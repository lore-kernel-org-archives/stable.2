Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356630;
	b=JZb/qzS0PdfKFyHq3Skag6keb7/sPjEf/XPOaT1gAypSjKTkXi7LjaLrMZnCvH0b/M9I
	 4Edzmo3QZ+P1KmihuvEn3j1Drlb6Ii+NMYM1I6iuCv27ZL2FLzdUvqSAtQM1ayVnthFP2
	 1eHvFJGj7iHZzVwVwe4EUmZ6JDnMXJc+MYDhTbaSCa4UAbe7RMupCYnVqxmClff3qaxR8
	 3Flu5OeYvPFA5yfM4nWJf6WiRS/MlQ0QrG8VAG+Q0r6kfx2LvWHX5Hv1RZkZV0tzcHn8R
	 7NTLKxVu1TIJm+oTQpdenL9w6ScODocASm0LMPjICwdLX50gO99fNL13NNtHwzmzV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356630;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=eDgQQK+HfR4rq0BQo3pQYPpRzKFT7C2wcqCPpbg4Ees=;
	b=yMyxTTtwXo6I56t7Q1b0EYOuxUWvZvD8ZibFMBa6dbHxvDggdfDGdF9LqzGHzIqn/5wE
	 qlBMYMUGiY6ji7G1sZUlxhQh1T+Ixdx25E/eZnRNaXbfEAQ5s0DFdTkgxndlZbKfyRHS/
	 ctSbX8S8eJ8oirKY3d47EVL7O8Utqxa2Vv3qJXZL5QPV2kzf+lMn8U/8ZN1XoSdWtZNuc
	 OsVpS5+T6EXHLsnAdg+Jgr1yXr+yRWsaB7sRti3Qzj1PIE/tSIl9hdatgrO+YmZKufrEo
	 ROkPLzptyanYcMxV6lXDoiXCXPeCxbaqpPyUxL9xk/6SeAYzNXAsbjRoHRJv2qFZe7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=jSuwmoUU;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1C606A616;
	Fri, 30 Oct 2026 10:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A1C606A616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=jSuwmoUU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356630; x=1824892630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eDgQQK+HfR4rq0BQo3pQYPpRzKFT7C2wcqCPpbg4Ees=;
  b=jSuwmoUUZwtvyqA7Obo9vXwLAse+hmi+FM4fRvQ0INGj4K3OmTE2pE7i
   +ustDlI1wfVCUdWzd+Y5FL7/dJr21tezwj6WYKJbyqR3Ym5nS7eLm5Grg
   o8A59PnF4rxKES88xKoStJpYhy+7TMOxE3GNCNeJJvw8b6hsSiFKl17Dk
   cWcF/zDjkq7yDiaJ0PpF0EmHFIbVAGflmPMiPOMOGwYvduWjWKRk0dDur
   Of5ofwk866uMbws4VU66nREdAYOHvnon/G+E7Oee/QcP1PW3oDtRigt3A
   00n0gQ30W5sCYh6/mrvrNL7bJGFY2BI23HlPcns9CHK6qqGFsaPj5yo1w
   A==;
X-CSE-ConnectionGUID: bb/cAvhmTsiSe1iL9rYuig==
X-CSE-MsgGUID: rOs4bfBaRxSvJixuYm+9lQ==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32435019"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:27513]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.46:2525] with esmtp (Farcaster)
 id 5bee4540-157d-4cca-bd8a-3ff91cc49b89; Fri, 30 Oct 2026 10:37:07 +0000 (UTC)
X-Farcaster-Flow-ID: 5bee4540-157d-4cca-bd8a-3ff91cc49b89
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:07 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:06 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "Kevin
 Cheng" <chengkev@google.com>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 6.18.y 3/3] KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits
Date: Fri, 30 Oct 2026 10:36:43 +0000
Message-ID: <20261030103643.573356-4-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030103643.573356-1-doebel@amazon.de>
References: <20261030103643.573356-1-doebel@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
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
index 8315868f783e8..58c487b57220e 100644
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
index 32e58cf412818..94fdc21e769fa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -449,10 +449,25 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
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

