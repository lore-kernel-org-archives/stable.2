Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AF41F7EC;
	Tue, 28 Jul 2026 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234484; cv=none; b=P7XGGslvmZsagUK54ZB8/LQZYBzlz+Q5RSOQhnhzC3Rr89MFPFfwL+Qpo9BVeVOxMfY90LCVo+4ir1/efXFoRxFfaUtFAHU92v5dWbjz/tX6f4HiW4LdH3czySa7QEZhSpYRoAN3OaK3xpQ0mDqA4TKBOOx8ddPS4AumK31nN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234484; c=relaxed/simple;
	bh=928YJs5Z23lnsUqkIq+IzsPbYrmuxfubjuyiC6+mggk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBJyf4Z/YKW2dZNUtQFn+soE4m8CzRPl+IQOPaHJDiS1ddJ2lE4TT+s99V7WLGRCRJUJXINcAjyQB/nDvh6SwzZVpJEkqJyaiKwC/pWLb/OSJxyO1oXuifMsgq3WC5f22bMgkqd+2914hrRpTJp+iDyqbEVIdssUzLf1yUl28FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvyM2Ga4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvyM2Ga4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785234483; x=1816770483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=928YJs5Z23lnsUqkIq+IzsPbYrmuxfubjuyiC6+mggk=;
  b=dvyM2Ga4zGw2mpCoEl2cvz3X1Pi7H+4qVD1Qtl6jnf5y/j6XTBfAd6ju
   uXAkD2KNEyiQiSZE32p+hFQOh1Q6n0tFWnKY/ytTkyJ3qNk1iJa7VAf3T
   vgxq5ImmuFTFJhcMJQhidY2m1ZG4i5r5G2fVxnQbaQSpE8nTS0RwaUVfh
   27sljQ2BmjwpH9cJDHdh0lmbKhDx0zeFFBdUxUK5uGIAiTwOmpCyHB39V
   get2mFZXq4FpVmEulEqArEBmyB4M5zuzjVhjwjFOrupkGbSr1PGKh3EDI
   4KOiBIx48AjF3ZEZqBhR5y0ZOrPnHyWK3atVEAI9s2f3qRwrfX7/S1NSi
   A==;
X-CSE-ConnectionGUID: NGyUT1aBTmy69bYrcRhMZw==
X-CSE-MsgGUID: JUDGbomgRlS1bSOP8ThA0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85682341"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85682341"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:28:02 -0700
X-CSE-ConnectionGUID: hXIkEse5S0apBxms99tnww==
X-CSE-MsgGUID: N0C/QSOYR72ZbLq0NoiT8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="297900104"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.93]) ([10.245.244.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:28:00 -0700
Message-ID: <407654ae-c3b3-4be9-9bbb-fd9526ed5b70@linux.intel.com>
Date: Tue, 28 Jul 2026 13:27:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci: bail out of setup if the controller is
 inaccessible
To: Breno Leitao <leitao@debian.org>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20260724-xhci_dead_hc-v2-1-1f8dee685ef1@debian.org>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260724-xhci_dead_hc-v2-1-1f8dee685ef1@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/26 12:38, Breno Leitao wrote:
> xhci_gen_setup() locates the operational registers using the capability
> length read from the very first register:
> 
> 	xhci->op_regs = hcd->regs +
> 		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
> 
> If the controller is dead or has dropped off the bus, that read returns
> ~0, HC_LENGTH() truncates it to 0xff, and op_regs ends up 0xff bytes
> past the page-aligned MMIO base, i.e. unaligned. The first access
> through it, xhci_halt() -> xhci_handshake() reading op_regs->status, is
> then an unaligned readl() on device memory. arm64 faults on unaligned
> device accesses, so instead of xhci_handshake() catching the all-ones
> value and returning -ENODEV, setup oopses:
> 
>    xhci-pci-renesas 0005:08:00.0: Unable to change power state from D3cold to D0, device inaccessible
>    xhci-pci-renesas 0005:08:00.0: xHCI Host Controller
>    xhci-pci-renesas 0005:08:00.0: new USB bus registered, assigned bus number 1
>    Unable to handle kernel paging request at virtual address ffff80030a770103
>      ESR = 0x0000000096000021
>      FSC = 0x21: alignment fault
>    Internal error: Oops: 0000000096000021 [#1]  SMP
>    pc : xhci_halt [xhci_hcd]
>    Call trace:
>     xhci_halt
>     xhci_gen_setup
>     xhci_pci_setup
>     usb_add_hcd
>     usb_hcd_pci_probe
>     xhci_pci_common_probe
>     xhci_pci_renesas_probe
> 
> This was hit with a Renesas uPD720201 that failed to power up ("Unable
> to change power state from D3cold to D0, device inaccessible") yet still
> reached the HCD probe path.
> 
> Read the capability register once, and if it reads back the all-ones
> value (as xhci_handshake() and xhci_reset() already test for), abort
> setup with -ENODEV before op_regs is derived from it. Reading it once
> also avoids re-reading a register that may change under a concurrent
> hot-removal.
> 
> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Thanks, added to queue

-Mathias


