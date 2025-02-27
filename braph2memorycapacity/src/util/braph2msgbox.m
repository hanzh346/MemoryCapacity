function f_out = braph2msgbox(title, message, varargin)
%BRAPH2MSGBOX opens a modal message box.
%
% BRAPH2MSGBOX(TITLE, MESSAGE) opens a modal message box with TITLE and
%  MESSAGE. 
%
% BRAPH2MSGBOX(TITLE, MESSAGE, 'PropertyName', PROPERTY, ...) accept any
%  uifigure property.
%
% F = BRAPH2MSGBOX(TITLE, MESSAGE) returns a handle to the uifigure of the
%  message box.
%
% See also uifigure.

f = uifigure( ...
    'Tag', 'f', ...
    'Visible', 'off', ...
    'WindowStyle', 'modal', ...
    'Resize', 'off', ...
    'Icon', 'braph2icon_64px.png', ...
    'Name', title, ...
    'Color', BRAPH2.COL_BKG, ...
    'Units', 'pixels', ...
    'Position', [(w(0)-s(48))/2 (h(0)-s(30))/2 s(48) s(30)], ...
    varargin{:} ...
    );

icon = rgb2gray(imread('braph2icon.png'));
h_axes = uiaxes( ...
    'Parent', f,  ...
    'Tag', 'h_axes', ...
    'Visible', 'off', ...
    'InnerPosition', [s(1) s(13) s(16) s(16)], ...
    'XLim', [0 size(icon, 1)], ...
    'YLim', [0 size(icon, 2)], ...
    'YDir', 'reverse', ...
    'Colormap', [BRAPH2.COL_BKG; repmat(BRAPH2.COL, 254, 1); 1 1 1] ...
    );
h_image = image( ...
    'Parent', h_axes, ...
    'Tag', 'h_image', ...
    'CData', icon ...
    ); %#ok<NASGU>
h_axes.Toolbar.Visible = 'off';
h_axes.Interactions = [];

h_text = text( ...
    'Parent', h_axes, ...
    'Tag', 'h_text', ...
    'String', message, ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [size(icon, 1) 0], ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top' ...
    ); %#ok<NASGU>

h_button = uibutton( ...
    'Parent', f, ...
    'Tag', 'h_button', ...
    'Text', 'OK', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [s(5) s(7) s(8), s(1.8)], ...
    'ButtonPushedFcn', {@cb_button}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_button(~, ~)
        close(f)
    end

drawnow()
set(f, 'Visible', 'on')

if nargout > 0
    f_out = f;
end

end
