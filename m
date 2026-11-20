Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218862;
	b=HqwYmG+TxGFiMbFwqUT5n69MxMCcB/NpTamXbV9yAke3LhFnq4ehFLZ3A1E3406INqHL
	 fMNsCb/Yk7o9xaEYjlMQoPnqTPfmNkXMCd44kwQ3YoNCMcVJ3OIL9F8KmlL4QuKehYPXv
	 xa0NpyIhekuXVTd2gdP0JTRjRLdQUrHuX+onUyeKHk6W8bhE6hs4D07otvnbX3GkpgYUY
	 ytHpO8qxXeFvPh00fZIOLVkgGwVyp78E442oS8T2J15bEYYVwW57F6oKreFpjJFk47Oq2
	 eXc6llsqX1tR4iStBed1/kI9wDmL0U7hO6t4033MQa4RHs9C2XIkDGCAjzo52AstYKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xJPZl5evGP8F6MuKELplPvTbH6ZVugBq2XkPlqpVuPc=;
	b=rFKKJJLcirvZU6YA0ry8We7DHJU9xZvmxJtz4eAUgtphtGEfhHe+S4e1EUNl8PMAnkRw
	 Huuj49bKEcg/wk2+8Dq8s6sSQTLmNquHWoa6G3YMNYH+q8WghgrHWSA+zSMdTw9A4ESjw
	 KRxlW6avSgiS++HwZ9ial3D6dSPLhralVFb6D7ZNv9gnMIjMfeOQk9jFPWEUJnAHXXvnm
	 I4M7Q7eSmrbbY9y/af06l+aLZADKI+QSVDseHL73WmB/wcZ7cQrGiyABO+t+FAYX6kwFG
	 Yv4hUC9lUexAXlcb60scCdsg2jbzIo1QsY8bKfZxuJjn4H1P46vwS8+fkqGF6Q1OUWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+ga714s;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EB606A68C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B7EB606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+ga714s
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so13322415e9.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795218858; x=1795823658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJPZl5evGP8F6MuKELplPvTbH6ZVugBq2XkPlqpVuPc=;
        b=C+ga714sQWcJdkw0Xpdg2OlXKFgsE8ih8EnKXfjHIv0+JuGV5xpCD2uDyzNanM9Bm8
         2yBgqByvdJNQYsQ2f4dULNyK4jgCwRB4kTTrzugaItKFVLNkEhhV9wRYhUX9VDGFntJB
         hl3R5h+10CFCz8QSO2aHex0Y/B3s6zAHBUYZ2QBE+jphNfredA2I2vfUU07hywqWC79Z
         bXm1tbuYqjLXo9FYW8gBtxuJNzmJBvLEF1LOGDcz2hOOcOeYOWhhrTjyGMnV8/qUn3An
         j4Ozf+n12qMFyCOW1aGBhZae/fD97XB1N4cYsX7tN90dVVWYSTFrTXIhrdXH9AWR2OZt
         hJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795218858; x=1795823658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJPZl5evGP8F6MuKELplPvTbH6ZVugBq2XkPlqpVuPc=;
        b=0hPMl2hAxNjj9gM/cnjLJal9Jjy6vGuNtDqtsekS0kDad81dYboLrzj3iNqOq7yK/H
         A1/tr82Ir4G/MMATq78/isCCKsGh35phhJZbvcLVYfjb71c4oZM1uedhX/g6ecclOCeI
         L09l18Flqyq4LllUc1dH8UKFc1dNfyRyxlfKrlEo4DroRcopVDN6ChuK/A+f7dC30xsX
         ysasfQaf07uuBLD3L55oOlzDIv7KiDX0dI8QhFKeCBbHZacpOGehYeMJnfSN2j937OSJ
         2q8oBrmMVSoaiPvN5j5tGVglCbGAtRKF8X4eZopdbzwIkLVvNw7UBCmmFrtZdQdfUF96
         dyZw==
X-Forwarded-Encrypted: i=1; AL+hErFIrTjlP7MWdzQZItHvH836sNn69ZuTBPFN07n1MU47U7SedMXHaLzvWmRsP06ysvRa0a31PEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YaXBRnjZtusJEFRSBxxAkRiu5G9NvwOUlRnzgdXXJbQw7dlM/
	B8ONnRGsLGyrfhQkj6v94MLNEETN3t47sc53Osfh57hwpWgNrKYGluc=
X-Gm-Gg: AYBFou2MoqM1hGGTEVg5O+MH7lHsC+YdrAeI3gYU8rlZ5Pc2h3+4+3yH056uARqOEhR
	jr7yUbc32Yjwvxgg6jKiCX9Dh1NPsIAXQ+mJN53RLDaM5mJMuDOXplDyzR5oe0U+E9+Ycy53VvU
	GHIL0bwGNwDqXQ7BqJdoUKRQ9fy6s6WZWRUQmPPyi/XRAuZaoIsHx+0L8t47nwgsxOoIHOHOCfm
	vVbCQsB+jhwv3AXoj2J78lJQhh19mBQbdqQEsStzaby0KX8hhLSgmDywhptJnq8QNDd8vOhPN3h
	Xu9OCtVTsVfYhRTH2gNn0bvaKtugwtPKlnPyjv4jDKwCS7v3oNk8wO+KJXvklcYVSJQ8H2mAAWK
	WYAyy5Mr6WaTLdhX+wAW0mfk+QwjydjnmheP+v2TiO1iNC0aEquNqvgtC/8sIMZ8q8h4MUtrGc8
	KlFvrsH1/H8vedkfJKpa4fAdCQtiVN0AMny3k8qRz55NX24L/mJZ3+tsSriQpgqdFxCZhAD0VjE
	cyvJalEqVzZpczmmOCCclqpHcQMCVvV7R65UVlt0CLX2/qBXvgYfKSxShb1ZQvHjLWtdfE+jjI8
	BQnOgta4keqnW1I=
X-Received: by 2002:a05:600c:3547:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4bb888098bfmr104741775e9.11.1795218857727;
        Fri, 20 Nov 2026 15:54:17 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm29426445e9.2.2026.11.20.15.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:54:17 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 net 2/2] net/ncsi: defer free of removed list entries to an RCU grace period
Date: Fri, 20 Nov 2026 23:54:07 +0000
Message-ID: <20261120235407.1911365-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120235407.1911365-1-tristmd@gmail.com>
References: <20261120235407.1911365-1-tristmd@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

ncsi_remove_channel(), ncsi_remove_package() and ncsi_unregister_dev()
each call list_del_rcu() and then immediately kfree() the entry.
Concurrent RCU readers that found the entry before the removal can
still dereference the freed object.

ncsi_remove_channel() also kfree()s the channel filter buffers
(mac_filter.addrs, vlan_filter.vids) while the channel is still on
the list.  An unprivileged NCSI_CMD_PKG_INFO caller walking
ncsi_write_channel_info() can follow vlan_filter.vids into freed
memory.

Additionally, ncsi_unregister_dev() frees all packages and channels
before calling disable_work_sync(), so the work function can run on
already-freed structures.

Add struct rcu_head to ncsi_channel and free channels through a
call_rcu() callback that releases the filter buffers and the channel
together, so the memory remains valid for the full RCU grace period.
Use kfree_rcu_mightsleep() for packages and the device structure
which have no sub-allocations accessed by RCU readers.  Move
disable_work_sync() before the package removal loop so the work
function is quiesced before any structures are unlinked.

Found by manual code inspection; not triggered at runtime.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ncsi/internal.h    |  1 +
 net/ncsi/ncsi-manage.c | 28 ++++++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 2c9d1f22c16a9..2cb1cf653164c 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -239,6 +239,7 @@ struct ncsi_channel {
 	} monitor;
 	struct list_head            node;
 	struct list_head            link;
+	struct rcu_head             rcu;
 };
 
 struct ncsi_package {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index ec7c0d8cf3d9f..d872351d40245 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -242,28 +242,33 @@ struct ncsi_channel *ncsi_add_channel(struct ncsi_package *np, unsigned char id)
 	return nc;
 }
 
+static void ncsi_channel_free_rcu(struct rcu_head *head)
+{
+	struct ncsi_channel *nc = container_of(head, struct ncsi_channel, rcu);
+
+	kfree(nc->mac_filter.addrs);
+	kfree(nc->vlan_filter.vids);
+	kfree(nc);
+}
+
 static void ncsi_remove_channel(struct ncsi_channel *nc)
 {
 	struct ncsi_package *np = nc->package;
 	unsigned long flags;
 
-	spin_lock_irqsave(&nc->lock, flags);
-
-	/* Release filters */
-	kfree(nc->mac_filter.addrs);
-	kfree(nc->vlan_filter.vids);
+	ncsi_stop_channel_monitor(nc);
 
+	spin_lock_irqsave(&nc->lock, flags);
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	spin_unlock_irqrestore(&nc->lock, flags);
-	ncsi_stop_channel_monitor(nc);
 
-	/* Remove and free channel */
+	/* Remove from list and defer free until after RCU grace period */
 	spin_lock_irqsave(&np->lock, flags);
 	list_del_rcu(&nc->node);
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	call_rcu(&nc->rcu, ncsi_channel_free_rcu);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +331,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu_mightsleep(np);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
@@ -1964,6 +1969,7 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	unsigned long flags;
 
 	dev_remove_pack(&ndp->ptype);
+	disable_work_sync(&ndp->work);
 
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
@@ -1972,8 +1978,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
-
-	kfree(ndp);
+	kfree_rcu_mightsleep(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.47.3

