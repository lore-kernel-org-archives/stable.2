Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553B46985F;
	Mon, 17 Aug 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990554; cv=none; b=OKa05vJVeYD0Vy6/2W2Anfb3NGsqQawmnrotT+zwBpsm+qRLyW1b9lg97ABI539eLfmv1F9XRbLOECDQnrXwxWKPvg2IdeJUCCSnYtSquOy4nxw7FkAZ4Rkb3a0cwOthQeLsE8R1Ga0JrpZ5JO3Bl7hemS/sDZBjIESjt+lkffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990554; c=relaxed/simple;
	bh=eGyBb01apftUQ24cX139zedQVRfdr5/PM74x5+NmGwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5xvyuAR5lbqbTsO7Fhq9jVmW4vmwJpFG/JCyD88zlT73WWBQlMvh+vSl7sFnNrhykoYaKngH5kHPi0xiNBqp29OEFIJ1s+noiX6HwHLkHKKVhJpcOTZheYzcpZQ6/1U7czex6cfrrx+QCoyT8BJNdLGpJ31+0ugQyHVwYDNeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCXwKpVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCXwKpVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567011F00A3A;
	Mon, 17 Aug 2026 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786990553;
	bh=H+2eX47stH/q2JAw3b8ab2nSSp3xaOSVzVDzvbM7fXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCXwKpVhll6YcTLKNRWWDQ2SgroTkWAx9ELUDk1PMA6ABTgyXyy+Dz0OwlvQb/5YJ
	 F5Mx/+K5v2cG+mo6GpipnObuMWGG+A6Sknn6zxlM6RQ+AWzsoLccrmog6oB+bJV7LJ
	 DqRJVsuGPiEfO7msvUKW8YKeE5Tnv6z5dvbk0tCGDaGVKS6pYro6il1WzfuUzz1Lzs
	 O8FipBF4xXo54N2V5/zsJeUvjv6m6A1b+TAmBr0Al3gg2tOQJo7Qg/W0mW/gIQCYiK
	 fAOSu5w6mt9ygfcddn4O2fRsCA2RSncPmzKW5i4SnLVmAnwioxDu10i+8zMhw7qTTa
	 5Qm7RGeuHCGaA==
From: William Breathitt Gray <wbg@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: William Breathitt Gray <wbg@kernel.org>,
	david@lechnology.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: fix refcount leak in ti_eqep_probe()
Date: Mon, 17 Aug 2026 14:15:43 -0400
Message-ID: <20260817181545.190769-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260604094036.3777747-1-vulab@iscas.ac.cn>
References: <20260604094036.3777747-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=wbg@kernel.org; h=from:subject; bh=eGyBb01apftUQ24cX139zedQVRfdr5/PM74x5+NmGwI=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnN/psv7d4rErKXw+tS/JpX8+YVRE99OO/c5jUT3z2YK Ft622R5e0cpC4MYF4OsmCJLr/nZuw8uqWr8eDF/G8wcViaQIQxcnAIwkZs7GBlemZxv/b+U2yNT U8t3zbaGQmanndzH7UTeBVxvVQk1/RPPyLDr8aTXbzijPq9W2CT9JeN0lB9HzYNqoVLZv9p/+H4 WnWUEAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Thu, Jun 04, 2026 at 09:40:36AM +0000, Wentao Liang wrote:
> After a successful pm_runtime_get_sync(), ti_eqep_probe() can fail
> if devm_clk_get_enabled() returns an error.  In that case the
> runtime PM reference is never released, causing a refcount leak.
> 
> Fix this by adding pm_runtime_put_sync() and pm_runtime_disable()
> calls before returning the error in the clock enable failure path.
> 
> The same cleanup pattern is already used when counter_add() fails,
> so this change makes the error handling consistent.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/counter/ti-eqep.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index d21c157e531a..84fbf500b0f8 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -548,8 +548,11 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	pm_runtime_get_sync(dev);
> 
>  	clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
> +		pm_runtime_put_sync(dev);
> +		pm_runtime_disable(dev);
>  		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> +	}
> 
>  	err = counter_add(counter);
>  	if (err < 0) {
> --
> 2.34.1
> 

Hello Wentao,

This seems similar to another patch we're working on.[^1] I recommend
reviewing and commenting on that thread so we can consolidate there.

Thanks,

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260529095834.2561-1-sozdayvek@gmail.com/
