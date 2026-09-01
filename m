Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F652E2DDD
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306345; cv=none; b=gddCzASI01q/sVZpsuRXqzJpmWSMWlDEEfCwx2iAC5tEtXWa3mCUNvZBk4uRPq4nsoeRmO5YP2C9HYU04MtY1657td8ETcY4CEMGb6pY1vu3IK5D4RU3VM8jgrDfn/8C+uvFCm92HzH2jZ5s+/Hd8zcuB/OwoatwxQrdFH+uAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306345; c=relaxed/simple;
	bh=KEDD4dZKpPPcROM8iIStZFRMsbLevHvLu0GEBfep8EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0ztfRhttyO13x6q9y84MsBg04SYZTzhTB5np6rIzaSLeXEfIrMHfjViSy+AD1UuUPVhIkDDRx1GrLzM5DV09AONilXZ6VF7Tzf53ffOod0hFGOk3tntO5UGXUvFLxeCWgwNjz5zoFRDEWor5JL6ObyK4k4Anr0Yfd2tPwCqDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiW9SLLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiW9SLLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2BF1F000E9;
	Tue,  1 Sep 2026 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788306343;
	bh=AcNnl3SxbFzg3dYD2yxR3/Dochv8hUacjY9js9vKzPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RiW9SLLl//eu506kHUhyH10SjJu4whXVLHQvzqewPeRxzwuqFmKoOz+HgPi/Ak5+O
	 cm3MFFCdwBtQuxsoNMx6A5UfWnYb/kfXzRZ9HEYx5pOKetiz1lwiFBVFXPooRwvbfv
	 wtsfyPlcU51pLYMi0rR64h49uJt62utiQ6putCtawr6gRcnkanyCpPz60O+rSSYkd9
	 AYXPlgEldVPI4cbp522hwKk5bNaVMUZttdcobvn9GTR/hvI3koRyZr2MweTz6p2cZK
	 zVfgDa/Guakwew8sH3w+q7KoDWGlrs0xwVvAkTjpDpSSELtL78XMrC4pxW2Ud0TSuj
	 /kJi2x6cuvDDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	David Laight <david.laght.linux@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] crypto: atmel-ecc - replace min_t with min
Date: Tue,  1 Sep 2026 19:45:39 -0400
Message-ID: <20260901234541.1770079-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083113-uncapped-voicing-f7d4@gregkh>
References: <2026083113-uncapped-voicing-f7d4@gregkh>
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
index 75fb7be844cf1..6f784e2e596c6 100644
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

