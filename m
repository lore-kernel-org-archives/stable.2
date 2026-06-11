Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D0233922;
	Thu, 11 Jun 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189089; cv=none; b=hPUc+xuRPgibdIP8eQSjVvNTpoQsGSF8vFvhGlc8UBzG9jW3I0OqvHwLFC6EW9W6cdXDWLNcSLuxPB9ZOwva72w/VZS9WWfL1xjQNsyePmDjhQ4+/m8hl4MS8pR31xAwk8Dam/RQGp8QtTuKwaao8Rc02JdgwX6FRyyaPk1SjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189089; c=relaxed/simple;
	bh=tGX2theAQhAy9tSUIsfMCcmQQSOrGpJU24wZE8u/g/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD/z89X2bNoUII5Z1z3GsE8LAbW2b06SFHERppChUz3entg0PUN/L36MuWG0wJcncT9IsXJDS9anNpiMAYiVx7eQQRNGJE0sy8I2UN46N/ZnJLwS5KFg2vif9Xr8+tzk/k2OFpjEXUuZrH5+VGI5y56wicT29Aqz2lyifmZq3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLdHd6LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLdHd6LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157431F00893;
	Thu, 11 Jun 2026 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781189088;
	bh=J3IzR5NXDA4imuyDY0iZdwVa7rhntxKKeT3HhY1M8TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLdHd6LOElfOLC8x9m8fKdgUDNBqscivHnEJaYP18Hvy6w4iqhb05uuw8fySwTYh4
	 tSjMoWsB6B7bdYSQywHZgRCXygV/akgCPaSVGO0+E2pYbNjkuNUoi4Txddj1dzwYFF
	 FdfmqzjcKGTHgmw7uKAWnh3ItLjvjIHAgc/18Ek9U+O8dX16ncTsJx6MrsV0p7t+R+
	 PehDm0fCn8JW4WV8fwm2bkuMgJj/1wlxe/sQjDf8FcGK1/JBsG6bXV98s6jJzqiVWe
	 p7D/oG1wRK1+2JnFIMEJ1Bf3PpJZpXIIn5OBtu160YVNYEdiGWUIx8knQ50KTYXxyO
	 gwOQyqlRtQ8VA==
From: Simon Horman <horms@kernel.org>
To: vulab@iscas.ac.cn
Cc: Simon Horman <horms@kernel.org>,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: bgmac: fix refcount leak in bgmac_phy_connect_direct()
Date: Thu, 11 Jun 2026 15:42:02 +0100
Message-ID: <20260611144200.600147-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609074411.205176-1-vulab@iscas.ac.cn>
References: <20260609074411.205176-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says:

Although the issues reported below are flagged as pre-existing
I wonder if they should be considered in the scope of this patch (set)
as they appear to be similar issues to the one this patch addresses.
---
net: bgmac: fix refcount leak in bgmac_phy_connect_direct()

In bgmac_phy_connect_direct(), fixed_phy_register() returns a
phy_device with an incremented refcount. If the subsequent
phy_connect_direct() call fails, the function returns the error
without releasing the phy_device reference. Add the missing
fixed_phy_unregister() in the error path to prevent the leak.

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 3e9c57196a397..c97cf7ebad7f1 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1456,6 +1456,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
>  				 PHY_INTERFACE_MODE_MII);
>  	if (err) {
>  		dev_err(bgmac->dev, "Connecting PHY failed\n");
> +		fixed_phy_unregister(phy_dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this driver still leak
the fixed phy identifier during driver teardown and in other error paths?

In bgmac_enet_remove(), the driver calls phy_disconnect() but does not
appear to unregister the fixed phy:

drivers/net/ethernet/broadcom/bgmac.c:bgmac_enet_remove() {
	unregister_netdev(bgmac->net_dev);
	phy_disconnect(bgmac->net_dev->phydev);
	netif_napi_del(&bgmac->napi);
	bgmac_dma_free(bgmac);
}

Similarly, in the error path of bgmac_enet_probe():

drivers/net/ethernet/broadcom/bgmac.c:bgmac_enet_probe() {
...
err_phy_disconnect:
	phy_disconnect(net_dev->phydev);
...
}

Since fixed_phy_register() allocates an identifier from fixed_phy_ids (which
has a hard limit of 8 slots), failing to unregister it means the identifier
is never released. After 8 unbind or bind cycles or probe failures, the
fixed_phy_ids bitmap will be exhausted, permanently failing subsequent probes.

Should fixed_phy_unregister() also be called in these paths to prevent
exhausting the fixed phy identifiers?

>  		return err;
>  	}
>
