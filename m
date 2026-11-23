Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435227;
	b=A1TAyVrOrI4hDT0fTbIDUOAKmeLHPYsqZFvwM0+je+D9ndiIQILeINz2CCakymWOZ77N
	 t1fyY5rdL8DrXoQjiB4hoKjU14TDPQt6qPC+EDqjZ/KUBIIswayDFQvJywoxPlv9AYDlQ
	 SDOV8nM+uO+9ixnasPHOp3gTWdy/xFdN+ToaIRl9VSYnTRgUv6kWihR6+tC64962NghiF
	 sDrpi7yU8VzZYQ3ceN/YFvdP3J7HVXHjdz3tl0FsuKEaeArFXwhtO3/bnb3/LNyazGfd7
	 RIEWgGfkN0hgMGnttSAIPdP8KO0cAhkYza5HSCwiwAmOjpTFQC5WrPnukou68WTybRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435227;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wZza3oBznNsF/l9fnP/STPuEgD5r5EBmGF1RMREZYiY=;
	b=m7wATscFk2rmnJ5PIPsJ6gQP5KIv7nxmLupYnRhUDMuCs9w4cXImIbFfI1W3N5YdqwL6
	 /mh6CBOJ7dOBZgN7xDN+CLOFGl2Pfw+SLG3Nup3+JAVuV5hnHlh9i1uaQF84yehCKeNkX
	 xylZk3NvmM6G+YaJTd3rMSOQEjqhaZMCOPsIEFmM6oFTUX05I4iW9qy+t2cpf/I68ppFg
	 naIwnUDGYA+/rSSE/ovkhJZO6CGCS7BBWDOSgDKJJ+IrV5wy8Xj1EqNHHY68wUIaWmJTj
	 idbezPcoruCfcm9z9THjqaRAqwerO58XtGh6NaKIamnQ8S3eErPLVGaBZ8xyXRIXsCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpX55Z1L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD9606A31F;
	Mon, 23 Nov 2026 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpX55Z1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EA61F000D0;
	Mon, 23 Nov 2026 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435226;
	bh=wZza3oBznNsF/l9fnP/STPuEgD5r5EBmGF1RMREZYiY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YpX55Z1LSy55+W/dtLzpo8YBhWsEmucavKxBFARCWi2lw0wW/Vprl1ymSJSXUxiJs
	 WgaAtgB6AUDDqIFmj2pVzAS9FZveX/iKbi1NGxC5n51+Cg2DCrz+gLmA4vVJppnagJ
	 kfrxKrixAzG2DqbCjJMDgJIJW6+V4/P1djXrhsfKpXEaHtJe4BUKtvFSD/w68dIKxR
	 m1/Ame/c9uacoKpeExixEjFCAUh9qXKzVfuXNxsxc80pbz8d2cQp20IZQm4drEq2NB
	 glBAKJLKRgo9Y3ctKCLmqcf70iCQNyompYEtJLcfCV670Xe4s7+09ORDHvvy0pDlNA
	 L7uq3bS0mOHdg==
Subject: Re: [PATCH can-next v9 08/13] can: gs_usb:
 gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info
 messages
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:25 +0000
Message-ID: <179543522572.3131.13220832614638612242@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-8-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-8-db121d488945@pengutronix.de>
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

- [Low] In gs_usb_receive_bulk_callback() (drivers/net/can/usb/gs_usb.c),
  the patch replaces netdev_info() with dev_info_ratelimited() but…

--

can: gs_usb: gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info messages

When an IN URB fails to re-submit before the network device is known,
gs_usb_receive_bulk_callback() used to call netdev_info() with a NULL
netdev. This patch logs against the USB device with
dev_info_ratelimited() instead. It also removes the NULL initialization
of the local netdev variable.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729102802.505168-1-mkl@pengutronix.de

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 308daa2645ada..f49179cbd7876 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -820,8 +820,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  				netif_device_detach(parent->canch[rc]->netdev);
>  		}
>  	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
> -		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
> -			    ERR_PTR(rc));
> +		dev_info_ratelimited(&parent->udev->dev,
> +				     "failed to re-submit IN URB: %pe\n",
> +				     ERR_PTR(rc));

[Severity: Low]
Is the net_ratelimit() check still needed here?

dev_info_ratelimited() already has its own per-callsite limiter through
dev_level_ratelimited() in include/linux/dev_printk.h:

	static DEFINE_RATELIMIT_STATE(_rs, DEFAULT_RATELIMIT_INTERVAL,
				      DEFAULT_RATELIMIT_BURST);
	if (__ratelimit(&_rs))
		dev_level(dev, fmt, ##__VA_ARGS__);

That means this message now goes through two rate limiters. If
net_ratelimit() returns true but the local limiter suppresses the print,
a token from the global networking budget is used up and nothing gets
printed.

The short-read message earlier in the same function also logs against
the USB device, and it uses only the dev_*_ratelimited() helper:

	if (urb->actual_length < minimum_length) {
		dev_err_ratelimited(&parent->udev->dev,
				    "short read (actual_length=%u, minimum_length=%u)\n",
				    urb->actual_length, minimum_length);

Should this site drop the "&& net_ratelimit()" part to match?

The commit message also doesn't quite match the code:

  "and also rate limit the number of messages to prevent log flooding."

net_ratelimit() was already limiting this message before the patch, so
the patch doesn't add rate limiting here. The subject says "use
dev_info()", but the code uses dev_info_ratelimited().

The duplicate limiting is also still present at the end of the series.

>  	}
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de
