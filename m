Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B6371860
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075395; cv=none; b=JY7+QiIi3V0mR7jikEFNXeaESWZK5+bJ0LzbrmGn7rTyJ1x1DzRpgyfW6qNsmwJSe2TxhRRLQ2NGfLmpqJ/uDHJf2MTfRU7g+Jc06p4qEvYRXNaaZy95nDVquww9COjLQNpzQunAUTSUxrq6McocmRHFeCXoGh/6dcQ8zl9pnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075395; c=relaxed/simple;
	bh=KK3BxFyY+k1mBTx2IExWA/ouwxlV2Df+c3wdgi7Lk0o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS6KS+x2p5Ag/TfND0dXDWXXtjBsBjJq6+avNTC14iKOrJolV7dRcIYasm0gDuOjuNvXR/H9DIDT0f/d1rCHC2xuzfrQjDfHo1dow/Jw2NS/FSOPS6RSOmWp5HqAlJgg76cwreYfQAgyQDbP1bbdWDU8+PeJH6gH1tN3Px680DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyszrwGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyszrwGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FB81F00899
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781075394;
	bh=jtHvcgqAu8v2YPctakrIYsBNQrHANt0cF9AvYDlwPQ4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=lyszrwGf+ZPaiiV0PeqShNWNbgTtzndJExdRpbn72JvsnAjHx6nq8WGf7riT1PfI9
	 4IumPqXb/9cB2FslZ0Pbnu31jtCtChOESA0yUFhBJl3yCRf7P0VUvP8CE8Tduq+Xmo
	 t0aC2kX0ECCJRvX6OESXwBzKheyX0u07j4KNhfmt025wQRbpn67mbWrHB3ZhNZvCB+
	 WrgT9advMxtmjlvwN5jyuGj3ak30cbM2b2FEoPzts+keFOTqx4aa7/GP7MEbZzFNLf
	 GmV/0/OpCDSYDHCzgVc1RHwwPwuNX3PzzMtzh+Laju6ytm0cQ1eJduyGcmEAwMTFmy
	 Os55XLLp+kkcA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39666f49929so57312011fa.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:09:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/YyOIbXkWElqF9mya7f1Pv5llB5MrUIqoKfwrN4+psADNnlf7wgtulL1nHdfg28PprmOMiu5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxygUbIGSOLIRfuDaCT+C+hFhmkP4ZJjII1KomXSeXzGkuEntY
	9zKVamypArIdc7gp9UIzHURSyqhLy6BlPJ/coDkNRDUNaCtRsdYIFPRmh4GpAypSDXDwnJmdAzq
	k2nCuLRs0LazVnvuVszgd3EQvp8pQgZXWhdJzATUdrg==
X-Received: by 2002:a05:6512:60b:b0:5aa:6dfd:459e with SMTP id
 2adb3069b0e04-5aa87b8e1bemr4673923e87.7.1781075392952; Wed, 10 Jun 2026
 00:09:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 03:09:51 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 03:09:51 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260610030513.2651018-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610030513.2651018-1-haoxiang_li2024@163.com>
Date: Wed, 10 Jun 2026 03:09:51 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfjpibfmnHKi1GeMRCgDOc3=+1_C3aJfYQwR_YMcHtC_A@mail.gmail.com>
X-Gm-Features: AVVi8CfY527vYJqPCTKFLvrHgAhLfpoYrAWJS-RKMwI2pvUAHuO9GyiDhNNz-o4
Message-ID: <CAMRc=MfjpibfmnHKi1GeMRCgDOc3=+1_C3aJfYQwR_YMcHtC_A@mail.gmail.com>
Subject: Re: [PATCH] i2c: davinci: Unregister cpufreq notifier on probe failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, brgl@kernel.org, 
	andi.shyti@kernel.org, khilman@deeprootsystems.com, chaithrika@ti.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 05:05:13 +0200, Haoxiang Li <haoxiang_li2024@163.com> said:
> davinci_i2c_probe() registers a cpufreq transition notifier before adding
> the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
> releases the device resources without unregistering the notifier.
>
> Add a dedicated error path to unregister the cpufreq notifier after
> i2c_add_numbered_adapter() fails.
>
> Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/i2c/busses/i2c-davinci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index a773ba082321..a24c3e8b87ff 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -818,12 +818,14 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	adap->nr = pdev->id;
>  	r = i2c_add_numbered_adapter(adap);
>  	if (r)
> -		goto err_unuse_clocks;
> +		goto err_cpufreq;
>
>  	pm_runtime_put_autosuspend(dev->dev);
>
>  	return 0;
>
> +err_cpufreq:
> +	i2c_davinci_cpufreq_deregister(dev);
>  err_unuse_clocks:
>  	pm_runtime_dont_use_autosuspend(dev->dev);
>  	pm_runtime_put_sync(dev->dev);
> --
> 2.25.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
