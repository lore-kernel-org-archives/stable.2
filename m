Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467290;
	b=hOWz3qu1Bh/drEjx3VZuyK3frRg+uTC0GjA3PvU4ppLxoWtmpcvzI3gJ128WWu3pvtCL
	 zidgr+X7UiEEqjTkIk0RGTeiEnNVCzqTrPHcoey3DIRr1BBrr6Tpvit6TbK5bWiIa6THS
	 6KtTD0Aq8E6uCDZZAy7mHcvq80/+EZ3sf4dB6DHQ0yomOskKX/cDFbRoeA7ASosaY8PtV
	 E21nxuU+Xh5v/tED5tBpv+lvV8nheaLFX4PLd/nEzivK+vxfy48XN7pqX7KN1G/E8Squp
	 3kyJ0zWRDLEJNmih8bXzdjsOMrA8MUSUsURJ8slKn9UXwKzN6xoFaOyU75+jUCnQ4HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467290;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=T1EVA641LW6g9iZivmErL6bCgrLZeRILPc29/4zkGT4=;
	b=OJbu/jhvIKC8G+tr1StpugeEQbO5c3MmpX//QjfVANxFeo025SbR62pUEuLITvTlIRuq
	 Z/i3B46qav8whzyILS/in6Vgt/2H97KCj+pO05j8exvxH31mfYeDOQxJQ82sxUx8aX4dJ
	 JOtD1xhURSWnTX6lTKwY1fWjgL/1j/JXVAcQAbzlGO/79/J3cLR4nGQS8S8mQYK+nLmBY
	 oIYAAdkCt+ULmhDHT30j/IEqPGUM0zpGwmmYu15kATXLxzPZGxdtMdFeTBt/UPc0loRUN
	 xEoe45/EcdMDWyEp2h85GdwLRHqG+NWnqS6KGGLR8aPNwXii3+L2jmpFlHmbzBzJlcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="S//XLNwV";
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D82606A321;
	Thu, 12 Nov 2026 07:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D82606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=S//XLNwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=T1EVA641LW6g9iZivmErL6bCgrLZeRILPc29/4zkGT4=;
	b=S//XLNwVKhOE7xO+/wor137Eqehl62HRrZStQYQm1vHrYC1i4PuLq2nsKwS2sR
	1InxIpGDfqkNQ91YXV9TFENyITpMYiXDknFw64JMxHAeK5mgKzmz5Z/OcghwMnh1
	a9HrFE5dU0jyW0psnzbHaajyYIrSrmOGuIHn8PQo5S7uk=
Message-ID: <82d01fb0-cf0a-473c-bef7-6ccb6d827ec9@126.com>
Date: Thu, 12 Nov 2026 15:06:29 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethtool: phy: fix NULL link_topo dereference in
 phy_prepare_data()
To: Andrew Lunn <andrew@lunn.ch>
Cc: maxime.chevallier@bootlin.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 nb@tipi-net.de, 2022090917019@std.uestc.edu.cn, devnexen@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111072146.3293821-1-xiaolinkui@126.com>
 <1fb006fc-aab9-456d-95c2-0e94df1dfb09@lunn.ch>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <1fb006fc-aab9-456d-95c2-0e94df1dfb09@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Hxd5ZfVqDhzRDA--.51826S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF15uryftF1fuFWktr18Zrb_yoW7Wr4rpa
	yYgF9YkryDGrWSqr4rZry0kFyY9rnayw4rKFy8K345u3s8Gr48ZFW8tryqvr4YkFZ5G3Wj
	qF4UJa9xWF4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcBMNUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRuPZmr1ZXvC7wAA33

Hi Andrew,

Thanks for the review.

You are right - the ethtool patch was treating the symptom. I have split
this into two separate [PATCH net] threads: the EMAC driver fix, and a
reworked ethtool change that warns instead of hiding the bug.

 > There is another way to look at this. The MAC driver might be broken,
 > it is assigning ndev->phydev, which it should not. It needs to call
 > one of the helpers that get to phy_attach_direct(), which sets
 > ndev->phydev.

Agreed, and EMAC is the broken one. emac_init_phy() handles a
"fixed-link" property by registering a fixed PHY for the MAC's own OF
node and then assigning the netdev pointer by hand:

		res = of_phy_register_fixed_link(np);
		ndev->phydev = of_phy_find_device(np);
		if (res || !ndev->phydev)
			return res ? res : -EINVAL;
		emac_adjust_link(dev->ndev);
		put_device(&ndev->phydev->mdio.dev);

Skipping phy_attach_direct() leaves phydev->attached_dev NULL, installs
no link change handler, keeps the PHY out of the netdev's
phy_link_topology, and the put_device() drops the reference the driver
just took. The user visible part is the missing topology entry:
ethnl_req_get_phydev() returns dev->phydev as-is for a request without a
phy-index, so phy_prepare_data() ends up doing xa_load() on a link_topo
that was never allocated.

The fix makes the fixed-link branch match what gianfar, fec, davinci_emac
and nixge already do: of_phy_register_fixed_link() followed by
of_phy_connect() on the MAC's own OF node (gemini uses
of_phy_get_and_connect() and stores the result, the same harmless shape
as the icssg users). The explicit put_device() goes away because
of_phy_connect() takes over the reference. The manual
emac_adjust_link() stays; the PHY state machine is still not started,
which is fine because a fixed link does not change and the driver
already treats dev->phy.address < 0 as "no PHY to poll". Full
rationale is in the commit message.

Cross compiled for powerpc with W=1 out of ppc44x_defconfig, no warnings.
No EMAC hardware here and no in-tree DTS pairs "ibm,emac" with
"fixed-link", so beyond the build it is inspection only. The hand
assignment goes back to 08e39982ef64, but it only started touching the
net_device with baab9de385a8, which is the Fixes: target.

Two adjacent issues I left out on purpose: emac_remove() never calls
phy_disconnect(), and the fixed-link branch never calls phy_read_status(),
so emac_adjust_link() copies SPEED_UNKNOWN/DUPLEX_UNKNOWN. Both predate
this patch and are worth separate fixes; happy to send them.

 > Are there other MAC drivers which assign ndev->phydev?

I went through every "->phydev =" in drivers/net/ and net/. EMAC is the
only driver that leaves net_device::phydev pointing at a PHY that was
never attached. The others are redundant but harmless:

   - icssg_prueth.c:425 and icssg_prueth_sr1.c:238 assign the result of
     of_phy_connect(), which already stored the same pointer via
     phy_attach_direct().
   - gemini.c:374 stores the result of of_phy_get_and_connect(), same
     shape.
   - net/dsa/user.c:2643 pre-fills user_dev->phydev from mdiobus_get_phy()
     before phylink_connect_phy() overwrites it with the same phy_device;
     mdiobus_get_phy() takes no reference, so nothing leaks.
   - Plain "phydev = NULL" right after a disconnect (gemini, rtsn, dpaa,
     icssg) clears what the disconnect already cleared.

Everything else called phydev in drivers/net/ is a private member of a
driver structure rather than net_device::phydev (tehuti, wangxun, r8169,
xgbe, qualcomm emac, tsnep, hns3, hibmcge, bgx, smsc95xx, oa_tc6,
dm9051, plus phylib internals and phylink's pl->phydev).  tsnep does
have a separate of_phy_find_device() reference leak, but that is
unrelated to net_device::phydev and not touched here.  So EMAC is the
only offender.

 > This NULL pointer dereference can be considered good, because it might
 > be pointing out a bug. So we might want to keep it.

Fair, and that is why v2 no longer returns -EOPNOTSUPP silently. It
warns once and then returns -EOPNOTSUPP:

	if (WARN_ON_ONCE(!topo))
		return -EOPNOTSUPP;

phy_prepare_data() already returns -EOPNOTSUPP when the phydev is not in
the topology, so callers do not learn a new error code. The driver bug
still lands in the log with a stack trace, but a plain ethtool query no
longer takes the machine down. The dump side returns early when
dev->link_topo is NULL, so this can only fire from the doit path, at most
once per boot.

This is also the only spot in net/ethtool/ that touches ->link_topo
without coping with a missing one - phy_link_topo_empty() is "return
!dev->link_topo", phy_link_topo_get_phy()/get_port() return NULL, and
common.c, port.c, tsinfo.c all test it first. Before 9dd2ad5e92b9,
ethnl_phy_parse_request() had "if (!topo) return 0;" ahead of the xarray;
that check did not make it into phy_prepare_data().

If you would rather keep the oops as the canary, say the word and I will
drop the ethtool patch - the EMAC one is the part that actually fixes
something.

Both v2 patches drop Cc: stable: the EMAC one is latent in mainline, and
the ethtool one only warns. Say the word if you disagree.

Thanks,
Linkui

