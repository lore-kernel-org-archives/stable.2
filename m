Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A2409620
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382587; cv=none; b=eNMtAcESD6Hl01XV+NFCvONEdClS3+bm4w483m0sisnfohNmU+wNW2qt6GnkfvyDLFkPR3LhD/hHjEy907qOzebJATiEk0vnA/mAfzeNxopUN24RhdOnLzxrdufn6InfkDVxc1D+iQOAWvOY/A+VvI8QlAG8V56lafbxn/KUEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382587; c=relaxed/simple;
	bh=8gWEwUfsO3F33rc5Vr/t2TJpJxPQT4ef+ZgW5fdDpk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6qnBduue/WkdQVh+3dUEOFWyft1yKhUVk8M1ZpAWf1+Hark0fc1JiTTzESS/AmMXyG+9pMFu2eptJqe8rvFAsHUK0yx4m0wmIGxV4McEgp+3BokSaqHnt0lK9WUjs9ZVh4ow+wyB73X6VQEJN/XgTXiaBPvsxtqdGJDF70aNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADONGWES; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDXTH48a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADONGWES";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDXTH48a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786382585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scdHE3f1gT3tI1szOZtkMdShahjFVVqLG8G2E2kb/84=;
	b=ADONGWESx0JBwlwenRzW8TL30467+KfWrD7JZJ7eYJYDlwXlUJIx0m11Es9+/g34QP92Z+
	C0bmcascUUnHdb0BFzPtDDAJBlmZtEScVmgF093jaMhsXF9GUI8Mkf8KCguSXzRqyMv7Q+
	zD6g14PPx5bdj7QBxZMoP19UtkyNL9c=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-eE-_ubloPeiRHor1Y84mbw-1; Mon, 10 Aug 2026 13:22:54 -0400
X-MC-Unique: eE-_ubloPeiRHor1Y84mbw-1
X-Mimecast-MFC-AGG-ID: eE-_ubloPeiRHor1Y84mbw_1786382574
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-82014436716so68151227b3.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786382574; x=1786987374; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=scdHE3f1gT3tI1szOZtkMdShahjFVVqLG8G2E2kb/84=;
        b=MDXTH48aQ6UhqSgqDegVF+Oiwy/odGrUx4dk5PpilLiRC9HIVCg4Yv3460G5qZQEO9
         Dv0WbDtqg2x5P54QuykjdCKMGtENfEsNQoi8iXUjExfUpMr41mw4VdnND6EECNNUarAh
         sNVqSxO8IPfdbZNuMDnNVdBM3GVjDGVnKdv2GTDO22vQmhnN6+OdCif6WeTjC7vdyqB5
         bAjZkT+AtqMkl2r+4Jk5/XoN3TZjQOSd0fZqBkaaOaHEQcp6hJhOXEosFtw3om4n+DwI
         oMNUU6B5h/N/ZCWVz3MUpAuDMjSxxZHxX2Keo14ZPtruHhwTK7F2vEffRu1ogmR531el
         sOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786382574; x=1786987374;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scdHE3f1gT3tI1szOZtkMdShahjFVVqLG8G2E2kb/84=;
        b=iUm5INgTuTo1xQ6PGKpxyWFA4bEOUVSOaNW0lChE5u3xh/iJqNZr/q6YIpqBiu1rjo
         zWK3LduM/LaPo2lbHrZxfhmkjrPTIihJhdWnSVNpp3B67OKL6bcwHTnvCB4DLV8sFB5n
         HkAELHd6dCzK+NgaA86mf1WLGS+fB31nwLDB+QDcm1ITW9IGR8eoKCAYGwnCs+W53M4b
         wqB2mRt/vR8NQ63SGB2hzQ8r3xX2Zjhjib66fXWy9iPOgetYoScfthIT8KPBUdRbjPeA
         SfVOKdXzPO1pCjeI9pxGXKKiA38oVazClasrace0mWRsD37Djcvwv6P/hJ3qhVPp4rQK
         aT5A==
X-Forwarded-Encrypted: i=1; AHgh+RrkSoX8hvjFbFo/u4lxAlTTiq/SHuW1p9sV7GsGcSzfLa9exFpqWmNOsb9oJu2T3bnca6VnOd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCyxO/5mI05olyGDkGDzOEBPCo7SOr99meQny6R3KN4b+hG7b
	Hs/mpws4zbn3Bt06r3LQe8N0HQ2E0SjlsCmq8XKA/YlFd/Sf7b+DgYlmIJcGWgbDPreEgM8Wu2/
	pjPBTd3Cuyw53qMMebzZcjm70Y3Zicu0YAfu9KV5q9R6S8RqKpXunN2iqbQ==
X-Gm-Gg: AR+sD12DqxyXRxgzu91XpICYRCPuU2gEqBLn/9ik1oloTs2H6oGdJihg08jMD549cWq
	WSWocdzAhbhuhXsj5zqM1Omnnc9B655yP140mXAwbp+n+1uQdH/UJTvirgcN8IIn62ySHGqeV5z
	f9LQ9hsw5PNg3PAQxUciGQQr3s8YGFM6RkF6ckp+kwsIJ+Md2LLrNDBmfHZbJGO3emuzLbDmp1k
	StWp+FVzBjnRwxUghdz6ACFcBKG8UhSwPwZ0E0VXKRvsqbcczET+CL3DmYo60aTY7mnAnYg0bCI
	7sMTZxSs4BOS/58xdnQXevnaA/S4HIr2gunOI705pt0LbdRg2TaFE3/2rB2CduAjCTgf3u3tSzR
	94vOui0mwwNPKSiwOF2IV0ogPpnRPL9mhDjs=
X-Received: by 2002:a05:690c:f06:b0:80d:c2cc:f673 with SMTP id 00721157ae682-82d2a8c4531mr20804047b3.20.1786382573966;
        Mon, 10 Aug 2026 10:22:53 -0700 (PDT)
X-Received: by 2002:a05:690c:f06:b0:80d:c2cc:f673 with SMTP id 00721157ae682-82d2a8c4531mr20803727b3.20.1786382573576;
        Mon, 10 Aug 2026 10:22:53 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f577c580sm60710857b3.27.2026.08.10.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:22:52 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:22:49 -0400
From: Brian Masney <bmasney@redhat.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: imx: imx8qxp-lpcg: fix runtime PM cleanup on error
 path
Message-ID: <anoI6eX9OzI0bsFy@redhat.com>
References: <20260808080215.2669452-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808080215.2669452-1-lgs201920130244@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 08, 2026 at 04:02:15PM +0800, Guangshuo Li wrote:
> imx_lpcg_parse_clks_from_dt() takes a runtime PM usage reference with
> pm_runtime_get_noresume() and enables autosuspend with
> pm_runtime_use_autosuspend(). The success path drops the usage
> reference with pm_runtime_put_autosuspend(), but the error path only
> disables runtime PM.
> 
> As a result, the reference taken by pm_runtime_get_noresume() remains
> unbalanced on registration failure. The autosuspend setting is also
> left enabled instead of being undone with
> pm_runtime_dont_use_autosuspend().
> 
> Add pm_runtime_dont_use_autosuspend() to undo the autosuspend setting
> and pm_runtime_put_noidle() to drop the usage reference on the error
> path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 18cdbad40c6c ("clk: imx: clk-imx8qxp-lpcg: add runtime pm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index 1dae3410ee99..262645bef62d 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -277,8 +277,9 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
>  		if (clk_hws[idx])
>  			imx_clk_lpcg_scu_unregister(clk_hws[idx]);
>  	}
> -

Don't remove the newline. With that fixed:

Reviewed-by: Brian Masney <bmasney@redhat.com>


> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 

