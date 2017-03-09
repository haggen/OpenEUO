----------------------------------------
-- Constant Definitions ----------------
----------------------------------------
--
-- This file contains various constants.
--
----------------------------------------
--
-- table C
--
----------------------------------------  
----------------------------------------  
----------------------------------------  

local function H(s)
	return tonumber(s,16)
end

----------------------------------------

C = {
	--TControl.Cursor:
	crDefault                 = 0,
	crNone                    = -1,
	crArrow                   = -2,
	crCross                   = -3,
	crIBeam                   = -4,
	crSizeNESW                = -6,
	crSizeNS                  = -7,
	crSizeNWSE                = -8,
	crSizeWE                  = -9,
	crUpArrow                 = -10,
	crHourGlass               = -11,
	crDrag                    = -12,
	crNoDrop                  = -13,
	crHSplit                  = -14,
	crVSplit                  = -15,
	crMultiDrag               = -16,
	crSQLWait                 = -17,
	crNo                      = -18,
	crAppStart                = -19,
	crHelp                    = -20,
	crHandPoint               = -21,
	crSizeAll                 = -22,

	--TControl.Color:
	clBlack                   = H("00000000"),
	clMaroon                  = H("00000080"),
	clGreen                   = H("00008000"),
	clOlive                   = H("00008080"),
	clNavy                    = H("00800000"),
	clPurple                  = H("00800080"),
	clTeal                    = H("00808000"),
	clGray                    = H("00808080"),
	clSilver                  = H("00C0C0C0"),
	clRed                     = H("000000FF"),
	clLime                    = H("0000FF00"),
	clYellow                  = H("0000FFFF"),
	clBlue                    = H("00FF0000"),
	clFuchsia                 = H("00FF00FF"),
	clAqua                    = H("00FFFF00"),
	clWhite                   = H("00FFFFFF"),
	clMoneyGreen              = H("00C0DCC0"),
	clSkyBlue                 = H("00F0CAA6"),
	clCream                   = H("00F0FBFF"),
	clMedGray                 = H("00A4A0A0"),
	clNone                    = H("1FFFFFFF"),
	clDefault                 = H("20000000"),
	clActiveBorder            = H("FF00000A"),
	clActiveCaption           = H("FF000002"),
	clAppWorkSpace            = H("FF00000C"),
	clBackground              = H("FF000001"),
	clBtnFace                 = H("FF00000F"),
	clBtnHighlight            = H("FF000014"),
	clBtnShadow               = H("FF000010"),
	clBtnText                 = H("FF000012"),
	clCaptionText             = H("FF000009"),
	clGradientActiveCaption   = H("FF00001B"),
	clGradientInactiveCaption = H("FF00001C"),
	clGrayText                = H("FF000011"),
	clHighlight               = H("FF00000D"),
	clHighlightText           = H("FF00000E"),
	clHotLight                = H("FF00001A"),
	clInactiveBorder          = H("FF00000B"),
	clInactiveCaption         = H("FF000003"),
	clInactiveCaptionText     = H("FF000013"),
	clInfoBk                  = H("FF000018"),
	clInfoText                = H("FF000017"),
	clMenu                    = H("FF000004"),
	clMenuBar                 = H("FF00001E"),
	clMenuHighlight           = H("FF00001D"),
	clMenuText                = H("FF000007"),
	clScrollBar               = H("FF000000"),
	cl3DDkShadow              = H("FF000015"),
	cl3DLight                 = H("FF000016"),
	clWindow                  = H("FF000005"),
	clWindowFrame             = H("FF000006"),
	clWindowText              = H("FF000008"),

	--TControl.Anchors:
	akTop                     = 1,
	akLeft                    = 2,
	akRight                   = 4,
	akBottom                  = 8,

	--TControl.Align:
	alNone                    = 0,
	alTop                     = 1,
	alBottom                  = 2,
	alLeft                    = 3,
	alRight                   = 4,
	alClient                  = 5,

	--TCustomEdit/TPanel/TListBox/TSynMemo.BorderStyle:
	bsNone                    = 0,
	bsSingle                  = 1,

	--TCustomEdit/TPanel/TListBox/TComboBox.BevelInner/Outer:
	bvNone                    = 0,
	bvLowered                 = 1,
	bvRaised                  = 2,
	bvSpace                   = 3,

	--TCustomEdit/TListBox/TComboBox.BevelKind:
	bkNone                    = 0,
	bkTile                    = 1,
	bkSoft                    = 2,
	bkFlat                    = 3,

	--TCustomEdit/TListBox/TComboBox.BevelEdges:
	beLeft                    = 1,
	beTop                     = 2,
	beRight                   = 4,
	beBottom                  = 8,

	--TMemo/TSynMemo.ScrollBars:
	ssNone                    = 0,
	ssHorizontal              = 1,
	ssVertical                = 2,
	ssBoth                    = 3,

	--TForm.WindowState:
	wsNormal                  = 0,
	wsMinimized               = 1,
	wsMaximized               = 2,

	--TForm.Position:
	poDesigned                = 0,
	poDefault                 = 1,
	poScreenCenter            = 4,
	poDesktopCenter           = 5,
	poMainFormCenter          = 6,

	--TForm.FormStyle:
	fsNormal                  = 0,
	fsStayOnTop               = 3,

	--TForm.BorderStyle:
	bsNone                    = 0,
	bsSingle                  = 1,
	bsSizeable                = 2,
	bsDialog                  = 3,
	bsToolWindow              = 4,
	bsSizeToolWin             = 5,

	--TForm.BorderIcons:
	biSystemMenu              = 1,
	biMinimize                = 2,
	biMaximize                = 4,
	biHelp                    = 8,

	--TLabel.Layout:
	tlTop                     = 0,
	tlCenter                  = 1,
	tlBottom                  = 2,

	--TLabel.Alignment:
	taLeftJustify             = 0,
	taRightJustify            = 1,
	taCenter                  = 2,

	--TFont.Style:
	fsBold                    = 1,
	fsItalic                  = 2,
	fsUnderline               = 4,
	fsStrikeOut               = 8,

        --TCheckBox/TRadioButton.Alignment:
	taLeftJustify             = 0,
	taRightJustify            = 1,

	--TComboBox.Style:
	csDropDown                = 0,
	csSimple                  = 1,
	csDropDownList            = 2,

	--TMenuItem.ShortCut:
	scBkSp                    = 08,
	scTab                     = 09,
	scEnter                   = 13,
        scEsc                     = 27,
	scSpace                   = 32,
	scPgUp                    = 33,
	sccPgDn                   = 34,
	scEnd                     = 35,
	scHome                    = 36,
	scLeft                    = 37,
	scUp                      = 38,
	scRight                   = 39,
	scDown                    = 40,
	scIns                     = 45,
	scDel                     = 46,
	sc0                       = 48,
	sc1                       = 49,
	sc2                       = 50,
	sc3                       = 51,
	sc4                       = 52,
	sc5                       = 53,
	sc6                       = 54,
	sc7                       = 55,
	sc8                       = 56,
	sc9                       = 57,
	scA                       = 65,
	scB                       = 66,
	scC                       = 67,
	scD                       = 68,
	scE                       = 69,
	scF                       = 70,
	scG                       = 71,
	scH                       = 72,
	scI                       = 73,
	scJ                       = 74,
	scK                       = 75,
	scL                       = 76,
	scM                       = 77,
	scN                       = 78,
	scO                       = 79,
	scP                       = 80,
	scQ                       = 81,
	scR                       = 82,
	scS                       = 83,
	scT                       = 84,
	scU                       = 85,
	scV                       = 86,
	scW                       = 87,
	scX                       = 88,
	scY                       = 89,
	scZ                       = 90,
	scF1                      = 112,
	scF2                      = 113,
	scF3                      = 114,
	scF4                      = 115,
	scF5                      = 116,
	scF6                      = 117,
	scF7                      = 118,
	scF8                      = 119,
	scF9                      = 120,
	scF10                     = 121,
	scF11                     = 122,
	scF12                     = 123,
        scShift                   = H(2000),
        scCtrl                    = H(4000),
        scAlt                     = H(8000),

	--TMenuItem.Break:
	mbNone                    = 0,
	mbBreak                   = 1,
	mbBarBreak                = 2,

	--TScrollBar.Kind:
	sbHorizontal              = 0,
	sbVertical                = 1,

	--TBevel.Style:
	bsLowered                 = 0,
	bsRaised                  = 1,

	--TBevel.Shape:
	bsBox                     = 0,
	bsFrame                   = 1,
	bsTopLine                 = 2,
	bsBottomLine              = 3,
	bsLeftLine                = 4,
	bsRightLine               = 5,
	bsSpacer                  = 6,

	--TSplitter.ResizeStyle:
	rsNone                    = 0,
	rsLine                    = 1,
	rsUpdate                  = 2,
	rsPattern                 = 3,

	--TBrush.Style:
	bsSolid                   = 0,
	bsClear                   = 1,
	bsHorizontal              = 2,
	bsVertical                = 3,
	bsFDiagonal               = 4,
	bsBDiagonal               = 5,
	bsCross                   = 6,
	bsDiagCross               = 7,

	--TPen.Style:
	psSolid                   = 0,
	psDash                    = 1,
	psDot                     = 2,
	psDashDot                 = 3,
	psDashDotDot              = 4,
	psClear                   = 5,
	psInsideFrame             = 6,

	--TOpenDialog/TSaveDialog.Options:
	ofReadOnly                = H("00000001"),
	ofOverwritePrompt         = H("00000002"),
	ofHideReadOnly            = H("00000004"),
	ofNoChangeDir             = H("00000008"),
	ofShowHelp                = H("00000010"),
	ofNoValidate              = H("00000020"),
	ofAllowMultiSelect        = H("00000040"),
	ofExtensionDifferent      = H("00000080"),
	ofPathMustExist           = H("00000100"),
	ofFileMustExist           = H("00000200"),
	ofCreatePrompt            = H("00000400"),
	ofShareAware              = H("00000800"),
	ofNoReadOnlyReturn        = H("00001000"),
	ofNoTestFileCreate        = H("00002000"),
	ofNoNetworkButton         = H("00004000"),
	ofNoLongNames             = H("00008000"),
	ofOldStyleDialog          = H("00010000"),
	ofNoDereferenceLinks      = H("00020000"),
	ofEnableIncludeNotify     = H("00040000"),
	ofEnableSizing            = H("00080000"),
	ofDontAddToRecent         = H("00100000"),
	ofForceShowHidden         = H("00200000"),

	--TTabControl.TabPosition:
	tpTop                     = 0,
	tpBottom                  = 1,
	tpLeft                    = 2,
	tpRight                   = 3,

	--TTabControl.Style:
	tsTabs                    = 0,
	tsButtons                 = 1,
	tsFlatButtons             = 2,

	--TSynMemo.Options:
	eoAltSetsColumnMode       = H(00000001),
	eoAutoIndent              = H(00000002),
	eoAutoSizeMaxScrollWidth  = H(00000004),
	eoDisableScrollArrows     = H(00000008),
	eoDragDropEditing         = H(00000010),
	eoDropFiles               = H(00000020),
	eoEnhanceHomeKey          = H(00000040),
	eoGroupUndo               = H(00000080),
	eoHalfPageScroll          = H(00000100),
	eoHideShowScrollbars      = H(00000200),
	eoKeepCaretX              = H(00000400),
	eoNoCaret                 = H(00000800),
	eoNoSelection             = H(00001000),
	eoRightMouseMovesCursor   = H(00002000),
	eoScrollByOneLess         = H(00004000),
	eoScrollHintFollows       = H(00008000),
	eoScrollPastEof           = H(00010000),
	eoScrollPastEol           = H(00020000),
	eoShowScrollHint          = H(00040000),
	eoShowSpecialChars        = H(00080000),
	eoSmartTabDelete          = H(00100000),
	eoSmartTabs               = H(00200000),
	eoSpecialLineDefaultFg    = H(00400000),
	eoTabIndent               = H(00800000),
	eoTabsToSpaces            = H(01000000),
	eoTrimTrailingSpaces      = H(02000000),

	--TToolBar.EdgeBorders:
	ebLeft                    = 0,
	ebTop                     = 1,
	ebRight                   = 2,
        ebBottom                  = 3,

	--TToolBar.EdgeInner/EdgeOuter:
	esNone                    = 0,
        esRaised                  = 1,
        esLowered                 = 2,

	--TToolButton.Style:
	tbsButton                 = 0,
        tbsCheck                  = 1,
        tbsDropDown               = 2,
        tbsSeparator              = 3,
        tbsDivider                = 4,

	--TMssageBox:
	mbOk                      = 0,
	mbOkCancel                = 1,
	mbAbortRetryIgnore        = 2,
	mbYesNoCancel             = 3,
	mbYesNo                   = 4,
	mbRetryCancel             = 5,
	mbCancelTryContinue       = 6,
	mbIconNone                = 0,
	mbIconStop                = 1,
	mbIconQuestion            = 2,
	mbIconExclamation         = 3,
	mbIconInformation         = 4,
	mbDefButton1              = 0,
	mbDefButton2              = 1,
	mbDefButton3              = 2,
	mbIdOk                    = 1,
	mbIdCancel                = 2,
	mbIdAbort                 = 3,
	mbIdRetry                 = 4,
	mbIdIgnore                = 5,
	mbIdYes                   = 6,
	mbIdNo                    = 7,
	mbIdTryAgain              = 10,
	mbIdContinue              = 11,
}