Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0B52BE54;
	Fri, 18 Sep 2026 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767067; cv=pass; b=K2mGERCY2UtOitYWEJUgs9dd2dcRBK0aSNodxgMrAJf5ZibDa6c6kObj1OifxAGV808FIiccVc/AF6+6hpLVH1Yv4EMnQuMCVp0Yk12dEUoRnp/v1QpKWfRWb/T2WkkpICZNl7/n9wDDbap0UdsDbSFaVBuZtCI0z77bRbigIAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767067; c=relaxed/simple;
	bh=SqGJJ5G1fioLU2t/CmvjPf5oyG671BrLlJ3FuwhtKfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXIHrgSI3pBMQRxJ2+/War0f9NSPxuxuLcWY8dUVgtCctdPvjtS+ouiRwiM0SpKQ8djsvyrPWIVyvvhsaAH+bo3JBUxHfD5gzrFqKDVK8GCXltcGW461eE6lTkAaT1RSAmFm7fGgJaaEs6sKGtilHfuIqSm+rxZQ5vA47LXL1Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=michael.riesch@collabora.com header.b=jFooVyTt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=michael.riesch@collabora.com header.b="jFooVyTt"
ARC-Seal: i=1; a=rsa-sha256; t=1789767052; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BJqRUl17C5cSdFCNk87K5I0UObDR81A6Ln1yrCWgs1O0OLbV7EG4TjzxfqRSlxGoFGxkrX0yGhEhL0tIh2o0fHjdstdR3AUxF7NyX2jENiJXd7dBClEJ5UIQxFbrP1lRhF2Auh3l/ibrvQOdiWzFHk45/IuVpIJdT16qq4DKgKo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789767052; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wOdYVCAYXvONYslNNR7wiaBs5rl7Cl0Yr9264UP/uBY=; 
	b=RpKdJD1K+pCzoNRNvurNEkzRkxpjo3KsX0NtDhAIQeiI1VUqat3Vp2h/ebeqFM8QGDL5Ol6aGiL5/E9m9/79yOdqoY8hFsFItzCZqw6H0sOqsvlnMZ/tEV0t7YP8giQo3KiwMQdP066VdG59abwbq07dGqCIoABweMxkDwP4dkM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=michael.riesch@collabora.com;
	dmarc=pass header.from=<michael.riesch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789767052;
	s=zohomail; d=collabora.com; i=michael.riesch@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wOdYVCAYXvONYslNNR7wiaBs5rl7Cl0Yr9264UP/uBY=;
	b=jFooVyTti62icv3fQnr31WdiT+sHQO4if8/f8xEcE31TCH3npzyY2EV2ibmYJr7W
	ZPaJclh/2s20nqdMcYoXdhyCc6RVFb5rthcl/7CvHLRMcjUT11N+sn/wYutlyjXOwY5
	8HttStAWtX7MRq3DGrZ6kSO2X49COgsfJaLa/B58=
Received: by smtp.zohomail.com with SMTPS id 1789767051697815.3455949100515;
	Fri, 18 Sep 2026 14:30:51 -0700 (PDT)
Message-ID: <9bf16301-ab58-4d55-bd32-b807bef1f53b@collabora.com>
Date: Fri, 18 Sep 2026 23:30:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] media: i2c: imx415: Add missing v4l2_subdev_cleanup()
 call
To: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>,
 sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
 mchehab@kernel.org, mani@kernel.org, jacopo.mondi@ideasonboard.com,
 nicholas@rothemail.net, benjamin.mugnier@foss.st.com,
 sylvain.petinot@foss.st.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1788940469.git.chubuchnyi@gmail.com>
 <6a7bc243c8cab077de57fc9c3d6a3d005c110f64.1788940469.git.chubuchnyi@gmail.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <6a7bc243c8cab077de57fc9c3d6a3d005c110f64.1788940469.git.chubuchnyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Aleksandr,

Thanks for the patch, LGTM!

On 9/9/26 10:02, Aleksandr Chubuchnyi wrote:
> The subdev active state allocated by v4l2_subdev_init_finalize() is leaked
> on unbind.
> 
> Fixes: 14cd15e7a1e2 ("media: i2c: add imx415 cmos image sensor driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>

Reviewed-by: Michael Riesch <michael.riesch@collabora.com>

Best regards,
Michael

> ---
>  drivers/media/i2c/imx415.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
> index c3b22b238..12c2f3df6 100644
> --- a/drivers/media/i2c/imx415.c
> +++ b/drivers/media/i2c/imx415.c
> @@ -1125,6 +1125,7 @@ static int imx415_subdev_init(struct imx415 *sensor)
>  
>  static void imx415_subdev_cleanup(struct imx415 *sensor)
>  {
> +	v4l2_subdev_cleanup(&sensor->subdev);
>  	media_entity_cleanup(&sensor->subdev.entity);
>  	v4l2_ctrl_handler_free(&sensor->ctrls);
>  }

