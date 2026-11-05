Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860014;
	b=g2wpnHHfWippnPf3d76IdH8tixhZ+JjyzX4PecnjuRBm3ugNH91FvgVwNyYzFxKoKW7B
	 srcuGR7sJBa3nFXKieGl6tcpUcTCLzygbcIoVqjTQiNRlgnY/1qvFX+D6BwukDFugKDBQ
	 c57tFRh33SwT31W74QuJ9gBmWwSJBiaz+FrC2YH9D9aUPLWB/r5EMYMrUr0ba4TnQWWZc
	 SbQuXnVncdqY6xgbqu2/k0e+mQUuFpKtApeFvavFacOMmAa672Zcrq8zXrob7sqXTuIRw
	 8pIiOyu7sDzuGmBDgN3IX7m6hVdU3e7xUGevTSBGZa9ATd0JmBdyeg6VONpn/NiEOzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860014;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e07DBcItyUz5/dNj40IGj9ZHlIUcPp6W0V9oYQAxftI=;
	b=WGDFFeT1ijea4kQuDFH5HtzkjxB9oA0NXyRmGkU9PgfyQiYnJdLUslsIO3kJIPDnvUpo
	 JcrH/4MDvCKaoRRCETeCtjGUXawYbcWXG5OwyTcV+SFURBOROzTar+tME8sZG9YsBZRSO
	 l7QVquvZnxp3gqNXKrEknY/Ywz38bvuBSk4mmctn86mB8DVheS+3ikFBEZIzPG/pel17b
	 0CRwwoJr/ev1SslFL0/afX+vlNJs/zrSQcy7tRPSUGfKA4E/wlu7l7aTU5qKgF2qeSIF+
	 TSVQKKxJuJQ9UsU11H/PAxbsbZWfwRkx4QCf/IjUGAB30E/+1H9pQm11fbu55gLFu8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a6cjHMC+;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067A606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F067A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a6cjHMC+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793860014; x=1825396014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUgQvJgk8ZW2mML5mjrA34yWEf/ir95l86g8Dk/I0dE=;
  b=a6cjHMC+E7bFNbHDuOSgDHQZP45IDWgJWXd3lt0PPTWH72ulqbpCyXM0
   DbqNcpSuzKt6Hyi+y7eh5E+AZ6yNkMzmDxEBARFSeJLbRCZddp/cGFohA
   6dNeuAzvG0EdWTKLrWUdKH8js8ca2BWUZwKZ9+XmODO+1+75nWvlLEoDz
   7DBBUaaSwBOHG/fszMbPkJbBtwIOohbLzrHEhGZ2UJ8X2qkJBfJMnfWS3
   4AeDTB+rqX73Mx5grqnd1+mnc2MciIrRmU9ahbLvmkW0UwEhD0GW4XrzE
   FPuishNDd6KalIs2GrQyEQ7YoA+exCUMVWpbor4Jyb5sqVIza2C0dtW8P
   Q==;
X-CSE-ConnectionGUID: B4vOYJASTGiI4z7jR/hXRA==
X-CSE-MsgGUID: +TvUA8SaQUukFbD9IqL7Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2524185"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2524185"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:26:53 -0800
X-CSE-ConnectionGUID: pHXoweaFRpeclZZQ/yLVpw==
X-CSE-MsgGUID: noG4tZXaSK2q4m8RjCTA/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7253797"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by fmviesa001.fm.intel.com with ESMTP; 04 Nov 2026 22:26:50 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: stable@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	sashiko-bot@kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12.y] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
Date: Thu,  5 Nov 2026 12:13:20 +0000
Message-ID: <20261105121320.2093899-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-starch-scroll-7508@gregkh>
References: <2026110458-starch-scroll-7508@gregkh>
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
index 7a8dd42b9032..a36d9f504ba5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6627,11 +6627,12 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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

