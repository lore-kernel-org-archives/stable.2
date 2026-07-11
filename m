Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086628F5
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777659; cv=none; b=kAV/MIJM3/ZiowqdtzidZoh8VZvDjG3SIZ4h1Aace/G7yVReLC3SUDy7ixrqVRJwgix22rz4/m1fcVjrxZHo9EDkSTAutRkHPFMLn9FcUeW1SeApy4g4aE/9NCajrBsfTEkAoYxytKyc4XyOvpNedDDjpJpgXwYABScOtKAHGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777659; c=relaxed/simple;
	bh=dI5sz4efJ/IwhuA+ar8TvJxJWTOdMJOvEDrJnVCWieo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HK+XrpZvQVqGEX+kncLxfsfSFMfOvcLpd7QJRJ82Agt0RoIcJTVqYH5ZTWXqOCqSYmOowVJtivT2Bqo1SRsTdstchruUeQ22cZ74IYTBYwF20pVOVli/eeIgeBwbtehkCZMAqQa64pK5gUtxnvTj8TuXjtHzeR2PfsvRCMNV14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6bFz5ps; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6bFz5ps"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so18388245e9.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783777656; x=1784382456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRsWWJteHWK3O+2yvFE1KJZgJEYSIpWRCnEwdBb+TyM=;
        b=a6bFz5ps6z1NUfNjeqAYN68pJE3TX42OTyBdHbRt4NgLTGEbOkstyQ7Du3zrO1ATev
         dxf5+yfMN2/CufYQROXsCVgeXHee2hXiPnJfMaYdIVQ93K1Zhe1QdLt3u/gQBMaG+/EB
         iJGc/ZWRbxht7gmh1hH6bYOXuTgWfTBfTQBquiVTUNTB3ZWg4uRntyvKY40Dnu0ucNsd
         8/wuHQ3QDO9MD9Z0UO27JK/W5ttcI2sLpEAIMT3XRlL+/4HGOhpJbji7Ul82i+wQ4kdI
         KhCHeJg+koy75AkIxH8B4lxsNs5sJDEiJyju3WoESSO034Yfp3/r+u0s7Sjjc6dNGmxS
         sIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783777656; x=1784382456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRsWWJteHWK3O+2yvFE1KJZgJEYSIpWRCnEwdBb+TyM=;
        b=MDfg6fzvU/DWIrvSDxcd++hiw9Ggpj1kdRex0PiXiP0cjsnKRz2MlCFq1umqHINmNR
         PaXEgPqMdE1zo1sHXdJgDK/BiUeD0rdVzeMJFqLgA227f/TiQ63x4RGgd+HMgLbCwl0l
         2LucDl9N0A5tSiYu+klRBwEdFpd4LMXeWkw9xmGHo2mO//qh68eBkqHEnm+EOvtJX+OI
         KmylvDryKmia1n1PKEf6oyXecz0MC3p6l9xLfwNUSO3hvXYjXRvwVbFnCfaKZbLAkxkV
         nLmWnNLrKXqNrhKCx+jbmhbDUsHLrzTYAvltyokAACfCyygDSgvtUlITNKsNavp9CGlI
         MqfA==
X-Forwarded-Encrypted: i=1; AHgh+RpinDCfOub2EsIfmJ+vAmWQi2ep5FWWOzdR0irVg6WVPfI0FOoFKqrxE+YhS7fddMYImWqahqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7ynha6xXxEjqK1FufRi6/3p2tWDbVCvCO5rQfK7x+TDr9ajP
	KG2+PNXVbHTxF3d49fZP2TrtiyN5JQxQIMwXZJxmAoYFjXBeA5m7aow=
X-Gm-Gg: AfdE7cnug1VviLmSPHueUfRKcugQEAnv7BuJNDuKhNalBIeMDWMo42kBcRaR5D7X4P8
	d+IG7rmaWhIN7s2Q8U1Y0YsCHz8y+9cBAX9NjHIniSxruZo+51bo0/Jts26Nxzxm0KI5oZuE7Qs
	VtJI1WacjHYEgr1P0dRvbPjzFqyboVgMLd7C1h9Z698ZhiQUNAPMS7uDZdBkt2R4RtV+UAkq1xe
	9e7CmUkXcV6078l5HHG7bmhqfMrin6dtJbK05BDbX/eLrz0V4HK33MSyduSC13vTCWl0CqDmTmG
	kmOwGbdt9VyWhMcPhM5CcoOnwLJj30nVwbUGKX/2MQHn8cUisyMpO9/QGYMpkLubIn7Ul8RUHQ7
	+XlHpH0nBgf3AwwNX8RzFbJPC/YkFZ9KbDlJuoP4aGuR+EG2582Rw5D8U+A==
X-Received: by 2002:a05:600c:6304:b0:493:bb2e:11a5 with SMTP id 5b1f17b1804b1-493f87e4a48mr27240475e9.15.1783777655987;
        Sat, 11 Jul 2026 06:47:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm104406305e9.2.2026.07.11.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:47:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahesh Bandewar <maheshb@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] ipvlan: add xmit recursion protection
Date: Sat, 11 Jul 2026 13:47:32 +0000
Message-ID: <20260711134732.1385563-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

ipvlan devices can enter infinite transmit recursion when combined with
packet forwarding configurations (such as IPVS) that route traffic back
through the same ipvlan interface.

The recursion path is:

  ipvlan_start_xmit -> ipvlan_queue_xmit -> ipvlan_xmit_mode_l3
  -> ipvlan_process_outbound -> ip_local_out -> netfilter hooks
  -> dev_queue_xmit -> ipvlan_start_xmit (recurse)

The existing per-CPU xmit recursion counter in __dev_queue_xmit()
(XMIT_RECURSION_LIMIT = 8) does detect the loop, but fires too late:
each recursion level consumes roughly 2KB of stack space through
ip_local_out and netfilter, and at 8 levels the cumulative usage
exceeds the 16KB kernel stack on x86_64. The resulting stack overflow
hits the VMAP_STACK guard page and causes a kernel panic.

Add a per-CPU counter that prevents any re-entry into
ipvlan_queue_xmit() while it is already executing on the same CPU.
This mirrors the approach used by tunnel devices (see
IP_TUNNEL_RECURSION_LIMIT in ip_tunnels.h) but with a stricter limit
appropriate for ipvlan.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 835e04835..ab99eb624 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -9,6 +9,8 @@
 
 static u32 ipvlan_jhash_secret __read_mostly;
 
+static DEFINE_PER_CPU(int, ipvlan_xmit_depth);
+
 void ipvlan_init_secret(void)
 {
 	net_get_random_once(&ipvlan_jhash_secret, sizeof(ipvlan_jhash_secret));
@@ -676,6 +678,7 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_port *port = ipvlan_port_get_rcu_bh(ipvlan->phy_dev);
+	int ret = NET_XMIT_DROP;
 
 	if (!port)
 		goto out;
@@ -683,18 +686,32 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct ethhdr))))
 		goto out;
 
+	if (this_cpu_read(ipvlan_xmit_depth)) {
+		net_crit_ratelimited("ipvlan: xmit recursion detected on dev %s\n",
+				     dev->name);
+		goto out;
+	}
+
+	this_cpu_inc(ipvlan_xmit_depth);
 	switch(port->mode) {
 	case IPVLAN_MODE_L2:
-		return ipvlan_xmit_mode_l2(skb, dev);
+		ret = ipvlan_xmit_mode_l2(skb, dev);
+		break;
 	case IPVLAN_MODE_L3:
 #ifdef CONFIG_IPVLAN_L3S
 	case IPVLAN_MODE_L3S:
 #endif
-		return ipvlan_xmit_mode_l3(skb, dev);
+		ret = ipvlan_xmit_mode_l3(skb, dev);
+		break;
+	default:
+		WARN_ONCE(true, "%s called for mode = [%x]\n",
+			  __func__, port->mode);
+		kfree_skb(skb);
+		break;
 	}
+	this_cpu_dec(ipvlan_xmit_depth);
+	return ret;
 
-	/* Should not reach here */
-	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, port->mode);
 out:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
2.47.3

