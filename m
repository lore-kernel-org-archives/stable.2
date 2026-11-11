Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417363;
	b=C/72FNN8EkfTmHKWZhcmwq564/eFJPFPCThW2i83raXwB40Z4RWE7/CzA2R+cBwwQ/kx
	 iif83IxNjHQkxCGZcdf1NaPod79RwDKM9PPFybNVl/+eEy9D/EFxJpuACkdDBjIFg9TDJ
	 WBEVxiyl0inDPeMzGkv3m6ZimcZC8aD08T/2zbWoR3lg271ua+hsyn0ydTnYunpNa5QFT
	 pjK/dGv+rzgydq3cgy3bLPnRXV9SaQNsbvbkS5RaJfTq2eSV/xamBbVCb+XAXrHKvRj6e
	 0qoca8tsrAAdgbtK8WUjkPC0vaoVPDI45fiupJNyHUcaTm++mqp8ZhX8slRyX0pmDkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417363;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	b=4tE/Osby/Z9I7mJRjg8/H355s1PtHLqj1fKI4q4JqTW7+fzyEybL/aSOPlbtAcx7LR+P
	 leV26M0PNdZiNkK+Azo8jGfdzQsGm3gcTf4iEoN7l7O1v3Z3+oEdNUl95h5CthcNKjrzQ
	 2sIMHE6c1VLqB/rPuu2jQ1G4vjDYaNvZG3OcHXpPOuS9S4qr21SYo1bmiSpUKE2UacQqT
	 9f82/h1QpOKfjsTJgNoPtiZcA3IK79dAh0hmmLg4+rZszrY51zKAybjU8f9Q9mJOogqSG
	 b+902QH9yvD9+1JU2eWP2IOreX1A+9gKkpCxE9pXgN0vdARE3tMUKyP9JIrr/aGd/wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKZdB4Vp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58D606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKZdB4Vp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4CE1F00A07;
	Wed, 11 Nov 2026 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417362;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKZdB4VpR4Y5eljc4A0k9KgH8jamSo8zLJsS8k3PQ7QmFi0vvytrgtAjFbHvfV7NS
	 ke/2GKFd1O6eYQPL7rpY9oMFwJG/p1JEpmeyWTJJaVeCOX1jApaN4y0bUMTXxMiC4T
	 riEuRqJNwwc9/rXTyltleppZ5i+lhhSKzIaufH7jyP7tJ7f1C8JFViSVLLKUiTsL5y
	 K3PduSqg8BedNJti+9KysUbukefkyGNfyKPYYXb+Rl+r3A4SlisDdeGi6jjpgQ4PzT
	 OoE73SwTF2JsSPpZ+4TZWmpqB5Pbwh3eFmprRsVUZGNRpyg+pOb6N6yup8ER2aGnRe
	 UMSmr9UxyePQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jacky Huang <ychuang570808@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:15:58 -0500
Message-ID: <20261111171543.3521975-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111171543.3521975-1-sashal@kernel.org>
References: <20261107052657-failed-6.12-1dc3871ce7ec@kernel.org>
 <20261111171543.3521975-1-sashal@kernel.org>
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

[ Upstream commit 1dc3871ce7ec819030c22297f8960c61cc42a990 ]

The WDT and WWDT muxes list PCLK3/4096 and PCLK4/4096 among their
possible parents, but the driver never registers the corresponding
clocks, so these parents could never be used.

Add pclk3_div4096 and pclk4_div4096 as fixed factor children of pclk3
and pclk4 and expose them through the clock provider.

Reported-by: Jacky Huang <ychuang570808@gmail.com>
Closes: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc48795a@gmail.com/
Suggested-by: Jacky Huang <ychuang570808@gmail.com>
Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-5-48937ee6c9bb@bootlin.com
[jbrunet@baylibre.com: removed stale link trailer]
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 6aa42a3e1be3b..c914079cee2d4 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -17,7 +17,7 @@
 static DEFINE_SPINLOCK(ma35d1_lock);
 
 #define PLL_MAX_NUM		5
-#define	MA35D1_CLK_COUNT	236
+#define	MA35D1_CLK_COUNT	238
 
 /* Clock Control Registers Offset */
 #define REG_CLK_PWRCTL		0x00
@@ -544,6 +544,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[HCLK3] = ma35d1_clk_fixed_factor(dev, "hclk3", "sysclk1_mux", 1, 2);
 	hws[PCLK3] = ma35d1_clk_fixed_factor(dev, "pclk3", "sysclk1_mux", 1, 2);
 	hws[PCLK4] = ma35d1_clk_fixed_factor(dev, "pclk4", "sysclk1_mux", 1, 2);
+	hws[PCLK3_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk3_div4096", "pclk3", 1, 4096);
+	hws[PCLK4_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk4_div4096", "pclk4", 1, 4096);
 
 	hws[USBPHY0] = ma35d1_clk_fixed("usbphy0", 480000000);
 	hws[USBPHY1] = ma35d1_clk_fixed("usbphy1", 480000000);
-- 
2.53.0

