Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF0392829
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187566; cv=none; b=e52+b9xQo+4iRMaHDalnLKUz0hU6Dye3hQX37rfYSra8iFTs8KbEDisPNBA21u/c9G7R0Bk7m+TjlZa9IpxxOVfPcstdSYZQSbZG6sng6lG0Q26i1RrHSb8zuw/U6Rv9luWxbDghx498ePwBbI7Hk8CgQlsEr0jsjHhNDPXBbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187566; c=relaxed/simple;
	bh=zh3n/6vMKAYsQBFDuYYaQzWvVH3R+LSQiSxJOuPjO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWYzhX41Ho+yEsieg44NdqzcrGU95QcyJyrzDRUgZopMyi+5Um5yiBQ6jPCNhYbyqGNRO+nZT1vVTqnm/JnXiM1n8feR8r4A08jQIcTcWygj/ZJvEbgTGIK/1EOuTdCPXcUZWvrdAQ5g8F+KYfQev3Gw26zmbD5OdlRejAxaxvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWtogN8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWtogN8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D891F000E9;
	Sat,  8 Aug 2026 11:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187564;
	bh=OUh8IIS3qH7iDL08ce1v3242pScC5xRttytJ7v8t8bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SWtogN8r8bwAaSRQVataGFdtexOm5fIH2xRSOyt3DvBqwCS7SeMLAx6PDALonbdWs
	 zQp8VUzNqyvFwVtjoRYPfrvvuqR0f0z+F2pFQlAF6eAI8fOn1q2V3kzAiFLpuOM0id
	 1ZvFtt7fg0KY0G8cDRiJS+cjrU6dFOmuIImIhb0VIpa84OHv7HMsGzrN0N6TwWIqgA
	 6mfJjdSNyAGJKw1iL1Uo0mneD7aLcPsyG223loeXmNFn3OSiVyxJWpq1eYjlmevrbn
	 X5LCBaX0g6ailbff339mfaAZJUOsuyzIKJa3dj72bvxwjpyphIAcA+/GOUV6FFBUa1
	 NAh93Eivr1/MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
Date: Sat,  8 Aug 2026 07:12:42 -0400
Message-ID: <20260808111242.94131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072959-jaybird-dweeb-9a94@gregkh>
References: <2026072959-jaybird-dweeb-9a94@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chancel Liu <chancel.liu@nxp.com>

[ Upstream commit d091132889c1378dd0944a72f86eae3e4da1e4fa ]

When the BCLK divider ratio is 1:1, fsl_sai_set_bclk() enables bypass
mode by setting BYP, but never clears the bit. The BYP=1 value remains
in the regcache, and is restored by regcache_sync() on the next runtime
resume.

Since BYP=1 combined with BCD=1 immediately outputs the ungated MCLK
as BCLK without waiting for BCE/TE/RE to be enabled, the clock is
driven prematurely before the stream is fully configured, causing
noise on some codecs.

Fix this by clearing BYP and BCI in fsl_sai_hw_free() taking into
account sync mode and the opposite stream's state, so that the regcache
holds BYP=0 before runtime suspend and regcache_sync() on resume will
not restore bypass mode prematurely.

Fixes: a50b7926d015 ("ASoC: fsl_sai: implement 1:1 bclk:mclk ratio support")
Cc: stable@vger.kernel.org
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Link: https://patch.msgid.link/20260710070835.3749817-1-chancel.liu@oss.nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9a5be1d72a907..2f69fdee10a80 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -716,6 +716,8 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int ofs = sai->soc_data->reg_offset;
+	int adir = tx ? RX : TX;
+	int dir  = tx ? TX : RX;
 
 	/* Clear xMR to avoid channel swap with mclk_with_tere enabled case */
 	regmap_write(sai->regmap, FSL_SAI_xMR(tx), 0);
@@ -723,10 +725,29 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
 			   FSL_SAI_CR3_TRCE_MASK, 0);
 
-	if (!sai->is_consumer_mode &&
-			sai->mclk_streams & BIT(substream->stream)) {
-		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
-		sai->mclk_streams &= ~BIT(substream->stream);
+	if (!sai->is_consumer_mode) {
+		bool adir_active = !!(sai->mclk_streams & BIT(!substream->stream));
+		/*
+		 * If opposite stream provides clocks for synchronous mode and
+		 * it is inactive, Clear BYP and BCI
+		 */
+		if (fsl_sai_dir_is_synced(sai, adir) && !adir_active)
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(!tx, ofs),
+					   FSL_SAI_CR2_BCI | FSL_SAI_CR2_BYP, 0);
+		/*
+		 * Clear BYP and BCI of current stream if either of:
+		 * 1. current stream doesn't provide clocks for synchronous mode
+		 * 2. current stream provides clocks for synchronous mode but no
+		 *    more stream is active.
+		 */
+		if (!fsl_sai_dir_is_synced(sai, dir) || !adir_active)
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
+					   FSL_SAI_CR2_BCI | FSL_SAI_CR2_BYP, 0);
+
+		if (sai->mclk_streams & BIT(substream->stream)) {
+			clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
+			sai->mclk_streams &= ~BIT(substream->stream);
+		}
 	}
 
 	return 0;
-- 
2.53.0

