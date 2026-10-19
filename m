Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1A4F0534;
	Mon, 19 Oct 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414078; cv=none; b=hn9Qez/BscYCpV6ELoiVQnGNSBzRuF8rfAJFJ10bhCq5lJqiUu96999Yc5vPUGvEn5H3wbIK4+wgkSTgq7tutrun/ALg/BoLq9ygo+bGJCUnB2PifEXfIlgMvMZ5vFvCgJeG6OWgVGGSitnuNgVhfoazi8SdTnzboXccai5J81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414078; c=relaxed/simple;
	bh=T8TOdyqs3cCrF/nGVma3SBbHxWF77CM8ZvrXReIx5Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVGxMpLor0yKNx4VhJSyy+SIgvaRnlFm/tcBZ5Rj8eZHDDJBtO55EIbqAwtpeGNzZeafb1GycsUzIlj/b1B4sCmUN9GpvHcBUJBa+MUEss0M/u4RHIURzIRYbPsk+3PMBCHCeNiwxKXwkPNcQoAv/Qtlmi5wJqOvRs4biw424R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiiADlfH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiiADlfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792414075; x=1823950075;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T8TOdyqs3cCrF/nGVma3SBbHxWF77CM8ZvrXReIx5Gs=;
  b=XiiADlfH2y7VFiQPoKmFxChPBhi7+9Iht2ohaeTQGfK8ASF+5NLYP1Mq
   bYK6FSA1xHjmd+v6RXAQ2PTXIlNNUU+X1Cws9EByst/wjaDMVRe/VrqzQ
   JJAtFqYJ4qO2zLgYpgs32SuQUz8xwql4TlK83JJPFC7oQyzFngJdMObC0
   1/1VUwX3dfys5Ki1M20G9CJ5BY54lVqJNjC/VckoAj4vfz0qBR8in8S3f
   CO0yq+H1eaCiyNPMtuX+t0BVqkcrxgy3LUyd5c1Zb7gqSp/MGgmWKxkxF
   kCPUXrmVymB06il/G6DB9FCKo34ekF+MZUTi3Jv5RoUGT2O8x8ngu4K91
   A==;
X-CSE-ConnectionGUID: Qi+MtPC/QAmwMw1IDWiyIg==
X-CSE-MsgGUID: n0lllosdSwmjwW73WXo1wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="994042"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="994042"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 05:47:53 -0700
X-CSE-ConnectionGUID: q/B1HGdoTfy3jefbYjA7Mw==
X-CSE-MsgGUID: tXCmjySFRvq6bCNDcgqpKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2523922"
Received: from nneronin-mobl1.ger.corp.intel.com (HELO [10.245.113.10]) ([10.245.113.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 05:47:51 -0700
Message-ID: <e952e037-5be8-49c0-b0fe-bcf1bda77bdc@linux.intel.com>
Date: Mon, 19 Oct 2026 15:47:31 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: fix EP0 context leak on virt device allocation
 failure
To: Anfernee Cao <anferneemelokc5@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261017111114.1135-1-anferneemelokc5@gmail.com>
Content-Language: en-US
From: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
In-Reply-To: <20261017111114.1135-1-anferneemelokc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/10/2026 14.11, Anfernee Cao wrote:
> When XHCI_EP_LIMIT_QUIRK is set, xhci_alloc_dev() reserves an endpoint
> context for the default control endpoint before allocating the virt
> device:
> 
> 	ret = xhci_reserve_host_control_ep_resources(xhci);
> 	...
> 	if (!xhci_alloc_virt_device(xhci, slot_id, udev, GFP_NOIO))
> 		goto disable_slot;
> 
> The reservation is normally released by xhci_handle_cmd_disable_slot(),
> which calls xhci_free_device_endpoint_resources() for the virt device
> found at xhci->devs[slot_id].  xhci_alloc_virt_device() does not install
> the virt device when it fails, so the Disable Slot completion handler
> finds an empty slot, returns early, and the reserved context is never
> released.
> 
> Each failure leaks one endpoint context.  Once num_active_eps reaches
> limit_active_eps, every new device is rejected with "Not enough host
> resources" and cannot be enumerated.
> 
> Fix this by releasing the reservation when xhci_alloc_virt_device()
> fails.
> 
> Fixes: 2cf95c18d506 ("Intel xhci: Limit number of active endpoints to 64.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
> ---
>  drivers/usb/host/xhci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 7f7babe9d681..8b9a6f88cca5 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4278,6 +4278,15 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  	 */
>  	if (!xhci_alloc_virt_device(xhci, slot_id, udev, GFP_NOIO)) {
>  		xhci_warn(xhci, "Could not allocate xHCI USB device data structures\n");
> +		/*
> +		 * The virt device was not installed, so the Disable Slot
> +		 * completion handler cannot drop the EP0 context reservation.
> +		 */
> +		if (xhci->quirks & XHCI_EP_LIMIT_QUIRK) {
> +			spin_lock_irqsave(&xhci->lock, flags);
> +			xhci->num_active_eps--;
> +			spin_unlock_irqrestore(&xhci->lock, flags);
> +		}
>  		goto disable_slot;
>  	}
>  	vdev = xhci->devs[slot_id];

Hi,

Thanks for working on this. I believe this is the same issue addressed in this patch:

https://lore.kernel.org/linux-usb/20261006152427.3735383-3-niklas.neronin@linux.intel.com/

Thanks,
Niklas
