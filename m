Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0E4028CC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490354; cv=none; b=NDaSohz+aZjBNyOXwc6vLns/qwcvU213KmhG5Dvf9pghIeQEnpkVuCPDYsWi//7tkDzaAxZnpPo0+d/8kwMTy5HfhNhFTTGyXf2OmbSfgfYD44+SmOeURno8bAJcUR+R8oezVxGnRssqnifooSRqUNIgHIRxoCVb3W6eZPnt5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490354; c=relaxed/simple;
	bh=6n8aBNMwx4OFO/mnbIfYfSm4PtfhYsQd9178zaHTGvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaNcBy8h0n06hZvD04IZheDcY4K1mU3OnrKKjZl0stuxIYmcG460Bo3NAB0ILQgJuDR5tYlMmSxwqQA2fIRdkpEgN9ykVHnqghmXmHMqfu/0sqwq4Qo/QS3uUk87wto1RyOTHMfZfl8VVvAIi/nNMb4AgFyiV6jwCASRIeuTBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=scb1zAex; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="scb1zAex"
Received: by dvalin.narfation.org (Postfix) id 838F820535;
	Fri, 26 Jun 2026 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vjJlBq13n8wcgUX/p8ro2v42RFsQaU92CfBNIbNXX8=;
	b=scb1zAexWxBEN2l36pM/EKw0/zcklXLYA3TWJcLnBptM77ujb0MkxJ85zcUnZ7CcufJ26b
	SGIKNI457RERflsAA9oI9/XZh2fZN2I7O60nfICB/c3wxKLa2VH/qhVBvrXyX+Ww1ENsBl
	/OFmK+tHRUpBFChmC1ipqU+xvKrvGsM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 07/26] batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
Date: Fri, 26 Jun 2026 18:12:06 +0200
Message-ID: <20260626161225.124839-8-sven@narfation.org>
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

commit f54c85ed42a1b27a516cf2a4728f5a612b799e07 upstream.

The recover variable and the last_sent sequence number are initialized on
purpose as a really high value which will wrap-around after the first 2000
bytes. The fast recovery precondition must therefore not use simple integer
comparisons but use helpers which are aware of the sequence number
wrap-arounds.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 77bc69573a562..0801dcf93540a 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (tp_vars->recover >= recv_ack)
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

