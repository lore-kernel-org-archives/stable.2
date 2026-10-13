Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373F5013DF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904365; cv=none; b=PbGP3k0SnveGHjWXA/VMF+VEXFNXsCNZ6Jge283sKYgq6uPOban1keIyxERVLiqzWZt9zUP5mxG8VUJ5Ex0nXvBYhWskWBFLMTumuL6ahMHs6jUF7ZkcX+SkNOdXO2S5Nb5d0fIDXH+5tyA5GyQmjNgxHj3CMLfoegjiFFubo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904365; c=relaxed/simple;
	bh=nuBj+q901zmPujYOkws67VpVp/yJqRSGKzqDkBlvAOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjyxghnCZVdcTy5RILorTVM4VhnX7SXUDiSHihF+8/jRYdbDuK0T2kmb4nh5J2PS1iKWOhdRiEArhOcroyNHafMRppe5qyEjD39CplmMwN9K7aOhgn5EaeYnjPreyUSXI+qNrEmIEiJ0lx2S/tU0tolNuvXKa80L4q3m7V3wStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS67xP9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS67xP9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740D41F000FF;
	Tue, 13 Oct 2026 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904364;
	bh=R09ye/NQjdLBaf/x3xpi8EhLO3RXE0hXsXECNKXJl0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AS67xP9IaM4NFPmm6w5l+9p3efA4FzErVHlbQtVtKz4YVVkOI0/WQjQa79NLRRgtY
	 pPk9j0t8aP7yunFeHJZ0V855sBBO5BmPzppNbv/yy71r6UP7uC4hqJFWUGmIJ3HJz/
	 7VXmPj/gDqIbxkjVqsZaY710adtdjrla9fBCPHIBqafN26WOGAHHI7j4TJ/R5pGa0d
	 QfylpQDFMb9VfGEHyx24vEqgbq3vInQhN4ueGoDf9az/sGNJ6plNFksx5fmT9NIyOS
	 S9nsGFQ+NtFHc9/ktHN/14b7uHW0ASsCFprZkUBye0FylVk/EbqLK1vLbrRrW6/jbE
	 VXSbbKjxqWwuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei-Jie Hung <imbigking12@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] riscv: patch: fix handling of bpf-jit execmem addresses
Date: Tue, 13 Oct 2026 11:12:41 -0400
Message-ID: <20261013151210.110227-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013151210.110227-1-sashal@kernel.org>
References: <2026101208-patio-blinking-92df@gregkh>
 <20261013151210.110227-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei-Jie Hung <imbigking12@gmail.com>

[ Upstream commit a510e1ae8c9030750c2edf7b0bc9b186cd8c7a06 ]

Commit 8718e5a3090b ("riscv: patch: skip fixmap mapping when kernel text
is already writable") gated the core_kernel_text() branch of patch_map()
on CONFIG_STRICT_KERNEL_RWX, and explicitly left the vmalloc branch
unchanged. That branch has a separate problem.

That branch only creates a temporary writable fixmap alias when
CONFIG_STRICT_MODULE_RWX is enabled, and otherwise assumes the target is
directly writable and returns the address unchanged. That assumption no
longer holds: bpf_prog_pack_alloc calls set_memory_rox() on every pack
unconditionally in alloc_new_pack(), independently of any
CONFIG_STRICT_*_RWX option, so BPF text in the vmalloc area is read-only
regardless of what CONFIG_STRICT_MODULE_RWX says.

With CONFIG_STRICT_MODULE_RWX=n, patch_map() returns the read-only
address directly, the subsequent copy_to_kernel_nofault() takes a
page fault and returns -EFAULT. bpf_arch_text_copy() turns that into
-EINVAL, which propagates through bpf_jit_binary_pack_finalize() to the
WARN_ON() in bpf_int_jit_compile() and leaves the program un-JITed.

Note that BPF cannot be fixed the way kprobes was in
commit bdc46e507b59 ("riscv: mm: make EXECMEM_KPROBES writable without
CONFIG_STRICT_MODULE_RWX"). EXECMEM_BPF is already PAGE_KERNEL, i.e.
writable at allocation time; the read-only mapping is established
afterwards by generic code in alloc_new_pack(), which arch code cannot
influence. The only place this can be handled is patch_map().

This is the same problem that was fixed on arm64 by commit b1480ed230ac
("arm64: patching: fix handling of execmem addresses"), and the fix is
the same: CONFIG_EXECMEM is what actually tracks whether the vmalloc
area can hold executable memory that needs a temporary alias to be
written. CONFIG_BPF_JIT, CONFIG_KPROBES and CONFIG_MODULES all select
it.

Note that this is not limited to CONFIG_MODULES=n. Unlike arm64, riscv
selects CONFIG_ARCH_OPTIONAL_KERNEL_RWX, so CONFIG_STRICT_MODULE_RWX can
be disabled with CONFIG_MODULES=y as well, and the bug is reachable in
that configuration too.

The !CONFIG_MMU build is unaffected: it has its own __patch_insn_set()
and __patch_insn_write() implementations and never calls patch_map().

Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
Signed-off-by: Wei-Jie Hung <imbigking12@gmail.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com>
Link: https://patch.msgid.link/20260914115607.350097-1-imbigking12@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 16b243376f362..1e8f1ac5a755f 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -46,7 +46,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 
 	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr)) {
 		phys = __pa_symbol(addr);
-	} else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX)) {
+	} else if (IS_ENABLED(CONFIG_EXECMEM)) {
 		struct page *page = vmalloc_to_page(addr);
 
 		BUG_ON(!page);
-- 
2.53.0

