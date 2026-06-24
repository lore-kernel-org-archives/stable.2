Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9234676F
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311910; cv=none; b=LTweBE9XhMnUdlw8AsasePSVQKExMiC6sizvFMUtiThsj/dLQtDceHnswAjcg1H5247o7WqM7FYk7N4Zyw55p8iO+aXaHmlAZ1GTpZYZtKjENoHGHjvueDIu66NLQgnpLAGws3HlVnXWqvNIvdytqFaORMcz1ATuhM3gYEkiKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311910; c=relaxed/simple;
	bh=Ag2dMLJyxsxo2yKyBiVG3MrdVzSXXfqSu4U59syt9qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr4+oXtnWkH34/rxT5UEXjwtvttYkA2SEJIr0b7xbhSq2Bc3ZjABa0sVYhWlqXM0ywoKH7zg7Opuif2xrqTGmNgh9Sex3zuSLt3aerhnSn3VppGg/y8FbVg2+BwyifpZhrySS7RhM8KaaOHRTOlumxCTKgNu5jHJ2Q80KmPqZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=lNdpJaW1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="lNdpJaW1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92213351918so113434885a.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782311908; x=1782916708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4TwTbCnVZ8bBjyLyd7NRPMpWOFSAYz6ZPnesPypTyM=;
        b=lNdpJaW17qPMoH2yUAMnqM8j5XpcPExFLbf+hhzalZihNNYvpm0EzeafdSjEpDDfqf
         L4b0TKHbbHnCCCxSykgNT67gv2ENUbipEx2f599phE3Oilw9BELJE2VCF7Wjs+VjYMKP
         bpsUOTHWGelmvINcBqFjniRmo+iH3XlZU2v5rhaImUm6k8oXNiLEiDv839GkUZDXhcJw
         9Yf04yaDRX125DQ29z9MN3CrpZfcnVTJMHWyh+wOrHXgc43LmQ2vbr/kwC/EleBely0F
         3vo8QWr/EasLXRCTqI7GOgVOm9IPLIbR9VGHIYV9Pb6oHUtuUU7BI7x/pUT0dX81gWOu
         NPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311908; x=1782916708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4TwTbCnVZ8bBjyLyd7NRPMpWOFSAYz6ZPnesPypTyM=;
        b=qujPBsVb8x+bQIqzHkVEiy7J+qI+dpKfTzePbEmra5QxuqlXiSEqO7JmlZhkwd/Xb7
         kUYZg1psHuJy4stQWvsXLzEDw4hQrUM7WVUqXwUgMWKdMklkeS/ZAwr35om5NAOEofJZ
         m5ZEp7y8LaJATx+hTd7SUwi4Ef/lFFnNuR+G+FFhqmfeU/YPdQQGX3Pu5NE09CK2INHe
         E03BiCTAl5fFTW45tyGyOMZtmB2yEpXsL2cCDHII+SSHkj1gRRMroWgWwF9fEqg/Xdyp
         VhmOF62KHCwQLp4qOCrDK5sOokF1XU743XXauJDzCFN/4m9H0A5DHe0h/tE79ZOKb6bp
         4IWg==
X-Forwarded-Encrypted: i=1; AFNElJ9pNuUsxC3SzqQ9Unw+zZv408CUxJyAJ7zoT/lzIZBqpTEUivfoeb4lWXj5JLmzZO0D+HgCcbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/74QG4g5kDpRuCuEoeKDldHp/vdBRNhYSqqSLKiwEi48aTtr5
	gu8QgoisW9p+7kBsZGACtLpopI7BuuasJcVzl6jq4ayOM9JTDdzYuhZEaqsSmgGm/w==
X-Gm-Gg: AfdE7cmdKj4KJCmT948uJepAlXIz86MrMtxXB76hn+jzCIoQxFkv1ox4LiiHhpSCx1U
	VYULgcyvyxpPvty5gQpG84EHOkYIFY2EshKFSJDUFsQSeYbdPrRNFK9MwPCGZ+Ux08YNz//ZVp3
	zeI2eifXu+IK39tIb4N5gnIbYgLubIet7Ob2An4iqvoIWs+Fj61ZsDKBpnZWjovJxEbDlXai67A
	oXdyqoh29PdIDCjZkmpnlJGKg8NYc1hXP3tqd1xhbL5l8WxNCtAcXCh01tnlgW9wPmeWgBSIa3w
	TTV85Y4qy3BUKQICPg3UWQKtd9iItILV+OsjL3aelbgjWRb0fduPFao0dXgWJBxOCxtfAb6vY4J
	m9Q/zTQ/KP6UONJ844GvOFLKrPpZ+fWBz2q/XiLv43z3YVPjXL+qVyvxDGIAlVDBEhGtTI8S44Z
	zWhAOyZNCYarEJ8vw+AUTexiY+TsZf5hVJ
X-Received: by 2002:a05:620a:2950:b0:911:9a7a:8076 with SMTP id af79cd13be357-9277beeeb53mr668661585a.8.1782311907591;
        Wed, 24 Jun 2026 07:38:27 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bd89sm569510685a.45.2026.06.24.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:38:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:38:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jimmy Hu <hhhuuu@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: udc: Fix use-after-free in
 gadget_match_driver
Message-ID: <079877da-315a-4ed6-b344-35d9954a54cc@rowland.harvard.edu>
References: <20260624030154.393004-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624030154.393004-1-hhhuuu@google.com>

On Wed, Jun 24, 2026 at 11:01:54AM +0800, Jimmy Hu wrote:
> The udc structure acts as the management structure for the gadget,
> but their lifecycles are decoupled. A race condition exists where
> usb_del_gadget() frees the udc memory (e.g., via mode-switch work)
> while gadget_match_driver() concurrently accesses the freed udc memory
> (e.g., via configfs), causing a Use-After-Free (UAF) that triggers a
> NULL pointer dereference when the freed memory is zeroed:
> 
> [39430.908615][ T1171] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [39430.911397][ T1171] pc : __pi_strcmp+0x20/0x140
> [39430.911441][ T1171] lr : gadget_match_driver+0x34/0x60
> ...
> [39430.911890][ T1171]  usb_gadget_register_driver_owner+0x50/0xf8
> [39430.911910][ T1171]  gadget_dev_desc_UDC_store+0xf4/0x140
> [39430.931308][ T1171]  configfs_write_iter+0xec/0x134
> 
> [39430.957058][ T1171] Workqueue: events_freezable __dwc3_set_mode
> [39430.957287][ T1171]  dwc3_gadget_exit+0x34/0x8c
> [39430.957304][ T1171]  __dwc3_set_mode+0xc0/0x664
> 
> Fix this by ensuring the udc structure remains allocated during the
> match. To achieve this, introduce a new usb_gadget_release() routine
> to the core. When the gadget is added, usb_add_gadget() stores the
> gadget's release routine in the udc structure and takes a reference
> to the udc. When the gadget is released, usb_gadget_release() drops
> the reference to the udc and then calls the gadget's release routine.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---

This is basically right, but there are a few small issues noted below...

> V1 -> V2: Rework the fix using a new release routine in the core.
> 
> v1: https://lore.kernel.org/all/20260526070635.839701-1-hhhuuu@google.com/
> 
>  drivers/usb/gadget/udc/core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 60340ff9edbf..f8ce8694c101 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -31,8 +31,9 @@ static const struct bus_type gadget_bus_type;
>  /**
>   * struct usb_udc - describes one usb device controller
>   * @driver: the gadget driver pointer. For use by the class code
> - * @dev: the child device to the actual controller
>   * @gadget: the gadget. For use by the class code
> + * @gadget_release: the gadget's release routine
> + * @dev: the child device to the actual controller
>   * @list: for use by the udc class driver
>   * @vbus: for udcs who care about vbus status, this value is real vbus status;
>   * for udcs who do not care about vbus status, this value is always true
> @@ -53,6 +54,7 @@ static const struct bus_type gadget_bus_type;
>  struct usb_udc {
>  	struct usb_gadget_driver	*driver;
>  	struct usb_gadget		*gadget;
> +	void					(*gadget_release)(struct device *dev);

What happened to the column alignment here?

>  	struct device			dev;
>  	struct list_head		list;
>  	bool				vbus;
> @@ -1362,6 +1364,18 @@ static void usb_udc_nop_release(struct device *dev)
>  	dev_vdbg(dev, "%s\n", __func__);
>  }
>  
> +static void usb_gadget_release(struct device *dev)
> +{
> +	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
> +	struct usb_udc *udc = gadget->udc;
> +	/* Cache the gadget's release routine to prevent UAF */
> +	void (*release)(struct device *dev) = udc->gadget_release;
> +
> +	put_device(&udc->dev);
> +	if (release)
> +		release(dev);

I don't think the test is needed.  Even if the release function pointer 
was given as NULL when usb_initialize_gadget() was called, the value 
stored in gadget->dev.release would be usb_udc_nop_release(), not NULL.

(Come to mention it, that's a really dumb name -- it should be called 
usb_gadget_nop_release() because it's a release function for a 
usb_gadget, not for a usb_udc.)

> +}
> +
>  /**
>   * usb_initialize_gadget - initialize a gadget and its embedded struct device
>   * @parent: the parent device to this udc. Usually the controller driver's
> @@ -1418,6 +1432,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
>  	mutex_init(&udc->connect_lock);
>  
>  	udc->started = false;
> +	udc->gadget_release = gadget->dev.release;
> +	gadget->dev.release = usb_gadget_release;
> +	get_device(&udc->dev);

What this is doing -- the whole scheme you are now implementing -- is 
sufficiently unconventional that it deserves a comment explaining the 
situation.  That is, saying why we need to take a reference to the udc 
and why we therefore need to override the gadget's release routine 
(i.e., to drop the udc reference).

>  
>  	mutex_lock(&udc_lock);
>  	list_add_tail(&udc->list, &udc_list);
> @@ -1462,6 +1479,8 @@ int usb_add_gadget(struct usb_gadget *gadget)
>  	mutex_lock(&udc_lock);
>  	list_del(&udc->list);
>  	mutex_unlock(&udc_lock);
> +	gadget->dev.release = udc->gadget_release;
> +	put_device(&udc->dev);

These two lines don't seem to be needed; usb_gadget_release() will take 
care of this for you when it runs.

I suppose you could argue that usb_gadget_release() might never be 
called if the gadget was statically allocated by a modular driver.  In 
that case the udc structure would be leaked.  So if you want to keep 
these lines here, that's okay -- provided you add a comment explaining 
why.

Alan Stern

>   err_put_udc:
>  	put_device(&udc->dev);
> 
> base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
