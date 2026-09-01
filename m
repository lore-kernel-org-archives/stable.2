Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D11D514E
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296844; cv=none; b=M1nFSSGwP8A3JiRepZR1TEFjrZ7WGk4OT0lwF2wZxSHNg9m1UwjpPZytxCfFEHjeNWUVOGeqUjIvZRjdihwfTDHwwEKGFYmbcMfZlDUVZheJOqJjrlV+DvToq6yZUUyiB3GYuuDtYrgJGdeq5oFBGUTVreeaFO5P8pzkTqTu+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296844; c=relaxed/simple;
	bh=PSanpeaYvjPfKuf/sg7u9S3A98IdCILnVJB+oqa7t48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQrs8MVqCKyHlqIG/0hgeAuATTjMkSoN+y934Rm9TxajRK4kA4EBxgMGxv7XrSBMrXYufZiJrvu7YO3wlVorrfW8gMsMkY/OrhqHew6YswdpsPK1oLsMg1pil0l/6dtmMnYv275MoayVpyBqc5pUAUR0kq8r2axeyDRu7iqJt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzwNcq4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzwNcq4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228221F000E9;
	Tue,  1 Sep 2026 21:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296842;
	bh=mwBIMDwrr/ynR2P7MK+YjTXJOHupWp0YMWLzm6Xle5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzwNcq4nH/Sh0OSl97dj1EB3Rqfz+yMOQfdmhlqNCtHhp9qrn31656h0AQJrd32mU
	 0ApycxDHWhaGjI5inThftYhg6w/zpoRUlcWrmRpOc5hW8IgfWe07QoYMhJwRj5AzMO
	 p2YXNVOL2FE69kF18B4/i/SQLLonyCr3bKmnsDtzMVXmT7dA1fMsf6KZqMMm2B73PO
	 Olcj8BguAnu0vS9ERak9tomDWn3E1R3FTvrYBQcGSnEe4LMsqo7/VwQfpT0YsffjrK
	 p5PgQfxCkPoj5RCOueRpL/qcWQQtk+joDnH6AZlce8sWh0gXwy3Mgd1tPgc91L9qTL
	 96bd9jOnWbn6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	David Laight <david.laght.linux@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/3] crypto: atmel-ecc - replace min_t with min
Date: Tue,  1 Sep 2026 17:07:18 -0400
Message-ID: <20260901210720.1603783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083111-derail-placate-9202@gregkh>
References: <2026083111-derail-placate-9202@gregkh>
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
index 9c380351d2f9f..8160a2c49b10d 100644
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

