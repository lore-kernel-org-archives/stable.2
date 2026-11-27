Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787896;
	b=QaEPzSYxFtpQia3VWemcZzhkbeD4jJxk08XJB0IHzeRX/jWLtU+zsCWlWdqxfSmdKjmD
	 eP0IZFOpZIv2HFu2fpgR5YqsC4vQrG0oeksDE77uBpqwKLcELH/lvQoDHGZWsb1K6TOjs
	 ttuuZ6T2CLqAtM65uykeOsY1E9G+APDQ2kchsZZw2jjM++L70wwGH0capPM+qJ7Z991IU
	 pvx0NNi9jcqcMHu7EhFVGB4m114vI4cUCE0z/3fmoFo8SIfHuceCkmrWbvzNuSvGBrKX8
	 70bqd/MSrUaFwS6t+m2cWjOHyqu0b0lKORucPf4NfXZjCbjDsmSjdTEzgBKjsuiPnDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787896;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f1cpR8UC2K9Hh290rl3zoXoR37d6lYjg5P7GDWf+Pv4=;
	b=RHjtkf1/dqDWJFM5EZil/QZT/UDxspR+8dRWaxsT8a+BPOvZuKFq4CFJH0SMoskWhol2
	 5vM0CsNh+jcpVGXfnQLOE9HhBuEweuWx/gGXk399J0+1zEdJZwkuH/D8CD+wFWNREArXY
	 Bx84oMjxab4lDIGZ8gZA2jIZOMAbG2/8haX/oTNP4fLIvmg8x6fJ5vFdM5QHrRtAyH5iR
	 kcFtmmmf+68ecgzihnLWmsnyx/YB7jucodCLA5vJDR4e5W4Eho4hKnxfqksjYSSX+pkKu
	 iRoMhHM3cF18JstRIwG1PzMba8FC9PIaPtdY8QGSbgJLvJOlRp9B0K9GJq2xvvliD+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mwr1txn7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D553606A31C;
	Fri, 27 Nov 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mwr1txn7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9461F00897;
	Fri, 27 Nov 2026 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787895;
	bh=f1cpR8UC2K9Hh290rl3zoXoR37d6lYjg5P7GDWf+Pv4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Mwr1txn7jxQbejBY5GLGQ0t+lgUPqvLYv6L9blRBfMR7VxoKA4rZm6Dmm7ILpH1gW
	 o/Dm9uuaxFmgpPqYLRGdXbE2hghbvSsphBP3k6S6pYnyQYKvK/VC1O6W0wAjj2o8jK
	 BFSOXBhJiocESx7bjUz8XyD8Xki1y7dymQIHMlb+vuMhNaRdSsuMc+vzs+Vy/7OMYC
	 dQYhtmcIw8YGWicI2iUJx4ezMLQHA8B4/KsNKLH7a/6QjZJa896fOK/0ATMJR4uVt5
	 AdnISnq9i30+Teum8o+Jeh9iDXUXGYqjlzsV016HNoS/+ceXxqDGpmfxzv23X+0FUh
	 rAGob45wrO+Pg==
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
Subject: Re: [PATCH] phy: rockchip-usb: fix reset control leak
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, 
 neil.armstrong@linaro.org, mani@kernel.org, heiko@sntech.de, 
 p.zabel@pengutronix.de, ayaka@soulik.info, kishon@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com
In-Reply-To: <20261115042640.426517-1-yanxia@cmss.chinamobile.com>
References: <20261115042640.426517-1-yanxia@cmss.chinamobile.com>
Date: Fri, 27 Nov 2026 19:28:07 +0530
Message-Id: <179578788741.13164.8538367481844332594.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=mani@kernel.org;
 h=from:subject:message-id; bh=2LC0gv6PbFQzQ2shw21mBeIjq7U/AJqmn3yIRLpECSI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCYxy/tnNAqKySBaZmAGd4rkFqYGz3dced8FzB
 MTfEoh13lWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawmMcgAKCRBVnxHm/pHO
 9VN+B/98sdGMuznYvCHZlcxI085NqcsaU/rEbhG5UbvhGEpYFkj6/u8oKd3mooQvZlX2tGjFKdV
 PgcK55C6Fo0i/ducIa1zXTckPf1O7vvQvzY0EgqgyWHs2PKM8GAzMU5vZ+34tmkjZRdtNGHZz40
 9aWNyUo26t4Ww9pu+b9GUPYPWWZiU+Yl2/5s53mBHmYoJP2R0Y8KJxoqIt3WMBJKEIXUa8bYSuE
 LC6txnqr4S9bB/hm0prdJI1G3U+1qWV+oTNJEgt7Yit7OlshzUtFgRgKPMi+3gmeRP8rhOueZf0
 Ak4FJMjVf2PMxwknn5y1NRgYRiapdx6ymbozXFKFnU5DH/d1
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-15 12:26 +0800, Xia Yan wrote:
> rockchip_usb_phy_init() acquires a reset control from each PHY child
> node but never releases it on probe failure or driver detach.
> 
> The leaked exclusive control prevents a later probe from acquiring
> the same reset. Since lookup errors are converted to NULL, subsequent
> PHY reset calls silently skip the hardware reset.
> 
> Register a devres action after a successful lookup to release the
> control on probe failure and detach. Keep the child-node lookup and
> the existing handling of lookup errors.
> 
> Found during review of reset-control lifetimes.
> 
> Fixes: 0f74ab59ce87 ("phy: rockchip-usb: use rockchip_usb_phy_reset to reset phy during wakeup")
> Cc: stable@vger.kernel.org

Stop CCing stable list for these minor fixes, please.

> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-usb.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
> index c5a2853a63d3..79b3315b6590 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usb.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usb.c
> @@ -183,6 +183,11 @@ static const struct phy_ops ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static void rockchip_usb_phy_reset_put(void *data)
> +{
> +	reset_control_put(data);
> +}
> +
>  static void rockchip_usb_phy_action(void *data)
>  {
>  	struct rockchip_usb_phy *rk_phy = data;
> @@ -219,8 +224,15 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
>  	}
>  
>  	rk_phy->reset = of_reset_control_get(child, "phy-reset");
> -	if (IS_ERR(rk_phy->reset))
> +	if (IS_ERR(rk_phy->reset)) {
>  		rk_phy->reset = NULL;
> +	} else {
> +		err = devm_add_action_or_reset(base->dev,
> +					       rockchip_usb_phy_reset_put,
> +					       rk_phy->reset);
> +		if (err)
> +			return err;
> +	}

Why not devm_reset_control_get()?

- Mani


