Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268E49F129
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054803; cv=none; b=H+6DzEBEQRMfz/GpyeU7lmTRU6i7MZWLV0UWALKaLl4QPMQEnTKX+yfObKxvGGFY/K5/zIr5bmYQUstM9ouwsko8x2tLr+Q6XQqcw9MKBIL43RiVDGiBq0fPK4cyhHgnac45OQbFAO13T3JpqdQfK+3AhadUBlBzdfiU0pZoEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054803; c=relaxed/simple;
	bh=9UTqpDTW5ReUcetLLz4Ymo2mNIr3sUQ8fp9IGf329Ng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pWqOfGS73+EB13Ai3jvgsybl6xUdSmXHPLw4TDI7P1gnSYZ4KEDtPxXsrlN4TLWX7nDtYazhj5tXpK5xkrdK76MwDjb8Csel5SERcjrdLxuMPq+fLhZ5/BMFzIHeADImx8oQQEOMbw+2nrYQWdsiabhvSJNnGGlaT0ZijSX1LY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uWMhpcGT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uWMhpcGT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 136D41A1230;
	Thu, 15 Oct 2026 08:59:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D0A1360360;
	Thu, 15 Oct 2026 08:59:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACEA710328B02;
	Thu, 15 Oct 2026 10:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792054796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R3D3zrodfnAja/dl0ygdUFT7h9waEojVMa7L3/zFbmM=;
	b=uWMhpcGTN5JowFQjWpLSbGpJDvx4A8udLV/wKsPvs2PsSiI6B1LbXD04lX9ILI5jAm9aIt
	pLZPFoHl89d9EYiavK9vd2TSaABhsW8mNjCT9S5w0zii85fzj0qgUTF79h+ReV4Bw4onaf
	Z2//KxBhS+KcZCnWogpg81yzJjIlV+mLQ2vQS6hL8POJZ23liasp8hnwC4n5ormYfS6Zm+
	F0OOtNBq4A9xs4rBv2wcpUbgZMg04usYwAbA1Mqhgf3jI7sWDNZTcO2KZnFH7Kp8XTQtK6
	pVGQNi6uNLs/8+fG6NOmD2XbpRBu+QDVpOJVtUWTXhVzzxCBtsP/U7gQMKF+Zw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 10:59:47 +0200
Message-Id: <DM5AEKBARGER.2N6UFBKLU5AIH@bootlin.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: fix silent probe regression
 due to reset timing
Cc: "Paul Cercueil" <paul.cercueil@bootlin.com>, "Nishanth Menon"
 <nm@ti.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Phong LE" <ple@baylibre.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Julien
 Chauveau" <chauveau.julien@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com> <xlv14iengyes.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
In-Reply-To: <xlv14iengyes.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Last-TLS-Session-Version: TLSv1.3

Hello Javier,

On Thu Oct 15, 2026 at 10:28 AM CEST, Javier Martinez Canillas wrote:
> Luca Ceresoli <luca.ceresoli@bootlin.com> writes:
>
> Hello Luca,
>
>> Commit e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
>> rightfully added code to make the reset pin really work instead of being=
 a
>> no-op, but that change introduced a regression making probe fail most of
>> the times, at least on some hardware.
>>
>> On a BeagleBone Black rev.D the IT66122 silently fails probing >90% of t=
he
>> times. This is because:
>>
>>  1. the regmap_read() calls just after it66121_hw_reset() to read the ID
>>     registers fail
>>  2. there is no error checking for these regmap_read(), execution
>>     continues silently
>>  3. this results in not matching any of the IDs from it66xx_chip_info
>>  4. and this results in silently returning -ENODEV
>>
>> Empirical tests showed a small delay after de-asserting reset fixes
>> probing. Likely the device needs some ramp-up time after reset. No such
>> requirement is mentioned in the docs I could find, so the amount of dela=
y
>> was chosen by testing: 10 ms worked in 100% of 25 test runs, so setting =
a
>> 20 ms delay should provide a safe margin.
>>
>> Fixes: e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>> FYI For items 2 and 4 above, I'm sending separate patches to make those
>> errors not silent. Those aren't fixes, so they would be for drm-misc-nex=
t,
>> while this patch is for drm-misc-fixes.
>> ---
>>  drivers/gpu/drm/bridge/ite-it66121.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/brid=
ge/ite-it66121.c
>> index 51fc68ffdf8f..692a85e1e2e8 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -356,6 +356,7 @@ static void it66121_hw_reset(struct it66121_ctx *ctx=
)
>>  	gpiod_set_value(ctx->gpio_reset, 1);
>>  	msleep(20);
>>  	gpiod_set_value(ctx->gpio_reset, 0);
>> +	msleep(20);
>
> Maybe adding a comment here mentioning that this value was found by
> testing and is not mentioned in the IT66122 documentation ?

Sure, I'll add in v2:

  /* Post-reset delay not specified, value found by testing */

> In any case, the patch makes sense to me:
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for reviewing!

I assume I can keep your R-by with the above comment, let me know if that's
not the case.

Kind regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
