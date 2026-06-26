Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AF3FF88D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490336; cv=none; b=oSozP237LWvnxf0Je+SqYmuEspKYc1sgWkFxT1YIaVsg6/S/5PY7i3LEFjY+ZG8ayO5TzS55scuObjAQdNosjumYyXxs9t+RnoYkuTLWS6dy6v2MHijokRJ+3sEWcUr8R/dhEaIruwarAvamH6e02ze5bYhL1eiDcqcnJ8XgwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490336; c=relaxed/simple;
	bh=P4aBLeU9AprRE48reenrSHL3UHPgewTXL/5UVYPbv3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktLkrtJgK5YsuCTrah6E3P6Sqeb0xg0MKeUi/vPjwfHZZa87lhQDCKRVMXBnewKlevVw6XWM5R6q2pnu7aeU5HSaxGyYU4E07mqW5dR1aJUl0DFoPaND19ngBmczk3aPwRBnAPrXUwJ6eFx8cJfEz7BIC2Bxh6JLo3fwUkk5V8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=cgMzWUDY; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="cgMzWUDY"
Received: by dvalin.narfation.org (Postfix) id 8B19B203E0;
	Fri, 26 Jun 2026 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDSy2qTMyfWAyfXmqFUe66rn9x6umV+SPaL0jEzNnDQ=;
	b=cgMzWUDY2C0LiWjWBdVt2cRndwv1HM8MxcNX2zIxas/84ndbz2izXXr/AkkQ/2q7noXMT8
	iuKap69TAcJNPxo8m6IaKZXEEBdTdbpmTXcnmwot4lYESYibUxHWWEDiPnYV52aHuG4zqA
	TkBKklUeZ2vMJQfcOUKkrdg6j0vY4+k=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 01/26] batman-adv: tp_meter: keep unacked list in ascending ordered
Date: Fri, 26 Jun 2026 18:11:45 +0200
Message-ID: <20260626161210.124712-2-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5aa8651527ea0b610e7a09fb3b8204c1398b9525 upstream.

When batadv_tp_handle_out_of_order inserts a new entry in the list of
unacked (out of order) packets, it searches from the entry with the newest
sequence number towards oldest sequence number. If an entry is found which
is older than the newly entry, the new entry has to be added after the
found one to keep the ascending order.

But for this operation list_add_tail() was used. But this function adds an
entry _before_ another one. As result, the list would contain a lot of
swapped sequence numbers. The consumer of this list
(batadv_tp_ack_unordered()) would then fail to correctly ack packets.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b1629e0ac8268..f222c5093b647 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1325,7 +1325,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
-		list_add_tail(&new->list, &un->list);
+		list_add(&new->list, &un->list);
 		added = true;
 		break;
 	}
-- 
2.47.3

