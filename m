Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781172;
	b=tcYRMcVVxSztx4LYHDDLyOIRxyxpG07sFghw2mTxArQ1MFOwLpWbJHCYkkNsONHr2+HP
	 /HxA3CPJnWbWix4kc9K/m0QqODpsQKPnBiDyjcj44LY5Cq0IgFwFb17yNdwmKJjIR1ZaM
	 A+JMefrDrg23dE3cI4izmRtFbkTouk4zi2Ud7UPxNHTEEXRnJcfcVUSB03mgEj3LyahsT
	 601PK6CAQhjOISOAL7EO6BO3VjwBCSFZyST18X/1WArSYZ6CUunE9counqowHYgRHuLCJ
	 iqzkZjhNxBD8ZlzJloMxipt61CKhpT88Nwugl2ElId9M0pBR9VbsmtHINAEX+QQ2hvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781172;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Hcrb4t/Nl9nvOKmZQf/cJ2Litd4kOlho8EMiq96w22w=;
	b=N2YfynL7bsdAQICmYFBVNMmnCDjeXmOmFXEKit80ylVtqA9gD0qB+W+9LweqlFOWbmfg
	 Gzh+muDRTbW2hpuyf5zOVyvu7+5aoSqkh3ErLiBWes6zBLrtw3AVqhMWbwSbDkR/iSguI
	 slyfgFDEOXqy48Mrmnr9rqWZTu6hw2mxt/CmmIFgIuLlpeOv+/44nv6bIjz4cvKJ3LC+h
	 FB79nTMrj31v7iqqDSv/6JZjx1PCcvfgJYcgC+xuSaNCSUIY1tNi7Tnzo9OMENyLX7Ie5
	 6VQ8hrWJYyoajbxtio/B41Pw1k3rLwlguJvhB/vz47lui4+5TYI8CrZWKDOHaavEXMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHpKD795;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D4606A332;
	Fri, 27 Nov 2026 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHpKD795
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483901F00898;
	Fri, 27 Nov 2026 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781171;
	bh=Hcrb4t/Nl9nvOKmZQf/cJ2Litd4kOlho8EMiq96w22w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jHpKD795s7YWEsgmapb+j7rdte1qNpX03QEKVSV2CtWH1pfd4jhg5+a6ze94ebd1p
	 v2XY5qdfKGzn8NPCDPSXJz1iwixlX1WEJN/nDLFoVN3vwR8ZRe7AkGmXwV7v6mNw1y
	 mIMvNVvsYMVlXD7Hguhz2mG5GyyqGkreNuhKDfMGmYFdldehklJ73jUyOvX3XCyxK4
	 1c5VlrwdDqm4P/0kJu6JEaa87pV7fkGbHt9tbjNFPUt/phY46s94uu1at48GFBepJl
	 QrafZ+jmGwZSth/4c7YfkyyAzD7ksnaPDocFh3gCWw+eaYooEQ9oeb/A9y2a4guJ9j
	 HDnc+vsF0F0VA==
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
Subject: Re: [PATCH v2] phy: rcar-gen3-usb2: cancel OTG work on unbind to
 avoid use-after-free
From: Manivannan Sadhasivam <mani@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261109113121.1534929-1-hj351016@gmail.com>
References: <20261109113121.1534929-1-hj351016@gmail.com>
Date: Fri, 27 Nov 2026 17:36:04 +0530
Message-Id: <179578116447.13164.14627017211544717666.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2589; i=mani@kernel.org;
 h=from:subject:message-id; bh=0XpU3qHhJDd5Mt2xvK6RN1DmHwWq31KyTwjLbROnsU8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCXIvvHg4SXjfHFJNcTq2q77m7TJ8HBZl9RpF/
 UDDtn2QpCeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawlyLwAKCRBVnxHm/pHO
 9ZhQB/0aEBpHkv1D6YQFJNBtxnNoN713fYsH/NcoNYmIZobHJScAFAuGEJ0TiHS7P+LXrzLaEL/
 C4ljns8uCWDPksZuIRJC8HrU/57Wj6KELEq8eCWC3EtYNRS9Sz961s26qC/WoFe9r8KoJ774AVK
 JrKjB+TNFEncFidcCHZSBMjtkluXv7KaNlSQhbgAw69g2i81NV01j+yK2Z/iE0qnIykYJp36XFL
 c0Lcq/PrCbhfRdB5nA3dm25xDge+LYaRsOOjXKgzWWmzu4PhVbsK9UBKefcEOj2RybgSZTXkyNv
 c/p3O50BWRP6YNO5jJ1Ss+H7ZhLaxrbwhJ98XH7Enlpzy2Dt
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-09 20:31 +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> The OTG role/VBUS interrupt (rcar_gen3_phy_usb2_irq) and the role sysfs
> attribute schedule channel->work (rcar_gen3_phy_usb2_work), whose handler
> dereferences the channel (ch->extcon). The channel is devm-allocated, so
> it is freed at unbind, but nothing cancels channel->work:
> rcar_gen3_phy_usb2_remove() only drops the role sysfs file. A work
> scheduled just before unbind can run after the channel has been freed, a
> use-after-free.
> 
> Cancel the work via devm, registered before the interrupt is requested so
> that on unbind devm frees the interrupt first (no new work can be
> scheduled) and then runs the cancel action before the channel is freed.
> 
> Fixes: c14f8a4032ef ("phy: rcar-gen3-usb2: fix mutex_lock calling in interrupt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> Changes in v2 (thanks to the Sashiko AI review):
>  - correct the Fixes: tag to c14f8a4032ef, which introduced channel->work
>    and rcar_gen3_phy_usb2_work(), rather than 2b38543c8db1 which only added
>    synchronous extcon handling
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index b5ba751..35e519a 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -1171,6 +1171,13 @@ static int rcar_gen3_phy_usb2_vbus_regulator_register(struct rcar_gen3_chan *cha
>  	return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(channel, enable);
>  }
>  
> +static void rcar_gen3_phy_usb2_cancel_work(void *data)
> +{
> +	struct rcar_gen3_chan *channel = data;
> +
> +	cancel_work_sync(&channel->work);
> +}
> +
>  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1277,6 +1284,17 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>  		return irq;
>  	} else if (irq > 0) {
>  		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
> +		/*
> +		 * Registered before the IRQ so that, on unbind, devm frees the
> +		 * IRQ first (no more work can be scheduled) and then cancels any
> +		 * work still pending before the channel is freed.
> +		 */
> +		ret = devm_add_action_or_reset(dev,
> +					       rcar_gen3_phy_usb2_cancel_work,
> +					       channel);

Please use devm_work_autocancel().

- Mani


