Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.185.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887821;
	b=bf4q70rMFN0RkbZlA6sWiCrs0f9/SU+2ze5NqCXltIyAe03w6XidemAIZbkiPO2RQflc
	 ftdjP4RaJz249VpxW7OJwhZHbad80aY5En+101Xc+SpPZM6tz4mPouMkc3CbkU8RI3yBd
	 KsX0cb5uzkv6AOzioBk1UUPIJ8PbFY+dUpJlGWFHMT0YFRnpqAwY+pZvZdhn0xH2Oo1uP
	 uh9Qjs1f8fA2GzggceFgVPqJlG37XFlwzYUH5un9zz9SgN8nft4Ets9Tf5/j+89RYtrbj
	 mknEB1LfIqqXPEfEel4ThI2ozCzP1ooK3qpQWltzkKkiIrZbI71SV1erGx9JGsG70WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887821;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Bar;
	bh=2w/pv8W8p2703IU4YSematscewyjnxpED9mVVxiIFo4=;
	b=Df+OBpZ6XMF7HU7etQsB+gGi3cjOJ+VvAdX3miFwusxtSWR4fFiMQNqnNPKtxvQtbBJc
	 QPIYOdDFPttDM/yTKGacY+n/BcswYOnVcxQf6Y71X5jFPqWcBY7v2IfCmzoLFEnowsiuR
	 3d9fx4yW3hUlcyKytCVUDmE1TkV8OhnbsbIyhhMmSXQphnbVmRj0Is/XRloO3t4dZd8cx
	 r1ZKaYAw8yqmYilC+Ax0KujiSRs/xUHFrk2VL4C9ztEDQ0lcegwK5hM207JIGcvLXbIYj
	 XkYMFH5CGiYbTdg4f6FZ5TAxACsxaAMGVF22dBTXmjM87GbWGbiBaYo09h2KWLDL3GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=badcode.im;
	spf=pass smtp.mailfrom=badcode.im;
	dkim=pass header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b="RJ/XGpAd";
	arc=none smtp.remote-ip=185.185.58.180
Received: from badcode.im (badcode.im [185.185.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD92C606A33D;
	Thu,  5 Nov 2026 14:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD92C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badcode.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badcode.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=RJ/XGpAd
From: Alexander Ildiyarov <alex@badcode.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=badcode.im; s=dkim;
	t=1793887818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2w/pv8W8p2703IU4YSematscewyjnxpED9mVVxiIFo4=;
	b=RJ/XGpAd89QuYTXpsvBXCp4YT4Zv3Rpp5EAi8+phAcuzARz58byHBX/dkXUGrMezEwxi1d
	ZXHmgZGLp5oVw+vLiLYzPLOB4yAtEUBqFrEHajSAEjIK0bQBe3WI/7YRiVMR+A71fDu1OD
	zuk+eRu6uYuk8exG6s2Cbfeuwn5VwdPffjUNFKLFk/7B9cprr92edeGzMs4FmeVbrQX4qC
	vaf1LbZgqiTmUBJnjC2mSRdIm2taIRatXLGDfwRFVsGDwySwAKGSM0aWEU5+fFxGw/Tbsp
	iiEii+JIBQOzaZ3S8UXRe2y460XkStCPHQSOq8izmrrjwUyow6yANzRQHlDTCg==
Authentication-Results: badcode.im;
	auth=pass smtp.mailfrom=alex@badcode.im
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Alexander Ildiyarov <alex@badcode.im>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] wireguard: noise: recheck replay and flood under write lock on initiation
Date: Thu,  5 Nov 2026 17:10:06 +0300
Message-ID: <20261105141006.95083-3-alex@badcode.im>
In-Reply-To: <20261105141006.95083-1-alex@badcode.im>
References: <20261105141006.95083-1-alex@badcode.im>
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
X-Spamd-Bar: -

wg_noise_handshake_consume_initiation() checks the initiation's
timestamp against latest_timestamp, and last_initiation_consumption
against the current time, while holding handshake->lock for reading.
It then drops the lock and takes it again for writing to store the new
state, without repeating the checks.

Incoming handshake packets are spread round-robin over all online CPUs,
so two copies of the same initiation, received back to back, are
processed in parallel. Both copies can pass the checks before either of
them updates latest_timestamp and last_initiation_consumption, so the
replay and flood protection is bypassed. The responder then creates two
responses, each with a new ephemeral key, and installs the keypair of
the last one, while the initiator accepts whichever response arrives
first. When those differ, the session is unusable until the initiator
gives up on it and starts a new handshake, and an attacker who can see
and duplicate initiations can repeat this for every handshake.

The window is narrow, since the expensive DH computations happen before
the check, so it is between up_read() and down_write() only. With netem
duplicating every initiation between two namespaces, no double response
was observed in 200 handshakes on a 4-CPU VM. With a usleep_range(1000,
2000) inserted before down_write() to widen the window, 30 of 50
duplicated initiations produced two responses, and in 12 of 50 cases
the session was unusable after the handshake. With this patch applied,
and the same delay, every duplicate was rejected and all 50 sessions
worked.

Fix this by doing the checks again once the write lock is held, keeping
the read-locked check as a fast path for rejecting replays.

This is the initiation-side counterpart of the response-side race fixed
by:
commit 2a73c9b2c0ca ("wireguard: noise: reject response consumption after intermediate initiation")

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alexander Ildiyarov <alex@badcode.im>
---
 drivers/net/wireguard/noise.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 428d3afe3ce4..209127654e65 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -580,13 +580,23 @@ wg_noise_handshake_create_initiation(struct message_handshake_initiation *dst,
 	return ret;
 }
 
+/* Must hold handshake->lock, for reading or writing */
+static bool initiation_is_replay_or_flood(const struct noise_handshake *handshake,
+					  const u8 timestamp[NOISE_TIMESTAMP_LEN])
+{
+	return memcmp(timestamp, handshake->latest_timestamp,
+		      NOISE_TIMESTAMP_LEN) <= 0 ||
+	       (s64)handshake->last_initiation_consumption +
+			       NSEC_PER_SEC / INITIATIONS_PER_SECOND >
+		       (s64)ktime_get_coarse_boottime_ns();
+}
+
 struct wg_peer *
 wg_noise_handshake_consume_initiation(struct message_handshake_initiation *src,
 				      struct wg_device *wg)
 {
 	struct wg_peer *peer = NULL, *ret_peer = NULL;
 	struct noise_handshake *handshake;
-	bool replay_attack, flood_attack;
 	u8 key[NOISE_SYMMETRIC_KEY_LEN];
 	u8 chaining_key[NOISE_HASH_LEN];
 	u8 hash[NOISE_HASH_LEN];
@@ -594,6 +604,7 @@ wg_noise_handshake_consume_initiation(struct message_handshake_initiation *src,
 	u8 e[NOISE_PUBLIC_KEY_LEN];
 	u8 t[NOISE_TIMESTAMP_LEN];
 	u64 initiation_consumption;
+	bool reject;
 
 	down_read(&wg->static_identity.lock);
 	if (unlikely(!wg->static_identity.has_identity))
@@ -630,17 +641,21 @@ wg_noise_handshake_consume_initiation(struct message_handshake_initiation *src,
 		goto out;
 
 	down_read(&handshake->lock);
-	replay_attack = memcmp(t, handshake->latest_timestamp,
-			       NOISE_TIMESTAMP_LEN) <= 0;
-	flood_attack = (s64)handshake->last_initiation_consumption +
-			       NSEC_PER_SEC / INITIATIONS_PER_SECOND >
-		       (s64)ktime_get_coarse_boottime_ns();
+	reject = initiation_is_replay_or_flood(handshake, t);
 	up_read(&handshake->lock);
-	if (replay_attack || flood_attack)
+	if (reject)
 		goto out;
 
 	/* Success! Copy everything to peer */
 	down_write(&handshake->lock);
+	/* Check again, now that we have an exclusive lock, so that two threads
+	 * processing the same initiation in parallel can't both pass the check
+	 * above before either of them updates the timestamp.
+	 */
+	if (initiation_is_replay_or_flood(handshake, t)) {
+		up_write(&handshake->lock);
+		goto out;
+	}
 	memcpy(handshake->remote_ephemeral, e, NOISE_PUBLIC_KEY_LEN);
 	if (memcmp(t, handshake->latest_timestamp, NOISE_TIMESTAMP_LEN) > 0)
 		memcpy(handshake->latest_timestamp, t, NOISE_TIMESTAMP_LEN);
-- 
2.43.0

