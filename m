Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4835C6B9;
	Thu, 27 Aug 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814692; cv=none; b=NZ964/B710+Xyr5CT+FKQG4ZfMX42pu/rOWuIYLVKfgYe+lqDACankKXjbFsodLBS+a+v6v7oaPyRK6QF+5yM+xichwGxAr98EwF2ZGVuq4iwhP0HSG06zTAawgxBylAMyjWBE0wkaqdse7EbRz+x9pU9S85Dns9NgmWwcH3qqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814692; c=relaxed/simple;
	bh=9psfMD2rBk9v5ZTKw0YTKJVLADHqnogUqFIO1Uu+XPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iqs1u+a7ic4My+wmfJlLNz2rqQd7iGMtIPa/ys4VLHVP4h6T60mBScSllb3Hrlck4h9jhBsxVbZ2MEC3ZJdz72EXqUq1tYIlgWi0q+xeLI4h5YpF8EEqswrZvT8HoMPqKVYV0SXKAkQFpare8L6v5uaee13KHaDXc8/daBtor6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoJ7PZhJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoJ7PZhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55020C2BCF5;
	Thu, 27 Aug 2026 07:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787814692;
	bh=9psfMD2rBk9v5ZTKw0YTKJVLADHqnogUqFIO1Uu+XPI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MoJ7PZhJeBM40solemJKt1oEugmCIcQXQLpcbdkyE1AV/TtBln16i9BGkRJm5I2sO
	 SYqUswqT+72BbamOz8BGRE8M6mE7NDF3j22QmZ+ew9kMArUsRTwnu23GNZPk7GIGes
	 dXMKQ320u/+wZsXRsV8RXyf84pENe/4vR73ZBxJ6Hb8ze9w7oLuej7CahQcF5+3WLT
	 9lVDVGukg2DIGtVDt77XTijf5hhbxjdmC7NfvgLfC1TZfwGXMqOSRZdkCQhQOXDnVb
	 FY2R4fkoG4GvlYzXUwE4wOEgxeqXxoDHECMl6CoEmdqMGz2E7+oyafUA435qzsVdQu
	 t8BSwhy7tSfOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99CC61DB9;
	Thu, 27 Aug 2026 07:11:32 +0000 (UTC)
From: Johnathan Browall via B4 Relay <devnull+johnathan.browall.topgolf.com@kernel.org>
Date: Thu, 27 Aug 2026 09:11:25 +0200
Subject: [PATCH net] bnxt_en: avoid redundant RX mask updates in UC
 overflow state
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260827-bnxt-uc-overflow-v1-1-f20d48864fe9@topgolf.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XctQM1Yij+irhw4qSdUhJJ0geU/
 rtRl+deztmRJalk3JodSRbNGkOF86mBG56hF9JXZZjW2LYzljhshWZHcZHkp7iSv/C1q4+xzKj
 aO4nX7Ze8I0jB4z/mmUdx5RvDcXwAl7BU2HkAAAA=
X-Change-ID: 20260826-bnxt-uc-overflow-f3b5882626bb
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Pontus_H=C3=A5llstedt?= <pontus.hallstedt@topgolf.com>, 
 Johnathan Browall <johnathan.browall@topgolf.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787814691; l=5499;
 i=johnathan.browall@topgolf.com; s=20260826; h=from:subject:message-id;
 bh=4U2myiO1oDFh7prFk52MM8vNlU4NypZBLmBkndBL97o=;
 b=0KlDHFG7dkd488T0jnp+ZyUQ2EuxyAZh34SuX9VDDNs+oAZAjWPvl4WKWB7k5rD9mj0sbtNdp
 ahyVEujONtsBRlkZBP9x50fbZFmTQSSafnBfORH33KLacWMmLTM5tmZ
X-Developer-Key: i=johnathan.browall@topgolf.com; a=ed25519;
 pk=w6Hvfd81SFSs3dF3Kpe2Y17SpDtiKU3eXu0RdWOCnZk=
X-Endpoint-Received: by B4 Relay for johnathan.browall@topgolf.com/20260826
 with auth_id=976
X-Original-From: Johnathan Browall <johnathan.browall@topgolf.com>
Reply-To: johnathan.browall@topgolf.com

From: Johnathan Browall <johnathan.browall@topgolf.com>

bnxt_cfg_rx_mode() stops programming individual L2 filters and turns
on the promiscuous bit in the VNIC rx mask when the interface has more
unicast addresses than the hardware has filter slots
(BNXT_MAX_UC_ADDRS).  The driver state never becomes consistent after
that: vnic->uc_filter_count stays at 1, so bnxt_uc_list_updated()
keeps reporting the UC list as changed on every rx-mode callback, and
bnxt_set_rx_mode() removes the promiscuous bit from the mask it
computes (it only re-adds it for IFF_PROMISC), so the mask comparison
also fails every time.

As a consequence, every rx-mode callback resends the same
HWRM_CFA_L2_SET_RX_MASK to the firmware, including for requests that
change nothing, such as setting a link flag to the value it already
has, or a macvlan going up or down.  That would only cost an
unnecessary firmware call if SET_RX_MASK processing did not affect
traffic, but on BCM57416 and BCM57504 (firmware 23.3 and 23.6) it
does: each invocation causes a short interval in which incoming
unicast traffic is dropped.  We observed this in production as
sequence gaps in GigE Vision camera streams on a PF carrying 19
secondary unicast addresses, with HWRM tracing showing a SET_RX_MASK
(and no filter alloc/free) for every repeated "ip link set ... arp on"
that changed nothing.

Fix it by recording the overflow state in a new vnic flag.  While the
flag is set, the UC list is only treated as updated once it has shrunk
enough to fit the available filters (the content of the list does not
matter while all unicast is accepted through promiscuous mode), and
bnxt_set_rx_mode() keeps the promiscuous bit in the mask, subject to
the same bnxt_promisc_ok() check that bnxt_cfg_rx_mode() applies.
bnxt_cfg_rx_mode() sets the flag when the list does not fit and clears
it, together with the promiscuous bit, when the list fits again.

An unchanged rx mode no longer causes any firmware call, and neither do
UC list changes that stay above the limit.  Crossing the limit and
real changes to the flags or the MC list are programmed as before.

Tested with the equivalent patch on 6.12.y on BCM57416: the repeated
SET_RX_MASK invocations no longer occur and the receive disruption is
no longer reproducible.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Cc: stable@vger.kernel.org
Co-developed-by: Pontus Hållstedt <pontus.hallstedt@topgolf.com>
Signed-off-by: Pontus Hållstedt <pontus.hallstedt@topgolf.com>
Signed-off-by: Johnathan Browall <johnathan.browall@topgolf.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9c2cc5027..4805ee63e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13791,6 +13791,16 @@ static bool bnxt_uc_list_updated(struct bnxt *bp,
 	struct netdev_hw_addr *ha;
 	int off = 0;
 
+	/* In the overflow state all unicast is accepted through the
+	 * promiscuous RX mask and no secondary L2 filters are in use,
+	 * so the list only needs reprogramming once it fits the
+	 * available filters again.  Reporting an update here would
+	 * resend an identical SET_RX_MASK on every callback, which
+	 * causes brief RX packet loss on some chips.
+	 */
+	if (vnic->flags & BNXT_VNIC_UC_PROMISC_FLAG)
+		return netdev_hw_addr_list_count(uc) <= (BNXT_MAX_UC_ADDRS - 1);
+
 	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
 		return true;
 
@@ -13826,6 +13836,13 @@ static int bnxt_set_rx_mode(struct net_device *dev,
 	if (dev->flags & IFF_PROMISC)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 
+	/* Keep the promiscuous bit while the UC list is longer than the
+	 * available L2 filters, so that an unchanged rx mode is not
+	 * treated as a mask change.
+	 */
+	if ((vnic->flags & BNXT_VNIC_UC_PROMISC_FLAG) && bnxt_promisc_ok(bp))
+		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+
 	uc_update = bnxt_uc_list_updated(bp, uc);
 
 	if (dev->flags & IFF_BROADCAST)
@@ -13869,7 +13886,11 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
 	netif_addr_lock_bh(dev);
 	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+		vnic->flags |= BNXT_VNIC_UC_PROMISC_FLAG;
 	} else {
+		vnic->flags &= ~BNXT_VNIC_UC_PROMISC_FLAG;
+		if (!(dev->flags & IFF_PROMISC))
+			vnic->rx_mask &= ~CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 		netdev_hw_addr_list_for_each(ha, uc) {
 			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
 			off += ETH_ALEN;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ab894f8ad..53ad39f44 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1332,6 +1332,7 @@ struct bnxt_vnic_info {
 #define BNXT_VNIC_RFS_NEW_RSS_FLAG	0x10
 #define BNXT_VNIC_NTUPLE_FLAG		0x20
 #define BNXT_VNIC_RSSCTX_FLAG		0x40
+#define BNXT_VNIC_UC_PROMISC_FLAG	0x80
 	struct ethtool_rxfh_context *rss_ctx;
 	u32		vnic_id;
 	u16		default_rx_ring;

---
base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
change-id: 20260826-bnxt-uc-overflow-f3b5882626bb

Best regards,
--  
Johnathan Browall <johnathan.browall@topgolf.com>


