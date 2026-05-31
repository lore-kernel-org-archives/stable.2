Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B037A4AF
	for <stable@vger.kernel.org>; Sun, 31 May 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780231490; cv=none; b=gfXz3rcKct3TMiPKQWhwomz4miyyQlCFmtYLjcSGjthLWyMS/hyIb7IAgHu5wD7U5mKWls27xeDosGpyF9QDHGbEHO7DK8SO71vtlLPjuE2kjP3ztDPk+Yy/C7IHNvw1IUKdCtusb1Vm6KdKi9EKlqLIsIPn2ef1XvVd5vZkAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780231490; c=relaxed/simple;
	bh=dJ4GRFwuWSHnPw/cVXnvzNeCJ5o9rhmasOCW7qlG0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGBG9Rp9lbsvIFt7u1ZpbV1vO2bKNFBLKd6zXSP7x7n0g4iLPXbi3X7T7NLyDJ3kyt9Xd6goeF/ThNJ/VrSkJCNmZrupOSRaAE6GeVTPuX1DmFeFsLG1J4LmIXJcyUZAiwSHYkZ6tTYxj9xxh2g2Jw82P4ZP0fC2vju8gVodRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGhmxeOz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGhmxeOz"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so28015446d6.2
        for <stable@vger.kernel.org>; Sun, 31 May 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780231486; x=1780836286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KA3GlBTHlZs+71CgTMpALkS8BwxWXgNQSpyqZfnP7CE=;
        b=WGhmxeOzmMYFkQ7UqLH4AIoi3GEwo+OW39OE3y2e7LeLlP+LZskQYNBJ6imHzRLqKL
         4VeEj3K4p81z82T18WjoQH2nB1e+PHIH5Z7n01SNxNjpcmN3emOpETuAfHxJ+/KN76IQ
         4IGopmUSL6zdSlETNCBLExJob7Azc9fZMCljIlf/5kHDqU15jP98RbD+o6N0T6ms8+yY
         oVmabbT6jpcRJYfEcRpgtm50q2bONW9m+mUjeoz6YV+bfOpPNy4pu3ylCcuQEBT9lOrY
         /24MIhcI9//4Hr6u70Zj+62M8xvb0wRe8ChC2xSN8giFDu0c9qIT9KMhYMROu/01ta1/
         D1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780231486; x=1780836286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA3GlBTHlZs+71CgTMpALkS8BwxWXgNQSpyqZfnP7CE=;
        b=nDCMojWJldB/rZMtMol1w80QS4nujO6YRGy9GQLSdXApheR2C2bAx93sTQ6biOvPIh
         BDXo7DokJrmsQhblhCqpDcG58XULWCNSvbmLwPFWl9g6gYEMvqja6IKU2r7vi+vLRIUv
         MMhFN4TMo8hJ210iWsiLEGLteSo+nixjIdJcADYaxId4R2YRUsDApB0PFy9qo0z5QzGA
         LMhyAgmGGemZgiCl1ejeDXLj9fQGS3aSzWslJYlZ1FqsvtRLn60Bi2iFx8wae8oGgupx
         gMB3aY7vDW8GLctaaGYbJt7b08hwsefKw+bgEVz6WXHk6rzcGQG1cKVLQ1rGLqwYBaCJ
         MK0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/TOEF/E0yGDTVx2W/wSRkrID/UopTU2CE3L9QlAK82hysbzKUylWIihKf503gFZ/mlDyE7Kfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGs7VaANMhiraVNNsmUZlNj3Ga/dReuEyBs9tXpCaXXLTO4xDJ
	+xEsaRKxURrLdKpBqM6+B6wCp2YLNtGRbs0PzUYK7A/VyVbVGf3oKv7E
X-Gm-Gg: Acq92OHCzRtAQkwShUaMoby3HoFVtM5bD8VntOTUFw/tWUrSTdENHlOnlH2csx995A7
	GnadEiiv9Ktd7pYZQM5BJ2EycT7DRWpbo5iRZ9kXpPoh2v2RupV9LJ5Tutqbn/gCjT/kuT57EsQ
	80DDlb7WP2v/sDyfKr0PNo/u5MJl4zlzUfGduvkwXZlyK1mh5s762SjY8TGnmZtHMgiYxUIUSNQ
	vQJ9hZlhTUv1GCr9hOCRKArGSq1OqgG+ds6svoJ+dqWKxq0+L1GZ+2oqHV+vtKGbb4tXyAtNkSp
	xNUNQpEKBMdlF9JVlV4wNUGerSjs5QN6PLsyxUUlIgBBccRbcVHKRUcv/7cojcepN9uljXsP4cz
	iK10a7XdGcGI1mbAzlsaV9TcTUTx2MuEpKcAWvvxqgG1Un7jTmjau9n5GY5vFJsyEN9/OT7SrXC
	k7TLF6cWdEFpyQeYyElSvCB0TKITldMpClVBcCZOt/NzfHxGJpc6sAMKkx70d/HFxa0CDuJ4FZn
	iPdCsw8ydNu3JmmulTPOMzMkhU4bxM=
X-Received: by 2002:a05:6214:2b0c:b0:8c7:2be0:6c91 with SMTP id 6a1803df08f44-8ccefd9ea17mr119791426d6.28.1780231486169;
        Sun, 31 May 2026 05:44:46 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea061e87sm68138276d6.12.2026.05.31.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:44:45 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] tpm: tpm2-sessions: wait for async KPP completion in tpm_buf_append_salt
Date: Sun, 31 May 2026 08:44:28 -0400
Message-ID: <20260531124428.2304629-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

tpm_buf_append_salt() in drivers/char/tpm/tpm2-sessions.c calls
crypto_kpp_generate_public_key() and crypto_kpp_compute_shared_secret()
without installing a completion callback, discards both return values,
and immediately frees the kpp_request via kpp_request_free(). When the
resolved ecdh-nist-p256 KPP backend is asynchronous (atmel-ecc, HPRE,
keembay-ocs), either operation returns -EINPROGRESS and the deferred
completion worker dereferences the freed request.

The path fires automatically from the hwrng_fillfn kernel thread via
tpm_get_random -> tpm2_get_random -> tpm2_start_auth_session ->
tpm_buf_append_salt on every entropy poll, without any userland action.

Install crypto_req_done as the completion callback, wrap both KPP
operations in crypto_wait_req(), and propagate errors to the caller.
The wait is a no-op for synchronous backends.

Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v2: restructure the error cleanup into an explicit success return plus
    err_free_req/err_free_kpp labels, per review. No functional change.

Validation (QEMU x86_64, swtpm, async ecdh-nist-p256 stub backend):
  Unpatched, the deferred completion worker dereferences the freed
  kpp_request: KASAN slab-use-after-free with the allocation and free
  stacks both in tpm_buf_append_salt(), reached from
  tpm2_start_auth_session -> tpm2_get_random -> hwrng_fillfn with no
  userland action, then a NULL completion-pointer oops. Patched, the
  same setup is KASAN-clean across repeated entropy polls: the worker
  observes a live request and the free runs only after both KPP
  operations complete. With no accelerator present, the synchronous
  generic backend establishes sessions unchanged.

 drivers/char/tpm/tpm2-sessions.c | 45 ++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index c4da6fde748f4..f44646b26b192 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -489,15 +489,17 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
 	sha256_final(&sctx, out);
 }
 
-static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
-				struct tpm2_auth *auth)
+static int tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+			       struct tpm2_auth *auth)
 {
 	struct crypto_kpp *kpp;
 	struct kpp_request *req;
+	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist s[2], d[1];
 	struct ecdh p = {0};
 	u8 encoded_key[EC_PT_SZ], *x, *y;
 	unsigned int buf_len;
+	int rc;
 
 	/* secret is two sized points */
 	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
@@ -520,14 +522,15 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	kpp = crypto_alloc_kpp("ecdh-nist-p256", CRYPTO_ALG_INTERNAL, 0);
 	if (IS_ERR(kpp)) {
 		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
-		return;
+		return PTR_ERR(kpp);
 	}
 
 	buf_len = crypto_ecdh_key_len(&p);
 	if (sizeof(encoded_key) < buf_len) {
 		dev_err(&chip->dev, "salt buffer too small needs %d\n",
 			buf_len);
-		goto out;
+		rc = -EINVAL;
+		goto err_free_kpp;
 	}
 	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
 	/* this generates a random private key */
@@ -535,11 +538,17 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 
 	/* salt is now the public point of this private key */
 	req = kpp_request_alloc(kpp, GFP_KERNEL);
-	if (!req)
-		goto out;
+	if (!req) {
+		rc = -ENOMEM;
+		goto err_free_kpp;
+	}
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &wait);
 	kpp_request_set_input(req, NULL, 0);
 	kpp_request_set_output(req, s, EC_PT_SZ*2);
-	crypto_kpp_generate_public_key(req);
+	rc = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
+	if (rc)
+		goto err_free_req;
 	/*
 	 * we're not done: now we have to compute the shared secret
 	 * which is our private key multiplied by the tpm_key public
@@ -551,8 +560,9 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	kpp_request_set_input(req, s, EC_PT_SZ*2);
 	sg_init_one(d, auth->salt, EC_PT_SZ);
 	kpp_request_set_output(req, d, EC_PT_SZ);
-	crypto_kpp_compute_shared_secret(req);
-	kpp_request_free(req);
+	rc = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &wait);
+	if (rc)
+		goto err_free_req;
 
 	/*
 	 * pass the shared secret through KDFe for salt. Note salt
@@ -562,8 +572,16 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	 */
 	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
 
- out:
+	kpp_request_free(req);
 	crypto_free_kpp(kpp);
+	return 0;
+
+err_free_req:
+	kpp_request_free(req);
+
+err_free_kpp:
+	crypto_free_kpp(kpp);
+	return rc;
 }
 
 /**
@@ -1018,7 +1036,12 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
 
 	/* append encrypted salt and squirrel away unencrypted in auth */
-	tpm_buf_append_salt(&buf, chip, auth);
+	rc = tpm_buf_append_salt(&buf, chip, auth);
+	if (rc) {
+		tpm2_flush_context(chip, null_key);
+		tpm_buf_destroy(&buf);
+		goto out;
+	}
 	/* session type (HMAC, audit or policy) */
 	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
 
-- 
2.53.0

