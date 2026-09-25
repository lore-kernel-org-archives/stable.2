Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F34C4F6C
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359130; cv=none; b=IuVyFomDSOMhEYtv1zkQxyQ1ZsGXdE2AS/uwonGwOHsrzWnSBv01TYrHwXiwyyc96Ku8JBJm68/PqV36qvJR8MnE9HuFCfYleP+Gab2k6HWoJTJB4mrLztI9Pgm7HuME+MwqV4P3E1EO5wO89WP3hK/QKOOXCUKK/q6QGZUSK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359130; c=relaxed/simple;
	bh=WeES9ehztCzHuWG2/5HTUKsw3379MCvE3CByP3cWqAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHRveVtmmP+xxxr28m5wEpg91CxEjf3o4HADWrG6HaxXCJSYEA8VdzPSHbP0jiocT/zbdpM2GXzsHLJ2iEUHDtLIqr2BKLMpqxNUgoT1gHXgItbev6nrZ2/4M5c7nUkZeIhv9rD5VG9TS8FIhma1woP8SNruFd5Q0rxKmz4+YyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWEGrZaz; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWEGrZaz"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d07so1010961c88.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790359127; x=1790963927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4KeerP0rGguZsopa+/cLzGOO6bpg54VomvE6LssK9/A=;
        b=QWEGrZaz7gG+6EucwChN4UIyyGtsk5PNUWRigdypXoXYD+r96HVLBZVx9pWhReN9dq
         ipvB5EfJFPu4+yI4viZfsvRg1Pt1/Lqm1ir9BlTDFQGoPDCLptA3jfcUbLTKub9t2I0n
         p7d4FC7g5nZTHXCcMIXNDcTkH9KGPgvwGyr3ORGhepHztp5XYdr99ofnXpRfcVnK1VP9
         23mThJi4BJeYVxjG5WL3cS/xB2/+zafeBCFbBLIicEYupGovXhpL/TT66hTjpvHLKK7Z
         9/XRl5jEoPmRzewJ44fvrTSpJnXvm+bthprv+6odQdxMjmSUhuoHGUI08Ykk3YPOmAoJ
         g7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359127; x=1790963927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KeerP0rGguZsopa+/cLzGOO6bpg54VomvE6LssK9/A=;
        b=L9NgYsvfrHl9epA0Gyaj45sCPNOE8N9XrTYWrHgJ0SRPWoKTQMoYzEfbuya0H/gIeb
         1e8XYH8RqE58jDM+bYkkHz8etGiQJLvOL8umBuSjm2J7a5cI8b+qFnq4AmG1BhEi5L30
         tNPggTFqy+/s9GS9GmqXVtQeJyAqvMJqq1aEh6AuayHZvOUG4SLEnoqYD9XLSiRQp9PC
         vyTZ2nl3icbQEaF/NSyGFQ/zXQo7K4hHJNVyb+4nLff3F/cP1a1VEhA//s2AgsK0Kwcp
         ZQaCEuxAGIvUl5uriRqLgvvsC1r8BSMYA0oybEkOKF+vHJ37HigJBuCJFZIxIa2pmmHz
         frLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyF6SxPeCKQEUjpgJ+7YyQ9AzBStI95SRqnSN1AEGUK8G7hTjeGZgU5PjkBh227HPqXgRP/4k=@vger.kernel.org
X-Gm-Message-State: AFuF++kznOp5bE/tdiqHm9zreNm4il4eZS6cNXPqGw/alWj+i6RDmvtT
	arShy41mepN2knE3U8bi5yeQSYkYunVrOfSjxzlbTY5rOYb96esyD70n
X-Gm-Gg: AYBFou0xJ4w9wHtkxB9/eQpOPidOCS4G7o2Lv6LrfaeVBillz8yc8vh85Z6ttSvUpCt
	WtA3yYcOGVbj/hxn6KDcDZtxRBse0MSlKzf648AdYokSQlRbSaLaR7Y+IVn1g+sdj5egcRQOe4Z
	hk7SM0p4xObeo9RsvojrEGPkoVwH4uD0zYpshntr+DNzYrfXOFJuw7VsSJZhH5DeizGRu3tzPRy
	T05ZIzA2GQfxjafvV2bwtx0dIjG1L1SYx24KdFBA78Hsztky4ZUUHsNx6UjmzQ/8Ea6zkcHXomw
	zdw8+JXHNYvMnVzwnMPzlhOZTBc1q/icEy0es8zbWcZWSbWrwLey4erpmZN1zq+/YHkrnVcjB0B
	+98kYtH95M7McnwHP7DetkrBAgUqActhryA9B94WPGS6Ah8lXZ6YfvTa6gQO121DmksiXqsT5YV
	xBUngfTll0CUbDMS+StXd+Td68D1WQWzdzxwvdO1Q9tLSJRhk3+uDtY61qzmkB8iM=
X-Received: by 2002:a05:701b:280c:b0:143:2702:7f1c with SMTP id a92af1059eb24-146d04955fbmr755336c88.37.1790359126735;
        Fri, 25 Sep 2026 10:58:46 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm5848605c88.11.2026.09.25.10.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:58:46 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: haren@us.ibm.com,
	herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] crypto: nx - validate 'ignore' before subtracting in decompress
Date: Fri, 25 Sep 2026 14:58:39 -0300
Message-ID: <20260925175839.3704942-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The decompress() function subtracts the header-supplied `ignore` value
(a u16 from the compressed stream) from `dlen` (the number of bytes
produced by the decompressor) without checking that ignore <= dlen.

If a caller decompresses a crafted buffer where `hdr->ignore` exceeds
the actual decompressed length, the subtraction wraps around to a
near-UINT_MAX value.  The subsequent memcpy() then copies gigabytes of
data past the destination buffer, causing an out-of-bounds kernel write.

Add a bounds check before the subtraction and return -EINVAL if the
value is inconsistent.

Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/crypto/nx/nx-842.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -421,6 +421,8 @@
 
 	slen -= spadding;
 
+	if (ignore > dlen)
+		return -EINVAL;
 	dlen -= ignore;
 	if (ignore)
 		pr_debug("ignoring last %x bytes\n", ignore);

-- 
2.43.0
