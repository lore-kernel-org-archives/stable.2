Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4714214A84
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309207; cv=none; b=qFy9Z1cHsu0tfLkPVjH0rnzHbFIUYwzHsS5a1vwkKQEmQcp+8m2cSBhMj5twgwSDYbOcdSV8YvEWH+/ts36TYGdvBVupPzjIAEHdnouRgHDLpNHu2ZmvvYdOoPxkh1Ka86koHWHfIba/9JfkTDUGiS3VGSGzn9ZqyAyXIZrFIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309207; c=relaxed/simple;
	bh=wFMmVx65zeOYvAWGAdhsqaAKfFJbNLSJoOydWlLbQTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHF33dfVifegtEerfijazEsJx+1yLAf2SU8uFttRNqElcTe/4Z3Xj1/EBdmY2hwE/tMgYKLwbStWgjz83RTC5Dk8s4iA0TrmA8WCSmLGvZSpCA5PQzH0xYpg38dEg8lJ6hxrbRspgKP2XRKOG31FR9JPydZjJTzWKn0pFdd4IpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxx8gAwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxx8gAwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD54A1F000E9;
	Wed,  2 Sep 2026 00:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309206;
	bh=IsMf8An27hSIkqY/mg781M3KhabACuKhnoXjlUgR55A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dxx8gAwmr2lpRyakmXHD4/F9RE/bXm3/nMW6jlNtiyKR4M2ilOHL3zniqk5Iw6NaZ
	 JgD8z35S2OE1AJV65MjNfYkdVHnfAL609ByD5xGuA9ZH/RpE5PKgqDLp+18IR35UXi
	 Y6TYOIApEoGsCEUKJOKclY6OVpVfzoe0o4ey5W+H4NYMDLKZ/f+LeGBgyFSwL24n6q
	 lBM7yglo+Qg++kecCM7hWdNF90aIQnWXP7XzPrZQu1++PoVkPU9zSlZ7w6w7jS2AWC
	 GlQKLqLWF4gYchaBS/weFIaayQ/mOmEREAWgm46ZPsazaJzEfpGn05pIXlQxYYQMDQ
	 +578OaoFp37TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	David Laight <david.laght.linux@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] crypto: atmel-ecc - replace min_t with min
Date: Tue,  1 Sep 2026 20:33:22 -0400
Message-ID: <20260902003324.1792196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083113-trough-translate-08c1@gregkh>
References: <2026083113-trough-translate-08c1@gregkh>
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
index 004d87cbfa221..e21466dfd0753 100644
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

