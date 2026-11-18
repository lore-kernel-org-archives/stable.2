Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040362;
	b=UcqCmkiGKcTDjIalgyvv/avtjW0bBaC7IbgNbn3gqGEy5VjYZg4xJ1xihssci6Tojjfw
	 PjmmdXfV+jgLBmXQc6XvAaHHGfFepG13TEYrwzkDDCZwlGwzIQLitAt5Zu0vkRS8z3LAE
	 3WvOqZLS54uZaR5eD/tFOFKkn56N3FvGdOFlthb40BxZHPb6EdrX9X8U1eJZufML13P54
	 vT8SrdIAPJ2Qxu23w8mX/6dgrfcEPw6haJzPdivFclx27bAdHhGDzOmSSQYRmh5jshud4
	 Ocft6nP/NrmxeGpm+aOfAEtpznnJ+GVKCwV99Xirzv8mcVgNnZnsj07XABnzO3MjuwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040362;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3B+8++5tpV3zDQLhadaZstF3q/rpXHwLZuqY72uKG7g=;
	b=sNLBehbN1Yhs9qXR1tecuST/73NHxJ3dYZiVaMudIwOJinPjDuwyner2MDONiShdG3zx
	 uC9Yym+bBYy0E+FhInqIKz2qazofOFBZx+YIM0Pwd2MRg+VzyhoIFkyZaGBgZSrzk/KUM
	 7k82RxYITH8ZJ0FTixKqoNpSdpzPig2Y45ZfXjs+ixMOYkJdCg8HwbBwrItuq57E+7Am8
	 4fWC6fN2e1fKgb0j0V96phCUlF70EcErUslgdxp3ZnykRZoOwCRpNTSmgS5JxnjBE7MCH
	 /8wIYz5cUKW8mCFX0qLVKCZB8rnFP1i39jO5wZZEXw51iBnK1n3ZGjkd05QkqBOpWOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eK8gRSZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135D60A2609;
	Wed, 18 Nov 2026 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eK8gRSZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F167B1F000C8;
	Wed, 18 Nov 2026 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795040362;
	bh=3B+8++5tpV3zDQLhadaZstF3q/rpXHwLZuqY72uKG7g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eK8gRSZXgH6xcPpRcmVS6hygWlYjU7ahtHVUPO7lW7UnpVz6VoKtGughcg6naqa1u
	 nIIXhik55oyQK3sbC8rSC1Hy6XRNr90cl9Sd64DAyjkU975vFZqqQ911gTOoSbcjIe
	 h0WY0FP3SSff/KYLq/70iu2oNrxFFyuXvI4729zhsXEqQGfmmQHmn0qp7pDynxFB6G
	 dLwd8gOMKIWVfFIzqdUimmVg93VebmSLlwF/vs2KxxtLq8W1zcIrXshRIr5L1j31br
	 q14Hc+NMjU31Vv1RzVqiLf0zjB+dITglaKHBdg9m2IEDjXhlguI8hxjAos1VF8jC5x
	 1wtj5KBOCtuyQ==
Subject:
 Re: [PATCH net 08/11] can: netlink: fix static FD-NON-ISO mode validation
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhuling0805@qq.com,
 stable@vger.kernel.org, socketcan@hartkopp.net, mailhol@kernel.org,
 o.rempel@pengutronix.de
Date: Wed, 18 Nov 2026 22:19:21 +0000
Message-ID: <179504036152.3136.12444797036692057668@kernel.org>
In-Reply-To: <20261117220818.1142581-9-mkl@pengutronix.de>
References: <20261117220818.1142581-9-mkl@pengutronix.de>
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

- [Low] The patch fixes a second, older bug but tags only the newer one.

--

can: netlink: fix static FD-NON-ISO mode validation

This patch moves the "fd is disabled" exception for the static FD-NON-ISO
mode in can_ctrlmode_changelink() from ctrlstatic to ctrlstatic_missing.
That stops requests such as 'fd off' or 'loopback on' from being rejected
on controllers with a static FD-NON-ISO mode. It also adds a check that
rejects any request which explicitly switches off a static control mode.

Link: https://lore.kernel.org/all/tencent_3A964832542399A780E646D6A6246335C409@qq.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115095746.709371-1-mkl%40pengutronix.de
Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-8-6826a6227d36@hartkopp.net

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 081dfddda0008..521e2496e2cc3 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -330,9 +330,17 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* static control modes can not be switched off */
> +	if (deactivated & ctrlstatic) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "static control mode %s can not be switched off",
> +				   can_get_ctrlmode_str(deactivated & ctrlstatic));
> +		return -EOPNOTSUPP;
> +	}

[Severity: Low]
Should this patch also carry a Fixes: tag for commit c9e1d8ed304c ("can:
dev: replace can_priv::ctrlmode_static by can_get_static_ctrlmode()")?

The commit message says this check closes a bug that existed before
6742ca18cb41:

  "before the above mentioned commit a request like 'fd-non-iso off'
  passed the check and removed the static CAN_CTRLMODE_FD_NON_ISO bit
  from priv->ctrlmode. As can_get_static_ctrlmode() derives the static
  modes from priv->ctrlmode, this information was lost permanently."

The permanent loss comes from can_get_static_ctrlmode() in
include/linux/can/dev.h, which was added by c9e1d8ed304c (v5.17):

    return priv->ctrlmode & ~priv->ctrlmode_supported;

Before c9e1d8ed304c, priv->ctrlmode_static was a separate field, so this
path could not clear it.

In trees that have c9e1d8ed304c but not 6742ca18cb41, take M_CAN v3.0.x or
v3.1.x, or pcan_usb_fd with firmware < 2.x. A request with
mask=FD_NON_ISO, flags=0 and FD not switched on passes the check. Then
'priv->ctrlmode &= ~cm->mask' clears the static bit. A later 'fd on' is
accepted and reported as ISO mode, while the hardware stays non-ISO.

The only tag is:

    Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")

With only that tag, will the stable tooling skip this fix for LTS trees
such as 6.1, 6.6 and 6.12? Those trees also lack ctrlstatic_missing, so
the patch would not apply there as is.

Would a second Fixes: c9e1d8ed304c tag help here? Or a note that older
trees need a separate backport?

>  	/* do not check for static fd-non-iso if 'fd' is disabled */
>  	if (!(maskedflags & CAN_CTRLMODE_FD))
> -		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
> +		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117220818.1142581-2-mkl%40pengutronix.de
