Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA45349C9
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904759; cv=none; b=BqyUiGaj5gB2S/qS3N1VWYq/WND8+vVmu+HcfDjNtEToVZer+jEfQwnVImzVjE5AbxesXiqWEHp/Zv2nmtZsObUkX7eNHmpJ7ZS32raq5r6BI/TSpTtN8blo/ou8xC9I26WDyhnlzguFFOnMfcFH1QxsuqdQpbpNSFZd2hkD0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904759; c=relaxed/simple;
	bh=ggWbtHPYSAiZT9lKoZwNuhTB6eGmevstPnx9G1HxWN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzRayEHLY2z0lHyRjiW/8QOmcQU/nb6u022aFuMVZLSbXIKQ05v1J6dfd5VabPlXaE4Uh+XD72BvQY7Qt8teY0D15tPnc9XOb2CmJ3kP8dZi1ehxs2GU9LQHxixC6q8wydRwpYpPb5ArMjtrhaOZlQTbapCW7Tydusgtx6L7xow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIzOPY3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIzOPY3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8811F00898;
	Tue, 13 Oct 2026 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904757;
	bh=aDTRaLqLD+54pmyctK5IC0LC1Gtcp/4spbMay+hp59Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iIzOPY3h2/9EVCaPga7ziqYWryTWdNZtvDODl5CghRxtaSCOz/bCRQ64tW6ieJkLz
	 Fs33l/+maSbXd2wf1sm+KwDFgAu+ALB6gMOyC7QiSvwWvRkBmV/+5GyVCPTRTm5GG5
	 AD0LZDJVc0vqN4uazbmY/wb789sgkS5BIE2y9wyhYqloR7PymUm+h93AkG/WEjxQVm
	 GU17ae8kaMJJ9JusO8tq9gtaRE2z90tEv3Fcl+GxC+xPSHhJfwR36NOsDO2iWEylBa
	 C3nCUaibMqyYpXQ/KJEYqdh4jYV8ur3M+VEx6lohfAx4Q6F0B8nyYNbmVfDPlP1Dop
	 WRbRlSHn7vHdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei-Jie Hung <imbigking12@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] riscv: patch: fix handling of bpf-jit execmem addresses
Date: Tue, 13 Oct 2026 11:19:15 -0400
Message-ID: <20261013151849.209222-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013151849.209222-1-sashal@kernel.org>
References: <2026101215-envelope-tribute-9992@gregkh>
 <20261013151849.209222-1-sashal@kernel.org>
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
index f8826f1595e16..9c9282f8a3a50 100644
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

