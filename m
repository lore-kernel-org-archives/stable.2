Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D633D6D6;
	Wed, 23 Sep 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153353; cv=none; b=o53pXy3qnua/38nGTKvH+PAARe/np9AR0kMfJ2YX6dEWQA7ZkTS0AYnM4hFa6acD/UepYn6iDPfQLaoJv0jPwO2F7SrqPpf58qBklS4sNrU4k9v7nUCHPthYACP4IlqY6sQPKFMGJu2vDdhFjgO5UUamwzAYfj3spiZuMhbDpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153353; c=relaxed/simple;
	bh=WMInSkDiedkFkgVU+MIhWpHri5pvptYn/yFijzsi0n0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fQwQMwPaKffsAikZiYnS1QoJtF05sFKDrGzxJEXXhSURll6mWExWabAm3/UEhrmANH1UwBoV0LRrv0ybfw6UivsFB0E84Vw0DEPoT08Ib+3MRbBepbRLlP5U0Yr+TTD/kLx6cMQuA8BHEP0VjjNs1txecoHCr4dnbbYpsNFjYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHuSWKpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHuSWKpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0B01F00899;
	Wed, 23 Sep 2026 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153351;
	bh=HAzAbRseFHRfPkM/W12gGZK0ib8Fu7rDz5eSEN1NGzI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=OHuSWKpvJUN0xD1KZKdsjpZpG9E35wmc0zS05zrTmSQQhD9ZPFuHOvKHAmwS0hCN5
	 oa5a6EuS0zMjFDXzYGGiVjLFYRKiSWo9GhChRNq8CYOuD63NNKVb3JHmzQJkcBpSId
	 mzdsoo3zgiYer5rc2ZmvpT4/KqVYSgqW5eRqQQMVgKATfI/Zm/em20pMK8sfDHJi82
	 YoMxNP2LiVgNfn4PsOiwlZcOdOxIKRaruIPPO0lerDvBnbNwgnMGAG0V2Csbv4vZ1v
	 /T9Iue+c+hSlb3CW5MrglwmjU61mVpE7aVq1NliW82u1vQdAYOUucehHJ0t/64KgzZ
	 wIfzKeo7C6/2A==
Message-ID: <c03262f2-419d-45c8-9b29-f3bfe6680744@kernel.org>
Date: Wed, 23 Sep 2026 10:49:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: rtl28xxu: fix SDR platform device leak
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Antti Palosaari <crope@iki.fi>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260921081542.210151-1-lgs201920130244@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260921081542.210151-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2026 10:15, Guangshuo Li wrote:
> rtl2832u_tuner_attach() registers an rtl2832_sdr platform device, but
> if registration succeeds without a bound driver, it breaks out without
> unregistering the device.
> 
> dev->platform_device_sdr is assigned only after a driver is bound, so
> rtl28xxu_tuner_detach() cannot unregister the unbound device later.
> This leaves the registered platform device and its associated resources
> allocated.
> 
> Split the registration failure and driver binding checks. Unregister
> the successfully registered platform device when no driver is bound
> before leaving the switch.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: a2f7f220df5e ("[media] rtl28xxu: switch SDR module to platform driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> index 487c6ab784ab..3603d0cf638b 100644
> --- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> +++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> @@ -1391,8 +1391,12 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
>  						     "rtl2832_sdr",
>  						     PLATFORM_DEVID_AUTO,
>  						     &pdata, sizeof(pdata));
> -		if (IS_ERR(pdev) || pdev->dev.driver == NULL)
> +		if (IS_ERR(pdev))
>  			break;
> +		if (!pdev->dev.driver) {
> +			platform_device_unregister(pdev);
> +			break;
> +		}

Looking at other drivers, I think this is incomplete.

drivers/media/usb/dvb-usb-v2/zd1301.c, line 142, does it correct. Note the
try_module_get() call that is missing in rtl28xxu.c.

Regards,

	Hans

>  		dev->platform_device_sdr = pdev;
>  		break;
>  	default:

