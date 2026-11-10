Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322640;
	b=pBjXptytjF1vdMY94/+Q1vvczNHidss0SL+nJVBzyf1X0hvFG4j01pF35VD/rYaI+fnJ
	 PzgYDPjIYXoPM0aaWhRyEtou0QGvYoYXDqQzJCnFzGQ7J4eKZ75CuZDjWn1CuEggHXxiS
	 0j1ZX8ZDiMSbQkmatUzt5c4VDAu+iqmUCV+1ucpYvbotJEkM10dy4UMCiG9m2m2WlrM6m
	 itIl/7uzqkOScwo8P5iWPGXsT97h3tlTzSq7CH8h2FTVj50BJH6MWI4+gJIYafhnXkD1a
	 HJnknlLOaGfCeDDX2frHtZwhKILpnv+rTK6b0llrbOxAZc2JgtY0QmeGq70oII1QUCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OKksOqNJDdhut5fFp8xR5W1ELPbFZSZbi6+r+zHHDSA=;
	b=Mewd0tuMB9T6G68CZKwVjVZ4MwY94RrsTFIQimM9timVlW9Gt72/3t1RAmOyERF9lH99
	 zdt8KD6sCxAKuKQTY/LFqlO96cA3Ac3pfH2sm2Y4yCq6C7bEsnbNcxW601mDm7YLtvxna
	 7hmFrH9xVutBKzC1CJWKvZAI/f/MMWzjCJpsF5Af0sH9jkqPVI1qz0tcQgYi3zfVqPO5H
	 KH1yuW6mdgKTjZMzyhBTW7MzU5e3pcPcPIjnKNUdnMRokvfJNS1UOJsvMMKWLUVqZhvKc
	 nhngxBLy0ZgoNXKGIMIbQPgSEfeV44fp8hTFFCz8WPQ+Ue+xi6eMycO00PcKfD1KfeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nulg/LKg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nulg/LKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2791F0089F;
	Tue, 10 Nov 2026 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322640;
	bh=OKksOqNJDdhut5fFp8xR5W1ELPbFZSZbi6+r+zHHDSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nulg/LKgz1xS5ghw+H2nXsVB1elAfp07U1fXYdlnsZ31bqD/tfKkqI8KzuT0o0F/D
	 AplpneP3dl2kUfT6un8u3IQ6RbYNu9xdw46Q0MJXADnLHfTLhtdLH4yBTGtOWJT+EP
	 NsuQGt5BCT4kRhgW+w9HVKvppA/FEWTjC9hKt01MHgx4fo7fyA6yujdccj19j0EXn5
	 /w725/DkmY3wvduzien1uxJe2M2GQRUfqnXlCx+CRN9SGZXB7eaibCeqj53g3Nck2h
	 p6i1ABcD1PihQOMlt7LHVbo/rDqzSY1iUvVF+hpYlXlDEjDPtY3dlbru8lpYa+eR2Q
	 Vx8bdGJY7Z6xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mfd: ab8500: Drop bm disable parameter
Date: Tue, 10 Nov 2026 09:57:17 -0500
Message-ID: <20261110145712.2008098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062311-failed-5.10-5bf2ae8b131d@kernel.org>
References: <20261107062311-failed-5.10-5bf2ae8b131d@kernel.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit a98688d2ddfe274cb7c7ca3c6b6afbe9f844ffc3 ]

Nobody is passing the module parameter to disable the
battery management portions so just drop this parameter.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Stable-dep-of: 5bf2ae8b131d ("mfd: ab8500: Fix child device leaks on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ab8500-core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 4cea63a4cab73..bad4cb684da36 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -122,12 +122,6 @@
 static DEFINE_SPINLOCK(on_stat_lock);
 static u8 turn_on_stat_mask = 0xFF;
 static u8 turn_on_stat_set;
-static bool no_bm; /* No battery management */
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param here.
- */
-module_param(no_bm, bool, S_IRUGO);
 
 #define AB9540_MODEM_CTRL2_REG			0x23
 #define AB9540_MODEM_CTRL2_SWDBBRSTN_BIT	BIT(2)
@@ -1256,14 +1250,12 @@ static int ab8500_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!no_bm) {
-		/* Add battery management devices */
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
-				      ARRAY_SIZE(ab8500_bm_devs), NULL,
-				      0, ab8500->domain);
-		if (ret)
-			dev_err(ab8500->dev, "error adding bm devices\n");
-	}
+	/* Add battery management devices */
+	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+			      ARRAY_SIZE(ab8500_bm_devs), NULL,
+			      0, ab8500->domain);
+	if (ret)
+		dev_err(ab8500->dev, "error adding bm devices\n");
 
 	if (((is_ab8505(ab8500) || is_ab9540(ab8500)) &&
 			ab8500->chip_id >= AB8500_CUT2P0) || is_ab8540(ab8500))
-- 
2.53.0

