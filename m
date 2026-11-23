Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436723;
	b=UrPMllJYcZ48+52W6Zgoxikf9PsWkmZkPV5zsG6SV6LCrkA3WmDXrOvIIT8YwUn6sElh
	 tLoMlRKr7qPVDfMb0hyMtToP7JOlcKHxO3oRoNmGofE5mx03JAOGAoxsaS2j62cR6mRrX
	 SF+BDyQXdiwUkwj38v/2z1y8Wjgzd5zeHOUtQwGGsT/yrUX1AuOqDUTIFBgkO2EQ8SNUc
	 h+5fk/aINmWmWOcTZ19KUNIj5eznjH9R6D3h6YrbDguAd7yJaVIKBkPoh6plEaEf9/n3g
	 dTB31iD0wL/szWnXm2w4TrUScGvAQt7k/ST1nC/q26dbmNO/gcz0buK34I4GekSkrfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436723;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0HCcVaiN6zL06j8OH+DWJsO9CPI56ZNwHXwb4yDVBIo=;
	b=s7E8Y06fz8tI3Zho3ZxEVoeJp40J2i88zOX9jhy0zYzzoQXnRaw7zY8+K2PjZmpOEkkb
	 E9jiJu8SgphJQbXjJ1hVUAQGLM3wY389j/flo8/DOxFUn6/a3I7pngAapda//tOQj4A4X
	 rdcwUeNCBFIiOYfV+u1veuk2EGQnzCRbpc0iJ3Si0caqg29AA07R32y0eNAwo6aGGK7nA
	 bqAUVZA7siQxaNUvmnU6eTf7iVAm5WP+DidUQh1R5SeC4q1mqeqtBPYIDFjxdc5Uo2nIp
	 JHrw5oHzYrf+/vx5C4oFcI2tpdUfYLEmHCSLtHERZ7G/l6Ur6fi0oxyAuLSSTxkDvvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nmy59yNu;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806F606A31F;
	Mon, 23 Nov 2026 12:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A806F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nmy59yNu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795436722; x=1826972722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcK/k+U+62vmwaX265etrptZXqWK4S4GLNrEf7tegyY=;
  b=Nmy59yNu103Yj/nTlK5JWbk5FiFqmgDUFsDJXEVMmNXT/qx8oKrqeRrQ
   qHuOy/Z0UclKQfQo1zvQ1TapECLZROkqlW/Mm+9ApgUEg/EK1umqXNaQc
   i2QxdI0ULqbBhilyvlNY+23lNvHA2H6m6XVp6SeHvA6eCnjDZGLjZ/CBW
   RnfBy5wrD3Ti7N9LS0Z4oL3fDAGlo90bjYQiMeqz2TgFIVeyJROFlxZeE
   UtSU2PgNgA1LYAs00K95zyG/xqDOj47u+pn4f1IsrDka1IkKYshpJmkpj
   zjMJMw3IVMhzbOfk1Ns1X3OXki0kszI3EUHNcOKV+/EH+wNnNdlK5HyPd
   A==;
X-CSE-ConnectionGUID: FiXMHxEGQxKsX8pzVynRng==
X-CSE-MsgGUID: qU/vRtY9RyqyHENoPgzZkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4127864"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4127864"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:22 -0800
X-CSE-ConnectionGUID: 369g3QcKQNKoD2xjXwHvYw==
X-CSE-MsgGUID: tcfMWZM7Sdi+J0kT0KfTJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11481386"
Received: from emr-371.sh.intel.com ([10.112.106.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:21 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Yanx L Liu <yanx.l.liu@intel.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>
Subject: [PATCH 6.18.y 3/4] KVM: x86: Force fixed-1 bits in DR6 after synchronizing with hardware
Date: Mon, 23 Nov 2026 20:14:26 +0800
Message-ID: <20261123121427.2803358-4-baoli.zhang@linux.intel.com>
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

commit 7b88577a0983af221a78fc66c56532eb97d8fd2f upstream.

Set all fixed-1 bits in KVM's version of DR6 after synchronizing with
hardware to paper over as much of the virtualization hole as possible.
Because KVM dynamically disables DR interception, a guest can write any
DR6 bit that isn't fixed in bare metal, even if the bit is supposed to be
fixed from the guest's perspective.

In addition to providing some amount of consistency in KVM, this will allow
adding sanity checks that KVM never ends up with fixed-1 bits clear in its
version of DR6.

Link: https://patch.msgid.link/20260930193634.3415089-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Baoli: 6.18 has no arch/x86/kvm/regs.h, declare kvm_get_dr6_fixed_1()
  in arch/x86/include/asm/kvm_host.h next to kvm_get_dr() instead. ]
Tested-by: Yanx L Liu <yanx.l.liu@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/regs.c             | 2 +-
 arch/x86/kvm/x86.c              | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 319aeac052f14..413d1a1cd0919 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2249,6 +2249,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
 unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
+unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 7556eee700029..6c7fda91b670d 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -679,7 +679,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
+unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
 	unsigned long fixed = DR6_FIXED_1;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3ca396316d3cf..a620f14410595 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11042,6 +11042,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH);
 		kvm_x86_call(sync_dirty_debug_regs)(vcpu);
 		kvm_update_dr0123(vcpu);
+		vcpu->arch.dr6 |= kvm_get_dr6_fixed_1(vcpu);
 		kvm_update_dr7(vcpu);
 	}
 
-- 
2.43.0

