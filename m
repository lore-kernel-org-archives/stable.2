Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1F43CE5E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740723; cv=none; b=EpSWK/XR2kr9mIa6/zQKLMTjE/1GzkHd2lyvbIAfVAYdbnp4XmPpI4qPLlY0jSG5EP7Izi4RDtYDM4cK307nxbAAiRqt1pHNqFG5nIvBPR9KpQBOUmMVfAJ9g8zzTZgifOFFlNF+Z6wWwkZ5UoZVfML+if/B8vbOM51oSehwOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740723; c=relaxed/simple;
	bh=T6VI/MjUMTWjR0YmJzrLiiKf7zo+1Zk/2lAOGfSsHHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KG/U8Tx/nLEvzBo22N8G7GkuOXYDo/0j1r1p00zJI/mrcwP/CvDb5qjJY5A5cpksoAg+0OAMNHQJ6UqmyOCaoY6Cz0QGO5NNFq7kzWVysEBxBF1ba3SCORXqiEPzHWyBZl8iJ/ynUZcWYS/gZtwfKzVqnGFEdtmCAGtC8NCzArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0AOnUaz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0AOnUaz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f6981d244so681f8f.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740720; x=1785345520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRQ5TWPONEvJdayuRFKl7W3Z0rghnTrzVVZ4y0zRgw0=;
        b=h0AOnUazKFb+8b3m+V7160UIw0rFzoQ7s7guhMaVYmmF3xWsM2ESTfOoRuURjuCkBf
         35Y54tH3KlFoC/ZQQGQux2G24clI7v+nLALObSv7h2d1F8VZetR3rA/6fnYY04gcPeeR
         V5sB4azWuLHrQ0rD1s5Wox3WhOnOG0ajne3eM9AecDQV5zQBxhPcHA1HOoh/BVhb8eWW
         WXrWJJ+bAbndxfYKZXcHQmAE2I4vLwgblmKe2WPBKiS7ALSxN3Q9F5N/nOAerEoq2oEx
         qOGflCWN0ej61uXGPBqAouOt2BLj9jXAUeYrEAxz814FYYFd37apaft9b4Xn66ThVQb+
         uGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740720; x=1785345520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRQ5TWPONEvJdayuRFKl7W3Z0rghnTrzVVZ4y0zRgw0=;
        b=Z79HDLZMhqntX7ndPp2yi0T5JKAhJN4FcJgwY1CmluAAkYWu++ZBd7Ezp3OAAs7sDz
         7jLnpiC5Mli6RIBT/sS85L6/u3nwCLEL8e3H1rIstDWIa4s22u3ULduine11qZz+GrG1
         9Jpdr6yWPt9LM48zv3eoiexVwevva0p+oFznLRqlOvL81CetRyF8qs7a/Z1eZAQFK8Qi
         kadSF4pKAI6IsoIXZx8LwxD5zAqdx27JEDOpHvIC6c8lvxKbiVYUb+HsEv/b4RGtdJxs
         6B1/GkZtDfV/PlPP8UhUovpI9OyoG6C/S5MbuLjBw+ud3IvLmYYIjFxGO5orxKj5cCvQ
         u3QA==
X-Forwarded-Encrypted: i=1; AHgh+RrSyl3dzgcNNe6GCnwzh5s/JAgkt+3QrWV03ezM42xP41UrZYd6HWbKufdKhnjl3OtcPmvSz5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxvIX3lIdzW5xGEy0raLRU1J07Xg1HepDEbm4bjnxyNxyE/bz
	gADA3bOyEKReaIcJocLx44WizdYW/TMNFcm9v3sc5VPqfxjVvesYmLr/
X-Gm-Gg: AR+sD12bb0pUNCRHgaRmgnFovCKsivRVJ0AiEj87fiJDpPOXzcXdrAq1j0oeN1LAOYZ
	Aa5cw2r88gVLNs51P3/GYREK570QrT5z4uxcJjUks5oqH6Mpx+1MaUeLKNKIYCbvS477DUXOs4J
	7m37cSZI/TEKFdO/WCcFiVhj5BWaODwaWGZTScXFa8vhLyeMzobT2+0E3con1wmegxvfgzcoiVS
	uLHSmJEOdYio59EahBx9Yotr9Fg0BiupisGzfrn0DCUemlL64A3vS7gZCJTA/QLStL3sTsuqnze
	VVSwX/GH54WLrLwcgxYvhXYnZOQ27moS7MoxrEztq0eteP9iJ7b+Fp3gJTFUs/3h7643X9jND36
	wYCgG5dE0rMECIt1ow11/NO9bkU3+RtpxnG46vSc7DbPx/LHRH0KvKR9he36+jZpJXK68gFWHTp
	5qHnnpa4ATBYbqN4i7TDcpyN+1K5/C6hiNesRchGAfkINPqpj/O0lxr2zckKE2eSfBW/kfELLag
	iaK9OV3djColld/HkxJgXJAxh3rtEMg55+xhGZXNBYYQwkV
X-Received: by 2002:a05:600c:4f82:b0:495:6274:56bd with SMTP id 5b1f17b1804b1-495659881dfmr61794135e9.4.1784740719850;
        Wed, 22 Jul 2026 10:18:39 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-078-051-150-230.78.51.pool.telefonica.de. [78.51.150.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a634cf9sm92427615e9.9.2026.07.22.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:18:39 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	qingfang.deng@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Wed, 22 Jul 2026 19:18:33 +0200
Message-ID: <20260722171836.196-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722171836.196-1-xiexinet@gmail.com>
References: <20260722171836.196-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP append a 6-byte tag/RCT to every forwarded frame and process
each frame individually (sequence numbering, duplicate discard). When
a lower device aggregates received frames into a GRO super-packet --
in software, or in hardware on GRO_HW-capable NICs -- the HSR
receive/forward path mishandles it: frames are dropped and, on
memory-constrained devices, processing super-skbs in softirq context
can also pressure atomic memory allocation.

The HSR/PRP stack already disables LRO on enslaved devices for the
same reason. Extend that treatment to GRO: add netif_disable_gro()
and dev_disable_gro() mirroring netif_disable_lro()/dev_disable_lro(),
and call dev_disable_gro() from hsr_portdev_setup() so enslavement to
an HSR/PRP master automatically strips NETIF_F_GRO and NETIF_F_GRO_HW
on the lower device (recursively on its own lowers, as with LRO).

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Cc: stable@vger.kernel.org
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 18 ++++++++++++++++++
 net/core/dev_api.c        | 16 ++++++++++++++++
 net/hsr/hsr_slave.c       |  1 +
 4 files changed, 37 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f..eba2c26a4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3434,6 +3434,8 @@ void dev_close(struct net_device *dev);
 void netif_close_many(struct list_head *head, bool unlink);
 void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
+void netif_disable_gro(struct net_device *dev);
+void dev_disable_gro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab..a6cf2adc8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1840,6 +1840,24 @@ void netif_disable_lro(struct net_device *dev)
 	}
 }
 
+void netif_disable_gro(struct net_device *dev)
+{
+	struct net_device *lower_dev;
+	struct list_head *iter;
+
+	dev->wanted_features &= ~(NETIF_F_GRO | NETIF_F_GRO_HW);
+	netdev_update_features(dev);
+
+	if (unlikely(dev->features & (NETIF_F_GRO | NETIF_F_GRO_HW)))
+		netdev_WARN(dev, "failed to disable GRO!\n");
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		netdev_lock_ops(lower_dev);
+		netif_disable_gro(lower_dev);
+		netdev_unlock_ops(lower_dev);
+	}
+}
+
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
  *	@dev: device
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 437947dd0..02fb21629 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -269,6 +269,22 @@ void dev_disable_lro(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_disable_lro);
 
+/**
+ * dev_disable_gro() - disable Generic Receive Offload on a device
+ * @dev: device
+ *
+ * Disable Generic Receive Offload (GRO) on a net device.  Must be
+ * called under RTNL.  This is needed if received packets may be
+ * forwarded to another interface.
+ */
+void dev_disable_gro(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	netif_disable_gro(dev);
+	netdev_unlock_ops(dev);
+}
+EXPORT_SYMBOL(dev_disable_gro);
+
 /**
  * dev_set_promiscuity() - update promiscuity count on a device
  * @dev: device
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f..cefbbfbd5 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -170,6 +170,7 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	if (res)
 		goto fail_rx_handler;
 	dev_disable_lro(dev);
+	dev_disable_gro(dev);
 
 	return 0;
 
-- 
2.43.0

