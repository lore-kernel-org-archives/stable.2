Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE01F130B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504221; cv=none; b=WlreYL+QCJ8CnFA5oHCvP6Nt6b7KgBCLORSg1OJzzQ+rqHDB8J7mdOUPuwPbppxI+N3N51kDakTrM/J8PiilX63VFMX9uKMoiz9nbgAa2irsKp6ah21wqnkR0ElcWVrEOF7uEp6sSsUQ76PiovwTfbOGifPsgQB6Z5Y6F0ZdN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504221; c=relaxed/simple;
	bh=IrCjmLZSwcykKQD29o9aRGewqUDwYED79vLKvSVfXC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxJbmSOBLs+zOfvioaYpc/HHl9P5B4sMothl/FrrlycCOW1hrmFIutgytoZGRTl/J+1QpvboU/heBiid2fn+XBzCYmEHT1MbBI8YpDkiDMm7j5L4q0NR/NXH+PcBU1E6ghbJFwsvQeY+PahZKY1GcRZzAcOM3uEmO6Zq0m0P0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=k7jYI1Bf; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="k7jYI1Bf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504143;
	bh=XdNYKDjZx36KUAvPXisUNBEZIMwi7oiORiekkHJ5DZ4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=k7jYI1BfVmZ9dXF8AOPnaO+ModdANhvAsgSALCjsMwG3eukMAvSLk2j08ReZB43kT
	 cdrvkLeYR5vTBsI/oVPJ8soI922iBWBVbUVOzcXZO1z3RJdM0mcGVzMW7qR4g6SfUC
	 B3m4DUACnMNR6s5lu5Wgwy5gqdIsYY28K6PwdxAg=
X-QQ-mid: zesmtpgz3t1783504137tdcd2bd27
X-QQ-Originating-IP: hOoFgyOAf1C00IHCaw8+jyEW2NRI8rPhlll/dSFltC4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:48:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2669361903815992737
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 06/11] net: add a common function to compute features for upper devices
Date: Wed,  8 Jul 2026 17:47:12 +0800
Message-Id: <20260708094710.27047-7-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NlHBkxMClmN0/tWHncpTwIrqh9TTqZaCskkoWTMXQ1Z+wcZxJ/gLdQsl
	w7bOQfupXqiODl+T50podz+Rfa3FFwlLPz/TABwG8s/EQMire6XIVZRnFq08jy4/mvW7To5
	pP2/nIBGxdyplXDA3C021CcRSO6dJo5Vl37pT3AGYw0LahQW5hB5eDR92YYuL07TPcopYFr
	2uBJPrMXBRgnw8cE/GFSqeXWfWD6MlyC6P8J5vhtyN1RqfalTxTNd0DSc46mPLyvR7+c054
	2PIB2XAjEY8Z+b9a4g0vbW0FtZ3XQlpfOigLiAxGCWQHS76a0BiksMirriuVF0BL+podRKA
	+qMn3ZCfrQ4nA9nTqtO2j//juK4kncIYN+7NE7JHh/IoLt9REjA3yFnZhQMj+L8saCeiO1j
	QXUA5YDPsU4PThC7zOkTh9RTRgvlw26O9MaSNQPWs5y4yguwTfOG4JU1EZdpY1lCo9Gxalf
	VaJt95JUqNyeTpygReQMUkc+HTHfQnmbiSxryLqOtzUxZaPqXDZzJmkLXezBcWf3QPysIcl
	QDSpDioM1TbKeqYBWMVH3GLOfLd1LZ0H7+FJ1fLeU8gepTMZyo1Ee9zA1LKA+zQORqZ28lB
	GuWcUXXDp9RQrk0WrhJYNjYfbpyg/i59LkPD0VFtAZwVVCnDTTMlCvJiE9N/1FA7qO6ma9V
	QlfYa9UcL/T1rZXUHCbEdd5Q8U3xsURq5G66GyLdaIYP90eCa7P/kumqQHFbe/bgVQ649oR
	zZaTKE9ycjNOy/Fe40i0YFxF2XuTAMCOqQQuRyjbP8mFBbwXbsZUpzA4eq1ekFHHpTyrx4s
	j+VTSrgLR4hsw1MyPlrdAgwTszOhkevTDMQS7eO6FU7lmAZDBtIo2KDJ+d8pbkdyX+JpGmH
	Gy86SHunkIYO8K2jwmzBvUcdRBxR+XFD7ZbTbaQQEwa61U1/FOz/tRTo6cxS4Zuzx395Jn3
	ZAHiMtrz744SqULqZ+TLRpVCXVwVG+UPcL8kvS08mCrQkcr2rvkKnedk3I5N8YhGKfnMFP1
	OEPjuEeq/zeGQMlWk3KP2ZstECyATk9h8XAkbpBQMvQ+bCGxYTdrgw0ToksV/2Yb/stmic6
	Q1f+DlfemvIkXyb1+bLuNKc742bYkE+kW0veEjUq5DQpvTcmwYdtLtkNZot5OcQPfzCuvcH
	TVhr3fYaUveSBMz51WAXoRJ82Q==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 28098defc79fe7d29e6bfe4eb6312991f6bdc3d3 ]

Some high level software drivers need to compute features from lower
devices. But each has their own implementations and may lost some
feature compute. Let's use one common function to compute features
for kinds of these devices.

The new helper uses the current bond implementation as the reference
one, as the latter already handles all the relevant aspects: netdev
features, TSO limits and dst retention.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://patch.msgid.link/20251017034155.61990-2-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 744c03df1002f9a83335ff9f62916b6e2caa02ef)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/linux/netdev_features.h | 18 +++++++
 include/linux/netdevice.h       |  1 +
 net/core/dev.c                  | 88 +++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 1b5ad57e7cbf5..988e62cafd316 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -261,6 +261,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
+#define MASTER_UPPER_DEV_VLAN_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+					  NETIF_F_GSO_ENCAP_ALL | \
+					  NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define MASTER_UPPER_DEV_ENC_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+					  NETIF_F_GSO_PARTIAL)
+
+#define MASTER_UPPER_DEV_MPLS_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_GSO_SOFTWARE)
+
+#define MASTER_UPPER_DEV_XFRM_FEATURES	 (NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+					  NETIF_F_GSO_ESP)
+
+#define MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 202e557496fb4..a81dab6c2f5f2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5005,6 +5005,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_master_upper_features(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 405b448bd91fe..0cc03e6c6fb14 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11450,6 +11450,94 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_master_upper_features - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES;
+	netdev_features_t xfrm_features = MASTER_UPPER_DEV_XFRM_FEATURES;
+	netdev_features_t mpls_features = MASTER_UPPER_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = MASTER_UPPER_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = MASTER_UPPER_DEV_ENC_FEATURES;
+	unsigned short max_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	unsigned short max_headroom = 0;
+	unsigned short max_tailroom = 0;
+	u16 tso_max_segs = TSO_MAX_SEGS;
+	struct net_device *lower_dev;
+	struct list_head *iter;
+
+	mpls_features = netdev_base_features(mpls_features);
+	vlan_features = netdev_base_features(vlan_features);
+	enc_features = netdev_base_features(enc_features);
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 lower_dev->gso_partial_features,
+								 MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  MASTER_UPPER_DEV_VLAN_FEATURES);
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 MASTER_UPPER_DEV_ENC_FEATURES);
+
+		if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+			xfrm_features = netdev_increment_features(xfrm_features,
+								  lower_dev->hw_enc_features,
+								  MASTER_UPPER_DEV_XFRM_FEATURES);
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  MASTER_UPPER_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+
+		if (update_header) {
+			max_header_len = max(max_header_len, lower_dev->hard_header_len);
+			max_headroom = max(max_headroom, lower_dev->needed_headroom);
+			max_tailroom = max(max_tailroom, lower_dev->needed_tailroom);
+		}
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+			       NETIF_F_HW_VLAN_CTAG_TX |
+			       NETIF_F_HW_VLAN_STAG_TX;
+	if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+		dev->hw_enc_features |= xfrm_features;
+	dev->mpls_features = mpls_features;
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
+	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	if (update_header) {
+		dev->hard_header_len = max_header_len;
+		dev->needed_headroom = max_headroom;
+		dev->needed_tailroom = max_tailroom;
+	}
+
+	netif_set_tso_max_segs(dev, tso_max_segs);
+	netif_set_tso_max_size(dev, tso_max_size);
+
+	netdev_change_features(dev);
+}
+EXPORT_SYMBOL(netdev_compute_master_upper_features);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.30.2

