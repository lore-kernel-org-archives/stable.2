Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C2309F00
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490217; cv=none; b=O652kfBjKoDl+AVUoHsmwnHmKlFecwWlBzzl9fQS6S1QQIq8VFNVq4galWRwMVVJpaXaxx52XmqJ+Y3I/FhY5pJTURp4zoipVradIN6mEcErX53e1mgQCgH8PkGNEBpTNuRDuGYFi7JsczcwVSvvwmzWQ8p3LSFLrFEFUEpQbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490217; c=relaxed/simple;
	bh=qfGB8HsKpO2u9WqxVUfgY+IS8q/shw7An5DbVN3Is4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erBDQAdP+C7YiWxmOtzrm//wKEjewzaHYw0CYHwxTY6f8CxheQBSjTinM9akC0LrTbUm8z0a/YQn7v5svcCflaybUPXN/S/+JM2Nikqwewfxklor13PK/M7QxKi2UkznX76Z7W96+Imenl42K9M5p/0DNRc6JczyqSRk3I387UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=MtUBZM5B; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="MtUBZM5B"
Received: by dvalin.narfation.org (Postfix) id 6291120595;
	Fri, 26 Jun 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VZ27Sb8ASbqR6vpFqs80jCKvkE3UJQ0X749XV6KbbY=;
	b=MtUBZM5BQkwDYkchqS0CazkqNzF2tIzJGBW+JP/DMGolAMi9IgWAmM/N4q+vidZ+kX+mbh
	8Hh5zSfTDoA9KKUC/1g+Ji3pUpgVrfBVFzYc2F0Pm+U/+kPmQ7vKCH58DW/P17Q/Wm2ppt
	Rgs/E6/I+09TIbP78p1JdygaLl+MFrg=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 14/23] batman-adv: v: prevent OGM aggregation on disabled hardif
Date: Fri, 26 Jun 2026 18:09:43 +0200
Message-ID: <20260626160952.123713-15-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit d11c00b95b2a3b3934007fc003dccc6fdcc061ad upstream.

When an interface gets disabled, the worker is correctly disabled by
batadv_hardif_disable_interface() -> ... -> batadv_v_ogm_iface_disable().
In this process, the skb aggr_list is also freed.

But batadv_v_ogm_send_meshif() can still queue new skbs (via
batadv_v_ogm_queue_on_if()) to the aggr_list. This will only stop after all
cores can no longer find the RCU protected list of hard interfaces. These
queued skbs will never be freed or consumed by batadv_v_ogm_aggr_work.

The batadv_v_ogm_iface_disable() function must block
batadv_v_ogm_queue_on_if() to avoid leak of skbs.

Cc: stable@kernel.org
Fixes: f89255a02f1d ("batman-adv: BATMAN_V: introduce per hard-iface OGMv2 queues")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c     |  1 +
 net/batman-adv/bat_v_ogm.c | 12 ++++++++++++
 net/batman-adv/types.h     |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 6dc39fc0350e6..7b9bc8a4bd48f 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1084,6 +1084,7 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 
 	hard_iface->bat_v.aggr_len = 0;
 	skb_queue_head_init(&hard_iface->bat_v.aggr_list);
+	hard_iface->bat_v.aggr_list_enabled = false;
 	INIT_DELAYED_WORK(&hard_iface->bat_v.aggr_wq,
 			  batadv_v_ogm_aggr_work);
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 939aa4b303ad9..12de9b44064dd 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -255,11 +255,18 @@ static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
 	}
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	if (!hard_iface->bat_v.aggr_list_enabled) {
+		kfree_skb(skb);
+		goto unlock;
+	}
+
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
 		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
+
+unlock:
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 }
 
@@ -422,6 +429,10 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
+	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	hard_iface->bat_v.aggr_list_enabled = true;
+	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
+
 	batadv_v_ogm_start_queue_timer(hard_iface);
 	batadv_v_ogm_start_timer(bat_priv);
 
@@ -437,6 +448,7 @@ void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 	cancel_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	hard_iface->bat_v.aggr_list_enabled = false;
 	batadv_v_ogm_aggr_list_free(hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 238d9824c2d62..28f239421f74a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -131,6 +131,12 @@ struct batadv_hard_iface_bat_v {
 	/** @aggr_list: queue for to be aggregated OGM packets */
 	struct sk_buff_head aggr_list;
 
+	/**
+	 * @aggr_list_enabled: aggr_list is active and new skbs can be
+	 * enqueued. Protected by aggr_list.lock after initialization
+	 */
+	bool aggr_list_enabled:1;
+
 	/** @aggr_len: size of the OGM aggregate (excluding ethernet header) */
 	unsigned int aggr_len;
 
-- 
2.47.3

