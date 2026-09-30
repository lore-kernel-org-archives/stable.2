Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2FD3ACEED;
	Wed, 30 Sep 2026 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811553; cv=none; b=gdoEzQw+ZRBxknEKI1yYCgyrgSZ1pnmix05zeHpgbhzdIiZuq+bOnR4mPM98f1aQNghzVHGuBlVa2+DRdEzna79h49qzUv9touRiJRd3X7HjlQUQRwNjc/bwXLyG+zOJWCEiVoQHuOYZv+nrjFzPRC+jLwuppS9z6vxKlTVgyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811553; c=relaxed/simple;
	bh=mZTdRyAGM22fPpS5hrH9V1sgZRvbK+cWKUOQMPGgnjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQPgTeUUKyuetS8J40XEuA7GnK2ld5obYKyxP0+Ske5ysAkscNbFlkTgaZwuxEBwxcUc91WsHT54JIx465uYVFXEsiRgJ6+858I6OTB1fnFetkn8EWVORmpCuh3POhDchWni5v11b4V42U8B8hUkg9bvXL3HlJnXOcVDzuGwnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPwU4PHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPwU4PHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A501F000FF;
	Wed, 30 Sep 2026 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790811551;
	bh=DWqCFzLlFkOdVmvdd32OLOlMg9exXKWjSzyHvJXSslY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oPwU4PHEXb2NlyU9ZDadQPIycpemqmt7T6bEXLz1RlHMFhXbAhYHRKTIhadYY9ihr
	 CBPBvsO+U0kTHp1UmGX37LMZ0rPfphoIFsyBpBNGoI3PVQ0h5ZqSEyRNS+fkoXeB8n
	 ZdKXP6WOd/l8nZuVvLxLBnvEs7V50R+qNWrMOLHSG61ulUl1ky9YEH4Put6HHQZhlj
	 QljcdWGZkcDFx84KeGy1wjqvdS7pCjcArEowZF0bbc46t4cFYuTgQtFAdWnleQrrWk
	 BVY/dS8tyLWZ80G0MdDwDoY4YHA637PYUJ1NP9ucKjbzQBtKQNduzUPHpHuXIYoXjm
	 szUX8DISBEu4A==
From: Jakub Kicinski <kuba@kernel.org>
To: bestswngs@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	co+2cf741c3005abc20@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: team: stop reusing skb after queue override
Date: Wed, 30 Sep 2026 16:39:10 -0700
Message-ID: <20260930233910.146301-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926090039.1714460-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Lets fix all the bugs in this area in one series"
---
net: team: stop reusing skb after queue override

This patch fixes a use-after-free in team_xmit(). Before it,
team_queue_override_transmit() treated a non-zero dev_queue_xmit() return
as "no handoff" and then reused the skb, which had already been consumed.
The patch reports the handoff separately from transmit success and only
tries the first override port.

> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index beffbe450612b..59dd94271ff19 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c

[ ... ]

> @@ -1864,8 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
>  	bool tx_success;
>  	unsigned int len = skb->len;
>  
> -	tx_success = team_queue_override_transmit(team, skb);
> -	if (!tx_success)
> +	if (!team_queue_override_transmit(team, skb, &tx_success))
>  		tx_success = READ_ONCE(team->ops.transmit)(team, skb);

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. This fix
relies on the transmit op always consuming the skb. Does broadcast mode
break that rule?

In bc_transmit() in drivers/net/team/team_mode_broadcast.c, the original
skb is only handed off if a txable port was found:

	if (last) {
		ret = !team_dev_queue_xmit(team, last, skb);
		if (!sum_ret)
			sum_ret = ret;
	}
	return sum_ret;

If no port passes team_port_txable(), last is NULL and the skb is neither
sent nor freed. team_xmit() then only increments tx_dropped and returns
NETDEV_TX_OK.

Does this leak the skb and its sk_wmem_alloc charge, since sock_wfree()
never runs?

Can this state be reached? team_adjust_ops() picks the mode transmit op
based only on tx_en_port_count:

	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
	    !team->mode->ops->transmit)
		WRITE_ONCE(team->ops.transmit, team_dummy_transmit);
	else
		WRITE_ONCE(team->ops.transmit, team->mode->ops->transmit);

However, team_port_txable() also requires port->linkup.

For example, say port A has link but its tx is disabled through the
tx_enabled option. Port B is oper-down but tx-enabled, which is the default
after team_port_add(). __team_carrier_check() keeps carrier on because port
A has link, and tx_en_port_count == 1 keeps bc_transmit() installed. Every
packet sent through the team device would then leak.

The same could happen if all tx-enabled ports lose link while transmits
are in flight. It could also happen if user_carrier_enabled keeps carrier
up while all ports are down.

The other transmit ops (roundrobin, random, loadbalance, activebackup and
team_dummy_transmit()) all call dev_kfree_skb_any() when they find no port.

Should bc_transmit() also call dev_kfree_skb_any(skb) when last is NULL?

[ ... ]
-- 
pw-bot: cr
