Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807627;
	b=vT9rg62R4doZPdP1vwH4Cc8HIMbxvdHv4hYriN/kHVqrzJ078yi4CMfHagTnmR1BKC6s
	 fjM2YKv3W3TeofONyO+QQgoNgCQgI9ycoRdO9iAu1noifeWSWuaBERrJv6Y9Y7+PNhzmQ
	 2KfkokHkCidueV3sh/3U65CBrquagVVBsQEtVWe6+G9z1z+Z/iEIun6AWBbEsT8Vp2ZId
	 VpkMnF2QSjkfzBoScNoTpXFEwWhyJlh4/aa8ZXxesS2dxT6+AS880nCGepgS/RGFDZF4R
	 NCB2tqSGs8t75DAEGxtVD6k9D8ljpOVE8ct2jDNqg6b9qjjxX7Jm60qHgYeW1HJrZFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YUuho9BdRijfF9IGiPy/MBiVnwS2llm6jmaZgMATH6g=;
	b=c28oE94ay8s08sZ05N54I6btyi9sLQcoBFkNVw8CbjA9BkqdsqUu7s/o/9z/Q+BMXRIS
	 504Btxv9XYKHOEOm+1Uo174XtpA/F5U3Pgwq37REDq8wiNLRM1jfembSmyd1uC/a2oBzF
	 nRUtfkvy+BmCdder51VfpcIMNrODxyXQh9Fql7OOnzM3qAH6oVhKEpY9aKilF0xVqel3X
	 DB7FTgtfoOfmQFsBiM/0mWL8S6s4lyqT6CAV58Jpu2PonDwqtr+yvb0r/bhTu+PNqpphY
	 RHt8CifR7FRb/JW/rl24s1nHi3STQiL7Fbrb2RHN7c89He+sqI0exyalGiu2JEs1QSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTRHFAcs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFC606A31E;
	Fri, 27 Nov 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTRHFAcs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0551F000C1;
	Fri, 27 Nov 2026 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807627;
	bh=YUuho9BdRijfF9IGiPy/MBiVnwS2llm6jmaZgMATH6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fTRHFAcsdjlwm5/xTwv1+BwJ5KlAyUW9pQuwes272RniHs3GiQNz1ge7ZeoObNbcE
	 a/JU4TtRDV8tS2hLxbY0tnE6S3tr3M+RUtfVh6a3EOfBH/9UyI8c8ES2pb8csLTMci
	 7tVLLH8AcpUwgYWHWXU/nEmWuKbE5FetoDd6blt2XncWcD1BJUoGmAIExtySKaXaAy
	 ae8fcGQkBiNNkoAtXsd9I366TU9W6Ssur3KXx/TRSeZKbdnXTJZ3fzfNB9HGN/VnHw
	 ffb+Oc2coeaYKp6hxx86OJ4yO6y4YLi35H2tDU0BD8YNrjrm1Lpxy+l3KWYZO+T74z
	 el5E0QMmNFgVg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Thomas Abraham <thomas.ab@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] clk: rockchip: cpu: Allocate rate_table before registering notifier
Date: Fri, 27 Nov 2026 19:25:29 +0000
Message-ID: <20261127192620.3443537-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127192620.3443537-1-lee@kernel.org>
References: <20261127192620.3443537-1-lee@kernel.org>
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

rockchip_clk_register_cpuclk() registers cpuclk->clk_nb before
allocating cpuclk->rate_table, and on clk_register() failure frees
cpuclk->rate_table before unregistering the notifier.  A concurrent
parent rate change can therefore observe a NULL rate_table while
rate_count is already non-zero, or dereference the freed rate_table
before clk_notifier_unregister() completes.

Allocate and populate cpuclk->rate_table before calling
clk_notifier_register(), and reverse the error-path teardown so the
notifier is unregistered before cpuclk->rate_table is freed.

Fixes: f6fba5f6967d ("clk: rockchip: add new clock-type for the cpuclk")
Closes: https://sashiko.dev/#/bug/linux-c0f18cf6-69e2-4cc3-8b2b-7b25245ccd06
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/rockchip/clk-cpu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index eb6b8b878e4d..27d5b6f6987d 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -360,36 +360,36 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		goto free_alt_parent;
 	}
 
-	ret = clk_notifier_register(clk, &cpuclk->clk_nb);
-	if (ret) {
-		pr_err("%s: failed to register clock notifier for %s\n",
-				__func__, name);
-		goto free_alt_parent;
-	}
-
 	if (nrates > 0) {
-		cpuclk->rate_count = nrates;
 		cpuclk->rate_table = kmemdup_array(rates, nrates, sizeof(*rates),
 						   GFP_KERNEL);
 		if (!cpuclk->rate_table) {
 			ret = -ENOMEM;
-			goto unregister_notifier;
+			goto free_alt_parent;
 		}
+		cpuclk->rate_count = nrates;
+	}
+
+	ret = clk_notifier_register(clk, &cpuclk->clk_nb);
+	if (ret) {
+		pr_err("%s: failed to register clock notifier for %s\n",
+		       __func__, name);
+		goto free_rate_table;
 	}
 
 	cclk = clk_register(NULL, &cpuclk->hw);
 	if (IS_ERR(cclk)) {
-		pr_err("%s: could not register cpuclk %s\n", __func__,	name);
+		pr_err("%s: could not register cpuclk %s\n", __func__, name);
 		ret = PTR_ERR(cclk);
-		goto free_rate_table;
+		goto unregister_notifier;
 	}
 
 	return cclk;
 
-free_rate_table:
-	kfree(cpuclk->rate_table);
 unregister_notifier:
 	clk_notifier_unregister(clk, &cpuclk->clk_nb);
+free_rate_table:
+	kfree(cpuclk->rate_table);
 free_alt_parent:
 	clk_disable_unprepare(cpuclk->alt_parent);
 free_cpuclk:
-- 
2.56.1.839.g22a8290db9-goog

