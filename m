Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AC1F30BB;
	Sat, 17 Oct 2026 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792270362; cv=pass; b=gG6bCAdQ/Kgq6VYhbneda/iVgHcLgB7uANjDBPiXLS+bhXBzewynqnMxiouy/vEb/3e0f7Xsz88VRDDhYSQxJe0SAySH2lnS8ymbv4XTmrlwIalTwGiLRJ2OWATJxDIc6U12Zqh6Dak+loDl5ytIhWAvGQmRYzwfcV9hADe5X74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792270362; c=relaxed/simple;
	bh=PZWlQ/Jb9uuec6yHjcVfpSgfLVlMyZ9mjWW7/Gkgy/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWkp5AYw7hFvfS/NNzRMOYDYkFe7rdUNv2pXA/iRcQ934VPc+bnO5a76WhXQOu1WT7sVrAuxJ0UePld5PYi3mtc6FPvszIH1QDDYNRONGO/EyhnBeY+F0wOJS4Lq0hxNgPt8IdyNB/IArtDnjZfStZkWo6RwFVyGbte4upBhTRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=LEKqCmIp; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="LEKqCmIp"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 77A0D201B9F;
	Sat, 17 Oct 2026 22:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792270357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pg/IFoKVAys457OjK/fDR2aVL5yf3Pec2r1MUlKxOnA=;
	b=LEKqCmIpdi1R+PyAAiQjMz+QXEPQE53AA5NGQxBT/TnpwC8q8Ie2GpeZZTCoOED36HNMun
	aQyiLG8Yw3dJu5ijUTkaFA+ihNCOe5O0cPdmw2m9gZKWB1lxXGqYskN5fWByZFz7/DsfRz
	Xk41QqSceD2qc2FiCNXco2CQ+/VpZfJ2DP07m9Oj+YzAebrD65XuA/a0bxOwiSHjDvNqSG
	i+jTaqVaN3OD0mPxoKDhf/pqJex1MAsXp7VvL58wW12YCXKaq5jg9uub6ek+5u7pnffkM6
	aQV0Kq81CIErke0RT6KijQB1or8b6Yc4QS5R0bNotlzSqXwl+Gajc9UWyUHS2g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792270357; a=rsa-sha256;
	cv=none;
	b=aAUOKgexuhwX4gM9qP3KtrjpPvf4KIhKlkm5zKNj6UlmWYKl8lQNRaiR7PMctfXBED5/Fa
	rtBeS8/mL9fBfA5ZIcK6XpkvbFoeCZ7M4GUiBbinJ9eCF1Pw+GpY8nlFRsvkKIfZ71ELvw
	YBE1Lw1kzseTvx825PVzniWx0tyBGJnIJrtC0y+WVSLp9krnYjWfGwvjZrwhv/kApRodBY
	UMXPu6HQ3fItKp6PlrwrUiI18NdNl7XWLMhnG3phm1gaabw7OUG9GpDeEQly2JsH8WWjQN
	q9cY4WO7O3dRE0fr71ZvKo9faCh1PsSrBJ+BGPnwTu6V6amdtQWshi+TYtnM9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792270357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pg/IFoKVAys457OjK/fDR2aVL5yf3Pec2r1MUlKxOnA=;
	b=TD0hJvdISOEfDeFqYEfMNFLyPfMUsPAO0R/d2bg69wehxvZRIKYKEcZe+QcU3FkFGBGqwu
	2OfQNikm4jeTUa1Hp2IY6VGVCamJJsIHyPEb7taeIMfR3fPBLnW+WYJit/jWABEdTWXZdd
	Ve4vWu2QW2l8k9OXIpA+YQM6Z3CKXeocadxG1cKiecnD9+qX13NXra5r9cHTvKn7VAHHnz
	y5aVyDK1KYBphEiFVSd4cY2ViJWZufkwE1xOSe4xHCxY2kzZUarhAST+vgQnqyZNGWRPZB
	7sfAsQ+HkAqCOdbXgJLqKA2ujFAJJavgKdybG+LZXL4Gb9UOhI6bBibL/Ve9GQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIBOP-006TIu-1F;
	Sat, 17 Oct 2026 22:52:37 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C5845C7813;
	Sat, 17 Oct 2026 20:52:37 +0000 (UTC)
Date: Sat, 17 Oct 2026 22:52:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Norbert Szetei <norbert@doyensec.com>, 
	stable@vger.kernel.org
Subject: Re: [RFC PATCH can-next] can: protect the receive lists with a
 per-device lock
Message-ID: <20261017-unbreakable-arboreal-pug-82cb07-mkl@pengutronix.de>
References: <20261017201935.399233-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3wczge5qzgud7dja"
Content-Disposition: inline
In-Reply-To: <20261017201935.399233-1-socketcan@hartkopp.net>


--3wczge5qzgud7dja
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH can-next] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 17.10.2026 22:19:35, Oliver Hartkopp wrote:
> The receive lists of a CAN device are located in the device's
> can_ml_priv and travel with the device when it is moved to another
> network namespace. But they are protected by the per-netns
> rcvlists_lock. So can_rx_unregister() needs dev_net(dev) to pick the
> right lock and silently returns when the passed namespace does not
> match dev_net(dev) anymore.
>
> isotp_release() and bcm_release() remove the socket from their notifier
> list before they take any lock that serializes against the netdev
> notifier chain, which runs under RTNL. A socket that leaves the list in
> this window is skipped by isotp_notify() / bcm_notify() and has to
> remove its CAN filters itself.
>
> This fails when the bound device is moved to another network namespace
> in this window: isotp_release() passes sock_net(sk) to
> can_rx_unregister() and bcm_rx_unreg() reads dev_net(dev) without
> holding RTNL, so can_rx_unregister() does not find the filters. As
> can_rx_register() stores rcv->sk without taking a reference, the
> remaining receivers point to the freed socket (isotp) or the freed op
> (bcm) and travel with the device into the new namespace:
>
>   BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
>   Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
>    can_rcv_filter+0x4af/0x8c0
>    can_receive+0x28d/0x3c0
>    can_rcv+0x2a9/0x310
>    __netif_receive_skb_one_core+0x21a/0x260
>    process_backlog+0x210/0x760
>
> raw_release() is not affected, as it removes the filters with
> dev_net(ro->dev) under RTNL. But raw_release(), raw_setsockopt() and
> raw_bind() hold RTNL while removing and adding up to CAN_RAW_FILTER_MAX
> filters per socket. As this can be triggered repeatedly by unprivileged
> users, e.g. by binding CAN_RAW sockets alternately to different CAN
> devices, RTNL becomes a global bottleneck. Extending this RTNL usage to
> isotp_release() and bcm_release() is therefore no option.
>
> Instead fix the root cause and add a spinlock to struct
> can_dev_rcv_lists, which protects the receive lists of a CAN device or
> the 'any' CAN device lists of a namespace. can_rx_unregister() now finds
> the subscription independently from the current namespace of the
> device. The protocols hold a tracked reference to the device (ro->dev,
> so->dev, op->rx_reg_dev), which keeps the device's receive lists
> accessible. The per-netns rcvlists_lock only protects the receive list
> statistics anymore. The callers pass the namespace that has been used
> for can_rx_register() to keep these statistics balanced.
>
> The lock of the CAN device receive lists is initialized in
> can_set_ml_priv(), which is used by all CAN network devices to set up
> their can_ml_priv.
>
> With this, raw_release(), isotp_release(), bcm_release() and
> raw_setsockopt() do not need RTNL anymore. A socket that leaves the
> notifier list while its device changes the namespace removes its
> filters itself, which now always works. The filters are removed under
> lock_sock() only, with cond_resched() between the filters. The
> existing busy-wait loops on the *_busy_notifier variables remain
> unchanged.
>
> raw_setsockopt() now reads dev->reg_state without RTNL. Use READ_ONCE()
> for this check, which is only a shortcut now: When the device is
> unregistered concurrently, raw_notify() waits for lock_sock() and
> removes the filters that have been set by raw_setsockopt(). The filters
> are copied from user space before lock_sock() is taken, so a stalled
> copy can not hold lock_sock() and thereby block a concurrent
> NETDEV_UNREGISTER that waits for lock_sock() under RTNL in raw_notify().
>
> raw_bind() and isotp_bind() took RTNL to serialize the device lookup
> and the binding with NETDEV_UNREGISTER, as raw_notify() and
> isotp_notify() checked ro->dev and so->dev without lock_sock(). Now
> raw_notify() and isotp_notify() check ro->dev and so->dev under
> lock_sock() in the NETDEV_UNREGISTER case, and the device lookup in
> raw_bind() and isotp_bind() is done under lock_sock() too. Both on
> device unregistration and on a namespace change, unlist_netdevice() and
> synchronize_net() are executed before NETDEV_UNREGISTER is sent. So
> either the notifier gets lock_sock() first and a subsequent bind() can
> not look up the device anymore, or bind() gets lock_sock() first and the
> notifier finds the new binding afterwards and removes it. A bind() that
> looked up the device just before unlist_netdevice() but takes
> lock_sock() only after the notifier has run registers its filters on the
> unlisted device; these are removed when netdev_wait_allrefs() rebroadcasts
> NETDEV_UNREGISTER while waiting for the tracked device reference. With
> this, raw_bind() and isotp_bind() do not need RTNL anymore. raw_bind()
> removes the filters of the previously bound device with sock_net(sk),
> which has been used for can_rx_register().
>
> raw_notify() and isotp_notify() keep a lockless READ_ONCE() fast path
> that skips sockets not bound to the vanishing device, so the notifier
> (running under RTNL) only serializes against lock_sock() of the sockets
> actually bound to this device, not against every CAN_RAW / CAN_ISOTP
> socket in the namespace. ro->dev / so->dev are rechecked under
> lock_sock() in the NETDEV_UNREGISTER case; a bind() that sets the
> pointer right after the lockless check is caught by the
> NETDEV_UNREGISTER rebroadcast described above.
>
> The NETDEV_DOWN case only reports an error to the socket and keeps
> checking ro->dev and so->dev locklessly. ro->dev and so->dev are read
> with READ_ONCE() and written with WRITE_ONCE() where they are changed
> in bind() and in the notifier. dev->flags is read with READ_ONCE() in
> bind() as it is read without RTNL now.
>
> Other users of can_rx_unregister() benefit as well: j1939 removes its
> filter with dev_net(ndev). When the device has been moved to another
> namespace after can_rx_register(), this picked the rcvlists_lock of the
> new namespace to protect the device's receive lists. Now the receive
> lists are always protected by the per-device lock. The receive list
> statistics of the namespaces may still become imprecise in this case,
> as before.
>
> Measured with four CAN_RAW sockets each rebinding CAN_RAW_FILTER_MAX
> (512) filters between two vcan devices for 15s, on a kernel with lockdep
> and CONFIG_LOCK_STAT (which inflates the absolute numbers, so only the
> comparison matters). Without this patch raw_bind() is an rtnl_mutex
> contention point and the rebind rate is ~32/s; with it raw_bind() no
> longer takes rtnl_mutex, the rate rises to ~99/s and the rtnl_mutex
> contention from this workload disappears (rtnl_mutex contentions
> 1621 -> 213, rtnl_mutex.wait_lock 307 -> 0). An unrelated
> ip link add/del running in parallel is no longer stalled behind the
> filter churn.
>
> Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with concurrent=
 NETDEV_UNREGISTER")
> Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
> Reported-by: Norbert Szetei <norbert@doyensec.com>
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301=
A8E@doyensec.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Can you make use of Documentation/dev-tools/context-analysis.rst for
this series to document what each lock protects?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3wczge5qzgud7dja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatPgEgAKCRDMOmT6rpmt
0gHSAPwPNDknypxjCueIzgHvgvAJngExPG7lZYFlW/d9448C/AD8DT7em/zvOuLu
8agGjgq8J6+9W4SWfhieptFK0vGKTg8=
=WIUY
-----END PGP SIGNATURE-----

--3wczge5qzgud7dja--
