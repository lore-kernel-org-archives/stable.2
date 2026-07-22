Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD73D954E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754280; cv=none; b=iLn/rLzwHYVdh6bTpLBIjATMo8JGjJXDWe0aGmBuDKYNuzkofMq+anrkmZ7ehPSl+9da2Itpomj9UD0xGWj3NscNwGU/ADU93PSHjvtpRNEsoZpq3pLhiY4y+Vq6qdf6TiO3OSx/e4AUfIOrCcgl+uavkyqPv/i1w0RIwf9GCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754280; c=relaxed/simple;
	bh=CWkXh/mVTEoWKc0N911hWr25ky7AI3k4TRB9BGNu6VA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNoxn+8x5Rzxh6BYzSPEMsBRmk59o5/iAHiiMkqn+07BTr09F6uUVigCmSPm/tZsYpfEc8E2A8QU1lhZ53HLCXjyLfje6texRU0bGUXcGzYb5WgKUVW1DBCJemDus0MNmRHTG/RspuuHjZA0h5Ud0xJ2xyZxZB9denyb+YQ+HvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY3g22bN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY3g22bN"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so11449965f8f.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784754277; x=1785359077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=viuWpyRyias3SaBiIZU8Wm8wddtNAMSTHpyQzh3dLJc=;
        b=lY3g22bNIgpVsY8c0cTvHLAmH7IqrmIONynVEhrs4ngSwPhc6e602mluRE7Z/7cvHU
         QtpcGjVYe/z/uUaOe2N5gyux5MWm9+iw/6WNAukHPjYZ0Eo4dle+88mQJ0sD3e/GMUB/
         UIgmWljqjL6FUywUdLtLh/xmuRsIbDVbTEuyncPWWkfGFA9QkbDJ4DP5iE4HihgWzPL3
         Xt4LpRcg+7yfbfiFgh/5mnVX64a9LXCqzd5Uuley8gDaT3GaAvmhUB2nYrUVPPfVpyfZ
         NuxvCjt/PVLHE+qevD/YZIE9uYQj8abNAJsArsr1AbjmZokg1YAjhgtXfxY4x+KidF3h
         7n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754277; x=1785359077;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viuWpyRyias3SaBiIZU8Wm8wddtNAMSTHpyQzh3dLJc=;
        b=PKP8H7y5jCiMBhD/78U0mqVwsJO7ldVXnx6P7XIFszuadI+WEiMOZdPBVfiCm9gViX
         CJkj+7qE+4G575OktW9hosULx85BCGLqoueKOHRpkGqJRF9ZVa0m1nxJZsiF4DsAgHGv
         eIEy+IWRgUEiDiB3jPYXExNvtRvcgAonElX0R5Zbqd7B0uXfXa0VJBpQreuNnBYelWVs
         Ftkt84F3q18PBu7bh9btl/ATr0BzJgpHy7QONbVO9ukMdjBjcTaAiatlK7ID7ODU8QW2
         gt0KDLVxljrAEVDrMfB3yeZ0pukmFgwRSFud9fDTW0YOY2EVgMGhTdtKPlSk+QoKZ0XX
         Ou2g==
X-Forwarded-Encrypted: i=1; AHgh+RqrSEg2XpmbbotFIVxPao3twuPjti/gNW+tZA3kXuWx8TM2KjL7SqXZuocQoCBtzNRf2WSaNKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXs56X9WfqboJpHfuM+wMlPnQhGsw7HWILnDo7YF/d3uVlIkh
	vIsjMxfXDPhxdpDdIdR1diPImB3TwDToXjtTTahK/DStI8VxW/2RgZ9x
X-Gm-Gg: AR+sD130QT9+fyA57GzLFwWGT0DeiPm49KcD9AmUo6N4xldP3dbPKxTmdrAmHgLH5f5
	c5QlvEbN1TjDUOkT+inx1d7Eh7ZJvAcJoG0qJ0I1FylxDy+552Cs+zKgvyCg25MmsRPHcBJyURy
	EfPX6bT3wPd6N2+DQzOLbGJUv0G8cPG7Yp2CBBsJzhX8IulInHvf9G7qNnckZ7JVR+eQ590zueE
	Cxyu2B2O9a4tI3YaKxdFjzzrJn8RJcnUzjMgHYlm+0e2q+yuaFdOEVQAdQvpa+NWF/ghenIDjvA
	s9pTRtK17WuFJ/Nt58J8OjzwpWORLjQmgZYX4dHUigU2h2gAe3wN4DCX2HJoPQJfyJ1IeND0aMt
	IKHAvBhj8cSuUwAGshz0Qj+aj37uMWwXioxR5m25Qf9txwhegJeA+mS7ZKsTE75qGFBgh3w4MrZ
	CtleUWW5haR7zTyewGLommNg==
X-Received: by 2002:a05:6000:481e:b0:478:3f4b:348b with SMTP id ffacd0b85a97d-47f8d710fe7mr546018f8f.7.1784754277421;
        Wed, 22 Jul 2026 14:04:37 -0700 (PDT)
Received: from foxbook (bey56.neoplus.adsl.tpnet.pl. [83.28.36.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c631fdsm8934817f8f.28.2026.07.22.14.04.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Jul 2026 14:04:36 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:04:30 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: bail out of setup if the controller is
 inaccessible
Message-ID: <20260722230430.2256c8a4.michal.pecio@gmail.com>
In-Reply-To: <20260722-xhci_dead_hc-v1-1-78f55597524b@debian.org>
References: <20260722-xhci_dead_hc-v1-1-78f55597524b@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 04:27:36 -0700, Breno Leitao wrote:
> xhci_gen_setup() locates the operational registers using the capability
> length read from the very first register:
> 
> 	xhci->op_regs = hcd->regs +
> 		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
> 
> If the controller is dead or has dropped off the bus, that read returns
> ~0, as I saw in practice.
> 
> The first access through it, xhci_halt() -> xhci_handshake() reading
> op_regs->status,  unaligned readl() on device memory. arm64
> faults on unaligned device accesses, so instead of xhci_handshake()
> catching the all-ones value and returning -ENODEV, setup oopses:

And if it didn't oops then it would read some other register, and later
write it, and maybe do stupid things. At least HC_LENGTH macro
truncates ~0 to 255, so the other register would most likely still
belong to this xHCI.

>   xhci-pci-renesas 0005:08:00.0: Unable to change power state from D3cold to D0, device inaccessible
>   xhci-pci-renesas 0005:08:00.0: xHCI Host Controller
>   xhci-pci-renesas 0005:08:00.0: new USB bus registered, assigned bus number 1
>   Unable to handle kernel paging request at virtual address ffff80030a770103
>     ESR = 0x0000000096000021
>     FSC = 0x21: alignment fault
>   Internal error: Oops: 0000000096000021 [#1]  SMP
>   pc : xhci_halt [xhci_hcd]
>   Call trace:
>    xhci_halt
>    xhci_gen_setup
>    xhci_pci_setup
>    usb_add_hcd
>    usb_hcd_pci_probe
>    xhci_pci_common_prob
>    xhci_pci_renesas_probe
> 
> This was hit with a Renesas uPD720201 that failed to power up ("Unable
> to change power state from D3cold to D0, device inaccessible") yet still
> reached the HCD probe path.

Seems unproductive, I wonder if it's somehow intentional or a PCI bug.
You would need to ask linux-pci about it.

> Detect the removed controller the way xhci_handshake() and xhci_reset()
> already do, by testing the register for the all-ones value, and abort
> setup with -ENODEV before op_regs is derived from it.
> 
> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/usb/host/xhci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 091c82ca8ee29..4e8a87df91d9d 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5453,6 +5453,10 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>  	mutex_init(&xhci->mutex);
>  	xhci->main_hcd = hcd;
>  	xhci->cap_regs = hcd->regs;
> +	if (readl(&xhci->cap_regs->hc_capbase) == U32_MAX) {
> +		xhci_warn(xhci, "Host controller not accessible, removed?\n");
> +		return -ENODEV;
> +	}

Good idea, but there is one more case to potentially worry about: hot
removal. In theory, you could read a valid value here and then U32_MAX
below and crash the same as before.

It would be more robust (and efficient) to read the register once to
some tmp variable, validate it and then use that to set xhci->op_regs.

>  	xhci->op_regs = hcd->regs +
>  		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
>  	xhci->run_regs = hcd->regs +
>  		(readl(&xhci->cap_regs->run_regs_off) & RTSOFF_MASK);

One may wonder if run_regs shouldn't have similar check. However, if
the chip is hot removed here after successfully reading hc_capbase,
xhci_halt() will not crash and return -ENODEV before anyone uses the
bogus run_regs pointer. So there is no urgent problem here, I think.

Regards,
Michal
