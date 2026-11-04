Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822988;
	b=X0p7eCxaoOm/CiNkAWyEGlDfIv8Km8jw+T/SLx8++DjyORvN2sK9BRTG+R/Hfq9aF/fN
	 kna8E6jdE5B9gH+zDWyKoRxQi1x1Uwu7mq+kmsFcGJrdQRBeAaMoDbF9cGijoDEH4p1Ap
	 ILjaV1fP9414i/qLLb+T0czyiVLj7hnpvZ1tFpU0f9HpdqZEmkCIEknWpzZiTtR93+0an
	 KxuXNR8cAKuj97L/fd0ZEQ5M3h+zodYBGMYaD9SkRo02f8OTJ5jpe1wLwtcNTzBee7GYl
	 UvfR1C0CyZyginCda4Uuspev+U6ssqBymB0UhS05vTjLBuTWLj6R/hGG1BFvLW4Tquw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=7PJM4PbhJHpLhbWOLitVKtM/DyGHKxiR5hSKnNJAjXU=;
	b=Md41/D4YLIeupYfxElVt2Dw2NtdDCClVT5tMet5L+Uh5T+lP2NPOjHt/Bhh/ROQMXB22
	 OJ13C3f3UolHNegSSQd6wwhJ+AeVlcJTGAqY4DU09U+osJ3jicqcdopaWzH3tASmnPjFQ
	 w55+qpqMWRfX+dKvqYz6vcGTaGGDiM26gkBVmlDD58T1rVMk4KSu06/LAGBSSw31pLtAg
	 dwxf7jysBfF0NfehewtKx0aoPznrtnYsQI9onMW89J/hFhl7g+iWG98JfJLEwHwVZpGDF
	 Phj4ZBtYtQOowkGw+accZW6NtGlz66D2O2LGNbrsLzcpJm1fnIbL736JCP54lrmgDwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a45YS1Xc;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CE607C0AA
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D97CE607C0AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a45YS1Xc
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36d6765756fso1026023eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822986; x=1794427786; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7PJM4PbhJHpLhbWOLitVKtM/DyGHKxiR5hSKnNJAjXU=;
        b=a45YS1XcZYiSvN/+A0jIa3rWTLWJ/IzdfxjgeD9DUHE8RI1ig8G9b042/i5LxmkJrc
         ePRtaEVDBQbEPe4UjVMYQYg45+/fX8F4w+AdddwlOc1vZWjJc2e+TlVcthwliZBLx04M
         HCCnJttpgVSL6bzW8ECkMho1UciQkxFw8ZCWp6RM3b115fv7iSkWJkEG2Zak+k3oo3Yx
         IY4h/I2pbdrlJJJHsCQpUOSKHoH0t4WnR+oTm51TT9Cd8xyGn1zSXYVhfvaifLVH4rf0
         vdeRYsqcn3MqktNQR2vEcQk5FvZFlyS69S/a0oiE3bSsIqhADGPf2HrAwArqIKMOk9mS
         WqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822986; x=1794427786;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7PJM4PbhJHpLhbWOLitVKtM/DyGHKxiR5hSKnNJAjXU=;
        b=gUsbtpCmd7TpC4HvpobF0FDktv/nejBiqF33bJm2wDmL+kOAUSssI6JfnQGq6QO0b8
         96oQutUcC58p8zwDfufcoFl60LSPohshVjLX5UaYq6rukuZ6PwjKuUQgql/o+KyPgiIz
         UIkngcTM/+6UPEh+jxDZhnRCuu4tAjquIgR3nvYs/HSQZ5Rccfwa+VZqoqkpUYxsw5UA
         Ah37ucGxkkWGXBuFV6M6j2kTNSoHjuqkAfJT4Q2HvNIABIlBEXfFziWELrJZmspSN/Yy
         ao0fb8MBoviutCLVl9Ff8F3aTvp70avh7r/unhD6DEiPtKZw6pVG4dbhkmELMUrs77eg
         2GGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxveTAAofWxHzwLGCE2Y0Zeko3zT0ae1J8UfeVbwkCIVqGtVufL4W+ttXwhzHpjCTE5y2z75PY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l06P6xc6f4ohX4m2Qimn/hs2aFS8PzLLiWYH027jOp+WipltI
	QQBX+DGt5RHiOCKiDaZgdgtR9Le9qxb/qqRFJsPrUZWDGcator9Kk6Eu
X-Gm-Gg: AYBFou3s6hP1oZOsQzI39nl3sxcF2ql73xaJWMnzS3vqA/xVhoDcAzZ/IBDi7Do31cj
	TgLGyA9tO5YOodJXzzIHnHOjvm8+J5N64/zelzW7NE0AhEh4/ujFG81EnXAzLxznAfRbiInIUWX
	n4qQCd2r41QQf93rEcph6mUPO2s/vubQHclbMsxuOCAFAMinAkxRoBIUOrAdtuaavuO+H1p29AR
	+ZN1OC0iXufO0tbfH/oLS6Q1kd2RaQQhTeAv6IJEEoRNBDNBLpulZ7VFCVvx52dJOD72MN5odKC
	f+XsysEYv3smrtY+eS+dBqrr808WyrxlI3D/Aah0JlDmV3iuqBjyIUdTxRbi/Ifsdo+4q9NtHRS
	ZRuP7DUpMW1E5ryJNlcK3nYWmKQbxEemmjH2LLCeiMgMHd6zvx2b0BR1wUz93tnA7ndSeK4jhlO
	RbzpDqcYfJ9HHPyo0ReBn8yOQoXUSjxozmfSBLJGPmRw3lgysRoxNOSgow3E+vQ/qi+/His+1t/
	3sRpjhNmZqCGJqAiiJ0t3O9cRIhF7eJyPGA3XpH9wjzXGBocMPAgJs7SkvhNeU8tDTnPudCb237
	yMxMT66E6RQXLgtwuqoQEyLQYCUdWJcA6jiG7y9X2wDqSeAV+ZwZo2CLMrEYXcFxQxnSaw==
X-Received: by 2002:a05:7022:3a8c:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1ac4fa14bc6mr29667079c88.0.1793822985762;
        Wed, 04 Nov 2026 12:09:45 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:920a:44a8:6f02:232e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4706bsm12494370c88.15.2026.11.04.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:09:44 -0800 (PST)
Date: Wed, 04 Nov 2026 12:09:43 -0800
Message-ID: <14c52f5f176b8fc6aadaa31c9f4715c0@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: cyapa_gen3 - clamp the reported finger count to the array
In-Reply-To: <20261103084135.426629-8-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com> <20261103084135.426629-8-zhugl3@xiaopeng.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:41:35PM +0800, Guanglei Zhu wrote:
> The finger count is taken from the top nibble of a status byte the
> trackpad firmware fills in, and used to walk the touch array:
>
> 	num_fingers = (data->finger_btn >> 4) & 0x0f;
> 	for (i = 0; i < num_fingers; i++) {
> 		const struct cyapa_touch *touch = &data->touches[i];
>
> The nibble allows up to fifteen fingers, but the array holds the
> five touches the chip is documented to report, so a firmware that
> counts beyond that makes the driver report coordinates read from
> the stack past the register block.
>
> Clamp the finger count to the size of the array.
>
> Fixes: 9f1cd857518f ("Input: cyapa - re-design driver to support multi-trackpad in one driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/mouse/cyapa_gen3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index fc3fb954523b..fda807a4c141 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -1149,7 +1149,8 @@ static int cyapa_gen3_event_process(struct cyapa *cyapa,
>  	int num_fingers;
>  	int i;
>  
> -	num_fingers = (data->finger_btn >> 4) & 0x0f;
> +	num_fingers = min((data->finger_btn >> 4) & 0x0f,
> +			  ARRAY_SIZE(data->touches));
>  	for (i = 0; i < num_fingers; i++) {
>  		const struct cyapa_touch *touch = &data->touches[i];
>  		/* Note: touch->id range is 1 to 15; slots are 0 to 14. */

If the packet reports more than 5 fingers (for example, if an I2C read
glitches and returns 0xff bytes, which would otherwise pass the bit
checks for OP_STATUS_SRC, CYAPA_DEV_NORMAL, and OP_DATA_VALID), the
packet is corrupted and we should not clamp the count and report 5 bogus
touches to userspace.

Instead, please reject packets reporting more than GEN3_MAX_FINGERS
with -EINVAL during the header validation in cyapa_gen3_irq_handler()
and cyapa_gen3_try_poll_handler() (or in cyapa_gen3_event_process()),
so the driver treats it as an invalid state and reinitializes the
device. While at it, please also use GEN3_MAX_FINGERS to size
data->touches[] in struct cyapa_reg_data, and either fix
GEN3_FINGER_NUM() to mask with 0x0f and use it, or drop the unused
macro.

Thanks.

-- 
Dmitry
