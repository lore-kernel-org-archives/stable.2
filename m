Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699893;
	b=KxwYyFzMz0jcbcgx+NEaUgQK3afYTzaBe+l9JJxupUfqTZ8DOBv3Bp2xZ5fLUbXbW9dd
	 Zw/KNDXmOiI6rSJ0ylDkhJNa6G895dmedyhw8r2vjFJq5oLxADVxK7CmI1K77qVbnKoR8
	 wrn4mM/IUl9Sb2dmRMX5HFv69n/mvi95TrC4185rQXpVNoQm0Ej0ZBaXN/JkB8cP3nEg0
	 8Gm44z1M0BdrFgeUqz2zgLvIGsJJlKACiYZanVev2ocZEJg8RyKcTwDqgJ62uzJVqCxdE
	 19fmk9xVSSIR48UCz28JDdYwsKrkv1ybWEQyFV4ze4eX0HI3FKGFb7bH4MuRnWxaXjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699893;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vaNd3hjjK0RwNZ+3nKlLJJm9wJyFljAYjaDt+xbVY7A=;
	b=ND4BpTpDPrDJ7R9kIOOXyc7WK/ONBgR2DhmFh2t7ObNS278oIZwbqN7lpX/go9wyFBUz
	 gH3BhKwtCSZKFpKdFU9lXUSwCA5zl8PWDBSsvIjdK2m99uyDeVBDw275/MzHQzJhId0TX
	 hRmyqkN0xU5jDAaaeA94ajgF8x+8zpSCeKcwKb5eDe0d2bup4BlDVyrqfIAentohKWZGO
	 rCPI8IjSW+NjPSsnFd3ST2XO/MB6BmUlvcR9Rz7taLulLtNgAvRod1HLVw/1dN2eO+nPp
	 ZGnirYxX1m/Wh+B6o5D2kA6PHSRSRsqZitFJsXJEO60MCN/JTTi95Bw7R3wauJm5V8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaByAHBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA0606A327;
	Sat, 14 Nov 2026 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaByAHBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED2F1F000C4;
	Sat, 14 Nov 2026 23:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699893;
	bh=vaNd3hjjK0RwNZ+3nKlLJJm9wJyFljAYjaDt+xbVY7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UaByAHBJI2Xt3Qe1G/zWfClNWJiBP4cDIJ/39j7PDRxuLNmZR4xRpNOZqkqLASbBR
	 V3u7gmgU9Yyrd4f/4tw+wBWANW2zkBWyEzWw7IH/RqlypLaGvQiPniDQeRXBr7Qc93
	 od3cXKY/HbaoreAG6iALQgQJM39ImmJqzhMgoY39PUgFGvYMk11KE/8b8FeknQ6w6t
	 2aNL1ouFY9MIs9vCnF02GKtYjNY+AYqL2gsAYyLz+ucTB0PB4Y1c/EJwNy4HvZZNYf
	 fgd3CXVaaQBME090HpZo2e4oD6A0ZgI5phCDiA+HFlLXsYFomBsHS2DgSKNvulnt7i
	 b25erJKmvLRKw==
Subject: Re: [PATCH can-next v6 1/6] can: gs_usb: gs_make_candev(): check
 can_rx_offload_add_manual() return value
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 14 Nov 2026 23:44:52 +0000
Message-ID: <179469989234.488853.8740350173705893191@kernel.org>
In-Reply-To: <20261113-gs_usb-fixes-v6-1-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-1-0c039e1bfd74@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] On the current tree the new error branch in gs_make_candev()
  cannot be reached.

--

can: gs_usb: gs_make_candev(): check can_rx_offload_add_manual() return value

This patch makes gs_make_candev() check the return value of
can_rx_offload_add_manual(). On failure it now exits through the existing
out_free_candev path. The commit message says the change prepares for an
upcoming can_rx_offload series in which can_rx_offload_add_manual() can
fail.

Link: https://patch.msgid.link/20260907104942.17089-4-ciprianmarian.costea@oss.nxp.com

> Fixes: 24bc41b45583 ("can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception")

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3b9b2f104d868..cac4ce323a1de 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1487,7 +1487,10 @@ static struct gs_can *gs_make_candev(unsigned int channel,
>  		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
>  	}
>  
> -	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
> +	rc = can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
> +	if (rc)
> +		goto out_free_candev;
> +

[Severity: Low]
This isn't a bug, but can the new error branch be reached on the current
tree?

can_rx_offload_add_manual() in drivers/net/can/dev/rx-offload.c only
fails when mailbox_read is set:

    if (offload->mailbox_read)
        return -EINVAL;

    return can_rx_offload_init_queue(dev, offload, weight);

gs_usb never sets mailbox_read. The private area returned by
alloc_candev() is zeroed, so this check always passes.

can_rx_offload_init_queue() always returns 0. It also sets up
skb_irq_queue as an embedded struct sk_buff_head, so the
"offload->skb_irq_queue == NULL" case only appears after the upcoming
rx-offload rework.

The commit message does say this failure comes "In an upcoming series".
Given that, would it be clearer to present this as preparation for that
series rather than tag it with Fixes: 24bc41b45583? Today the check
cannot trigger, so backporters may read the Fixes: tag as pointing to a
bug users can hit.

>  	SET_NETDEV_DEV(netdev, &intf->dev);
>  
>  	rc = register_candev(dev->netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-gs_usb-fixes-v6-0-0c039e1bfd74%40pengutronix.de
