Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3133993
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490303; cv=none; b=aJ2okwrZ+WWZdvFVeS0764GgE2G/nSVoP+pPd9vQBtIBz+Ec8yDmJtBhWVwy6eV3oXt39AJyxMaJZYP/QeOlgsBRXEF9L3gPPeQ/o+k8FDYpCLpaSy9c5ckk2RUT0R/g6sLvkYopRbax4MQ5z806SMAdPxDCBOBjFAJtSJqdGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490303; c=relaxed/simple;
	bh=xrgct7VVPivwC4ngHYhJl2Q3PxN9f7d1t2RlHjvZz24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF7bO6Q3X+ErR9YPOVhGkOrjv3bWkQQaQ6xH77ZRVhq0IcjdIMBfIOvxBXbKAwW8oVLaEotZXz1jmhRoT8N7vgQIiH+qDDfHLyHb1N8leD09bAzG60F7oDedeJWSMkhD2W1QcFE4xXDP53eY8CFTKpriyXuVgP5HRgOAz9yr76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=XzjJgTcg; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="XzjJgTcg"
Received: by dvalin.narfation.org (Postfix) id A8030203D3;
	Fri, 26 Jun 2026 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdVLpshkYHxtM7X6i3aXjE0XlsoUcme2Ybm8XbLO74Y=;
	b=XzjJgTcgI5pfB0EQcqH25pqbMnOA4myTxW6Khj921ns9juBJ7uy2Yw6ZhC42ucn0g1kt2M
	vlQ0EcdQgR/NvNs3Dr0ybrE0IHZEI/y+1xqM1AoQQ5jh50ngxItKAvRZJyOWvS0bBCYDGa
	cWWzowIkNpMpSMIlxC8FU4iX2QPMW+c=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 02/25] batman-adv: tp_meter: initialize dup_acks explicitly
Date: Fri, 26 Jun 2026 18:11:16 +0200
Message-ID: <20260626161139.124425-3-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
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
index f350a60e6c76b..750e5e9d3dc9d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1045,6 +1045,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
+	atomic_set(&tp_vars->dup_acks, 0);
 	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;
-- 
2.47.3

