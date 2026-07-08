Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4662E7631
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530480; cv=none; b=HCo6gHdrLUutIlJU6trShz7/X2ZfwUe9nBHDKRXsWtybqLHhtNKTjDhuVboSlQrUoN+F3R0Q4tMElXYBLxpbPbSHQBO8tPpEw42H38rmI9qcPym/jkyBxkufcf0lfFQRQp8YzXxXhsbtljliljC6xTT6aAME5ta37hIvs0VVfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530480; c=relaxed/simple;
	bh=Okun8PgF7PUdESpTukMLPfo/8mr/wu4lK2Kd+zVCkCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0VZo6WoLqRZNDJVvIx0Ht+RM5NLBiGYQ1MCHDt2xgse0IDmUmuQjyISt8f1j8LdhVUhXF8TdZhzqvPjoD3tKaqJazlHIsI9MHQo4zXrA7tAi/iU/qcR6myEP1DnLBUYPaIKcNG6quI1NTV0DmFXlOOyQkRK8md1IaW6xH/aq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N91GAFJT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N91GAFJT"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so820835a91.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783530476; x=1784135276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7wFTXwb6Z1kkFm2K1NVbhztTCfF3worZxBUKjCMRONY=;
        b=N91GAFJTo3Hlksu450DpqF01E3fLxMFEFcITn1lwSAzLecXwqB+QMeAQFMOpH0IZJM
         cxTFFRUQosIdgifTKPPtliig/XFu1XErwCrYFLsPbkyZd4bpeOWw5e8VKGpq1rfzJsQ9
         NwltAFFXQxR4UYG7ajOkqb9MQQicvs9+K6vGQCK09Sj+VOx2lCnlOaj+3EbDZAzDWdHy
         nnxeBfycRTd7aY3GEl39Sjr7BnIIiHk3YTVkNiczvv8g+ilvjBl+M3G77oqaOETQZk8L
         CiW79kRzKMBFzcQd9+shfG51P0gWwjZS9ci1Mrp3kysYUhdCytfVa5k3AvMBmtBptQCv
         ZvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530476; x=1784135276;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wFTXwb6Z1kkFm2K1NVbhztTCfF3worZxBUKjCMRONY=;
        b=bP9hZ9Jpu2j7IU2Zi/FMo1M+SAhg7NmGi/5dHM1SMpfzMQfFEl/4tzsrsD4x9Pengi
         VwvhqGRsJGQ4E2LPAGcc4orfzpzo7mdt2bolkmePK688fwDkuk9A2D74LDaDIsGW0WAb
         dmW9l9juPipmE4SJjJjBBsvVl72FV/onqs/pzYXflRk5NstePiPqNoAFvcChsuiOItUd
         kzgFh4nCVmy9rd9v8oD1u2dE0iIGkR8JW4IKS3YK8Z+hBGpWgpMZpCM2/84PgZJQnFt+
         5kGumayYoSBlkORHW3T+OX0oHgF9RnssneymE/Tsak3SuOx8v812QGbd98iwuHQs8AT5
         XTUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrY0cbKdGBEGm+jG6HAhD3XBQpSwNmb25Zr4Xdy4SOwV5GRMkiclXIz+wsjC+UzxuLS8I4+AI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhuvQtYQNWiEPJ4RqnOl6gImZfk5ujw5BqRHSdlHe2VYUZmDSK
	tZ+6zWa7j0ZRwTIiav+khyVICh1BEnsXKoK/3Rj9HF2Po5RE+yJLWLxgJb8gecglrEI=
X-Gm-Gg: AfdE7ck/NGYSV7PiOAPDcy+IO6JyCgvpulzDEkYwHFG2Ud0oGogJ/LMJZrnSynp7IND
	U0mKQCg/7of3plBfg+pRXunRq/tZ6Zii/XtPXyQiZnL688lu+Z0BGNRh6Dt1ooGt5HIBxryvOOT
	0/0ePbFsXechMsuxWXouefqbLp8jy6j3jw0j5YcHIK5J3zrcgdjmZvh3gnUQqpsimVxVcfGe9Zn
	pJz9/8e+lyEZ4W0KVCiUTbtoxy2/yvSitItzj7RL/43K5Uga06Y5wJqrbAE1DxngOu5GbtiKLlo
	TyBSlXT2SbaPGe4NLxDeOLofbQZ1QzCF1bfA/2Xuj5Q1OfDJw7lMxIoY0xyi4lvf8T0uMpPIHg8
	L/t7WyKw3USeTSv9P+fgUCgvcwcjyhRJw5GONJIzVqJ1VVVeLnkYyje9+Lhmp2ueAMX7TtorYjj
	8tFuQ4x75WzWBoczvX
X-Received: by 2002:a17:90a:d88f:b0:37f:ef32:d444 with SMTP id 98e67ed59e1d1-3893fe5bb10mr3499928a91.1.1783530475481;
        Wed, 08 Jul 2026 10:07:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:da71:a4fe:1ac2:9750])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-388fdaa2c73sm1084089a91.1.2026.07.08.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:07:54 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:07:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-remoteproc@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH] remoteproc: scp: fix device reference leak on failed
 lookup
Message-ID: <ak6D6JX1jP1NxNUh@p14s>
References: <20260706065614.389412-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706065614.389412-1-johan@kernel.org>

On Mon, Jul 06, 2026 at 08:56:14AM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the SCP device when attempting
> to look up its driver data before the driver has been bound.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away.
> 
> Fixes: 63c13d61eafe ("remoteproc/mediatek: add SCP support for mt8183")
> Cc: stable@vger.kernel.org	# 5.6
> Cc: Erin Lo <erin.lo@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/remoteproc/mtk_scp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>

Applied.

Thanks,
Mathieu
 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 85a74c9ec521..436656bdfa8b 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -36,6 +36,7 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *scp_node;
>  	struct platform_device *scp_pdev;
> +	struct mtk_scp *scp;
>  
>  	scp_node = of_parse_phandle(dev->of_node, "mediatek,scp", 0);
>  	if (!scp_node) {
> @@ -51,7 +52,13 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
>  		return NULL;
>  	}
>  
> -	return platform_get_drvdata(scp_pdev);
> +	scp = platform_get_drvdata(scp_pdev);
> +	if (!scp) {
> +		put_device(&scp_pdev->dev);
> +		return NULL;
> +	}
> +
> +	return scp;
>  }
>  EXPORT_SYMBOL_GPL(scp_get);
>  
> -- 
> 2.54.0
> 
