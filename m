Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920E308F39
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299060; cv=none; b=nDLEvSKKvZ9bnKu1S4aGBShUxGJ86FT7l+IM3SznX8OUB3BMhScxbMG5PDw/bn8DB4fLhDdf7j+IdK6vZ6th7sh/nU6dsWN1ZsK2ldg23wrCRvUTPI/1p8fEeEvxDtIIRsDzIjDzdyTu+v03kgKTnIs9YpV74bsr5FaRuNTA0Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299060; c=relaxed/simple;
	bh=ll5xueqgExKxMOl2Ktjqqqj5PBbvNRWYOyPGdaK9/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDulVWswKjYeRShq1GOa5SF2Uz7W8QBUVveiCwldrBV3xM9ZbiJuEI0qzkQdzoBlPOR/gXM9gz6ebfCf0uT3QcGaRfbBFGDtFlJW/vHj0OEagXmspnIUv8CudzZ8hcxMzV4e8ZQL6RiJOlWreNEzwIKW7ntif/Je02rov7VoA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv1khuM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv1khuM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995581F000E9;
	Tue,  1 Sep 2026 21:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788299059;
	bh=hvne9InTrwtgnjMKASb2rW8oSchTJtTkO8ZlDvVi4M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qv1khuM9l6kEVp5xf1QceI7OojGwPSCGhhIZ7gv/JD0y1aaMmHGijxClq9n0EEKRi
	 XQlo/pxDZPpUraSJffzjlYRribC1bLMUNHPKt5v03upxoMfm0kL0AgeDMgnD+3Sczo
	 ddM1FJ+dTJWIUxFcGDkni/Jcx4l/ku+KvvBVQMFaqkf1xg8pJclZF9OBZUCvzf/eBW
	 nwMyFU2mgQQtcsLjyMAo3OJAT9hPRYqT7Cc89TOADIAKcW1fUZlGCw7a0wvYngBtsA
	 2gFHH/BC5KjtVXNutaknGL6YJ99pJOGVKj+jRN0WxErsuTXp0cnfj49FDMFTDugefD
	 5OwoQBsgT0Neg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	David Laight <david.laght.linux@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] crypto: atmel-ecc - replace min_t with min
Date: Tue,  1 Sep 2026 17:44:14 -0400
Message-ID: <20260901214416.1635694-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083112-dugout-suing-a5a9@gregkh>
References: <2026083112-dugout-suing-a5a9@gregkh>
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

