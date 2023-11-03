local todoCommentsSetup, todoComments = pcall(require, "todo-comments")
if not todoCommentsSetup then
	return
end

todoComments.setup({})
