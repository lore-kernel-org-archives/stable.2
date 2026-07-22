Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEC3EDAC1
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739381; cv=none; b=F4WTEwfPKcgmBcKXyUluzEVRFrmNiljK7ZRFeOg4lRX4iPk0DFg+aSM3rDnISaK6xWa1e7lnx6RmadJJs+Uqfl+J6BgxZIhuWepWQ2p+HvBLwthzUgzePrlFj44tSyTh6ic5qu4XvNqMNrjvmvfAsbMXOdHl72rB6q4AsHA/hxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739381; c=relaxed/simple;
	bh=T6VI/MjUMTWjR0YmJzrLiiKf7zo+1Zk/2lAOGfSsHHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCJW0GrcL6XNJpa/vLmMAW0p+TaYow6pLXiav35ijFh9I0bgWzUHloHVZpXHb3DE//kkMXxEyxstRAIuC2zpF/rKxaIkK7ePewtmzJFNWdh0OzajZnkAe6iZeCHEifH7NOiG/rh+9zSLjpgYmf0EQsLcNkVvJGWjq0iN4hVfRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbW8SoJY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbW8SoJY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so84675e9.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784739377; x=1785344177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRQ5TWPONEvJdayuRFKl7W3Z0rghnTrzVVZ4y0zRgw0=;
        b=CbW8SoJYwIv2U3iTinGx0XjtJKpKPuag9lE3wIo7lGYo2vb3F2GJhutN5YGO4q7lOQ
         AeKJi9t+pXAyRhqWBxLobmGIvkQTtOwyvC0ZAlAAo/flRqB/ipBZBJCE4wTsLG1Rr3cG
         w+Q7hu5Tojxbx8ktzeo90D8NLFcdmib3uuVmVa/JXO9rB+QWfnyTPiiAtssPlUdL1yXL
         3WnSGyf1vjTKxDB7qgSsp+VDiQW8vsADy0DqvblV4FFPPAtvsPUiJ48KaH6LMEJoSw/D
         ibC0TNeB6NrKzmdTR465lGShfhjMGtxBCSMrDaoc6UbxjTX2BqH4JjidznBn0iegMifj
         pmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739377; x=1785344177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRQ5TWPONEvJdayuRFKl7W3Z0rghnTrzVVZ4y0zRgw0=;
        b=PZztfW0c8H1WsjwWlc4XKlFPLeF1hgF2wosGu1EBuuDY2s118ZJkq3ug3SeUWh68sr
         77iboCkEIdkfPIXVLdc2pcg2cUGZfOWfhvM/nOnryV5ozMBKv78+AigU4DUz6rltXeol
         iP/arbENLl2xpmZymV1hXSzLmicxFDaw5ByaNPPWsje+58pex5nQ+m0bpM1lpL3jTUfa
         sRykRtD0YBjSr2iMKKAmuVu7CJ/UVwbuu5mtXV/9+hYI3KQYpwOZUS05ltgY8EYKChju
         f9XpU1co+IuxMM0rZVy4wep06Ssna0TlWxBh+gg29HFdkesQHd7E0gkxOiix2Vlt/IK8
         hZog==
X-Forwarded-Encrypted: i=1; AHgh+RoYXVWgv6SbfQSOTjrBmpziU5/g7G2E5Rumoy4+1h4zAARF+8JhIJiq3GZ9WtHqQnEZB7QpFX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGve2Wf0uo/tJuTR70Dssn6GstCSHSQ2PQltYpNc2HUzJ3mG4
	ihobQpWuiYNuJhX+0YB0CK1SdbfE8403a4fKVO47nYMWqnBwlw87GGKt
X-Gm-Gg: AR+sD12B+UodbdTLZNtWuIdagfbi2e72YOQzLjQyhQ7phFKj9CrF+8P6eSmjTo2tawI
	rDS4A2KucUBTTjR5nApO/KBm8l8qoBp3BLzvpOsJrdELaEewTC0gNa+PpMSF8EgLQYm+Jn78/xQ
	IlL3VEfgtDlQW/qmhF3qH8/d6xYSr0k8pnHz5i7kf4OJwJifZlpUpxOEl9VtB5MeNHT1jh9TqFo
	5Mntw/J4XMHncWCadD8Xt0KfFMDqTPcFQskzYifsCeEnzqG/kZOEi4adFtAcl+FH/Y5TIDX/Bc3
	tfrkmU6fy4rsgFb3sIJ2wy05WqNz+jKgzu9CtNQyd5ani70/X0dKWMYl3pbWWxBt4x2msATFmpC
	7fognFcDzI43VdlqF0Sea5jd507MCx8hvDVvPNbzqgMdMy/dB4G2N9B4dg7Jo+62B6Q0x0vNN9u
	3VH/t/iBMuwPRdrZrODs5K+cKUYecDOp2d5zfwedkqMTI2ALyQSdVaSLHxAD/mwc1KLAQWaJGO3
	Mk2qlDmpyiDYyP+DUUFrxYbk8G9mF9fn2JU/Q==
X-Received: by 2002:a05:600c:474c:b0:495:6f6a:f48b with SMTP id 5b1f17b1804b1-4956f6af50dmr15751855e9.5.1784739377292;
        Wed, 22 Jul 2026 09:56:17 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-078-051-150-230.78.51.pool.telefonica.de. [78.51.150.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm7288629f8f.22.2026.07.22.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:56:16 -0700 (PDT)
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
Date: Wed, 22 Jul 2026 18:56:11 +0200
Message-ID: <20260722165614.124-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722165614.124-1-xiexinet@gmail.com>
References: <20260722165614.124-1-xiexinet@gmail.com>
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

