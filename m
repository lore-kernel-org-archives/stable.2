Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0B30C172
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516414; cv=none; b=JzQQehH1zFCkeQLK46/9SOXfeObaSrrUX4m2LOuiipi6uJUGTnLFErgt7QdeExBJcB6AmqmZLtiVG5dXcVd3TteLVVf0RAnMRM2PPCveNCuT05FjBeBylNz+6os5wupDBvfqwMuc8SmMjGcUCKL7E1uuhoocCaHXVUp/tPfnuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516414; c=relaxed/simple;
	bh=Gs/PljVUUspuFUmq10FMNkcjWj8w/JpLIy2uNLGD3Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/5acDugAnTEV91X3PC1WJGIrwHPD+JLhUF6JiVeO+6aXTkDrXZAGVUgkazuctASj2bckzEzzjIrjJHjuDjrpOI2qHRib09pixjeN80+XzjKMj4cmnDRWpRmiaFoEasoHqVS3PXVsTVa+PDdRbnR8oFXpiUe6SZpmvgBIGoszCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WV1HUW7G; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WV1HUW7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784516412; x=1816052412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gs/PljVUUspuFUmq10FMNkcjWj8w/JpLIy2uNLGD3Yc=;
  b=WV1HUW7GgFna1CKTVzgcwVZycawXF01gfaHeKRf9RV6BhdFLWAyq2yOI
   RJ63+8cov247TFg5GbFbSUX3COj8j7OKHcCE0RLyDvsXam2wTBWpsJwUP
   D+b26FisvXZIC8+F0ApV0XCoXiim/BUa8PWHdaLUfuWyiY8EEPo5SsI43
   4C6oBsTfCgT9N3q4y4xVPXztcQc2YvL1jcc8bH5yPBVzyNEbAAuOJjCUY
   7eDnPze+lUevhkCs9X/b5ztck9HjGv0yBdr6jnjsIuAdKb6+I6DTJPFLN
   J2kgO8jC+G3AGq+spE9s1EUXszFxMVyaNoTjh+wDZj1ciO6BRtM59bI83
   Q==;
X-CSE-ConnectionGUID: gDnrJZ4OQjmvouu+syVBog==
X-CSE-MsgGUID: kLj1ckH9QoGHkYM4+CoWmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="96229335"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="96229335"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 20:00:11 -0700
X-CSE-ConnectionGUID: A6NfjGXYRHGhKDaw0EGmtA==
X-CSE-MsgGUID: r0sCwY53Ssqa2TWUH4rjNQ==
X-ExtLoop1: 1
Received: from litbin-desktop.sh.intel.com ([10.239.159.62])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 20:00:08 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH 6.18.y] KVM: TDX: Account all non-transient page allocations for per-TD structures
Date: Mon, 20 Jul 2026 11:03:29 +0800
Message-ID: <20260720030329.744758-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2026071641-falsify-antiquely-4d9a@gregkh>
References: <2026071641-falsify-antiquely-4d9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit a8b2924676ec42d76597f849baba31acc3ba1bfc ]

Account all non-transient allocations associated with a single TD (or its
vCPUs), as KVM's ABI is that allocations that are active for the lifetime
of a VM are accounted.  Leave temporary allocations, i.e. allocations that
are freed within a single function/ioctl, unaccounted, to again align with
KVM's existing behavior, e.g. see commit dd103407ca31 ("KVM: X86: Remove
unnecessary GFP_KERNEL_ACCOUNT for temporary variables").

Fixes: 8d032b683c29 ("KVM: TDX: create/destroy VM structure")
Fixes: a50f673f25e0 ("KVM: TDX: Do TDX specific vcpu initialization")
Cc: stable@vger.kernel.org
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://patch.msgid.link/20260129011517.3545883-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Binbin: Resolved conflicts in __tdx_td_init() due to lacking commits
  eac90a5ba0aa and 69050f8d6d07, retain nr_configured_hkid increment and
  kcalloc() call. ]
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d9ffc16dfefe..7534397defa2 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2474,7 +2474,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	atomic_inc(&nr_configured_hkid);
 
-	tdr_page = alloc_page(GFP_KERNEL);
+	tdr_page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!tdr_page)
 		goto free_hkid;
 
@@ -2482,12 +2482,12 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 	/* TDVPS = TDVPR(4K page) + TDCX(multiple 4K pages), -1 for TDVPR. */
 	kvm_tdx->td.tdcx_nr_pages = tdx_sysinfo->td_ctrl.tdvps_base_size / PAGE_SIZE - 1;
 	tdcs_pages = kcalloc(kvm_tdx->td.tdcs_nr_pages, sizeof(*kvm_tdx->td.tdcs_pages),
-			     GFP_KERNEL);
+			     GFP_KERNEL_ACCOUNT);
 	if (!tdcs_pages)
 		goto free_tdr;
 
 	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		tdcs_pages[i] = alloc_page(GFP_KERNEL);
+		tdcs_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!tdcs_pages[i])
 			goto free_tdcs;
 	}
@@ -2937,7 +2937,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	int ret, i;
 	u64 err;
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!page)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page = page;
@@ -2950,14 +2950,14 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	tdx->vp.tdvpr_pa = page_to_phys(tdx->vp.tdvpr_page);
 
 	tdx->vp.tdcx_pages = kcalloc(kvm_tdx->td.tdcx_nr_pages, sizeof(*tdx->vp.tdcx_pages),
-			       	     GFP_KERNEL);
+				     GFP_KERNEL_ACCOUNT);
 	if (!tdx->vp.tdcx_pages) {
 		ret = -ENOMEM;
 		goto free_tdvpr;
 	}
 
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL);
+		page = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!page) {
 			ret = -ENOMEM;
 			goto free_tdcx;
-- 
2.46.0

