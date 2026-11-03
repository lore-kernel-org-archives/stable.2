Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703345;
	b=SUbKvOs0L1VLk6gPUchR7XtHaJ+E3UB/tmb387zLG01TJyaZlsQRXGcEn31sefkRenNk
	 BNptSvEpvEQrXtf+ilpyUbYx/c/k1rlZ2hWDBkEvFw3uIkRXfJcUuVtrTRd2aZjjB6loa
	 +7dYP5rGRxIjQKDGB1+2W/2wLrAGL+5LnSM3L/xN76Z61bvEhgaOTsz5nDcYx598EzEKJ
	 ltXronP0R7rRSdsAaFTMff9HSQskhl4Os+qKkzQyUsiJEHvobEVbsWHcAAOsw10v3u8LQ
	 Btu556HgGfbuDR9Ff53upXWp9RYeawACDkOcQUGTLvgwmrMaBw07xpuepuCRKsR2Szg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703345;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=UjnvTBM/YYG24vlGmk6I7vQOjp8mM6En/1DCBRv6q50=;
	b=ruk9LmeBo4esfQ1duBPnrZKrxP9WJx8Ie2pJALHJY51BvVyEeNGVcSJDKMWHA3o/1SXA
	 oVVBDKLektcI3ujOxQhm2O1ISeTX07n98MNOiZiWhjSdRZxmj8Eh1SmmzcGC5V+mrS56P
	 gTy76IRLOD2YmeaTCQu4PxN7llo9KKSOy+xPWp66Z56gGlCoDuza5I1UMdgZe5AEbNEyB
	 Qu7bMFLzDB41waRB2j6kt7AI803l6+cX5/DVtP5nIujf9Kb3lEJ0tfNLvI+hQCxH9ZWXw
	 jTHzhCfMa7a/+q1kkRbobz+FGiAch+ahfCSOCv5cOS1+K1eWMZ1v41fJHKbAKBXSGBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9A60775E5;
	Tue,  3 Nov 2026 10:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA9A60775E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnt5ipvelq2OE7AA--.3022S2;
	Tue, 03 Nov 2026 18:55:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: stm32: release the LSCO clock provider on remove
Date: Tue,  3 Nov 2026 10:55:46 +0000
Message-Id: <20261103105546.1394618-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACnt5ipvelq2OE7AA--.3022S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3Zr13uFy3uw4fZr48Crg_yoW8Jw4Upa
	y8GryYkrWktr4Fg3WkXr1qva4Yy3ZIq3yFkFy7C39a93ZYvFy8Z3yrXFyrXF4kJF4rCwsI
	vw47Kry5uFW8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UC38nUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQAA2rpnOGESwAAs6

The LSCO pinmux action registers the rtc_lsco clock provider with
of_clk_add_provider(), which takes a reference on the RTC device node.
stm32_rtc_remove() unregisters the gate clock but never calls
of_clk_del_provider(), so the node reference is never dropped and the
provider stays registered with a pointer to a clock that no longer
exists.

Delete the provider before unregistering the gate clock.

Fixes: bb7b0df2be5c ("rtc: stm32: add Low Speed Clock Output (LSCO) support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/rtc/rtc-stm32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 1c4e4bd7afe4..a77868bd79bd 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -1215,8 +1215,10 @@ static void stm32_rtc_remove(struct platform_device *pdev)
 	const struct stm32_rtc_registers *regs = &rtc->data->regs;
 	unsigned int cr;
 
-	if (!IS_ERR_OR_NULL(rtc->clk_lsco))
+	if (!IS_ERR_OR_NULL(rtc->clk_lsco)) {
+		of_clk_del_provider(pdev->dev.of_node);
 		clk_unregister_gate(rtc->clk_lsco);
+	}
 
 	/* Disable interrupts */
 	stm32_rtc_wpr_unlock(rtc);
-- 
2.34.1

