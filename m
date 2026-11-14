Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699894;
	b=wr8X900ZE3u0a7Tg4eHnEfPKo4BIPuhstjx/a1c6AToMdOvbRkFoS9n+sqO4H51yxmQF
	 RvG5hUsRwv8aHf04ZBCPk9CUkR1mfPleJQRZXUObzSm0wnPRlDJdrXIbEqkjKwGqb71Xc
	 gZO4ffd5qFwzFQdd2xGGqjZfDA8gnQpFpgxStn+K9hI7pM18awsuDfqCX1kdn7pQnZK/b
	 p1burhuR32T6wdmAmTho7wGBLnTYY8LmGTtRRHbTcc15x7FaEMoh6w1rhz93UISlhHQ46
	 eyaAXsMMci4k0+XkOa4rT+QEhT8nIB4LF1H4h+feOs+rNAyw97WkqL53IgRSEgmui1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699894;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4eCp60z5R0fNOYWynSdAxYnkiCnb4H13EtT/Lg4xVQM=;
	b=C3j48SR606K2BgzGyhi/maOo0WcC/PDINxoYhDqbxUH8mVXjh0IuRgFQRLIrsBhoTuWB
	 1+twFqRzMAMufsgiMdmK/uOU4eeu7PFln4Q4hG4bz/QVPxpladgVa2hPC9DmEtmk4+4iE
	 EB7v5sYCH1GU39dD8nf+9RDnr9LSQwIOqqbr9wjC+XHtySBvX9KkzgJ80CtN3fOASQVAo
	 7ei3qTie3Lj5tcylUuVZoChsnjE4o3ParmylPLDHFF98EEyPQxsAT+cZd5CPe2jsUIeQo
	 QX1SEAXXUGgjezMXjN3loFx+TZ8f7rVrUqqP6l8ErTL3Zm+Fcv4x7sRoN3My2DHgb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD5czttO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E1606A32E;
	Sat, 14 Nov 2026 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD5czttO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053B81F000C4;
	Sat, 14 Nov 2026 23:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699894;
	bh=4eCp60z5R0fNOYWynSdAxYnkiCnb4H13EtT/Lg4xVQM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bD5czttOKv7xufAmli+kVyRrk44dO6qcVuOuTBPN8Ck3zImdZs2b6pGJsq5ifxn5n
	 y8fSQi25WLjgif91A09TI6Q7kUsdlwSa1yEQcouKGh3qdS5pwZnTedNMzbGUpreJLJ
	 lJfWjTJ0Up8xQ/DvXcKMJ43CzBNM3hktAWvbcd1Tb5Y46gNNjo4jXqfbW1Gj6irTAJ
	 d+hAGXj4LS5GzdeOCSMVxdY4kBTUE4Vc/lblxJ0CMBL5OtUh2yTP4a3zpGicdfDT5u
	 65+HfUrpMLi4aZ6exXrYbMn4+2tujo8tkc+eXPAOHcR2Yerd2xvv2mFdT55oZQjIPW
	 jXFfMfo0Yw4zA==
Subject: Re: [PATCH can-next v6 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 14 Nov 2026 23:44:53 +0000
Message-ID: <179469989360.488853.2267495586582678566@kernel.org>
In-Reply-To: <20261113-gs_usb-fixes-v6-2-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-2-0c039e1bfd74@pengutronix.de>
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

- [Low] can: gs_usb: inaccurate Fixes: trailer in commit message

--

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -861,7 +861,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
>  	if (!urb)
>  		goto nomem_urb;
>  
> -	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
> +	hf = kzalloc(dev->hf_size_tx, GFP_ATOMIC);
>  	if (!hf)
>  		goto nomem_hf;
>  
>

[Severity: Low]
The Fixes: tag points at 26949ac935e3 ("can: gs_usb: add CAN-FD
support"). As far as I can tell, the leak in gs_can_start_xmit() is
older than the CAN-FD support.

The original driver, d08e973a77d1 ("can: gs_usb: Added support for the
GS_USB CAN devices"), already allocated hf with usb_alloc_coherent()
without __GFP_ZERO. It copied only cf->can_dlc bytes into the 8 byte
hf->data array and then submitted the full sizeof(*hf) buffer. So
whenever the DLC was below 8, the tail of hf->data went out over USB
uninitialized.

The kmalloc() call changed here was added later by 62f102c0d156
("can: gs_usb: remove dma allocations"). That commit kept the same
behaviour.

This patch is tagged for stable. With the tag pointing at the CAN-FD
commit, stable trees that have the classic CAN variant of the leak but
not 26949ac935e3 may never pick up a fix.

Should this be Fixes: d08e973a77d1 instead? The one-liner will not
apply before 62f102c0d156, so older trees would need a separate
backport against usb_alloc_coherent(). Would you rather list both
commits, or add a note for the stable maintainers?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-gs_usb-fixes-v6-0-0c039e1bfd74%40pengutronix.de
