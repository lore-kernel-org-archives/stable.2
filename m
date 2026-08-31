Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C0242D9B;
	Mon, 31 Aug 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788140285; cv=none; b=BjE0Q1pcBsbzljzjAvN1xg3a3/EMoD6v4Z4XCEdpwBVU37cjsI3TyOG0iAOGQsQLTa8vJLBKFxKAd4n0ajOtSAqyWUyW762zoX6c9VHe42Rk4FXNeRjUbjlohdhXzBMJOUJy9xouy5GIoI7IAMdE5aPQVML8q2HCjsjatMvD6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788140285; c=relaxed/simple;
	bh=FTMokWpOROALywajLJHQNBXWNCPo4o7kFAhDGjYhtrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsN/97xNkL0CwoY0XJdNRZ9MFrDSa1PwWIV+tHLOKtbgLM9UvOh9A8+WmqPtgwJFd4Gw5x42fhKs2jaQyHQOGwl3Rf2o5eCftY+li5VJwpDq1yhDr94/NPyrd9rUvL4NUkWFo1rlu+lH8q1dQZoK8x35/pwmyhW+yYqQc3f6nH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markesler.com; spf=pass smtp.mailfrom=markesler.com; dkim=pass (2048-bit key) header.d=markesler.com header.i=@markesler.com header.b=Tqlwwb3i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPzqWdUR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markesler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markesler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=markesler.com header.i=@markesler.com header.b="Tqlwwb3i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPzqWdUR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9342DEC029B;
	Sun, 30 Aug 2026 21:38:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 30 Aug 2026 21:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=markesler.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1788140282; x=1788226682; bh=lCsO5K0kDnAmWtkvgKobE1mzl2/l4yUf
	x7c2/xcebko=; b=Tqlwwb3iSlnWNQTC5quOE/onjxoGREa+c2jFJiG4NCfD2Whc
	srKwUaisMCkjxANos6gVxVv7ZjA14jibC8I3Amo8B0xYbPl1ZvZYjso+h5PmdqGJ
	reS9uxEP2AI1fy0vFZwfC021qTsgl8m1g9kE3mNsm0sMa8SjpOjWRtfxf7ryOYJS
	CbKE3GyQD/6O1gHu8pDFBcCpX6PWEF9964iNWms0HF20blHVDeQZorbRFNEX620q
	+UxPndrBiKlwt/iGywPJqNwT/dAIkA59KXc8NSluTRDmXFMwEuPcnDX9UOJD/2sd
	7Zte/Fc+9HNb5hCuXeIoY3vuvCvjQCLDypSXxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788140282; x=
	1788226682; bh=lCsO5K0kDnAmWtkvgKobE1mzl2/l4yUfx7c2/xcebko=; b=U
	PzqWdURX4C3WW2lEdZarWak6D+70VKpVtlU5xUKmBs66qI1HR88A6OUDZZbfkhbr
	nm11VoZ2dQJEJ4rSSTfTBME5NcLOGosYtHhBCPR9KjUc9rKBNjkEOaDvfG9oXBvS
	3bOxhdZBOMszMQh7DU9h3X1pSYkpny7BoH3B4jzVFVkFeOaF/RymWmHDoYXRx4gY
	lyi1H/jx2jjXU2vGroABO5f7cPIFDcPtOtuxK0qjFFsAb5SSrp4+oBfqIkOixuay
	Cmewy4HJyMgENfzEdvrd7NM9IxTCK6AdnPvHAffp+pDcQGvS7yBIfAB/eguY1eya
	edqNjHw3yicszqZqqYCww==
X-ME-Sender: <xms:-tqUaqYAjspgHXm4y6DLwxT3OkBAh8wNQHJ2AkJo3sIqputCmOsNfA>
    <xme:-tqUavpu4V4G7TuwSGPFDtR1qpoA6jSbNy7w153o9Lz4BYDcNqZWn9uCa1kX9TgK2
    JFacpIJ-requTXUoKuuKH0KcARDqvZZidrsBxQbmfWAXHDmiuLsl8w>
X-ME-Received: <xmr:-tqUanO4bPXUs8DDiMBOuvRzkRyMBUcMBJ8yFAYexCpOlNDdUQbdYQmpD6jaFFIcclIe_fyvpdjInaeCXicr0Paq8-_-g0c_8Dw>
X-ME-Proxy-Cause: dmFkZTEIBKiYt/prjzRrfdoypg01rWKs9F5WGvnoc0Lci1DTTrf8F9Z5hO8gCM0XzH9+Wk
    RfYsS675w6n4m/mS4kJzky4LPDpKyCFGt1GK/GHYTpOVe4ZULnJn5vmT/IlMX4VRYEVL6d
    AjW+A3Vml0IUNKWpYTp5uFrGNfByhu46itQyuOKZ5AEpma3xcqObByITfw9KuavdfFjiMX
    tAlvHhVQ6MEKjpCyPTw+b2v3dpHN1qcn1E89KR62zBupSHPG/TjH9Svxp14Gwm6qjqcXcO
    GGEhXJkYSIj3P1iECTROI3PMOT0thtf9cJ0h5wWY7oOEjKd5tyB7k+dQYLEScyMOxDSdX8
    KApq0CA276iuwU7nBRSmEqDMu5wVyR8x6Emx6EVvLKk9yOZyQgnR65cuLtRBaeh2muY5B7
    KCsk8oPiNECDxjtSGWeBIR8Qi33PRvAs98gRGJvp318ujnjJue5qzn+BCOnjAS2WLibVId
    4rEt4BQd/WFS6DZ/92K/ILSHp/bYALNTKXjLIhRpibiRDKMTCyY1HiEjJvKWXHGa3+itzs
    EqDDaE2klmJmN2nzyg2CFu4QfUb56TzYJ06d6Qn5QfrDXQFwPA5Lw+/bs5iQ4UmXKN88n/
    +G8qrnRxUptRRzx2yOYpmQNT8yUvou5gEuc1YUi1b6CzcmOwLT272J3Uuz8A
X-ME-Proxy: <xmx:-tqUaipJtX_w2x9Vg3JlooV3BqQ7Z_JbMY7StqiAD1DLfVxkmSQJ5A>
    <xmx:-tqUake3WGaI9GOHf0k1j1PZtuP0PoWb_iUOOjuz-3vstA0j109f_A>
    <xmx:-tqUagQzMSLNDYPa-ifmFJqxPM6johWWgekwMutEPfIQ1lMtZdJWKw>
    <xmx:-tqUalasUrYWu5o4fM3ZJP_R3LUtBhJTEA4YoaTySwKIonU4GnY1_A>
    <xmx:-tqUakuBrvFvNlzkhO3hUhRjIyaqODzWPhPGq2pWyI0PRhC_ayKkH6cw>
Feedback-ID: i31494998:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 21:38:01 -0400 (EDT)
Date: Sun, 30 Aug 2026 18:38:00 -0700
From: Mark Esler <mark@markesler.com>
To: Paul Hollinsky <phollinsky@holtechnik.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Rakesh Kota <rakesh.kota@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5: fix all temperature reads
 failing with -EINVAL
Message-ID: <apTa156GmmYDy4sE@markesler.com>
References: <20260808023938.57146-1-phollinsky@holtechnik.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260808023938.57146-1-phollinsky@holtechnik.com>

On Fri, Aug 07, 2026 at 07:39:37PM -0800, Paul Hollinsky wrote:
> adc_tm5_get_temp() rejects any iio_read_channel_processed() return value
> that is not IIO_VAL_INT. Since commit bb21ee31f575 ("iio: Fix
> iio_multiply_value use in iio_read_channel_processed_scale"),
> iio_read_channel_processed() returns 0 on success, per its documented
> contract, instead of passing through the value type from the underlying
> read.
> 
> Since IIO_VAL_INT is 1, every successful read now takes the error path,
> so get_temp() returns -EINVAL unconditionally and every ADC-TM5 thermal
> zone is dead: with no valid temperature readings the core cannot
> evaluate trip points. Observed on a SC7180 Trogdor Chromebook (Lenovo
> IdeaPad Duet 3 / wormdingler), where the charger and skin-temp zones
> report an error on every read.
> 
> The check no longer serves its original defensive purpose either: since
> commit 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale()
> precision"), fractional value types are folded into the integer result
> by iio_multiply_value() inside the IIO core, so the return value carries
> no information beyond success or failure. Just drop the check and rely
> on the ret < 0 test above it.
> 
> qcom-spmi-adc-tm5 is the only iio_read_channel_processed() consumer in
> tree still testing the return value this way.
> 
> Fixes: bb21ee31f575 ("iio: Fix iio_multiply_value use in iio_read_channel_processed_scale")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Paul Hollinsky <phollinsky@holtechnik.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index bb6222c8cc5f..af72db6299cd 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -369,9 +369,6 @@ static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret != IIO_VAL_INT)
> -		return -EINVAL;
> -
>  	return 0;
>  }
>  
> -- 
> 2.55.0
> 

This looks like the right fix. Bumping it since it's been a few weeks
with no reply.

Rakesh Kota already fixed this same regression in linux-next
(0c569e22020f, "thermal/drivers/qcom-spmi-adc-tm5: Drop IIO_VAL_INT check
in adc_tm5_get_temp", applied 2026-07-27), but it went in without Cc:
stable, so it never reached a stable branch. Paul's patch has the tag
this needs.

It also hits sc8280xp laptops (ThinkPad X13s, Huawei Gaokun 3, Microsoft
Arcata) through the same qcom,spmi-adc-tm5 compatible string. On the X13s
it's the only software throttling path on a fanless chassis: no
cooling-device entries anywhere in sc8280xp.dtsi's CPU thermal zones,
just the board-level skin zone. The zone stays enabled, since it's
threshold-interrupt rather than polled, but get_temp() always returns
-EINVAL, so no trip ever evaluates. During an 8-core kernel build the
skin thermistor hit 73.7°C, past its own 73°C critical trip, with zero
throttling applied.

We've had 0c569e22020f backported onto our own 7.1.10- and 7.2-based
kernels for a ~week now, confirmed clean: the zone comes back enabled
with correct trip points, no disable message. Neither linux-7.1.y
(7.1.10) nor linux-7.2.y (7.2) has picked it up upstream yet.

Mark
