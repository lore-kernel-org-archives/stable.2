Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0A476CE6
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346430; cv=none; b=JNCwcUYXwz2qFSjuBOqGUxeDtHTUvW57S3cHjzcCmJCfSrQW1ARSRuPOHKxTufMAlGiSEhvbfuIKcKgZ9wPtdU0hk+SP0y0orTYfKgCUk/s/xyHVaGIucM2AZPduVIsCXa2bP/THFpbTWCkdJK8p04NiUmJY11jFEMUzk8q3Vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346430; c=relaxed/simple;
	bh=wFMmVx65zeOYvAWGAdhsqaAKfFJbNLSJoOydWlLbQTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flwYpNPrlV8co2g5u1SEqgBRkNHL+IUM5fwoA9/v58lA/CT2u8OCZUlnZtnDvr406zUmKcaIhckWE39VYJQB5Hho5F73J00X9naDaqWWaJzSWz7X36oGZIKXaprTnXspcTJXl6ihGCTs384qsZrQITrCYsHh6X5ITzxyxStHjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZhi/F6s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZhi/F6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB0D1F00ACA;
	Wed,  2 Sep 2026 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346406;
	bh=IsMf8An27hSIkqY/mg781M3KhabACuKhnoXjlUgR55A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZhi/F6sBoHc56EVUSp3r5p3GuIca+5j95L9gQuDo0Z6q0Lgdi0CRAn4odHuc7kYh
	 qyNezldyiFb2OKWpz+5XnP2So+rrWz+cmmTJrn5zkR8H14cvZP79o2J0PUCj2hjwuG
	 1kEuT28/XXXPZ5E6knNWVJ4RGPSSs2b1d4mtXNlgV4E+7LMe1yTuC2TSSQIuPtqSG9
	 zmMVGDZTInOM9vrZ8pZbc8XNC0HyDvJ551C8e9M9dc/OLn31Kr9+paKI9hxe2quk+4
	 vUcERANK53S1VASaL0drtXPZOtJk8hE3MX9Cbo43S6kvykUI6usxTGR9g54fYBOSq8
	 I9dATiDIT35lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	David Laight <david.laght.linux@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] crypto: atmel-ecc - replace min_t with min
Date: Wed,  2 Sep 2026 06:53:20 -0400
Message-ID: <20260902105322.2048136-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105322.2048136-1-sashal@kernel.org>
References: <2026083113-premiere-tables-885d@gregkh>
 <20260902105322.2048136-1-sashal@kernel.org>
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

