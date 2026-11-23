Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436719;
	b=RTTS5pM+sBV71yE47VtWiHFbHvDa3oUdMj8D/lhdoxkmcuVn7ARBafjUL0iL3Ps1hLMP
	 x2rY3AKWVTKpsuNiExrkPvQz0hn4zIzk1XpTHKvvazEMVMPifjSz8KCmHCRfBlB4DSH0q
	 c/StBdfSdgV7e1oRa++1lPSjArFzqVNNsFYrnUPjrr+qrWNsS3GRmw9fT6q8aU0qKzdyZ
	 QU6FKESXY10ixNUdEMXZIRcEUAzrDf61nhaiOEtGdj5tQGEeL7N8Ih+RMDfD2bIlsTG4j
	 CoJmcfa323GnRoJMxAaqJXs8btGQ4+wGdbeGtqIxj4oWduQw7EHAHg4dIhVj9dEERHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436719;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tldu1pPq1tFnnZ4lQX/5r3nL8doGcKw1UuvF+7JQIF0=;
	b=UNtfu2mBQZIxk2610GVmGBbGKiE99q4NNE5h9iH2Y3X8bk55p/snts/Fz8HfZo/subLp
	 b/KDc/5bvTktkdx0ng9wwBecXlufbaFWdkyPjzJ1cL11TUJol2Cz8KDCeOveTK0coiQZW
	 SfEpVuG+CylTwHJ09ycR1OIL+mJs9maVBf8Av6KqlGIVYe7iCMOtrW3s76v0ySuTg2CtR
	 Gv4+0l0f6HFBmHi29wCmaFJZGmhPFJ2g6rKz5/WJeXH9HPU50nxkFsPZpNbqidksp7XMH
	 eIGeMfS77RiYQznCUsdzWiyvUGzFT2z7xNziLoK7x9MwhDEgpQTHg1k5+h+18eWWUHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JRu6t01n;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15B606A321;
	Mon, 23 Nov 2026 12:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B15B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JRu6t01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795436719; x=1826972719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DbO9wJogMUZxd6nt5129SnhSMiIcfC/4XTjKPwbRlNo=;
  b=JRu6t01n3fpVmRIsoFBKb7CpGfLVfb1WkdZMaBofgHF2V/BqbvrqE8gt
   qiZhP+NlQu0BwhQ6rRqbxnlwCFRLjbZWIp+2UwkuED/wVMjuCKiB54hjV
   vPiCvf+iy/HePFHmjh/MH5d+riw44p7RJXIu9cw1TBBdxx2OQxRhidJw0
   O5shPqjZT3KK+yAMz7zMo0HsPilzXEkE/RbzTlnrU0mzdxmZfhJX7A7cl
   7uvsonOvU60vVoYAAthkL6LSeVDsTgYsAnFeoDR5OGNqmkotvh59AMBLU
   a13i9pRdeqCKZ+AHi9PRPCtJpRo2f5Yfp+vLQTgH6kGq0y+t6EMuIuCk9
   w==;
X-CSE-ConnectionGUID: H9ma1w72RfSSemhpM/fJmg==
X-CSE-MsgGUID: m2k3Ya1ZSy6pgVcM6Gp1ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4127855"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4127855"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:19 -0800
X-CSE-ConnectionGUID: Z4NyQ+6CTnCTGFpV2C83JA==
X-CSE-MsgGUID: 4F1VlV/FROOGmwYW4Bwt5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11481379"
Received: from emr-371.sh.intel.com ([10.112.106.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:18 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Yanx L Liu <yanx.l.liu@intel.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>
Subject: [PATCH 6.18.y 2/4] KVM: Return an "unsigned long", not "u64" for the fixed-1 DR6 bits
Date: Mon, 23 Nov 2026 20:14:25 +0800
Message-ID: <20261123121427.2803358-3-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123121427.2803358-1-baoli.zhang@linux.intel.com>
References: <20261123121427.2803358-1-baoli.zhang@linux.intel.com>
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

commit 28bb033664eef3c18c6acb2c075fc01d7ada9296 upstream.

Return an "unsigned long" instead of a "u64" from the helper to get the
fixed-1 DR6 bits, as debug registers are natural width registers, not
64-bit registers.

No functional change intended (the fixed-1 bits only set bits in 31:0, and
the sole caller truncates the value to an "unsigned long").

Link: https://patch.msgid.link/20260930193634.3415089-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Yanx L Liu <yanx.l.liu@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 arch/x86/kvm/regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3cd1fb8fb09ad..7556eee700029 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -679,15 +679,16 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
+static unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
-	u64 fixed = DR6_FIXED_1;
+	unsigned long fixed = DR6_FIXED_1;
 
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_RTM))
 		fixed |= DR6_RTM;
 
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
 		fixed |= DR6_BUS_LOCK;
+
 	return fixed;
 }
 
-- 
2.43.0

