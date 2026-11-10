Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280201;
	b=sS4XB67VQbieG8/66ILxrz/WNmpJOnLSwgV5uPSOpM2ueMoqnyInQmVjrFpBjNQjA8C6
	 Owps59CJN7ixPwq/sIKTnDRMLJ0BbH2DfAvAcXg+FTDtCdzh3D2X9SxJqeM/A4+GYaTQO
	 SwEpfgleZpSy+5VYMq4+VWP5pIWQmr+5J1LY/vrF/Rijk5bqZwHI+7C5ETaZVfxa4zQrl
	 hKk3gQv+KjxErlINR2K2cMynYfpI+Fo5gELDy5xUiwXov+b4yNw4leg5/YIgjcNPdEhTK
	 zU1YLN5w+8oXoyVyOqwKODc4tV8lfuJumyueCpa7S7Tv2SlGKur/0oUnUzpr5RZd0Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PywiT9Ep14G0sBmfohyQYhBCz2Fict1x3Orh8NoCAsE=;
	b=bSyu6y56ZMAIn8IOFkt35AgATqjSnMvv1iAuLdxMI909JBkn4WBzXeRsDoVT56ufN6oB
	 aEhPewG2ykCsGv0yIJvhToYDnS+3cbgSx1RpKcuA3YMkmLveDUGxvNPNzVZb7KoZhp2fh
	 1YM0Wj/UmtI4lPEKo0cCC4x0RVpdFFVJ7GIlHarbWvDp6HiPg1pjcWkuiYtJ5r+qS1nJN
	 9RZB5m8pfXUybArRFjAypn6VFYzil7eLkrEt/6IwTKlszKC4NIozDwN1D+0Q/HB4qwh4S
	 4Z7gdt9J9l9b86mPAKZAwMEcDeCAJAWwoOso+7JFmtUqgMnaLX6iVWXzQxa0ZW0SllQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3bFrYRo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10571606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3bFrYRo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483E1F008A4;
	Tue, 10 Nov 2026 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280200;
	bh=PywiT9Ep14G0sBmfohyQYhBCz2Fict1x3Orh8NoCAsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3bFrYRo3xrZCy2zQ4mD2HgstWog/8QEgiyJiqO1Y2FZIrBUao/wAt9snBWLszBAI
	 idporgrK5allJQncy2IDQba6RFsQ35wwI9f9oTMINrvHhvCWUAe3PY9v85wpfY67QF
	 /Ddn0jr0EDv4KjaQmFRDqCGGewZSHVnCSRg4ss13iPAGSKlovQHlK+Mr/OHNTLtMWS
	 hevjYfbCXUpUV7j7ZGilc24KlohD/7jdelG2TR0NTOlr+mb7Eo/HJ+uqbdQnIpnl/J
	 XMM5CQKZDALqspn2ccZyl+ESEgd+exThAaqXGs6rb0cpQ1U21Zn2RlGipcFd/8LlbH
	 d/cA8bKdEjSFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: meson-ir-tx: Ensure probe error is propagated
Date: Mon,  9 Nov 2026 22:09:57 -0500
Message-ID: <20261110030950.4189721-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110030950.4189721-1-sashal@kernel.org>
References: <20261107055721-failed-5.15-2eb8a4cba70f@kernel.org>
 <20261110030950.4189721-1-sashal@kernel.org>
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

From: Sean Young <sean@mess.org>

[ Upstream commit 2eb8a4cba70f521a8217021e227cfa28ba17724b ]

devm_clk_get_enabled() may return -EPROBE_DEFER which needs to be
propagated else the probe will not be deferred, it will fail instead.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/meson-ir-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index e050430ffc7b3..d26fbe0b65de1 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -295,7 +295,7 @@ static int meson_irtx_mod_clock_probe(struct meson_irtx *ir,
 
 	clock = devm_clk_get_enabled(ir->dev, "xtal");
 	if (IS_ERR(clock))
-		return -ENODEV;
+		return PTR_ERR(clock);
 
 	ir->clk_rate = clk_get_rate(clock) / 3;
 
@@ -328,7 +328,7 @@ static int __init meson_irtx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 
 	ir->dev = dev;
 	ir->carrier = MIRTX_DEFAULT_CARRIER;
-- 
2.53.0

