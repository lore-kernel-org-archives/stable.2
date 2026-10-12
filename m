Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F5392C29
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818651; cv=none; b=qYClEfsuSmrfcirS3EnHq4eXx6U2MXh2y4/z4gLauh5q8GxWtD1cKufcy96AZQLinj8lulJ0T3Szh+YhRxgY+Lt41zxbGHXry60eg3X9j0CaweDrHKlZO1VqxZPdzMQgmSUqJUuRxFiM89ZyZ++VLtM1y4LADx/upj9PB1Z6CLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818651; c=relaxed/simple;
	bh=xxf/rqSU+vp+paTeTHDxcyJC1oyBGzcrQ2SJVt9Pino=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tQbo2R8rvz1OefKUcDNIsHi51N5OyedYLBE4cqsizELCrc+KVvWvvHeMHMYIUAO4R5AmQ2Uh8EQWKs/2RvwhZiL6i1wsieKzRZ7VY+ZG+57NGN4GNrxlTEj7ZrS+mVSF9iODwaXCaXnGNtm8bOtXy57+guVKIUjqk2ZBxsxkfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/xRUsGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/xRUsGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F271F0089B;
	Mon, 12 Oct 2026 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818650;
	bh=dLSxaeYIBDmt+uFLJEoXIXufBH3hklVgI0V3pagQXss=;
	h=Subject:To:Cc:From:Date;
	b=1/xRUsGvSD6OWUU9H0DZhJKV9a2gzFRzQ3naXr1NC/c3lLGFrqTVrLDryky/ujyvC
	 SFAYF8AO6RyiUZFn1FUEpOdLWRMUDq/YmYylhJQQG+8htV+IQRq3SsZHtEoaujFXyd
	 agdSaPOX3Eiz4QbQbao3qJWTcAzMREUB+5+gHsUw=
Subject: FAILED: patch "[PATCH] riscv: patch: fix handling of bpf-jit execmem addresses" failed to apply to 6.12-stable tree
To: imbigking12@gmail.com,pjw@kernel.org,pulehui@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:24:15 +0200
Message-ID: <2026101215-envelope-tribute-9992@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a510e1ae8c9030750c2edf7b0bc9b186cd8c7a06
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101215-envelope-tribute-9992@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a510e1ae8c9030750c2edf7b0bc9b186cd8c7a06 Mon Sep 17 00:00:00 2001
From: Wei-Jie Hung <imbigking12@gmail.com>
Date: Mon, 5 Oct 2026 19:02:38 -0600
Subject: [PATCH] riscv: patch: fix handling of bpf-jit execmem addresses

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

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 2239c28981bc..2b5adf01c550 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -48,7 +48,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 		if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
 			return addr;
 		phys = __pa_symbol(addr);
-	} else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX)) {
+	} else if (IS_ENABLED(CONFIG_EXECMEM)) {
 		struct page *page = vmalloc_to_page(addr);
 
 		BUG_ON(!page);

