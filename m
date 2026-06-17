Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5639022E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693474; cv=none; b=El7/tasmUDtPljBMp/nktaQ0q5Bb/ETKvC1zI7oc2mEOG2/qFLw5W3lZu7kyBZORMhLmd6mFFvJXaxyJpQpuFk/Hy4BE1dqBI8+M7GMQ9YqWpIaiVboSOpWjBvl8+Sr0oQUWGrNiyZ9DBYFy9g30ogqHKfO53A5kynnUeiK5xDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693474; c=relaxed/simple;
	bh=7qzujJgvvJFOSb/Q4ZosXOpZymWjz6Bg0x9iMNs/xuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwtHypQB5rt6idR3k+9FWFbzbgczvxLkHiyjoVsLPUllEaJcAXzPJUmYAinsA+Ua3gNV1oejuthQKX+0/OU/P+3qBX/U17iGLkrIYGfb/VUKav6Wqp4DPpyvDy+YwxqNKOqHyPhzGobW153OvY1pymLAYkLWKflanMJGS6AfjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs4Lp+EB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs4Lp+EB"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68dbd44fso5582023e87.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781693470; x=1782298270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXRivm292bJRGGQDbbNQRy7dH8nW4IqAFB7P7VgPQAM=;
        b=Cs4Lp+EB3LPMSFm3vb5AhDomuiw+kLIGPYQdOWDdUvMTkZ8g84eMplsdY8fS5T8wPV
         TM33H0Kxsbvp3ESBNODUZ4Xg2b49e0xyzqZLziE1YdMbBLBS/waWeBjLcy7XEBHSLc7Q
         28+6aOhDvYlxZhOBMSECJrx5XLXGmfrkI0T8RZiRISJa8sLjlI6P2IfpIJNXywh/wBpw
         Bz+fcQz2Ayowif1zWPwpGkX68DcO/7LbnB+YSiKZsGK4p5B6+FLuT5S+Y2SQBQZ4/l8w
         jMueJBWA9l1RGxZyOQphiawPyeRhedbx4Z3jChMEJzb+ipRSs4mA8WvZAZTE+WPHazhy
         FRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693470; x=1782298270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXRivm292bJRGGQDbbNQRy7dH8nW4IqAFB7P7VgPQAM=;
        b=Yyx03mLgXW5NN8ILhZIPTrKj3IQRt1KdmQ3ZJCGsx7E5/CQrSoWQbZDHvXy0CkwAvI
         E3DfCfPzyq0nx6DIds1P5df/Y7WTxmiUY2LylHTltkBOnuVUS0t4jOSN9AFzsPFkkupF
         ooY9ieOtxLQEdhz33DFlfOTrNPayZ+h+7NMm/asPkW/ZGD+my+ifZ4tvVGpCYx+YxP2R
         SRoU9tPjiWhAvA7gkX0q0ee2WyYDGQ7xSeHclTcdZwb5ZDABrdq3GjyHJjM4MdbywSKy
         WjEJyJkEzQ1ykji2PG6RIi+YzEYxyGnTaQBGkZ/IlhyD138Wx+L5xuRIfVPDSEAvi5yv
         O48w==
X-Gm-Message-State: AOJu0YzGp/Sx7qNh+dOa7P3r/9MbjN9q7t2YWcgS8r+rK1KSThOGiz2k
	AaVc1zeoF9DF6M2LTlAob/JCb7Ot/0OzXPtrWXBs7yjB9AyaS5DomeWRdsz81/KW
X-Gm-Gg: AfdE7ckfjo3K0DpuMRpsycLnNhYoyPTiuHVQtOnJjUzxCJAn+AHwcFBSrgmtjTs47W/
	RTOsY4r90eLlpw0fiMYgRo/h7siAvOU5kMDxX/BDGa0I7+YzmoqVJH4bqkzobHoQS84tOqH3b8T
	6qjQCey5Xh/k0uueOJYpvFexgATYwK4IAZ8XcRkJgT1WQrKZ2QJOYkAcE1DkMSueWZ9uuCrZR9M
	0sWMyu/kPRzeSmk570Fx0++SUu45M7kEeqaKvj5Sh9cLWbnvYfi5XHv+YQq/qMQlk9b6+i45al/
	JTBZ3bl/68kGjYwvSl+GhKF4HOC8DTmWYPES45WbnrqMr/Rw+Ov1hR8hs3uA6FU4FoXmRBzm91g
	a9pkfpe3VMtG7TsWQ0Fy37nDxq3Lc/a9K5yXqoe4+b5yckOC3xhaHw8axjiGaDqVn00EG7Wqros
	NFLOJBu06+1ngFy2rAZE/1iHhFXTKVGIYRoNTk5+XELhrUlU5FoGjPFx3AgE2V8EuLzwDoRQxep
	Jb1bIURPx0=
X-Received: by 2002:a05:6512:68b:b0:5a3:cc81:eff3 with SMTP id 2adb3069b0e04-5ad4700cbb5mr959230e87.26.1781693469320;
        Wed, 17 Jun 2026 03:51:09 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-6e-3100-ab3-3fa0-bafe-f56b.rev.dnainternet.fi. [2001:14ba:6e:3100:ab3:3fa0:bafe:f56b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1adedesm4354678e87.57.2026.06.17.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:51:08 -0700 (PDT)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 6.1.y] KVM: VMX: Make vmread_error_trampoline() uncallable from C code
Date: Wed, 17 Jun 2026 13:51:00 +0300
Message-ID: <20260617105100.22094-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a ]

Declare vmread_error_trampoline() as an opaque symbol so that it cannot
be called from C code, at least not without some serious fudging.  The
trampoline always passes parameters on the stack so that the inline
VMREAD sequence doesn't need to clobber registers.  regparm(0) was
originally added to document the stack behavior, but it ended up being
confusing because regparm(0) is a nop for 64-bit targets.

Opportunustically wrap the trampoline and its declaration in #ifdeffery
to make it even harder to invoke incorrectly, to document why it exists,
and so that it's not left behind if/when CONFIG_CC_HAS_ASM_GOTO_OUTPUT
is true for all supported toolchains.

No functional change intended.

Cc: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20220928232015.745948-1-seanjc@google.com
(cherry picked from commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a)
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---

Notes:
    Backporting to fix the following build warning:
    
    In file included from arch/x86/kvm/vmx/vmx.h:15,
                     from arch/x86/kvm/vmx/nested.h:7,
                     from arch/x86/kvm/vmx/vmx.c:63:
    arch/x86/kvm/vmx/vmx_ops.h:15:58: error: ‘regparm’ attribute ignored [-Werror=attributes]
       15 |                                                          bool fault);
    
    When building with gcc-16.
    
    Compile & boot tested.

 arch/x86/kvm/vmx/vmenter.S |  2 ++
 arch/x86/kvm/vmx/vmx_ops.h | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index b4f8937226c2..ea7be3a74b6d 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -274,6 +274,7 @@ SYM_FUNC_END(__vmx_vcpu_run)
 
 .section .text, "ax"
 
+#ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 /**
  * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
  * @field:	VMCS field encoding that failed
@@ -322,6 +323,7 @@ SYM_FUNC_START(vmread_error_trampoline)
 
 	RET
 SYM_FUNC_END(vmread_error_trampoline)
+#endif
 
 SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
 	/*
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 5edab28dfb2e..d23705df6a52 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,14 +11,28 @@
 #include "../x86.h"
 
 void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
 void invvpid_error(unsigned long ext, u16 vpid, gva_t gva);
 void invept_error(unsigned long ext, u64 eptp, gpa_t gpa);
 
+#ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+/*
+ * The VMREAD error trampoline _always_ uses the stack to pass parameters, even
+ * for 64-bit targets.  Preserving all registers allows the VMREAD inline asm
+ * blob to avoid clobbering GPRs, which in turn allows the compiler to better
+ * optimize sequences of VMREADs.
+ *
+ * Declare the trampoline as an opaque label as it's not safe to call from C
+ * code; there is no way to tell the compiler to pass params on the stack for
+ * 64-bit targets.
+ *
+ * void vmread_error_trampoline(unsigned long field, bool fault);
+ */
+extern unsigned long vmread_error_trampoline;
+#endif
+
 static __always_inline void vmcs_check16(unsigned long field)
 {
 	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6001) == 0x2000,
-- 
2.53.0

