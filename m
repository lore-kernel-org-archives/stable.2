Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68736D503;
	Wed, 16 Sep 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579648; cv=pass; b=DhaFEPVEvx07MhHGk1Zo9lpPbn8gHCDLmAxzH9Syfv+fIT7DYcDnUPo3e8hjCI0RTsMKgv6XYHrv8/4Ncx0W36kmxh9bGffwxpPCLIV5F6oNatUPHs302SySHq9zSI5Ds7Cmt0O4ieYctPeUGuuJSrulprkOfhoZnFxxdhi788g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579648; c=relaxed/simple;
	bh=92tg37CmSF1ufzebv0RSmYfnRdV6jfMV9hOZCai3IOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwbkByFPwgeHYxvZv2RyskzRu+O39DQqjzbSVQSaopNbehD7xyvc4X4qFz1ocvNcmlM6STt+N3v7KjbQN28FkPwcOdVmcjDOHko/SVyleeC/Js60ydbzvp9IKhTl2a9iruW8bUo+5Zf3Ufcj5BgYH7xxl7mNcoXLtfdLnFub51g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=JCN6Jf3V; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="JCN6Jf3V"
ARC-Seal: i=1; a=rsa-sha256; t=1789579634; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OcWGWbCtQyAF4qkrN7p4azhGGDdw+5U5j8VyYOYLb1gBsSy3qgD5MLDMhBmn9+QjxkOqvYGfCX1flfr+kKYJxLwzsFX1cRUoA0iZWajNauXTL5DcfCF6+8H/CZOCKHJH9rZ8Z0yGzLIHMXFqU38Th52vBvswiwzlz/YcrTqiqrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789579634; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yu4I8aA/dSCWiNzd0EiMaIb1hEBPZBMS5B0bclDwg3U=; 
	b=j1EjAJDPWLzUqrtf/AWps9jhj7K6lk233J0lmD2EGKZD6Xs1NfIr5FzpvHJvh4jpa3HwPTEXTskgBmeApmAwq8PIskOPdChg2bnHC/+cNVLIvBRe5ar9uK6zK/DSVa3694wXupmzLoyL1VBtW45k49r78EvTopgQqZ+yBA0WQrI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789579634;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=yu4I8aA/dSCWiNzd0EiMaIb1hEBPZBMS5B0bclDwg3U=;
	b=JCN6Jf3VoU2FPQcE7Cla4Ac5E0bw+bPSvMGe+NiYJCMTz422U1TYnCsuRJOreAtD
	2ca+SRFf5xxKjMxM/+jr4coKAkqbDzVU5gThzZjCCf30AOZ+/Ypuvxar3/2759XUcmy
	W5TjQELzpkBQvDKB8T7xNYVjeI5pzIdNItz7RHY0=
Received: by mx.zohomail.com with SMTPS id 1789579634133586.5912753636819;
	Wed, 16 Sep 2026 10:27:14 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] media: rkvdec: do not destroy borrowed SRAM pool
Date: Wed, 16 Sep 2026 13:27:12 -0400
Message-ID: <h_fJ5CZXS3anfaQzbf4v3w@collabora.com>
In-Reply-To: <20260915140511.2429792-1-lgs201920130244@gmail.com>
References: <20260915140511.2429792-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Guangshuo,

On Tuesday, 15 September 2026 10:05:11 EDT Guangshuo Li wrote:
> rkvdec_probe() obtains a provider-owned SRAM pool with
> of_gen_pool_get(), but its error path incorrectly destroys the borrowed
> pool with gen_pool_destroy().
> 
> of_gen_pool_get() returns a pool managed by the SRAM provider. The pool
> is not created or owned by the rkvdec driver and is destroyed by the
> provider when its own managed resources are released.
> 
> Destroying it when rkvdec_v4l2_init() fails can invalidate the pool
> while the provider and other consumers still reference it, and can also
> result in the provider attempting to destroy it again later.
> 
> Remove the incorrect gen_pool_destroy() call from the probe failure
> path.

This is indeed invalid, as the gen_pool is already created when this driver is 
being probe()'d.
The sram module can only be built-in, not a module, so we know that the 
gen_pool will never be destroyed while rkvdec uses it. That allows rkvdec to 
just get the pool pointer and not have to call a matching put() function as 
there is no need for ref counting.

Reviewed-by: Detlev Casanova <detlev.casanova@collabora.com>

> This issue was found by manual code inspection.
> 
> Fixes: e5640dbb991c ("media: rkvdec: Add RCB and SRAM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/platform/rockchip/rkvdec/rkvdec.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
> b/drivers/media/platform/rockchip/rkvdec/rkvdec.c index
> 061281f903f3..4541ef9ee3b9 100644
> --- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
> +++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
> @@ -1857,9 +1857,6 @@ static int rkvdec_probe(struct platform_device *pdev)
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> 
> -	if (rkvdec->sram_pool)
> -		gen_pool_destroy(rkvdec->sram_pool);
> -
>  	return ret;
>  }

Regards,
Detlev.



