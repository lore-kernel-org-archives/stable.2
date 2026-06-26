Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49503F7AB2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490328; cv=none; b=jFGc32NYQ8Mibke5Jm46Oqj4CNR1nRV8UK5T9/aztuiqy/dIig1TC35plx9mSOgjmL43wIiSH3n+Z6vCbs3wOX8dDt4ic2d7X98iP6uSvTcxgg4klLvOLmMrowldLpQzfK22qXKjCfgb6uVI9g+xWu/sHPQPZFfcHwrwlofiVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490328; c=relaxed/simple;
	bh=k44MaVpNG1+lGixrY04cGEMGkYBOurPVbAPyVk3hKSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoHLVipX++iP0zUv6BGsb7It2oXSsMnnkNN8WrXtBqw1KYYKGwPrO/jSuZMRt3gorild4vht+wb8dj/ZHSSa0ZT2Bm6aNp9nzjH0GPr5eh14GDsx/OJPQY8Zf08FFJptpDc+yqfB48JwWPZPhyhpNxgDWE7n3WxkLRpVt5iNU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=TH9A1F27; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="TH9A1F27"
Received: by dvalin.narfation.org (Postfix) id 595932045E;
	Fri, 26 Jun 2026 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G53tFD/kYCn/VPqL8qFGsbaTzSiy7my/YAHjGSApYYw=;
	b=TH9A1F279qF9eGCd5jF7pYyrrNPQZr2coN0eHvURmZGNG9qe3qQGmhHUl854s5IsIUvf+L
	P8Aj4EAJh6TQqrzhaQL0hMku7+V4D1GbMDyB8ipnN/+ZchWosqEbcjUbAU/6BdMZvqsk55
	aHh+liLLAcf2z0raM4bVEkxZhteT91Q=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 21/25] batman-adv: tt: don't merge change entries with different VIDs
Date: Fri, 26 Jun 2026 18:11:50 +0200
Message-ID: <20260626161154.124562-22-sven@narfation.org>
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

commit f08e06c2d5c3e2434e7c773f2213f4a7dce6bc1e upstream.

batadv_tt_local_event() merges/cancels events for the same client which
would conflict or be duplicates. The matching of the queued events only
compares the MAC address - the VLAN ID stored in each event is ignored.

If a MAC would now appear on multiple VID, the two ADD change events (for
VID 1 and VID 2) would be merged to a single vid event. The remote can
therefore not calculate the correct TT table and desync. A full translation
table exchange is required to recover from this state.

A check of VID is therefore necessary to avoid such wrong merges/cancels.

Cc: stable@kernel.org
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7041cd69e2007..69a42bc3fa02e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -485,6 +485,9 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
+		if (entry->change.vid != tt_change_node->change.vid)
+			continue;
+
 		/* DEL+ADD in the same orig interval have no effect and can be
 		 * removed to avoid silly behaviour on the receiver side. The
 		 * other way around (ADD+DEL) can happen in case of roaming of
-- 
2.47.3

