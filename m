Received: from mx1.bren.win (mx1.bren.win [51.81.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7084CF461;
	Sat, 17 Oct 2026 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.56.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266220; cv=none; b=HDsCkuIOeO5YeE59PfHXnSZ/MpYhhLBSNPa9bnxLoMi/pEtXnfn5H1Kc+xVPQVhTXp4szZ9p7Hdnp3lphdi3pGuKRNVf9NrOZQUPhZTTiarsi2kZbRnLnBGqm4YqHstyFzHshTQLN2UR/jaql+y7Oar6J2LVX7z4upNh+dIfdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266220; c=relaxed/simple;
	bh=4VJJpzrYPQwWPT9k9guTizo863FPGPNnHOu7gtlArto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLHxgx9BDLIBt7jKbnhr9E94Tre+jfLnMdDnCrdhVqWEn/5cBFFlA5AcnQIjuFmphgAnuifI2asaA3zf91gshXsJFV/09Q5dMYt8uTjJrngpTcAw/NKrbecRwgjm6hHKvteMp7MQLKi+wmEwB/rjmYLAMc5rDjc2Wwkw6H/8HiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bren.win; spf=pass smtp.mailfrom=bren.win; dkim=permerror (0-bit key) header.d=bren.win header.i=@bren.win header.b=LIkwzP9V; dkim=pass (2048-bit key) header.d=bren.win header.i=@bren.win header.b=r9yuZ0AL; arc=none smtp.client-ip=51.81.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bren.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bren.win
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=bren.win header.i=@bren.win header.b="LIkwzP9V";
	dkim=pass (2048-bit key) header.d=bren.win header.i=@bren.win header.b="r9yuZ0AL"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260901; d=bren.win; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1792266203; bh=feAW8sNvX4y7Z/iBdWCH/eX
	YB2pXonRKpjrqViUaCfw=; b=LIkwzP9V92PBqPzeHSEYssjkW1cD5WqMubuWZRTPQmweF6U2Dq
	NMSnzmDUeEOIHVblVLST0Pm29K0CRfxLHnBQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260901; d=bren.win; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1792266203; bh=feAW8sNvX4y7Z/iBdWCH/eX
	YB2pXonRKpjrqViUaCfw=; b=r9yuZ0ALtiW9PXG2nnS3Y7Gd1cjrhjSP6xDouXjnw4K49c0pAC
	2/BEYj7HvE3+0Y+wq7cvmz2yCJS4AOd79L4FZcR24Zcvyt2/7FY/Tjklt9jJtEhG2LVLRTVq9Tf
	Wz5vA5XBtCsv1C2l1S23k4mz16XthaRcpqlNAQWnFVs2TkdlN2hPtxNWPIAK3Dlaj5G7Q9Fwd38
	yjfL1JDFNXYou9EdKxyRsd4vyaDxqtVInNnkRUTTcSqRIpjcsiu/Iq0Wv2FPnbm6+NDY0ysD77X
	XfRVOn8HdKTgmxBb1VR6KMZYDZJ5T9LEDzMmyLEqQ0qyCRejjY5x3z4CmO8VxBIKeMg==;
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
	stable@vger.kernel.org
Subject: [PATCH v2] clk: mediatek: mt7981: feed MSDC from emmc_208m, not emmc_400m
Date: Sat, 17 Oct 2026 14:43:08 -0500
Message-ID: <20261017194308.1541507-1-bren@bren.win>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT7981B datasheet specifies the storage interface as "eMMC v4.5 @52
MHz 3.3V", MediaTek's SDK kernel parents CLK_INFRA_MSDC_CK from
emmc_208m, and both the SDK and U-Boot device trees hand the controller
CK_TOP_EMMC_208M as its "source" clock with max-frequency 52 MHz (52 =
208/4). Mainline parents the gate from emmc_400m instead. mtk-sd derives
its divider, the reported actual_clock and its data timeouts from that
source rate, so with a device tree asking for 26 MHz it programs CKDIV=4
and believes the bus runs at 25 MHz while the real bus clock is 13 MHz,
and every clock-derived timeout is sized for a bus twice as fast as the
real one.

On a GL.iNet GL-X3000 (Samsung 8GTF4R eMMC, 8-bit, 3.3 V, HS) this shows
up as msdc_track_cmd_data write data errors (host->error=0x4) on
roughly every 40 MB written, escalating under sustained multi-segment
writes to exhausted retries, "I/O error, dev mmcblk0", lost page writes
and a stopped f2fs overlay. Raw direct reads top out at 11 MB/s where
the vendor kernel reaches 23 MB/s on the same card.

With the correct parent the same device tree yields a real 26 MHz bus,
23 MB/s reads, and four rounds of a 1.4 GB mixed direct/buffered write
stress complete with zero retries and zero I/O errors, matching the
vendor firmware.

Fixes: 813c3b53b55b ("clk: mediatek: add MT7981 clock support")
Cc: stable@vger.kernel.org
Signed-off-by: Brendon C. <bren@bren.win>
---
v2: add Fixes: and Cc: stable tags so the fix reaches 6.12 and other
    stable series; no code change. v1:
    https://lore.kernel.org/all/20261017190729.1369302-1-bren@bren.win/

 drivers/clk/mediatek/clk-mt7981-infracfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
index 68a102d..3d98bff 100644
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -157,7 +157,7 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA1(CLK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", "infra_66m_mck",
 		    14),
 	GATE_INFRA1(CLK_INFRA_FRTC_CK, "infra_frtc", "cb_rtc_32k", 15),
-	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_400m", 16),
+	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_208m", 16),
 	GATE_INFRA1(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck", "emmc_208m", 17),
 	GATE_INFRA1(CLK_INFRA_MSDC_133M_CK, "infra_msdc_133m", "sysaxi", 18),
 	GATE_INFRA1(CLK_INFRA_MSDC_66M_CK, "infra_msdc_66m", "sysaxi", 19),

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.55.0


