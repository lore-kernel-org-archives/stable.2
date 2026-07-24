Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDF43CE63
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909585; cv=none; b=Y8Y63KrzKjTt62qd+I35eqXFhZOyF08ZXGHHhzEtY/dX+DtFV3Vb/fQcz1qBD3snubyhPCWgnDt/QYWCVMGhvtxvX7BdT+/PPpZjxEZFqsO43+/gxHxP+5CdNMZ3P+rTvN2YMZ4yDPGjZ1+Cvc5cGIJj2W+YpChnCapcxSvGmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909585; c=relaxed/simple;
	bh=LKbFUDhj3VWhwQaESnH2NVyncH+CR8IBlzH7bYjPfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIMu9PGC2Bxgw14AStIFSvUa+07g1Z7gmGfLl2uRo5QymlajNoYPa8ecFhEFW5DuX57v5TDy8iQtTsEUebZ4UUnx1hQSBY80OOe4RmdJPdslEpLDz5cBkoVlzPRi0eShXhc/OLYvZ/47XxJtGP0oEEIqgkabkMi1oRhS6AGT2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgx2Y+bE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgx2Y+bE"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495773ee3edso630315e9.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784909577; x=1785514377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g5QCk+t6gnqXj6DEKChexCyjlhSd215AVJ6Z8sL7eXs=;
        b=sgx2Y+bETIngYbB+KU9LklzffUhbsct07z/XF3f/xANDZQCdTxDRC9BOFhIDdjqIHK
         OPj0SfWwW8jgQYIN9aS43y+OZMwmV/HjibOICRkzOxFXvV80ot46bdyLLy5/79L2DeeS
         Edxn4G2zKcTp88DNABmGweRJNo6CSGwP2n2curwbP9tjaiqj0+L+slzJn7l/S1RAHtzJ
         Jp1ZHhGMCiqr8R+mP08g0ymDyzN8b2YTiS8fWdbdrgbE/U7C8dm7u74SoKayJ0kFP3bo
         GWhMi/GM23JG1cAEjgtc+KK4Oz00ntFfFZHl2EDDNDEDfsstaidgz/KUPXOaZPQEQPK1
         6XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909577; x=1785514377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g5QCk+t6gnqXj6DEKChexCyjlhSd215AVJ6Z8sL7eXs=;
        b=AGwjnK6zuNbSa7vaWvtMHeBLtIKo64LZa3fi6G8IdDpt8XuhMCxEjBiX6YfQe3Pgd7
         t+J0V8JNULvm5uOVzPJIjk3qyx2iESkeQz6bJ+MCevDfTCqWj+e8VI40S04CJDp5ytOC
         Pn0bk/QQBtLQ/Uj+/FTYFL7G7zf2aWdXONxQ/GFBE6YR1FeITqskcxdVVD5+4Es+mhL8
         MUJ2EowD2MceCVSHko52o9A8FkwjSi/FeaPz//TmDtPe9r9WtcnXxonjgDiX+MEwwI/m
         Wq4LtZw/IOaAnW35bPp1WRYO+apZhf1nk0IJPFX/I7XJMRQItQw8EC/pgNOdO/vRH5Sa
         kTUg==
X-Forwarded-Encrypted: i=1; AHgh+Rqzq1gEsruO977ZguTQf+/YITCTUnHZazYn5N6JbraZjdiZy+LiNl3LzcRCtoaX8XPJ5OeUrPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPv8oDcUKlbTdMQfOeo71ilMlEbhlsCDs/8u2aJb0xtBvzO9Xr
	Ceb9Ww+wfOSEfmTyTk8hv0mG/OpTF/f43IQAbu9gIraIROpKfDo9qeL5
X-Gm-Gg: AR+sD10X1hTAsZT7HXkMaIuV5WSjRBWZtqBvoiS+aB4lQNzBfj2IL812RuqSGKSrVVQ
	ZaNbUj8cB1hlOB0zDgTttCFv5M7E5XLxDoLxT5S8rm0otK4GNlgj8jPrTP4NuSLXc177xRFke+u
	LtoZspXpTSeowt1eHCdn76MdJC6NCjF//F+9/opaUXmy9mxdDDVMqstlfb4oTYTHRbcHDa6LV8t
	kCZiXjm/auosjDurcLL7SDx3jPdxA+QsqezEtoV52IPueLoyGNL3tREhB0bvyIFgIGuMzY7/fQR
	IDc6f7XtHZYITA/puQ+AAa1U4LTXnjqYmpx6WUc+lPqRpIJs+8mMxscn1XF3xXpqCs15OfivNui
	lgBZsirUAfRaUsxMeH2ZCtyPlqgdWUE85FOaoRnrEZCasqoLMbBBfHk+ckeex5Q9mxycU7FtGkO
	kKQH8nYRGAFf0ORxpmV95wlx5omHTPf7ndeXqpzMJknXMJQCHdA9Ay8CGPWIy4PzFshNmLtFlzg
	nbvqoKPMqPEyIvSUNMgodHZl/z3VqM/M4IuA08=
X-Received: by 2002:a05:600c:190b:b0:495:4840:c6b with SMTP id 5b1f17b1804b1-4957a7e9131mr33384715e9.1.1784909576912;
        Fri, 24 Jul 2026 09:12:56 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-181-161-038.77.181.pool.telefonica.de. [77.181.161.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm40969655e9.1.2026.07.24.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:12:56 -0700 (PDT)
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
	Xin Xie <xiexinet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Fri, 24 Jul 2026 18:12:50 +0200
Message-ID: <20260724161253.79-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724161253.79-1-xiexinet@gmail.com>
References: <20260724161253.79-1-xiexinet@gmail.com>
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
index 9981d637f8b..eba2c26a49b 100644
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
index 5933c5dab09..a6cf2adc862 100644
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
index 437947dd08e..02fb2162951 100644
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
index d9af9e65f72..cefbbfbd5ef 100644
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

