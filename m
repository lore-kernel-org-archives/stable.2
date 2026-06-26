Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248E37BE7D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490207; cv=none; b=u+jjQTZ+5zZ0SBkXbxW+zjcqruTlV4EDjnrT7xys40bl2HTuhli599xgwvQUfIONv/tY3DlQD7DGm18y14Dn112YLhsWNCfrvT2Oa47n9TcG8P8oldizsXqavWmIaxDYOIMLryWWArKWb5057/GXBc64L8LkzueygDGtVjmEOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490207; c=relaxed/simple;
	bh=KRRn1NSTnjV4o39EwoSNHhl9KmxfyyBPrIjXZ5M/L0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq8Paw9R0LfeKVDyfImWBD563Ow4mmpJntV3P2z6wcrgxPR+w6akKrXjdTulLZ+6DwS0I/4jZc23vgJVtygEMwJkgpiYX2fmbNnrFULwFcdHTi90kwO+FtSrWJY0S8hX4RsMqL4XI4LRwUG6WvBFfzhfUw68hFDZRBR1qnUoQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=getPHPeR; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="getPHPeR"
Received: by dvalin.narfation.org (Postfix) id 17C3D203F3;
	Fri, 26 Jun 2026 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRVDngbZvrQ5ev2GIwumRCtns3QHjJuIIAMSMPJBf0c=;
	b=getPHPeRoLNQ2qL/yjOyaPDTcB5Yud1EagT9v081ciGmZdKKa13IchvNYPKGDwxnPRKdii
	qgKXlGOWxpHvH8nLAvcRmI5oP8rttReesoCMyk4MP9M0PF4+PhYdKSQTG5MlTBI+2J4SQ1
	8qKc61hhZ5olrVJ7h2ZnrlliLzWFmqk=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 02/23] batman-adv: tp_meter: initialize dup_acks explicitly
Date: Fri, 26 Jun 2026 18:09:31 +0200
Message-ID: <20260626160952.123713-3-sven@narfation.org>
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

commit b2b68b32a715e0328662801576974aa37b942b00 upstream.

When an ack with a sequence number equal to the last_acked is received, the
dup_acks counter is increased to decide whether fast retransmit should be
performed. Only when the sequence numbers are not equal, the dup_acks is
set to the initial value (0).

But if the initial packet would have the sequence number
BATADV_TP_FIRST_SEQ, dup_acks would not be initialized and atomic_inc would
operate on an undefined starting value. It is therefore required to have it
explicitly initialized during the start of the sender session.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c837a91879ac2..1699fb8f8c82d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1055,6 +1055,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
+	atomic_set(&tp_vars->dup_acks, 0);
 	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;
-- 
2.47.3

