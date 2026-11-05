Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860206;
	b=ljOZ9NG3NymiLSFAeK8xgK9rxyjZQgZ02VuLTPsv6nZf/k446rfYiXvRlUAhqdEOuARn
	 v7uE0z4pTMr0ACe7GbXVY1jiDPcLaJz0NtIQgn7N1ZL25506CNQ2+jsQ+/6bFgJdvzhdt
	 +/Ch9rEeV7AfjS8Pk995rv2EbZYVqx+AlZZ0gWnszSnUM4ojTz4Jp3F5O1ujS9WFQQ7Kk
	 k4aNMsVhZ0Z03i3R0aLixhMTzWrGXbvCe1Ws0usuWACMJMFHc+nuoNhlsbUXqDB0A+cUb
	 hLnkzbFExMR/I8N1ibdvI8pZPLvg+WAT10dittysEzH0p7D4NsDTWazgWbN5xT+zrhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860206;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PWFxmCMnB0irhASLVF8rS0f0i9Jv3PfY5sbSXj2DSx8=;
	b=J5oOD3KGA70ojqHRz5yveTni23quTSNmtL1p8SjlWQulBbAdTJ15nj3LakkMTEJz07aX
	 NNfijOnPScO9zLQHGswOJV3c6+yss6CudGTUptjRdtzEgZVRdnMZUVkGLJO+WDq91zPXg
	 cUJN3OwxhDwne8rEYKDjPpedZHiWoTsuUF1ibFW8rpGaQMAu636lnv7i1u8xhipu054GV
	 jX2OncK/uZXaDhpkQ8CKU19FU2wTRzvmbaGv691NBo+DOb5sIX+xi43GP/2yJUMLP0p+X
	 018KKPTP+ZlY2Fd0UNe6YhKTGqYlLk2jwHW3VEvI56IGGv5XMEBaTTZg16YngHCBE0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k9CrtHYG;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB52606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB52606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k9CrtHYG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793860205; x=1825396205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cZMd+gqMUM1MF7vow6A25xOJT5b6Hlp828Eu1VikqtA=;
  b=k9CrtHYGFFfV/YHcwNZ1RBlAyq03a6xhVkyr3gXt+bKFSWkDnphpUrwl
   PFfKpfcSzL7HRbaA4wvUwiZpEfwKhhzrOoVEsE2Tu5L4IDpqJ8YwagjUa
   hjUV9YYamGFx6ygV1jgDPAnUFatddlx+NTPTjRGjvcYPJmM6DnSMlaA+i
   gyhZwfZ5iNk/Z2ZEGeBKYHYGGCWHGB+P+uIN+qlbpZZ7P89+8Axom7nJM
   DGvwYhTVTMMt18twoJZFHkQ7ptnOj/PRYxianhg19fJDb7e9FmTEYt5SL
   kFv5oPFoQBoQGBx9ayjjBaCVi8x4ZcPO5Jy69ZPwWRbJbRMayVwDU5H6t
   A==;
X-CSE-ConnectionGUID: V7lpHu0zT4GhwTppJkUbfA==
X-CSE-MsgGUID: oUmBwWsETsyjAf7ZK6NqTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2653806"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2653806"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:30:05 -0800
X-CSE-ConnectionGUID: cQZzTEGRTiyft5QpTiWbiQ==
X-CSE-MsgGUID: PCXSTjT0QS+/cb3As6s0Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6805910"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by orviesa003.jf.intel.com with ESMTP; 04 Nov 2026 22:30:03 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: stable@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	sashiko-bot@kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1.y] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
Date: Thu,  5 Nov 2026 12:16:32 +0000
Message-ID: <20261105121632.2103355-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110459-dismiss-purse-35a5@gregkh>
References: <2026110459-dismiss-purse-35a5@gregkh>
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
index cc10bde20d45..16b95732ba9e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6539,11 +6539,12 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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

