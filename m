Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CC21A42D;
	Thu, 17 Sep 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632920; cv=none; b=EIJg2UA6gKZAGwNmE1dsenENQ+8L8Ap9EAe4Sn8/abu5ydRitTsy1rrbeRpZafA9/LI+cylkqk+GMW14scVDIKzeh29+ltYJxD7jFMiFbpqMiTiAf+DrQND1TSTbUtlxa3ZVOJlOZMjQ/hvy59QeQKaq1q6962U1GOO12REfNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632920; c=relaxed/simple;
	bh=irOsyhvGvw0CQJbGaZtUxAJVTX8hnbnlTDprGG5vL2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omMnIhikFrJ7VPzm90EbgsskvynaDMZLNJV6of8JPS6G02D6pugbM+Cy3D71axVAQU5FrEm3S0rzLdysWxujmr/et1+I3D5OXJMoZYk9fs3zC7c0/v1G431gQP8sxGEEp4vJok08hgbgPA67wU9OC8M7v4IQepnjTxeQwng1EPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqB946gz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqB946gz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB001F00899;
	Thu, 17 Sep 2026 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789632919;
	bh=QDyuTO0ZRwbxBwmEf+aUlRK6Ejj4v7oLYhRv9ipxsZ4=;
	h=From:To:Cc:Subject:Date;
	b=SqB946gz59b2RK7yo9v8JaVtoNHYj/1qfiDgVQSkVvQ10uIyUDuV87kqktecI1Xfk
	 Y461oPZTcDhp7ARRgvK//M7KeQG88Eo71ek2ochcr2mlxkbslDYm+jluTTLUZcgriP
	 lY3d8rbPVCoc5FrTotEOmQjBpHp0Dm6iIFKsBUsARVybKHcPLWHZHVjHUH6+JIr/DI
	 ieCwcOjD/umuvsP7D4UQD8ffB9nC8NdsTssCeqaGhKFCwE/PA1l7nLT1SYtBXL/og1
	 HeYkbUw+jUNlErR7eftOQVI/155NhKd/t2NUueuD6PeSbYAS3qOWREHfhnnwlz4V9G
	 QRkWBJ4IECjug==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH fixes] soc: samsung: exynos-pmu: fix use-after-free of interrupt generator node
Date: Thu, 17 Sep 2026 10:15:11 +0200
Message-ID: <20260917081510.59599-2-krzk@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=krzk@kernel.org; h=from:subject; bh=dE3+/DwJCR9TouOaCXZbn37MEpseKqnU4nyKAMX3J+Y=; b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqq6GOfmg1EExaA4JgYrGTpt82/nt+ZKPakZCU4 VEng7yjWgSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaquhjgAKCRDBN2bmhouD 1xwCD/47Xr98/iTaeEhMXsYh7XA3Ab2nRUQglUf8QQ+204FVgDyDk0O+Zc8z1cqcOqCZ1cDs6lY YSu2n8xLSl0j0CKuwH/4E/Crlb+SAOrfHyhhtrf9w7IjALw1R5l5Oge5f17UGnp8df38W2SrBTi RnHYxogE4RpY60Y18BwjeKelW/jYRzy1+2tUwvSL+8ZAqpyn/NQH8beBaWa+YETXJqX7/awDwzk HHlouS6bpisTSH6liyul2WNkbn+StDWyCV8HQMogvsr6pKFRCfpqwVVOeFW3q6787PRi/xMwBmg l7Z4nMEvBuoSHaJWNTuLPlyYe8NBoInERSeEJGy518na0bPU/POxfn4vZEzmUNc/qLcvcmnH3e6 uPgrQcOdytZey0AnKx8SpF6jdBh9HhhuMyGI3MQ6n8/MzrceEZP+M6bAKqsojfQ6hVo+xfOvM27 0kiAKer4GduAPvjRfLIKegPBZ5W/UN5g12z3BiwsjHa1OyiXpC1gdBFV3slHHyOpILrx3SWWr8R vz9Y2FUGC2ixH1vbdxPzkoFBvSN3Q+uZEsoQwRScTyNhdAwfg8feFtt9rRyDcwGMONfCrT+FtdF hi44atFRXq0JpWKuqXZUxHBtSE3RMGWpSOLOoFEGE0fsQrC3Opb1UAUANH5Jdm0B1/hr9wYmMTi +q5lRNXq4oM10tg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

From: Alexey Klimov <alexey.klimov@linaro.org>

The setup_cpuhp_and_cpuidle() parses the device tree node for the
interrupt generation block via of_parse_phandle() and decrements its
reference count using of_node_put() immediately after fetching the resource
address. However, later the intr_gen_node pointer is passed into
of_syscon_register_regmap().

Fix this by declaring intr_gen_node with __free() and removing
of_node_put().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
Fixes: 78b72897a5c8 ("soc: samsung: exynos-pmu: Enable CPU Idle for gs101")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://patch.msgid.link/20260828-exynos-pmu-cpuhp-idle-fixes-v2-1-06bce6107bd6@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/samsung/exynos-pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index f5fcdde9750e..efccdd63e40e 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -409,13 +409,12 @@ static struct notifier_block exynos_cpupm_reboot_nb = {
 
 static int setup_cpuhp_and_cpuidle(struct device *dev)
 {
-	struct device_node *intr_gen_node;
+	struct device_node *intr_gen_node __free(device_node) =
+		of_parse_phandle(dev->of_node, "google,pmu-intr-gen-syscon", 0);
 	struct resource intrgen_res;
 	void __iomem *virt_addr;
 	int ret, cpu;
 
-	intr_gen_node = of_parse_phandle(dev->of_node,
-					 "google,pmu-intr-gen-syscon", 0);
 	if (!intr_gen_node) {
 		/*
 		 * To maintain support for older DTs that didn't specify syscon
@@ -431,8 +430,6 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
 	 * syscon provided regmap.
 	 */
 	ret = of_address_to_resource(intr_gen_node, 0, &intrgen_res);
-	of_node_put(intr_gen_node);
-
 	virt_addr = devm_ioremap(dev, intrgen_res.start,
 				 resource_size(&intrgen_res));
 	if (!virt_addr)
-- 
2.53.0

