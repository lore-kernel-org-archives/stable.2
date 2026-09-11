Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4133E2ADB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123296; cv=none; b=eI6/nUYpQFn/Cpgl9p6fsQnngYVVilWeqlebFj+qklEOj210Xz496qxyl2YRvdJ0yiWu5Ano8Cgf5d2eCsQjNPD9CIDNyzbLNMTmyBQCnSu+RAecYyCIOpNz2HDhuLYK0uygAn9+d1hH4/gu0c8SYm5R7ccipUSMaepqGQFIB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123296; c=relaxed/simple;
	bh=Ljr/NfNDoZI/5OUDm217JDi000fj6BuaUIEq31TytGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXzg2r8mdeBAAT5PLr8YxiJU393MzYPxb5E5JhFGRTdl6cqpzEdfp8VZUiTdR/iAtOXFWkh0EKh6I2gfzOGKSpMtWD0kgyjNk2lOj2MjDGOoUabUkGKFV4/kwuebQVA/mPIsfJW9D4NAeApywJMEHZw8lnTn2lChdDxJai8k+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHAe0uCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHAe0uCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408991F00893;
	Fri, 11 Sep 2026 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123294;
	bh=VSPeB8+9p5egJkf2hd0bL8pbAet8l6phX4af2t0A1TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHAe0uCly3uueB88hqhenBr+jgEO4ivfLJFBoipglQnSqnocrVF68TVAuTglO+hiR
	 LNT6ljNGDRPZo4rW92Om7qDQVUlqH7OqVqtWilT4wYX9ZZLfllDT5jDhvCv4XleCFo
	 NWEkU9VQOPN2GFmbCz205Gc8L03if58Xm3eBeeug6qF86fFrxYS7wks2xJb+iY0/zh
	 4IMeyMruX4wZFOZbalh+ucWZv2Hpxf2NafxLWM1thQ26lyloHw4FKREvGTvIZrtu0D
	 JFExVIvPOrvm13RtH3xLNqcpHAERF6UUzxEMKmBaHtN5LM0Kg16sC1+3tTibNQLA3H
	 kdIsW4OHzDZwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 9/9] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
Date: Fri, 11 Sep 2026 06:41:23 -0400
Message-ID: <20260911104123.189614-9-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104123.189614-1-sashal@kernel.org>
References: <2026090914-waviness-supermom-9b84@gregkh>
 <20260911104123.189614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry@kernel.org>

[ Upstream commit e62392bf39ebfdf60d1d082799397fe1cbf8dfc5 ]

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported. KVM does check long-mode support before allowing
the bits for guest writes and userspace writes through KVM_SET_SREGS*
(in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
check reserved bits.

In practice, this doesn't really matter. The true motiviation is getting
rid of the #ifdeffery when initializing efer_reserved_bits.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713181020.2735367-3-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 +---------
 arch/x86/kvm/x86.c  |  3 +++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 07f2a22d2607d..19981ac780eed 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,16 +19,8 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-/* EFER defaults:
- * - enable syscall per default because its emulated by KVM
- * - enable LME and LMA per default on 64 bit KVM
- */
-#ifdef CONFIG_X86_64
-static
-u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
-#else
+/* Enable syscall by default because its emulated by KVM */
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
 
 #define MAX_IO_MSRS 256
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a0e74a4e40d06..3b29427526785 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7328,6 +7328,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	if (kvm_cpu_cap_has(X86_FEATURE_LM))
+		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+
 	if (kvm_cpu_cap_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 
-- 
2.53.0

