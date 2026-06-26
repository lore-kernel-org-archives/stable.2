Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A223FADE5
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490326; cv=none; b=OSmArKjxNdWMUDUNtb/xIl93MKaUXhmA8RiDVpulKeD++a/TFLSk9uTV3vTELSC1KU5xo11pjBJySwsTj7Yxzqr9pBKk5nvvT/0sGBwWXMUb3pHf7GNEr6VX6vF+KEoPsvBagin8eJaFJSI/Y5cP3xr8J+7c1FouUChCpMi6GMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490326; c=relaxed/simple;
	bh=rnz2zYpLVsGL6xJOaxRVd40K8qrJK+5XhZmORCe8U24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQy2HjrlkqelIecpm2Kt6JJ8jp23NfrI4jY2/WLnI76QxI13/dUwkf1VgmMCfMPCau2yeiGrrhK/AZYCZVaXNBSPzjsCq2hDH/IuBMht8U/dXD8232VlwKFB/JmA1qtpeUVkV5hG7C/BfwR6R/uvyfs4F//uzJbEFiHNbyWDrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=uBtITi7Y; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="uBtITi7Y"
Received: by dvalin.narfation.org (Postfix) id 084DA203D3;
	Fri, 26 Jun 2026 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwW0svO/v1tz1TarQp+TEvI4xGw6tlSn7FbNjRYcM4k=;
	b=uBtITi7YZgG2mVBmGsp84CzNBJaX/aJ+EBJTRX/+ozuH4W9/Jvvtc2HN6+Y/axS5pHwiEX
	b4lnPhJDPGWQCoEqFvyv6s1xnq5JDC94MSvr3Vt8+s8Qk7OwARG0iol96kZrIn+z2cg3N9
	UYS28y1I8YA8OjhSe89x+X4irBFm/T4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 18/25] batman-adv: tp_meter: annotate last_recv_time access with READ/WRITE_ONCE
Date: Fri, 26 Jun 2026 18:11:47 +0200
Message-ID: <20260626161154.124562-19-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161154.124562-1-sven@narfation.org>
References: <20260626161154.124562-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit d67c728f07fca2ee6ffdc6dd4421cf2e8691f4d1 upstream.

The last_recv_time field for batadv_tp_receiver tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 638dd438a6c05..b882919a868ca 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1183,7 +1183,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	bat_priv = tp_vars->bat_priv;
 
 	/* if there is recent activity rearm the timer */
-	if (!batadv_has_timed_out(tp_vars->last_recv_time,
+	if (!batadv_has_timed_out(READ_ONCE(tp_vars->last_recv_time),
 				  BATADV_TP_RECV_TIMEOUT)) {
 		/* reset the receiver shutdown timer */
 		batadv_tp_reset_receiver_timer(tp_vars);
@@ -1424,7 +1424,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
 					      icmp->session, BATADV_TP_RECEIVER);
 	if (tp_vars) {
-		tp_vars->last_recv_time = jiffies;
+		WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 		goto out_unlock;
 	}
 
@@ -1455,7 +1455,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	kref_get(&tp_vars->refcount);
 	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
 
-	tp_vars->last_recv_time = jiffies;
+	WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 
 	kref_get(&tp_vars->refcount);
 	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
@@ -1506,7 +1506,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 			goto out;
 		}
 
-		tp_vars->last_recv_time = jiffies;
+		WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 	}
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
-- 
2.47.3

