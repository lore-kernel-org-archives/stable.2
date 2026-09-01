Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763D431A22
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299889; cv=none; b=YMEq4ljU9TmqUSY0Dqs0TeIOeXdIOMNowQt5vuP9pQvGVZmSeRI/S50IteKo71S/ZU3Os6G65QD9cGANqWWwTgAhMXFwITj47+KbjwCB937oVZH/mYV343x12E2ZVZ51+BaFmaGZoeqfK0vdRKN7EknsQ24A6lqvQngEFn2pLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299889; c=relaxed/simple;
	bh=ll5xueqgExKxMOl2Ktjqqqj5PBbvNRWYOyPGdaK9/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knLoc9XAioFP7m+Mp4oxo6O5L4MG19lsTxFXAq5SDh2Et4VPMJx6iWjXTPs86ElMTW1/0MdG+bNrP/keIjZ3OnUQ178aXqcArxtnK4Scs6bpccwDOIQvYbnSDQQDWDyZAX/kRWlJmnOhjB00NrRbR1pf+AXfqfoEUzJ5+zs+cVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exaXewTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exaXewTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8D41F00A3D;
	Tue,  1 Sep 2026 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788299885;
	bh=hvne9InTrwtgnjMKASb2rW8oSchTJtTkO8ZlDvVi4M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exaXewTcZgaCwiym9V8C7vmqXAK6znfTHlS13v2WJJvcIWTIXEQUcMSgDNfGPRPQa
	 EXB9H+8rjP0rMmVFXy895NCvX2LmQyJMxYiRfH2kLKhlJ52OFo8sBs/2480VJKKn6x
	 HdM7zsHLR+GEz+bgUIg7myOxiVfrKGqQjQJCc3zYzRGmdOC2ybLCGWwzF5jMJ+tGdd
	 /13/m0gq/odqYIxcGMIfjKp+l5hsCXdBHmdbctrS/nzmQofwWnjyoHu3MO32f1O5G2
	 SveK6JW/4Td7zksRh0yZnZuNUjK/m2j2L2xdzeKXv0uBH8e/QzA5G5+0xBComRmetf
	 djR97YRYFLAQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	David Laight <david.laght.linux@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] crypto: atmel-ecc - replace min_t with min
Date: Tue,  1 Sep 2026 17:57:59 -0400
Message-ID: <20260901215801.1668303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083112-dreaded-mayflower-4781@gregkh>
References: <2026083112-dreaded-mayflower-4781@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 5b085b2a038a1458f9398cb3b3b03cba6e38e1e0 ]

Use the simpler min() macro since the values are all unsigned and
compatible.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: David Laight <david.laght.linux@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: f07a0d251db7 ("crypto: atmel-ecc - avoid stale fallback key after set_secret failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-ecc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 9da5a03880807..0ce56b095805a 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -56,7 +56,7 @@ static void atmel_ecdh_done(struct atmel_i2c_work_data *work_data, void *areq,
 		goto free_work_data;
 
 	/* might want less than we've got */
-	n_sz = min_t(size_t, ATMEL_ECC_NIST_P256_N_SIZE, req->dst_len);
+	n_sz = min(ATMEL_ECC_NIST_P256_N_SIZE, req->dst_len);
 
 	/* copy the shared secret */
 	copied = sg_copy_from_buffer(req->dst, sg_nents_for_len(req->dst, n_sz),
@@ -150,7 +150,7 @@ static int atmel_ecdh_generate_public_key(struct kpp_request *req)
 		return -EINVAL;
 
 	/* might want less than we've got */
-	nbytes = min_t(size_t, ATMEL_ECC_PUBKEY_SIZE, req->dst_len);
+	nbytes = min(ATMEL_ECC_PUBKEY_SIZE, req->dst_len);
 
 	/* public key was saved at private key generation */
 	copied = sg_copy_from_buffer(req->dst,
-- 
2.53.0

