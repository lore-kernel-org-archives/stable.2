Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859363;
	b=LcjctPqsINhmkpjRrWzoXmJP/NtwXx3N8c9pFK2G9ETDgHUXFeXbZQO+eO2TiNIooGIS
	 oCYEh16yw2kPCyGNLL11w4jVmgbj3JHbno+CHkvlauL3n0JTF9+pzqadzAI2AvnFvb5e7
	 RDptwsuI7WkgonhQbGM+k0dt3WuaF9OhBTq/XGm8/QdCdV3X3q8N8Wys29PPNWbArotxq
	 zXWh1kTDLqSkitFkkvQh+tKYqLiTR7hgnSpgFplnHuCyPfVe1i9inf0ZpIU70Q2JwJaRV
	 8H+M4Tl5NS1ZOhcr/klpRXS91k5Ax+SfKFK0NxHrR4pMXiR7ojbMTnwHfXJ3LEjsKXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859363;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ht3VAbHQHzDHei4QEb4HwEqvM3SGqJetP0+wHUtoq+E=;
	b=1nGe4xGSfGs5CML7JMO0lArXKH9T/RrCJsiyerI6//k9DRNq/4Z+b/s+ljVJEqtcabh9
	 KnIy5/QtYkzRws48EIzy3Fz9Bdchr8a+cFSwtPs5bQejVmmTeMpDvHcv4oJpc4gSAhjlB
	 Ppqu51ObHz2NKcU3bYxxNHNBJTnRxEeQrrR7CVG5mBDPUkdmZFWh6R/pX5ewqF5Zb7kHm
	 dQxdp0lQM+ndCesNuGEObm5m7Gl+Mgn4EV7Cq37ozxnvEvIu/BO72IZPKKvlq10Mxhm5T
	 qFK+aDK2A38Php2PoxjQHDxiy7b58AM4TsKg3Zk/a23MvAFeW8Us4eUTDcv15PT5bZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cN8Xc5kn;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40B606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F40B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cN8Xc5kn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793859362; x=1825395362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7aUoKw3oosq0gAMmL/iJQ0+9zD1YGeuiR6rLRzJNxB4=;
  b=cN8Xc5kn3OB7BLNjozHEoNBwhbAyTMKNrSF1hNlEC6QCyi8+SZMJdPpm
   3d7znU7owhnjocYL4wdQ+706JVn0doG+44MnYkS9KD1+EynhX8Exsk67Y
   6R6NBqLH5wr5RHGwUpwxzKDfM9XvK/ltaxQcLPB0oTpY+0BLooXt0t81u
   KHCM2yvYPwPmmdbTqzb4eBY0TA57gjPekYYoyTMjzvwAWofHJhzPJk4gx
   +R9c+mkJflGXzVo9uczZMYV/HZ6f+YlMDke9hGeGpI6589ed61VWPCTes
   /VvdTC4zeGWVahKD5VxlYAX8FhclIh+w49nW+XkJUGNH2J4vQ/KZMn75+
   A==;
X-CSE-ConnectionGUID: UrTJYbNhQlW3giNqOzetxw==
X-CSE-MsgGUID: kCdxwbHIRHOkrtjk65seBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2670063"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2670063"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:16:02 -0800
X-CSE-ConnectionGUID: ATGGm9MPR52HKXI208cR5A==
X-CSE-MsgGUID: 3xNzNSgFTy+iD08vbBAtDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7031045"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2026 22:16:00 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: stable@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	Sean Christopherson <seanjc@google.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 6.18.y] KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
Date: Thu,  5 Nov 2026 12:02:08 +0000
Message-ID: <20261105120208.2031475-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-shrink-panic-2119@gregkh>
References: <2026110438-shrink-panic-2119@gregkh>
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
index c85c50019523..a9daddd84ad6 100644
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
index 5bae3d5ce6ee..54a78d5e9fe7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6173,6 +6173,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
+static_assert(EXIT_REASON_UNDEFINED >= ARRAY_SIZE(kvm_vmx_exit_handlers));
+
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -7354,7 +7356,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	vmx_enable_fb_clear(vmx);
 
 	if (unlikely(vmx->fail)) {
-		vmx->vt.exit_reason.full = 0xdead;
+		vmx->vt.exit_reason.full = EXIT_REASON_UNDEFINED;
 		goto out;
 	}
 
-- 
2.53.0

