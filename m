Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F934D4F9;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966229; cv=none; b=MNAuZJiv3NyoOW2bK0zBJZbknr3owRzG47ujNzsWAnU/wwCqZ2zf4x4OHqBMQIFXdfFnkVTpcofz8VE10plBgY0f8iTgOaJCepLboIO5UotMOwFP+XVrfc/sRINEDQyaHIus0GT90Kd+s7/p6mE/NhUfND0yJsqRQA3o8f+ywk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966229; c=relaxed/simple;
	bh=CEzJP8iXiE81KaVA8s3E4s9qC3Tqhw4yjd9MVLZenc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbspkKjLEa3MaehrrIiOPX8MaDsFpORi8PNeuj8DTdzemn+WZFoM2n8Ze2KhUgPWqRDJf6/rUtbM44dytX7FUTSCpqpwk3nycRGg961c/MZXjy8weVV6zlwbWykXgxSC3xaJFJadLoOIm3KWFJx1Ss9qu/j6Fc0mCgGGt42tGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYQfDQye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYQfDQye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FDA1F00A3D;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966228;
	bh=O75oVI8HOnhEwJFlZoZQsUnH7nY5IlDX63zUhNhf9S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYQfDQyeMHI0+PkgbJj9rhLbZXj/XW1EhFLhlczvQ/kuY1JE/4/AXBGfI5oFMNJOr
	 wt/K46o2/poZoxRxZhOJjo++URh6j9dF4+J+h5LPDmmwALZdEBP203MHYjkSj6q33+
	 Icaa5JPERAlzjTMscZ9OwF8+LbzM/kGw4SFE+XlzpP3vuWt4NP0imsXyETO+WFzERj
	 HaxhYJ2GxQTtmurc19zPvt1pscGST8J2+hv3yNUHCiMvVzi2TGYdtGYomj1oS4xqCY
	 lLCPj5PjzmcmQPZxfESUEivFA0of3DkoRuP4nk+RhFHqIXOzi988Vp2iUvamsIEHBL
	 MsvqDHciAc78g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
Date: Mon, 13 Jul 2026 18:10:17 +0000
Message-ID: <20260713181020.2735367-3-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260713181020.2735367-1-yosry@kernel.org>
References: <20260713181020.2735367-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported. KVM does check long-mode support before allowing
the bits for guest writes and userspace writes through KVM_SET_SREGS*
(in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
check reserved bits.

In practice, this doesn't really matter. The true motiviation is getting
rid of the #ifdeffery when initializing efer_reserved_bits.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 +---------
 arch/x86/kvm/x86.c  |  3 +++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e38..67481429ad6b8 100644
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
index ca01a2f2ec466..f68424a985cda 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6913,6 +6913,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	if (kvm_cpu_cap_has(X86_FEATURE_LM))
+		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+
 	if (kvm_cpu_cap_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 
-- 
2.55.0.141.g00534a21ce-goog

