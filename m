Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860147;
	b=IONaKqZRLvoQLp5cJ3lY/OZE/flTbNuRJ9u0euVc0gN2chAb2lrXmQ4UBQS2B1vNP3WA
	 eAGGurEs27sOlmZZJK+laELyBRuMGqekR+IAmwGGZBOox8pVspUmi7pvX7Id/QB3JkZjH
	 JE9psyxrk5MA8L/9Vcy4ARpzFbrm/wKw0PvcTnOl69HOk8xmbMAJowaOEGyxXH3w7I7DH
	 u3SVHlkUWzWiOZY6XE8DWGu/5vWvRbgfr1mxAnYoerqdYrtv3se7Adbu3hQEsgumcMRhU
	 sveVnt5ShU8MTdZhpKUXzPrPovWC4v3ndIi/A/huXoBWSgHQRbDp0zWlIZjEGTCqwyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860147;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4T3t6otSFQqWJdZERA1cxrUAGMnYDB4TZIPlCL9pFRA=;
	b=xGutLfttqW4VxcujmFWlOoRNeEbCcPPoOrvEpnSbdGpaGy5Khq1ySEIKL3zODAez9HAe
	 ZbQYV2p541cUzNWtL40ftTqQhwOM8S+zues7hcUbgI0BIwviFegV/TkB18wF26ltAo8+Z
	 3uOSnm6mE8eGdsRckjKgc2uTzFi1k11YRVXCzQmhG92dvw/GaGwC0nyjNPtBql3I8zNkS
	 N7DVkmXeReRzlXa9vGG2xh6SeCRb9FfBVzWbTRmsW4zejhSq8Ysgo0N6eQl9aKkuganmw
	 aWk0B+tAKcoEt2vK3xVywPZ/ySMcDFtZCVRaYitmQUINw+vBin6IBraJdJpG3W4FL9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ho7eWs09;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695B606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B695B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ho7eWs09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793860147; x=1825396147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcGCzOVEgPY0Yv64GcpGQbXm5oPxWh/RxzAK5lL3LFU=;
  b=ho7eWs09bO0zY2C88BF/dmXtx03qLCCJFkFq7gBrCW+mw3lsE0BrcuU2
   ZaY9e+J9Duaxa4bilcGxCqNgU1gH3krY5HB9fxMQfoSG2naAH/+UajQax
   noeNUsqrJxzBbT5TN/iHw5dLkjWw3Aq3I8hTCfGBFaUpNu4y6zOIry0dY
   YeWHFoCr/iOmOZmubOkMwW1bzPkHlu/tpacWotR4Wj9yTY/n2K0TSriem
   c+uS4GWSu6UqyPjZJl9A62Jnm46dgtv/MZRvzzJgT2bE/qMtKgd40m5dn
   t03maLMG4avUbVgh/zDv5Qf6L7ldPFv+PAxHW+Y8Yhe7Ab7kTOgcRpwpU
   A==;
X-CSE-ConnectionGUID: 1e1dMXXFS2GbpTCmIhZGsw==
X-CSE-MsgGUID: Dllx9xMzQ8WLBB/hQah+VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2630121"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2630121"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:29:06 -0800
X-CSE-ConnectionGUID: PUBCIeS6SxCVM4jksPS2Og==
X-CSE-MsgGUID: q2miV5maSwqkztSw7BdAbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6763804"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2026 22:29:04 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: stable@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	sashiko-bot@kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6.y] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
Date: Thu,  5 Nov 2026 12:15:33 +0000
Message-ID: <20261105121533.2097788-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110459-cone-playlist-3832@gregkh>
References: <2026110459-cone-playlist-3832@gregkh>
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
index ebbb9f63beae..1846f8b3c890 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6620,11 +6620,12 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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

