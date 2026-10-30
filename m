Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356655;
	b=FtLpJ5YamRRgRg+8zFLhsUK8Vc+NRcjmR3jrpw4oN/pDgQ/rbAxvTsiVXw+JwmfIulcS
	 z46j+WD0zKRgdNwiMArKeys0MvbIJJKGyNReHKaY9CD2d6/Vwravdry0FtNy5ERUGpGMj
	 iOxB+EmSQnrr0PRRHzscqrZI1z5wNOCNgAIPjf7Y980PC6kgawQRiDGR+jO4ncCvKHN00
	 /HgDUcCfYcUm3+PoMYEkcVYfh9xmWUQZMJoxR61wW/ZbZPkfsPg2gy2eQV1z8x3JrBd36
	 BxOBlL87tyl6Cc7Z9AQa9ZhZSRCKzzw/DTJuMS4vDSqiiNUT3bz+GySiz3Amm3+P72w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356655;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=eaajkiXghFd6LZOq5zJCsgHBWbJZSSddiwuhki+vXyM=;
	b=lFfqO/MQX4DoU0mJaHsnjb97uG+lhalfH6QBR4xlvUqEMZ8j1SO25QXm/wcbPMc/aSA6
	 Wb7FuM/CVOwe80Nb7ZAMIY3BPwD3K9P7ipEmsnjoVIK1RDDa+U6dPJxXmVF2feh/Z+wL+
	 hYsrdNow2ktRngdUdwraFOYF7Iz4Qlk9SeHr1VlpykAo2BwqOMtQZArl84PVZRLxtzgWm
	 ZTaBC+VVG4eKdOKUsGNQDJMJLbMTyH1mSQ1aQJNmLG7j6oHmJNemEKiOKC7tF3XHp3rgr
	 iFt3W9cl65lUpE5bO8SzzgJo/KMNXAyJ5eqq5OoT8SPWSPDomNfG8GI6+9St90frgOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=QEqshlKc;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2760A2611;
	Fri, 30 Oct 2026 10:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F2760A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=QEqshlKc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356654; x=1824892654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaajkiXghFd6LZOq5zJCsgHBWbJZSSddiwuhki+vXyM=;
  b=QEqshlKc5Svq/GK7QWyoparz8sgjsB9q0cp0spwOuOLWHMg5GAAXb6ib
   Ih9CeEQvBqFkBdBDh6GdDEmAiKqrC42aR5P31AqDSWm7CSnc7kPtwD6b2
   hojGYcH7RspRprJy58noECBcRopUkdfH013R/sR5zEyJ7t8lAIIWP5HZ8
   FRqBL0PlcR6PQctj8gRwHjRy3+gXlmP8fK7kNxExrrXxgJGwPAvYTAipj
   IfosHdEZFa0dGFsLq7RZcezSj8V1Pp1o3X03RIpkU4GjBaO2x7kjNuUXJ
   9VpsMafd6BBQj4c1GO5uBmQ33MozPdkUzrFt2CyMqA7aRuazu5FH+LNRt
   g==;
X-CSE-ConnectionGUID: XOEdu2fQTMqmW/eRUZUkcw==
X-CSE-MsgGUID: +jln6ROdQ0CovAldpLVP7Q==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32439631"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:2199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.23:2525] with esmtp (Farcaster)
 id 2db07783-59b1-4622-843d-5f3e11a7fc7f; Fri, 30 Oct 2026 10:37:28 +0000 (UTC)
X-Farcaster-Flow-ID: 2db07783-59b1-4622-843d-5f3e11a7fc7f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:28 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:27 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "Kevin
 Cheng" <chengkev@google.com>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 6.12.y 3/3] KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits
Date: Fri, 30 Oct 2026 10:37:13 +0000
Message-ID: <20261030103713.573783-4-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030103713.573783-1-doebel@amazon.de>
References: <20261030103713.573783-1-doebel@amazon.de>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Kevin Cheng <chengkev@google.com>

[ Upstream commit 96b067b59ad9ccede585fcadab27543188353bff ]

When injecting an EPT Violation into L2 in response to a fault detected
while emulating an L2 GVA access, synthesize the GVA_IS_VALID and
GVA_TRANSLATED bits using information provided by the walker, instead of
pulling the bits from vmcs02.EXIT_QUALIFICATION.  The information in
vmcs02.EXIT_QUALIFICATION is valid/correct if and only if the fault being
injected into L1 is the direct result of an EPT Violation VM-Exit from L2.

E.g. if KVM is emulating an I/O instruction and the memory operand's
translation through L1's EPT fails, using vmcs02.EXIT_QUALIFICATION is
wrong as the semantics for EXIT_QUALIFICATION would be for an I/O exit,
not an EPT Violation exit.

Opportunistically clean up the formatting for creating the mask of bits
to pull from vmcs02.EXIT_QUALIFICATION.

Signed-off-by: Kevin Cheng <chengkev@google.com>
[sean: use plumbed in @access bits, massage changelog]
Link: https://patch.msgid.link/20260522232701.3671446-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[doebel: no advanced EPT vmexit info here, so the mask keeps only the two
GVA bits; set GVA_TRANSLATED via !(access & PFERR_GUEST_PAGE_MASK)]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 17 ++++++++++++++++-
 arch/x86/kvm/vmx/nested.c      | 23 +++++++++++++++++++----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 829821fbc8437..0752d1b3d918b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -495,7 +495,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * [2:0] - Derive from the access bits. The exit_qualification might be
 	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
-	 * [7:8] - Derived from [7:8] of real exit_qualification
+	 * [7:8] - Derived from "fault stage" access bits
 	 *
 	 * The other bits are set to 0.
 	 */
@@ -509,6 +509,21 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (fetch_fault)
 			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
 
+		/*
+		 * KVM doesn't emulate features that access GPAs directly, e.g.
+		 * Intel Processor Trace.  Assume the GVA is always valid; when
+		 * propagating faults from hardware, KVM will discard this info
+		 * and use the EXIT_QUALIFICATION bits from the VMCS.
+		 */
+		walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
+
+		/*
+		 * Accesses to guest paging structures are not the translation of
+		 * a guest linear address, i.e. GVA_TRANSLATED must be left clear.
+		 */
+		if (!(access & PFERR_GUEST_PAGE_MASK))
+			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_TRANSLATED;
+
 		/*
 		 * Note, pte_access holds the raw RWX bits from the EPTE, not
 		 * ACC_*_MASK flags!
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 415e1d4b85cf7..11a784f0eb10f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -447,10 +447,25 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 			exit_qualification = 0;
 		} else {
-			exit_qualification = fault->exit_qualification;
-			exit_qualification |= vmx_get_exit_qual(vcpu) &
-					      (EPT_VIOLATION_GVA_IS_VALID |
-					       EPT_VIOLATION_GVA_TRANSLATED);
+			const u64 mask = EPT_VIOLATION_GVA_IS_VALID |
+					 EPT_VIOLATION_GVA_TRANSLATED;
+
+			exit_qualification = fault->exit_qualification & ~mask;
+
+			/*
+			 * Use the EXIT_QUALIFICATION from the VMCS if and only
+			 * if the hardware VM-Exit from L2 was an EPT Violation.
+			 * If the fault is synthesized, then EXIT_QUALIFICATION
+			 * is stale and/or holds entirely different data.  And
+			 * conversely, KVM _must_ rely on EXIT_QUALIFICATION if
+			 * the fault came from hardware, because KVM only sees
+			 * and walks the faulting GPA.
+			 */
+			if (from_hardware)
+				exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
+			else
+				exit_qualification |= fault->exit_qualification & mask;
+
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
 		}
 
-- 
2.50.1

