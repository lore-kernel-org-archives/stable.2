Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412E3939AF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574938; cv=none; b=Xem+o/kqx/zaFg5SyccW6qTC72GAy77o3YdzAckoeYsh4Y/roxnMrtwCBjJYz/QF5HO3v+u1Tyt0Xu2qZwlgRyS/3BpdkUw1gnikYWbUJtJDK48bFzKk3gKI1XF9kEGzvHVwXrdRgMt5zdoCwd07xypwTXwcaziPxPtZH6zRQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574938; c=relaxed/simple;
	bh=n4rtoVBivuuxT8maYZ6GjwI9IH0POieenNXxUQeibjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAh077UVRiYTOKOmxELGl7TKow3sf0CUnF9yaYyC8bEoEAaUbVjahMBDyjxbQv/YoMYHCx5kRdA353fg2n14l/AUokOfySrNo7TAj2TEYkKX4DcQsGeFu+D7e7yhMbeKd3ihSv2mQkZ/nVJR02YrCpW9Bpb3qDdNPlobxROLwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=u9lMWM72; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="u9lMWM72"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so21944245e9.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784574936; x=1785179736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7MPEl8CVn5sXC9/GdUGvs1DC58WkPmH4mOB5joq72dw=;
        b=u9lMWM72G/OAeZj78uLjzvqNXEjN7oH/OyKK6cZkqzBt/cbhh/BapH4YoEkuUBZLzQ
         278JUNxVn5eDSq+DHDkc1q5HaJzd4YDqZT68/sEsFO9zNirEtT1xGRA+zt8BpY6wLS1n
         a5kYY75Bklki2CzDMux+kJsbbo3CC8AMl6Oei23JXm4WBI/t4udQzvEn40pm5tlZOjWA
         c81+Y+FdHqKNjnlGX71tqpdQhsUqBi38+WnbbvbesIfAsblqj63AXtJ6KpK4j1BGUu2I
         IAhANa07xu8ELHGjOqWFMHcHBazaWUQKaLcAHtqnB4YknNrKR744glFWs5dkw30jEwiB
         0y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574936; x=1785179736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MPEl8CVn5sXC9/GdUGvs1DC58WkPmH4mOB5joq72dw=;
        b=msYJsrh9Ahf0Pz80RZji0OtQ4deDJYkWREZH1oL3exzv5JMc8bW3ceTEjn33Z2b9cJ
         /ArXCL8ohirC8nAORsYIySV4GC24iAru0rGA7hGc+35+6ds1TJQFtISUJ5uqJzer9wcm
         b+eEumHLPKpOJyAAFXak1FDpcY6hXWSzZ1Qs4RbvDhLe2JkYXYxk8ID029J1BL8AyL9T
         neAbxhlA2AHsWpYYcVx4lox+1cHu2qv0uFrOOqCqiZKRm4vsxaqYBLcEqD9KoiimOnnD
         1L/EH+G74eg+Z86t81WmoaaGCBjbgd21f9V5rq6t5Tq58aAkadnvQhWRooHzRMUtK+kL
         tlhA==
X-Gm-Message-State: AOJu0Yw8DIaejLuLazujjUlfMlLu+Bo2/m4zEkKFDEecozZ/qsn4D8dj
	aNbFYDHMQbT1O3V7A7ohhxluqY5qVl04wK4vFf//MRnDo50fbSk1lF6qAVAlwe8I3GRtSWpqQT9
	S+IYX/Q==
X-Gm-Gg: AfdE7cns4BCX3kZLXzEPYsg0gTY0oHojq91rJiIch0xcGBEb9UMozmX+MNnVKMFEZEU
	E1jiAiZiyvWlCM0JAKEnYSelOYzmXj/1DzQyJ4ETOvjdU5u+pxiPoIR/F1vh9Ogl4UwPvrvspkH
	HMOjqrR6YcQKkp6He2KfuHH8uswzXW6x7aAy2Ajz4pSaQlkyXxEbnC/NulujL75eRnigAZmj52V
	fSSLmtxtAofvue5cnNO/fjO3QEcOwRVgw9jmvQXaGODdMMUonKobStWVWJ6EoEnxl20CGf/+Mtc
	7GIXvmhUhB+uDiByzakqQrgFfkgi3p/J5/EUH8Wclve4FLXs+koV8sDfMtxNbYOtLsAiKYqh/g6
	HIMHT91oc8TLdjNrCWUJ3OfWhT280X0z3nqcFnj3R8ZjXhxyV4PjeRynzgD+3Snc2/MnHS6eC9u
	KfDsvIhuVQAMHdVoRRvJCTIvU7si7v6hzjaelP9HFFMILuSHhrePgSdPahCjFIBGTfsWa4QnR1B
	9iM+PZOtw3NDmrecFHNIM+eShbtF4olKz9hJkpq98F0FQ==
X-Received: by 2002:a05:600c:3153:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-4954a41382fmr186525145e9.39.1784574935532;
        Mon, 20 Jul 2026 12:15:35 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49500sm34232061f8f.2.2026.07.20.12.15.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 12:15:35 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: stable@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH 5.10/5.15.y] crypto: rsa-pkcs1pad: Don't WARN on an empty digest
Date: Mon, 20 Jul 2026 21:15:33 +0200
Message-ID: <20260720191533.15971-1-doruk@0sec.ai>
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
WARN_ON(!req->dst_len).  The warning is therefore directly
user-triggerable, and on kernels built with panic_on_warn=1 an
unprivileged process can panic the machine -- a local denial of
service.  Reproduced as UID 65534 in a setuid sandbox.

Keep rejecting the invalid request with -EINVAL, but do not emit a
warning for the user-controlled length.

This is the 5.10.y/5.15.y form of the fix, where the length is read
directly from req->dst_len rather than cached in a digest_size local.
Mainline does not contain this code path; commit 1e562deacecc
("crypto: rsassa-pkcs1 - Migrate to sig_alg backend") removed
pkcs1pad_verify() in v6.13-rc1.  This is a minimal fix for the
affected stable branches.  The 6.1.y/6.6.y/6.12.y form
(WARN_ON(!digest_size)) is sent as a separate patch.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: c7381b012872 ("crypto: akcipher - new verify API for public key algorithms")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 crypto/rsa-pkcs1pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index e2f4ccbd71dd..d10076bb6ec2 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -535,7 +535,7 @@ static int pkcs1pad_verify(struct akcipher_request *req)
 	int err;
 
 	if (WARN_ON(req->dst) ||
-	    WARN_ON(!req->dst_len) ||
+	    !req->dst_len ||
 	    !ctx->key_size || req->src_len != ctx->key_size)
 		return -EINVAL;
 
-- 
2.43.0

