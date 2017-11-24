" Vim syntax file
" Language:	C++
" Author: Dieter Hartmann
" License: GPL
"
" $Id: cpp.vim,v 1.2 2003/04/04 14:28:01 dihar Exp $
"
" -- Qt classes
"
"
syn keyword qClass QAccel QDict QIconFactory QPicture QSyntaxHighlighter
syn keyword qClass QAccessible QDictIterator QIconSet QPixmap Qt
syn keyword qClass QAccessibleInterface QDir QIconView QPixmapCache QTab
syn keyword qClass QAccessibleObject QDirectPainter QIconViewItem QPlatinumStyle QTabBar
syn keyword qClass QAction QDns QImage QPNGImagePacker QTabDialog
syn keyword qClass QActionGroup QDockArea QImageConsumer QPoint QTable
syn keyword qClass QApplication QDockWindow QImageDecoder QPointArray QTableItem
syn keyword qClass QAquaStyle QDomAttr QImageDrag QPopupMenu QTableSelection
syn keyword qClass QAsciiCache QDomCDATASection QImageFormat QPrinter QTabletEvent
syn keyword qClass QAsciiCacheIterator QDomCharacterData QImageFormatPlugin QProcess QTabWidget
syn keyword qClass QAsciiDict QDomComment QImageFormatType QProgressBar QTextBrowser
syn keyword qClass QAsciiDictIterator QDomDocument QImageIO QProgressDialog QTextCodec
syn keyword qClass QAssistantClient QDomDocumentFragment QIMEvent QPtrCollection QTextCodecPlugin
syn keyword qClass QAxAggregated  QDomDocumentType QInputDialog QPtrDict QTextDecoder
syn keyword qClass QAxBase  QDomElement QIntCache QPtrDictIterator QTextDrag
syn keyword qClass QAxBindable  QDomEntity QIntCacheIterator QPtrList QTextEdit
syn keyword qClass QAxFactory  QDomEntityReference QIntDict QPtrListIterator QTextEncoder
syn keyword qClass QAxObject  QDomImplementation QIntDictIterator QPtrQueue QTextIStream
syn keyword qClass QAxWidget  QDomNamedNodeMap QIntValidator QPtrStack QTextOStream
syn keyword qClass QBig5Codec QDomNode QIODevice QPtrVector QTextStream
syn keyword qClass QBig5hkscsCodec QDomNodeList QJisCodec QPushButton QThread
syn keyword qClass QBitArray QDomNotation QKbdDriverFactory QRadioButton QTime
syn keyword qClass QBitmap QDomProcessingInstruction QKbdDriverPlugin QRangeControl QTimeEdit
syn keyword qClass QBitVal QDomText QKeyEvent QRect QTimer
syn keyword qClass QBoxLayout QDoubleValidator QKeySequence QRegExp QTimerEvent
syn keyword qClass QBrush QDragEnterEvent QLabel QRegExpValidator QToolBar
syn keyword qClass QBuffer QDragLeaveEvent QLayout QRegion QToolButton
syn keyword qClass QButton QDragMoveEvent QLayoutItem QResizeEvent QToolTip
syn keyword qClass QButtonGroup QDragObject QLayoutIterator QScreen QToolTipGroup
syn keyword qClass QByteArray QDropEvent QLCDNumber QScrollBar QTranslator
syn keyword qClass QCache QEditorFactory QLibrary QScrollView QTranslatorMessage
syn keyword qClass QCacheIterator QErrorMessage QLineEdit QSemaphore QTsciiCodec
syn keyword qClass QCanvas QEucJpCodec QListBox QServerSocket QUriDrag
syn keyword qClass QCanvasEllipse QEucKrCodec QListBoxItem QSessionManager QUrl
syn keyword qClass QCanvasItem QEvent QListBoxPixmap QSettings QUrlInfo
syn keyword qClass QCanvasItemList QEventLoop QListBoxText QSGIStyle QUrlOperator
syn keyword qClass QCanvasLine QFile QListView QShowEvent QValidator
syn keyword qClass QCanvasPixmap QFileDialog QListViewItem QSignal QValueList
syn keyword qClass QCanvasPixmapArray QFileIconProvider QListViewItemIterator QSignalMapper QValueListConstIterator
syn keyword qClass QCanvasPolygon QFileInfo QLocalFs QSimpleRichText QValueListIterator
syn keyword qClass QCanvasPolygonalItem QFilePreview QMacStyle QSize QValueStack
syn keyword qClass QCanvasRectangle QFocusData QMainWindow QSizeGrip QValueVector
syn keyword qClass QCanvasSpline QFocusEvent QMap QSizePolicy QVariant
syn keyword qClass QCanvasSprite QFont QMapConstIterator QSjisCodec QVBox
syn keyword qClass QCanvasText QFontDatabase QMapIterator QSlider QVBoxLayout
syn keyword qClass QCanvasView QFontDialog QMemArray QSocket QVButtonGroup
syn keyword qClass QCDEStyle QFontInfo QMenuBar QSocketDevice QVGroupBox
syn keyword qClass QChar QFontManager QMenuData QSocketNotifier QWaitCondition
syn keyword qClass QCharRef QFontMetrics QMessageBox QSound QWhatsThis
syn keyword qClass QCheckBox QFrame QMetaObject QSpacerItem QWheelEvent
syn keyword qClass QCheckListItem QFtp QMetaProperty QSpinBox QWidget
syn keyword qClass QCheckTableItem QGb18030Codec QMimeSource QSplitter QWidgetFactory
syn keyword qClass QChildEvent QGb2312Codec QMimeSourceFactory QSql QWidgetItem
syn keyword qClass QClipboard QGbkCodec QMotif  QSqlCursor QWidgetPlugin
syn keyword qClass QCloseEvent QGfxDriverFactory QMotifDialog  QSqlDatabase QWidgetStack
syn keyword qClass QColor QGfxDriverPlugin QMotifPlusStyle QSqlDriver QWindowsMime
syn keyword qClass QColorDialog QGL QMotifStyle QSqlDriverPlugin QWindowsStyle
syn keyword qClass QColorDrag QGLayoutIterator QMotifWidget  QSqlEditorFactory QWizard
syn keyword qClass QColorGroup QGLColormap QMouseDriverFactory QSqlError QWMatrix
syn keyword qClass QComboBox QGLContext QMouseDriverPlugin QSqlField QWorkspace
syn keyword qClass QComboTableItem QGLFormat QMouseEvent QSqlFieldInfo QWSDecoration
syn keyword qClass QCommonStyle QGLWidget QMoveEvent QSqlForm QWSInputMethod
syn keyword qClass QConstString QGrid QMovie QSqlIndex QWSKeyboardHandler
syn keyword qClass QContextMenuEvent QGridLayout QMutex QSqlPropertyMap QWSMouseHandler
syn keyword qClass QCopChannel QGridView QMutexLocker QSqlQuery QWSServer
syn keyword qClass QCString QGroupBox QNetworkOperation QSqlRecord QWSWindow
syn keyword qClass QCursor QGuardedPtr QNetworkProtocol QSqlRecordInfo QXmlAttributes
syn keyword qClass QCustomEvent QHBox QNPInstance  QSqlResult QXmlContentHandler
syn keyword qClass QCustomMenuItem QHBoxLayout QNPlugin  QStatusBar QXmlDeclHandler
syn keyword qClass QDataBrowser QHButtonGroup QNPStream  QStoredDrag QXmlDefaultHandler
syn keyword qClass QDataStream QHeader QNPWidget  QStrIList QXmlDTDHandler
syn keyword qClass QDataTable QHebrewCodec QObject QString QXmlEntityResolver
syn keyword qClass QDataView QHGroupBox QObjectCleanupHandler QStringList QXmlErrorHandler
syn keyword qClass QDate QHideEvent QObjectList QStrList QXmlInputSource
syn keyword qClass QDateEdit QHostAddress QPaintDevice QStrListIterator QXmlLexicalHandler
syn keyword qClass QDateTime QHttp QPaintDeviceMetrics QStyle QXmlLocator
syn keyword qClass QDateTimeEdit QHttpHeader QPainter QStyleFactory QXmlNamespaceSupport
syn keyword qClass QDeepCopy QHttpRequestHeader QPaintEvent QStyleOption QXmlParseException
syn keyword qClass QDesktopWidget QHttpResponseHeader QPair QStylePlugin QXmlReader
syn keyword qClass QDial QIconDrag QPalette QStyleSheet QXmlSimpleReader
syn keyword qClass QDialog QIconDragItem QPen QStyleSheetItem QXtWidget 

" --- Qt keywords
"
syn keyword     cType           SIGNAL SLOT

" --- Qt Macros
"
syn keyword     cType           Q_ASSERT Q_CHECK_PTR Q_OBJECT

" highlight Qt classes like bulid-in cpp types
highlight link qClass Type


" Vim syntax file
" Language:	C++ special highlighting for STL classes and methods
" Maintainer:	Nathan Skvirsky
" Last Change:	2006 Oct 22

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
  unlet b:current_syntax
endif

" C++ extentions

syn keyword cppSTL		abort abs accumulate acos adjacent_difference adjacent_find adjacent_find_if any append asctime asin assert assign at atan atan2 atexit atof atoi atol auto_ptr back back_inserter bad bad_alloc bad_cast bad_exception bad_typeid badbit beg begin binary_compose binary_negate binary_search bind2nd binder1st binder2nd bitset bsearch c_str calloc capacity ceil cerr cin clear clearerr clock clog close compare compose1 compose2 const_iterator construct copy copy_backward copy_n cos cosh count count_if cout ctime data deque destroy difference_type difftime div divides domain_error empty end endl eof eofbit equal equal_range erase exception exit exp fabs fail failbit failure fclose feof ferror fflush fgetc fgetpos fgets fill fill_n find find_end find_first_not_of find_first_of find_if find_last_not_of find_last_of first flags flip floor flush fmod fopen for_each fprintf fputc fputs fread free freopen frexp front fscanf fseek fsetpos fstream ftell fwrite gcount generate generate_n get get_temporary_buffer getc getchar getenv getline gets gmtime good goodbit greater greater_equal hash_map hash_multimap hash_multiset hash_set ifstream ignore in includes inner_product inplace_merge insert inserter invalid_argument ios ios_base iostate iota is_heap is_open is_sorted isalnum isalpha iscntrl isdigit isgraph islower isprint ispunct isspace istream istream_iterator istringstream isupper isxdigit iter_swap iterator iterator_category key_comp ldiv length length_error less less_equal lexicographical_compare lexicographical_compare_3way list localtime log log10 logic_error logical_and logical_not logical_or longjmp lower_bound make_heap malloc map max max_element max_size mem_fun mem_fun1 mem_fun1_ref mem_fun_ref memchr memcpy memmove memset merge min min_element minus mismatch mktime modf modulus multimap multiplies multiset negate next_permutation npos nth_element numeric_limits ofstream open ostream ostream_iterator ostringstream out_of_range overflow_error pair partial_sort partial_sort_copy partial_sum partition peek perror plus pointer pointer_to_binary_function pointer_to_unary_function pop pop_back pop_front pop_heap pow power precision prev_permutation printf ptr_fun push push_back push_front push_heap put putback putc putchar puts qsort raise rand random_sample random_sample_n random_shuffle range_error rbegin rdbuf rdstate read realloc reference remove remove_copy remove_copy_if remove_if rename rend replace replace_copy replace_copy_if replace_if reserve reset resize return_temporary_buffer reverse reverse_copy reverse_iterator rewind rfind rotate rotate_copy runtime_error scanf search search_n second seekg seekp set set_difference set_intersection set_symmetric_difference set_union setbuf setf setjmp setlocale setvbuf signal sin sinh size size_t size_type sort sort_heap splice sprintf sqrt srand sscanf stable_partition stable_sort std str strcat strchr strcmp strcoll strcpy strcspn strerror strftime string strlen strncat strncmp strncpy strpbrk strrchr strspn strstr strtod strtok strtol strtoul strxfrm substr swap swap_ranges sync_with_stdio system tan tanh tellg tellp temporary_buffer test time time_t tmpfile tmpnam to_string to_ulong tolower top toupper transform unary_compose unary_negate underflow_error unget ungetc uninitialized_copy uninitialized_copy_n uninitialized_fill uninitialized_fill_n unique unique_copy unsetf upper_bound va_arg value_comp value_type vector vfprintf vprintf vsprintf width write

syn keyword cppStatement	new delete this friend using
syn keyword cppAccess		public protected private
syn keyword cppType		inline virtual explicit export bool wchar_t
syn keyword cppExceptions	throw try catch
syn keyword cppOperator		operator typeid
syn keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn keyword cppStorageClass	mutable
syn keyword cppStructure	class typename template namespace
syn keyword cppNumber		NPOS
syn keyword cppBoolean		true false

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppAccess		cppStatement
  HiLink cppCast		cppStatement
  HiLink cppExceptions		Exception
  HiLink cppOperator		Operator
  HiLink cppStatement		Statement
  HiLink cppSTL			Identifier
  HiLink cppNCBI		Special
  HiLink cppType		Type
  HiLink cppStorageClass	StorageClass
  HiLink cppStructure		Structure
  HiLink cppNumber		Number
  HiLink cppBoolean		Boolean
  delcommand HiLink
endif

let b:current_syntax = "cpp"

" vim: ts=8

