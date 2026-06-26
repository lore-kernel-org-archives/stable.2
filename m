Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495E37F737
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490217; cv=none; b=enChlMgSdjHrVwo6zlUEqdXu628pMqjJKU7mxlGKsSHkBS+x8N/9RFYDYJosLyWachjpIWk8kMGUce5SgQok6XLJfTrv4ZzbGrfyxL4mvxOhLIudd3KwComFNTNAYNtlwnJC2YWyZn9XC1ya8zf2++tSPVXfLQETNwXjEaZJ84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490217; c=relaxed/simple;
	bh=R3C83TC0/HNrA1RXBrskuBF7LaJAVf7Qw8lt61j1Cso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGOXBM3ps1stKWmq1EaHwib2XKjvKUzXyj1oikwconmGSIq0UBIuvsXBuIUqitvWw+oh5gINZTh/JEheqOxMAWgzkWLXjUz0tH5b9QFrca2mp48Q1Ics4F2gRedAUT22a91jMinRUugOnKTqTDfQPZIlMzrtwAu/Iyp7HyOGMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=XM59aRxX; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="XM59aRxX"
Received: by dvalin.narfation.org (Postfix) id 0BD7820551;
	Fri, 26 Jun 2026 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyfdZ0kUq/FvdR3nI2yX3ydB8CBgNAdnTHP0GEkhkcA=;
	b=XM59aRxXwruas1k3CUme2qSuYifU/afzKqYAsoIGiajUNAKZCrPT9efBcGyBXLYi5RfXfE
	7otinGQH8DphjiFgfzy8i86RcNoFh4VYjzW9AxCjNYUlcYxzJl20C2TFBkxQO+h8DpfSJE
	Xl0PWAIbB7MtgUWhk+wQuVLbQvEgW7Y=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 11/23] batman-adv: tp_meter: initialize last_recv_time during init
Date: Fri, 26 Jun 2026 18:09:40 +0200
Message-ID: <20260626160952.123713-12-sven@narfation.org>
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

commit 811cb00fa8cdc3f0a7f6eefc000a6888367c8c8f upstream.

The last_recv_time is the most important indicator for a receiver session
to figure out whether a session timed out or not. But this information was
only initialized after the session was added to the tp_receiver_list and
after the timer was started.

In the worst case, the timer (function) could have tried to access this
information before the actual initialization was reached. Like rest of the
variables of the tp_meter receiver session, this field has to be filled out
before any other (parallel running) context has the chance to access it.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index a015ff73812f5..ea5640242ddc2 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1412,8 +1412,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
 					      icmp->session, BATADV_TP_RECEIVER);
-	if (tp_vars)
+	if (tp_vars) {
+		tp_vars->last_recv_time = jiffies;
 		goto out_unlock;
+	}
 
 	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
@@ -1440,6 +1442,8 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	kref_get(&tp_vars->refcount);
 	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
 
+	tp_vars->last_recv_time = jiffies;
+
 	kref_get(&tp_vars->refcount);
 	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
 
@@ -1488,9 +1492,9 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 				   icmp->orig);
 			goto out;
 		}
-	}
 
-	tp_vars->last_recv_time = jiffies;
+		tp_vars->last_recv_time = jiffies;
+	}
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
-- 
2.47.3

