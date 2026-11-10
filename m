Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328020;
	b=wWcZuesmo7gnM9XK36rX1ohBA+1DB5LRvJ57L1hJvLWULxJZk+1g/tGvDC1Peq+/D/Xg
	 +tTHO4XSBR/zbKyPfrYR9UqNOHsElG3yCptakIWGGyqrXSDIrL/qovN9jocKXAqbotEme
	 bMzQOCkLkl4e5HB4+45Sf9feG0r9ifNsB+I+gTCZlA5WYN/IJ3byjeD/a8P1WgCpDvIVt
	 NR8LRO1BLFl3tN6SBfLwQA1KwzpbCwMZZObcg6Z/mT7OHPTOebvJg2xI+pRLoQAKlLU8z
	 jWEWWEwPVbgBs60Q7bnRJf+o8bxqGbgzhxaeb3JSIiVejIVWu5708s08bJbVcOjgkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5YYJRcZa30FSTFvsS37m5JHIMPZTvVDdG65PlwXrp/k=;
	b=5Szr5hHNALJGnMbtvV/ApxiI+O6CGFq43J3ea0rcVSzGOP4n7UD0E4y53cCRKq9/i0ID
	 3B0XSBarRJqVuWHpsP+/gD7yk6zUJ1s4/uEo/PczmN50AeCCRgav6yxyIw3z8cwriX9nw
	 U2+JjtUKpsdJO77vcvm09QZ87U6umTa5fsP+oZNUr8e5TLEhkbVUF0k9w5KQ1PrgDL0g5
	 BggNh/lS1YC1GDfRyETfIecF8mR6Q2rcMTulvUYshAzJ5VfenxqypZuz1Z9v4ZXIqAt8A
	 n3wtUcNxMXRV9wJBwm0OIxZlHqg7wRDl9Uv6IdqcB9crNRTP8M6OvoqX9Ofzi0/AurA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oo9N/FWR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD3606D7C1
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oo9N/FWR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E4E1F008A2;
	Tue, 10 Nov 2026 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328019;
	bh=5YYJRcZa30FSTFvsS37m5JHIMPZTvVDdG65PlwXrp/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oo9N/FWRPDDhLHv/1pXSWFakhSjvrc2A+dU1tm1cc/4NhqYD1zkRkW7yJDZNFLwbY
	 eYalfSUCQZkAhdPTw4vY8u1Iwge1Aj86kXlJoZAY/bEVbA+HW0qisrQHuun1LVbRMR
	 29sWiCn3jm5oLQ3HJFDcQawO1c1CDbeT0eVaNiHmw086I1mfJNN6k3dNCRMe/8e9Ba
	 BCdwPB677YLdSlQkekxIc2BPQTfjJ4YZxbATMWp2YDPVfH4ofz4hQRTAQ/mYts80FZ
	 +4EBAso1DR51atB5fD2Eb8U1yktjkW8StCO+usnhpRRNu6BSf1T+WpMQDuylJwVfZh
	 Z4z0H0SsDowYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] sctp: hold shkey across socket migration
Date: Tue, 10 Nov 2026 11:26:56 -0500
Message-ID: <20261110162640.2496297-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062420-failed-5.10-52ffeaa358d1@kernel.org>
References: <20261107062420-failed-5.10-52ffeaa358d1@kernel.org>
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
index 96215fc4ee466..a3e9996120b89 100644
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
@@ -9462,7 +9472,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.53.0

