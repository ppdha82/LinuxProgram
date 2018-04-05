import sys

debug_mode = 0

def make_1555rgb(red, green, blue):
    if debug_mode == 1:
        result = (red << 10 | green << 5 | blue) & 0x7fff
        print("result = ", hex(result))
        return result
    else:
        return ((red << 10 | green << 5 | blue) & 0x7fff)

def export_red(value):
    value = (value >> 11) & 0x1f
    return value

def export_green(value):
    value = (value >> 6) & 0x1f
    return value

def export_blue(value):
    return (value & 0x1f)

def convertStrToHex(src_string, index):
    if debug_mode == 1:
        str_value = src_string[index:index+4]
        print("origin ", str_value)
        return int(str_value, 16)
    else:
        return int(src_string[index:index+4], 16)


def convert565To1555(src_value):
    red = export_red(src_value)
    green = export_green(src_value)
    blue = export_blue(src_value)
    if debug_mode == 1:
        print("red", hex(red))
        print("green", hex(green))
        print("blue", hex(blue))
        hvalue = make_1555rgb(red, green, blue)
        print("hvalue", hex(hvalue))
        return hvalue
    else:
        return make_1555rgb(red, green, blue)

src_file = "main_menu_test.c"
des_file = "target_test.c"

f = open(src_file, 'r')
t = open(des_file, 'w+')

lines = f.readlines();
for line in lines:
    str_count = len(line)
    if "0x" in line:
        str_for_line = line
        buf = line
        result_idx = 0
        str_offset = 0
        while buf.find("0x") != -1:
            result_idx = buf.find("0x") + 2
            str_offset += result_idx
            if str_offset < str_count + 2:
                hvalue = convertStrToHex(buf, result_idx)
                hvalue = convert565To1555(hvalue)
                str_output = str_for_line[0:str_offset - 2] + "0x%04x"%hvalue + str_for_line[str_offset + 4:]
                str_for_line = str_output
                if debug_mode == 1:
                    print("str_output", str_output)
            buf = buf[result_idx + 4:]
            str_offset += 4
            if debug_mode == 1:
                print ("buf", buf)
                print(" ")
                print(" ")
                print(" ")
        t.write(str_output)
    else:
        t.write(line)

f.close()
