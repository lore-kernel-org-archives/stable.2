Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070F2F7AD2
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504308; cv=none; b=KjLuyIlvzKEizNAhIL0ocInspEyl11yNMcQhN0j4L3sKFXs8dTto0zCDpidzVqGEHiFbydJrwRdZYAo0KF/8qAn7tJvGIgALWfN7/XUOEKQ0J4iQtCTejTmtcA4w8CVIeTjEqYg4JMsZH+tEbc83kg0/PLLWQMFn7fgTuKmfJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504308; c=relaxed/simple;
	bh=gIJuQpbGBprMTZj4fI1DJ+HWF9GdQRmiHjiy0ilOOx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UqFW8fqimeQiai+HbctJzoUMWqO30GbnxMBxylmkpo5VSwUWJ/TKm6iWI6Y+azNZ6TcMG/M8gY9oFNTVUudjR9UpI3aX1Kg56kHAmRkNpDkXSlmqgXP/3kXwQhebbk8PHZo4X5zECIBwAWUSOJk3wd7Ecn9IyzeNs4cuda3cz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lKEfru2q; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lKEfru2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504231;
	bh=k3eEdy3zwrLEeUUYFHk+OKgu6J2cW+PVB9Ma6vI6mgY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lKEfru2qtcSz/CMDF1t9+9hm91UUH83yejAXRit2q7tlXCLHOsCN+U+5YGgWiYGZk
	 B+B5t5jsQtzufLAHXqg+FuYymJ8eallPKg6hWUkuBi/cws4tIPFmdYOwdTlHje+NQV
	 lUTsM9M8AHtORJWmNp7rov/UnlXOIN+5tPMQ9B6w=
X-QQ-mid: zesmtpgz3t1783504211tde6dfb9b
X-QQ-Originating-IP: XtN6cGRdh8GNn2ihL5qS2Bn2X38NtPL8wgP2CV5g0Tc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:50:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15675103572857389073
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Eric Dumazet <edumazet@google.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 10/11] bonding: prevent potential infinite loop in bond_header_parse()
Date: Wed,  8 Jul 2026 17:47:21 +0800
Message-Id: <20260708094710.27047-11-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NSegwrIO7C6E3gQkuRaymzoMQKz/vmFL/7AkWWx3yYMraj8qZVE3feEo
	q+dSeH1dhG2XhiEcHDaL3+OwV5LEtu63yU8KUs4zsxugb8VPI/IL47Hf6cAFCFJ2fRxFThG
	iTAKof9Hnf1Mclw1xy7KFA/PLvhxRoTYhWkWljuP3w+ssTk6r9SffSiA6dYR0R8y6OmrGDV
	v4kAdQ+wOYwZRoVsZUBwqcSJL6e38Fe20SBcEyndXwbkbrPpKOLpNKjt+M5cXb2D/SdePNj
	nYZoZKNgaqorTXhOt8zzXtANh7VDNQU/7P6UjBPH6ziTvtoiwpdtf1JAo6RxDNlKaEpzCdx
	zPaiZl4XvMqWceDEdyASMVChWxWA5wo/teDMw58xDIHHPY0lk4ff+TZHGSVPGwDgTMflth4
	SyGqaBmjsHaa3VpOhqRFdbr3ubRT3KvFK9xHe7CdvWMHtRorI2ashOt9VbKmyMWRwput/MB
	3cOO35EE1g9EXtmUHcY6lVoC0lIrSRctL9JIwpm5KP5Jdyxcaw8FmzOGsqcUIsbKj7gP1cD
	9vYzEP4aNGGcrk5aGtyppMQbzDBbjOV8CNGQ4sKu6+7lyRU7+uTbmBG076nrXfM1oPA+mpV
	Rm2QhqoAdzsg4Z1cPnU1f4R0ArYe3NE3FaQ/r2XzufTwZxrqfyqp0bQVKV582E6RX9f8U4E
	fH4cACvtx57iaVCBvFy7b+AxGsb52gXzvcckikiIJQ2G0scl4xYfW+OFUUlMILCjxhavO+C
	1yobiTGQ4svqvIveYdVpjl9B3LbRwSY/OZZEslj9AryldvaTRvroX1mFW5f8b+bKAp6rQP4
	/LPzln4Dr5/oBX3WgNawGSNfvUZqK9h0SajvyuroA/9F44xEtK/MIcb0xL0kM2eFNVetkOM
	/kGmw0PM2QGimmhw7EZX6Ff7rPN8gOziuqNXSa0zsWE2mipHu40/Vv5Ffpx3jVSGHSUKoWw
	foJB3537gQcKQue2Emh0L+EyZy/0oWAF2lqDoFk24pDQkNSfmTh828O4hHMuJawK4Sp4+Om
	JyXdNXM7wDxli1qnbEmNxokBon1i8Vkf5xUCU8XmpCXI7z+6hRcxaz/R6plAFu/RLbqCQtf
	zYyyVtwXMw2hrzcczQoYwXbulQgq8wTv5KUjTLMZf2/nmrr4A7IqhMCXoZKnnqleA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b7405dcf7385445e10821777143f18c3ce20fa04 ]

bond_header_parse() can loop if a stack of two bonding devices is setup,
because skb->dev always points to the hierarchy top.

Add new "const struct net_device *dev" parameter to
(struct header_ops)->parse() method to make sure the recursion
is bounded, and that the final leaf parse method is called.

Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Tested-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Link: https://patch.msgid.link/20260315104152.1436867-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[backport to 6.6, also fix function for wireless/{cisco/hostap}]
(cherry picked from commit 946bb6cacf0ccada7bc80f1cfa07c1ed79511c1c)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/firewire/net.c                             | 5 +++--
 drivers/net/bonding/bond_main.c                    | 8 +++++---
 drivers/net/wireless/cisco/airo.c                  | 4 +++-
 drivers/net/wireless/intersil/hostap/hostap_main.c | 1 +
 include/linux/etherdevice.h                        | 3 ++-
 include/linux/if_ether.h                           | 3 ++-
 include/linux/netdevice.h                          | 6 ++++--
 net/ethernet/eth.c                                 | 9 +++------
 net/ipv4/ip_gre.c                                  | 3 ++-
 net/mac802154/iface.c                              | 4 +++-
 net/phonet/af_phonet.c                             | 5 ++++-
 11 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 7a4d1a478e33e..21f3a9dae072a 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -257,9 +257,10 @@ static void fwnet_header_cache_update(struct hh_cache *hh,
 	memcpy((u8 *)hh->hh_data + HH_DATA_OFF(FWNET_HLEN), haddr, net->addr_len);
 }
 
-static int fwnet_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int fwnet_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+			      unsigned char *haddr)
 {
-	memcpy(haddr, skb->dev->dev_addr, FWNET_ALEN);
+	memcpy(haddr, dev->dev_addr, FWNET_ALEN);
 
 	return FWNET_ALEN;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index af8cdc8d26c91..6b558aa98c6d2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1489,9 +1489,11 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 	return ret;
 }
 
-static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int bond_header_parse(const struct sk_buff *skb,
+			     const struct net_device *dev,
+			     unsigned char *haddr)
 {
-	struct bonding *bond = netdev_priv(skb->dev);
+	struct bonding *bond = netdev_priv(dev);
 	const struct header_ops *slave_ops;
 	struct slave *slave;
 	int ret = 0;
@@ -1501,7 +1503,7 @@ static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 	if (slave) {
 		slave_ops = READ_ONCE(slave->dev->header_ops);
 		if (slave_ops && slave_ops->parse)
-			ret = slave_ops->parse(skb, haddr);
+			ret = slave_ops->parse(skb, slave->dev, haddr);
 	}
 	rcu_read_unlock();
 	return ret;
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index dbd13f7aa3e6e..bd269fdaa1d01 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -2437,7 +2437,9 @@ void stop_airo_card(struct net_device *dev, int freeres)
 
 EXPORT_SYMBOL(stop_airo_card);
 
-static int wll_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int wll_header_parse(const struct sk_buff *skb,
+			    const struct net_device *dev,
+			    unsigned char *haddr)
 {
 	memcpy(haddr, skb_mac_header(skb) + 10, ETH_ALEN);
 	return ETH_ALEN;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_main.c b/drivers/net/wireless/intersil/hostap/hostap_main.c
index 787f685e70b49..8ba1a709fe47d 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_main.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_main.c
@@ -575,6 +575,7 @@ void hostap_dump_tx_header(const char *name, const struct hfa384x_tx_frame *tx)
 
 
 static int hostap_80211_header_parse(const struct sk_buff *skb,
+				     const struct net_device *dev,
 				     unsigned char *haddr)
 {
 	memcpy(haddr, skb_mac_header(skb) + 10, ETH_ALEN); /* addr2 */
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 297231854ada5..6f96d1c6d10fd 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -42,7 +42,8 @@ extern const struct header_ops eth_header_ops;
 
 int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
 	       const void *daddr, const void *saddr, unsigned len);
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr);
 int eth_header_cache(const struct neighbour *neigh, struct hh_cache *hh,
 		     __be16 type);
 void eth_header_cache_update(struct hh_cache *hh, const struct net_device *dev,
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 8a9792a6427ad..47a0feffc1215 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -37,7 +37,8 @@ static inline struct ethhdr *inner_eth_hdr(const struct sk_buff *skb)
 	return (struct ethhdr *)skb_inner_mac_header(skb);
 }
 
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr);
 
 extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a81dab6c2f5f2..74474139fb9ac 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -312,7 +312,9 @@ struct header_ops {
 	int	(*create) (struct sk_buff *skb, struct net_device *dev,
 			   unsigned short type, const void *daddr,
 			   const void *saddr, unsigned int len);
-	int	(*parse)(const struct sk_buff *skb, unsigned char *haddr);
+	int	(*parse)(const struct sk_buff *skb,
+			 const struct net_device *dev,
+			 unsigned char *haddr);
 	int	(*cache)(const struct neighbour *neigh, struct hh_cache *hh, __be16 type);
 	void	(*cache_update)(struct hh_cache *hh,
 				const struct net_device *dev,
@@ -3174,7 +3176,7 @@ static inline int dev_parse_header(const struct sk_buff *skb,
 
 	if (!dev->header_ops || !dev->header_ops->parse)
 		return 0;
-	return dev->header_ops->parse(skb, haddr);
+	return dev->header_ops->parse(skb, dev, haddr);
 }
 
 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index b4a6e26ec2871..a90d2470e090b 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -195,14 +195,11 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 }
 EXPORT_SYMBOL(eth_type_trans);
 
-/**
- * eth_header_parse - extract hardware address from packet
- * @skb: packet to extract header from
- * @haddr: destination buffer
- */
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr)
 {
 	const struct ethhdr *eth = eth_hdr(skb);
+
 	memcpy(haddr, eth->h_source, ETH_ALEN);
 	return ETH_ALEN;
 }
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 75d388dd5ac62..fbe554a6fafa7 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -888,7 +888,8 @@ static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
 	return -(t->hlen + sizeof(*iph));
 }
 
-static int ipgre_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int ipgre_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+			      unsigned char *haddr)
 {
 	const struct iphdr *iph = (const struct iphdr *) skb_mac_header(skb);
 	memcpy(haddr, &iph->saddr, 4);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9e4631fade90c..000be60d95803 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -469,7 +469,9 @@ static int mac802154_header_create(struct sk_buff *skb,
 }
 
 static int
-mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+mac802154_header_parse(const struct sk_buff *skb,
+		       const struct net_device *dev,
+		       unsigned char *haddr)
 {
 	struct ieee802154_hdr hdr;
 
diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index 2b582da1e88c0..e38fad4144e48 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -129,9 +129,12 @@ static int pn_header_create(struct sk_buff *skb, struct net_device *dev,
 	return 1;
 }
 
-static int pn_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int pn_header_parse(const struct sk_buff *skb,
+			   const struct net_device *dev,
+			   unsigned char *haddr)
 {
 	const u8 *media = skb_mac_header(skb);
+
 	*haddr = *media;
 	return 1;
 }
-- 
2.30.2

