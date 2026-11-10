Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304894;
	b=b+TB2gx7yId3pzMxHb2ZpYuAGMjcj9ixhLWEFzgqhV81/JumB/UZiSXV+ztYbHADYQfB
	 oR7cCjG/DVPwdkV88ZyCrsZuLCxARrqwoVC10N2dT4yWGkpH4RCBUtB5XOXzSCxE/diuG
	 3S/t4p+/nOCPX3Tpoh5/LVRkMudnFxZ9N4JZxr1rvLWxzuAVDHsAsVFpdBfdCeg4hvJ2/
	 74iwX7N7zzaVm0hjToyO5tq6WfxvD2ykNiqCgIM8qeG/FVCSatrVxCovpD3/tUX8asDrX
	 QTf3DGjzFdLBZnhdm23twCZGomlH2GYlgaSKKQ6zM6BLaSYE/0O0jRvm8rIyZdqnv/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304894;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NV/n9QUrC7hJ5I6sA0qyjFunoR/tVEYb0g42BBmWAR4=;
	b=lxVy/6BP+uj5VdtUQP8ov3hPe1yAwjEhKJunIqNpF59BkeOpDv3n4TjljLQIEykWvPdu
	 WmtxwFN0ftgtEH4cQaYquTKpRJjex96hEsL+q6Zqj/RAQRR2uszFYrRCItf+DD2LLSJIK
	 eZwFch9f6zgZAf72VUPsvrFyAW5kf2OlK4X8NZya+TXCwJHpUEzk2aULD4NyR2Min8TDt
	 vwnEtKxH2lTCFQjtsy3VmpXmqNqrSX9OZe3mAz2BKN9YCe4rpJlXWAFI+Mb63kPS0UeTv
	 OakJG980PW/enyioGpDmoPlPS0g5TSsY5uyglqWw/mJoA59y1jLOadm7v6ztFwGPXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DM6ww2mY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0E60A5BC0;
	Tue, 10 Nov 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DM6ww2mY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300191F0089F;
	Tue, 10 Nov 2026 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794304894;
	bh=NV/n9QUrC7hJ5I6sA0qyjFunoR/tVEYb0g42BBmWAR4=;
	h=From:To:Cc:Subject:Date;
	b=DM6ww2mYH13DcKy7AmjihvAMAcNoMQbrudRC6YIjWZVAcRjMBJW9b62/oehirxDK1
	 aG1eszc+y3qx1lqI5vomerOBqGja+yJIclxrscxe+enN2cPG4zOREDTAdyLFzCubhL
	 8FwQoEkv+6mDQh5ARq9OjLi2u7wiUdkpIpZLUZa3gOE96rHyYDrP9VoWNKPIRexccR
	 ENFyUAI1ciozQM5BiYT0tyjU6FmGfeXdQgoGADCM87Y0m/a6CEXpePoy7VpR52tA7A
	 QQ8tAYQBuWZw46Buqyjmv5PWiXXQb23IXpjicvaq2Ly2ZNscoL/8aaWgQLgSm6QHaa
	 iGvTmPlM/LxtQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQifT-0000000AlvD-2vbf;
	Tue, 10 Nov 2026 11:01:31 +0100
From: Johan Hovold <johan@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: [PATCH net] net: tn40xx: fix swnode use-after-free on probe failure
Date: Tue, 10 Nov 2026 11:00:51 +0100
Message-ID: <20261110100051.2567443-1-johan@kernel.org>
X-Mailer: git-send-email 2.56.0
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

The mdiobus allocated by tn40_mdiobus_init() has no primary firmware
node so its firmware node pointer points to the secondary software node
added by device_add_software_node() and whose reference is released by
device_remove_software_node().

Drop the stray firmware node reference decrement on probe failure and
driver unbind which leads to a use-after-free when deregistering the
software node group as the parent MDIO node has been freed before the
child PHY node.

Fixes: 25b6a6d29d40 ("net: tn40xx: create swnode for mdio and aqr105 phy and add to mdiobus")
Cc: stable@vger.kernel.org	# 6.15
Cc: Hans-Frieder Vogt <hfdevel@gmx.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/tehuti/tn40_mdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index fb1a4a2e4dbc..49951477ac05 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -157,7 +157,6 @@ void tn40_swnodes_cleanup(struct tn40_priv *priv)
 {
 	/* cleanup of swnodes is only needed for AQR105-based cards */
 	if (priv->pdev->device == PCI_DEVICE_ID_TEHUTI_TN9510) {
-		fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
 		device_remove_software_node(&priv->mdio->dev);
 		software_node_unregister_node_group(priv->nodes.group);
 	}
-- 
2.56.0

