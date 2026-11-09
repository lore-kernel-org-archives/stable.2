Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256484;
	b=wS0jxdZNHhjzSOyxAR9nY9hF5GrPfMM0A9IBrr6J5Jh7pMFK96pMF0for36VnnpMUWjm
	 eOEZlaUJiFW+sc+xaSjkT8XWKpQTZSTvlGGFivB5lKkOzZrb/uO4kiM8WLO422/plMc4C
	 n9xk9i7GVfwtyLuf2GrhpqRFiEgGXN1h1ucVEglbqxqqXe+4H62i/7uUs0OXcwgXibIjK
	 LD50gZ5n45CDREQHCTIKb0gmQCWl5GA6HX1GRWtRuu85LXDVBjb5UYPLVG+oMIDFZ114W
	 mUChxzTuCxvdJTdiEN2AvurWDo8ZOXAT7960kPkF2okQ2iEKmjbiiq750v52NKoamFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IBxWV0bMHBiaBYABre4CeRklD+VEvSYRbNLDT7mR5OE=;
	b=RN5asxxDa+C+NRD06mKOA3HnznTWgoorot/ZtXOs6PkcJkdApV8SsFmGHM6nD99zEcBt
	 wNCuFiMU1WYvwi9+6/C6t4mP11tm0X/uACYIAZrHlQZ04GsGH375YVy/FglkNaktDfY8R
	 IAfGTVRtCKpsPm+KDzDH1xvk2j02+ArKk74LP+qF5VYuN0kt7eCQWkcFnJB6L17lU9sfX
	 E/EFz19AwQ0LTXOut7AVmQw+pPVUNPsvA89AKE64PrlW/In821VC5sryn1g4442XOjP8W
	 vfcIKCmgDxx59eDxpq44fNd8f6Dc3yG7cML+uezCe+Xkbekg9kXnz/QovamxL7NLYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c9TmK+9W;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87878606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87878606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c9TmK+9W
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490f38e9688so1063132f8f.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794256483; x=1794861283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBxWV0bMHBiaBYABre4CeRklD+VEvSYRbNLDT7mR5OE=;
        b=c9TmK+9WzrGyvd+dKsPN5CRanNi3KrAxYt7LKAN24BULUbEELTKz9a3REq0gnaF1eU
         96dkvLHUhT+Dey24BA803kWLvqWppZfKGlgK/KTSDJWb8BEvoi7SQKLyu0+qFBBTQre6
         c3ApfaIZXvk4P+K3nfi3o4lJT5hPfKjNev4vephwJOukoaCVqawno6zNEU4T8EiQ2QXW
         9yEl7K8t58m72puXrbI19fiGd0WImOk5Oiyyr49pOh9OIc3MUl6WSRXs2+54rV0TOQsK
         Ia7OO0PJANNhk8znn9Z2t/YF+YVTLM0vpswHDvvA4LmBeyZ/HMzX3fo3LpnpsBPzg7u7
         xlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794256483; x=1794861283;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBxWV0bMHBiaBYABre4CeRklD+VEvSYRbNLDT7mR5OE=;
        b=eXEO8Bepuu0QnUgx4EwRbIMopwPJ4asbURGZNEIDbxQl8utID/dlSM9JUsN77WxrHt
         RtwHDK6zUhqzsZMTvU7XV7wr/cJGk72Af53Q4NjtTEtI4gN1dQuttnyCVa+yjIZQ1POb
         Xxk782FsmfEpTo71amGwI7vFQxRU4Tww8W2luRgNxJTSItfl9Hlk356iAqUlMPEUyx9t
         KSMlfnCBSyOYRSv0uEhZvr+tQn7t80UR89EO2yonNRxVYphKjgQSpeew2IA0q43GbBvn
         glgKD3AudyvKLztNGfMee+t527ltKfL5GTtHyn1Eb3Nmfnr7s/+SnHYX80xf1ehsfxWE
         mCmw==
X-Forwarded-Encrypted: i=1; AL+hErHbN1efGtBtzGgq1I5cmJT25Zha9LCr1gc+EZSQomdxL6pyaQIPyIxmZl0QHY6CoVgMzcMRTd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WtBQWk/xRn5fI5pAzAsXP26xf2DSUJ5h7H7YwqUuPUx7Zvfs8
	uCNu/oOPths6Nhq/zZajq7cIbXZurCynI8F5GKbGQn0BITAV1d2sbCV1
X-Gm-Gg: AYBFou1MlkjLBbe7Hd+8lzWSDHr2tdScCW/SWZSyHComLmb035nZKf2ZIRcp9ckJIBG
	SDvTT8qwwgy4CjYyqC39E2k4j80WPJkGUpWLuECobsUQI9pj39oa4sRC+N0sx0F8YhbblXcsFVx
	Umjt88/3p73OjurZcHFs+tBZHXnF8hiWbAttb+5/FunSDgbXLvKU/SqFo7hwdxCNxtEK1Z64MYY
	crJG3UBdTsa9HRLsLO/A6ja2ixsmQtlkuhKW/asB2XCM4d9U86d63KuuZHgzhyu+gyULpS+BuIu
	3g8NsBSnCy2HbAZrX23PZQ6+uc6AsvOzLuMS+HsrMR/amo7fZduIj+ZV/BO+MvolhKuJwNdfHSz
	gqqI7AsZloTrkP6DLavV2DHSyNyeJ13tV9LdESw8ilGOOze6Eo+BsSeOdYgeSkVxYKdo4D34Nyw
	8lx4qQblQVjlonKQsXvMtXy9haG1uAlRpAhgAHNTfDCHlsKtBCGoA3MsHzJqKH6fsoMc6Rj2niS
	n4bWqjpVsG0LFClKxNiFBKDpRkUJyYFdL0M1Z04ryW8sEpa06XNmSkqmHHAZUHSpMqVo1AaUxbB
	NNIPtHv0luo7+uZaOQcG3+LixhDPOd92hRe1WqCn1/nAaDZx9kD14jpV4qk=
X-Received: by 2002:a05:6000:4b10:b0:48e:678d:396e with SMTP id ffacd0b85a97d-4982e362a4emr1059772f8f.9.1794256482703;
        Mon, 09 Nov 2026 12:34:42 -0800 (PST)
Received: from foxbook (bfj76.neoplus.adsl.tpnet.pl. [83.28.47.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbfc6sm917789f8f.41.2026.11.09.12.34.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Nov 2026 12:34:42 -0800 (PST)
Date: Mon, 9 Nov 2026 21:34:37 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pengfei Lv <lvpengfei20@huawei.com>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, xuhaiyang5@hisilicon.com, xuetao09@huawei.com,
 caiyadong@huawei.com, suzhuangluan@hisilicon.com
Subject: Re: [PATCH v3] usb: core: hub: Re-guess ep0 maxpacket size after
 reset
Message-ID: <20261109213437.5c693895.michal.pecio@gmail.com>
In-Reply-To: <3daf18d4-4936-4ed7-8846-b67f1664be13@rowland.harvard.edu>
References: <20261106031625.1824732-1-lvpengfei20@huawei.com>
	<20261109093935.2634235-1-lvpengfei20@huawei.com>
	<3daf18d4-4936-4ed7-8846-b67f1664be13@rowland.harvard.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 11:05:30 -0500, Alan Stern wrote:
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 199d3f535a89..d86bbba1457c 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -4969,31 +4969,29 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
> >  	}
> >  	oldspeed = udev->speed;
> >  
> > -	if (initial) {
> > -		/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> > -		 * it's fixed size except for full speed devices.
> > +	/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> > +	 * it's fixed size except for full speed devices.
> > +	 */
> > +	switch (udev->speed) {
> > +	case USB_SPEED_SUPER_PLUS:
> > +	case USB_SPEED_SUPER:
> > +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
> > +		break;
> > +	case USB_SPEED_HIGH:		/* fixed at 64 */
> > +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> > +		break;
> > +	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
> > +		/* to determine the ep0 maxpacket size, try to read
> > +		 * the device descriptor to get bMaxPacketSize0 and
> > +		 * then correct our initial guess.
> >  		 */
> > -		switch (udev->speed) {
> > -		case USB_SPEED_SUPER_PLUS:
> > -		case USB_SPEED_SUPER:
> > -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
> > -			break;
> > -		case USB_SPEED_HIGH:		/* fixed at 64 */
> > -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> > -			break;
> > -		case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
> > -			/* to determine the ep0 maxpacket size, try to read
> > -			 * the device descriptor to get bMaxPacketSize0 and
> > -			 * then correct our initial guess.
> > -			 */
> > -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> > -			break;
> > -		case USB_SPEED_LOW:		/* fixed at 8 */
> > -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
> > -			break;
> > -		default:
> > -			goto fail;
> > -		}
> > +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> > +		break;
> > +	case USB_SPEED_LOW:		/* fixed at 8 */
> > +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
> > +		break;
> > +	default:
> > +		goto fail;
> >  	}  
> 
> The usb_ep0_reinit() call belongs here, right after 
> udev->ep0.desc.wMaxPacketSize is set.
> 
> >  
> >  	speed = usb_speed_string(udev->speed);
> > @@ -5062,6 +5060,9 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
> >  				goto fail;
> >  			}
> >  
> > +			/* Sync the guessed ep0 maxpacket size to hardware if needed */
> > +			usb_ep0_reinit(udev);  
> 
> Not here.  And not inside the retry loop -- ep0_reinit should be
> called only once since the maxpacket value is changed only once.

Sashiko pointed out that xhci-hcd may not perform ep0_reinit() properly
until address_device() or enable_device() is called.

So it's either this kludge, or dependency on an xhci-hcd patch which
didn't exist until today:

https://lore.kernel.org/linux-usb/20261109112846.04bfeb0f.michal.pecio@gmail.com/

Regards,
Michal
