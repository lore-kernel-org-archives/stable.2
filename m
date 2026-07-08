Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD02F693B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504186; cv=none; b=jfhnUhBV0QUIK8LHzKGToxbSntjycOWdT4kDB2jCwxP5FzeqrGisNuytk6UaWtbq5TvI8mYEL0aJ/EBvUsC7STpYjP/5i19fbgnk5ojQ5Tp9X9dYY07RgtjMFjSYT7g5rI2X1e75qi0e1Q88Ju0Md8AMPBmJNfYO55gkCgluzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504186; c=relaxed/simple;
	bh=6ardkB2xZtZgrf6hxvpHJ6U54MUperY47+IWWbD592k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjcHP2QvnNYCaVCHXQGuJ6rTlBVBUVLSayt5K5aoY6yBK5y6uMzyWjR9hryC05tW7y1aM5xwkBiWF9hKizJI5MOOqpYidLmuRKrCQzuVpJTf+ceOSXsvZkDJn+d7PZhWpECfLqG5Q6ngrBDhufJNEZFWv4/oHUAzrsZJEmbWer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=T8urphUQ; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="T8urphUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504131;
	bh=6Y/V4rDpx2JwVZpUvlczIS4MCiT5olwMcMBqB6+EmZs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=T8urphUQk2j5sLyK+4ei99zP3B1p6XhjvvEmlYX2tPzqH+/yLMSR5WiDX7TRtAIn1
	 K0cgyxYUbKntefLjSTr0wjC0pmxMbqw9C7BkbNpMYVj8ImjY+M/PYZsfebXlgALWA3
	 9jENWt51QLGMgJE9r6+1gPm5a8WAJBwbt5cYqa1w=
X-QQ-mid: zesmtpgz3t1783504124tf32bfb24
X-QQ-Originating-IP: HxM5PcJSfsaR2lQrnh7C9rtQMs36S949mGEVUyTJguY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:48:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8011343679142257779
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 05/11] bonding: Correctly support GSO ESP offload
Date: Wed,  8 Jul 2026 17:47:10 +0800
Message-Id: <20260708094710.27047-6-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NHGFjaVOIMm2xvh4gMutXNY8qML2oQTjpTxahGumC4RMeyNKo7l38C7G
	AzZdE566Tdfrq++TvAiW08CqOXqp4taqmvAkR2h4uFRE7HZqvN7Pl5ibGhCM8vyHU6Rjhq4
	lasEDh4zhDWHHei218D7vFnNYn5JQHz1TejiN1nK1ZDmbj848Fv34OdLCN9ClKwvcF/RLXz
	WNG+Xx3mgZdbd5HEE3Zfq0RgpTTjITmTDy67gpVlH6DC9iRcNQUIve6OPf6ZPPZaebNaaym
	tZythIrlELb6t3SEnnQZN2twiVf9g3qm9XnxeXd/scznfrElPEFZmxIZkJRVtHZOapws9Ci
	ZRsj6EaWiRgr2nLssEpoPS4uzUqOuZuaiQyDnuTDXw515i+7IUVqvOPxsNvwrYhTlMw0qfZ
	3cqqWdeKhK610oYTfpbMcDr2EldPMX07fOGCIK6OmLw31aYgVOgBh8XTIB5F/1F+A63Cw67
	cEg5Rl3WK2+I73ZjJnRPbnhY3Sh6cPL1x0fZKH6dmY+eOUYY7QZBskkZtTwQC/xG4bvwJ2Q
	O9OLCjDpWFxBBS/abNbCmeNnd4DOFsqSRQNhTw3fkHURDvxHBSp8z2nD6OryZcosKcYw26c
	UXqu/ndeWRKfv/HsZVqcFhXp3OKglLvjTcN06EC2NxlC1M0kCR/iVtUTM4uXU9amgW5VNDr
	QDlJBg5GMYRR5U/T1l8LgWLPc41YYnSM1/WKJBAUiFEzQhiLsSexehjuvH/n4bBlCdACYon
	UxtWRWKjrzsn+lt+Q+qmFc4ZcWO8d05gxovF5pRv3gEDVth0B/RUFsOm9iRcECxotjsWAyv
	04h6vu/CBhGPEgdJfgyKtFhvrXprjqWVWtM8WEWOz/1LwwIsUdaAJlrVDRPtKzsgfOXTkyc
	BeXSA9vuTY3WlC5vYKFOX/+cb/vY2bR5dSWj/8fbKZYAi/yTIb52MigUuwuJhS4GxvPlyzM
	3lRuVPnqp6haDZN52jwUJ55SmbEkryFHUrtKWxHWIZKqhMUIeGKYaAcPLeoz6MwrW4q9h3O
	xFyyLewNOBttWcHxRuIMkfnroxmD+cvelGdulyNIgldlcqjgdqP7riRP00fcSmf5QUb6anD
	b2RsEBQixx+ggJ8vr4AOhM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a ]

The referenced fix is incomplete. It correctly computes
bond_dev->gso_partial_features across slaves, but unfortunately
netdev_fix_features discards gso_partial_features from the feature set
if NETIF_F_GSO_PARTIAL isn't set in bond_dev->features.

This is visible with ethtool -k bond0 | grep esp:
tx-esp-segmentation: off [requested on]
esp-hw-offload: on
esp-tx-csum-hw-offload: on

This patch reworks the bonding GSO offload support by:
- making aggregating gso_partial_features across slaves similar to the
  other feature sets (this part is a no-op).
- advertising the default partial gso features on empty bond devs, same
  as with other feature sets (also a no-op).
- adding NETIF_F_GSO_PARTIAL to hw_enc_features filtered across slaves.
- adding NETIF_F_GSO_PARTIAL to features in bond_setup()

With all of these, 'ethtool -k bond0 | grep esp' now reports:
tx-esp-segmentation: on
esp-hw-offload: on
esp-tx-csum-hw-offload: on

Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Link: https://patch.msgid.link/20250127104147.759658-1-cratiu@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 00ed3c3ade696ebff6d6ce191f04d2c82eaf2297)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/bonding/bond_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ec21958babe7d..9ba63cf77cf08 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1474,17 +1474,20 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
+				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_PARTIAL)
 
 #define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_GSO_SOFTWARE)
 
+#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 
 static void bond_compute_features(struct bonding *bond)
 {
+	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;
-	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
 	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
 	netdev_features_t enc_features  = BOND_ENC_FEATURES;
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1518,8 +1521,9 @@ static void bond_compute_features(struct bonding *bond)
 							  BOND_XFRM_FEATURES);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
-			gso_partial_features &= slave->dev->gso_partial_features;
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 slave->dev->gso_partial_features,
+								 BOND_GSO_PARTIAL_FEATURES);
 
 		mpls_features = netdev_increment_features(mpls_features,
 							  slave->dev->mpls_features,
@@ -1534,12 +1538,8 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
-	if (gso_partial_features & NETIF_F_GSO_ESP)
-		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
-	else
-		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
-
 done:
+	bond_dev->gso_partial_features = gso_partial_features;
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
 				    NETIF_F_HW_VLAN_CTAG_TX |
@@ -6090,6 +6090,7 @@ void bond_setup(struct net_device *bond_dev)
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
 	bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
+	bond_dev->features |= NETIF_F_GSO_PARTIAL;
 #ifdef CONFIG_XFRM_OFFLOAD
 	bond_dev->hw_features |= BOND_XFRM_FEATURES;
 	/* Only enable XFRM features if this is an active-backup config */
-- 
2.30.2

