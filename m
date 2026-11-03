Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700320;
	b=Iy/z/eVLLj8toJiJ4FGlICYLZU74/yWh/qUOZAb2/c33Ne10p2aBDohfSgPF2XRxqDsB
	 eKVbS36Of4ge2/y52wIRNp63jyNULhnNjwbAh3bHq7QPaYRZIGVh638oPC9m/6gbEWFUh
	 WybU71JGHUDMI5FctdpVTTCfuWFl0Q/5a3tTwH8fWfXhvhQ8qO+P3Fj6tiGMssrYHJAHx
	 7dNfOaPmDt5oG53FSGMvsy0LuaDy4W12e7mkUkdIezDbi0zGCK+xVd9s8ZhIApArZVMk0
	 GwqzZHkD8SOWmemXGQW5U6Ot3WlvPbRXwUtMn9ihIrxLZoyOrAsjF8msZ4LUmHqORxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700320;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=xWha5x+sclOSUOwxcjH9Fy7xQDjuXfr0A01pOAbZ1wc=;
	b=iTHRDZoOozH0j0m0MIbe8BKefMYOP6J0sCocS6n7V96W1mQ0vpd2ySGWqETijFgqAK22
	 VkJ6lPPZbI7LV0Jjhdm5Ox8gdW0R8Mn2Vn5DGFVxDXUXeQPiCHoVw6fECiKSB6TBi3U5Z
	 uwkRwv5Jd/K2sP75rxgFIFqbvEDafCH79aL+HSX/WzNm/9HStdSaRuXlaQlgHWSjYB4Gx
	 0zakSUkmRN1L0mlVz1HgmREkET0RJJrjsvYmsYbnAVOzks/Q5SZpwKVyemhTDbwEo6xjh
	 PjYSEfX24r42MB5zBdGkPAW91dYRoOPzi7MYPDQAbI/POKsPKbvp6BMjdqUIaP5ly0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D8606A32D;
	Tue,  3 Nov 2026 10:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301D8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH15jYselqC3s7AA--.5349S2;
	Tue, 03 Nov 2026 18:05:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Michal Simek <michal.simek@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-arasan: Unregister all clock providers
Date: Tue,  3 Nov 2026 10:05:21 +0000
Message-Id: <20261103100521.1309763-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowADH15jYselqC3s7AA--.5349S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UuF13Gry5Zw4xCrW8Crg_yoW8Aw17pa
	y5WFW5Ka4qyF4rurZ5tw4Uua4Yy34FyFW2vFW7KwsYq34Ygry8Cr12vFyjqFWDXry8C3Wa
	qr1DZr48Cr4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1K9aJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUAA2rpnIBhxwABsn

When #clock-cells is non-zero, sdhci_arasan_register_sdclk() registers
two clock providers for the same device node: one for the card clock and
one for the sample clock.  of_clk_add_provider() takes a reference to
the device node for each registration, but the unregister helper only
calls of_clk_del_provider() once.  The second device node reference is
therefore leaked and the sample clock provider remains registered after
the driver has been unbound.

Drop one provider for every clock that was registered.

Fixes: 07a14d1df454 ("mmc: sdhci-of-arasan: Add sampling clock for a phy to use")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mmc/host/sdhci-of-arasan.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0ee22923ad56..dccd2980fdd6 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1648,11 +1648,20 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 static void sdhci_arasan_unregister_sdclk(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
+	u32 num_clks = 0;
 
-	if (!of_property_present(np, "#clock-cells"))
+	if (of_property_read_u32(np, "#clock-cells", &num_clks) < 0)
 		return;
 
-	of_clk_del_provider(dev->of_node);
+	of_clk_del_provider(np);
+
+	/*
+	 * sdhci_arasan_register_sdclk() registers a second provider for the
+	 * sample clock when #clock-cells is non-zero, and each provider holds
+	 * its own reference to the device node.
+	 */
+	if (num_clks)
+		of_clk_del_provider(np);
 }
 
 /**
-- 
2.34.1

