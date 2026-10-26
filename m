Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004802;
	b=Fk2b9gfvGsJev85S9O+BUg6BKbTaJcrfpH2Pxvv34CJa+aEulFq7ZMVq5ZpuWxTwqYLQ
	 OayvwHBZSaDbRoifnZLhtCfX++zx9mzHfofJZOzTkm1tG+vf+Ct82wt4NFb/y6u30oNZz
	 JeerxsBPvH6OL79fTF5/tC68lhuXRwKb+ZFwMEgE6fCKcEvnCIlvzepBk8jz5gZUQULop
	 f5AKKTsZ5e7ApYBZs3OcEIQzeQPda73g7phfGAyZy/UAYvbWXAulTk/G28pVWsL9iWmQ6
	 t//iKtMA/C/+p0X4Rd2kec1kB7hihDnLDr5QfxuIThpZ+sWSx3RBn1khCtN1M83C5pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004802;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zooGUg5U79hEFPrT6Hi6K1nHULVSW/Tn4sEvAK4VHgM=;
	b=ZKQSZmsrDrnPuZ7zqAnvW+02c0AToyIov4i8epFBhNCJdQ8MvDw5pc8dGGPSd0sdc1QQ
	 RK7OnC8g5/6JldMF/1RkQwabgDWUfc3FpCKGwx719yLhx3LArk2uVItWuPFsauVDqJTus
	 Q94vx5D5yhYSE/6tMtj3o3mn9to/Z67JgmrS5UsZ0HX0YXtZ7Uqb6EFoSY+BdrjXbQ/sM
	 p0m71i5dRPYhVN4CBafnBgRQOJVM16QQCf4LsREf/113ZNcybjY8AccXSE/+PKSR5z12d
	 d+7equ80koDtzWR1BkFawppdjxk441LrFQSEDg+YhSYfUoH+KAevkDyJ8dBbQnYHvPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=xOMgBnOp;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7D0A7606A32E;
	Mon, 26 Oct 2026 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D0A7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=xOMgBnOp
Received: from kero.packetmixer.de (p200300c5973Ce5d80Fc8dfE94A24022d.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id F1FC7FA1DA;
	Mon, 26 Oct 2026 09:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zooGUg5U79hEFPrT6Hi6K1nHULVSW/Tn4sEvAK4VHgM=;
	b=xOMgBnOpjIEKs567hEgwRcEEpAczhvNU3VlMu7J+24ohb/EiruGY05gGdc43DNjfDsviHV
	YiNy547Ofd+bLg0w+PrxAQaUSAeUYxW/0f7I6lJoPVrNo6Iih4Mxf/WPHF8Z+//gVh209A
	m0xix3+j7BcD6nud5JZNdaEA6V+Junsy2Z3g73u582wbw6n9+i7q872Gb3dWktmhghc/Uf
	NvpruixTYcemMbXHu4SAR1g5cQwVvZcWffpcHnNDbOCQuNQd0zK8rMQhQYcObFZqa8UcXE
	yllsiZziv9R+1c06Yi3YAaSbtf5h1S7Ffg36W24vjB/3m7srny81MGj9gk28eg==
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
Subject: [PATCH net 04/10] batman-adv: dat: initialize orig_node of unfilled candidate slots
Date: Mon, 26 Oct 2026 09:53:03 +0100
Message-ID: <20261026085309.1074911-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
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

