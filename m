Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356647;
	b=e/PyVaiPwxeL6jhNDBei2QuZt2bhxGGVwcglRfXVs28Pmn/jHgUp5dQGb/MaFaV0isU9
	 qR1sXKudfKE8mmNJouDT9KUO1BNpYD4TuuNiJU234G45hc2YDHVuB961jYdqEZfyw+13L
	 RTsjAd2r756TR0V45TCrhsY1Pp+OvvtCbXndOGA0GnpTXZk9jM2KVLgOKOTqID6US9EtG
	 LZKrjaboI+xcOfEBbDE8BaPs4ygH9IkTddB6B+d3/RwCbatlW7W6/HnonQPQg6+142lg0
	 k1WOhycCEwiMT8JSuL5Rn+PNhFflUTArO/5io0N/o6i2+LSHQ2ET1c/2jYlCx4k4ASg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356647;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=aqOIVCef/lMI30CqJ3FYmDR4bilZzBQtZ67U+hEJUY0=;
	b=ccXZnxZAn2xc4yyzZLVgJyXnLHtnh851swQZ4Qmr03f4QvzWO7HxsFi/xyM81Z9bje6I
	 5qW6LrrevKy/yKsPQ86GRC2mTMlPcVeSaadoWTKYotrKge98MbLjiLf/WOLQ9UbLlsld8
	 BtXEeqh/x35w4+P92buMu82Dz+FF3vMe64OkYaTck347q6oAzvpJtYhehl5H6+DDRlLoE
	 0ycUIfW45QMIlsxg00D7sqneaeLPB+5fvBCfRL9IkI7E0D8mNiWdM+ikgBrSThLUTyqLE
	 mnwgcIy1YZ9lNMn1I+enFZXDD0A60jLI4rRSMrKFTxxImi40ltewkxYvRJmGt+ROSsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Hj9SZwWk;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F826606A31F;
	Fri, 30 Oct 2026 10:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F826606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Hj9SZwWk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356647; x=1824892647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aqOIVCef/lMI30CqJ3FYmDR4bilZzBQtZ67U+hEJUY0=;
  b=Hj9SZwWkYSBXQdMhopJdDKOS2YthOXNc+1yklrbwdyynUgjI6HZyBO0b
   zk8VrblzNpdNVYTLXJy949s0gbXYG/q73zFizmXrUTt3QIRwJAE07gMOD
   vzNAj0ebvRXHlgK66sgsGaXldzJsjZfRfW2Y6UZthEowlUtfOQt0xlZQW
   ysm/h5VsidJiZfG4J128GmhbS/OUmPMWmNNqBG5HyoCXmZxVU2+E6wGMP
   UCtkEnfZLJbQd+dg8Bam8RVzizS/lh3IUcPoTMrahmXnfo0U7Zj5PVjQZ
   A13gDJty7POqZ+FIdDIQR4ZPiWTn45k+A8/+xqHNBlLIp8bzZehEq7/jL
   Q==;
X-CSE-ConnectionGUID: ugjKjdGpT7CIw9nLP4HIEw==
X-CSE-MsgGUID: Brj8DXu2R+O+VAvg5b3epQ==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32690039"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:6160]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.149:2525] with esmtp (Farcaster)
 id 7e125356-9e09-4241-96f7-950904a2ffa5; Fri, 30 Oct 2026 10:37:23 +0000 (UTC)
X-Farcaster-Flow-ID: 7e125356-9e09-4241-96f7-950904a2ffa5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:23 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:22 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "Bjoern
 Doebel" <doebel@amazon.de>
Subject: [PATCH 6.12.y 0/3] Backport nested EPT violation GVA bit fix
Date: Fri, 30 Oct 2026 10:37:10 +0000
Message-ID: <20261030103713.573783-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
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

Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.12.y, with its two
dependencies.

Patch 3 is the fix: KVM pulls the GVA_IS_VALID and GVA_TRANSLATED bits
from vmcs02.EXIT_QUALIFICATION even when the fault injected into L1 was
synthesized while emulating an L2 GVA access, i.e. when that field
describes an unrelated VM-Exit.

Patches 1 and 2 are prerequisites, tagged Stable-dep-of; neither changes
behavior on its own.  Patch 1 lets the EPT walker tell a paging-structure
access from a final access, patch 2 plumbs in whether a fault came from
hardware and renames kvm_inject_emulated_page_fault()'s exported symbol
to __kvm_inject_emulated_page_fault().

Context adjustments are noted per patch.  Based on v6.12.113, build tested
on x86_64 with CONFIG_KVM_INTEL=m and CONFIG_KVM_AMD=m.  Not runtime
tested under nested virtualization.

Kevin Cheng (1):
  KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED
    bits

Paolo Bonzini (1):
  KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa

Sean Christopherson (1):
  KVM: x86: Tell ->inject_page_fault() whether or a fault came from
    hardware

 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/mmu/mmu.c          |  3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h  | 26 ++++++++++++++++++++++----
 arch/x86/kvm/regs.c             |  3 ++-
 arch/x86/kvm/svm/nested.c       |  3 ++-
 arch/x86/kvm/vmx/nested.c       | 26 +++++++++++++++++++++-----
 arch/x86/kvm/x86.c              | 16 +++++++++-------
 8 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.50.1

