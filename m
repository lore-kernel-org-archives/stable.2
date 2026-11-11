Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417118;
	b=syOb46Z4R7RstbGPsWy3UD+gxIbZGnMlGN2lsXlHZAIsWeyw8/msF1YQHsXGjQqLqGln
	 YXd5ueHJXrhFar8b4HO0U9jkxk6G/GBFbYLoSkfvs3xLQm+WjQ7y3hll42QgQH993r0VB
	 c6Trp8FxbqFj5tR7qGxBiXn8HFzogko/IbQhwLp2vSil0+COpEGuNm7KxnXz0QP6Je1Wp
	 kexV5zNv7Z0fI9Ta+jlqaYcT6gkLM2ESeBFCswb+IfwC+mz7vqG8mWozhArfi/IvaurkN
	 HyHvOdwGGrYTsZfUU7pv9jTmVdlLPCOZsj6L4Xf2adRvcPwT0v0E3AokzGUE7AXpF4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	b=ITuI+GZRS8lQzZKMvVDoUqswjtHONoYVb5lq1M4L7VHf2ZA0ovUdY7QMrGu7rCXpULHB
	 G6+NYOPoHG4B/9AiBFUgRMwGX9jbsKix5xdUUqtmu20weILy0LLu/nun5tOCf2Al+IRj+
	 QRqMUNF1e8GRkZpBn0hYH9WxpbYkzQYGzoFjLmzN2vb5h0VymFgtZmeXzqDXr2sufbbSh
	 IWao2Hg7ujfqCdcFg7BDQ6vMVzVy+T0frJRwqi1hYTn7AoiSZQRuBnCV6E1k8OJw2F5/t
	 sVl1tr9REf+kXu+L5gDh23tTsGarjIu2tKZd3BKJCYu/f3lnY+HWEr90ru7n0DjMoEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PC4Fsl0/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PC4Fsl0/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6371F00A05;
	Wed, 11 Nov 2026 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417118;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PC4Fsl0/Q6Qe/Oz0zdruI5pCt+fvlbQ5+kWUERv73aqSy98oRCCDpxsrBRVPhhPFo
	 pE/YqqvHiKBfxR1Lehw0BIQo/BL9CcLZPxMRdMkk/yYnoJatXXxCUpVM4wPTGaSwYb
	 sp2H/uemcDI9Z6kcmydoGzz0x3fN7kDZjnkv0l22fXZMQsBaBRMtLDqeA5rrjzI1FC
	 KJkHUH9Ni+eWkmjE98gIJr4aEoD1Z1V3YriAYxAbLHpECy65VMbuOVKza5a77vGswp
	 G6cS+2P5n21CpM50JYg6yFJ/fk5BNkbDDvcFUAsR8/fiS0G9PN+IP0TEL7t4/cv5rW
	 2H5VuLGZ1BNJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] clk: nuvoton: ma35d1: Keep the clock count in the driver
Date: Wed, 11 Nov 2026 12:11:53 -0500
Message-ID: <20261111171146.3480409-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051509-failed-6.18-1dc3871ce7ec@kernel.org>
References: <20261107051509-failed-6.18-1dc3871ce7ec@kernel.org>
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

