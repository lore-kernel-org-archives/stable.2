Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7145A288;
	Thu,  8 Oct 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464517; cv=none; b=l73ie2D0MfxXcr/y/vVR+5fYAr0JGCGKJEfIQoDvJJrrOFQIYSBUP4k13Em/nFMJJI15KhAIxjz4ZLcQyCUuba5LMFi8uvNcXq96IiK4gXfsvyymK7I1u84hdhWlpnK4bRpO1UAEBOYquFRyB1W20W6Lx4BZPNI4Ef0ZjHhVZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464517; c=relaxed/simple;
	bh=lkoBppS8cToPR8kV2KkbyVbZsLQdIqlbgullnc9FxoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu9ctGS3/kTe55PtrhxzK7n8oD4xGuStJFRUR/TtccdSG3rO/UAfCQ6XNVcBdprZb/KLB1o8yxljQtBt4wvEQj+fsQoWn0by3bksA6VMyamFNDOx+3UjNFXJDNKAh6GI3iauy7YBIbFbC2hiBGbXPxVlG2427pjYBDmy6TPYtzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ne+pHO0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ne+pHO0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039C81F000FF;
	Thu,  8 Oct 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=ne+pHO0a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791464510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya7g+FtvxWjB2wIBLf4BgwaXCHnUk+WaaD/ERrzEiuI=;
	b=ne+pHO0aleCCo7JNTFLDSWJb4gV8M+wfBh7tEZv8cThP33Qb1I5HBK+SMMG4yc/Su9pGKQ
	SCLcpPs8MOR9A9Qb944D+589o4WgtFZhumVpLBPMjEPdMDScYaX6EzT2OwKHlVsY65XVIt
	NDFfW6eKlya2feakd3BZXj3YpTq8oRs=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 68616c33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 13:01:50 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] wireguard: noise: reject response consumption after intermediate initiation
Date: Thu,  8 Oct 2026 14:59:16 +0200
Message-ID: <20261008130124.724119-4-Jason@zx2c4.com>
In-Reply-To: <20261008130124.724119-1-Jason@zx2c4.com>
References: <20261008130124.724119-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two threads begin processing the identical response message, received
twice. The first thread, A, runs. While it's running, the second one,
B, gets partway through, and during that slow calculation, or even while
blocking on down_write(), A completes and then also a handshake
initiation that's already been queued up runs in thread C, which itself
takes that same down_write(). The handshake initiation creation
succeeds, and sets the state back to waiting-for-response, and calls
up_write(), at which point thread B resumes, because either its finished
its calculations or was finally allowed to acquire down_write(). Thread
B then copies the state back to the peer, and begins a new session,
using that state, which is the same session as the one made in thread A.

Thread A			Thread B			Thread C

down_read()
 sA = handshake->state
 memcpy(cA, handshake->crypto)
up_read()
if (sA != 1)
 goto fail
slow_crypto(cA)
				down_read()
				 sB = handshake->state
				 memcpy(cB, handshake->crypto)
				up_read()
				if (sB != 1)
				 goto fail
				slow_crypto(cB)
down_write()
 if (sA != handshake->state)
  goto fail
 memcpy(handshake->crypto, cA)
 handshake->state = 2
up_write()
down_write()
 if (handshake->state != 2)
  goto fail
 derive_session(handshake->crypto)
up_write()
								down_write()
								 slow_crypto(handshake->crypto)
								 handshake->state = 1
								up_write()
				down_write()
				 if (sB != handshake->state)
				   goto fail
				 memcpy(handshake->crypto, cB)
				 handshake->state = 2
				up_write()
				down_write()
				 if (handshake->state != 2)
				  goto fail
				 derive_session(handshake->crypto)
				up_write()

This seems basically impossible to hit in a meaningful way in practice,
but ensure that it absolutely cannot happen by comparing the ephemeral
private key that's on the stack with the latest one that the peer's
handshake state has.

Cc: stable@vger.kernel.org
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Reported-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/noise.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 63f41836ebd5..428d3afe3ce4 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -783,10 +783,11 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
 
 	/* Success! Copy everything to peer */
 	down_write(&handshake->lock);
-	/* It's important to check that the state is still the same, while we
-	 * have an exclusive lock.
+	/* Check that the state is the same and that this is still the
+	 * initiation we started with, while we have an exclusive lock.
 	 */
-	if (handshake->state != state) {
+	if (handshake->state != state ||
+	    crypto_memneq(handshake->ephemeral_private, ephemeral_private, NOISE_PUBLIC_KEY_LEN)) {
 		up_write(&handshake->lock);
 		goto fail;
 	}
-- 
2.56.0

