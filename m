Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5223B994F;
	Thu, 17 Sep 2026 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633027; cv=none; b=tjs7JXHWbmemnuKAJBtJANSKm9etG1iLTevBtQdaimQ5xFsvfMhwVVCihsA5YhWU/K83K+qF2+Pkc41jzi7CIrd4vzDKOcoOSfFIagZp8g1Hh5SGvOqwYjj8VfAorpBaMF4RqeZA2I253klNkp2GSYVfIgs12ycnFtDIuqzvy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633027; c=relaxed/simple;
	bh=irOsyhvGvw0CQJbGaZtUxAJVTX8hnbnlTDprGG5vL2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=df8wodtDtLoUYZbuLR7tdkZcfSd7nlph82UQXzjtRnXXTbw2OnsztsoyZgPeuRSDi6UxaowckGTsP3QeLW62zvceMfu2t0hzNXk4tgu6OK/OmEHAHMDzCP2L46iS8bQINsbO3+eXAbH+DpIXwNzw5CO62eGMe2sownW+hPBz9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLzow3By; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLzow3By"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3B11F000FF;
	Thu, 17 Sep 2026 08:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789633021;
	bh=QDyuTO0ZRwbxBwmEf+aUlRK6Ejj4v7oLYhRv9ipxsZ4=;
	h=From:To:Cc:Subject:Date;
	b=YLzow3ByjYz4Nltp3wIx4GflEpu2GJ50QEuJyLZ+gPTs/SdzrCugpRVN1Dkhlhx0g
	 MHBmfOPM+dGYEHnuK9nTVtBZEig1aFSDmo0ko+z/c9gisRV3QX4VG2ve/nspMEsBCT
	 r4p96tDWrVPbiAk5/s3pmsFZ30B0lX1b9HSianoHrLK2KW9e9guWxAyK+V6CrKkT1+
	 QxSa/qPVNxrS4PtAIw5Zujl9aa6HbvJx5SfJdRpkw0sdOYf74Vt77TwaW06+AQAgkE
	 dEfUx8dlqwUILzVai5eGdvwaNo7N+Qgx+ih1atHXfQdi64Xy9Qbm2IlxbnfKApbS0S
	 rIR65RY34WJTA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: soc@lists.linux.dev
Cc: linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH fixes] soc: samsung: exynos-pmu: fix use-after-free of interrupt generator node
Date: Thu, 17 Sep 2026 10:16:42 +0200
Message-ID: <20260917081641.72291-2-krzk@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=krzk@kernel.org; h=from:subject; bh=dE3+/DwJCR9TouOaCXZbn37MEpseKqnU4nyKAMX3J+Y=; b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqq6Hpfmg1EExaA4JgYrGTpt82/nt+ZKPakZCU4 VEng7yjWgSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaquh6QAKCRDBN2bmhouD 17hVD/9i2Gymlk29bdGxFhA84Gwu4oAuOHXMoJetd0ixu4Xxz6V16ibx7qFZBlj2DjKrWtFDm2Q jDLjvwG2/bwcDfvaa0AcYyOTHQmEbW+ZqR8OygkRn5EyeGoBE5ejicacTIHe24ROdw5+M88gnQv L0A5iyYto3RmEaiZIEerD/UIfwnCVv2iIyPX4ITPDQMUpbGmKJuiB9awk5L+IiHpkjnCwIO/zXa 29tgFwhUuYiBtK3XtNrLtM7uZtngsdlSFM9xHEyJomMmfKqKxiIeIUUeCBzw5dZLiZnsblnzZo4 L7m0n24Rh6spssSpLQVNPDnM3R6ynU8ADbMXpcE2pVlxyMVw6K1Mo/6PX9H0NTcuS7g7v6JcbMl hktAXyU+YSIck/laKAbJq3UrZkQxAO39thXD7ozNACTUliwylK/8cXtxdjV/OS8yY//2H8mR7ft Uj/QbIJ24uONWVWZTDPDD+BmYCaYNO6cuPERZS9fCdxyuPeB27IbBwEp6XgiIXo6/UYmKwZ5+Fn Yy4r7Q/vdwfyWaR3hJCz6TEagGvLjJAHNfGjLA216fU9JdqcSjkU4lGJKcdOv5G3jqkFw5Fxp0F 2KtaSfQfdDGktcawIQGhxmZVbV4F7cl751T1GroPynyHqDJ+6qEPbtEgEABN8v1kX2IQFR6QxN5 RUuvsYxFJi8vS/g==
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

