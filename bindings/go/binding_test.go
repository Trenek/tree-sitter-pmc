package tree_sitter_pmc_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_pmc "github.com/trenek/tree-sitter-pmc/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_pmc.Language())
	if language == nil {
		t.Errorf("Error loading Przykladowa Maszyna Cyfrowa grammar")
	}
}
