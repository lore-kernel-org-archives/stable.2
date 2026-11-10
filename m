Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331065;
	b=mIP4KVRY9lieTJbAd8mqcTMyIzER5F0/zl0cnxQmAXwyrsrwackRpDuTgg1dGWXbUy70
	 3wEXV7y8XPYQ3yjqbagU6yWfyWYbdVgcNTIg6JKkGSSylCCiqeA34YXYDBsHO0MMos2Za
	 Qwktt+rLLQ3YmpFwD2Gh+XlWylHXqFdrIZCAPyEuQlHc7b9GtqKNV6yutD7Km1WNU7EjO
	 TSYTVFOw5Y9m5eyGsYDrGn1YwDKVh3r5xX9kWtHnO8OChWTXQ6WAxj+dNVgfHix56okOM
	 Ym+8IN95zh91xMvhQCopPa+hkpk2aaFz1CR7kC+QgGprPDrQ0G8MoF29QSTLRncpx6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=72g33SxzWXKHvB52lrU844hZ7EwB55XERmVH9+vwAt8=;
	b=YcGr+oNCmFTdvn6IZ6sqpeBLwLF9LDLxlCXEsxJ3LffekjS0RtaetzZWTR+wvN3SkeBW
	 WOontHoY605+njgT1vldq0iZ1HDvBqYois5chQ/Ph9QVzcwNFvvgu8cJrWIKhkE8T3ZqN
	 pRDOEUi08flfsIgQKKSA/QHefjLghRhj+flkihAyT++N+hWFxDeBTh6VVygYHFqc5p+E+
	 9M4k27lpsFyWpsu/EPNKqsqCZal+D+JRPaCEr9UoqEUADEdDH5CfDlgaFt8bmEzlwWXdt
	 ALOJzsv7nKoDEC2dgWR2eb2BnrAVmp/daWEaoDI+ZWfQkr5vrnra9UhXduCquEvXI9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dp3XEiJ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847A606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dp3XEiJ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B91E1F008A7;
	Tue, 10 Nov 2026 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331065;
	bh=72g33SxzWXKHvB52lrU844hZ7EwB55XERmVH9+vwAt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dp3XEiJ67BGBbJgA7zBb1XgiGAn9564bEo2Hpz46mPktJmn81aLhaDTcSw4bp/Rjq
	 5YkT761Iz8S1ql+H1YgYpe8wJjDreschayOF58YIkuM9hYoNs8GflCjYqGfVMKo6hI
	 jkCNg3kc7o87hL2ZozX4IdATECX77McJS6I3XDHlnjWRMeQ9KmxZaXpAlhJ8jyl+yV
	 UlSUKySSv54pp9Des4rN+Ltt4tM4BbchBaxik9jH/KkBFsDdAF9aiPV8TI+3Mit8Hh
	 rSIYmpHNEm3lRo/XH0fOz5WKzomFWZiFHUydGucfG1afhb2iwabD1p6dpcgF+xiUC9
	 fPykhFF4gdf1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Jacob Chen <jacob-chen@iotwrt.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] media: rockchip: rga: fix clock cleanup
Date: Tue, 10 Nov 2026 12:17:41 -0500
Message-ID: <20261110171735.2803139-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061827-failed-5.10-a875c43dd95e@kernel.org>
References: <20261107061827-failed-5.10-a875c43dd95e@kernel.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 254f3337ce2575bf94f1fb40cc40fdbc70371116 ]

Fix this smatch warning:

drivers/media/platform/rockchip/rga/rga.c:734 rga_enable_clocks() warn: 'rga->sclk' from clk_prepare_enable() not released on lines: 734.

The reason is that aclk should be disabled/unprepared before
sclk, instead of the other way around.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jacob Chen <jacob-chen@iotwrt.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: a875c43dd95e ("media: rockchip: rga: quiesce IRQ before releasing m2m state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index bcbbd1408b368..02c2ea2b42a50 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -717,10 +717,10 @@ static int rga_enable_clocks(struct rockchip_rga *rga)
 
 	return 0;
 
-err_disable_sclk:
-	clk_disable_unprepare(rga->sclk);
 err_disable_aclk:
 	clk_disable_unprepare(rga->aclk);
+err_disable_sclk:
+	clk_disable_unprepare(rga->sclk);
 
 	return ret;
 }
-- 
2.53.0

