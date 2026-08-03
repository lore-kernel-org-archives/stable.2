Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA030EF89
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722491; cv=none; b=deBa/2gR46KvejOgePKBMSCE9l1/dJw6Ox4jjeGMmgTyPI/OzHmhS7tOABY4jPuRqrVFGiJxg4G0of08YHfKKdxd5Z7/rrZZvhz2EKSsRBxpY/D0PmKUNGAy2yXD9UngONjn3pG+SH+s0zI/l9LpJuWjOqPZmsbtmPg4P4CEymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722491; c=relaxed/simple;
	bh=022CtzuCYgQKuBmhMtlJd63b6/BfGbbIKTHJfIfKPR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1z8CurVmwF0ySy19FBWzNj4WAZxefJEvrBzoRxIPQHizib44Blvfqn9dnMY0eMKGCfwPdb2jTgnZrutLMyglB9ThWLjh+EYBZdm3Xu93CdGD3PX86s3Et8Chpc5GsrlgDQo6+tKrs5fAWG92lcZMEON81ZXV8I34g2UR+Kw2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiQ61x/2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiQ61x/2"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c999f162c9aso1819389a12.3
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 19:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785722489; x=1786327289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzNZQnQ26DMRnAyduy+p6kI8g6zuK0Z3SnPpOgcKOwo=;
        b=fiQ61x/2q50i52w63NkKp3av2ivGKX70rPpIeoWOlDgLtkrr7A851AQpDvA0Noi/XN
         5dXSR53yioK42tQU25hqYfUz9rolkS3CDtHRrrgFgp1QURKYGyLywkUCtmMyqtcVnhIw
         l8rNkqkAm/1Ql76JDyTQKh4HaWvOcm62IThr2ZVmuNoSX9xF8Lf/QBhiRNZG4XogTBKV
         n2JQritIt+0WMK8R1+TJaShimyfn8VcxF5rHAcAz31sUeXxUByLT2/RNrjUewMAeRbKP
         3aWIMiFB3pLiFftJfekVTqeoWOerNrJb5pyEsjW/omDbCrEJS7Gl0ZZi2zMkWrIz9c5K
         b01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785722489; x=1786327289;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzNZQnQ26DMRnAyduy+p6kI8g6zuK0Z3SnPpOgcKOwo=;
        b=a6KHcizEmw5PdeTD858Vc8CRshdKcopYXYQW7BUUMSqe9QU8+EnpXegPmrL2VEBPNT
         hXeKxXh7hNNdw20l73cdtbDm0UCc7PnVyxwBdaRdxfUAfIo+r9CoGo9YaC7F4a1PUwiO
         R1yG58Y5FyQGc1tIqn2UTUo7NjAFzR7Of6jQ+cx94sQ56EYrfY1H/peF8F48aQhvNgJL
         PxowmW+cX+Nx/r8U8/ZIO/roI3JyD1yK55c6JkhVg4mlE7AwYhZmM1SOLoOLiyLhLCql
         j5jDorrh2byGNeO/rlbaMaLd0/GwngfQyIhKU+ih0VKzKsNrErBWPlYEUkNpC9XfVLIQ
         xw/w==
X-Forwarded-Encrypted: i=1; AHgh+RrOyJGulYB2dm+XrcwUnL+xKET6btjMSSvRMus4NKTOP4S0WKDVzqVbieX7WQCeRj8kLr5LwDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywU6O8FV8e+CIAFzs/OeOWyBaKYRyPOEJXs4X5npqwQKJGv74Y
	dkZBIvdLHVkmDaFCpvN/hgFwm9u1xmyUjD95yj50On+Dr8AGgbte16+ZGAGMqA==
X-Gm-Gg: AR+sD112LmbBEiUS1cFZk0CgyXJ02/9EJi9kvxvO8OJg4jIejswdcm+rcMpeW+f70II
	jt/D96VTkXacwKmVGdyiPh5K0F8+RecHimhVIUikn6RBrTihOm+z25KUbIUbh1LlmStswmWCWn+
	hkyjYehkVszxd+38jITtrLJzqh1kBNcU+/CIfc2kilq8DQDkMrEbfTBR96tNjFSNX/s8qs/q6xA
	OELrgiOURS2ac8wRWYu2qJeyv0K92pydtbEx2hKaGWop4gG8iSkkpi+hUQZRPu/CKmGc9cNkN9E
	rZoxj2W9kuBAzaU6bEu90WIWXOQBQF0CXdQlD1DwE+69HIjTHeAHPnphjpQthYEGX2kmH8gY+OQ
	7NIFhJI1c3895o1+3xGgLSIciQOixxQtH7UTxgxe/2Kqikk4uNZloRVf9p4HMWAv02Es/uu/HA/
	aQ5gSlNF1RpPPq2IZNx4X4mt6pE3dubMEiZOvgCJfaXQt2XtLGrrNXu018F/mb6OgRxeFMzPw68
	ZgQmKK8ohegXyxLwHblb2Xj2ICmqw==
X-Received: by 2002:a05:6a21:69c:b0:3c3:83e8:c211 with SMTP id adf61e73a8af0-3c92a901f54mr8377503637.63.1785722488848;
        Sun, 02 Aug 2026 19:01:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm51119156eec.28.2026.08.02.19.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:01:28 -0700 (PDT)
Date: Sun, 2 Aug 2026 19:01:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dongxu Su <hj117@sz-huijia.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] Input: xpad - add Voyetra Turtle Beach PC Rematch
 Gamepad
Message-ID: <am_2UxUjAciSMByi@google.com>
References: <178572174191.26980.4407731925140715976@sz-huijia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178572174191.26980.4407731925140715976@sz-huijia.com>

Hi Dongxu,

On Mon, Aug 03, 2026 at 09:49:01AM +0800, Dongxu Su wrote:
> 
> Add support for the Voyetra Turtle Beach PC Rematch Gamepad,
> a triple-mode (wired, 2.4G wireless, Bluetooth) PC game controller.
> 
> The VID 0x10F5 is already in the XPAD_XBOXONE_VENDOR whitelist
> (covering the GIP mode PIDs 0x6015 and 0x6016), but XInput support
> was missing.
> 
> Add XPAD_XBOX360_VENDOR(0x10F5) to xpad_table to enable XInput mode
> (both wired and wireless), and add xpad_device entries for all four
> PIDs to give them human-readable names:
>   - 0x6013: XInput wired (XTYPE_XBOX360)
>   - 0x6014: XInput wireless 2.4G (XTYPE_XBOX360W)
>   - 0x6015: GIP wired (XTYPE_XBOXONE)
>   - 0x6016: GIP wireless 2.4G (XTYPE_XBOXONE)
> 
> Signed-off-by: Dongxu Su <hj117@sz-huijia.com>

What has changed from v1?

> ---
>  drivers/input/joystick/xpad.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f36..7f593fc 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -267,6 +267,10 @@ static const struct xpad_device {
>  	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
>  	{ 0x10f5, 0x7005, "Turtle Beach Recon Controller", 0, XTYPE_XBOXONE },
>  	{ 0x10f5, 0x7008, "Turtle Beach Recon Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
> +	{ 0x10f5, 0x6013, "PC Rematch Gamepad", 0, XTYPE_XBOX360 },
> +	{ 0x10f5, 0x6014, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOX360W },
> +	{ 0x10f5, 0x6015, "PC Rematch Gamepad", 0, XTYPE_XBOXONE },
> +	{ 0x10f5, 0x6016, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOXONE },
>  	{ 0x10f5, 0x7073, "Turtle Beach Stealth Ultra Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
>  	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
>  	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
> @@ -522,6 +526,7 @@ static const struct usb_device_id xpad_table[] = {
>  	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori controllers */
>  	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries controllers */
>  	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
> +	XPAD_XBOX360_VENDOR(0x10f5),		/* Turtle Beach Controllers */
>  	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
>  	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
>  	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */

Thanks.

-- 
Dmitry
