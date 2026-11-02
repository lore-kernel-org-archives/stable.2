Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632395;
	b=B/YqyxdTegJHihqLgjbDs1po6rn2l0De+v8Wh7TB6Z2RYhQvFxagfR0sF4wda81OO9Jw
	 z0aIwsKZilKwDJgXn//1cELNbbF2RtqILSryh8xGfSUTxajSkRMoQZFnwKb6pMqy99Uyu
	 xk3A6wDZ1znToc5SP+aXq9FT8rALT7p638G/ln825/fTICuZOpkYAfMVRe3rOi5zLpzGH
	 sQ4oRRAaLygeCNnBMhNDMlwJEZ1jEHdZYwjp9VZi+CxHlvAANDMjNg9j4pEhl9U6QF/Hi
	 yUi01GtgrgCEPbRDjhdSxy5scPRIH5YnKouPFPGcX3SigDKQh+wzeS9GvJfCVWUifHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632395;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fB9PkDgCE2U0R6bh8YV+nog83PKus3S1gygS4ZBj95U=;
	b=H5I4hu3GWYlHsk3Ao1h6tmEoDOFP1c02THuTDjE/8JQd+b2f+4UrVNjKD2ElLFCjyT2b
	 Nx5C6TfjApGS1lV6X7r4VtBCR13tkq9vVpolmQBWZi3vIGWPDsRi4HQykMRk5OSYkfTN+
	 D3aGmJzNKssnffdWNS4iaaS5L8G4GxXrcMGaWst497VbJ6mGsnjSM8jURAE8uFXoNWebX
	 T2lGH04e/vJeh3GxZTY9yImuyoBoR2uruT6qUsdJm/Cb8pnDusTjaMQdjWFaCNMlNT39a
	 oxpgKKY1Mggp3imEmkfBOP+AOTAvyIDggraDII1uldhJeJic2fd4p6xouMtqPv0L+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejdOEXst;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC5606D828;
	Mon,  2 Nov 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejdOEXst
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF19E1F00A17;
	Mon,  2 Nov 2026 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632394;
	bh=fB9PkDgCE2U0R6bh8YV+nog83PKus3S1gygS4ZBj95U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ejdOEXst3nyIpYGm8MqeuqVMpWK/Gp8b/HMrHlkW+SdRhncJR0GgBspNfMILBDSmb
	 vdrjN0S9dtFsGk7XivXNW4D5JzUIwOQlHXBoAUTdJHKmwBVv3ukk4iuW7uHlcKN8VX
	 nMjVdOUUzL4Y2P7A9DW1k6yojj440/HodKea3ga7ly6HrbLk/OAuaT/h+obbIxEbZx
	 +kWIjcc/hJOF1IcYwz4xHRqQhDPocGoTTiNYDkUlnQpnh7K9T0eXAZYGipfvU69YnS
	 tPN+dk2+Uo8Sm0xoMa5bEqZZkMGNP9M5NTQRchbAi9U+ItRYOBLe/h+DYy4c+sMP94
	 JFwGUb2LnjHZw==
Subject: Re: [PATCH net] netdevsim: reject port addition and clean up ports
 after a failed reload
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 15:13:13 +0000
Message-ID: <179363239328.3131.10039779072179462995@kernel.org>
In-Reply-To: <20261029145844.231018-1-omermetekaya0@gmail.com>
References: <20261029145844.231018-1-omermetekaya0@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is meant to block port creation with -EIO after a
  failed reload, but the check only lives in nsim_drv_port_add(), so VF…

Pre-existing issues:
- [High] Pre-existing, not introduced by this patch: new_port_store()
  (drivers/net/netdevsim/bus.c) calls nsim_drv_port_add() without…

--

netdevsim: reject port addition and clean up ports after a failed reload

After a failed devlink reload, nsim_drv_port_add() now returns -EIO.
nsim_dev_reload_destroy() now deletes any leftover ports on its early
return path when reload has failed. This fixes a syzbot report of a
WARN_ON in bpf_offload_dev_destroy() followed by a use-after-free in
nsim_drv_remove().

> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index feb88ccbbcedb..61f0824ce4d3b 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1697,8 +1697,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
>  {
>  	struct devlink *devlink = priv_to_devlink(nsim_dev);
>  
> -	if (devlink_is_reload_failed(devlink))
> +	if (devlink_is_reload_failed(devlink)) {
> +		nsim_dev_port_del_all(nsim_dev);
>  		return;
> +	}
>  	debugfs_remove(nsim_dev->take_snapshot);
>  
>  	if (nsim_dev_get_vfs(nsim_dev)) {

[ ... ]

> @@ -1758,7 +1760,9 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type
>  	int err;
>  
>  	devl_lock(priv_to_devlink(nsim_dev));

[Severity: High]
This is a pre-existing issue, but can nsim_drv_port_add() be reached here
with a NULL or freed nsim_dev?

In drivers/net/netdevsim/bus.c, new_port_store() calls nsim_drv_port_add()
without taking device_lock() and without checking drvdata. The sibling
handler nsim_bus_dev_numvfs_store() does both:

	device_lock(dev);
	ret = -ENOENT;
	if (dev_get_drvdata(dev))
		ret = nsim_drv_configure_vfs(nsim_bus_dev, num_vfs);
	device_unlock(dev);

The netdevsim driver does not set suppress_bind_attrs. Unbinding it runs
nsim_bus_remove()->nsim_drv_remove(), which ends with:

	devlink_free(devlink);
	dev_set_drvdata(&nsim_bus_dev->dev, NULL);

nsim_bus_dev->init stays true and the new_port attribute is not removed,
so the following sequence seems possible:

  echo netdevsimN > /sys/bus/netdevsim/drivers/netdevsim/unbind
  echo 0 > /sys/bus/netdevsim/devices/netdevsimN/new_port

new_port_store() passes the init check, then dev_get_drvdata() in
nsim_drv_port_add() returns NULL. After that,
devl_lock(priv_to_devlink(NULL)) dereferences an invalid pointer.

Suppose instead the unbind races with a new_port write and lands between
dev_get_drvdata() and devl_lock(). Would that become a use-after-free of
the devlink allocation?

The new reload_failed check runs after devl_lock(), so it does not help
here. del_port_store()->nsim_drv_port_del() appears to have the same
pattern.

> -	if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
> +	if (devlink_is_reload_failed(priv_to_devlink(nsim_dev)))
> +		err = -EIO;

[Severity: Medium]
The commit message says "Block port creation with -EIO when reload has
failed". Does this check cover every path that creates ports?

nsim_esw_switchdev_enable() calls __nsim_dev_port_add() directly and does
not check devlink_is_reload_failed():

drivers/net/netdevsim/dev.c:nsim_esw_switchdev_enable() {
	for (i = 0; i < nsim_dev_get_vfs(nsim_dev); i++) {
		err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF, i, NULL);
	...
}

After a failed reload, it can still be reached in two ways:

nsim_bus_dev_numvfs_store()
  nsim_drv_configure_vfs()
    nsim_esw_switchdev_enable()
      __nsim_dev_port_add()

devlink_nl_eswitch_set_doit()
  nsim_devlink_eswitch_mode_set()
    nsim_esw_switchdev_enable()
      __nsim_dev_port_add()

The devlink core does not block driver ops when reload_failed is set.
esw_mode can also stay at DEVLINK_ESWITCH_MODE_SWITCHDEV across a failed
reload, for two reasons:

- nsim_dev_reload_destroy() only calls nsim_esw_legacy_enable() when
  num_vfs is non-zero.
- nsim_dev_reload_create() does not reset esw_mode.

For example:

  devlink dev eswitch set ... mode switchdev   (with 0 VFs)
  set fail_reload in debugfs
  devlink dev reload ...                       (reload_failed is set)
  echo N > sriov_numvfs

This seems to create N VF netdevs and devlink ports on a device whose
traps, fib, health, psample and hwstats are already torn down. It never
returns -EIO.

At remove time, the new nsim_dev_port_del_all() call in the reload_failed
branch deletes these ports, so the bpf_offload_dev_destroy() warning does
not come back this way. However, that branch skips the VF and eswitch
reset that the normal path does:

	if (nsim_dev_get_vfs(nsim_dev)) {
		nsim_bus_dev_set_vfs(nsim_dev->nsim_bus_dev, 0);
		if (nsim_esw_mode_is_switchdev(nsim_dev))
			nsim_esw_legacy_enable(nsim_dev, NULL);
	}

After a successful retry reload, wouldn't the device be left in switchdev
mode with num_vfs == N but no VF representor ports?

A second eswitch set to switchdev returns 0 early because
mode == esw_mode. Writing the same num_vfs value is also a no-op. The
representors would only come back after num_vfs is cleared or the mode is
toggled.

Could the reload_failed check go into __nsim_dev_port_add() or
nsim_esw_switchdev_enable() instead? Putting it in nsim_drv_configure_vfs()
and nsim_devlink_eswitch_mode_set() would also work. Either way, all
port-creation paths would be covered.

> +	else if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
>  		err = -EEXIST;
>  	else
>  		err = __nsim_dev_port_add(nsim_dev, type, port_index, perm_addr);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029145844.231018-1-omermetekaya0%40gmail.com
