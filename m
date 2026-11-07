Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053239;
	b=vZanYSqyeHECk2+D9xF4/VX992001KhKnRD1BewaFsJN6OcK4B65hdR/ItaK09V1i4u4
	 gOkdFHzX9eYEI2HmLwjGY+veZAIDZ7j4wHLrtcX3lAYKsSHs/bwPWtSdgyHXu+KZwGGqO
	 h3ur+2yvJ8JNFX9FbNy2KY0etkl4dGsUbnF3HK7/wJUsQNDF1vbiyt9ABWrFFwbREIAK6
	 yr/GKr6fikiCKLhpYfs7x1Vn/0s284KTupJgpdjMoRFNgKGRaO+fsM4jdF7n/1aiiVvYR
	 P66m0DrGa1+52ftFNdY9zmlBNdMtq8Y5WJZt59ym855Y0c4AOArjoW1LIME6HDkDN1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053239;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=T4DQgQD6BZb0zJ5cyJeM3EcgoStNMi0qYJ/wpTmwtr4=;
	b=qjskhAug/jC4amQgMQH0lYjHRuvV13Hujeen74sn3iZmrrqFBj6Z8T6PS4OeKinLfnRQ
	 ZUrSGbEYiMPL77bC/6sGDRsLuUKQfw9sDQqUmvPjeyyXRyq+IZpuODVzCUSCHRmRiiChC
	 5T1RxMOjJW/SbwptpfqrJT+Q0Zw4CgZg2d2Uu1c/NWUESia3ljUr/btWjGTZEhca9XSHW
	 K0Z3L0KWbE+y+zmXInnMZVECNFB7EJWH9uiMUsd/6lhLJv2GOgNrQknuceHvvG6sFgrCA
	 7byiiIjNEtMyCvkPPMpUvyHVMF4uFZNXteIG00h8QBJ28jMDJlBD7Mkw0ZxejLt/EWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Wg2L/Ac5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FD606A32F;
	Sat,  7 Nov 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wg2L/Ac5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C11F008A1;
	Sat,  7 Nov 2026 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053238;
	bh=T4DQgQD6BZb0zJ5cyJeM3EcgoStNMi0qYJ/wpTmwtr4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wg2L/Ac5CiE1owO1n/ALeS0Fr2aktZ01dK3drBIzfVpfJTTYFUpy7bKRUFXBfIZwT
	 8foTK49KOHVNZEmpioGzfaX8xdL6Db/S0qF90qSQs6QulwRSMUHd9Rpjgvtiw8F6/7
	 SwR7uhXkricVzPD9dTwPQ/6C9pChv9/IAJqEUp3Y7N5mzdFN8zXrOXIrjxm5751MYt
	 CQ++bZgMIrf4Iboz7M8ASUQhg/shNHPKt+tJks/gkpr1Pabj7D0zTeruwtlv9sfKF3
	 785Ei2N3Qr+CV+WCb8FLJ/Fj1qpUG7mSgIcyxhq26Fr+Tt0tQNjIAlVXDkRSGl+p6I
	 flxslhFeB5jBA==
Subject: Re: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC
 write failure
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 12:07:17 +0000
Message-ID: <179405323723.994134.11947248661617076904@kernel.org>
In-Reply-To: <20261103102851.1340480-1-vulab@iscas.ac.cn>
References: <20261103102851.1340480-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the enable-path leak but adds the same leak on
  the port-removal path.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  mlxsw_sp1_ptp_mtpppc_update() has no serialization between its two…
- [Low] The new rollback in mlxsw_sp1_ptp_mtpppc_update()
  (spectrum_ptp.c:1223-1226) calls mlxsw_sp_parsing_depth_dec().

--

mlxsw: spectrum_ptp: release parsing depth on MTPPPC write failure

This patch reorders mlxsw_sp1_ptp_mtpppc_update() so the MTPPPC register is
written before the parsing depth reference is adjusted. If the write fails,
the reference taken on the first enable is released. On the disable
transition, the reference is now dropped only after the write succeeds.

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> index 9c5862f4e16a3..0db77af4828f1 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c

[ ... ]

> @@ -1214,12 +1215,21 @@ static int mlxsw_sp1_ptp_mtpppc_update(struct mlxsw_sp_port *mlxsw_sp_port,
>  			netdev_err(mlxsw_sp_port->dev, "Failed to increase parsing depth");
>  			return err;
>  		}
> +		depth_inc = true;
>  	}
> +
> +	err = mlxsw_sp1_ptp_mtpppc_set(mlxsw_sp_port->mlxsw_sp,
> +				       ing_types, egr_types);
> +	if (err) {
> +		if (depth_inc)
> +			mlxsw_sp_parsing_depth_dec(mlxsw_sp);

[Severity: Low]
This is a pre-existing issue, but mlxsw_sp_parsing_depth_dec() ignores the
result of the MPRS write and sets the cached depth anyway:

drivers/net/ethernet/mellanox/mlxsw/spectrum.c:mlxsw_sp_parsing_depth_dec() {
    ...
	mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(mprs), mprs_pl);
	mlxsw_sp->parsing.parsing_depth = MLXSW_SP_DEFAULT_PARSING_DEPTH;
    ...
}

Suppose the MPRS write also fails on this new rollback path. Would the ASIC
then stay at the increased parsing depth while software records the default
depth with no references held?

The existing VXLAN and IPIP callers have the same behaviour. The next MPRS
write would bring hardware and software back in line.

> +		return err;
> +	}
> +
>  	if (!(ing_types || egr_types) && (orig_ing_types || orig_egr_types))
>  		mlxsw_sp_parsing_depth_dec(mlxsw_sp);

[Severity: High]
Can this leak the parsing depth reference when a port is removed?

mlxsw_sp_port_remove() calls mlxsw_sp_port_ptp_clear(), and that helper
ignores the return value of hwtstamp_set():

drivers/net/ethernet/mellanox/mlxsw/spectrum.c:mlxsw_sp_port_ptp_clear() {
	struct kernel_hwtstamp_config config = {};

	mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_set(mlxsw_sp_port, &config,
						       NULL);
}

Take the case where the removed port is the last one with timestamping
enabled and the MTPPPC write fails during this clear. This can happen on
devlink reload, port split/unsplit, line card removal or driver unbind.

mlxsw_sp1_ptp_mtpppc_update() now returns before the disable-path
mlxsw_sp_parsing_depth_dec(). mlxsw_sp1_ptp_hwtstamp_set() then returns
before it clears ptp.ing_types and ptp.egr_types.

mlxsw_sp_port_remove() carries on regardless:

	mlxsw_sp_port_ptp_clear(mlxsw_sp_port);
	mlxsw_sp_port_vlan_classification_set(mlxsw_sp_port, true, true);
	mlxsw_sp->ports[local_port] = NULL;
	...
	free_netdev(mlxsw_sp_port->dev);

After the port leaves mlxsw_sp->ports[], no later orig_ing_types or
orig_egr_types scan can see it, so nothing ever drops that reference.

The next first enable on another port sees orig == 0 and takes the
reference again, so the count goes to 2. Disabling that port only brings it
back to 1, and MPRS stays at the increased depth even though MTPPPC has
been written to 0.

mlxsw_sp1_ptp_fini() then writes MTPPPC to 0 without releasing anything,
and mlxsw_sp_parsing_fini() would hit:

	WARN_ON_ONCE(refcount_read(&mlxsw_sp->parsing.parsing_depth_ref));

The old code dropped the reference before the write. That is the behaviour
this caller depends on, since it throws away the port's software state
whatever the result.

The commit message says:

    so that the reference count always matches the programmed state.

Would the removal path need a forced release, for example in
mlxsw_sp_port_ptp_clear(), for this to hold?

>  
> -	return mlxsw_sp1_ptp_mtpppc_set(mlxsw_sp_port->mlxsw_sp,
> -				       ing_types, egr_types);
> +	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but is mlxsw_sp1_ptp_mtpppc_update()
serialized against port removal at all?

The ndo_hwtstamp_set path runs under RTNL only: dev_ioctl() takes
rtnl_net_lock() for SIOCSHWTSTAMP. mlxsw_sp_port_remove() calls
mlxsw_sp_port_ptp_clear() after unregister_netdev() has already released
RTNL, so that path holds only the devlink instance lock.

The function reads every port's types with no common lock held:

	for (i = 1; i < mlxsw_core_max_ports(mlxsw_sp->core); i++) {
		tmp = mlxsw_sp->ports[i];
		if (tmp) {
			orig_ing_types |= tmp->ptp.ing_types;
	...

It then decides whether to inc or dec and writes the global MTPPPC
register. The per-port types are published only afterwards, in
mlxsw_sp1_ptp_hwtstamp_set(). parsing.lock is taken only inside the inc/dec
helpers, so it does not cover the check-then-act sequence.

Start with port A as the only timestamping port (ref = 1):

CPU0 (removing port A)              CPU1 (enabling port B)
mtpppc_update()
  orig != 0, new == 0
                                    mtpppc_update()
                                      sees A's types, skips inc
                                      MTPPPC = A|B
  MTPPPC = 0
  parsing_depth_dec() -> ref = 0

Port B now believes timestamping is enabled, but MTPPPC is 0 and the parsing
depth is back at the default. When B is disabled later it decrements again.
That either underflows the refcount or drops a reference held by VXLAN or
IPIP.

There is also a lifetime problem. CPU1 loads tmp = mlxsw_sp->ports[i] and
then dereferences tmp->ptp.*. In the meantime CPU0 can set
mlxsw_sp->ports[local_port] = NULL and call free_netdev(). The port is
netdev_priv(), so can this read freed memory?

Under this concurrency, the "always matches the programmed state" claim in
the commit message doesn't seem to hold either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103102851.1340480-1-vulab%40iscas.ac.cn
