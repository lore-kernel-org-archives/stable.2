Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520989;
	b=tuy73esT/oJI+HQPiVhd5d75mdxjmmHEw+lCEZG0XOSuAuNoendWzYwDM/laaImESPq1
	 RwcunwPykoInkym36m0aPiQFwinh/hXk0+XcXggmRuMoa+V87MPJ5U1O0eqMijEbM3359
	 igWwA1XYNZxlwTxAwXPVZJnX00mO41bZXq6gmw9lk9GfxspAhJUr8sSpHoNgA9Svq1JVo
	 jqHMb1ftHBi0qrrfLf5Gf8YoXvSXILHqlc4tJp1Id4L6MI0yfCMtQNLpD9sKvJvb993yr
	 Awi795l19Wm0gdKJOkqH7ZcNK1dpJrTy7msU1TvVxZBzIaEv8cp0f8agj6JHrYPb6+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520989;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J6Da50J1V8Sxf6MbTURmnFjnMgqzNALvpXgpfJtWA6g=;
	b=VK2AIqmQf33y2TBRKbvDrUzPsnI4jRNJ43mOoQ2U/2LZBcbywqWTjW9T8h1dAGEQTebX
	 8V1fVT0izIhNihDxiNl3TKQEkG0L2CTA72IBa6ly2Huvc1VrouyuR5RUhbJNpPXMkbNTt
	 oUuj3sYMvK2NGujjftH7CxpPOVwQi2hh6dP8V8BzbeuOvlqTX4aoyy+f4gH4SLybxlT45
	 LDlRtO41gtD8/sLe2vvIY8FQzxhtu1TeL7LbIz2vbrAdbp1d2BNFhdKT/1ohboId2qV6B
	 JsaTLbN3CaeHidwGfXVtwgOYtJXTyPESfpn3b64EUKZcPFpbBJQ5NEmCcGoaVk0KuQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZUbD+ZK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571A606A31C;
	Thu, 12 Nov 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZUbD+ZK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979911F000C4;
	Thu, 12 Nov 2026 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520989;
	bh=J6Da50J1V8Sxf6MbTURmnFjnMgqzNALvpXgpfJtWA6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aZUbD+ZKFwkQgxT5VsLJNK35sCqd1Dkwql1U1jW5dNGhtmirRAtrMXgR76vfu/LUj
	 rvDHchTjL4ofamZab2MD1xmVH0rpG91uL6Gt5ZnGRhAIEZ+jAlCRh7BbQOA4vwlh6R
	 GRQaC25HorukNtgKe9az2to+rs2ye4DDlEY6Gne/DUJXJyUVy8os9QKnx1UNXl/mAj
	 KyadDR7rCr27TAWlREvrKLm39lKZ6jcBZX7CCB4ozsTWdHgxaAMXoPuDQp7sdj2btG
	 LU0Fvi++qUZec+XQxVTIK8rssclbFFjKg6hAJ9zLkV4mRtepG4b6Qm6i18Z+exJADU
	 o0/SeTY/7fmbg==
Subject:
 Re: [PATCH net] net: tn40xx: fix swnode use-after-free on probe failure
From: netdev-bot+sashiko@kernel.org
To: johan@kernel.org
Cc: fujita.tomonori@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, stable@vger.kernel.org, hfdevel@gmx.net
Date: Thu, 12 Nov 2026 22:03:08 +0000
Message-ID: <179452098811.2199510.15081106290449010908@kernel.org>
In-Reply-To: <20261110100051.2567443-1-johan@kernel.org>
References: <20261110100051.2567443-1-johan@kernel.org>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch rests on a wrong premise and adds a refcount leak of
  the MDIO software node, along with a dangling pointer into freed…

--

net: tn40xx: fix swnode use-after-free on probe failure

This commit removes the fwnode_handle_put() of the MDIO bus firmware node
from tn40_swnodes_cleanup() and calls it a stray reference decrement. The
commit message says this put causes a use-after-free when the software
node group is unregistered on probe failure and on driver unbind.

> diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
> index fb1a4a2e4dbc5..49951477ac052 100644
> --- a/drivers/net/ethernet/tehuti/tn40_mdio.c
> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
> @@ -157,7 +157,6 @@ void tn40_swnodes_cleanup(struct tn40_priv *priv)
>  {
>  	/* cleanup of swnodes is only needed for AQR105-based cards */
>  	if (priv->pdev->device == PCI_DEVICE_ID_TEHUTI_TN9510) {
> -		fwnode_handle_put(dev_fwnode(&priv->mdio->dev));

[Severity: High]
Is this put really stray? It seems to balance the reference that the MDIO
core takes on the bus fwnode when the bus is registered:

drivers/net/phy/mdio_bus_provider.c:__mdiobus_register() {
    ...
	if (bus->state == MDIOBUS_ALLOCATED)
		fwnode_handle_get(dev_fwnode(&bus->dev));
    ...
}

The bus has no primary fwnode, so dev_fwnode(&bus->dev) is the tn40 MDIO
swnode here. The core expects to drop that reference in mdiobus_release():

drivers/net/phy/mdio_bus_provider.c:mdiobus_release() {
    ...
	if (bus->state == MDIOBUS_RELEASED)
		fwnode_handle_put(dev_fwnode(d));
    ...
}

However, tn40_remove() and the err_cleanup_swnodes path in tn40_probe()
call tn40_swnodes_cleanup() before devres runs devm_mdiobus_unregister()
and devm_mdiobus_free(). In tn40_swnodes_cleanup(),
device_remove_software_node() calls set_secondary_fwnode(dev, NULL). The
swnode is not primary, so this sets bus->dev.fwnode to NULL. By the time
mdiobus_release() runs, its put is fwnode_handle_put(NULL), which does
nothing.

Here is the refcount of the MDIO swnode kobject after a successful probe:

  software_node_register()               1
  child PHY swnode kobject parent ref    2
  device_add_software_node()             3
  __mdiobus_register() get               4
  device_add()->software_node_notify()   5

Without the removed put, tn40_swnodes_cleanup() drops three of these
(notify_remove, swnode_put, and software_node_unregister). The PHY child
release drops the parent ref. That leaves the MDIO swnode at 1 forever.

With the put in place, the count reached exactly zero. kobject_cleanup()
only drops the parent after the child's release has finished. Given that,
where does the use-after-free in the commit message come from?

  "the parent MDIO node has been freed before the child PHY node"

After this change, does every TN9510 unbind, module unload, or probe
failure after __mdiobus_register() leak the MDIO swnode?

That leak would have these effects:

The tn40_mdio-<id> node stays registered under /sys/kernel/software_nodes.
The next probe's software_node_register_node_group() then fails with
-EEXIST, either through software_node_to_swnode() or through a duplicate
kobject name. The card cannot be bound again until reboot.

The leaked swnode's ->node points into tn40_priv->nodes.swnodes[], which
devres frees. software_node_find_by_name() dereferences
swnode->node->parent and swnode->node->name for every registered node, so
it would read freed memory.

device_add() set swnode->fwnode.dev to &bus->dev. device_del() never
clears it, because dev->fwnode is already NULL by then. The leaked node
would keep a dangling pointer to the freed mii_bus.

The same core get/put pair already exists at 25b6a6d29d40 (in
mdio_bus.c), so the 6.15 stable backport would bring the same leak.

Could the fix account for the core's reference instead of dropping the
put? For example, bus->dev.fwnode could stay set until mdiobus_release()
has run.

>  		device_remove_software_node(&priv->mdio->dev);
>  		software_node_unregister_node_group(priv->nodes.group);
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110100051.2567443-1-johan%40kernel.org
