Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860452;
	b=c/fvVAOpuUTlJ3yRV8VEtwfnqhUFlcLGNs77rnYzcHxQnKn2khnLt2atYH3W/5qodWvy
	 PAzDnvLjRM+TO5wcdk4TngDXjjK59oblC+LVXd8HastnHxLryqaYbMPCcbA54A5BZCX+q
	 dEsllkk+FqybAOQTeEqCMGOVqwjwF+6HRFEqfWq1ZtG194o6C3vSyf9pvdhw3f/aEfFWS
	 YbrNW2VSzxFx84/x6b+Uky4YPVjHUtUU38ISQvDzfw7mQUgP7v9CiOLie1SH/I9U37xIm
	 JyRvad0z/Dhn65c7fj3cSP9rPFKmXJp6qoE6F64V/nWlgQGY+jz2y5MOyXt7hPkvEew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860452;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ee8W2JgghbZinr70wGu2Q3Zi+elqsXdBuoLSfXMvJAQ=;
	b=BxBjjbmTFzvaCnSQhUedyavAUlsK+IR+EDgsRP9TPannQgE9Hgj/b0AEseE2Wng4gMNL
	 BW1MnsKlQ+H/pSak12hKbvH94y3D9pCKDND8kLtMioLxuCl6XE39zg+8IrwvpEZs4vpLv
	 o8FC9yXbMe8/xrIFntm+JbaaEBzxDFfFVGL7GXQCdkXAQ+fhcvcNXymrFUBRpR1w72zUh
	 Vfckh2MiPEx5tm7GMb/E/TEAfLIjCoMFbbWxmw+2NXFUQXDNux79z0Ig6yX95DqFpp+bg
	 5kA0Yti2NRWuQVj0wDITi18QCcGSsBWkotO7YrAKkCyUXW9pLK9WbtFS/aLgDDxpfBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="KGu4Wv/H";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECD606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0ECD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KGu4Wv/H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793860451; x=1825396451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jEIm1CPwOPOuNIqwbPVHXJ7NWjUiSwExdFnWoWeDjCc=;
  b=KGu4Wv/HWOVolPe/HXoaCzVkvmOcZL0p5WAMa/B90hGuBpsRelVc/0NK
   FhAagjv/LfW3DUtfY72NlPFMw1QZP2bw8MCZ8FIyTnvuUZVFN49ZUNFqI
   1kwddiFE1xgWC+69ZV+VrEf/pH2kxj0aj5u6ozRTUvWOOK17SBlOd2YGI
   6UecBrc2dK+avE4Kwve4Zdn6ABv/OADxUMX+9G1uvDd5Z1owyjqTbQ/MH
   QVjsMBC+P8eu91oa9/usXQzLbqH30rGz5Np2Zbuk8GMOKvrPIpMLNuj6k
   qHabm4P5CTMJlYN9rpF0AGkWYa/GwEu1J2NSLBvEpX3ZhRw6EO50zuol1
   g==;
X-CSE-ConnectionGUID: s5DGklgZQYOnOkAZZ8lVJg==
X-CSE-MsgGUID: /zD/QrOsSLWEpejyez6o0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2521066"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2521066"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:30:57 -0800
X-CSE-ConnectionGUID: SiYncaUaTeSXprzeDgQmsw==
X-CSE-MsgGUID: zjR59fXFSOWUtGmtILBnNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8691823"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by fmviesa012.fm.intel.com with ESMTP; 04 Nov 2026 22:30:55 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: stable@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	sashiko-bot@kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
Date: Thu,  5 Nov 2026 12:17:24 +0000
Message-ID: <20261105121724.2103509-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110400-steerable-maternity-eeae@gregkh>
References: <2026110400-steerable-maternity-eeae@gregkh>
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

[ Upstream commit cef48693da1e964e9f192bfc16cd0ed287c48337 ]

Preserve the negative return value from __vmx_handle_exit() when a bus
lock is detected, instead of always overwriting it with 0.

The purpose of bus_lock_detected handling is to force a userspace exit to
inform userspace that a bus lock happened. The negative return value can
achieve this purpose, and changing the negative value to 0 fails to return
an error to userspace. So, preserve the negative return value.

Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-7-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 244b67601bce..77b1161e36e7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6192,11 +6192,12 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * a bus lock in guest.
 	 */
 	if (to_vmx(vcpu)->exit_reason.bus_lock_detected) {
-		if (ret > 0)
+		if (ret > 0) {
 			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+			ret = 0;
+		}
 
 		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
-		return 0;
 	}
 	return ret;
 }
-- 
2.53.0

