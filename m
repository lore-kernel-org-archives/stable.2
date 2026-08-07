Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FC286D70
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111679; cv=none; b=D4cPrjHvvnLwdXefdEySq/Ibuca0tuuTUk2QjddhERPPRFw5LxBaqn1ikWI3NbnGS5/pBf1OrjVCS0QspHmXEJkj4H2LQqXPQ3I6ODzamgtzrQ+Uhd57KXvmA7mkA5EUPoNw9FhrWlZDZTIfXH9nBu5jOf/XINi2MgzfGkA4hXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111679; c=relaxed/simple;
	bh=3bCtOifuFc7J3Rr7UUrsOND5iV/KohhwCXR0G0U50ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRBhBsg1mWOnIlKWbQFVQ2c1GOqHvmEBwf6XPEOF4T/STLzMugmiXuKSKXglpkM5v9U1YPQPF+7C6XFS087c7FkG91lhnKMaRRu+FHjUIecpVBjtVyx/SmidZPdaar/6z55J+Xkx4zsVd3g1OzlHtbYDzwX6LgOPyGtIGoJlPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUav/tCV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUav/tCV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4731f5ffa74so284152f8f.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786111675; x=1786716475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VdpvcqvwrdqUs5sE0SeDLQ9ugUxBd1IjKy13SBkkSv8=;
        b=HUav/tCV7ilSX34LG5upW1qkX86YqLA3UUCSLMkpafEFwO0pkqcccScP6jl993A806
         teYcaYzOhSC5wuQdMpXmvLpNBCGOIEiZnZzn9yQOog4Wqf46c8X+sTjsG6DigAPOoSMS
         oLfVBFafg1uia5m8t7sod8l7yVsJuJtIMgxtasYidQpUyZ4inQdnfXXJmy08XQC4Cl5W
         lUud1bh4vy1cOY4GTBFcp9LPH2vO155CkYTa+wfDO0alFrGNWtaVwARnpd09zNbpwDcS
         H8zbaQBUSy5YlWnKNBR2dNAGURqO2eR5BN6sjGNKwhpj1h3U6bgNxLs3R+IcU6corNAM
         GTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111675; x=1786716475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VdpvcqvwrdqUs5sE0SeDLQ9ugUxBd1IjKy13SBkkSv8=;
        b=MVyyufGWYHAEQtS5yG04tbCsfLU+SQhOqwMTATNsH/0y2gS4D0X2DDCTp9s6jDPJ/d
         fZ7HroItV2pu+GlZFGwlsiK+aJyBAjWhhqG4ZYce6nK2FvCsVHboFcWIoendTzpyoloA
         c1edqPlqZ0wusTiIQlbZF6JU/W9JZcFh+IgO/4lUkv2foOD4evOtxdZJkpZIPJgCuE4h
         /iaui9FreJz9czeQRXeH5Mei0uTwgWAZGstx29PObGYMPgpUZSZpW6+/kagqjDUtLRaz
         6/soUVRzH9sc0t5itcYMrYSZiC+pI6Ncww50+Goc8BdWesdVrJNY67S1MLE5wlifaBgB
         g7vA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3fFzqOF4hP38cFNKHT0aV5jfZFzGFxzgbnk2deKiAQllCPEmFD59A5LNr7BFnPPgkAGQ0RIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42GEbBEPKBBcmAwJiN1jA0R/KnNTW1Q7UDHnTDpeZbycTjXdX
	OdMO2HfXT47P6MnLYqVpW58fCeJ1/1b3VyNUTSaI6oGbwE9EVnM6ekr/
X-Gm-Gg: AR+sD12WFJcyqqs906sytmKH9xAgWZiIKADf3gRnH4yjnvXx1ZbOAYVgQaVa1fKOAl9
	teBrCjExqnVtyd4ZTW65++exaOqlaGTOH5Fxs+j8e9WAZBvepikcdjISUY2Mi7MWG6q0piAEo51
	nFvdHj+6IyO4Py/9k7n+1VLyt86UoEwLx/HEi8fxrE61yrPFJXT5kMVtM1FKRENvWMThpqaiW4n
	pHEw06M9KJBK6EqzPxYHvhwTJ9l1q5ZEbpzluztcMW4vGHyQgWr74FIWMgZNP7MQ8cJDHN+1L06
	k3vSy7pZNVNQIR1lWZ3CdK1QwmSzkOtP3kDs9hPWSAqMl6ohVjMaq7YdvizE8ps3mOtGHVE/VD2
	fiG02GUzw9xEa+m/2IWc0bSQm4enkn2XbrcP5IAZsp6/w8xVeqsrtfgHbkgyY7FORn7r51n0fD9
	U0jTyaPd9A6G6cxMzHsrqH+JiTCt/xDLfKVQ5S7LYh1SkULZazazslgz6lKKzA7tBUnBn55iaL8
	5nJ8R1ya9DtqiG8rjjYj8tlms9tIOkjlJXoofTztQzKRJ5CrwtW4yeOmMaO/w5UW9ornXuCHMJd
	Q0bYOHvZAfn8PRzj9dkA4CbDXUAH5bISCw==
X-Received: by 2002:a5d:5f83:0:b0:47f:80e0:53bf with SMTP id ffacd0b85a97d-47fec5322c9mr17563757f8f.3.1786111675024;
        Fri, 07 Aug 2026 07:07:55 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-201-133.77.179.pool.telefonica.de. [77.179.201.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm5980064f8f.11.2026.08.07.07.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:07:54 -0700 (PDT)
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
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v5 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Fri,  7 Aug 2026 16:07:47 +0200
Message-ID: <20260807140751.1351-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807140751.1351-1-xiexinet@gmail.com>
References: <20260807140751.1351-1-xiexinet@gmail.com>
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
index 01c73b4b50dd..3cae70754bc4 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -171,6 +171,11 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 		goto fail_rx_handler;
 	dev_disable_lro(dev);
 
+	/* GRO disabling is best-effort: devices with fixed-on
+	 * GRO/GRO_HW cannot be forced off.
+	 */
+	dev_disable_gro(dev);
+
 	return 0;
 
 fail_rx_handler:
-- 
2.43.0

