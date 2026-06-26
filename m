Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA33F9F22
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490277; cv=none; b=imWBMhImB6tgMPlVzGGJq4JtR2L2l772HNmHGIynGiHgNlb27udjfXdolzLKROYVojrQZ0Doa0CwX0wo1aofKWOKfoMGuaVR88vjZiCkcAIyzjqYzvp01BL8yqg+OwGWJJqt5UDxsjX/HFwEK4H2x1B2kxv4Tjbh46WzYxtO0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490277; c=relaxed/simple;
	bh=7cDHcjvEzzahJsAcUvwRsY50rJndjNaeBCe9htmCCxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYSbhbHO8WlfuxtCdf0wXb2p2rPEdyIfYfkj2aHata1UnQ7PrVg/7Lxyov/Afv2gXPiZ6kV3cH1S6/1A0QvHxtO32ssEFMoimAOKmpUXgbnM1Rk0DyV9FpEztp+uQPy/jQMaYdumlohiQ/LK2JU4lkmPApwTYwikGxex4b1160k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=XMj6P1rX; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="XMj6P1rX"
Received: by dvalin.narfation.org (Postfix) id D40F720019;
	Fri, 26 Jun 2026 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59X/qDUjvWeFefwAIi9KRk+afTdTJTjPsonVPWd7erg=;
	b=XMj6P1rXj/YWf3odUVC+SvVMhRSdtHPzjjP+MEzHfaaHEjgBLxjVeFRBZzFUWWZwCPLxm7
	n3B+WO3agCEQM3muhtIa7cno9ZShKs10p1+RvL8qbPbjtdkTOSeYenrADzBW/D+1maV+zG
	VMFH0Df9Tkbau+AtjmmVggVciOx/61k=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 21/25] batman-adv: tt: don't merge change entries with different VIDs
Date: Fri, 26 Jun 2026 18:11:00 +0200
Message-ID: <20260626161105.124113-22-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161105.124113-1-sven@narfation.org>
References: <20260626161105.124113-1-sven@narfation.org>
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
index 8ab1257bade04..4bc73aceeb89f 100644
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

