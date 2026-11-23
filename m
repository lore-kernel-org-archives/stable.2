Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452590;
	b=x3xgCynrkSCCv7hvYB8q+MEPNtby0qtiNzFeo4x7GGonP03UulGSXlS1tIj2QrtdAFVG
	 67I6XywbQbuJgitB9QNbU89wYQaG/xZkpHFlmpTxH7s3x+jbYuhpsv4lMChE2kp3XIjJ4
	 Pu2ZZodtjd4k3S7aHt3MgXdti37Wk5KDE/4DIrpHwqLXpMWShAjpUAQJovd12ZlEuyUMR
	 RA43hjZdJhPEQKRBnLUnFpGlS1sM9HT0fFuJEhk2ByNCNnB8OTcnkFnFXRJF5s7pcBx5F
	 ECPYSIkj+nDjSLSvyFi07xZ3SdXg2cAGDVIvpKQ8dLgI+q+JRit/kKvCtEfZdVEQ8ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f+VbVKcweoeen5B0jtSKCf/3jM4Xab72+IxryIhEnYs=;
	b=WnLTnMmQJwYE53ft47f5ALXzRKdmGX7K/UVlFoTwYha3pAgC3o3s8x0oA/2cIyTodlZo
	 K5JmMdMTASr3m61akSJfXqjwr63ax1ie+1gLwf5ISz5Y806mRHyTLjboxtJoSJk2MGvao
	 VKfFTX89Y47iMAg7m7qRYP9r5g+qZO45Ha3FYDEEjZZ4nqsGrVOcndCSryM58rKdYQh1W
	 GLq9b+zpcCja/8w7uA8UJ+kSLir92DVTil6F9uOn3i8RdQnH7fmhpjT4OwK89n64gj11o
	 /6hZ07CORbqbooldxYB7N9bGEYaEZF1TGEF3n36LiyEg96RkH5xr9Y+DxNhpYB68+Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtvcV6th;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB07606A697;
	Mon, 23 Nov 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtvcV6th
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296DD1F000C4;
	Mon, 23 Nov 2026 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452590;
	bh=f+VbVKcweoeen5B0jtSKCf/3jM4Xab72+IxryIhEnYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtvcV6thoKzdYK0dmH/+9OZnYe1QbfYPD/u5kw2Gc4b38bHylZOnW4IEtBisrjWt6
	 M/DvxmvSWrO679bnGfa0+JhBxVaSxGmU1hd4f+x57N8Zre5h9m+3jDP+q148LQ3kxf
	 afPlA9aNE8J62B8Q+fF0hCOOwtComG8VCSDfukUaiqF9BPFszYeWiBWf2CmMqark8Q
	 qV3Ka4UPqH+cWwcUHO0oohWnGzFj4fHdcZEVZS3eBw9X5dYN+wCKLvzmd8cOovi9dl
	 hEING+hxNAyOQbRiTx/Vqu52HDbRWhQbTb2d5e+Lr6/1GnLm3xIen4Isb0yalwno1c
	 d7GMMVYmOp+Kg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Drew Fustini <fustini@kernel.org>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] clk: tenstorrent: Poll atomically in atlantis_clk_pll_enable()
Date: Mon, 23 Nov 2026 16:47:41 +0000
Message-ID: <20261123164834.3330320-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123164834.3330320-1-lee@kernel.org>
References: <20261123164834.3330320-1-lee@kernel.org>
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

The Common Clock Framework invokes .enable callbacks in atomic context
with interrupts disabled and enable_lock held.  In atlantis_clk_pll_ops,
atlantis_clk_pll_enable() is registered as the .enable callback yet
waits for PLL lock using regmap_read_poll_timeout() with a 500 us sleep
interval, triggering a sleep-in-atomic bug via usleep_range().

Since the PRCM regmap is backed by MMIO, use
regmap_read_poll_timeout_atomic() instead.

Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller driver")
Closes: https://sashiko.dev/#/bug/linux-980395a6-f282-478a-bf18-b5695a725735
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/tenstorrent/atlantis-prcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tenstorrent/atlantis-prcm.c b/drivers/clk/tenstorrent/atlantis-prcm.c
index eccc8015da23..d9155f133713 100644
--- a/drivers/clk/tenstorrent/atlantis-prcm.c
+++ b/drivers/clk/tenstorrent/atlantis-prcm.c
@@ -313,10 +313,11 @@ static int atlantis_clk_pll_enable(struct clk_hw *hw)
 			   PLL_CFG_EN_BIT, PLL_CFG_EN_BIT);
 
 	/* Step 3: Wait for PLL lock */
-	ret = regmap_read_poll_timeout(pll->common.regmap,
-				       pll->config.reg_offset, val,
-				       val & PLL_CFG_LOCK_BIT,
-				       PLL_BYPASS_WAIT_US, PLL_LOCK_TIMEOUT_US);
+	ret = regmap_read_poll_timeout_atomic(pll->common.regmap,
+					      pll->config.reg_offset, val,
+					      val & PLL_CFG_LOCK_BIT,
+					      PLL_BYPASS_WAIT_US,
+					      PLL_LOCK_TIMEOUT_US);
 	if (ret) {
 		pr_err("PLL failed to lock within timeout\n");
 		return ret;
-- 
2.56.1.750.gf70dc682cf-goog

