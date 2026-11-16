Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855373;
	b=VMJDPn9wyPION6ND8OdCpAfkp64uXjBDHeDnFmoAbJqXkW6K7WClrdhteiBveVo2AyzU
	 LbCgh/y6uhmVQDSCVJtvl0ovKx5RcQN+J3GOxhTyoGElteYIq+51Zy6Ou3ZLqQBr5c+r2
	 jD/S2JafqAEpo74tWRtGZqyqGqoJh+kQZbRwF/0swBoPhcRGq57zzJbAQWg9K2Ja4Xrhn
	 4nQiBVk5H+yJh/9IndbyRCgS18qxedcflqueCUJTATmS5+am3mszXaarweherr+lJafa8
	 7Kpx26M0UIfCGW7dyVuMPRRfX61Ygg7Dunp4K3tcQbzI3hrH85JMAXgnmP1VK3Q/SPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Qq6glhbhJ58HkVzMpkvkPAysJCirBwST/ZXZJ+yxSic=;
	b=X9edmObkX7/axxcGNQK3qWOGPKBWsxNV8+8jrcEbJ/p9yxuPKyQSNHw5tLoDEewUBacG
	 mhU2vu3ZeokeEzGn4aXZkMeGnwyXEZ6RM/1lhhZ0bJG9oQv0LSZfApYzBgdRO261nTa/a
	 40QAyl6d2GzhU2ls0XKyhmYjgoOSuzfoR3KsqpMiPN/df0VabLrBlUwqmGMT/VXVWEKBT
	 2cD5GvjVr1VMX6Hg4IVes9KgwWkS73yq+aVTA2kq8B+j8WWg0xHS1tq8Odny/fRS9bkEy
	 xaYxZxUcTGdXiTTBy3LWra6+vDYUNNqkDh0SbAQ6R7BBTmI1Ndd5LkuCzuFEhxF6gLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=prb93aDP;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEC606A8B0
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3DEC606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=prb93aDP
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ebf4cd218so46463636d6.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794855371; x=1795460171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qq6glhbhJ58HkVzMpkvkPAysJCirBwST/ZXZJ+yxSic=;
        b=prb93aDPHbM4PkhU42SDnNuqiQ52r1qwsMJJOJBlfjVXwraNrmm7Fp0ZJlYiy7AhDb
         RFZcoczw17nHNZJl2Dq1/lz2x2Koem0UJlzEqsnHXWOCiHhcyhUOmn3ZeuxiLtXL2xV/
         cPuhq00K5vyqt9v7BBMjcsN2IAdUurpI7l7W2SBmJjLr3xUCy2+6PDo3KMCCcr+h3fLN
         ci5wwfAZHTeRWjsGX1E8M1YoGYqpAlBrLeKplVJ2ZHuyD0FgJHQ92/Jr37oeRlDDT/oK
         /bA54ELtG4w+vL9KReaEjrw3ARv0q5LGTT2/IfTomu+rfN/i2+9bV2QD4PEqmmkgd3mw
         f2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855371; x=1795460171;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qq6glhbhJ58HkVzMpkvkPAysJCirBwST/ZXZJ+yxSic=;
        b=a+xguGITh3LdI4DxNWeqlxpokMBfqdYTHhB/mHxNEp+KB9W1WVw+jS8hyBliFF5wbt
         8UL0FW6j3P2jVPy0liKgGaY2XFe+4gXPx2cnxOQ+0TqNQ/9A80XpzrqHbQIzYRVWqcd7
         pgNmW9Dh6cU85akW9NnN0BRd8eknYcDJIOlJcSVutNw7lcQPLWUNU4Oai4NX7wM5Feh9
         PgOjbFhoUSRvTuLANQ1a7Cj7PNUFob9seqYkh6bKx7lhtqdw50BuY+XVacKsJo4lTokc
         2bJ5LETxqZYKPsohujVtK4zq9XJNC69igkaM5b3Rbr7F7ew/81yl8AaifjR2PYZHPoXl
         8oww==
X-Forwarded-Encrypted: i=1; AL+hErEQhahkSJLBDzt71jil1S00PzMbFjMJUoSkGjt71IHPdoV4U5/fEeXycPYCbap0BZ+tq6NLP6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uYCbeTI9E+4lZmnZTxISKSD4A4mPNU1GNFcGczJVgNyMck4P7
	AabcAcMhoKf7DjG5yT51yXOj3L7crmp1wtZfoIlaQWZEpzBRio6FTrDCW0sQDQ6N7Q==
X-Gm-Gg: AZFdTZdUmrvEpdbXX5dodJax7Bo/wCyZK0ju/SOn1T/4J5RugafM+tj4bJppHBiU02F
	nL3RZ46kSdRr6TnmcWLkewfyi3B7hkGctWEA2dSxD+0G7jYPiJa/n1z4X1DnPR79oUIQSUl5zSN
	apP+Vj+f9vNS3j6e2VR7P+lHZfrML+lcxR9wE4Lv+LdzLnWj+I4jV1tn/G251Hk5Cs5lvYshHDX
	xyalixrYOsOlnBxetsaaYkJzr7wCR74EFmZo6mVuaEnz8DF05VksoOd+CPzeX6Sa48Q0ix/LlKw
	eDWgfvfHwIHCD3F9REDUsNSwRV/0Tjqz52SAtnsbAtfhZ5f6awI92XkFWrCxYwVGPORMqxTpoOF
	eKa60NsBbLNQV0aDGo5TECwtNWRILQN4/lo/BwYctO29EO0JWKCJgH0yjDYGuFhmKUxbtmztUTj
	CPaeOpUUJv2i0RXqIxs1JdgSd8EDbdtRLpwnMeh7nJKewtfzpg80X4t6BIoSt/GkHSK+TdqpItr
	Xb2/d/ZYsFGsuQfUvIRMHGMXo4TYEAi27tSzh/Zz4wjDGTExvhN0CnAiK2Dmx4uSRZrs30quM08
	rLGI7Y27mi5hqdLJS20qBVH2f/JvnYBL5iH+Hl1XQNVc6HaXPGA=
X-Received: by 2002:a0c:e084:0:10b0:917:af36:df30 with SMTP id 6a1803df08f44-91f24194addmr143466866d6.16.1794855371264;
        Mon, 16 Nov 2026 10:56:11 -0800 (PST)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d452b0sm92039326d6.11.2026.11.16.10.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:56:10 -0800 (PST)
Date: Mon, 16 Nov 2026 13:56:08 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Pengfei Lv <lvpengfei20@huawei.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org, xuhaiyang5@hisilicon.com,
	xuetao09@huawei.com, caiyadong@huawei.com,
	suzhuangluan@hisilicon.com
Subject: Re: [PATCH v4] usb: core: hub: Re-guess ep0 maxpacket size after
 reset
Message-ID: <bbc753f4-4120-4274-85cb-a4e1e987156a@rowland.harvard.edu>
References: <20261109093935.2634235-1-lvpengfei20@huawei.com>
 <20261110033038.2882473-1-lvpengfei20@huawei.com>
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
In-Reply-To: <20261110033038.2882473-1-lvpengfei20@huawei.com>

On Tue, Nov 10, 2026 at 11:30:38AM +0800, Pengfei Lv wrote:
> Per USB 2.0 spec section 5.5.3, the ep0 maxpacket size is fixed for
> all device speeds except full-speed devices, where it can be 8, 16,
> 32, or 64 bytes and can only be determined by reading the device
> descriptor.  During initial enumeration the USB core guesses 64 bytes
> for full-speed devices; after reading the descriptor, the real value
> is stored in udev->ep0.desc.wMaxPacketSize and applied to hardware by
> usb_ep0_reinit().
> 
> Commit ff33299ec8bb ("USB: core: Fix race by not overwriting
> udev->descriptor in hub_port_init()") guarded the ep0 maxpacket guess
> block with "if (initial)", so on the reset path the guess is skipped
> and the host keeps using the value from the previous enumeration.  If
> a buggy full-speed device responds with one 8-byte packet and NAKs
> all further polling, the HC doesn't recognize a short transfer but
> keeps polling for the rest of the descriptor till unlink, and the
> device cannot be re-enumerated.
> 
> This was observed in production on a 6.6 LTS kernel with a full-speed
> USB banking token (bMaxPacketSize0 = 8) in a virtual-machine USB
> passthrough scenario; the reset re-enumeration hangs 100% of the time
> after the VM issues USBDEVFS_RESET.  The device is not strictly
> compliant (it should continue answering IN tokens), but this class of
> USB banking token is widely deployed in enterprise environments, and
> the regression breaks a configuration that previously worked.
> 
> The 18-byte GET_DESCRIPTOR that runs after SET_ADDRESS (wLength=18)
> is unaffected: the device sends the full 18 bytes as 8 + 8 + 2, and
> the final 2-byte packet is always a short packet regardless of
> maxpacket.  This is why the device completes initial enumeration yet
> hangs on reset re-enumeration.
> 
> Fix this by removing the "if (initial)" guard so that the ep0
> maxpacket size is re-guessed on every reset, and by calling
> usb_ep0_reinit() right after the maxpacket size is re-guessed so that
> the re-guessed value is applied to hardware before the GET_DESCRIPTOR
> data stage.
> 
> Fixes: ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pengfei Lv <lvpengfei20@huawei.com>
> 
> ---
> 
> v4: Per further review by Alan Stern, move the usb_ep0_reinit() call
> to right after the ep0 maxpacket re-guess block.  Each layer does the
> right thing on its own side.
> 
> v3: https://lore.kernel.org/linux-usb/20261109093935.2634235-1-lvpengfei20@huawei.com/
> ---

Pending other comments by Michal Pecio:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/core/hub.c | 48 +++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 199d3f535a89..e3d8ee3271cb 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4969,33 +4969,33 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  	}
>  	oldspeed = udev->speed;
>  
> -	if (initial) {
> -		/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> -		 * it's fixed size except for full speed devices.
> +	/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> +	 * it's fixed size except for full speed devices.
> +	 */
> +	switch (udev->speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
> +		break;
> +	case USB_SPEED_HIGH:		/* fixed at 64 */
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> +		break;
> +	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
> +		/* to determine the ep0 maxpacket size, try to read
> +		 * the device descriptor to get bMaxPacketSize0 and
> +		 * then correct our initial guess.
>  		 */
> -		switch (udev->speed) {
> -		case USB_SPEED_SUPER_PLUS:
> -		case USB_SPEED_SUPER:
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
> -			break;
> -		case USB_SPEED_HIGH:		/* fixed at 64 */
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> -			break;
> -		case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
> -			/* to determine the ep0 maxpacket size, try to read
> -			 * the device descriptor to get bMaxPacketSize0 and
> -			 * then correct our initial guess.
> -			 */
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> -			break;
> -		case USB_SPEED_LOW:		/* fixed at 8 */
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
> -			break;
> -		default:
> -			goto fail;
> -		}
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> +		break;
> +	case USB_SPEED_LOW:		/* fixed at 8 */
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
> +		break;
> +	default:
> +		goto fail;
>  	}
>  
> +	usb_ep0_reinit(udev);
> +
>  	speed = usb_speed_string(udev->speed);
>  
>  	/*
> -- 
> 2.34.1
> 
