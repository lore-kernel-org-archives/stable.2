Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327481;
	b=wDKMpQ3QfJDErlLHfXeEXTUBkKGFmERaBwS5NclC6yYifE5xAa2sUIK3ZWgbuPknTSC5
	 f4t263Aq+BHZKmy5hgyxWQ48gjEn2MrtsndEr6w8zcbM4AGFB3D7z/Ivt2A/i8qeRRWpR
	 jjqqKDY0fccY54OCpGJqGC8Ylej/4ZMW/1CYQ9Q4Y4mPuaYqvh5t2CtgD0wuTPPjUDWAK
	 EIa0RODNHqX97oDNX5IFgWmWRiHhBogKrlVla3YWupqkAPWUFZGiSxMlR9lCMpFqTPe2v
	 1yMekJNl841e2Azfjo5xuST4Xby/5htDpYD1EZIfjSKUjU4I/FyK2v+oBCDMnYoVc4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327481;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B4ZAqtLRqf/33qq2p2OFEp1ffqZo90MaUYX6ISChNl8=;
	b=M3p8g+hNmRlztuDzRNbir8qu4eonN+qaecsaxdKef/tZNFXW3KMHXhZA8tB1dS5Sdorf
	 wYy5eGcPYNU8nyoHqpMED8dXblMjJwO9IUuWq/1jUPYnItmCfZvbp0Eor63IthjECZoz/
	 pERW8f/CKWYHMu5mLVUtkbaZfcoZQdCgeMyaZ+WcYZfBxD895Y6RaHLNWreqG7Gf2L3hl
	 5jQP6p7VHDXib2kF2QY+pm5M0cBbDaayhxcg+UYCr6Lrdi3E7Ea++TJiRQ7qKkhxxg/LA
	 vPV/PqNRkbYDwYt4rfHSMgTcAVaDWodAC3J3/nYWDD0tQIbOZkaJhm2Xhkx8fh4WdIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daRfMXpL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC137606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daRfMXpL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DA81F0089F;
	Tue, 10 Nov 2026 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327480;
	bh=B4ZAqtLRqf/33qq2p2OFEp1ffqZo90MaUYX6ISChNl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=daRfMXpLcVJIsFFw+OGGo7j2nbprc+GwiOPts8a5LV3SeDBkS7R1Rv/EcA16Zl5m4
	 TGK88F0zNQHEX1NGWTTs2d6X5Qdq0Y2PQQUkqsGRnXa7StT7T/SvurfKknmdQQWrqA
	 npq9WTi3RrAxUM9sC+Kej8kp9H7lKANlqVjxvVyFsmNG5Uz/X+NQpYDjlGWc+lm5bJ
	 9rRoHFzfpg8ofwbGaAmpza3TDLYxkNAeYzUh4FJtHUSvelywXueSkcxdFzMWkyuwVc
	 V8/g8GXggCo/W23edwBBnJIAd1r/kO+Dnvp3MH2pDmoea73Gkkp+pOnbLnhzFkYJdK
	 PB2QOzX8J5T6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] sctp: hold shkey across socket migration
Date: Tue, 10 Nov 2026 11:17:57 -0500
Message-ID: <20261110161751.2477980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060725-failed-5.15-52ffeaa358d1@kernel.org>
References: <20261107060725-failed-5.15-52ffeaa358d1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lee <david.lee@trailofbits.com>

[ Upstream commit ad1320865b1826ffa2e81e37c49535751e81335c ]

sctp_sock_migrate() transfers queued DATA skbs from the old socket to the
new one. skb_orphan() invokes sctp_wfree() during that transfer and drops
the skb-owned shared-key reference.

If userspace has removed that key from the association, this can be the
final reference. The following sctp_set_owner_w() then dereferences the
freed chunk->shkey while trying to take the new owner reference.

Take a temporary shared-key reference before orphaning the skb and release
it after the new owner has taken its reference. This preserves the selected
authentication key throughout the ownership transfer.

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20261009074244.3718-2-juny24602@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 52ffeaa358d1 ("sctp: re-point retained control chunks on association migration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 27bf81a893a7b..7cc3f146b1fcf 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -146,9 +146,19 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
 static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 {
+	/* Keep the shkey alive until the new owner takes its reference. */
+	if (chunk->shkey)
+		sctp_auth_shkey_hold(chunk->shkey);
 	skb_orphan(chunk->skb);
 }
 
+static void sctp_set_owner_w_migrate(struct sctp_chunk *chunk)
+{
+	sctp_set_owner_w(chunk);
+	if (chunk->shkey)
+		sctp_auth_shkey_release(chunk->shkey);
+}
+
 #define traverse_and_process()	\
 do {				\
 	msg = chunk->msg;	\
@@ -9698,7 +9708,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.53.0

