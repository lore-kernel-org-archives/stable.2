Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786203;
	b=wa5i8kpbVkCKERphlTWqzVfiu449SCz2yPZhgim7zTgQSiTCQTicl5XwrZjumjE7Ax8T
	 Uf1lWOOpbwO6XNNgMHCECr2eiU/JN+LblDRf6V0LTvmRQrOKeD8n/nBqC5thV5jvZ6GmB
	 aDfrn2hustqOHGVsb9oE1G5vgcRIlw/sZsUwFEQnB7fC4STyME/dtMbY9rQQyP4AtV7QQ
	 V03NJjcQCp78apfcsbmKcI0RTVhLanLwzZvc9n3UGFlyc27uyQW4tHpV4mgcROcBEqq6G
	 grIEXVKXpQ1DKOtFJf4025OBhdWcKCYKEQt87GHeTTzjiYgLJHxdL/ypzQU8sBVv2mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RhbYBTCFnUIkHjspi7K1/DTnz9+g0EGatlkywDux9+A=;
	b=WfZnERxGzcS2vzxcSp8+JqbN4e3GR98jNE4EoEKISKzRwX6rYc2NsbWYyIdCkSHg+xMl
	 d0nYjmlCQMzV+wtC/dWAr8P2dChYjH9CX7Rabsug7p4SspENJ2Y/o2BRqdXZIfyzQwlHD
	 Xy9rkqw/NsO+zl1LaWid+SEJabRMhjFfPYlAefhEZz5Jk9WBDwUqGAHKzrl7J822BQPZk
	 iOvyW5Xb4pWB/3pdFxn5Zgu3N4jp3rnp4epJrPAqRTn6RIDUxjKUs0cyfsR3QVUgFAQrL
	 LZjTX+dtLjzw2JMvz4OfYlb4wlK25YtCB11tZS61JYSsMMOk9aNXcuyb8kp4ayQPpmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvPfONrf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD29606A327;
	Fri, 27 Nov 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvPfONrf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568EC1F00919;
	Fri, 27 Nov 2026 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795786203;
	bh=RhbYBTCFnUIkHjspi7K1/DTnz9+g0EGatlkywDux9+A=;
	h=From:To:Cc:Subject:Date;
	b=SvPfONrf5kP7D4rgL3bnw5aGbvo6hAGlxLV6MLIWMETk0yFKbwWorN03YZC6W1JH+
	 M+UTacVhU5suwingZnUH0LopRnMMKOdI+jUgegtfoSLlOuv65nRBm9LzMy6fFgAqXf
	 2DpUmb4Bth+jk9Eq3iacsJwq4PNo6cTa2hur8FdLj7gBDMmEepQg9NJ9neIc8HYfKF
	 WGzKg70TV86dpHxeb42EHBO7s8FgChfIf2uDMLOIGzxBDYMXoviOOa3pX6AmCoWIAg
	 R8bgow/izwm443Oqh3T2QToD0TacF8V2d9pInNSpgjDUzCnupfvUsCSwog6EXcosXH
	 aJ5GCD2cIjpDQ==
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
Subject: [PATCH v2] clk: tenstorrent: Use prepare/unprepare ops for Atlantis PLL
Date: Fri, 27 Nov 2026 13:29:36 +0000
Message-ID: <20261127132958.2714501-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

The Common Clock Framework invokes .enable callbacks in atomic context
with interrupts disabled and enable_lock held.  In atlantis_clk_pll_ops,
atlantis_clk_pll_enable() is registered as the .enable callback yet
waits for PLL lock using regmap_read_poll_timeout() with a 500 us sleep
interval, triggering a sleep-in-atomic bug via usleep_range().

Convert atlantis_clk_pll_ops to use .prepare, .unprepare, and
.is_prepared instead of .enable, .disable, and .is_enabled so that the
PLL lock wait executes under the sleeping prepare_lock rather than
atomic enable_lock.

Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller driver")
Closes: https://sashiko.dev/#/bug/linux-980395a6-f282-478a-bf18-b5695a725735
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Switch from .enable/.disable/.is_enabled to .prepare/.unprepare/.is_prepared so PLL lock polling runs under the sleeping prepare_lock instead of enable_lock, per Brian Masney's review.
 - Keep regmap_read_poll_timeout() rather than switching to the atomic variant.
 - Drop Anirudh Srinivasan's v1 Reviewed-by tag due to the implementation change.
 - Drop the other patches from v1 that were already applied or superseded.

 drivers/clk/tenstorrent/atlantis-prcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tenstorrent/atlantis-prcm.c b/drivers/clk/tenstorrent/atlantis-prcm.c
index eccc8015da23..ee7044e3f1df 100644
--- a/drivers/clk/tenstorrent/atlantis-prcm.c
+++ b/drivers/clk/tenstorrent/atlantis-prcm.c
@@ -269,7 +269,7 @@ static const struct clk_ops atlantis_clk_fixed_factor_ops = {
 	.recalc_rate = atlantis_clk_fixed_factor_recalc_rate,
 };
 
-static int atlantis_clk_pll_is_enabled(struct clk_hw *hw)
+static int atlantis_clk_pll_is_prepared(struct clk_hw *hw)
 {
 	struct atlantis_clk_pll *pll = hw_to_atlantis_pll(hw);
 	u32 val, en_val, cg_val;
@@ -284,7 +284,7 @@ static int atlantis_clk_pll_is_enabled(struct clk_hw *hw)
 	       !(val & PLL_CFG_BYPASS_BIT);
 }
 
-static int atlantis_clk_pll_enable(struct clk_hw *hw)
+static int atlantis_clk_pll_prepare(struct clk_hw *hw)
 {
 	struct atlantis_clk_pll *pll = hw_to_atlantis_pll(hw);
 	u32 val, en_val, cg_val;
@@ -332,7 +332,7 @@ static int atlantis_clk_pll_enable(struct clk_hw *hw)
 				  pll->config.cg_reg_enable);
 }
 
-static void atlantis_clk_pll_disable(struct clk_hw *hw)
+static void atlantis_clk_pll_unprepare(struct clk_hw *hw)
 {
 	struct atlantis_clk_pll *pll = hw_to_atlantis_pll(hw);
 
@@ -378,10 +378,10 @@ static unsigned long atlantis_clk_pll_recalc_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops atlantis_clk_pll_ops = {
-	.enable = atlantis_clk_pll_enable,
-	.disable = atlantis_clk_pll_disable,
+	.prepare = atlantis_clk_pll_prepare,
+	.unprepare = atlantis_clk_pll_unprepare,
 	.recalc_rate = atlantis_clk_pll_recalc_rate,
-	.is_enabled = atlantis_clk_pll_is_enabled,
+	.is_prepared = atlantis_clk_pll_is_prepared,
 };
 
 static int atlantis_clk_gate_shared_enable(struct clk_hw *hw)
-- 
2.56.1.839.g22a8290db9-goog

