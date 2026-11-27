Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802673;
	b=JcFsYrpJVsT4y3cVgai+f3LMKWwm3dfXs5FJ6Tv8wQsLNVHgjn2SWkZNDyLpeHvG9g8T
	 9pZmH2QWB4Iw6yFCcutXMJKt6ChmMRIUpvVeQaHtnXEOU2kZVz6KeUk2zwCX8k19wD4ul
	 jGgTabIoSlmZgpkvHH+AtQsyNbK/qV+EHCve73h8zeFPIFzvobDt0kdiQpLNh+RKKY3DY
	 6POk8OTCLRcMgrRc/N5a6gBw3ru9O4CZ8HT2dfaCMFoUuTid2xueCMoQcJHm3U5CL158g
	 smB3FpaXI3HNrL6ptFzeb0QH3MHRyioP75/xTN/WX7Yx2jqOa9eBv7WM+fiC3xhzjSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qe14tgxTCMfnyxp7bch1qUtRx5SdNgj5ROLZ22SbLsw=;
	b=fRDV331+Hq310f9L9P/JXbtpFjk/Az5fdqf/B1+bSSH6tW8YG/5BU2pf84xz1JW3EsQ9
	 J3aiGRPaUzZPyVm593i85Nx9qqwkLeFaXFyqcUuPcVarsh8D9FsCIDzTshYLDowRbonki
	 u9aZYLVVfedwLxxv/ihgdKN/rSnkxXIx8bqfPsa1IheCDZDHdrEz+a2Tla4gVVq04etji
	 yIydCK+KJ9t4cfY9aQPHEbIClaXedwY/nX71arCILYU9pWUeh4AVU+IGucI3/5LJdqXFm
	 AOiWmbdoM09X24MV1jZKWCTWgnfU1TI4MBTiyuhckJBRgCwv1mpaVNH0ntZRw1I76/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne+u+HRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349E606A326;
	Fri, 27 Nov 2026 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne+u+HRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6636C1F00893;
	Fri, 27 Nov 2026 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802672;
	bh=Qe14tgxTCMfnyxp7bch1qUtRx5SdNgj5ROLZ22SbLsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ne+u+HRj00++BdWk3T7wUB6ThytNoyacf0tNpaP9od9pUDdyZ+Vqi9d8Rqv6QZFc6
	 +tnx40B9oeYkM9E+dvOCx8KrvJ+AAO18LrWIweb4WOUhJTAz44bwa6K+cGK/RpvZla
	 MDQpC8B6jKPz22CLFsTA8DZiGXoXY0s/V1aB9yk0NGiq54gFP+eTHHpBDyAe4Y/5KI
	 Mk5ToF0hZXrODsbw3zwtG7sWIqpL4yIfy34IbybbgHSbjEiq4enbf5sHvTTZpTanGV
	 +VB4aYE9HDboJ9T1/cmmQpJZFYzjN8x4J2LC8mqgs1m360jkCEeFZGznLZ1j8lFY6o
	 LJ/fsuw/Ldb1w==
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/12] clk: samsung: exynos5-subcmu: Detach power domain on add failure
Date: Fri, 27 Nov 2026 18:03:09 +0000
Message-ID: <20261127180416.3277544-2-lee@kernel.org>
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

exynos5_clk_register_subcmu() attaches &pdev->dev to its generic power
domain via of_genpd_add_device().  If platform_device_add() then fails,
it frees pdev via platform_device_put() without detaching it from the
power domain, leaving a dangling device pointer in the genpd device
list.

Record the return value of of_genpd_add_device() (keeping attachment
non-fatal when power domains are disabled) and call
pm_genpd_remove_device() before putting pdev if platform_device_add()
fails.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Closes: https://sashiko.dev/#/bug/linux-0f461223-0d95-4e2c-b3d1-eac8e585e532
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 373129847301..b0781e9f5640 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -137,7 +137,7 @@ static int __init exynos5_clk_register_subcmu(struct device *parent,
 {
 	struct of_phandle_args genpdspec = { .np = pd_node };
 	struct platform_device *pdev;
-	int ret;
+	int genpd_ret, ret;
 
 	pdev = platform_device_alloc("exynos5-subcmu", PLATFORM_DEVID_AUTO);
 	if (!pdev)
@@ -145,10 +145,13 @@ static int __init exynos5_clk_register_subcmu(struct device *parent,
 
 	pdev->dev.parent = parent;
 	platform_set_drvdata(pdev, (void *)info);
-	of_genpd_add_device(&genpdspec, &pdev->dev);
+	genpd_ret = of_genpd_add_device(&genpdspec, &pdev->dev);
 	ret = platform_device_add(pdev);
-	if (ret)
+	if (ret) {
+		if (!genpd_ret)
+			pm_genpd_remove_device(&pdev->dev);
 		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
2.56.1.839.g22a8290db9-goog

