Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBD4A3D3B;
	Thu, 10 Sep 2026 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047362; cv=none; b=a98XPbAkEjEXrE+ZaQxghEVnAKjsKdliJWyZK/gUGgHCNh7khViffEQIw4KQlV+I2uAVJfRx5oHno9UucJjGkhEHDHrYUowbhQDQ6AAHnJ2MIxLChbAQz8ArGSHxJ7JJ9ipNbR9hJVE2VcHdUFrXF+z1nIm2YsLty5dU/SfLWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047362; c=relaxed/simple;
	bh=1h0TzmWhWdjCSxWri2fXQes5Q55yMqXFM6zfRX64d0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4a0FE8xEZKld2epwW92BbfmEYZfdEsQcl3wcI1kTuxRrQIIdCbiuHl7JF3/te1pQxUGfzzhpVwXdth/otCKRjWQDVLthqljvwLCACqyHgr/UGITritPBB0JyknSXNCKmioPmmHLIfBCnaDeRhgsSGTYAw9YGxDXZB9tF/Pryd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hzxz8TM2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hzxz8TM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789047361; x=1820583361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1h0TzmWhWdjCSxWri2fXQes5Q55yMqXFM6zfRX64d0U=;
  b=Hzxz8TM21mNfPB6s5UBgR3aDCvC7j8sg0HiEIMGoWCQPk3fkqFkXfOzq
   g05ul0BSu4s7YGg4iwAfBjbcDmbr0L18a4EjSJEAEES8lguUqLtIXUz7H
   h6cGAo6HyT1d245o65LEBaoOsnl4dytZxontO+m14ntRDQ5LJdYFzYq1F
   darPtrzg2Cri26mg9dRYHg0MQphKAMm6XHBilUgjlnnYefFExjPXsBo4R
   8GqYPKzgpQ40hdAidk8lmzpNBCLY3xCqySyNNFL2SvlpvUww88C2uO2xk
   i2ya3JaLtS9kwQcnHHcnTNRyFKTfPwbXnBByjV/0l4XQEXhknfnCAYVTr
   A==;
X-CSE-ConnectionGUID: 6b9iZUNmRJONm4Q6I2Zftg==
X-CSE-MsgGUID: zAk5iyC2T5G0V8vbU4lcjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99828320"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="99828320"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 06:36:00 -0700
X-CSE-ConnectionGUID: UGJ+kIffTb+ah9vSOaGBSw==
X-CSE-MsgGUID: ZzS7AwbzTCOBU8cTxvqn3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="295132299"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.245.216]) ([10.245.245.216])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 06:35:58 -0700
Message-ID: <cb0ffb2a-a102-4653-8362-f846b514bce0@linux.intel.com>
Date: Thu, 10 Sep 2026 16:35:55 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: pci-quirks: abort xHCI handoff if MMIO is
 inaccessible
To: Haowen Bai <calvin.bai@ugreen.com>, mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <A8558181A93455E3+20260906162614.26940-1-calvin.bai@ugreen.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <A8558181A93455E3+20260906162614.26940-1-calvin.bai@ugreen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/26 19:26, Haowen Bai wrote:
> The xHCI early handoff quirk polls the BIOS ownership, CNR, and HALT bits
> with readl_poll_timeout_atomic(). Unlike xhci_handshake(), handshake()
> does not treat an all-ones read as an inaccessible controller.
> 
> If the controller becomes inaccessible, readl() can return U32_MAX. The CNR
> bit then never clears, and the atomic poll keeps retrying. The atomic poll
> budget is decremented using the requested delay and loop iterations, but
> not the time spent in readl(). Slow failed MMIO reads can therefore keep
> the PCI hotplug thread spinning far beyond the nominal timeout and trigger
> a soft lockup. The 26-second value in the first warning is the watchdog
> threshold, not the handshake timeout; repeated warnings showed the thread
> still stuck up to 260 seconds before a controlled reboot, leaving the
> system unavailable to normal management. Comparing the watchdog timestamps
> with the RBP loop counter in the dumps (about 1,372 iterations in 26 s and
> 15,638 in 260 s) implies roughly 16-19 ms per polling iteration, despite
> configured 10 us delay; these values are inferred, not direct measurements
> of an individual readl().
> 
> Return -ENODEV when the polled register reads U32_MAX and stop the handoff
> before issuing further accesses. This prevents an inaccessible xHCI from
> keeping the PCI hotplug thread busy and making the system unavailable. An
> eGPU may still fail to enumerate, but that failure must remain controlled
> rather than causing a kernel Soft Lockup and taking down SSH or desktop
> management. The existing timeout behavior for non-all-ones reads is
> preserved, matching xhci_handshake().
> 
> A Thunderbolt-attached AMD Radeon Pro W5700 in a Razer Core X enclosure
> reproduced this on an x86_64 UGREEN DXP8800 Plus with an Intel Core
> i5-1235U. The GPU's xHCI function 0000:06:00.2 (1002:7316) triggered
> the soft lockup in irq/123-pciehp; the register dump contained
> RAX=U32_MAX:
> 
>    watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [irq/123-pciehp:139]
>    RIP: 0010:quirk_usb_early_handoff+0x552/0x7e0
>    register state: RAX=00000000ffffffff
> 
> The call trace was:
> 
>    pci_do_fixups
>    pci_bus_add_device
>    pci_bus_add_devices
>    pciehp_configure_device
>    pciehp_handle_presence_or_link_change
>    pciehp_ist
>    irq_thread_fn
> 
> The failure reproduced on two hot-plug attempts and did not occur when the
> enclosure was connected before boot.
> 
> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haowen Bai <calvin.bai@ugreen.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
