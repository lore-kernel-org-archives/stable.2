Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436713;
	b=WHSE0IEhxwiXzUx7Yesnr9zssbIiFTMznFUkQ7hG6GtGPFYJkw3nydmwNkfYM3kQhWp4
	 Ie9eVIgFym08TwLPackD3guDlZegSHjpu6GHNOeAQllJfeG0+tRbBuk3BAM90f9FhQRf4
	 gApWW5qsnWiKG5actvbs6UpFcc2YsDynA4vJW2YoHFVAFn0/gJOgPDsBD3SKGG/3qz+eA
	 NwyGWn3Q56vSJ4a14nld+7VdWPq8T5LMFAz/W/SSc7FxRNzf5JVPV0nPJ14+EsWQEk6LQ
	 KHrwVOvMursJd0tiwpK3MF3+lucGSnHRCtKG8ZVqtZJM+rDFE5VFsCJzrYNuluEbktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436713;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zP/rdP6cAnm6xwOfkN9ZnCreMYEXoK89xKV+B10aH8c=;
	b=AqbFNcWSj3sGHyNG4eQTRCnk8fDgwHhcMclLrErvsK7dHxzS9mknKSQ2M28w+0CD5XzT
	 Oe0E6BFrEN/xXOwd7bi20A5WCbLPwJi7ROC/N1glO2msQRVDnBG8QPMvq7X8Xx3H1ySIj
	 RNFq5ilVH6Om61YVOKdN56NlJKUxSM9VDK+8JyJ/S25Iqn6l6qBuQp2xc/nsgZdtIQiyu
	 bqF7bMZpTnjLHGT1uxPVpZJenDy9tiOGQrbe4MauuH049p7kKRpGma8H5CQdrvJ8/I4VX
	 2SARoGG+qTvpll+uGjHILmJhen/JPRmrMKsshyNFg0IwK0n3p0I9HQflX3Pj8xyJelg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YdC5w0o2;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70510606A31A;
	Mon, 23 Nov 2026 12:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70510606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YdC5w0o2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795436712; x=1826972712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hqAosn83DjPHxx+6NwmAJxE8M8zatUgc/LZqvz8JAx4=;
  b=YdC5w0o2Jcwfp79ic/xYnZx3iaRLVU+bfnTeoVXfAM21bVyXd1QvtCSA
   Xja4OH9EACvbAZUOjXybKRtb8bOAHDexwozLKd2GOMCSDsELW6XEEMR/T
   ynhPTFbODy4zxFNdnus6nwWBz0lzxnJ8CNJXkaRstOKD5WVtWfkTQssEV
   ETy3uN7qsokJ1ghPUgwv0XOZ5/O2NpXe8cegiYd91I8f0zUSBacLJNR9O
   Gdyx8bRCdeEYwCfhGVi4//hKy3iYpWd05iYGpOwZbx28DZ6+H09v128/8
   xg4D8VEb7bh8bJlXhK2hPKDTnPgIigu9oCYJkO+lPwBuhIm9gVg0mWcyU
   w==;
X-CSE-ConnectionGUID: FTJ9nCFFREWU1mDHmqZwRw==
X-CSE-MsgGUID: WJpQMw1RQb2JRaqMR2+nLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4127843"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4127843"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:11 -0800
X-CSE-ConnectionGUID: Dg9BzfPwSCqaLFRAmsmGmA==
X-CSE-MsgGUID: Kz9etXi9RiCl4tLIjip+hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11481356"
Received: from emr-371.sh.intel.com ([10.112.106.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 04:25:10 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Yanx L Liu <yanx.l.liu@intel.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>
Subject: [PATCH 6.18.y 0/4] KVM: x86: Fix DR6.BLD regression in guests
Date: Mon, 23 Nov 2026 20:14:23 +0800
Message-ID: <20261123121427.2803358-1-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

Hi,

a58917a271cb ("KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when
delivering #DB payload"), upstream 719a1d58bf43, went into 6.18.61
without the rest of its upstream series. Since then kvm-unit-tests
x86/debug fails on hosts with Bus Lock Detect when the guest CPU model
doesn't have it, e.g. the default qemu64:

  FAIL: Wanted #DB on 0x400da7 w/ DR6 = 0xffff0ff4, got 1 #DBs, addr[0] = 0x400da7, DR6 = 0xffff07f4
  ...
  SUMMARY: 25 tests, 17 unexpected failures

Once KVM stops intercepting DR accesses, the guest's write of 0 to DR6
goes to hardware and clears BLD. sync_dirty_debug_regs() copies that into
vcpu->arch.dr6, and since a58917a271cb the #DB payload path no longer
sets BLD back, so the guest sees it cleared.

Later patches in the same series fix this upstream (v7.4-rc1). This
backports those two fixes and the two cleanups they depend on. Patch 3
needed a small change: 6.18 has no arch/x86/kvm/regs.h, so the new
declaration goes in asm/kvm_host.h.

Tested on an Intel host with bus_lock_detect with a 6.18.64-based kernel
whose DR6 handling matches v6.18.64: x86/debug goes from 17 failures to
all 25 passing.

7.3.y, 6.12.y, 6.6.y and 6.1.y picked up the same commit (in 7.3.2,
6.12.117, 6.6.163 and 6.1.193) and probably need these too. I haven't
tested those, but can send backports if wanted.

Thanks,
Baoli

Sean Christopherson (4):
  KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
  KVM: Return an "unsigned long", not "u64" for the fixed-1 DR6 bits
  KVM: x86: Force fixed-1 bits in DR6 after synchronizing with hardware
  KVM: x86: Set guest's fixed-1 DR6 bits when delivering #DB payload

 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/regs.c             | 7 ++++---
 arch/x86/kvm/x86.c              | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.43.0

