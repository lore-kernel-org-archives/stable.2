Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8D392822
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574930; cv=none; b=GXc0mUzAH9xSzgKjBw6J0t2Qor3l7QCfXnp6sos81Q3BQMfO5uXVhEP3uHporpSn6qM51zCu1bZG/G78qoERFx34qGbolaFD8cIy9Fn6DCgeA2KmsRGQ1Ax7yhRovMobVVqQjVN0LV9Ihxb2GKK5hsIxqFN0GrqW+28sPYOK6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574930; c=relaxed/simple;
	bh=xGOyn27kAb2aUQ2aktYzNNe4IoaFrQIOT8r1ok3Xtr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDGBcKQPxDNpmsP3/MZlvIxfVh2e5W/3EWFFFFKTRvUoFg4oiUXocv70TOJxCbClti8YTaJ72aVxUBkJuvgGL+vt/Y7SsFaGslt10Lk7yVk1CY6u3QEne9ETxZGjV+47sYC4or6ZwDCaf33ZEEOst9hEezHQL7X19mZy3YQ1CVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=boesQUmc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="boesQUmc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47de0093c42so5761656f8f.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784574927; x=1785179727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5XDxWfj8KWZ9DgniRwAUL8R0m0HpW65KqxOgihYK1aU=;
        b=boesQUmcQve0LMfhp8Sq8RPEztONnkxYK9HAlpScNDaJZVI6NdiLf5cxWAozBZIvgB
         DpbTKWb/uSgIZxf7BsQDfbDxAfRq16VqzmPnhXrZWNzwZPSmPUXUO5gCVINPbhNPbVbo
         iUMPd4r+QKJV/JjOaSACnaOWS/9M8JgMFl6DKpmqVjjG0mqkKJ0NpNu72WllB9+EuoYF
         idCnNxdAv2bHOKs7ABSfxONA1R4/rFWwHGVdwKlHADqeT5ppGpmdEPIT3dYNYyzPLELp
         alKdijUvXcdFd9o8iAru8fXgfk1bFhrwdddU2VFskSfvypgzduhCAS1AeL9Cfv8c12pv
         GdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574927; x=1785179727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5XDxWfj8KWZ9DgniRwAUL8R0m0HpW65KqxOgihYK1aU=;
        b=d7Z6sLq9FWHoSncpK1sR0wkspNxcUVZs4vDx+57Z5mcxiYUuBA0riKwsCq/FEC7UiH
         A47KqVUd4884b0gWL2NmpnAMvy5Qzaz0lhuF9oprFOSF1ew8wSRFfa2bRVkz7KeWL1x+
         lR7+z6brNphNW/AV2dEMxJpFbt7wNXjLWPBJJEIdU43vsKVS5rsWJSKJbmFJVvJldSty
         9+pbauPaE7ZMg7i9PBz74Zg7XjlYWBubKehIrL0TUcIgyhUlvyYtp4mxfs3hxfeRKLiD
         FqDIizTwINUOh6w8ShJhSNBumL4I+TppCJ9ESBR7WedIbAKCXdUgpsn/ainU7n2mrFA+
         +YGQ==
X-Gm-Message-State: AOJu0YxNICHan5cSbQyi+nyckULzH11Ty3xPk/ce9ny5s/txVvoNvC0o
	zQ5wrCI5Thk8R6vObp7Lp4WHgdBZos2e8WpMuwW2RVEsYcx7QTRQjqdf0SXzcxCAh67IppKiJvR
	I23UD0Q==
X-Gm-Gg: AR+sD12WKzx+46taasA0tjmppNho9WvsZv9U2JNlU3o4WVszHXqlsSo0kDoFlonIR2X
	LbhAlTidf5buBRq1pNjketoKih7X+wuvF4RWsHjGPDmTn1Gtm+g6poFrf064TMpWUkK5Z8syyug
	spUZQM37cPVrI42Jy60bqb7i6N3s/aJ4LbVH1h/GVDZIP4O/mcNpxh+OUtFqnTqe00TezoF1vmW
	xwOi8QEYCKF7lg8paPGNKM6UqT+jGJ+t9yq7bAvp7dWq7hc+pOfRQ5w80A7p5sanp+jWZjMsM0d
	VvPzMajj4jnm77jn5RL8f6XBvMlhZXHvDXIQ0lfoaa9os1H70MAYhJ2zmXFbpQsGYWTXf5yY3YA
	Q32wkziI8TaY/LzEf88mwwBzx9H7j3uh5QmlA8nH9SrlKRgPnp37Kx9j7BvpCmNCKOVPtjc+3RZ
	3fj+FD/+La8sLbJ4IariJ7wv9G21WxxM4LOKo1UR8bZs+3DW8XLz9K0g6AMoIqyJ1iuQudnRGBz
	8EX+K5L3qEVvi07bBlNRFol
X-Received: by 2002:a5d:5d82:0:b0:47f:59b4:390c with SMTP id ffacd0b85a97d-47f62329496mr17832694f8f.50.1784574927315;
        Mon, 20 Jul 2026 12:15:27 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee926dsm30211503f8f.35.2026.07.20.12.15.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 12:15:26 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: stable@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH 6.1/6.6/6.12.y] crypto: rsa-pkcs1pad: Don't WARN on an empty digest
Date: Mon, 20 Jul 2026 21:15:25 +0200
Message-ID: <20260720191525.15450-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KEYCTL_PKEY_VERIFY lets an unprivileged caller supply a zero-length
digest (in_len == 0).  keyctl_pkey_params_get_2() accepts the zero
length and the request reaches pkcs1pad_verify(), where the empty
digest is rejected but only after being passed through
WARN_ON(!digest_size).  The warning is therefore directly
user-triggerable, and on kernels built with panic_on_warn=1 an
unprivileged process can panic the machine -- a local denial of
service.  Reproduced as UID 65534 in a setuid sandbox.

Keep rejecting the invalid request with -EINVAL, but do not emit a
warning for the user-controlled length.

Mainline does not contain this code path; commit 1e562deacecc
("crypto: rsassa-pkcs1 - Migrate to sig_alg backend") removed
pkcs1pad_verify() in v6.13-rc1.  This is a minimal fix for the
affected stable branches.  It applies as-is to 6.1.y, 6.6.y and
6.12.y (identical pkcs1pad_verify); the 5.10.y/5.15.y form is sent
as a separate patch due to the older req->dst_len spelling.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: c7381b012872 ("crypto: akcipher - new verify API for public key algorithms")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 crypto/rsa-pkcs1pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index cd501195f34a..225fcc3377dd 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -557,7 +557,7 @@ static int pkcs1pad_verify(struct akcipher_request *req)
 	const unsigned int digest_size = req->dst_len;
 	int err;
 
-	if (WARN_ON(req->dst) || WARN_ON(!digest_size) ||
+	if (WARN_ON(req->dst) || !digest_size ||
 	    !ctx->key_size || sig_size != ctx->key_size)
 		return -EINVAL;
 
-- 
2.43.0

