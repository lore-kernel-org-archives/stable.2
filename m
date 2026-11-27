Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787488;
	b=a0crTBhzLtxK71gE3w/fWzUa0m4oOFm0od33H7x2sZd60lGxTSAzg3TQaMgjYSKAjN5Q
	 wPOASPpaCs+V9Ywtg8sGgF9hm3uyZhyFleJIBek2VvI8A4z7UH62ZY42VsIeo4JiKuBMI
	 y7M8wP3rC5JOsukxIjK2w2nu6jm3MyJBDCmGrbDpHT1Wcuke5jNrMhL9BUteZ1YRPU70S
	 8X1pe5rhkSXQeyeEzHsc4S5iRjf1gE8mVBB42AnwRV/D23PI3q12Qryt4/gJf+lnSq8Gx
	 dNpgyRIibrb029N+kVTv5VkZLbyaMoxe2jE9Mp9chhNwJoTW0voK0XMPDKnwDZdRl6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787488;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=inTnf+Q34pUSjRjN0/bRffuqg4k3UYdgRQOAcuP05Nc=;
	b=EnV3juDRRyYcG9oWK0cP4nqJKe1fSUS2vY61D/XQ+O8KhUnXXzfR2qv6H0sglnow3Mi5
	 gB+iEHq1JPkHiqqEcQKPbi+ZxoYdyEvs7LIsylt4HLi8jxCNK8gzPeocxTfkeGUdm/N5t
	 pcnK1T1omus+NvNOTeIuB4OjLn7R/96/06JIIAS/PUa6LLk1Bhk4rEwjtDs6ZErTeNK7q
	 qwI5AcRxLCXOp8wwIUxHncMFjo3FhTQqwSZLu8xORRncXopmMDh5x40W9aax0/nJ2+8vI
	 /3slds5irEhOMCRkjoMJLvFHl6wzx2F9NoirQeZII497UhzNPL8If+wgamkYMfuBSUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iat+Xno/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D4606A31F;
	Fri, 27 Nov 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iat+Xno/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7BB1F00898;
	Fri, 27 Nov 2026 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787487;
	bh=inTnf+Q34pUSjRjN0/bRffuqg4k3UYdgRQOAcuP05Nc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=iat+Xno/N5+fAY9YoK2WJsJE3KGKGnizpgIC8PftubKTRBMJHA8PrMVzlYtFll5ct
	 qzbY6vkyhiu3wagXjHo7jvWHjgTbuO2vZnJsdzfOF+qsuMUtdbqDXxUtBsQ6K8HoEp
	 y22DVyLrcpl5rqGhic8lmnphj37PQ1qcxZtHraRK2YcS9B39JhRLFQ1ngG6H4Th7tV
	 M88aj/DQUMVQnXIq7evw3PXNUdRUYodh++TGZKQNXOfAuzAZ8FY/IFSUB6Lrwjp0Th
	 L4tOjM2ZUhXMjOyAZZhSZfV09KUfUfbzV7Gin1YIVUMHfz6TLYdWHN3lQB974/3L6u
	 aAEXJx7E3QoIA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] phy: exynos5-usbdrd: power the Exynos2200 phy
 down when its init fails
From: Manivannan Sadhasivam <mani@kernel.org>
To: Soheyb Boulaa <soheyb_boulaa@proton.me>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261114064400.45572-2-soheyb_boulaa@proton.me>
References: <20261114064400.45572-1-soheyb_boulaa@proton.me>
 <20261114064400.45572-2-soheyb_boulaa@proton.me>
Date: Fri, 27 Nov 2026 19:21:18 +0530
Message-Id: <179578747867.13164.15624215435732669514.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=mani@kernel.org;
 h=from:subject:message-id; bh=R8SRN494D4jpipxtGO5grm+w57kGjbS8PQiAMPpE6C8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCYraAw+t8X0IxxX7b+nPChNSwk6fjRFbHtPkj
 ps93BZnp3uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawmK2gAKCRBVnxHm/pHO
 9Vp0B/9gna1D4jO2PEQBPgOW+lrwfFKksO63xG1FVuRcRlSCyMFA1aPT5phyBgKITaMqRdJOpgr
 e7m/x/GcpQwuFioVqphyXXyzN6+/E5F4ecCPrcZ7sJri0/RsIZeLfdFN7xc2xw8SsmhhhZ8PILr
 5h3jAdM0FobikQQtZgLDBgy4Om5Bk8efZf3obXhAkzQQQ2LxpI12YzHWFHpuOEFH1OMm6QtZLJ7
 mbJaIxgBUpstkCc5PxjfJlTyk1oaDozbbHQ6NXvceJhq45t8/MD3sg0qsc+Z1IyCR0UtgjLQn+I
 WxsPfxiVODg+3yBG0KJNSEKfUqR60di3qo9LGi4TtGyP8lk8
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-14 06:44 +0000, Soheyb Boulaa wrote:
> exynos2200_usbdrd_phy_init() enables the regulators of the UTMI phy and
> takes the phy out of isolation in the PMU before it enables the clocks.
> When clk_bulk_prepare_enable() fails, it returns without undoing
> either. The phy core does not count a failed init, so no exit undoes
> them later: the phy stays out of isolation, and its supplies stay
> enabled, until an init and an exit succeed.
> 
> Isolate the phy again and disable the UTMI regulators when the clocks
> or the phy-specific init fail. The phy-specific init does not fail yet;
> the next patch makes the UTMI init return the result of the init of the

Then add the error handling in next patch.

> high-speed phy.
> 
> Fixes: cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm controller")
> Cc: stable@vger.kernel.org

This patch is not a critical fix to backport. Please drop the tag.

> Signed-off-by: Soheyb Boulaa <soheyb_boulaa@proton.me>

> ---
> v3: full name in From and Signed-off-by.
> v2: new patch.
> 
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 087d552..a6fe779 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1462,7 +1462,7 @@ static int exynos2200_usbdrd_phy_init(struct phy *phy)
>  
>  	ret = clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clks);
>  	if (ret)
> -		return ret;
> +		goto power_down;
>  
>  	/* Set up the link controller */
>  	exynos2200_usbdrd_link_init(phy_drd);
> @@ -1475,6 +1475,17 @@ static int exynos2200_usbdrd_phy_init(struct phy *phy)
>  
>  	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
>  
> +	if (ret)
> +		goto power_down;

Is there a logic in doing the error check here?

- Mani


