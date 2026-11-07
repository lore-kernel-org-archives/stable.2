Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052062;
	b=tJNtb3ntv9x/6z3yrIX5/ozkqYVeZlrKHtNxPuPFEKDYG0/pUbs8CD2OyU1w137s7cS8
	 JSr7st0uF2ZhvpamDxyFn0GfpgwVDIsSrtfkWku6bcwG0sfRHK9VOpRAQcSqLbi60VQDz
	 9WMVj4JchIFOngvu/NSIZI/72SG1/1gTGmESOnh5l0UTuJ8mEHsnAFCIcdWrcON+X6/2u
	 MS7zOuIATQ5r0GToWehR7ov6jqreLXtdcf2Bofs8JJftZ7oeUeh2Vts+1nXpu82cKAOAb
	 CKoIa1BaRDr5eefLqIBfD4kMKJEdm6spOndXBTkAoRu1DCzq1LVny2AEPJUm62e103Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052062;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=shn+UzrofE7NNr5BdTHNkIDvUbHajl81IywsSu+zOis=;
	b=IE8HKP2zrF8zrcKWbawBSFIBkhVWosGFKq22RkM6iXiAKSASdxDw/8eGUKmghewgQCYu
	 ANf4fVsYesV2yPjXo5/RdbdKYwefjHUi0h4wZp5t1J05shFS0Sv5TfYIjc1TkN3kfzAls
	 hrKlSCIiF37zDe+P138rhEQ3kEMlZZPkl+foYf+Q/ML4JHK6eyPwhFpAZ1k+VUBBGAVzx
	 fRcCh5//d7XM2BmrniOFGOBDhFrcQ3rgIWNImuulhnsLt3L61daMRcl454JwpljBt+iHE
	 aemyriM/ykAfL5GW+JLOMOr6xDf0vinLPS2QNERNZSh3S2S2iXwovEv/N2FgSrrknXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDU10OKG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC6606A326;
	Sat,  7 Nov 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDU10OKG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3548D1F0089F;
	Sat,  7 Nov 2026 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794052061;
	bh=shn+UzrofE7NNr5BdTHNkIDvUbHajl81IywsSu+zOis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SDU10OKGQL0OEagf4BKtSQlgNhR/bO8alAts+IGtS2QQ/7x/WsJnPyM4NKfolqcRZ
	 7kjJggnA2+GYayF1emk94mAljCVLpo+RIu0x5tZ4gZ05HkjR27wGB6WlbKxQDISY4G
	 tYryRIeyybD1v2HeItXVQt/a9drVIsBLgGD8tZa427n+aG2d272ZUgw1GIFI0veqNO
	 y+qZGeqzqjbreWJEyQ7JV2d1Sjd/yqNK9KXbxMwRLMDr8KWLkRh4Hjln0B9Kf8+hGg
	 slqBy5+vsEzV8+tyKrNdyBZRIgGL9ku+uEuX0ukBGe+C3lasrcvRaGlE6zFmff66cD
	 W/mGV1t1Ga/oQ==
Subject: Re: [PATCH] net: dsa: microchip: drop the parent MDIO bus reference
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 07 Nov 2026 11:47:40 +0000
Message-ID: <179405206074.994134.651288231971882952@kernel.org>
In-Reply-To: <20261103100531.1309946-1-vulab@iscas.ac.cn>
References: <20261103100531.1309946-1-vulab@iscas.ac.cn>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes code that never runs, and the reference leak it
  describes is still live in mainline.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the cached
  dev->parent_mdio_bus pointer is only protected by a struct device…

--

net: dsa: microchip: drop the parent MDIO bus reference

This patch adds a devres action to ksz_mdio_register(). The action calls
put_device() on the parent MDIO bus returned by of_mdio_find_bus(). The
goal is to stop leaking that struct device reference on probe error
paths and when the switch is torn down.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 767c8fe8e819a..ddd821fa0d3e1 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c

[ ... ]

> @@ -2431,6 +2442,12 @@ int ksz_mdio_register(struct ksz_device *dev)
>  			goto put_mdio_node;
>  		}
>  
> +		ret = devm_add_action_or_reset(ds->dev,
> +					       ksz_mdio_put_parent_bus,
> +					       parent_bus);
> +		if (ret)
> +			goto put_mdio_node;
> +

[Severity: High]
Can any current chip reach this branch? It sits behind this check in
ksz_mdio_register():

	if (parent_bus_node && !dev->info->phy_side_mdio_supported) {
		...
		ret = -EINVAL;

		goto put_mdio_node;

In ksz_switch_chips[], only the LAN9370-LAN9374 entries set
phy_side_mdio_supported = true. All of them use lan937x_switch_ops, so
their setup path is lan937x_setup()->lan937x_mdio_register(), not
ksz_mdio_register().

ksz_mdio_register() is called only from ksz8_setup(), ksz8463_setup()
and ksz9477_setup(). None of those chips support side MDIO. For them, a
DT with mdio-parent-bus returns -EINVAL before of_mdio_find_bus() is
called, so the new put_device() action is never registered.

Commit 03d10c776802 ("net: dsa: microchip: implement lan937x-specific MDIO
registration") copied the side MDIO logic into lan937x_main.c, and that
copy still takes the reference without dropping it:

drivers/net/dsa/microchip/lan937x_main.c:lan937x_mdio_register() {
    ...
	} else if (parent_bus_node) {
		parent_bus = of_mdio_find_bus(parent_bus_node);
		if (!parent_bus) {
			ret = -EPROBE_DEFER;

			goto put_mdio_node;
		}

		dev->parent_mdio_bus = parent_bus;
	}
    ...
}

Does the parent bus struct device reference still leak there? That
would happen on the later error paths (devm_mdiobus_alloc(),
lan937x_mdio_bus_preinit(), lan937x_create_phy_addr_map(),
ksz_parse_dt_phy_config(), devm_of_mdiobus_register()), on deferred
re-probes, and on every unbind of a LAN937x switch.

ksz_mdio_put_parent_bus() is static to ksz_common.c, so as written
lan937x_mdio_register() cannot use it. Should the fix go into
lan937x_mdio_register() instead? The side MDIO branch in
ksz_mdio_register() looks unreachable and could perhaps be removed.

With Cc: stable and Fixes: 9afaf0eec2ab, this would be backported to
trees both with and without the lan937x split. Would it only have an
effect in the trees without the split?

>  		dev->parent_mdio_bus = parent_bus;
>  	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The
commit message says:

  "The child MDIO bus is unregistered before the action runs, so the
  parent bus stays valid for the whole lifetime of the switch."

Does this hold for anything beyond the mii_bus memory? The reference
from of_mdio_find_bus() keeps struct mii_bus allocated. However, there
is no device_link to the parent MDIO controller and no
try_module_get(bus->owner).

The parent controller driver can be unbound through sysfs, or its
module unloaded, while the switch stays bound. PHY accesses on the side
bus would still go through:

ksz_parent_mdio_read()->mdiobus_read_nested()->__mdiobus_read()->bus->read()

__mdiobus_read() in drivers/net/phy/mdio_bus.c does not check
bus->state:

	if (bus->read)
		retval = bus->read(bus, addr, regnum);

Could the parent driver's read or write callback then run against
released devm resources or unloaded module text? That depends on the
specific parent MDIO driver. The same applies to ksz_parent_mdio_write()
and to the pointer cached in lan937x_mdio_register().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100531.1309946-1-vulab%40iscas.ac.cn
