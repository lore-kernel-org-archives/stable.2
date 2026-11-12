Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472493;
	b=HamZkUnIaZgKU0PviWtqebbU6bmzakDnh7tZ8iwpYkDmvuJcV/Pmr7HfGjBTtpQljcLc
	 oSUudUcZcsmi29JgRIur2agbRNxapT7lsnN8EdwMvgtN9744rTnnREth8E8kFkL8PYpgq
	 fq0M/HzvOZW3RhoD/KXeVBaGY3j64snUuyU9gW4BqiDg7yFuvTT+RQv8eUar+CSmn7tSg
	 luu4HRtMJXtpwwrIP58jBcfrR2zOBCKXELKAu37skF0d6MLDvKDRk4/CnHvXtwD+TopYp
	 o9f7OGAI+bWkaB+HWGC02lbvYOJxiUni5hLCifA3VenDkZUTh1KLYP+aJPWyYTarDAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472493;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Up5j8TzM0Yy5snipwPfxPFv5mWJlT3wquG3RxXthBZY=;
	b=ZGM6q6kJ6Ce2n7ytX0yAQb/Z2rf9km3CS1x4dpaKJQdmwOVV4CoCOwieEOPv7lJd5Shw
	 a2FhGduLTjCwxGoUWDOviGy/zqklQsytZu37j9+3rhuAvOWKgZx31Sx+rHINb4wILcaij
	 P4csHFjI3+k16pCb/N/epAeMZqcIo2hwxReDRSW3AlDrNLGvgfBAEGMxqMNlY63Elg0yT
	 MdYzA+D5w9BdWL9HE3nM6/S9298aqN0XeUo4jZL2pXQ3Y+oBkCvWZObxbuHriYdFEb2en
	 l2MfJzDnoKI0n3C/FC/ZJQr6PyVaXYJoKuV2BbtT7iZzpPtrJ476uu5eaLLyHbqbxFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ej68i5BY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF7606B707;
	Thu, 12 Nov 2026 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ej68i5BY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9131F00A08;
	Thu, 12 Nov 2026 08:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472493;
	bh=Up5j8TzM0Yy5snipwPfxPFv5mWJlT3wquG3RxXthBZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ej68i5BY75arsjTGasmRdWC+rEebnr8+zb6tSnR1zawq3K3rjE6cC2JMg0rROTEMw
	 TCfHAmVECuO7NZIi4gNwHXwxaDQaAFitEEeIGGhjYFteZ3vI0JhYbgJnsmraEWG45J
	 23o1qrSD9ZdNhujG66uaqYjANu0/DJ9+Mdw2AH9qbxz5gzxULF+4Rw1WWDYGOU69ar
	 Apf6lEFOKNSDA1hkN/l9O1K1txJ+8hDmwjbYRksRp6lda/Sdl1VIrozOzdXu2ZSvvx
	 1Kkqjajsw2B94RQhG/bbOrv5i61beVMaVkylBNLoxkszLalz425mEKgB4tZ7VTtJcx
	 IzYiZAZn1B7ug==
Date: Thu, 12 Nov 2026 14:04:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	mani@kernel.org, mchehab+huawei@kernel.org,
	neil.armstrong@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] phy: HiSilicon: Fix device node reference leak in
 hi3670_pcie_get_resources_from_pcie()
Message-ID: <avV6KSL8Q6vVHsrO@parshuram>
References: <20260917134144.2153731-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917134144.2153731-1-vulab@iscas.ac.cn>

On 17-09-26, 13:41, Wentao Liang wrote:
> hi3670_pcie_get_resources_from_pcie() obtains the "pcie" child node
> with of_get_child_by_name(), which takes a reference on the node, but
> never releases it: both the "Didn't find pcie device" and the "Failed
> to get APB regmap" error paths, as well as the success path, return
> without calling of_node_put().
> 
> The node is only needed for the device lookup, so drop the reference
> right after bus_find_device_by_of_node().

We already have 1499f3d3407f ("phy: hisilicon: hi3670: Fix OF node and device reference leaks")

> 
> Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/phy/hisilicon/phy-hi3670-pcie.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
> index 87eac058a4bc..35e634279794 100644
> --- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
> +++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
> @@ -570,6 +570,7 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
>  	}
>  
>  	pcie_dev = bus_find_device_by_of_node(&platform_bus_type, pcie_port);
> +	of_node_put(pcie_port);
>  	if (!pcie_dev) {
>  		dev_err(dev, "Didn't find pcie device\n");
>  		return -ENODEV;
> -- 
> 2.34.1

-- 
~Vinod
