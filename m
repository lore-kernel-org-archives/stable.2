Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB493CD8D7
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786277702; cv=none; b=DIOYTUjt3I/A187FZtkzYzx1giwtjKWjacHaSScSTILze6qPmrEAB6iXX2nLk18BGNV64wdfOqV1vaKamcS/IEL9b9ltIOKorY/0cUtF4tCfRmVxvu879UZzqAEdvHpeFmxsiZMrQWLazB1ZyarZUsiEzzQKEq+4ezJRTvHaEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786277702; c=relaxed/simple;
	bh=nUOVeBFFUPO0EXBKrcOK+AXygJbNMgByifpoRqFKklY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXcaIHRXiIuCeCePA4oIBGU5L/HUDG0tLIx8ytyqCgsaId/dr+5x6tQSEUGobqr8EJgojJHZerih6sV5k3d2tl2UJSNZJx9FvAHSDyRjgTy1e8qkN6WiXpA7sYMwa80AW/a5sbZ9k8JctpoOyqVZLk3ITXHp7Hqq5tqlgmSO3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpFVWZVL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpFVWZVL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe45db360so119543f8f.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786277698; x=1786882498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tjt5VhvveBeVhJ7gVkQsZLN+QtuDGPYHnEEQcH//h8s=;
        b=rpFVWZVLH3wwUN0P/t6fs6jFdpeP9LNUcUVSNpK04vDbyeKwUZ0CeSAVHswpA4yEJY
         pv4P0mRJ6Yd7Mhg6Nu5xoxwHpHcu0DBtg2d7Oyfy8S2tA6n5MRIG/hglnAYaalxT92jw
         +n71l5NpbtmPyTBXpVhv3faUBOOFumjhjP0cNe3+6bLcB5DWFhtaJhmqar0carvqkhDS
         uSMn8qYHq2LT4ZsdAknkDsWbZTWD4LDN8GHo37gjOyylJ9tACzU+xnsc5A0Lkyt0vGvJ
         6EAyCMWlaYoryDnMiiEFdL56rJbg/jlizLkmgc7+A63waBOxIj+2s6elGO4IG/UFkQ0O
         F9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786277698; x=1786882498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tjt5VhvveBeVhJ7gVkQsZLN+QtuDGPYHnEEQcH//h8s=;
        b=PktnokxgV5oWRqoX+xSQpTGeDUb/N8HGbwLl0HBETMOKkMJy+aiObgihuKpVijJh8L
         XThO/qydUu/PalOIiAORquvhGBBgL+tP04+2NnhSMvgLiAq5kfO8zyvMY8aZy4zfZrQp
         1IgSG8GaxcZ3jChk1SGEPuNz+tA7Uio+9zch5zRafR9ZThk+vEC3a5L4eKGxR0aPd/PD
         9mYX5XasHaYkrn4wC2Q8sddpVhs6j+yrrI5Ks8eLMLcGV+QfIEFxHU0n2e3vLgNZCcS/
         ldoqmef41bwZTqVA+P11LIvacHYMKkCNKTNXATWOU9cvWkE2uonfutngcA7xDKcA05si
         2nBQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIR1jFCmgOeux+M13YpPsg5+wKd9pBBDj9s930j4694nebnvymzrzw2y0ousSr9cLrX4h9EP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsyEEt5014qVbur/vwyFdb+mTeScfkWnH9B2ei+GCyRVO19bWD
	JoCfzR+Q3rH+rgE0vbtqs/G7OG6bIyHVkX3GvRUazqPBd5M1zp5QYgFB
X-Gm-Gg: AR+sD12wuMzUBeQ1EihY3EIo9WPjZy6HAAtIZyibQgGR5chzlXsWrWL4bg3uPruDvRH
	7YIn3uZ7OK2bmjt8NVyNXxx1+PtW2+T/IsAuTyAnIbxVfls9mkJp9Fy8FhTSE0bWlQMqFhMbl41
	KeyIMYWl6mRZLuGW0WEHZ5zjcT5dQkrb4BxVD3F4Xtv21Yk8oWa7vfDLboLYQSt0+BPO0nIhGLJ
	TZAE6iNeboL2Zv4CGBZqqWeBAERnbh9F2vEYgk1iFTN6JLqqGhBOVpHQCmvwkulS9/afG17KGMb
	JE9MdPWESmyyksSeQj3eOR1+OMt75UAVMRA+uswd9KpSK5OF/JIsIkmFk0Zn6AUsxE3x4U9sw/X
	XL68vGHZrxf8CHDNaC7NGj7Nt3BsVq8IRfFVsmQzzMpK/UpcezRpCvS0rr+SoyvymhlnV51Du+1
	yfPJdi/rK7kCpVflItEunZufKLa5hkdtvGgWSNLPwZtHQwtoFvuzbo2+oFJc/0hyB6t+zDi6XzF
	5Av1FovZfnUtQlz/qX6KVfvVXg/xsE5GoUDHH5PRcDPzjI39Vn48MYwtysr7CztELoy+katYTo+
	lQpa8K9sw3rrMLLZl7fe
X-Received: by 2002:a05:600c:1d10:b0:498:8e6:d463 with SMTP id 5b1f17b1804b1-4994e79b14emr243848055e9.1.1786277698245;
        Sun, 09 Aug 2026 05:14:58 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-012-133-135.77.12.pool.telefonica.de. [77.12.133.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b3fsm25158434f8f.20.2026.08.09.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:14:57 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Sun,  9 Aug 2026 14:14:51 +0200
Message-ID: <20260809121455.1745-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260809121455.1745-1-xiexinet@gmail.com>
References: <20260809121455.1745-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP process each wire frame separately for tagging and duplicate
discard. GRO on a lower device hides multiple frames in one skb, which
cannot be forwarded with valid per-frame metadata.

Disable GRO and GRO_HW when a lower device is enslaved, matching the
existing LRO handling.

This is best effort because GRO may be re-enabled and some devices cannot
disable GRO_HW. The forward-entry segmentation fix handles plain,
trailer-free GSO skbs that still arrive; device-specific fixed-on GRO_HW
output is outside this guarantee.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Cc: stable@vger.kernel.org
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 15 +++++++++++++++
 net/core/dev_api.c        | 21 +++++++++++++++++++++
 net/hsr/hsr_slave.c       |  5 +++++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..eba2c26a49ba 100644
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
index 5933c5dab09e..f20d5ab0cf72 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1840,6 +1840,21 @@ void netif_disable_lro(struct net_device *dev)
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
index 437947dd08ed..3ca2515ad048 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -269,6 +269,27 @@ void dev_disable_lro(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_disable_lro);
 
+/**
+ * dev_disable_gro() - disable Generic Receive Offload on a device
+ * @dev: device
+ *
+ * Best-effort disable of Generic Receive Offload (GRO) on a net
+ * device.  Must be called under RTNL.  This is needed if received
+ * packets may be forwarded to another interface.
+ *
+ * The disable is best-effort: a device with a fixed-on feature (for
+ * example GRO_HW on a virtio-net device negotiated without
+ * VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) keeps it enabled.  Callers that
+ * need a hard guarantee must inspect the resulting feature state.
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
index 01c73b4b50dd..bb2182a169a3 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -171,6 +171,11 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 		goto fail_rx_handler;
 	dev_disable_lro(dev);
 
+	/* GRO disabling is best-effort: fixed-on GRO_HW cannot be
+	 * forced off, and GRO may be re-enabled later via ethtool.
+	 */
+	dev_disable_gro(dev);
+
 	return 0;
 
 fail_rx_handler:
-- 
2.43.0

