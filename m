Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970C409633;
	Wed,  8 Jul 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502329; cv=none; b=NAoWXWF0lAGh1MAx2MTvvoQT8XfwWXSiT4vFIG4kmtBdd3NdCHI6/z7fQFaeVuZ3rNo+gKmDjZjABa+YLTACwLFcD/DGKeUfzqjWU2LJ6+m6ubtNJ1T3bzmHeSGGKbSmmar/0NOwBsfJtndyLaJm/fvh8myQZwsnm4EgcaA6+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502329; c=relaxed/simple;
	bh=08k4P5TqooP9egcRbFF9BucqHCQgKWzFTGoux7doqNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shMEVA17BW70j73Yq4KZAI6g3uOKM74UsblPpx16t9G6KHC9Y0x9Lg8JIDy6JE8Gl1IoTc0IadkVkBPDTCFXqZiYj2V5twiU+USQvPKSSTAweONgaCFDUCohXWqZokThC/WiXgKd+86lMeGuiwfveVZAdkfpxuT8a+WrI2AOJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=muBAzhwl; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="muBAzhwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U8UISu70rMYz9drDEm9dQtE1+U1aVr9Myb/+AxDp0w=;
	b=muBAzhwl74D3W/iPlVV2Ovb/bVoaPw6ZLpszOTHLeFfvbl0ZscfwKvPsXFEOoF5wThik4V
	980JR9Mupm0Gbo0JHsyZ3FFmdX6i9ASXihka8cL0OQUO1v4A8RH4Ys+9iNmNQ3bzFURcXm
	Lhwjnt7T8IyI2XsZ9JT0LC0w7Vhr+qbOl2epPrmkeJvKiZffS95abLFD/1HWbdnr5ledHM
	BllMMsFgCKccIpKsvdwIe4ThjGxMVMRq7UVdagPc/ozINuNx3ecMfI+7ETqGWhwCHzC8ll
	5K43jF0siA5VcHVAwzhagDsEg9yg5kG9dSvLkvlBoTywR+neC1X1GvPcEEcijg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 9/9] batman-adv: dat: fix tie-break for candidate selection
Date: Wed,  8 Jul 2026 11:18:21 +0200
Message-ID: <20260708091821.314516-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The original version of the candidate selection for DAT attempted to
compare both candidate and max_orig_node to identify which has the smaller
MAC address. This comparison is required as tie-break when a hash collision
happened.

But the used function returned 0 when the function was not equal and a
non-zero value when it was equal. As result, the actually selected
node was dependent on the order of entries in the orig_hash and not
actually on the mac addresses. The last originator in the hash collision
would always win.

To have a proper ordering, it must diff the actual MAC address bytes and
reject the candidate when the diff is not smaller than 0.

Cc: stable@vger.kernel.org
Fixes: 785ea1144182 ("batman-adv: Distributed ARP Table - create DHT helper functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index c40c9e02391be..a6fe4820f65b9 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -546,7 +546,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	 * the one with the lowest address
 	 */
 	if (tmp_max == max && max_orig_node &&
-	    batadv_compare_eth(candidate->orig, max_orig_node->orig))
+	    memcmp(candidate->orig, max_orig_node->orig, ETH_ALEN) >= 0)
 		goto out;
 
 	ret = true;
-- 
2.47.3

