Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318060;
	b=SsR17Ooz5hoS5jDAocSzaP95dfLKqDo449K4PqwH3HFVZ8R4FzRJhEQpHcF7/AWDnqkm
	 XBp5tN/levH1+qJwjfCKdAFhSlPw7/cZLodOd5TkVrdJUXxHLVkJmtV6osjcdpZ2zcEcj
	 UCZ/LMHwA+IxIdkljq/5VTKyVlR3E0XMDSYZFdyyrb+nTzJe/WRNY1Mvj+p/PFyy6UXGi
	 feKkYTBKGYbTGxveE3UxTcvytfVfMLVOTfGaxpc28cI8R62qdvto4c27DG+01h1voLskL
	 Z9MpqE8QVNcJWW60u3Tc5W0pIQVwDvI+Pg5NnZolVKE+Kp2ubaK4pBjIxL47GEC4P+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FU6momGnKnv1GhyZ67rwhEFfTwOKEBiBAEKEui8fOPQ=;
	b=PXrvYIh/svzfIhEhaosO6pyKG4RzzpfkMCWA1F3Abw+g88EPg0cWMw6ePmX2/5dcKAIM
	 uT3Vs1tasR9eaJqJEXi7kp2rQAvtrGYvAQvXQFXq7msJ+red01ukrCGrppsjjwssTCDsU
	 td0d0Fnn03y4XaGRwW8syo6gduHYFBzaqJLlzhYBqLl6LPK0lDx0pNHyTY/IpLCmM20CB
	 tSH9GuQJqQRRJkUqEMj/QtkY5jmsCOaaCsnUfajhdwqky0nlYba1UNBG6i4mdMCK3m17d
	 MSx4HtIGrrHVueVp4sUGmEFzZoJyVvxCRGJCzNH4+qEx16eLXKOcGLcGfHA3SNp4gzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWrS+DIa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWrS+DIa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706871F008A1;
	Tue, 10 Nov 2026 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318060;
	bh=FU6momGnKnv1GhyZ67rwhEFfTwOKEBiBAEKEui8fOPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWrS+DIaHliOteXi967iPt6RGGHxyRgxa/G+jCboVDdiFeqUkPTEXajt/lLZXu5Yt
	 bNxVuUYDH6jvMGP2iccUsZoKJ1J5caUdNpRl8T0HyleUj7OTiCFvIsk//0HPKJeJnr
	 UxQJIJGSuLQbJ6KYMX/3i5TddwghMAO5A4q5w0h5e87owKXyekzaen56h8rlOQorP2
	 wlRqwrYNSCKAxNLL1oSAv5Nm0sJeyI/2/Wf6cAtfXcI9mz/RvnevmQlUWbM//pyNzV
	 g93frtQLD7iluoCG176O3KHqLptTUozWNoj047eOkl/t+Eoxk8CGe0tVPx+bYl6tBV
	 duKY3/7jARvUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: omap-sham - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 08:40:58 -0500
Message-ID: <20261110134038.1757009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061603-failed-5.10-be51ea091c65@kernel.org>
References: <20261107061603-failed-5.10-be51ea091c65@kernel.org>
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
[ sashal: adjusted cleanup context to match the existing inline unregister loops and tasklet_kill() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-sham.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 5a57617441b81..b2e1617474553 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2223,6 +2223,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 					&dd->pdata->algs_info[i].algs_list[j]);
 			dd->pdata->algs_info[i].registered--;
 		}
+	crypto_engine_exit(dd->engine);
 	tasklet_kill(&dd->done_task);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.53.0

