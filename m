Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A233233948
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504238; cv=none; b=XokGftcINpV8HrvE2FyP1O48kDnsGXwBGpzYson1q5tE7HmemcpiomtjIADbFHEjrKOBemWZdeZoyUjBw9gruLIfdNv3spqYfbEskn+4j8xb6wBIuyVQlMzxMFLgRvwbVoseB818lOb6Ji3cFckkyKPtTwbTDL3eBBsQ2KrBrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504238; c=relaxed/simple;
	bh=fTKKpGduZnLhb3LZiLH1R6HY0uk1sO7aj/VAOhrTWWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKK/z3uEhXjZevxmPO1lFFGSMjD4Y+A3uflq7cCxhR+0e8m9AmXDYnE8GcTc8mvnNFro4+PVaeecAr74JGgIEHo1aWjaMEb2nguL18JBAt2+fJxYu4lFtvqNLSUxlcutQKzlY5/q160ZpaBPmwsPpakX/F5jCQ1w5Y4/4/LF0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=a7/uLaAd; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="a7/uLaAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504190;
	bh=/bcrOR9j8N4/tQ6USyl/3WauH0y00KM301TgDlkKIDk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=a7/uLaAd31HcyOTRNLia4ejnzqqjtftBL5vR1cb1zxrwlh+XHBVU7LK76oKuri2I1
	 SjHvAb2W3jE7W2DDXLV1I0NUgwMu1N3k2axnEQNZxto/R5JSupyRmXXP/ZPdh4iFsa
	 7zVzYWwohZJpxzi1Cv9ZgjO3lx9bxJjbqrg12Cqw=
X-QQ-mid: zesmtpgz3t1783504171tf238f551
X-QQ-Originating-IP: TPBpY3JrKzBromWo3b1tyyjF94QgSJDr3Gh3cAiaGgI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:49:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5263401670316410863
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 07/11] bonding: use common function to compute the features
Date: Wed,  8 Jul 2026 17:47:15 +0800
Message-Id: <20260708094710.27047-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OO98jC/ZOxmeoOSx6bij4ArrEmEpAGw7mD3sPONaJXYzHrvIh+LBCe7H
	nPV3c2c0GUwkdgY1ivbYLjyRtJqAEMtVXsmAHsm+sAx+YjiNnwhdHwMSIY0Xoo+kl2nLN3S
	nFuk66xdUF1zz2OksczmI4GyvClRdfi2KltU9C6Kb+5eFa7Ls5+OlTUWnOWnqBiBmVouz9C
	meMrBb53nRhKnMDtqVShca2ogEYKIsqf+SnjmWzsf0siv/+CkueOwxpZMK2vZhvDaY+oP+E
	dEVMRvd4KeSYSkweRzgOl+n29G/QO98TWiGTkxTILBG4fWSRlCL/hBb+xuxGWHxvo3dEESa
	3rBQ+sNUdD6k1FsWIRypku0FY8hKvZEolDoyLWAuBEZ65cArNcdtLoM0t+WMhSlaJ9zRtwl
	6Rfz74BEuS2I3fp13zNChRrhpQjYbO45uayNA1clguFMlASjqyXSEa2WOxl9RQwVcY2QfkP
	W9LbHs2qSRqc0s3d1D4cKDZGSpHDmnXJHst+agjY8zYsC0xsvvplm9wljY16eZJe46t8b4N
	ayHLIMdz82h3wwCCEqCOiqhki/Vsi1+d7zPk+HRvUKZkUSKJy3Ht4C7Wc9u8fngCq4jO8ec
	HcGCbzkivgYne9sR6IBNWU3409Jl2pDsvLi15rTsyXJqpF237o4dyrSIvYF2oBHiv1iwbRh
	/IRSmyOOjnBl5LbDGj8vgLEsTMDmGl/4lUnknf7tgqoyiCh3MPX2dbBbAynN4b+MPXrogIU
	3v7q2LUfDbMbKucd9AdEvG784K0ofyeAEUCexlkxw+t6HSbJXLhAK0AQyRPFXcozN/CjGwh
	GUlQ0B8z/MNE0q0IrhTQy3cmqjJ3lUjUM+s4WztXjzHoGL2CzUfdEBchD2qb9VJyb41AN6d
	nq1FPCwPxWDTzmXRLktwuEpHBQFYI3KDjjyvjxg69ld5ScaoAqYZv8oeNMGFiiRPxIdDPEQ
	At8QhSqtBWFnfqBwomcsgrQgumRUX43lA4UBwDFsOMS1rCOqiXf+p6j66bsLvCiSmiNMxgf
	uwfrNXozp9lqKtBXHboAFliHOW3fmJ0bMToJdL3pVgQR6tu6CRv7TQunHwb+5LIe/uqF4gh
	P1vRvrjAku6bjOwZQ837jA2ltaS264aqLZeAOeZRL7k4d3EVEwgPjpBjcA6f0z9mZ3yp/sm
	aCVc
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit d4fde269a970666a30dd3abd0413273a06dd972d ]

Use the new functon netdev_compute_master_upper_features() to compute the bonding
features.

Note that bond_compute_features() currently uses bond_for_each_slave()
to traverse the lower devices list, and that is just a macro wrapper of
netdev_for_each_lower_private(). We use similar helper
netdev_for_each_lower_dev() in netdev_compute_master_upper_features() to
iterate the slave device, as there is not need to get the private data.

No functional change intended.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://patch.msgid.link/20251017034155.61990-3-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Conflicts:
	drivers/net/bonding/bond_main.c
(cherry picked from commit c8d250e0a8d61af8799ea5494a88ab7714955bf0)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 9ba63cf77cf08..4f2c03f52a310 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1468,97 +1468,6 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
-#define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_ENCAP_ALL | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
-
-#define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_PARTIAL)
-
-#define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_GSO_SOFTWARE)
-
-#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
-
-
-static void bond_compute_features(struct bonding *bond)
-{
-	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
-	netdev_features_t enc_features  = BOND_ENC_FEATURES;
-#ifdef CONFIG_XFRM_OFFLOAD
-	netdev_features_t xfrm_features  = BOND_XFRM_FEATURES;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	netdev_features_t mpls_features  = BOND_MPLS_FEATURES;
-	struct net_device *bond_dev = bond->dev;
-	struct list_head *iter;
-	struct slave *slave;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	if (!bond_has_slaves(bond))
-		goto done;
-
-	vlan_features = netdev_base_features(vlan_features);
-	mpls_features = netdev_base_features(mpls_features);
-
-	bond_for_each_slave(bond, slave, iter) {
-		vlan_features = netdev_increment_features(vlan_features,
-			slave->dev->vlan_features, BOND_VLAN_FEATURES);
-
-		enc_features = netdev_increment_features(enc_features,
-							 slave->dev->hw_enc_features,
-							 BOND_ENC_FEATURES);
-
-#ifdef CONFIG_XFRM_OFFLOAD
-		xfrm_features = netdev_increment_features(xfrm_features,
-							  slave->dev->hw_enc_features,
-							  BOND_XFRM_FEATURES);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
-		gso_partial_features = netdev_increment_features(gso_partial_features,
-								 slave->dev->gso_partial_features,
-								 BOND_GSO_PARTIAL_FEATURES);
-
-		mpls_features = netdev_increment_features(mpls_features,
-							  slave->dev->mpls_features,
-							  BOND_MPLS_FEATURES);
-
-		dst_release_flag &= slave->dev->priv_flags;
-		if (slave->dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = slave->dev->hard_header_len;
-
-		tso_max_size = min(tso_max_size, slave->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, slave->dev->tso_max_segs);
-	}
-	bond_dev->hard_header_len = max_hard_header_len;
-
-done:
-	bond_dev->gso_partial_features = gso_partial_features;
-	bond_dev->vlan_features = vlan_features;
-	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-				    NETIF_F_HW_VLAN_CTAG_TX |
-				    NETIF_F_HW_VLAN_STAG_TX;
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_dev->hw_enc_features |= xfrm_features;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	bond_dev->mpls_features = mpls_features;
-	netif_set_tso_max_segs(bond_dev, tso_max_segs);
-	netif_set_tso_max_size(bond_dev, tso_max_size);
-
-	bond_dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if ((bond_dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
-	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		bond_dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
-	netdev_change_features(bond_dev);
-}
-
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -2311,7 +2220,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	bond_compute_features(bond);
+	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2563,7 +2472,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_master_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4065,7 +3974,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_master_upper_features(bond->dev, true);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -6081,7 +5990,7 @@ void bond_setup(struct net_device *bond_dev)
 	/* Don't allow bond devices to change network namespaces. */
 	bond_dev->features |= NETIF_F_NETNS_LOCAL;
 
-	bond_dev->hw_features = BOND_VLAN_FEATURES |
+	bond_dev->hw_features = MASTER_UPPER_DEV_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_RX |
-- 
2.30.2

