Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888422;
	b=oauCn2Tt3RXlH+Pgl1vCEP00nE0KWpOsq+vPIZIvv6/Em3uoeZPQVrs5iLzsjmll7qeJ
	 lL7v45uE1W4V6+5N6l986DkgIlhYYmaUtuwAINzzEAKmSHVUgb2kCBJmXQHvXDci9Gsr9
	 zTNaHOxENTTgu5YkOtrYg0dsRXwNIH9zCU6ivVbWTZzcaiZFeUQuTAjU635/2UHD4/+yY
	 qzh+8Fh8cQbrEYy+tp6F1jYCYUCRajWZkXWfabX4eFwGaaSXaWqZDM7cNiOFkYy1TXOpK
	 21G9G00KXIpXOdKCYqeO/IDHFX+8a7SnmxpAygbW1vVA9CD1FwalYcK06qzUCuKaHDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888422;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9j7OAr20v+RlMYc8MGPS5Xjx5WH+YMzD3KSivw6GqE4=;
	b=jtd4l0RtnvGnVjyDTwMCPWNsIi0VQ2bwa38Yfh8FyqE7rwAqjdys8yNz/9JDpa8pkEaG
	 iAiL6v0CU4jxosYVLkjnpW3POYxfC698KCfiAEZQC67nB1InJTRnHaADZ64Fqu2F7Zbh9
	 /iqOtJDSS79ad5piEmYBN5mzrG1mAxSgb8FruLIn+DhvV5oNVOzguU+v+Am/Nb/VghqFh
	 sZaiiLn3BOohZKGaGaMaMYeSWXcYiJSV6nIruV3llwmJjoxiZgl7enoJFIWalCU02YJ9o
	 xe7XFQZT+D4XX5FJ0oKvFucUY7XaZUUgC1l6j0PTV08p8vIha2REAFStelpOMJBFzZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP1R5ifH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2A606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP1R5ifH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6781F00919
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888422;
	bh=9j7OAr20v+RlMYc8MGPS5Xjx5WH+YMzD3KSivw6GqE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MP1R5ifHbWUMmgiizsfEf3M3nHuTTFqJzWyoUN7+6C8vZSmzxmkTBlqTPSpTope9M
	 kErRFEjQhLzJQcxFKJBCyO7xsCWMK3LbObsPQvZSNlQKm652+aYuKl5Qydyf6Tkq3M
	 ycjYNmA1hFnPJfHKakRoGC71oSN5oeuvFRHzqzbhTb1WVE/VyprpptoruERMPSgXet
	 AYR10r5XXuE4kGkCjSL0NCIpptS/dCB6E5cf6gZK4Yq2cGnF2iFBRAfQbZfIKyLwWE
	 7iswSOlnF3Qj7fXw0bse4nm+XwfeO+HN3QpaxdNBibzRjjy1LsBjrVQJxkZAMjxotn
	 MAV2l2JTaWRDg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so15374321fa.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:20:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw8eNDCKk7Pj23KxA47OMZ3m9lDexlFPoUeq2kxxNcmbMIe1htey/6etj3aFaFw1a9ZaaFjjsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8l3sFIn36Qpl0fpSXniySRwP7f/3e90XLCXzmr8JdjyOIyBjcm
	rcZnTPOZgbXhr0n1FHkoWG2X0JPQk3E5+fZ2RV6UPU96Valv+mExlfveJoSWWoZ90T/VLDOXryq
	aptZHF+sX5Cy9530QM2LYgNMy1J75PFs=
X-Received: by 2002:a05:651c:c008:20b0:3ab:43ca:1daa with SMTP id
 38308e7fff4ca-3acc5f98dc8mr27775431fa.3.1793888420723; Thu, 05 Nov 2026
 06:20:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105114707.3030737-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261105114707.3030737-1-bsdhenrymartin@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 5 Nov 2026 15:20:07 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq4AoNzymK0F+q34rVfsBM=0-cioH33ETqO=O8soNQPWA@mail.gmail.com>
X-Gm-Features: AclHuK83mSd_6LJnEiM96cq9K076X5CYXG1WWhMMBwOtTetgW1uPaRe3PIog_B8
Message-ID: <CAL4Wiiq4AoNzymK0F+q34rVfsBM=0-cioH33ETqO=O8soNQPWA@mail.gmail.com>
Subject: Re: [PATCH] nexthop: fix null-deref in nexthop_flush_dev on
 UNREGISTER rebroadcast
To: Henry Martin <bsdhenrymartin@gmail.com>, Florian Westphal <fw@strlen.de>, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, namangulati@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 5 nov. 2026 =C3=A0 12:47, Henry Martin <bsdhenrymartin@gmail.com> a=
 =C3=A9crit :
>
> A device unregistered outside its netns teardown can be stuck in
> netdev_wait_allrefs_any() while the pernet exit handlers of its
> netns run to completion.  nexthop_net_exit() frees devhash and
> sets it to NULL.  The rebroadcasts then hit nexthop_flush_dev(),
> which dereferences the NULL pointer, e.g. on mainline v7.4-rc1
> (KASAN build):
>
>     Oops: general protection fault, probably for non-canonical
>     address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
>     KASAN: null-ptr-deref in range [0x0000000000000020-0x27]
>     RIP: 0010:nexthop_flush_dev+0xb8/0x240
>     Call Trace:
>      nh_netdev_event+0x250/0x330
>      netdev_run_todo+0xaa2/0xef0
>      rtnl_dellink+0x35f/0xa90
>
> The faulting task holds RTNL, so the network stack is left wedged.
>
> Skip the rebroadcasts, which are the only NETDEV_UNREGISTER events
> delivered with reg_state =3D=3D NETREG_UNREGISTERED.  This mirrors
> commit fd0909e963ed8 ("netdev-genl: ignore NETDEV_UNREGISTER
> rebroadcasts").
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Fixes: 8a4fc54b07d75 ("net: get rid of rtnl_lock_unregistering()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/ipv4/nexthop.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 42e55b5a755ee..1eba7026abcae 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -3996,7 +3996,16 @@ static int nh_netdev_event(struct notifier_block *=
this,
>
>         switch (event) {
>         case NETDEV_DOWN:
> +               nexthop_flush_dev(dev, event);
> +               break;
>         case NETDEV_UNREGISTER:
> +               /* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGIST=
ER
> +                * while waiting for the last references to be dropped; t=
he
> +                * netns and its nexthop pernet state may already be torn
> +                * down by then.
> +                */
> +               if (READ_ONCE(dev->reg_state) =3D=3D NETREG_UNREGISTERED)
> +                       break;
>                 nexthop_flush_dev(dev, event);
>                 break;
>         case NETDEV_CHANGE:

Thanks for the report Henry, I was able to reproduce this crash.

Your patch is correct for nexthop: the first NETDEV_UNREGISTER already
removed all nexthops using the device, and no new one can be attached
to an unlisted device.

But I would prefer to fix this in the core instead, for these reasons:

1. This is the second instance of the same bug after netdev-genl, and
it will not be the last. Any netdevice notifier using pernet state of
dev_net(dev) in its NETDEV_UNREGISTER handler is exposed. Adding a
reg_state check in all of them is whack-a-mole.
2. The NULL deref is only the first symptom. Once cleanup_net()
completes, struct net itself is freed, while the stuck device still
points to it. Following rebroadcasts then hit a use-after-free:
   - netdev_wait_allrefs_any() itself: __rtnl_net_lock(dev_net(dev))
with CONFIG_DEBUG_NET_SMALL_RTNL=3Dy.
   - Any notifier reading dev_net(dev) before checking reg_state, for
instance ipmr_device_event() walking net->ipv4.mr_tables.

   A reg_state check in nexthop (or netdev-genl) does not help there.
3. The root cause is my commit 8a4fc54b07d7 ("net: get rid of
rtnl_lock_unregistering()"). The barrier it removed had been added by
50624c934db1 ("net: Delay default_device_exit_batch until no devices
are unregistering v2") precisely to prevent this situation. I only
considered the loopback dependency when removing it, and missed the
notifiers one.
4. Restoring this guarantee in the core is cheap: a per-netns counter
of devices sitting in netdev_run_todo(), and
default_device_exit_batch() waiting for it to reach zero once all
devices of the dying netns are unlisted. In the common case the
counter is already zero and there is no wait.

   Then all NETDEV_UNREGISTER handlers, including rebroadcasts, can
again assume that dev_net(dev) and its pernet state are alive, and
nexthop needs no change.

I tested this with a KASAN kernel, using your scenario (a nexthop on a
veth whose peer is deleted from another netns while a reference is
held, then the netns is deleted). The crash goes away.

I will send the patch shortly, with your Reported-by: tag.

Thanks.

pw-bot: rejected
