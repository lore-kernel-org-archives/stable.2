Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436716;
	b=qBiba/TFup4XObGZqJePmr2+sPjylPIvY9c69TY5T5INUkNLfjzBGqBNzWpsx6m66J/I
	 F5EqqTMUoFnRW/1yuxwRzdw6WZCjCOcrp5pwLfNWqD/OzKhbFZRg0etDS6feTboVkPjIt
	 xFaHuFIXoVz48Mwc4a5jZIAB2bweyZgxY8Y4W4RoaGTq7P8SEHg99ABgaRFrMHhpAJMqr
	 TIOLUO5vSot0OR5sER9wDLHiuNP6TuYZboMZFm33L7TmApQFX+MVjNuYGLETAlKRN0Xdo
	 Vhc82Ay5bOH1p9vI/+SFDilxoAYH1a0v/vNjB9QnmscmLLgeY0HuplYlU1yieXDx+uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436716;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nsdnGbQNg9/23elN+vGTSlHR2pRYfG7hKDg/tkOOnn0=;
	b=Bos5h2vvyBVW6kM82lnezBnqZLRw/GZJXKKSZrfLPqNkbxXYDeboSJWMC2B8cXuXtWxl
	 RM41MmTDb3CR9MPcW6F8gbq8JmSbECKcq3Mu+zTei6+CvqRozg7QO+Ir74hBwAUbI5cLJ
	 H0gYbCYA7WoH9Pxzx3Gzfw92/bsdczMbH9QH28ujxWJ9dtdZYPO4+D//k45Vuc1Es9b8E
	 mqkbYLQiA+zrDbi6cyAZNBPnQ9qEB8V2mNvYFa9294W5tWbULzogPPyUqjuIM+/GYv0en
	 ZoMFlvxf4RCHR7vOAtP7OC04x2X/UkPUqG29bQOlxYe63BKEFTs0gkoDr98iobXRhmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SpWrdF/o";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14BE606A31A;
	Mon, 23 Nov 2026 12:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A14BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SpWrdF/o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795436715; x=1826972715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=925eR1VusGPsICziv5/4N92QpvwXi4NbREboNDmGokU=;
  b=SpWrdF/o3D+sBNWNBnXz1hQHob4pqYjQJ9zXjdG1kld7rTadqFFGlz96
   5oDawM2WmJe1UrCmEY67TxNSiq2UMIzCgQpqjOHMOAuzPVZY6U6g9l/gW
   9cB1g4+DtlE4HiKTbarLyixF0qB0IFubP31EXap1e/nhbdK3nzHPSXC7X
   EJXb6kjxVBEhk+7xq9hBoZ7y9rPhYbB1dEER59TQ7G9Z/DI88p06sV+YA
   0n8eVa+Xe4WpcsICt9K5sDWqcwswER1GW5VHSJvPo2hJWNOVPRF3R4BXW
   LLlTsSFHnAr+aWw0MmWtfcr+k/HKw9XPoU9kub+6rhHY/O5VhpTjg1lsQ
   g==;
X-CSE-ConnectionGUID: is1IgunLT8a7y2hTF8lmjQ==
X-CSE-MsgGUID: fw3PkT/ASmiQzQVUbTObRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4127849"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4127849"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:15 -0800
X-CSE-ConnectionGUID: U/4SfK6RQVOooGx0BpKVCA==
X-CSE-MsgGUID: I/CIVBNPRl2KNPVCbuRVOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11481371"
Received: from emr-371.sh.intel.com ([10.112.106.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:14 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Yanx L Liu <yanx.l.liu@intel.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>
Subject: [PATCH 6.18.y 1/4] KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
Date: Mon, 23 Nov 2026 20:14:24 +0800
Message-ID: <20261123121427.2803358-2-baoli.zhang@linux.intel.com>
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

commit cc551e8d4f77c278fd0bb0ed45d1103cb5a90889 upstream.

Rename kvm_dr6_fixed() to kvm_get_dr6_fixed_1() to make it more clear that
the helper retrieves the fixed-1 DR6 bits for a given vCPU.

No functional change intended.

Link: https://patch.msgid.link/20260930193634.3415089-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Yanx L Liu <yanx.l.liu@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 arch/x86/kvm/regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index d19a9e7e41f37..3cd1fb8fb09ad 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -679,7 +679,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
+static u64 kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
 	u64 fixed = DR6_FIXED_1;
 
@@ -705,7 +705,7 @@ int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 	case 6:
 		if (!kvm_dr6_valid(val))
 			return 1; /* #GP */
-		vcpu->arch.dr6 = (val & DR6_VOLATILE) | kvm_dr6_fixed(vcpu);
+		vcpu->arch.dr6 = (val & DR6_VOLATILE) | kvm_get_dr6_fixed_1(vcpu);
 		break;
 	case 5:
 	default: /* 7 */
-- 
2.43.0

