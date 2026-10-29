Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.81.56.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247083;
	b=HaoQiSawsPyppTi/Lf8+Za0JvvVuMW4mhTBoZ7/qhQLMGgGwtVjPzDCvdu2hV+JM+CWD
	 mARYz2kf3WrntHxg+7yOmtQfMKHu+DXpQOzF8HnJiEUHU0+Q419kwyxouyqa/DYn27AxO
	 TdnbjCL1ej4rbsg8tDBmEtma2vCTv/yE71KL15B6sDX4RuxW4MOXMwblkQv2hG2J6SuAw
	 8Ca850OCvxnzKRFXU9F0ksgPxeMtA9zbIWqvrZZYcXu2xPF8G9rWiec4XVCgAviec7bT2
	 Ggn9tEqETCevXsdOsULcBq894/Ifj6F084VZCb3BHU5VOEc0Xuufs5oIXqrIU2d03hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247083;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DOqKVI6/U3QL5LYFpBxo025cnPh8REghaHnxKILgPgU=;
	b=N7PkM3bLrAUodp56C0/rML49YA/UdFIOJINRgTHGkYlVgBz4T3KvIllPGxuDHovL21st
	 GIo7rYGXkZ2jVU67ZZmAGVi/7dNneoJAfx5sx49FNATJbsOR36hWc2eNEShZYwiVZUcxl
	 6Hx0pHRVJqjOEjyDAEH4PRqkBmCxu4UuqQNqX5zsXeBLfKD+G64x+QyoHHpjRYuPtkzOO
	 k5s5GMp+yGwUPzCVyeedauGssHie+uPbiJM173Jlaz7Vk4jweL+qKJeVEZxKeKaCfhZG3
	 P+5oRcbEAP5EuxnqYh3h+BY6GjCOflZ/NcLCrzbPwbKEiOJgoqWeI9w0pxfgrl2wAMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bren.win;
	spf=pass smtp.mailfrom=bren.win;
	dkim=pass header.d=bren.win header.i=@bren.win header.a=ed25519-sha256 header.s=v1-ed25519-20260901 header.b=Kjo8Smie;
	dkim=pass header.d=bren.win header.i=@bren.win header.a=rsa-sha256 header.s=v1-rsa-20260901 header.b=iLm4m1DP;
	arc=none smtp.remote-ip=51.81.56.14
Received: from mx1.bren.win (mx1.bren.win [51.81.56.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28254606A31A;
	Thu, 29 Oct 2026 04:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28254606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bren.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bren.win
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=bren.win header.i=@bren.win header.a=ed25519-sha256 header.s=v1-ed25519-20260901 header.b=Kjo8Smie;
	dkim=pass (2048-bit key, unprotected) header.d=bren.win header.i=@bren.win header.a=rsa-sha256 header.s=v1-rsa-20260901 header.b=iLm4m1DP
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260901; d=bren.win; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1793247075; bh=DOqKVI6/U3QL5LYFpBxo025
	cnPh8REghaHnxKILgPgU=; b=Kjo8Smiet/vmG/GU93JVZHHKS1Nghkqacjw6RU4aSLTOyvBbyE
	0HBb41hbIk5zDsnPb9zqw3+wmZpm3iRm6eAg==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260901; d=bren.win; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1793247075; bh=DOqKVI6/U3QL5LYFpBxo025
	cnPh8REghaHnxKILgPgU=; b=iLm4m1DPX21ijS0LWg9yNs3/tfHMUJMqjF8IQFJqbGYWnGeUuK
	xBF4tBoZb3EfWfFOx4591BKM+H9oqkyXiTrhx2mOu9COhyx4eB9fYKthfQn+MQwSS8xfb5vYrQL
	QXHoHiyMCqEoSTWSsdvPhIpdobuRyJPSMBscVNrTd/tTsXeqkMxD0qjUAIsgkz/knwK2eDfVcZk
	Dfju5GWQO1dfodlBX6YLo8vhGhT1PAdLnptIaClsYrVwEw5JYV8g9W3OKRUFyCzC4OErQHPOKp4
	MnWMYzUI6s6rnG/tadThRZwG6y3rRVAE3zY0jgO1cTpDCvF8ws9B/zpvFy/+PzmTnWw==;
From: "Brendon C." <bren@bren.win>
To: linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Shiji Yang <yangshiji66@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] clk: mediatek: mt7981: swap MSDC and MSDC_HCK gate parents
Date: Wed, 28 Oct 2026 23:10:41 -0500
Message-ID: <20261029041041.3367084-1-bren@bren.win>
X-Mailer: git-send-email 2.47.3
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

The MT7981B datasheet specifies the storage interface as "eMMC v4.5 @52
MHz 3.3V". MediaTek's SDK and U-Boot device trees give the MSDC
controller CK_TOP_EMMC_208M as its "source" clock (max-frequency 52 MHz
= 208/4) and CK_TOP_EMMC_400M as its "hclk", taken from topckgen
directly, with the infracfg gate only as "source_cg". The mainline
device tree takes both from the infracfg gates instead, and their
parents are the other way round: CLK_INFRA_MSDC_CK from emmc_400m,
CLK_INFRA_MSDC_HCK_CK from emmc_208m.

mtk-sd derives its divider, the reported actual_clock and its data
timeouts from the source rate, so with a device tree asking for 26 MHz
it programs CKDIV=4 and believes the bus runs at 25 MHz while the real
bus clock is 13 MHz, and every clock-derived timeout is sized for a bus
twice as fast as the real one.

On a GL.iNet GL-X3000 (Samsung 8GTF4R eMMC, 8-bit, 3.3 V, HS) this shows
up as msdc_track_cmd_data write data errors (host->error=0x4) on
roughly every 40 MB written, escalating under sustained multi-segment
writes to exhausted retries, "I/O error, dev mmcblk0", lost page writes
and a stopped f2fs overlay. Raw direct reads top out at 11 MB/s where
the vendor kernel reaches 23 MB/s on the same card.

Swap the two parents to match the vendor device trees. With the same
device tree the bus then runs at a real 26 MHz, reads reach 23 MB/s,
and four rounds of a 1.4 GB mixed direct/buffered write stress complete
with zero retries and zero I/O errors, matching the vendor firmware.
hclk's rate is only read for the CQE idle timer, which no MT7981 device
tree enables.

Fixes: 813c3b53b55b ("clk: mediatek: add MT7981 clock support")
Cc: stable@vger.kernel.org
Suggested-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Brendon C. <bren@bren.win>
---
v3:
- also move CLK_INFRA_MSDC_HCK_CK to emmc_400m, matching the vendor
  device trees' hclk (suggested by Shiji Yang)
- correct the claim that the SDK kernel parents the gate from emmc_208m:
  its gate has mainline's parents, and its device tree takes the rates
  from topckgen directly
- v2: https://lore.kernel.org/all/20261017194308.1541507-1-bren@bren.win/

v2:
- add Fixes: and Cc: stable so the fix reaches 6.12
- v1: https://lore.kernel.org/all/20261017190729.1369302-1-bren@bren.win/

 drivers/clk/mediatek/clk-mt7981-infracfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -157,8 +157,8 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA1(CLK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", "infra_66m_mck",
 		    14),
 	GATE_INFRA1(CLK_INFRA_FRTC_CK, "infra_frtc", "cb_rtc_32k", 15),
-	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_400m", 16),
-	GATE_INFRA1(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck", "emmc_208m", 17),
+	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_208m", 16),
+	GATE_INFRA1(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck", "emmc_400m", 17),
 	GATE_INFRA1(CLK_INFRA_MSDC_133M_CK, "infra_msdc_133m", "sysaxi", 18),
 	GATE_INFRA1(CLK_INFRA_MSDC_66M_CK, "infra_msdc_66m", "sysaxi", 19),
 	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "infra_adc_frc", 20),

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.55.0
