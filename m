Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6307347FFE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789224094; cv=none; b=EN+zrnpU11/gtu0fG6pNDEu4hurcpMmVr0W+yrvkLugcQzl7lnXE9WIKuonIe6Mn8f2s7IIk9bsQ/RzBenv4c02JyYz+TORqBd2+biLtM9bJpQNdw6jvSCPqP1MhMlkpUImrDt1yGH+YoZAbiEX7IhR8TaVQfRfvyG224uzl6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789224094; c=relaxed/simple;
	bh=jJUwvssp7BgAozkd0V89n4c6un4uRRFWxtfNl6AYC6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEa7bnqpJDIuK33fz+K3M+n2vNm4VvGNyTt8FYR9KM0QE2E18q+vmCmalVLf2qETRx8uIQbHoYzgKhh4AOOXMXd/2zQOQLiHmdrU7ZOLjDVm4UIIYR6CJ54BNBjujQKQv0diIeTIoAOoVRyA410Ww/lNbZLpZE9nDXUl5qcOzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ/rLwO4; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ/rLwO4"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso532499a91.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789224088; x=1789828888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iIsKkBRVqKHVlP9edUOYmG2b5QsoU5qyf6y8sJGrYtM=;
        b=nQ/rLwO43nAkQ9uAZK9C0K0P+lmIPrA9Y50Ghd+6vzT2l6dtVZzxA9bidBPftsb2a1
         QfpvaQBFddJ/mo8HKUxIhRltiqhZYKI6MxDF7aCUR8uHDU0VAkpqxudhlaUQjQe2mM70
         bO6Sli5m7RsEhB12bgDJSjobxDeVHMm/4QAII3beruf88NnV5j89VWo5aXAWpy+v10vh
         L6GihFzxHlzNiWU/l59EVkQiuOAJr0Sw2aXgEyzKcAyFzJbBKGKnzsmSFbL20oqaO7bC
         D5/aIvS6p8Y0QcuRaDH+KOw/emot6O76mZzv5+l8L5aExBx2dTpXl+nM9XMpJQWmmYmh
         LYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789224088; x=1789828888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iIsKkBRVqKHVlP9edUOYmG2b5QsoU5qyf6y8sJGrYtM=;
        b=LiBoP2hFxLPF5Qz08A2kqJDVFFxySWedqHI/huagA15rBDnrAz3LVed4w64isyPqdk
         wCyO2R5O/S06WNg81zBv3r/TDB7dZo1gONfatTt59+QsTeqiZOzAkdRaiJ4qzptZgVzA
         TFzVbuGUBcpnLwtq14yFGzEOr4hTyVWjZCdYNcLAfPRi1Lsh581/1b7F0uLqc4KJlLpL
         iqIzDRuw1K8ZFYw+5FCodMKxfQOsNv22EAPA6sRsd96KHlsey6U0OkqJ6+k+cDOKSErJ
         ntgC7vCsT16rn34vR05PG0xoTAEJGC/abgx0EbXd3mSufDy8TABx0iX6+aMwBt5mKlmf
         3cJw==
X-Forwarded-Encrypted: i=1; AKwUvByRDFZ2g2wL3W9OUKxRxelyKhol7mHJFrrVM+Ex8kIRFfhOYzUm6fHNW8ZhNaNePaDvA9EL7oY=@vger.kernel.org
X-Gm-Message-State: AFuF++nwhIJPR3sz9Yz0Kw5VxH8XZNnLtW01z7YmfB5+5szTcvy+2xTJ
	kwnoMO2pq5iLyx/0L1rOeEjyS9ujx9sjXFk4m7pK44Va2phbzAzxA6dTKGL/ZGHU
X-Gm-Gg: AYBFou0lQkgocLKDMpKKROyh1bq8Jb11SEqwd432RjdGThxO4OYUAGhRI9ivRYagkyB
	CaynbwaPpWyY1ynu4dcIwZ8RkkeYb7obDi9n9obvy+PUhTsQwHlilktqTiRkwGGR+6cNcNMnz8p
	kAzQav0IqXnvPcJQfzZnQRDzBRTr5IoXPM1ikXpbz+xyhUVl3oYNn65w0vqsV/eyD9pESgxwnjh
	50O+RcQHh3FzIb91XcwmHayJMn6eD6Pxz/JA5mExA2NjVegYJYodV10enUEt/E/njNYbx2euU7m
	ei8YxVXKD3gXZ2hqdueCN2Q8Gv8eipmcFLs8ANIsaKUWxUtHWFbP9s5JmeMn8XZmWMw/T3ObtFb
	VD9nTEhUXQdUL56N8cJnY6pDCk6gnxfHeH2whbtPIPV8fDv6KMGADSPylfQIOLaTqQ3t93S06Dd
	WuJk7okX3KPpvYI49fhOw1N1HQEJBdC8NA2rLww1wk79dB8VvIvlxmOw==
X-Received: by 2002:a17:90b:548f:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-39d9c1db3d4mr16333966a91.14.1789224087801;
        Sat, 12 Sep 2026 07:41:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e60484sm10380257a91.4.2026.09.12.07.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 07:41:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: omap-des: fix crypto engine cleanup
Date: Sat, 12 Sep 2026 22:41:16 +0800
Message-ID: <20260912144116.993932-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_des_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: f1b77aaca85a ("crypto: omap-des - Integrate with the crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 3b7104cb4487..4b5a8d13f505 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1082,6 +1082,8 @@ static void omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.43.0

