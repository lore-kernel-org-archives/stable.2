Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794826747;
	b=15d5NbXct0GXd9X5QOja/lRxV5m+4HIBkcd1yx+geQWCTW+y3gO+GPG2DRFy8d5LdXmv
	 vJF+pBYDu3334QIEgsWe/GX8Oiib+DaMqb3GDGBCe9kWouUewFz77oI3+3ztAME6yOtcq
	 8q5NKHFlNAFTh5/x9tU39WjwYSiFXPoRObKASf2MY5vJ8X7tmPaAjLoXl2dBzDhMi6mpH
	 U0yb/ss+FESSxCVOqZ2r/oXyW4FwUGnKpwEJdnUif9tTyYisAwVZaEzJOuL0ssXsBoQDk
	 iGkL0Mi3X0G+c8XIuflsCF/fEc57cp3MqpAaMFffL3iD+OEiAYxBJf+HIVABsWpEaRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826747;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=H0/JMO0MVBV4Zw97lRkerZQkk83rH+m9BE4n2iCqH98=;
	b=ZGZJ6ISMKRK8aNiksr1ZALXpy9JPqfePKHD2St6RyvTyFaNGCTeqMd4a4XQaMjbMD5Q8
	 ndnumBKNyqdEYEZYX58RNlJhcnrT+F/KNyX+WSb+eEZ3dCVmrJwz4UWq4+/hySITDXQSL
	 NIAo81QlPqa/E9tI7FjMjM/tmzh8aE3gfRqm+2v6Rh+ORaJufKSEyK6NzlbGV2BmP9pNT
	 OxGR5YHYQYJe9fAxzNDYnPofs13677ks9eiWb5zE4Mt2DalJ+dEl6sBIulGvTsjR4cV+t
	 ElCC9yrAUt+rpbZgvpgnWtAwzePdhx/1UN0lQIjG3mX8xUjtcQbfAKFoNI3j9pHVmog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gmYoRoB6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C9606A32F;
	Mon, 16 Nov 2026 10:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586C9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gmYoRoB6
ARC-Seal: i=1; a=rsa-sha256; t=1794826723; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U4di7FQLEGmh5daOcGk2o50RD1RZRFsdi9aQoA8ojjLbUX96S1kCd8uSWRqLueoimcp4P7JKDZYVX4oKgLEV/m4NJbcoxgPMOKNuFlJdap9YOtxhQI4CpqdulRa2+6yLW9XDDT6LA+V6n7yB6rZxRtrtm9AlpPztUPNZH/iOX2c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794826723; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H0/JMO0MVBV4Zw97lRkerZQkk83rH+m9BE4n2iCqH98=; 
	b=NuORiU6iqRD+GYvbIZWS+GNV1E4TWx6iJwKNY9M37u/rLqNJNTyA0VjewG1qB1/Gg/wFrFqqTSUmOaDbwwBbfV+mHYJidjO1EadWsEmQwdNTuDk45z+w2eGVjdN6DYoifgNy2dlMbvUgXMPgFqM40ZQzrNmq8smMAyZuzac7doc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=michael.riesch@collabora.com;
	dmarc=pass header.from=<michael.riesch@collabora.com>
DKIM-Signature: a=rsa-sha256; b=gmYoRoB6F3PFZlpxFpHCOUFln6iGvF6CHYby8KvdogacxOk8YQW6aSHLgXr+P81MaTOah0JATWnZ+Tg1EMxoCPxQvonaD+Yyw0ZIpd0HqgXJNog5BEgjmh+aQAlpEQfkOMxAv4PNaPh4MfO/VvB6d5XZjrJgYDrFKtNArTSeU+g=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=H0/JMO0MVBV4Zw97lRkerZQkk83rH+m9BE4n2iCqH98=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794826721300634.623479738804;
	Mon, 16 Nov 2026 02:58:41 -0800 (PST)
Message-ID: <df61d7d2-7ad8-4b68-b3a0-7a03513ab5b7@collabora.com>
Date: Mon, 16 Nov 2026 11:58:35 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] media: rockchip: rkcif: Don't reset the hardware
 in runtime suspend
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: linux-media@vger.kernel.org, paul.elder@ideasonboard.com,
 daniel@makrotopia.org, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
References: <20261112183208.2688580-1-mehdi.djait@linux.intel.com>
 <20261112183208.2688580-2-mehdi.djait@linux.intel.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20261112183208.2688580-2-mehdi.djait@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Mehdi,

On 11/12/26 19:32, Mehdi Djait wrote:
> The reset in the runtime suspend also resets the VICAP IOMMU.
> 
> When the IOMMU driver accesses the IOMMU registers inside the delay window
> between the assert and deassert, e.g. in rk_iommu_zap_lines() to shootdown
> IOTLB entries, the system hangs.
> 
> Drop the reset and the now unused reset control.

I agree that the current situation is nothing more than a crude hack
that happened to work in most cases. But I doubt simply removing the
reset is the correct solution. Recently, I saw some downstream patch
that makes the reset a shared one, which seems like the right thing to
do here. What would you think about that?

Best regards,
Michael

> 
> Fixes: f53fb31a3889 ("media: rockchip: add driver for the rockchip camera interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> ---
>  .../media/platform/rockchip/rkcif/rkcif-common.h  |  1 -
>  drivers/media/platform/rockchip/rkcif/rkcif-dev.c | 15 ---------------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkcif/rkcif-common.h b/drivers/media/platform/rockchip/rkcif/rkcif-common.h
> index 4d9211ba9bda..38208e8b7b2d 100644
> --- a/drivers/media/platform/rockchip/rkcif/rkcif-common.h
> +++ b/drivers/media/platform/rockchip/rkcif/rkcif-common.h
> @@ -237,7 +237,6 @@ struct rkcif_device {
>  	struct clk_bulk_data clks[RKCIF_CLK_MAX];
>  	unsigned int clks_num;
>  	struct regmap *grf;
> -	struct reset_control *reset;
>  	void __iomem *base_addr;
>  
>  	struct rkcif_interface interfaces[RKCIF_IF_MAX];
> diff --git a/drivers/media/platform/rockchip/rkcif/rkcif-dev.c b/drivers/media/platform/rockchip/rkcif/rkcif-dev.c
> index be3a174b9aab..dceabee2ecd6 100644
> --- a/drivers/media/platform/rockchip/rkcif/rkcif-dev.c
> +++ b/drivers/media/platform/rockchip/rkcif/rkcif-dev.c
> @@ -10,7 +10,6 @@
>   */
>  
>  #include <linux/clk.h>
> -#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> @@ -18,7 +17,6 @@
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/reset.h>
>  
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-mc.h>
> @@ -201,10 +199,6 @@ static int rkcif_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to get clocks\n");
>  
> -	rkcif->reset = devm_reset_control_array_get_exclusive(dev);
> -	if (IS_ERR(rkcif->reset))
> -		return PTR_ERR(rkcif->reset);
> -
>  	rkcif->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>  						     "rockchip,grf");
>  	if (IS_ERR(rkcif->grf))
> @@ -273,15 +267,6 @@ static int rkcif_runtime_suspend(struct device *dev)
>  {
>  	struct rkcif_device *rkcif = dev_get_drvdata(dev);
>  
> -	/*
> -	 * Reset CIF (CRU, DMA, FIFOs) to allow a clean resume.
> -	 * Since this resets the IOMMU too, we cannot issue this reset when
> -	 * resuming.
> -	 */
> -	reset_control_assert(rkcif->reset);
> -	udelay(5);
> -	reset_control_deassert(rkcif->reset);
> -
>  	clk_bulk_disable_unprepare(rkcif->clks_num, rkcif->clks);
>  
>  	return 0;

