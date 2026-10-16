Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A54E50AA
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169121; cv=none; b=aa5rJgyPhB9ybU4vf2fZfldBYVj+t635jmJpIci7mnsdxqoCUgYUNuqZjSpKsmsuurxn5XTMbSLWBBCVmX0TtOMq4qiL7MBSkGjfRL4I7MeYg9szbqzPkLKyYWjFzd4k6/kB4qIdZI4NLqRwdhAUFu/qWeXiP5qsQQINRubCddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169121; c=relaxed/simple;
	bh=dQhR6bWMAE22RkUGJfmhCjhcV8QYLG43jGeH5+7dOb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WXkyEvJz4Nn8G+GgNebeGayIXIMgJqEANSocgqCQcjLLGxx59t4Ld9SQDaRQUs8R62AKxOiyBmOHFIkKQTCoe/IB33O1rAQz/YDV0WeQmH3x+pBJop6MUjnOYdsdxiMGkPbUNqLLfZ+PVvIGd7ylE5MnymmzSWTpqcFQmLNin9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=17jsBznu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="17jsBznu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BEDDC4E41267;
	Fri, 16 Oct 2026 16:45:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7BC8E6075D;
	Fri, 16 Oct 2026 16:45:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82CFC103281F4;
	Fri, 16 Oct 2026 18:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792169108; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zCfHJT2nJNftShFXyc0yDO6xYUrctPr6ToJXXu+mAGs=;
	b=17jsBznuMRomwhiPKsGVz6cK2MsD9pbkBCNCiqTKU3Pr872RZHmHUkKHaApzUi4NwxPwVD
	o6ryLtkzUMjFeMM8h7gYQILs/w4NEKxq3FTo97XQEs7+FxX9zrAItzPldWRJIc0Lh/5eAg
	4PAb2oKHVyWXDwBi8mcPbGRfcwk+gdbVXUgVbho8nTxOh5830xKOQZ3Xt/wDZRDtMCkyez
	a6hEj32XjEqfVgtj11DeV7sUyH8LBte7r9KGGdhc7bcoS1HkRB9p+bvT2/W9a7jg/e+TP1
	dvHtq7FPuZ5okx+u2/vH2++2UafRABih/KGGx1Z84V1KWfgWPr2rUgCYqEvk8w==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Fri, 16 Oct 2026 18:45:04 +0200
Subject: [PATCH 6.12.y] wifi: mac80211: defer link RX stats percpu free to
 RCU
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-cve-2026-68409-v1-1-41366ceabda4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBREr0Jm7SdtKU31KsSF1A98F2haIBrC3
 Sm4fDN5b0XiKJxwK1ZEXiTJe8ygLwXC8Bh7JnlmhlHGaaUdhYXpAHLeqiupqvb5sa2vLLL0idz
 J9ww2cKU25Q/3/57m9sVhOmrYth0Fr46HegAAAA==
X-Change-ID: 20261016-cve-2026-68409-03582614b834
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maoyi Xie <maoyixie.tju@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Kaixuan Li <kaixuan.li@ntu.edu.sg>, Johannes Berg <johannes.berg@intel.com>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792169105; l=2913;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=8xN9li6vOm3DOnzgruxVDNeqqL9twdhlrU5FZQ0u14s=;
 b=9Z5Cb5XNy/6IyIai2r+NklCrjk2XpIBdc0CO8NNn/bcWaAzeifCP11pkmyEbNS6rbwCxJ8YCH
 T2ch9V5pCzPB4oxtaRcHt9Izw4QkOz9qWocKYplA1UwxXDnvmFX4XrA
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit aa2eb62525188269cdd402a583b9a8ed94657ff0 ]

sta_remove_link() frees a removed MLO link's RX stats percpu buffer right
away, but defers only the link container to RCU:

	sta_info_free_link(&alloc->info);
	kfree_rcu(alloc, rcu_head);

The RX fast path reads link_sta under rcu_read_lock and writes the percpu
stats. A reader that resolved link_sta before the removal keeps the
pointer. The container stays alive from the kfree_rcu, so the read still
works. But the percpu block it points to is already freed. This needs
uses_rss. That is when pcpu_rx_stats exists.

The full STA teardown frees the deflink stats only after
synchronize_net(). The link removal path had no such barrier. The race is
hard to win in practice, but the free should still wait for RCU.

Free the link together with its data from a single RCU callback, so the
percpu block is reclaimed only after readers drain.

Fixes: c71420db653a ("wifi: mac80211: RCU-ify link STA pointers")
Link: https://lore.kernel.org/r/20260626080158.3589711-1-maoyixie.tju@gmail.com
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Link: https://patch.msgid.link/20260627083028.3826810-1-maoyixie.tju@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/mac80211/sta_info.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 122697fbd84b..40e939ae62f6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -355,6 +355,15 @@ static void sta_info_free_link(struct link_sta_info *link_sta)
 	free_percpu(link_sta->pcpu_rx_stats);
 }
 
+static void sta_link_free_rcu(struct rcu_head *head)
+{
+	struct sta_link_alloc *alloc =
+		container_of(head, struct sta_link_alloc, rcu_head);
+
+	sta_info_free_link(&alloc->info);
+	kfree(alloc);
+}
+
 static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 			    bool unhash)
 {
@@ -379,10 +388,8 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 	sta->sta.valid_links &= ~BIT(link_id);
 	RCU_INIT_POINTER(sta->link[link_id], NULL);
 	RCU_INIT_POINTER(sta->sta.link[link_id], NULL);
-	if (alloc) {
-		sta_info_free_link(&alloc->info);
-		kfree_rcu(alloc, rcu_head);
-	}
+	if (alloc)
+		call_rcu(&alloc->rcu_head, sta_link_free_rcu);
 
 	ieee80211_sta_recalc_aggregates(&sta->sta);
 }

---
base-commit: 7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e
change-id: 20261016-cve-2026-68409-03582614b834

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

