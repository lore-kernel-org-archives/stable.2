Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1247606F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129930; cv=none; b=MMdWr06ctLKpmVuSApBdVIVGqYX8hf+UphhVWf/Tbw9oK4QrEA9PjDwzVlplhWzTP+D5FqD3Y5KI5QZukcYXgy/DUiOZCsi2NvQRE5GuUu4XQIejoDr0V4RGLYqDAqpDuKnnaZ6j1r7HOMie7+KEItSTaVXIOBMfn74q+wyYzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129930; c=relaxed/simple;
	bh=A2CvdhG7/vIyoUeGkv5E4Ugr/imarWjFKS/kJBdETX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeGYlhifGdMaZ4oxFieEgnul6WHuwMSN/SIOuPQ6GtfzZkaqQ1EQbwp5Q3ExYLxf6PMokFYc9hpaRkFYfBOKs1ZSw7Ci7dsccukHeR/Y9RadUqOlvuUDnx0RUiLnBaM5sYFKSUfvLKx8H5RVe5Af3uNnZ/+Psc/6WsUIeAcw2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTeLwa6L; arc=none smtp.client-ip=74.125.230.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTeLwa6L"
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a46d5c5bd7so5098141fa.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789129917; x=1789734717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QnJBFBfRn5myQJHTDGn3pEafZ8mzs7RtDdyu8ZdsQwo=;
        b=OTeLwa6LRDrdvM0CXgSsIkzWuO2Yf5+q1U55b8O8Qqd/AbLK4k7enyrGV2/RqenOEj
         V9X4RUQ7ELDWdYi02ArPQOXtf7XB1Swm1Tjjtl/T3a3/AJcHiy6BZUXTrcrmvlVFu84L
         zhBpIqa6SvG4eOvh0F+gBATF25vOkt7PqBn4rEa3fNpybAEuuOTVD0iPnfMRlK0D2uvb
         zaFiUABMEH8xSwsqxzg1ZQK/YdfX2ph38IynUMdFBGcO2VgRgJJgzBpBJ4pgpQjFu5QI
         cKLspNb4tk0W2qlQDl8Vsx/8NRZZoRz+GGCdz7LzTWseo6QZrlLbmfUeq8Tpv9lgYSgv
         vdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789129917; x=1789734717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QnJBFBfRn5myQJHTDGn3pEafZ8mzs7RtDdyu8ZdsQwo=;
        b=ba8CdzEwMYNED11kAuiN9Lf672Y5+sMK3to7pD6KykzYsG5Ui1XqXVwnZuotkSer2S
         1U8R9LhRFK/wDbkmhbAkyYzEjzHJiwoYvdu3cCoBmNRqtdFnxAWaOQm6ExLreVdv3ZXM
         YcxKpCkIrY4vdy6umtqnxWbYT0HviIjq2Ot8/IGJYEwxxvKHhRr3vJifLgfMvowWb9Fp
         e97ttzYcOw7r7WJew+0psUiEfL/76HV2m8ZrxD4XjUGTYC4k3G8rE971L2CQlNN5R6w7
         WEJOSqgVaGBCSv5Mu3rQHtgGJC+85qLdoFsVc7lBd2tGAujAPj1xdVVe+wHgdIBbl35E
         IC0w==
X-Gm-Message-State: AFuF++nVQq+6WKx4SyFu0Z/2w3Tp4rlS+U98e3ppmCrgLtNo6PXJv1xY
	w5VCQCBHyVe9iLVAt1C2YB1r/mu+2knWh+Cr86td4oQDuJDaFeVWN0ByVhEu8h120+8=
X-Gm-Gg: AYBFou32vZ82gg2AA9ZFKv0dZyF2GARbnZGNgL4I25n8jVxjjDwJw9+ZWi0DgT0N7Fg
	MfE3NwEtpyLJHHJXBYJEIysAwUJLHfuMrvRgR4PA1fHQAeWXo2B4aZ9UOyQMz1fXFIgJZd0nY8/
	hneOor1PbfjuKZ4gx2kuCSP7DLurgxr3CshB3t/VURYgWfAVPkiymw7hFc06LFhoFhBt9Bj+UwP
	90ECKu4qQ0SP+oPv0R7HKbfF8KKr82bXuouiep/GJdqyxLUzsqNxJP2laRk6fmitwoKZYlmhkII
	JYAiW4YHqNtF4/EUDooX6Ii+y3dYVNlfZ5udz6ENoBQ03rINe+UugmfvmRimasVZFbm0i8XjNfR
	kAwf82RcFZUphcQmuuFdaIfJGliXwaF/fehX2qbBw5iLEvCRlFMODnj9pLGpFYaqsn6kbKCS3yu
	nLSGKPVeQhz5JuyyU5+e1XzJluM57QLhx/QSgu2GUaYBCkhUw+kgI8vDhyOBnggx9iV2XL/jRrJ
	6rm5UfqA0/QJsgEGOYkqAy3354=
X-Received: by 2002:a05:6512:3f25:b0:5b6:1a7c:20 with SMTP id 2adb3069b0e04-5b8a032c8abmr874241e87.35.1789129916639;
        Fri, 11 Sep 2026 05:31:56 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a033149fsm576697e87.0.2026.09.11.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:31:56 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Joachim Vandersmissen <git@jvdsn.com>
Subject: [PATCH 5.10] crypto: ecdh - explicitly zeroize private_key
Date: Fri, 11 Sep 2026 15:31:37 +0300
Message-ID: <20260911123140.137198-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joachim Vandersmissen <git@jvdsn.com>

commit 73e5984e540a76a2ee1868b91590c922da8c24c9 upstream.

private_key is overwritten with the key parameter passed in by the
caller (if present), or alternatively a newly generated private key.
However, it is possible that the caller provides a key (or the newly
generated key) which is shorter than the previous key. In that
scenario, some key material from the previous key would not be
overwritten. The easiest solution is to explicitly zeroize the entire
private_key array first.

Note that this patch slightly changes the behavior of this function:
previously, if the ecc_gen_privkey failed, the old private_key would
remain. Now, the private_key is always zeroized. This behavior is
consistent with the case where params.key is set and ecc_is_key_valid
fails.

Signed-off-by: Joachim Vandersmissen <git@jvdsn.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ Roman: The zeroing is performed before ecdh_supported_curve() which is
not present in upstream but this does not change the fix's logic. ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for BDU:2025-00987

 crypto/ecdh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 96f80c8f8e30..2e7acfc42155 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -43,6 +43,8 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	    params.key_size > sizeof(ctx->private_key))
 		return -EINVAL;
 
+	memset(ctx->private_key, 0, sizeof(ctx->private_key));
+
 	ndigits = ecdh_supported_curve(params.curve_id);
 	if (!ndigits)
 		return -EINVAL;
-- 
2.53.0

