Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690191;
	b=dEO/wAL7zMB0adPphhtJTqTKJpx3ZnJzTNKH/YcKGI1+0JxB311xoFtjDxi1aDcz/R1T
	 Qpt7zHie9hU5a1bGlyeFHiO77opUTViM/tZ8e1wjm8u2P0KKxjCh6N7EbOUVS39JLEUKG
	 5tptdzkqR6eb1n/XYMK7AXNTVNZPNQeB4fdBfo5vIUvVGvfBFq4cScnKNOHEdJgJOmjfA
	 Emuz0a6MDqivkRYjVE7vXIP3K4EbImgWLYBdviuWZcsUAqu/0Eir79fufNKd0cmLrLDF4
	 ZOZ0pwEnBryOpCDg/MjhliUqs61tGEHZwAXwYrTjUk038wX57Qe9AEcVmg3ZCAHfYbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VF3+5ckqjkWo1/tuEiCb28KnOUZrUPKvSXLeZGTLF5Y=;
	b=TEX+ivGkSqLR5AayhvWLLfWWuDS4V97hDjP+Vhd0ijFVpVN73bqVKI5WL6/ZFKerjo2J
	 PORQF/Wj/LvmXPsxjzIrrY99DFIgztUhBkp6tLBTMnc1mZ9CdertVr1KTrwHPQu8vV+Y2
	 xupdngS9MU+/zSBRlMpk2SKP/5LpI2DNREXWdf0MHfzt99JFqyYDdUwin/eZYK75/SEGZ
	 Ps8H1Rv6e8+bvnGi+YJce9DoL4FoEj37Pz8R6DSyUijv7s7sSioPY3V5loDnyYxc53H0Y
	 r0vUKMMPulBpQ6U7y9mvQjl6WwSfAJc0Tx4ywzRk4aRr7d6zKRvC9QCB1Hh5XCemBYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=njza3wTA;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85361606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 21:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85361606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=njza3wTA
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5365d26ccbdso2172831cf.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794690190; x=1795294990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VF3+5ckqjkWo1/tuEiCb28KnOUZrUPKvSXLeZGTLF5Y=;
        b=njza3wTA94nlZ4biRy1rA18jY9hYlEQqvtu6o8uuNZmpbwAyBvWF3zxdtdfC6KDZ7S
         Fb3onuJoOjLXeXKcU/4EXQ8jEuRnMkjTYTX7DXsYjlTGfumZaP17roaMT7KFPVF13oHE
         y8zDyzvIfgegWnYbs3dCWO9cs3viq+AzzRW8WRSvWg+jYOjpM3RAqfprMlaRJuJp82S8
         bpesaZdJf2oL16toVLPEBMotiWo00LN9egC1p6cFLDfbXVFycFylTjLEWbLhSyWNP6NY
         /rvqHv0xJtkvd4tY4azMTT+mgnrOcNjrlagBncohReHsGRYDysYwiT2VLFGnaW9yZnG/
         jFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794690190; x=1795294990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF3+5ckqjkWo1/tuEiCb28KnOUZrUPKvSXLeZGTLF5Y=;
        b=cU8susW+SORnYVI5UhMarYai0bwCTgGuhOftpojXECAm/6oS3RQvRf8InK7psdmwpp
         OoxhbFrUR6hjQD98oga4qgg/QdhpEt+FXtPjFFOUH0wyO4gQZPtmXoXuRF5/tHDoLAgo
         75Y13T5HLvDhfLZ65FCf7qHE5i4o4Ahj7NIVoWLVKFeMlOeCE9c89Ag1bgRYYV1JYVSt
         GcxGuiq3Cdz6G8Xcq1wnx3qEChyDtXoqiqg9oRVCDmXXlUHDPdqlHwXabzu0A4CQxUS8
         aByxDrjBoQ288+HeKmBUNivaocV/VnLQadrN5EbDWRhmXF7TDENSakSmQSAD3lcdBn7e
         UvLA==
X-Forwarded-Encrypted: i=1; AL+hErETCRZMNm2uOFrze6oWFeghRmMumXzx0zZXFFMluUGpfiOZkwKa0hgN2GgiNXGDjI1ILNAW5JE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s1ioV2rlV5umFO1vK90ExTB7aCfw1pqdserXNsdoPp0JilHQK
	pa8aRzHnIcRS2PHh23uG9ZhCsdWQjNti06boD+PiyQSWeMRf5qsu443pCojKQp/PSw==
X-Gm-Gg: AYBFou1N9X3RZmj7r8Oj8hqaj5xRQC+GsITtNyx4wb5nIL0o7f9yBAFtEk7DIySMQhq
	h/tHF5zsYfkz2Ay9tVKPyotADL2mzla/30O2WXORuSM3rOFuGoUUKxvAnSvqa2MFbqKt2DRq+Yg
	4kcqwTB/nWOEYpxag1gBBDR1OtHlnreYffMl3GxOu6afIy2HkS8GsDZMuZLu+e3MBucvf9GUaIm
	V30CPUltdJw1XKHDLy7+vpG6Iqja7Yeipl0M0mAwbj6CNJKyApmumedwTxDrDorzM3K2Gkrlx9K
	BtnPkDRyVJ6hYNbD6/ayzfy2p3PMVgXOIVR42WTYQVsfqMA/Z8psVek0/Rp21ck1TpDp25XsogG
	/dX9rHfJyqSYnZe0lWXxPllp8l8ukZNKft8SjVEyiMiXEga36wL/oa3Io30yQ8+mQVeYBfXAGrr
	ro6NRDv8fM/GL0HVjkdj4vYIWvlANm7Bo5QESFo6sML+JgNDFvLYtM4hibGK05osHy+6qnOde18
	3ielPl2lVenujGViXRmNU4z0F7/fOE20Q47hvz9yR9OoNm2lWgiokVrpIFu0vLYLciR3xQE8aX2
	U9s46lzA3myhSDyjnrh5mkQSyVTaWbiCQZ6YtBOo+f9zDjV2xSs=
X-Received: by 2002:a05:622a:5a11:b0:535:a5f7:d586 with SMTP id d75a77b69052e-55ac9089b1amr95896921cf.64.1794690190346;
        Sat, 14 Nov 2026 13:03:10 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d458fdsm50228666d6.9.2026.11.14.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 13:03:09 -0800 (PST)
Date: Sat, 14 Nov 2026 16:03:06 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Alexey Charkov <alchark@flipper.net>
Cc: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: gadget: udc: Clear a pending connection when
 starting the UDC
Message-ID: <fac47d51-885c-4d83-be9f-860cf70816cd@rowland.harvard.edu>
References: <20261113-udc-connect-v2-0-f51b11f07eb8@flipper.net>
 <20261113-udc-connect-v2-1-f51b11f07eb8@flipper.net>
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
In-Reply-To: <20261113-udc-connect-v2-1-f51b11f07eb8@flipper.net>

On Fri, Nov 13, 2026 at 01:28:16PM +0400, Alexey Charkov wrote:
> Since commit 62911bc82b03 ("usb: gadget: udc: skip pullup() if already
> connected"), usb_gadget_connect_locked() returns early when
> gadget->connected is set. A connection requested while the UDC is
> stopped sets that flag too, without enabling the pullup. A later
> gadget_bind_driver() or soft_connect "connect" then finds it set and
> never enables the pullup, so the host doesn't see the gadget until it is
> unbound and bound again.
> 
> This happens whenever a UDC driver reports VBUS through
> usb_udc_vbus_handler() while no gadget driver is bound, e.g. when a
> Type-C port controller switches the controller to the device role at
> boot, seconds before userspace binds a configfs gadget.
> 
> The pullup is never enabled while the UDC is stopped, so clear
> gadget->connected once it starts. The bind connects according to the
> VBUS state that the core tracks anyway, and a function that deactivates
> the gadget during bind still has the connection recorded for
> usb_gadget_activate().
> 
> Fixes: 62911bc82b03 ("usb: gadget: udc: skip pullup() if already connected")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/udc/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index d5844384c368..577bc15f61a1 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1236,8 +1236,16 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
>  	}
>  
>  	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
> -	if (!ret)
> +	if (!ret) {
>  		udc->started = true;
> +		/*
> +		 * The pullup is never enabled while the UDC is stopped, so any
> +		 * connection recorded meanwhile was only a request. Forget it,
> +		 * so that the next usb_gadget_connect_locked() enables the
> +		 * pullup rather than returning early.
> +		 */
> +		udc->gadget->connected = false;
> +	}
>  
>  	return ret;
>  }
> 
> -- 
> 2.56.0
> 
