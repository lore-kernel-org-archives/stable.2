Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368284;
	b=mKjQOEcS/S1QotQ5oMF9IM27LuMI+Ro6B1gkHY+F97ZgU6SZUNaUnKAOP+TxVUpWCvEO
	 W6Z1SY/zYReMBo9BLNBFuXyyRH/1VwTXzUw3VGLefQTl4gDg2udU4167haiA2SjJLpPij
	 464kMyfTf13gpgncgKFHyC6fsdygpl+E0+qNEMeKQaJZ5b/Aw3Bvqt1NfNYJ0YUswU2ug
	 kQ1wzA5vn8siMo0bVFdYiP5KUvrdFFH0zy8gCfb4RIVQn2fYBEx6nf8ubncRX6r/Fr69g
	 GvR5vLymt41rEF8nSn9BHQ/B7uvDAFe0Ki01jZniiniHboXATkX/zdy6s3AmXQ0WLIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368284;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zooGUg5U79hEFPrT6Hi6K1nHULVSW/Tn4sEvAK4VHgM=;
	b=H1eRKxnY8FBo0Gx7ZzH6xXQTTMqT1ve9gcqOMCyAXff84Y5ZZ/278VZq5cr5M85q/cZl
	 IQMo7RLYYBHikese/BapO1XRJrLYEejulQ6XlV3Iv235hhTeaHxq9Eq511RKjMglGi0Mm
	 40+KDvb7EUdtTV1lAVqp3vAWUiLHkazd6P5OFbktvHlx+csmsQCuzmkg1Z94YdW2MnJqp
	 1ZbVh7h4JudJ7/MYUgQKQQ0krvzEG0kJt7ZahQwZ/5/gE1d1ZDDRMo9qNbAbWH54HH4T3
	 oq8zEhvmzC6DiThISi3PhRV+gHuoYihJgho4QqvmdXsOmEqzo/r4L/pF6A0SZFpcM9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=BFFAb6w4;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7433B606A334;
	Fri, 30 Oct 2026 13:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7433B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=BFFAb6w4
Received: from kero.packetmixer.de (p200300C597124Fd839580C360d3Ed6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C70D9FA197;
	Fri, 30 Oct 2026 14:51:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zooGUg5U79hEFPrT6Hi6K1nHULVSW/Tn4sEvAK4VHgM=;
	b=BFFAb6w48mJG8/X+32JzoBLNREjEax2+Ii+ujqab09H93BmKa4mFxx6dz43FTvXokA0w/5
	uS9pd+9rBiYgRfZ7iJxsZOzvHFtcXi6eQ8AQQNSX+KB7R6IFQyh/6nJkS3M+B6wySG6fjG
	QSLxR+SQMU0cYf+84uHeuPZBJpBt5Oi0NVpKfD2ZRUdPlB3E3ji1IjNflfKRECfgooloAV
	veGDs6EyxD97JzMC34Md1h6QixT9E2NLzKFkOMnGZOiUN+G1lc9QPSLT/QdzklptH4ZUUo
	HQvcE9TLPo7fS1kXsTE72DPYSvG6QdQfe3A8htrhxLJuWEAcdcPS+Vzb8AGZDA==
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
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 05/14] batman-adv: dat: initialize orig_node of unfilled candidate slots
Date: Fri, 30 Oct 2026 14:50:56 +0100
Message-ID: <20261030135105.2555887-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_dat_select_candidates() allocates the candidate array without
zeroing it. batadv_choose_next_candidate() marks each slot as
BATADV_DAT_CANDIDATE_NOT_FOUND but only sets orig_node when an eligible
originator was found. In the following rounds,
batadv_is_orig_node_eligible() compares res[j].orig_node of all previous
slots against the evaluated originator. For slots without candidates, it
reads uninitialized memory.

The orig_node has to be cleared together with the
BATADV_DAT_CANDIDATE_NOT_FOUND type.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-b25d9aa4-10bb-427c-a145-ccaadc2a1bb9
Fixes: 785ea1144182 ("batman-adv: Distributed ARP Table - create DHT helper functions")
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bffedbce..0260ed7e828b2 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -653,6 +653,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	 * NOT_FOUND
 	 */
 	cands[select].type = BATADV_DAT_CANDIDATE_NOT_FOUND;
+	cands[select].orig_node = NULL;
 
 	/* iterate over the originator list and find the node with the closest
 	 * dat_address which has not been selected yet
-- 
2.47.3

