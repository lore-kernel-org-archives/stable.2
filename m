Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992837C90F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490292; cv=none; b=hI0Ym7cscCL/iz5/qeMa0p1Z4Mzq+OqoOZ5ID3dUsiqnvwSlZqGKyUOzEboyaI2hulWCHeJmlIKMhRYK6gGHDNi7QYeqBf4WCjpmFCSuLP7UW4bBQt9S5V2Xa/PcVL7H4FeWARk4ZPVVq62vqdI10GzUkDBLFVMi9qamRtlswXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490292; c=relaxed/simple;
	bh=qwhlGqtkT+8Iktouhp7fHbaKgIS7KJ5b/Pa8N1OkJoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deC7iLkNkvyJ1HS66oq6A5+kxt2cYW7u4QnnTJ2qrmgA/GTHZkuXftN0g6g0l9YbeoGnCX/jdLGsZOMNV+0d4tBRO5MBoVfWhDStGCJJ8joFI4flkkHAX/6DzizTP8mJ1Y0345Yp1yVFiDWo5Bj872wr/Fp0ooTDiZ2vIUToXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=YcQXiNDz; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="YcQXiNDz"
Received: by dvalin.narfation.org (Postfix) id B5247203FC;
	Fri, 26 Jun 2026 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfsydxWxPODIUuq3G6wQJ85MGg4Uf7FK9teaBINZUPo=;
	b=YcQXiNDzQC5qYDjMPjxNYGaWYCjntQCr/yvY4bCh91Yv3BoeqMBr1SG1S2wm9AwGK566+s
	ae0S6coabTNVbYQzhSF7ZyyaNzSpYrCgL8MkDNCbi95I5zZ+l4tUYd2cHP0QZFYX+Cpago
	DILANZRf9pd327TIUosJJdGxgybuHeo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 12/25] batman-adv: ensure bcast is writable before modifying TTL
Date: Fri, 26 Jun 2026 18:11:10 +0200
Message-ID: <20260626161123.124273-13-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4cd6d3a4b96a8576f1fed8f9f9f17c2dc2978e0c upstream.

Before batman-adv is allowed to write to an skb, it either has to have its
own copy of the skb or used skb_cow() to ensure that the data part is not
shared.

The old implementation used a shared queue and created copies before
attempting to write to it. But with the new implementation, the broadcast
packet is already modified when it gets received. Potentially writing to
shared buffers in this process.

Adding a skb_cow() right before this operation avoids this and can at the
same time prepare it for the modifications required to rebroadcast the
packet.

Cc: stable@kernel.org
Fixes: 3f69339068f9 ("batman-adv: bcast: queue per interface, if needed")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 83f31494ea4d9..0709f42c54b49 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1199,6 +1199,12 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_is_my_mac(bat_priv, bcast_packet->orig))
 		goto free_skb;
 
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, ETH_HLEN) < 0)
+		goto free_skb;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+
 	if (bcast_packet->ttl-- < 2)
 		goto free_skb;
 
-- 
2.47.3

