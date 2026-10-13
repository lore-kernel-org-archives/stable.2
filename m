Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A095349CF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904758; cv=none; b=dpWxKB00zc4nBgbeRuh0cn8d8nmBVt+dH0fZIyfzeZc9YYWqiINJyUkbD502kCIFynkfGI39J5n25JyWd2IM7uXrG9883uGPixBzcBgIRHoA2tR96CaIHyoM1kIww5HzcsHrpINxRLpQQTUsFzUH93OxE6MavZhPtP0zs8L2aR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904758; c=relaxed/simple;
	bh=abW6/LyScLshdC4NFqjL+vqlw4MO7+nGRCvQS+ZX6Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDbNpbK7vIr3jCBP/5WRALdnuUyePsxv32v1gpc8xDV8Emghf4BMAAQWS8GRnplwajZif0Db/Y9iHDbTNwoAITgFGqPKOHf1YpxLsKDAcfUJcJe8j/V34Zu0SYwhGEUwtROt7I1MujRPxnhDt6wE/1MM8Tz3wuPnyprOnxOiWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlRgwt2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlRgwt2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642AE1F000FF;
	Tue, 13 Oct 2026 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904757;
	bh=fF7JX8SvSE9wUq6nu+FocmYyH2tY2vc1WhmpNphfnNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DlRgwt2tNXbPcMOFRIbiYVAuvwm9GXPZ76/OA1HddvjovmGvlRbM1rE9fLJDj/YGc
	 c0TCAZEMJeEawIyebvNfoPZCF1dxG1uTpz0Im7Msn41fAVH350vNl5HCwz5U25pJwG
	 NjHVqSKaTjX1C1wRnavSUNr61W9uy9fGl+tPHcSr9NtplHPengiWFZOmRKAabeYbS7
	 wZ0jvAyZt0KkdfgojPaejEYBfILLzKX6iBdFjDDsWtXCB/wgRz3sKOiol5zho9z0Pk
	 rOvADFah9PGRdiADzl+XU9PwH2MxuXHM4aKiaM4yHITG1OD3KvvZecxDNN3LHouu+s
	 abfsekwlerRnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vivian Wang <wangruikang@iscas.ac.cn>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] riscv: patch: Avoid early phys_to_page()
Date: Tue, 13 Oct 2026 11:19:14 -0400
Message-ID: <20261013151849.209222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101215-envelope-tribute-9992@gregkh>
References: <2026101215-envelope-tribute-9992@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vivian Wang <wangruikang@iscas.ac.cn>

[ Upstream commit 6b60a128c2f43180664a614830f3c529497e0394 ]

Similarly to commit 8d09e2d569f6 ("arm64: patching: avoid early
page_to_phys()"), avoid using phys_to_page() for the kernel address case
in patch_map().

Since this is called from apply_boot_alternatives() in setup_arch(), and
commit 4267739cabb8 ("arch, mm: consolidate initialization of SPARSE
memory model") has moved sparse_init() to after setup_arch(),
phys_to_page() is not available there yet, and it panics on boot with
SPARSEMEM on RV32, which does not use SPARSEMEM_VMEMMAP.

Reported-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Closes: https://lore.kernel.org/r/20260223144108-dcace0b9-02e8-4b67-a7ce-f263bed36f26@linutronix.de/
Fixes: 4267739cabb8 ("arch, mm: consolidate initialization of SPARSE memory model")
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Link: https://patch.msgid.link/20260310-riscv-sparsemem-alternatives-fix-v1-1-659d5dd257e2@iscas.ac.cn
[pjw@kernel.org: fix the subject line to align with the patch description]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Stable-dep-of: a510e1ae8c90 ("riscv: patch: fix handling of bpf-jit execmem addresses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/patch.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 34ef522f07a8c..f8826f1595e16 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -42,19 +42,20 @@ static inline bool is_kernel_exittext(uintptr_t addr)
 static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 {
 	uintptr_t uintaddr = (uintptr_t) addr;
-	struct page *page;
+	phys_addr_t phys;
 
-	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr))
-		page = phys_to_page(__pa_symbol(addr));
-	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		page = vmalloc_to_page(addr);
-	else
-		return addr;
+	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr)) {
+		phys = __pa_symbol(addr);
+	} else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX)) {
+		struct page *page = vmalloc_to_page(addr);
 
-	BUG_ON(!page);
+		BUG_ON(!page);
+		phys = page_to_phys(page) + offset_in_page(addr);
+	} else {
+		return addr;
+	}
 
-	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
-					 offset_in_page(addr));
+	return (void *)set_fixmap_offset(fixmap, phys);
 }
 
 static void patch_unmap(int fixmap)
-- 
2.53.0

