Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417703;
	b=UWGRzV4yCgYthy9lF8wsv3aDHLTTxMXENerY001uDwXfWDZ7N/b3//3Tj6/Gt+a58EuD
	 yEOnw4a9sZT0tMgoY8hB5AMKx6oDg207JFIP5mSYt/UzF/ZmCBtMznAzZaQ5oS3OKk4xC
	 mCks2XtaKEfmcyVd9i4F6TQxRASxIHihqRJLQn+OXSkCxWT8fRN+Y2/NTIn2DMi8CSPhI
	 OntW7uj1iVRu7JNe49ljCnn5fOVpQbNg4LtSm2QHozSsSieEv+8ORowaKnYCxvnA4ncRj
	 YEu3lIIQzrHHikFNq1TBvnYE7bwxo7+ctKOeGb4kxVx89gldYhcS9Swmh8Dp+cqt4AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	b=aS8n3k9WlwXDfKNkSHxxpTslh9puZfpUlgMJCMbS5AGsz24caafIY1vsA30p8FL7vBM+
	 3hVxnClNYaqP+aOhfQiDXgeGbJU+6ZIsPbGAgNFkSS+AWLuAQDxxhz/mXTboep3Xm9MX9
	 OXKHWFePcMxI66LmWhqxpThPRhuheO2PrdY3eH0nrA8OcUXoMhZHu+42BGMmFewb1QwwH
	 yaNwFHpRYL/+xNgoW8ZLkCeHPQOWJbczORZQcZ7HIexc+ScYV99+qsq/Y6gzBt4/S7epy
	 gbHTZx0rXt3TqkLpDkMKmTf0kcaz+Q6Z2BatF2wJweikq2HZlwJO42ZVeGPlpEsFEOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+FenpIW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3334D606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+FenpIW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463F61F00A06;
	Wed, 11 Nov 2026 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417702;
	bh=Qp8mSShXuyKtR1KzKIOI78p0nyVVyqD1GBkKFjfKGZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+FenpIWvEg3ijJRAjUwlvd7BDPKGvNNLSqSvhudeLsWcy5DyZFVYuOsg1NMsMHnl
	 pq0JT+lOr0QWYpzG6X/5AKtSsiRLhDxO5vKXSicSpZ1NsikT7djQ5KDG52dJSQI6Fn
	 kXB1a+B+0AALfag8DDYlJAmCPzENBi1WS6BxX39A05Deq8GSBY4mEG76rea3y3SRDk
	 qIjoyx8H45U3Hp9N+KhpZZudciaiQpxw2MVTOt6Od7OLTPv4x7Qxq8GWg0P+SOssr9
	 wAM2i4Ci9pYpRQa4gW4vmHrRTvPhF80QttMh6eqbLVTMCfPHyTejKdDXbCojn2jPVI
	 XFjX3K6D1tzZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] clk: nuvoton: ma35d1: Keep the clock count in the driver
Date: Wed, 11 Nov 2026 12:21:38 -0500
Message-ID: <20261111172129.3551299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053946-failed-6.6-1dc3871ce7ec@kernel.org>
References: <20261107053946-failed-6.6-1dc3871ce7ec@kernel.org>
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

