Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780D50EC13;
	Wed, 16 Sep 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580347; cv=none; b=usGE3t3eBdfb3b6BCh9i2xistCQolD4zv3g9IHlDzh9LDq7udDLA2WZUpqqfLt9b9h7ghNb7qqkRqGCl3PMiqGVyYTU4VfN2AlWJr5YUPZxPSP1RrOS7Lo4fLwqV8IfIi5EknSWs6dLRqkbFA8aXTWu1tmo04V39Zc0lv9vmZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580347; c=relaxed/simple;
	bh=1n2xg/JoPY4kIbe3mE4yyuTv5TFw3hrpgNEEZQHM9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9qpZtx11/2JAegA7tby/KdCpJ7Sjp6CgDgyifvDog0zpYXLBCVngbUvdzEQv6ZuVKoQzSWq7X9JfpsBSkcojazZoqSJ1VJnovBsVReeyM6rwPB9VEH7sz1UmBEKhfR6Nf90liHza7xQaknC9K076E3/oBk3nbYjc9NPQ35dQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKjnQsRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKjnQsRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431EE1F0089A;
	Wed, 16 Sep 2026 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580341;
	bh=Hw/R8i8meAA1zGDzRH9AGbiNJd1vryQPS42R/yDvgrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKjnQsRxjXBgEg6lmIflMrd91xGrzhV/zR0ZR5jpj+6ZyBStCMoH2fqEYxe/wTOp/
	 uuVFcEEFaglpcjwXx+GC7nnEhX26Ss2pIXlEsvnNSQFS8l6Pkb1SWxsg1fFup702xH
	 qTvROjAkedcIHSOdcfIbvx9SPLZry36E0S/Squ0SRlKLJe6CYf5COUDCOzAzEo82A3
	 8bUtzxO9UaQrhs9PEnKWVE0Fuujc/v+T3pR4YzwGk6wza+NrmSFFCYrxw+QxFEX/uK
	 jTZzDMzKaGYl2xyTFeOvmyidvxFI1A1EOVCe0XxmCzrX0qyhNj34Ah4Dw+7DVWw88F
	 WZ17BtYeYwyRg==
From: William Breathitt Gray <wbg@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: William Breathitt Gray <wbg@kernel.org>,
	biju.das.jz@bp.renesas.com,
	lee@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] counter: rz-mtu3-cnt: Fix runtime PM leak in rz_mtu3_count_enable_write()
Date: Wed, 16 Sep 2026 13:38:43 -0400
Message-ID: <20260916173845.1820981-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916092242.2001358-1-vulab@iscas.ac.cn>
References: <20260916092242.2001358-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=wbg@kernel.org; h=from:subject; bh=1n2xg/JoPY4kIbe3mE4yyuTv5TFw3hrpgNEEZQHM9qw=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFmrLj/e/GzDrU2HJ6yt1taZ33FOwu5Wtwej4jn+WP29r +bvqFNl6ShlYRDjYpAVU2TpNT9798ElVY0fL+Zvg5nDygQyhIGLUwAm0veTkWF5e01K96lXYbs4 9on/vXDD/N2j/UIvrE8F8zzwfOS2774swz/1A3fUWTUmMMm3rWRrSn+XLDJpwV/Bw/I75Rta40r 3inMBAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, Sep 16, 2026 at 09:22:42AM +0000, Wentao Liang wrote:
> When enabling a counter, the runtime PM reference taken by
> pm_runtime_get_sync() is never dropped if rz_mtu3_initialize_counter()
> fails and returns an error, e.g. -EBUSY when the channel is already
> requested. Because priv->count_is_enabled[] is left false, a subsequent
> disable write also takes the early exit path, so the reference is never
> recovered. Additionally, if pm_runtime_get_sync() itself fails the
> device usage count is left incremented while the hardware is still
> accessed with runtime PM suspended.
> 
> Use pm_runtime_resume_and_get() to resume the device and bail out if it
> fails, and drop the runtime PM reference when
> rz_mtu3_initialize_counter() fails.
> 
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/counter/rz-mtu3-cnt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> index 7bfb6979193c..2bfc92bea757 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -504,10 +504,15 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
>  		goto exit;
> 
>  	if (enable) {
> -		pm_runtime_get_sync(counter->parent);
> +		ret = pm_runtime_resume_and_get(counter->parent);
> +		if (ret)
> +			goto exit;
> +
>  		ret = rz_mtu3_initialize_counter(counter, count->id);
>  		if (ret == 0)
>  			priv->count_is_enabled[count->id] = true;
> +		else
> +			pm_runtime_put(counter->parent);
>  	} else {
>  		rz_mtu3_terminate_counter(counter, count->id);
>  		priv->count_is_enabled[count->id] = false;
> --
> 2.34.1
> 

Hello Wentao,

This looks like an earlier patch submission we've received.[^1] In fact,
I wonder whether these patches will be necessary anymore if the
"counter: rz-mtu3-cnt: check clock and runtime PM errors" series is
merged.[^2]

Sincerely,

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260814134138.1388045-1-ruoyuw560@gmail.com/
[^2]: https://lore.kernel.org/all/20260903090719.3498955-1-dayou5941@163.com/
