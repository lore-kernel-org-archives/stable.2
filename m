Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0B3CDBD3;
	Thu, 17 Sep 2026 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675542; cv=none; b=cXres6E9HDzHv2QMRMCyYV2R2mbS4KD8djqsvPo7lMW8M4faJmemCD6hRQUaR0J7TGLBvhNRNvKVRusAJnfhmbrTDgbhVHYBUT/yNrOQiCmmbrp6OSivScRRbEqwsPsnm+al1Oh6Gh6Y4ZKt8+WAI8QRS+5tlmpSO+D2jKQZVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675542; c=relaxed/simple;
	bh=GNiDzXO14cDFLHSrneHYdCGSV6sSR6GgVqXHOxgawbI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUE9PPhCAxQ4NL6Y1bcfzlbTluE5dYLeNbDJzresFhqt1OImpgeZ1PLfctyQMX/Ht9UpNc4mdMK7MxDvVtdBeKGXS44sD/cEIv+VjefBjTW2YghdQVkdmzZJX8Xztrt+/mRuXof87AdB5vtQaQaURPbL/NWR5UnkIMZuPAyqz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE1FZOpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE1FZOpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31F81F000FF;
	Thu, 17 Sep 2026 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675540;
	bh=Er2BY6U9h42ItjW5DZ/9PeWsE2jitUgEHLUUtX6RBoo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HE1FZOpl3W0JTi+sZ4Ud/5CT6+eSwXPOASVyUjGsEytc4Omd9uuk3icHlwVlQK6Q9
	 VlhlXaYTy193sUVXEx281R6ETU6fAsi5kgG7nkKOAJq4nEx3u3oglRkpxv3YpjArvN
	 VMSA0LKFT31wcEZd5mIbI7JaodMCq0ccN8dCUqa7AvY8cXYsZKayoEeDhWNj2bZL1j
	 mw39gMDzNkno//4phKaTuAy8KmP6Idhffao10UqWmTxx/UKRZbAZefgkRSmhRmbgyi
	 bKjVY9ffmGdoq32ANPw4cBiQH+y933tykxmobDha5s7t/eEmXB6yQSEpnpRZphTOp2
	 wunKqpszhi0SQ==
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix netdev reference leak on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, f.fainelli@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 20:05:39 +0000
Message-ID: <178967553941.22033.735612463412868083@kernel.org>
In-Reply-To: <20260916020340.2580417-1-lgs201920130244@gmail.com>
References: <20260916020340.2580417-1-lgs201920130244@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] mv88e6xxx_remove() (drivers/net/dsa/mv88e6xxx/chip.c:7499-7500)
  now calls dev_put(pdata->netdev), but the mv88e6xxx driver never…
- [Medium] The changelog states as established fact that
  'mv88e6xxx_probe() uses the referenced network device provided through…
- [Medium] The commit message asserts 'The probe failure path correctly
  calls dev_put() for pdata->netdev', but one probe failure exit still…

--

net: dsa: mv88e6xxx: fix netdev reference leak on remove

This adds a dev_put(pdata->netdev) call at the end of mv88e6xxx_remove()
to mirror the dev_put() that already exists on the probe error path, on
the grounds that a successful probe leaves the platform-data supplied
net_device reference unbalanced.  The change is tagged Fixes: and
Cc: stable.

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 7f68a0c558026..4869fcba34cb4 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c

>     mv88e6xxx_probe() uses the referenced network device provided through
>     platform data, but the remove path does not drop the corresponding
>     reference.
>
>     The probe failure path correctly calls dev_put() for pdata->netdev.

[Severity: Medium]
Can the phrase "uses the referenced network device" be backed up by code in
the driver?  Searching drivers/net/dsa/mv88e6xxx/ for an acquire turns up
nothing: there is no dev_hold(), no netdev_hold() and no dev_get_by_name()
anywhere in the driver.  The only two reference operations are the existing
dev_put() at the probe out: label and the one this patch adds.

What mv88e6xxx_probe() actually does with pdata->netdev is validate it and
publish its embedded struct device:

	if (pdata) {
		compat_info = pdata_device_get_match_data(dev);

		if (!pdata->netdev)
			return -EINVAL;

		for (port = 0; port < DSA_MAX_PORTS; port++) {
			...
			pdata->cd.netdev[port] = &pdata->netdev->dev;
			break;
		}
	}

The DSA core does its own balanced accounting for the conduit in
dsa_port_parse():

	conduit = to_net_dev(d);
	netdev_hold(conduit, &dp->conduit_tracker, GFP_KERNEL);
	put_device(d);

and releases it from dsa_switch_release_ports() (reached via
dsa_unregister_switch()) and dsa_switch_shutdown().

Also, include/linux/platform_data/mv88e6xxx.h documents only that cd must
come first; it says nothing about who holds or drops the netdev reference.
Could the changelog state which side of the interface takes the reference,
and could that rule be written down in the header if the patch is respun?

One more behavioural note for backporters: before this patch the reference
was consumed only on probe failure and retained on success; afterwards it is
also consumed on remove.  A provider written against the old behaviour
(hold before mdio_device_register(), put after removal) would now double-put.

> @@ -7472,6 +7472,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
>  
>  static void mv88e6xxx_remove(struct mdio_device *mdiodev)
>  {
> +	struct dsa_mv88e6xxx_pdata *pdata = mdiodev->dev.platform_data;
>  	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
>  	struct mv88e6xxx_chip *chip;
>  
> @@ -7494,6 +7495,9 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
>  		mv88e6xxx_irq_poll_free(chip);
>  
>  	mv88e6xxx_phy_destroy(chip);
> +
> +	if (pdata)
> +		dev_put(pdata->netdev);
>  }

[Severity: High]
Can this underflow the refcount of pdata->netdev?  Since the driver never
acquires a reference on that net_device, this put has no matching get.

Platform data outlives a single binding, so the put here is not idempotent
across the device lifetime:

  bind    -> mv88e6xxx_probe()  takes no reference
  unbind  -> mv88e6xxx_remove() dev_put(pdata->netdev)
  bind    -> mv88e6xxx_probe()  takes no reference
  unbind  -> mv88e6xxx_remove() dev_put(pdata->netdev)

The same holds for a deferred or failed probe followed by a successful one:
the out: label in mv88e6xxx_probe() already issues one put, and remove now
issues another, for at most one donated reference.

	out:
		if (pdata)
			dev_put(pdata->netdev);

		return err;

Once the count drops below what was taken, the conduit net_device can be
freed while pdata->cd.netdev[] still points at its embedded struct device,
which the next probe dereferences through dev_find_class()/get_device()/
to_net_dev() in dsa_port_parse().

Would it be better to make the acquire side explicit, i.e. add a
dev_hold()/netdev_hold() in mv88e6xxx_probe() paired with puts on both the
error and remove paths, or alternatively drop the unmatched dev_put() in the
probe error path?  As written the patch extends the unmatched-put pattern
rather than balancing it.

[Severity: Medium]
Taking the ownership model in this patch at face value, is one probe failure
exit still missing the put?  After the pdata block has validated
pdata->netdev and stored &pdata->netdev->dev into pdata->cd.netdev[port],
the compatible check in mv88e6xxx_probe() returns directly:

	if (!compat_info)
		return -EINVAL;

pdata_device_get_match_data() returns NULL whenever pdata->compatible
matches no entry of the driver's of_match_table:

	for (; matches->name[0] || matches->type[0] || matches->compatible[0];
	     matches++) {
		if (!strcmp(pdata->compatible, matches->compatible))
			return matches->data;
	}
	return NULL;

so that path skips the out: label and its dev_put(pdata->netdev), which
contradicts the changelog statement that "The probe failure path correctly
calls dev_put() for pdata->netdev".  Would changing it to
"err = -EINVAL; goto out;" be appropriate here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916020340.2580417-1-lgs201920130244%40gmail.com
