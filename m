Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802680;
	b=dr+tp77ChZGwVxjBstb1svVxHcNqjEpLac/mjReUUVny1gU1mYo/VyaWjq8eo7AsNxOf
	 a1Zxj93i6c7cqYIhLCDqvVr9PGBfpiMoNZYN3YAsSezlxgbWkMUWkGmGB0h22xitjBdiJ
	 CpIyDsxWjtwx4xWyLt5+ne681Q27IjBv/Kim31qP/4E37XyY4LMYkAB7Y4R5Bhpq3eesI
	 OcWJmr2e7e3wSPgV9FEfSD36K7oyqVhV7QE1Wz7xgO5FAyVrYzWsKaedQWsWkkQ7oFlyy
	 xWi2k6wwT7X6+1lV+sgOy7nWInnw2aCpRefJEi6+53SywiXoruoWMCLGEjWcZtk4aAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802680;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hJPmeFL4tUBd+lgcZ3/9m6XpdTjdrIyrjYdZJzGiKoM=;
	b=Suwe2d1RBIDlOyhs1a5+mg+hHEJN0QQyqfQLI7gdL1fyK94wfY0fJxArWmMNoEbOAMk/
	 MWu5UXlr2p/9egN1FiVPZ2Q/h9ypGq110CJeLKasZwIJX5cs0iYlmbzjkXWONj49bEdX9
	 bRYaKf1JoxmmVndBN31dAGQ5py19Mhb6tULfLqM0FevtUpUzO3oaJTwu7Xvp1/VCRxKPC
	 GZqffsnwBTja3C0cUUOSm/kJ3lQRyql7TtvKhHU/dVOII4F9H0BJKRU6t4n8vLZU/CiJN
	 Me7NeWNiG0p75oYgF1L6M14xo8hCHiwk+dqtQKciuy1Uk7zxiKjM7I+7fRV779zfPgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c0ag/05+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9D606A32D;
	Fri, 27 Nov 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0ag/05+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E0F1F000C1;
	Fri, 27 Nov 2026 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802679;
	bh=hJPmeFL4tUBd+lgcZ3/9m6XpdTjdrIyrjYdZJzGiKoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0ag/05+vlxEMz1SZVuspjQvws451DB29LEdWu5I7+R8fxhxibje68o6vPIPMvgAZ
	 5/e2rJTAMu9saiao7eZQ7kfTa1G+ByTiQCFNrBCcQjX69LI76ba0CN+BiEZQoHhc1r
	 s2ZgLrxMagQdoRU7EQ0JiH0jYUQveKBsRk8661PUCqm8P48GkQUWZM5+LnrV2s3Eb9
	 WVEt30y9sw6JYxT+wPLwCV6GqWNGSW6NUbxlBTcBVQ4xPyRPlIaRzHii0p+kE9UhES
	 +w2lVy69NNcEYhwgyzy091ah01eFlx+ZbG41TY/G1/akZ8vr3OLlTYga9mlFi4Jpzq
	 tdMpToxBoWEXw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	=?UTF-8?q?D=C3=A1vid=20Vir=C3=A1g?= <virag.david003@gmail.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/12] clk: samsung: exynos-arm64: Do not store ERR_PTR in data->clk
Date: Fri, 27 Nov 2026 18:03:10 +0000
Message-ID: <20261127180416.3277544-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127180416.3277544-1-lee@kernel.org>
References: <20261127180416.3277544-1-lee@kernel.org>
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

exynos_arm64_enable_bus_clk() assigns parent_clk to data->clk before
checking IS_ERR(parent_clk) or enabling the clock.  Because
exynos_arm64_register_cmu_pm() logs the failure and continues
registering PM callbacks, exynos_arm64_cmu_suspend() and
exynos_arm64_cmu_resume() later pass the error pointer to
clk_disable_unprepare() and clk_prepare_enable(), causing a crash.

Only store parent_clk in data->clk after IS_ERR() and
clk_prepare_enable() succeed, and release the clock reference on enable
failure.

Fixes: f05dc2024316 ("clk: samsung: exynos5433: Extract PM support to common ARM64 layer")
Closes: https://sashiko.dev/#/bug/linux-d237d28a-7387-4379-9bf4-331a7052082c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos-arm64.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
index 35d4de233cc1..360bd5d8421d 100644
--- a/drivers/clk/samsung/clk-exynos-arm64.c
+++ b/drivers/clk/samsung/clk-exynos-arm64.c
@@ -149,25 +149,33 @@ static int __init exynos_arm64_enable_bus_clk(struct device *dev,
 		struct device_node *np, const struct samsung_cmu_info *cmu)
 {
 	struct clk *parent_clk;
+	int ret;
 
 	if (!cmu->clk_name)
 		return 0;
 
-	if (dev) {
-		struct exynos_arm64_cmu_data *data;
-
+	if (dev)
 		parent_clk = clk_get(dev, cmu->clk_name);
-		data = dev_get_drvdata(dev);
-		if (data)
-			data->clk = parent_clk;
-	} else {
+	else
 		parent_clk = of_clk_get_by_name(np, cmu->clk_name);
-	}
 
 	if (IS_ERR(parent_clk))
 		return PTR_ERR(parent_clk);
 
-	return clk_prepare_enable(parent_clk);
+	ret = clk_prepare_enable(parent_clk);
+	if (ret) {
+		clk_put(parent_clk);
+		return ret;
+	}
+
+	if (dev) {
+		struct exynos_arm64_cmu_data *data = dev_get_drvdata(dev);
+
+		if (data)
+			data->clk = parent_clk;
+	}
+
+	return 0;
 }
 
 static int __init exynos_arm64_cmu_prepare_pm(struct device *dev,
-- 
2.56.1.839.g22a8290db9-goog

