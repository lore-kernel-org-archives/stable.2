Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316165;
	b=B2nvelW9upIREOmoWtyqE+rdZzdYp5heX/K+Hr5obXj848T97OFU5TdDHbRCMyxoKUwT
	 YJoRl38VKIGA/he7+TtHwqXTAAgdOWc3S3EN7UQkwhCX76N/PNmAee7dbZcYCk0dMMA3q
	 U000u/c2HGeJrQUBitKBzofoPSsg7i6LzvFK/0Pg9KGBafMy8IUB2ZHwlFjiONESXScjT
	 UYCeMJhN/vex9UnsivBtwYhY7oyfAlduclMgMcgL3phr+wkqk/hhWePS1rLSBFQv5oKJG
	 y80l2vskpqEYuPaIeRQAKyD6tVQ+BqYQEQcG4DzI+G8dmXse+HHnq7wz6u2+qwp251w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SI0P0srWUkgcMyNpPsHdJEstMmVWrGkD6wUWWQRSNvs=;
	b=5PL9wqpflZM4RY83T4jlbqzRCGWFPKk1wOymFk5BNI0iaUjKhROsEb6AfTXVGuvQQJPL
	 kXC+40w8RbgxFqKsPVNsUvacgJC8Euhb9erARTV9eJx3mYbPiqLP/SE/jiuial8UVgDMr
	 uFfysK8m8ishBsVTGalvauIyCojZKr0UR56pEnj0mwt7TnkkLz1UTBt/7blXnsvAoAAfh
	 9unm7QISggheWLbmkEewcmI/F1Fp8C1qVvIioH8wjnGDI2h6OZ1+4oIgC87L4SzbQcqiP
	 eZxr6Q7w0hS5WMXjHGEr4zcW9v0VvsDL5Nz4gSlOkEgbluhMJnAFUbwnuWz1KYF/pkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmcFmius;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74020606A7F5
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmcFmius
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A171F0089F;
	Tue, 10 Nov 2026 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316165;
	bh=SI0P0srWUkgcMyNpPsHdJEstMmVWrGkD6wUWWQRSNvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmcFmiusNk8hkVn+I5rDDWKzaDJ7E77FYARR8xcuD9dctt3efYEGbGqMASsKRNlBt
	 MOBa6o4TShX1jt/gv3tBW3mV2ZQnvTV5fzdiMXZenT9tkmgZ/VgfQSQFVXalmfNIIg
	 MrAKIxzyH/srNAX96fxxAMmDSEJlg4ZvhKUukjp2yxpZTDzWpzZmA5P2fbVfYSQcMo
	 lzeuhJoFd0+ibKY6MRsRTdpDmsrezZ3JKMVmO6v6EE0bXkodYWID307G8IZxNt7MXU
	 Ihs8QmGF5MZ+GSBYq0mazutdzo7/cRJpEPXVRmdaxwbbat+ZKm7fnG0HdfsVQV9yfc
	 +hcMuUDE4vM3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] crypto: omap-sham - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 08:09:22 -0500
Message-ID: <20261110130914.1637426-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110130914.1637426-1-sashal@kernel.org>
References: <20261107051708-failed-6.12-be51ea091c65@kernel.org>
 <20261110130914.1637426-1-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit be51ea091c6563158531e8c74e040552fdb1e28c ]

omap_sham_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: 133c3d434d91 ("crypto: omap-sham - convert to use crypto engine")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-sham.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 51842cf61995a..4f5e36197d3d7 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2210,6 +2210,7 @@ static void omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
 	omap_sham_unregister_algs(dd->pdata);
+	crypto_engine_exit(dd->engine);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

