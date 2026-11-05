Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859739;
	b=mz4yzLAB/8F9KAHl0WgTGszKq4cMmEG4AsKslW7QADpts8RIpsov9jQpNyCw6Ihyf9lo
	 YtJsT3zA/2rxQIY1l+liX2EJqDMw8ev8wB4LzU8gkeNgqmxhlgTU6SXCrKUnLAZG2UPsd
	 C6XnedAenAGpBi17cs/t092Nwhp4hddz8BMH5Z0QyOe8Brw2NmGg63IsjTfa7d8GlBRSP
	 RGTMk1wagZws53EJzXjIjmG+TyRlcaxySAT8GpRap5SYYn0GAsbzA5j95mQW3IF+MvhYr
	 vrgHiP7a5jY2xyphNphA87HtuOiM8RDMCN+MoNowepOoMTKepI1DN73M0Fijg3HzeSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c22kVI6iDaDjz+Pxwg/q1MAEsUvOm3Q18F07aEiZhTo=;
	b=2Nq5v/sMsMGTNYQvArDrmqE+ww5d2QLwt6fbvAyvsiyB/BZ0qXwVtp1earZAP740s2Si
	 91WUyeny1Cr0h6e+u1LYf1tcVAxEHktD2QcZPdemqLhq3FXPrzFRMlp9fggD3cbk24twG
	 DbZS0RHCaYVU8jOLgobkzJugGowOv/G9sCQMy1O7RJ2kPOtv5RKIigRvU0vmbjl8DmiO7
	 DPNIl0A3g10609UsiiGzZOnmzq6UscoU5MHfvOELHqacHzGGAVhG5HqqZvgktHl8mim0n
	 1mR9ASswlhVlCbmBIRRqTHCnbtyoTctW2duluRtLacwoGpg8IuXFT8mbxau2f1P57UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EyW7iDVS;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1F606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D1F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EyW7iDVS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793859738; x=1825395738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6jAi/xu4gl+txHbT7Jeh6opdG3IOgfnmDvp+yvOmTrw=;
  b=EyW7iDVSsWNo+g5z3pbZV2ZO9zngZw/jHAUBkaJKpe+z9izLOw0OYKN0
   KHvjUyZldqL9ifiE102T5j5uuI7QI43LJiX2r++ao6KS+0XHnksKhdos7
   nXFIQ7vKk6e8nwYhnWQF+cBleg4oQoX2GKIRrjfugD41ipmoaPAG8O/Fu
   HtssypP6ABizjhlAlqdyvhO6GoI9nm1+aDWjQB5oTAjbv2oM/39qfc3qc
   JvtWg4V+uSmd6btzJxDohTDEN2KvzPr6N0Dr+lLg49q/Ak1l8fk4IjH6X
   4tWcQZqAGlTFSJ+V4jCcb/8hHHJGGQQvl8PZVxAydJ0qvg1gKVG1AKHgD
   g==;
X-CSE-ConnectionGUID: lWGpn1bpTJW7EeV+7IWveg==
X-CSE-MsgGUID: /666IMmNQHGNLRKg0d0rxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2673470"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2673470"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:22:18 -0800
X-CSE-ConnectionGUID: K5CN2UuwSF6iRTCVTEEI4w==
X-CSE-MsgGUID: ugNHYbTJRlqFJQonmR5TSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8689784"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by fmviesa011.fm.intel.com with ESMTP; 04 Nov 2026 22:22:15 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: stable@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	Sean Christopherson <seanjc@google.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 6.12.y] KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
Date: Thu,  5 Nov 2026 12:08:12 +0000
Message-ID: <20261105120812.2037884-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110439-makeshift-acting-834f@gregkh>
References: <2026110439-makeshift-acting-834f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit d85f7dc8cf3c91a131946dae4c3aa8d9c97322d7 ]

Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
to stuff the exit reason on a failed VM-Enter so that the magic can be
reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
defined value (though the whole "dead" thing makes it pretty darn obvious).

Opportunistically add a compile-time assert to ensure the KVM-defined exit
reason never collides with a "real" exit reason.

No functional change intended.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260921235656.1107929-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/include/asm/vmx.h | 8 ++++++++
 arch/x86/kvm/vmx/vmx.c     | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index f7fd4369b821..ac2c0665b661 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -20,6 +20,14 @@
 #include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
+/*
+ * UNDEFINED is a KVM-defined value used to indicate that the basic exit reason
+ * is undefined/invalid, e.g. on VM-Fail or if TDX never attempted VM-Enter.
+ * The value itself is arbitrary, it just needs to not collide with a real exit
+ * reason.
+ */
+#define EXIT_REASON_UNDEFINED			0xdead
+
 #define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
 
 /*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7e098fb60bbf..7a8dd42b9032 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6151,6 +6151,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
+static_assert(EXIT_REASON_UNDEFINED >= ARRAY_SIZE(kvm_vmx_exit_handlers));
+
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -7313,7 +7315,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	vmx_enable_fb_clear(vmx);
 
 	if (unlikely(vmx->fail)) {
-		vmx->exit_reason.full = 0xdead;
+		vmx->exit_reason.full = EXIT_REASON_UNDEFINED;
 		goto out;
 	}
 
-- 
2.53.0

