Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74A3FD955
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879028; cv=none; b=MPFztXpoKSy8UrYiRNiS7IisXbpjql18KejQLjUZ6gbliqn8w4lQ1BuZm58lrAHQ1EaRW/NLZrg3ZTNpJ41OlEdz6062YJkE4byqBft+1G3DP4VTMzpcrTxpkcIIuPHUbu+2TljBNldPLet4l1SWwngmI2T1oujx0Wad8gBVojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879028; c=relaxed/simple;
	bh=MEoqzNpXKXk8yl7o+JNwo1gEmPQgDW5rKLd5WiXbrMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q61g0qpZ0/E78wUTjkO7fl6hDrh9LEbNiHZ5pgIFjQRDO/DAkqnW6JX6TM0b56lJcSCHgXZyGIk+C8+ECjGxx1YNt+UfLZjnfJmg4XwC7dUGNKCO5r21XEYlyjvZUfMCADei05bwyMGAZjngTcv+t6aLqw3VarVRhQqNu48+uHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0zWO1lR; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0zWO1lR"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso6735772eec.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879019; x=1791483819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vO88UioSE3d4VQ/pH+4CdBfLiNkTmP6WB0IbPHbTxWo=;
        b=f0zWO1lRi94kOahkW6gfLulgXbtgi9gH6JGRfg6mhok+LUqrKs4CBNn06ukee1l8ix
         EvoJXPrj7h/Rg2ica5BsAKH/ZRG+t+sugp3hmNukZODuwmq54CQioXPDmrnfIbOGXgpB
         YZ0HybIAGaEBR+0AFxfn1E4LCWWQSCZaZfmGw94MzPV95QH6vfhfqSIWFpP4XR+pYpJC
         BlYxCNUopsm0LJcwffjDrzQ09desDdjzq8OfBZAVPoo7rduKJUxtXuGBKVtJ7j3H3dW/
         Uru1Re1xrRu9/7i1T7MfLKOFs97k9SQGihh0/Bg95l+LHo8PhngDg6BNoXOXWp6IqVYV
         PWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879019; x=1791483819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vO88UioSE3d4VQ/pH+4CdBfLiNkTmP6WB0IbPHbTxWo=;
        b=hv8OL+271WPZ8SDKj1DSngWDp03a189h2pRThNP9bHLcey++WbVnMw4CJElQaC7aLF
         GEXwZL/6nrXE7PH27Qcaalu7V7m1eVDfWIjI1L8WrFA8B/SopuWPyr3QGtDgvwz7NeHr
         2AkBnDEsAJd9VVvY5RwQf8YEsl/0jIWsNCj/d8Egc0289cuyFmXohVRKxo0QdVo8M1o4
         qX9cV4VWxLJf/JQWNaTHJ2mrwnVWn0F68k67T2NYH09XgpXEUcv0YLS4/bmY+zzSRCjW
         jZczSUbxYa/QWQfo9kOVq5gNwupUxn71Qcj5mSOflRuZZzp57z+mrLXWJyY/AohSNsU5
         LDOw==
X-Forwarded-Encrypted: i=1; AKwUvBwCWQUumMJFkQbgvnCGVWZXi8Jtn5IXoITwJJETc+93cERXslFOecR9bvY2nbFOW0guI1djlYE=@vger.kernel.org
X-Gm-Message-State: AFuF++n8Yqu9AH3OSpJ84p+/dZC8Q+GgH1dPe1jD4wuN+XMr6UDzieCR
	Hh3KSQLDy8qLJ/2LDJjhCJx0MwbmbHdwjqkQHfPpgbNV+qAycdQnBXXqIaHFwg==
X-Gm-Gg: AYBFou3/QR/O+xaF5zOeAgzgM2orWiN7BM5t5Pk7VPtNMlmj7zZzQZAhxoJREdxVCHy
	v0bWBkPR6ikLAyT0IP2PoYhHnzb2RhJ5e0kY/S9SxRCzHLE93HoEpxARay1WHZjuV5vr4OdrsWv
	ShPH9qmKUqsoAjluF7ipJUm6h+59Y9/f9bFJsTboNK5bCnkC4nHdzGb074w/NZI7DRJdAzO9ACz
	AogRgWlzwPBZxk8YN5W1MMg7tHf35WJQUaILfTAFnPivRLix1S4H5iZkiYdj+4KjPpowwlcYt9u
	fhaZRw0mU1Hoyz9zIUbf5Zc05E3Wa150jtHEATVGTOP5FWvYaF0c8B8xM41Q2cvDh1ry7T0aVxp
	Opc3uLBN5VwItasmjMZVnurLJYTSAtGpS18RarAa6AmanrdZSclRoUUjAdX6AbUOOzfAi/2cQaj
	qnQTsU8fJTKy5TKvbIsEWYwx4urv0UrFaS0QjoUPUOe1R4DtTWynUcQv89S6h7cdz4iGOVzbE7G
	OpyA6sss4oiWVDftC3XycOKm94eeRyOkA==
X-Received: by 2002:a05:7301:1401:b0:34b:c0ff:765a with SMTP id 5a478bee46e88-34f06673554mr104019eec.0.1790879018716;
        Thu, 01 Oct 2026 11:23:38 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f303e3sm189671eec.5.2026.10.01.11.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:23:38 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+2cf741c3005abc20@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: team: stop reusing skb after queue override
Date: Fri,  2 Oct 2026 02:23:25 +0800
Message-ID: <20261001182326.572045-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001182326.572045-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
 <20261001182326.572045-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A nonzero dev_queue_xmit() result does not return ownership of the skb.
When an override port's qdisc drops it, the queue override helper used to
try another port or the mode transmit op with the freed skb.

Return the handoff decision separately from transmit success. Select only
the first override port under RCU and stop after handing it the skb,
regardless of the lower transmit result. Keep the existing success and
drop accounting.

  BUG: KASAN: slab-use-after-free in sk_skb_reason_drop
  Write of size 4 by task poc/5040
  sk_skb_reason_drop (net/core/skbuff.c:1240)
  dev_kfree_skb_any_reason (net/core/dev.c:3470)
  ab_transmit (drivers/net/team/team_mode_activebackup.c:49)
  team_xmit (drivers/net/team/team_core.c:1849)
  __dev_direct_xmit (net/core/dev.c:4934)
  Freed by task 5040:
  __tcf_kfree_skb_list (net/sched/sch_generic.c:43)
  __dev_queue_xmit (net/core/dev.c:4831)
  team_xmit (drivers/net/team/team_core.c:1846)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Cc: stable@vger.kernel.org
Fixes: 8ff5105a2b9d ("team: add support for queue override by setting queue_id for port")
Reported-by: <co+2cf741c3005abc20@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/team/team_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc2..3bf7c80f1d8e5 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -820,7 +820,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -828,11 +829,11 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
 	if (!team->queue_override_enabled || !skb->queue_mapping)
 		return false;
 	qom_list = __team_get_qom_list(team, skb->queue_mapping);
-	list_for_each_entry_rcu(port, qom_list, qom_list) {
-		if (!team_dev_queue_xmit(team, port, skb))
-			return true;
-	}
-	return false;
+	port = list_first_or_null_rcu(qom_list, struct team_port, qom_list);
+	if (!port)
+		return false;
+	*tx_success = !team_dev_queue_xmit(team, port, skb);
+	return true;
 }
 
 static void __team_queue_override_port_del(struct team *team,
@@ -1864,8 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool tx_success;
 	unsigned int len = skb->len;
 
-	tx_success = team_queue_override_transmit(team, skb);
-	if (!tx_success)
+	if (!team_queue_override_transmit(team, skb, &tx_success))
 		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
-- 
2.55.0

