Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436726;
	b=POcuKjHKEen4T7uo533K5WO7D2ADg4xjs3PnPpz0x+Ki3sRrpqhF6icirHEKhQzVNZze
	 9WjJiQ6erf/bnU9bHbxtCR7k12WudkMIkbaU82derVHtcAPYpMpJB5y3AaWxeiXkgBzpo
	 L8Zm8cQphPfc9HboEBT3iI0dtk+LSM+WByZ94LM28ZZPMh9fiEaOByXEJboyuyfHHN+vX
	 QEWvZKAr5F2HWsEAXGRf7sGaYARpmeupyzu+xgzN0NC+MOpSDhnlOroDUbat/U2icEfru
	 1B8LS6n2EbopxEvPfdae3xVGrIe9M6i+9IkqsuKSMjjKCnDueFvFKH6/fcnFpRDZgYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436726;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ByGyGzEJHJpVCbT4aT1e1dTwIZs/NCLUnJFJnVFgcQA=;
	b=zIyZZBuRn4QAczKX3aHJ2iq85DfxP7g8zDKZuhailic1zyDcIVJE0Q9ysK1jrX4fiwvm
	 yaLbC/J8Atq3A1jikzejfBPcifN7LjfHLY6SNoCvrRPxWTEqRPgpuxj4lZR19kr+HdtqY
	 3l7xjyEv3Xpp5P5n3VcTX+OLgO7HCu9pu6yc+8bi1dHSVpNM7EVGhCRUtehPWj4zTPTa2
	 G7HbARUdN7nfXACG2dlODdnMvWXwgw2fMyd6pscQw+2zqNNqVPH2aa8DmdCcQ79KVnJZk
	 e6RIuk1zXW7Jq6LSMz1m3/h7BfFYtDQIixC16F0WajPrw/kM6nlCsQh2XQ+Tlqvvn0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5djYkNU;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D41606A33D;
	Mon, 23 Nov 2026 12:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D41606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5djYkNU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795436726; x=1826972726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vZEtKzeLINfodQ7mK5eR4BmD+VgXKDETEjiMnjq/0co=;
  b=F5djYkNUTdAYVwCnaC3GJ7yyfNviOaGXdJeNCRzRhTqzkhbJZDqPjE9T
   qUnBjEHMPrMVbqg+i9YsmKb7Rc4Fg0H3iTSHn9/SByqMf1GXAdiQJQ4G8
   wUoblERL/LbYd+QdypXJXmyyRKKVUOEa5alBuxbID/7eltO1KRv2k+j1O
   KACvkIzE8gYfJGj5gYBSYcDT7hiSMzWvn7WMOGAuhXLthfsLL39Jou+o0
   ZjTjvgD53YL32WbAC+TjrYjVH5lTLq95cJwz34iBagC3SdoVDjy3/g3P8
   OZw3A1q5KW7/IvfkyynopTJ7XJul94mptzGn3g4Lhz3MzJolNLpBE4iED
   A==;
X-CSE-ConnectionGUID: OHmYY+TfTrmBX/0pUol0aQ==
X-CSE-MsgGUID: u4uVyC8SSaqV8yW+ICuoeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4127870"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4127870"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:25 -0800
X-CSE-ConnectionGUID: Gt3IuiSNTGmgXkO8v18tFQ==
X-CSE-MsgGUID: 7oa/LMGKQOuOT1xAeVEl/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11481390"
Received: from emr-371.sh.intel.com ([10.112.106.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:25 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Yanx L Liu <yanx.l.liu@intel.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>
Subject: [PATCH 6.18.y 4/4] KVM: x86: Set guest's fixed-1 DR6 bits when delivering #DB payload
Date: Mon, 23 Nov 2026 20:14:27 +0800
Message-ID: <20261123121427.2803358-5-baoli.zhang@linux.intel.com>
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

commit c62ffee78db8837a6251af83798907af37b53ed4 upstream.

When delivering a #DB payload, set all DR6 bits that are fixed-1 from the
guest's perspective, not just the host's perspective.  Don't WARN on a
"bad" payload (or existing DR6) even though KVM itself shouldn't set DR6
or synthesize a payload without the fixed-1 bits set, as userspace can
provide a completely arbitrary payload via KVM_SET_VCPU_EVENTS (and
"hardening" that flow is not worth the effort as there's no benefit in
practice).

Link: https://patch.msgid.link/20260930193634.3415089-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Yanx L Liu <yanx.l.liu@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a620f14410595..c06a793bf8c97 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -809,7 +809,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
-		vcpu->arch.dr6 |= DR6_FIXED_1;
+		vcpu->arch.dr6 |= kvm_get_dr6_fixed_1(vcpu);
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = ex->payload;
-- 
2.43.0

