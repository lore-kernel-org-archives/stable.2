Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8384DE731;
	Mon, 19 Oct 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414774; cv=none; b=azg23YivcEG6y3NLPROIRfgM1c44qwnQdY0F7TxE8Faek0SG3XA7mO/wkCIkwhkJOeQT88LXaIscr38hZQyJWXTgz+yhETgZMumIXIXWybDzeGwT0ac1mWlOvX9FKePTLaKljcFk4YZCjrylDhI/E0vcGCSuru/jrCH/eZQLD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414774; c=relaxed/simple;
	bh=/O/IZ6jeYkwVNlBRQZe+YCt80JcWyH19FfeWPmk/BhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5ndfEOjYpa6Ca9Y3nxK4xOzTEVgktQ/x/OK4IxdibNF9SKcH9NkSJo04VIpjc6pI45uVPp0r5A+YYew3jgn4/+mNf+3I1CFSIPEeVTFAesFQHPE0qV3EolEYcroYt4+TvuftJQI6RbZdfkf9mjoQRqW37gaFXEruKVXnR755PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hg7xatRv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hg7xatRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792414773; x=1823950773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/O/IZ6jeYkwVNlBRQZe+YCt80JcWyH19FfeWPmk/BhU=;
  b=hg7xatRvSprGp3zrnXY0Nt+sPRMVMjKW5myYVNjEyL40gAo1MZf2gQbU
   csmi6Hkw/56M+Xgf6bEV4RKDIEewNE5FRLIyhoVgFrLzg8G7ULC2/KxBx
   PFjIPDbUffUTpPtCXhYA1AuQIalmI1DGDcmL0LiMLNWFXLdueiz9OTDlt
   wQyCKHX5IDZA28rDaiuUHo3hLXhdK8Rv1f3JEeXC2ZdTgYslXn+DTAoY2
   YZro2VNb6EOyu73ETGQ9igGHktUkiZGPqjX+yTH5gjK9hwz2xohhpj65Y
   yy8rr6swPyD+WhLrcB+0rsm2ZwFN0h9hjiflqItcqbZLHNu8yhfDBTOMj
   w==;
X-CSE-ConnectionGUID: R+FXD3yEQfuK4P04DaZXfQ==
X-CSE-MsgGUID: y/pDUeU4QouyK1fkbLAnlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="981126"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="981126"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 05:59:32 -0700
X-CSE-ConnectionGUID: C+hhxvkJQNCNH16oITH1WQ==
X-CSE-MsgGUID: +48RKeNsQQmP901awQUj0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2410369"
Received: from nneronin-mobl1.ger.corp.intel.com (HELO [10.245.113.10]) ([10.245.113.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 05:59:29 -0700
Message-ID: <80a71702-f2aa-47ce-a1e9-15d6884270ce@linux.intel.com>
Date: Mon, 19 Oct 2026 15:59:26 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: disable the correct slot on alloc_dev failure
To: raoxu <raoxu@uniontech.com>, mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <6C94F1F35FF16E76+20260806084909.2959131-1-raoxu@uniontech.com>
Content-Language: en-US
From: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
In-Reply-To: <6C94F1F35FF16E76+20260806084909.2959131-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/08/2026 11.49, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> xhci_alloc_dev() stores the Slot ID returned by the Enable Slot command
> in the local slot_id variable.  udev->slot_id is updated only after
> xhci_alloc_virt_device() succeeds.
> 
> If endpoint resource reservation or virtual device allocation fails
> before that update, the error path passes udev->slot_id to
> xhci_disable_and_free_slot().  During initial enumeration this is slot 0.
> When reallocating a device whose virtual device is missing or belongs to
> another usb_device, udev->slot_id may contain a stale Slot ID.
> The newly enabled slot can therefore remain active, or the wrong slot can
> be disabled.
> 
> Pass slot_id, which identifies the slot enabled by this invocation.
> xhci_disable_and_free_slot() already handles a missing xhci->devs entry.
> 
> Fixes: 3ffbba9511b4 ("USB: xhci: Allocate and address USB devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/usb/host/xhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 091c82ca8ee2..dd8c12380e0c 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4298,7 +4298,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  	return 1;
> 
>  disable_slot:
> -	xhci_disable_and_free_slot(xhci, udev->slot_id);
> +	xhci_disable_and_free_slot(xhci, slot_id);
> 
>  	return 0;
>  }
> --
> 2.50.1

Reviewed-by: Niklas Neronin <niklas.neronin@linux.intel.com>

Thanks,
Niklas

