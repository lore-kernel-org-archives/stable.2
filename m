Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049151;
	b=kX5s5GZ/6h6ZwFTzh9HWnOzE8teBgTAfMDTOwAXWqpaODL5NDdet8f7OXRL5/54DYZMQ
	 9IiFo5nRSa1ZA2kmNYEEBeUdLg8UI4vDEi2OS9f+bJfzDzLxu9R2P4lsLxIzS44McPE3T
	 2knAVXilxUlecs2SJC81oyMoM1aDEuo8qXziqI0ZvkI5w2yjO3Zeb5LNZetKx49gKXVbx
	 QK3LTMd52ZrQLRZvcpjMTI5mAyvspRuc9txDb3T6sK6uImFEXXMiRfSkgkL+v3oyHoLNq
	 eTDYmM3J4G4WKxDRiQOL4EPajk3C5w9JuE4ElKNipFxwfMn72Uqe1rz0n6QPrQRwhZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5hQ8m/HzgTy2gabKpmizy1/gPFbpcW7ybcVUB9zx3Qc=;
	b=DwsUzA4s0fbAB4UhBlp3eVWiNv5/3Oxh7JKTTCDWa03KxZ9xMN3bJk39bMaUPxF1lZLg
	 d4j9MTWP4Zlh8qGi9kLPz90LgMz8/sdrcs9j3YZJKjTsrNvHP2WLch3YaDpqznj9tM5l6
	 hRYxx+02+jb0kfLWFOa2uFSHT2z7rPygwMLMfchteN+c62br28m3XxGOesRi4S6A2CONR
	 7S+C4XjXriN6G4plIgnlFBXe5AyoZP9g/NvVysdxsho6lLZ2v/qggo8BlhvdQuLhIoVZS
	 QmZQvkmAsGieb4H2fWOcnSqo0KQOp5Pxu3GsYf8nZgMgsTsTnaTyf7l7VqeikR+Q5OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dH5A7Fuf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F1606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dH5A7Fuf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14181F00907;
	Sat,  7 Nov 2026 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049151;
	bh=5hQ8m/HzgTy2gabKpmizy1/gPFbpcW7ybcVUB9zx3Qc=;
	h=From:To:Cc:Subject:Date;
	b=dH5A7FufA8aimlh35H4VJderYG1wvt6JSZWMmT3qs1oFz50/UvK3ZykcelYSheK7H
	 R4WJFbKzfyUZKtN4yCKqcR3qr8d/ZvMdQf7Ohb2SMBHIcC31KQ390vlEIrL+5D4Esy
	 74knchRczWK4o7AGAD7jv1wZvyMPjt9/SYXCoR7STz7BLM3q0kx7xFr4jWWrNOpFHp
	 MKJbuf7homg86RXu71e0oZZKfB4EVycbw7hDsrb1yeb3IgsX4o7U+ZLyYsIbLRiEZ7
	 STlSvVgHoHI4co/JKt8Yp53aePWpps+j8unQIilW/uJp2297DakYWptGOovx0Ws12E
	 F7sIUAKqP8k5g==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-des - fix crypto engine cleanup" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:09 -0500
Message-ID: <20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 12 Sep 2026 22:41:16 +0800
Subject: [PATCH] crypto: omap-des - fix crypto engine cleanup

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
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 3b7104cb4487b..4b5a8d13f505e 100644
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
2.53.0




