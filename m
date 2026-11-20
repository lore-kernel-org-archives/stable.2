Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176657;
	b=uSFOAjudmtbifuI/B3DGBDOLHu05tHhSMSFU9sC5/beQg+x6iqbgRy+8hJuubt4sQRMO
	 /WY6mUanvianoDG9t8KEYwbrE2etdxAS1jemgXSBqrNPoKwPiBI91KbOmXV7e3hRWUUbA
	 4lT+d3Kvzra87icSHrI+8g1NCgUZdTSRx6qPYviWq9vU2L9TBDALO53T9hHDb13RrnMy4
	 JXq9wOrRcMWxsDK0QL8x7L514WnnuRVW4CRm0hQaZsBHIxHIDuOG4PtFNUNW/3Ba6DZu4
	 muuO3dsl/s8VcTzSDt6UMkYewmzzwDw0d69IA3PiofyD7zbOkVAo+gjJYWozhoSLo4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176657;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yEn6hZoR27mO6l9Fwd74ebjt2Qc9Bj6f7MuKEtEDDIA=;
	b=NG81TL4MLbnZfooTMxpsQhcOj/SScyflofKhxLKWtoy80n71uJjhEsZIiq6e6SZEO9zh
	 8ub/cmiF/7y2dGV/QfFWPzBGHSdKq1S93YHvTMtG66nC0aOyT80beS/UhGs3KJ8uzzxf/
	 gl8eng27I4UNnmEKl7FefrDYAn7+RqFW2K1kP9+1fkuLYP19Lo5B0i1NMOPochYu1Rk+M
	 AqrfSUg4wX97J7c0rmSGGtWk+GiTi4Lxmm07H3iv5EW1oNuAUHKIC+dIVDTVdV2E0kPZO
	 KgK1CnFmaOXw1HUAqDF0WHnlGcP1bxliuQHsmUOr2T0e/AtbU6MDftWjZd0gv0+IvpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="W4KSeOo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F5606A325;
	Fri, 20 Nov 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4KSeOo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6912A1F000C4;
	Fri, 20 Nov 2026 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795176657;
	bh=yEn6hZoR27mO6l9Fwd74ebjt2Qc9Bj6f7MuKEtEDDIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4KSeOo/uGIm9oUK3TLcmpQgx47fddndPesoC0nJtyrER5Y7EfSo/sibJ1pTUrwfM
	 PFpxyRnzP1ea15lHlIEtoGuRbR1PmEweRFaur4hrrPZAszBXbB69WsOITok2AXD49W
	 hMHx4pubni6hzv1HWJxABR+SK0HDOKhOn2IzcLE4=
Date: Fri, 20 Nov 2026 13:10:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Neill Kapron <nkapron@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: fsl_udc: Fix potential use-after-free
 during removal
Message-ID: <2026112015-lumber-flyer-d8f6@gregkh>
References: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
 <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn>

On Wed, Nov 18, 2026 at 10:10:53PM +0800, Guangshuo Li wrote:
> usb_del_gadget_udc() can drop the last gadget device reference and call
> fsl_udc_release(), which frees udc_controller. The remaining remove path
> then dereferences it to release its requests, endpoints and DMA pool.
> 
> Hold a gadget device reference until this cleanup has finished.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: eab35c4e6d95 ("usb: gadget: fsl_udc_core: let udc-core manage gadget->dev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
>  drivers/usb/gadget/udc/fsl_udc_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
> index 878d70b55530..9d9d2164c5bf 100644
> --- a/drivers/usb/gadget/udc/fsl_udc_core.c
> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
> @@ -2537,6 +2537,7 @@ static void fsl_udc_remove(struct platform_device *pdev)
>  	DECLARE_COMPLETION_ONSTACK(done);
>  
>  	udc_controller->done = &done;
> +	get_device(&udc_controller->gadget.dev);

This feels wrong, why are you needing a fake reference here?

>  	usb_del_gadget_udc(&udc_controller->gadget);

This is where it should all go away.  If not, then reorder the code
properly.
