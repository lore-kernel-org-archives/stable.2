Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417360;
	b=Sx9mI8PiuLD6LjKbpl0omEbuQQVs+LHCLuoFIsD4W37ooBBoKAipSpIunGankvC1ioGb
	 1tRMlxx3fhCIK2wmTlDmaiKcODJfs+XqDBrB9FWrpnAaQgqV768sc28qui+akz47oXv+F
	 kPTrt9u8ncI2D0DQtpezC2W0J1rlGQwbigdCD7flRchblwDCVO/dqrMX4kQbi7cP7Pmn3
	 XOWJ9vkO+D7y2XGT5EDn4hsq5c7aagCGqNi4SjjMj5/YrzTQUC0iaeoo3+bZSe2+p8Wf5
	 OoLy9uy43I75mh1Rx8EdavMVz0p6A/Snl+243Cm5wHz0MboCqu3W1URLG6SQ9Am8NBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	b=yRSISO+ERtgxc1mHPuMMSZO8l/3p69C46Mp5XhhQv+3X/ZD3mJcYvC1NSAKONFj4RAfI
	 iKaznHQphne5EaGoExCql6MwYWenWwRwzTxN4WGe8lkBW3aMoXYMLp+futFXgiO18TJbs
	 p8hZfZXoZTAUfeUxEV9xQ/Is4H7ftUOwazv0Km9MmQP2EFw3+7oNoDD7Ei20MEG5T99qa
	 F+oMHn1TnufxLk0MJ4zbgHuchpihUnVic1Ret2LQK/SFkDqKq3zsKsFg4brOmGNGqTQ+0
	 164KZD7FRi1y5h7CCwkbJjpwyaFvpzcb+jHgPrEYPQjIP7zCp96+MP6R0rcQdqDRu0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYzUMqEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77261606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYzUMqEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC2C1F00A05;
	Wed, 11 Nov 2026 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417360;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYzUMqEntSKMaziHBTbHgKdtS6Wtpdni/ZFRPODV9YcTByDO5TFkMyK8azefP5Nsd
	 BeOBCQbOEis3PaOhFihqrhQg1Y0yDuxV+OqetVD67mEKOnwehEZsmnjlDiJD4UGRvr
	 bBuzAVwufFk1ArYkBOJ92+JROdEPG85I3LY+gN9Pyu+Oc8b4qBGknes0KWRmyh+0uR
	 N20slVnee/ibFpYz1kYhoUibPvBCKUOV9GANWLvOqcz/8wB5KzUsAFGyw1FVwVA1KL
	 QXesEwkKx0hVix8D02q5llcIyiJN+7gHtKXw5pFZmA6pdnf4f2cBpWEurDpXfLhwut
	 Nnswcrb2kAwYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] clk: nuvoton: ma35d1: Keep the clock count in the driver
Date: Wed, 11 Nov 2026 12:15:55 -0500
Message-ID: <20261111171543.3521975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052657-failed-6.12-1dc3871ce7ec@kernel.org>
References: <20261107052657-failed-6.12-1dc3871ce7ec@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 26ec588063d9b6c70773b8729372e2bf6d3ea95a ]

The number of clocks is not a binding since this is a value that can
change. As such, in order to support the missing watchdog clocks and
allow the deprecation and removal of CLK_MAX_IDX from the bindings, we
need to switch to a local definition first.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-1-48937ee6c9bb@bootlin.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Stable-dep-of: 1dc3871ce7ec ("clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 9f65d0623517a..6aa42a3e1be3b 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -17,6 +17,7 @@
 static DEFINE_SPINLOCK(ma35d1_lock);
 
 #define PLL_MAX_NUM		5
+#define	MA35D1_CLK_COUNT	236
 
 /* Clock Control Registers Offset */
 #define REG_CLK_PWRCTL		0x00
@@ -467,12 +468,12 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	int ret;
 
 	ma35d1_hw_data = devm_kzalloc(dev,
-				      struct_size(ma35d1_hw_data, hws, CLK_MAX_IDX),
+				      struct_size(ma35d1_hw_data, hws, MA35D1_CLK_COUNT),
 				      GFP_KERNEL);
 	if (!ma35d1_hw_data)
 		return -ENOMEM;
 
-	ma35d1_hw_data->num = CLK_MAX_IDX;
+	ma35d1_hw_data->num = MA35D1_CLK_COUNT;
 	hws = ma35d1_hw_data->hws;
 
 	clk_base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.53.0

