Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381808;
	b=AUr71el0CyqcXgksptJW0nJwwr7jYKg1wr5jaKBYpFiRB2LPueTuq/gYkNVL5JZTtFCk
	 bU7luvPdCqNiPGcMV+SXTxu3gJIJK+aAZVTrrw+synM1JvdftC7jaP4QZh+49hmX9Z1hw
	 jz2p8pkXQ7Ti0x0JCvykaju73aQi9WfYxS27HKpMgav+8FtwxYVHJvwr1brow4hxBBASh
	 ARL3/lOI2KI4jH7RBFv+c8yCcEe9LL5wbsiF6xsOiKn/dyjh3ZYV9ptJUf6JeYjFmwQOn
	 EMrzljlccHVyAHywBxebX8anSUOCL6Cx9r+J6gyjm0uIP3OzWiLptrlBjB9wJYdJCCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381808;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2dgUqUBanU/4JTuiSHsZiW6n7JGHT/pJg52L1d7/euY=;
	b=uaR4moUsfpi1Z1PE0Bd02w/O5csinsiEWm/tGtgbKd3Be1KmxGxTzdOfdTRPmuQ69Ohd
	 ECTYNUeXIP0rlj21+drwxKFsCT44J5ddcdsrlAXu7GAJ93kg6O+bGog54+/0hP2cZAm0m
	 2LpNEoDuGq+UTxgWiGCl/PN4FLBgHlxii2mA+M/DOqTWbDaiZYa9PhenPpUeUtkxB0uQT
	 eEedg3x0hsKWMmaB6IGS2x0fqBX0eFLeX9XdJ5d2u8R+JmkWgl+ibBcus29KzVgi7Xr2q
	 RFpJtUWTVcAscEUvaFSQnj1hyzIJp+ih7EWCNxDXD+P8Uu7541LsWAmaACedbAkjbbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=AP8eW28W;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BE606A321;
	Wed, 11 Nov 2026 07:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B15BE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=AP8eW28W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2d
	gUqUBanU/4JTuiSHsZiW6n7JGHT/pJg52L1d7/euY=; b=AP8eW28Wdo5OtBawzM
	qJUxk54CldTBDPvSOwd7QZUkO4T0jPGiqrX5REPmVzCznzP6rjYwvg6JRsNWBlPf
	/YaPA+gZ8XlCyx6mPiLqHdYHd0Fm/6p/CZWZiIEy++0l7vCH5rOfSFSMK0HLgely
	7Vq63mEdSbVtu5CCwg0ZFFQv8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3HzSNF_RqPOadDA--.16164S2;
	Wed, 11 Nov 2026 15:21:51 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	nb@tipi-net.de,
	2022090917019@std.uestc.edu.cn,
	devnexen@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@126.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: ethtool: phy: fix NULL link_topo dereference in phy_prepare_data()
Date: Wed, 11 Nov 2026 15:21:46 +0800
Message-Id: <20261111072146.3293821-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HzSNF_RqPOadDA--.16164S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF45urWUGF1UJF47CF1rWFg_yoW8uFW7p3
	yrKFyFkr9a9wnavw1UXw15CryUZFn7WrW5KFyFkanxZwn8Ww4kGa13Kr4aqF13A395Ca4Y
	qrsxZFyDXFnrZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisa97UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlA-Al2r0F4-MfwAA35

phy_prepare_data() picks up the link topology of the target netdev and
dereferences it without any NULL check:

	struct phy_link_topology *topo = reply_data->dev->link_topo;
	...
	pdn = xa_load(&topo->phys, phydev->phyindex);

The phydev it looks up comes from ethnl_req_get_phydev(), which returns
dev->phydev as-is when the request carries no phy-index, without ever
consulting the topology. A driver that assigns netdev->phydev directly
instead of going through phy_attach_direct() therefore ends up with a
non-NULL phydev and a NULL link_topo, and ETHTOOL_MSG_PHY_GET on such a
device dereferences NULL. The fixed-link path of the IBM EMAC driver does
exactly that.

This is a regression from the conversion of PHY_GET to the generic phy
dump infrastructure: the code it replaced bailed out of
ethnl_phy_parse_request() with "if (!topo) return 0;" before touching
the xarray, and that guard was dropped by the rewrite.

Restore the check and answer -EOPNOTSUPP, which is what
phy_prepare_data() already returns when the phydev cannot be found in
the topology.

Reaching the crash needs an IBM EMAC device with a fixed-link node, which
was not available here, so the fix is verified by compilation and code
inspection only.

This was found during an audit of net/ethtool/ performed with the help
of an AI coding assistant (Codex), which also proposed the analysis and
the fix. I verified the Fixes commit and both the doit and the dump call
paths.

Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@126.com>
---
 net/ethtool/phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 018b0412be86..60a617d9a332 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -83,6 +83,9 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	if (IS_ERR_OR_NULL(phydev))
 		return -EOPNOTSUPP;
 
+	if (!topo)
+		return -EOPNOTSUPP;
+
 	pdn = xa_load(&topo->phys, phydev->phyindex);
 	if (!pdn)
 		return -EOPNOTSUPP;
-- 
2.25.1

