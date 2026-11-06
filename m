Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995474;
	b=by0EKX6lFitGpGE5IYKJVZiLKcLUNcVek9AptNlJAUkAZtl15YaP6F3IFWrNemN1PmHO
	 pK7aK3JCLERo2aM7N0KjA1JUfTJ/6ss4r/LIpKPwlySYQdFyMOq7N+hyLoGarMQSAN0tH
	 9lxBHlEVnSiM+lVxIH8AnxOj5mfqiYeZHmKD3fVxQstmxOOQWn51QloMy+XBpW2TawNxm
	 Al9CZSuDZuU8um+x9zM7Th3BzKR64ZCCDVuMe3uoQIWLcy4bsRm7jU1WbOkQul8OSYZV8
	 1//ef/vW7rhxML3JYg59tv9xei1VKZ14beksGQgsgvw8Awy1+FCAIOceX0Nw3O6Btdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qdzzuDHKyfn9MEDqIa+4Jje9jOJuwPCdKzFPnU5vUZU=;
	b=tkGyA7JVyn9ykYee8WWuK07/KaN0B4fn2cNoF7TFYBE+GC45GpTy2RiRB6HcgCg+cfFi
	 GPYM3CNgG4LcIoiV3QoAReKfZ5+Bu94Abm3VPgSjODL5FipmR2e20339BMdK8/oaVpBO1
	 6mCvpDoU55FprnfSsDrpCuNiislO6gXswXGdRhJVarrJVDtRo7l4Ltrnypa8QSuaDoJug
	 XoA5kxOqZoeT5NcAnAYLVQjVZYYulInirbS6n3ZFfHNjrmMSkHJLtft3gAovyb5VLbooU
	 yRNZLJ15QptOi7KYbJP9aZ2WRMLiaRtsnrHoYcs+ZUlC/fvulf20RjzA3WWIQH/BU/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EaSKAHq;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86210606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 20:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86210606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EaSKAHq
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so10441585e9.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995473; x=1794600273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qdzzuDHKyfn9MEDqIa+4Jje9jOJuwPCdKzFPnU5vUZU=;
        b=0EaSKAHqfT6MH8ZkinKIWE9zvrSc79drozCAYUhfgwN1m4IXV5z8n7RslTiGPtjbks
         8vK9vNKjmpB2vCiu82GrSYnB7PriyUI9woE+kdH/u1SeQ6RDamBgmFLd3Q3y6RWgAYpL
         gmxNBdiPLUIC9Iq9auW8I24skXfVqMt1s8SVEl5yAEoY0A/eN2BAwW7kWLtmS4SMKYau
         6RTbon4zvOqZi9yMA+4XmSKUmzQReJL1OAEaiOteb/X1HYQoOIwIMqUPcm1S8w/mM2SU
         tMZhlgkHK0CHkJKjkLF+F+7KNVaEUCCaTOShURJCGPeygCU6Z11sKRGrVyg+Xz7e3+Ob
         yz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995473; x=1794600273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdzzuDHKyfn9MEDqIa+4Jje9jOJuwPCdKzFPnU5vUZU=;
        b=bvkY/gKHNmR+HYvNnOVySHuh4sdNu9Lk9dnbwwvcr2Kqpa4Ih8HF0DYtQr1/1SNR6h
         zU+B7wrio/LuqcwbcJL7XRMuE4LkIwBEgEIY3aIjYGEQKOXwJzX7PXiv4VASZNzlgb/9
         K3iRU7ny7R292ZYHZKtY5VTV225KCrzDDvUphqsD/tgXvKj5BqhU74ZmKKGqEVQuLKYL
         i9DtOl2ux0B0gyblrL8q9okVPk3qG+gVvXmJz3xJH4xGYklQh7L74xmkY09f2hsm5hVj
         QB8SYUe5EreoWAAAf9kmX4YXlAoe/YaLMHvtSTmUARxvaJJS1pbl9ZmaY6wGBZnQDFUt
         klDQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6uY3KWWIZp+cVnJchBDrKByY+kPh0xG+JM9Bf0nbV+r0lBfipuksFL362+BgPqzZ2ZaBeARk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hRaZYvVm415d6OLdcWDfzP4uhnfZehUAnIqO7Ys9GqI2HOw1K
	R4d5E+42+ZD0d1UYgbK7OaSvTN6cHELITRHv3omjlGfP0ZYVKeGjNdzDyUyGZWONvqQYlVHD
X-Gm-Gg: AYBFou1XL++Duc2Zvgfa1/Brj9iCg7gBjXdk2FkEuPwbPg/6yPXZCKBCYxEWBoypMv3
	BPb/i//Rs66gmGbuqnsvaTkssPjW76D2Mjuq836WOWKvEv0nOwAJKi9luJsSvHOUsATIN1T7YTj
	eYV8bRlNteZcXG2rnvkKxTWVvVvR0KjElZNi53LeHWTRxPS0vZBBTLA9ITBCKq7l4vHrpwcgMsJ
	9S0h7Cy+1ywFXSWdeXEMAlKvdGjaJMRaX32c7Te0DV8hHSaJoOL0wpHSZV6kSvfpGZLDCU7uW4j
	3UI7qyoITdVgGFTkEJtqNsKVmxYl3Hgr2GwFG7SfZdZiLQg4VfuWogffVDebyfzvu0KoRQvYoHl
	Al0NMtpRUjx9+Rmp0ZnheeDlcvW+bRz2elaOhHoESEkaiFJzhajnZvFgVHRaejIBIW8wY84QVcb
	nNd0yZKxypXqD4yvWYkxAGuRlI6yv9fk4nTV1uMOeCjf87pxautp/NeaNNFec5MA8EqbmtMsKYK
	kS868dQtqMxjnAYanvmKnKo5nSWdCcYETlgQDd7/VDVBq5y4LoTlPKGfhc7L5oQgLIxLOnwHguz
	hh7PcgzqwaC1dOhnBizj5DvIcvIEAuNQu19ZmA==
X-Received: by 2002:a05:600c:3ba0:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4b6db1c5f48mr71249715e9.4.1793995472786;
        Fri, 06 Nov 2026 12:04:32 -0800 (PST)
Received: from fedora.domain.name ([217.218.152.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cbdb9cdsm16959195e9.1.2026.11.06.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:04:32 -0800 (PST)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: ampr.mhd@gmail.com
Cc: dhowells@redhat.com,
	lukas@wunner.de,
	ignat@cloudflare.com,
	herbert@gondor.apana.org.au,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] pkcs7: Return -EOPNOTSUPP for data-taking algorithms in pkcs7_get_digest()
Date: Fri,  6 Nov 2026 23:33:56 +0330
Message-ID: <20261106200423.37769-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
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

pkcs7_get_digest() is documented to return a digest for IMA to use
when verifying a modsig.  For signature algorithms where the public
key algorithm consumes the raw data rather than a precomputed hash
(algo_takes_data, currently ML-DSA), pkcs7_digest() does not produce
an intermediate digest.

When such a signature has no authenticated attributes, sig->m points
at the raw data and m_free is false, so the existing check rejects it.
But when the signature does have authenticated attributes, sig->m is
an allocated buffer containing a modified copy of the AuthAttrs and
m_free is true.  The existing check therefore returns that buffer to
the caller as if it were a digest.

Test for algo_takes_data directly and report that no digest is
available, before attempting to call pkcs7_digest().  This covers
both ML-DSA cases consistently and removes the now-dead m_free check.

The only in-tree caller, ima_collect_modsig(), does not check the
return value of pkcs7_get_digest(); for a data-taking algorithm it
will now leave the digest fields unset and fall through with no
digest, which is the correct outcome for an algorithm that does not
produce an intermediate digest.  Callers that do care can detect the
new -EOPNOTSUPP return.

Fixes: f3eccecd782d ("pkcs7: Allow the signing algo to do whatever digestion it wants itself")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
v2:
 - Add algorithm name to the pr_notice_once() message (Ignat)
 - Add Fixes: and Cc: stable tags (Ignat)

 crypto/asymmetric_keys/pkcs7_verify.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 474e2c1ae21b..c2e0eda502e2 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -147,14 +147,15 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
 	if (sinfo == NULL || sinfo->next != NULL)
 		return -EBADMSG;
 
+	if (sinfo->sig->algo_takes_data) {
+		pr_notice_once("%s: No digest for data-taking algorithm (%s)\n",
+			       __func__, sinfo->sig->pkey_algo);
+		return -EOPNOTSUPP;
+	}
+
 	ret = pkcs7_digest(pkcs7, sinfo);
 	if (ret)
 		return ret;
-	if (!sinfo->sig->m_free) {
-		pr_notice_once("%s: No digest available\n", __func__);
-		return -EINVAL; /* TODO: MLDSA doesn't necessarily calculate an
-				 * intermediate digest. */
-	}
 
 	*buf = sinfo->sig->m;
 	*len = sinfo->sig->m_size;
-- 
2.55.0

