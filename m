Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230E403144
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490361; cv=none; b=enTeyjMJiGF4RN2N8XELtWcLPqw2DmOhUe4l4ggmFc3l/VEigm191teBgknoKX9M1tUvCQAf4Z6qoRG4+ohTgor0MJRBqOtrqNSrZiAgcSscmaG2grH4O01T69zJ3nArSmrgz8i1erXEvxyVLm7GTmt09uKQEk+cOouYUJeGdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490361; c=relaxed/simple;
	bh=YQ4o3ZiDFg0uZY20GRh45Tc12zssa0lIOUEJywvb6cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClUz5X7hrVAOvGv7MOVbAml0mTP8P/c2uGgbGgirD7bCTeeVfkKu/IktkKZL1kVDcxAw67oEYH1Z0DqOvsq4SZ3F3kSbVn0ceti4QROwVxLQLURCmoCMFG2THWlPKAfoItcQ8xDcrmihbwHf0wGTOUS6SnOD/FPOFnQ7cpzGhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=l8VeT5wG; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="l8VeT5wG"
Received: by dvalin.narfation.org (Postfix) id 2F596203E0;
	Fri, 26 Jun 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjb3J3pnl0UoZYXnu+0oCd8temxV7aOFimp5ioF5e5U=;
	b=l8VeT5wGaAd+W2/5ek7yZxkOqArRd/2OgcZ5ijI94fNox+cpYH4yY0yxYk/txeAguV3pbZ
	7XG4AmNwKnDc1ryJJsTajSvTOuVDP35HQftjTqYgt6UvgDQY1kTztFXj3UERNjkxk/xUNc
	rRMMlPlP+bm92HFvxku/6I4nyOhzn5E=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 22/26] batman-adv: tt: don't merge change entries with different VIDs
Date: Fri, 26 Jun 2026 18:12:21 +0200
Message-ID: <20260626161225.124839-23-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161225.124839-1-sven@narfation.org>
References: <20260626161225.124839-1-sven@narfation.org>
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
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9f6e67771ffa8..acd8af4446671 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -446,6 +446,9 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
+		if (entry->change.vid != tt_change_node->change.vid)
+			continue;
+
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
 		if (del_op_requested != del_op_entry) {
 			/* DEL+ADD in the same orig interval have no effect and
-- 
2.47.3

