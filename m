Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356624;
	b=CSk6I+ufyu2SGBMN8zGErz4P7jjJ/f3CQS6Ay1KcMJ3fppWe7wEuTv3e12rmrZtr019h
	 2Nmtv4QVhe5ihTtgp9hwoxfODwgvQCvYupfCQsU/gECzlovgekL5Z2CkRp1hVISfPQekL
	 sHoJxfnNOdJpgvmhbc+6Sio8HA3EMiLd18930vuECM3lX7mSIrIxsfQpMaqNG77xThwW4
	 Gmt6nWm6Mjb5NC7WO+c7a0f/qzd29T0TvzwSrs8gwAZT5eWxwcMSo4zX25fkv46hMM8+7
	 5YoSj+VxxsQCEr0vADWFci6fhMtNUvJ98mpg2Fa+8ri1enhTwtmP2BL5U8Rez1ZuEHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356624;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=DmHjgENSEM3/SBgtOokrDXU+0jtEzKN/4QNEBO3+0hw=;
	b=T8Xpz70haw7Ih2GT7nA9u71I5Tgj6xBbeVIh0GeRLtsvBdOWiClewi/dYt2hUZZTSSO1
	 i2tmwjGJYOfFW1Dn/+UhdgLmy9vlg2b+UpRKbSJTF+CNhTW2st2rbZCx+dM6A05ziPvhR
	 TfnNVbULpU19h9nrHFFWDzhWfa2y5fvWBfTz/GVBmVVUTi/siD+4djVqwWm6r5JxuiaGy
	 2T70QZuZxR3Y9IC3zvs7SrzOO/e3ads8M4jwxCCCDO3ZY3Kk9F5UprBQWljjS0iQ+FRt5
	 hd8B3u3ogFKtEjqaC7eanm35uhzk4AjbV4rC8M/OcnAnmW0LTbI6ZlCsIDWa1GZmiwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=XRNQZJBs;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691D606A604;
	Fri, 30 Oct 2026 10:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3691D606A604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=XRNQZJBs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356624; x=1824892624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DmHjgENSEM3/SBgtOokrDXU+0jtEzKN/4QNEBO3+0hw=;
  b=XRNQZJBsfJyJ8AE+yuJKE5db41ky82ak98DRuQXgPaJHdJkaJiEA7lQV
   c+zSyBzEBkgNzsc1UMMiNywxyElPsMUAmiSIUY7VeC+6IxB6HlWc1amFB
   yScOkulerA7rQ2PkeApXhHRcLQiamQuTynZw0igxRyKEUNqreRO4Kys80
   pLoZjFWtisSmPtYIgmW3n5n2VdAohfi8rOIt1QMVjVuD6FW5wnufph/r5
   405bU03NePN86y7hpPRLI1HLAZ+jW2VGb3myVZVpoQGcVC00is54U0pM/
   TxXZrLH2sovtTMu5ARTnfYyevJkaXw8BehUeeh8ScaeCRSzz+UOGqvRsY
   w==;
X-CSE-ConnectionGUID: 536e3dnJQjyPQh9pUrBmHA==
X-CSE-MsgGUID: 7gCkdxJYSqGKNdgGjOhSIw==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32449747"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:7805]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id 15856f3a-0c04-464f-a522-68f6fdd5e38b; Fri, 30 Oct 2026 10:37:00 +0000 (UTC)
X-Farcaster-Flow-ID: 15856f3a-0c04-464f-a522-68f6fdd5e38b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:00 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:36:59 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "Bjoern
 Doebel" <doebel@amazon.de>
Subject: [PATCH 6.18.y 0/3] Backport nested EPT violation GVA bit fix
Date: Fri, 30 Oct 2026 10:36:40 +0000
Message-ID: <20261030103643.573356-1-doebel@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.18.y, with its two
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

Context adjustments are noted per patch.  Based on v6.18.56, build tested
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

