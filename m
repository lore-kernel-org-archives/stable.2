Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884D3E1CFF
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403714; cv=none; b=kVYXWAY8HfK1p7fGyDCXvR6X7k+KDN77I2iP33BxRjyrs33oocJcrTUT6dtKqGIGotcvnKuJ7woPQS64+zjH7l9jX9RlJUEFFkv0PtT6C9bhONRxHF9kNJ/2aOz9hO7orfcbQJWeS0E4b52FAHWYoFZka5WJUb3mynWmao0Jhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403714; c=relaxed/simple;
	bh=txA3luw49KQYaD3e0kkYooetbGz2U80FDkOLBGwVA5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D85IhreSsffHK3NCrwYZP0x/vRw5OphsVS5iVzdPj2EL1RnBiOKhYTDOJ5FE0jnDZ6dqMZ5E3VpBVc79I8NJsOExhci0R9JjQ8jFBrkWfk9pgtIFy+kYw+K5ewu4RKIvm27cGHovPiAfdNN9u/wp4YbZv2BSpM91FPgHqQjgl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BzZsPfVd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BzZsPfVd"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-922ade88d0aso7213185a.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782403711; x=1783008511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug4SbaeJ/1EYKpxKC0dJskWinTAS7LmFXgKf0w7V/S4=;
        b=BzZsPfVda2GFeJl0UtWa2juzVDwnwSa9vyvdf3klmEMIy5vQ02QmOu2XQ2KB4XL4VS
         Poc9XgzmVwSNdXD3WeWvUy8Z2EaOovXb5yleDpvaUIjpW/JdFBHz1JCyqDp9BxwN0VD4
         EAKeyYKe6InGC2wNH3vZKn2oXlYlVAKmEba84z8PrSP9kmWrdjcsLrobDTDzLqlVxJ/o
         GUf91FqJqs8vZqRLm4u6zInTH4LZTJ2VlvmqKjnV/v6+VciSj8l8eZzARAbeKjlHMAyd
         fvefW1Ukocxz4amhgWEtXHo3eEABGY3IDFMxgThpRq2HEjxW+MVrP4Dh39Cf8CL7tdDi
         WBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403711; x=1783008511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug4SbaeJ/1EYKpxKC0dJskWinTAS7LmFXgKf0w7V/S4=;
        b=Too+cW8XpqrIn0D1QgL/eOfaZXoPV6eT1VOok38Nxh14Lu/F5AYfFTFC0L5bBYZfEu
         gM6Hg2PJr+1+vBW6lmatqlmhIIGs06+W0OwBKbIOrwzPBxYyatiGgBFl/jtxnibUuET6
         DOLOrFq8Ld7XYZpHXZJ2pQSKL1cY3inGUmeA1MnJada6rdKp03JCrTIj0WygJ2LiLZfD
         Q03cbih+eGctD1Z/SIl4Fin4tjhQUNbj7/ow3hYeTnfq2o0WiP6MPZjjAaqIgd2J03YE
         JE5ZX9RH7ARo3CWmmly6RocJA8XAc4bHOeoWFXv914MqooNUmgJq9XI5KHjiVvN1XTRf
         7G5g==
X-Forwarded-Encrypted: i=1; AFNElJ/CRVvFEthwSMbyDYfC5qL0mSK/0uSh0VXs06G9Qm3QIj0dBC2THSE1zWWS8DDfq1XneDIju74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7JnqoUgVxLAq2meyD5aqgPPS/Gs+xpvIz/4PmPgnbv7D1MoF
	9WSTlVBEt7YfIi9cynmsBblG2r4C9W1AH8bTq98oFlv95bsH3C5EmvW10OqrA+ksIka+JIoXIVJ
	0FzdVXQ==
X-Gm-Gg: AfdE7cmyPsz+sWgWIfgXUBdeENMsCNNLcT8DKAFvtwX6DYsnVKlekxh2Tq1Nqg0ldk5
	ULlfVTuQG6kkwCpikagupB6R92lk/NgMsu82XrvvKQtYb6t15kiGLt7TiUWSGzqwflajM4zBa2E
	TwAznU1hq3hmpXLuNQwOszUjec52oaqqeZVwXpzGvKdKiODWT06UB4JU24wekh3k71pCb9zw/DV
	mysNGXa65k69ywVPZSjmcdaCt9TNoqWgwYOlHsQAFT3Poltd5Z7kVZtQVunGGsghWY2hd71uE3E
	oMkfYKgqqwiulpFkdwYUnoCr24QUC8IIuozZwJSDwGlV9qQzIxJYAOi0En+rWLmt+UHMkRP1XJt
	nkxIhnZB5zEoIhSmZvLDsPMkYFG97qvXoUMsXCpklo/cR3n6eIPaX1WWmgQy7X8WCmu+u1mJ8Rv
	9di+QfB+V83foUzjZtJ+NxPUkuIGwy/bqN
X-Received: by 2002:a05:620a:4409:b0:923:8612:f15 with SMTP id af79cd13be357-9293bd3b210mr434367185a.18.1782403710911;
        Thu, 25 Jun 2026 09:08:30 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ac1b8sm842832585a.36.2026.06.25.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:08:29 -0700 (PDT)
Date: Thu, 25 Jun 2026 12:08:27 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jimmy Hu <hhhuuu@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: udc: Fix use-after-free in
 gadget_match_driver
Message-ID: <ae8d0b9d-ba7c-429d-a660-30e4d175599d@rowland.harvard.edu>
References: <20260625073705.803880-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625073705.803880-1-hhhuuu@google.com>

On Thu, Jun 25, 2026 at 03:37:04PM +0800, Jimmy Hu wrote:
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
> Fix this by ensuring the udc structure remains allocated until the
> gadget is released. To achieve this, introduce a new
> usb_gadget_release() routine to the core. When the gadget is added,
> usb_add_gadget() stores the gadget's release routine in the udc
> structure and takes a reference to the udc. When the gadget is
> released, usb_gadget_release() drops the reference to the udc and
> then calls the gadget's release routine.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---

Looks good to me.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

> V2 -> V3:
> - Fix column alignment in struct usb_udc.
> - Remove redundant NULL check in usb_gadget_release().
> - Add comments explaining the lifecycle override and error path cleanup.
> 
> V1 -> V2: Rework the fix using a new release routine in the core.
> 
> v2: https://lore.kernel.org/all/20260624030154.393004-1-hhhuuu@google.com/
> v1: https://lore.kernel.org/all/20260526070635.839701-1-hhhuuu@google.com/
> 
>  drivers/usb/gadget/udc/core.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 60340ff9edbf..f6da12b553a0 100644
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
> +	void				(*gadget_release)(struct device *dev);
>  	struct device			dev;
>  	struct list_head		list;
>  	bool				vbus;
> @@ -1362,6 +1364,17 @@ static void usb_udc_nop_release(struct device *dev)
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
> +	release(dev);
> +}
> +
>  /**
>   * usb_initialize_gadget - initialize a gadget and its embedded struct device
>   * @parent: the parent device to this udc. Usually the controller driver's
> @@ -1418,6 +1431,14 @@ int usb_add_gadget(struct usb_gadget *gadget)
>  	mutex_init(&udc->connect_lock);
>  
>  	udc->started = false;
> +	/*
> +	 * Align decoupled lifecycles: take a UDC reference to ensure it
> +	 * remains allocated until the gadget is released, requiring an
> +	 * override of the gadget's release routine to drop it.
> +	 */
> +	udc->gadget_release = gadget->dev.release;
> +	gadget->dev.release = usb_gadget_release;
> +	get_device(&udc->dev);
>  
>  	mutex_lock(&udc_lock);
>  	list_add_tail(&udc->list, &udc_list);
> @@ -1462,6 +1483,12 @@ int usb_add_gadget(struct usb_gadget *gadget)
>  	mutex_lock(&udc_lock);
>  	list_del(&udc->list);
>  	mutex_unlock(&udc_lock);
> +	/*
> +	 * Revert the override and drop the UDC reference to prevent
> +	 * leaking the UDC if the gadget was statically allocated.
> +	 */
> +	gadget->dev.release = udc->gadget_release;
> +	put_device(&udc->dev);
>  
>   err_put_udc:
>  	put_device(&udc->dev);
> 
> base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
