Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256C4C6D
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157540; cv=none; b=VLYs66q4jRfSCHLTULWpc9ztDL34B5CF5oifq4j2B6dx01z2cNq3Pxu6HCVstcLIMhE+v/do/+MRNIkerhfWNdHG+3ZIAW0mZBydr++tXBST0QEfx4srNRCPbonSjwKyAxq5VXc7yMPd1GWkTY2MxfphkCeeKlHmjqsbp1cjnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157540; c=relaxed/simple;
	bh=OSH7nP2LzsGFf+5AbCRkFzS2w+u+G+7I9Of5MPCzL04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cqgl+s2b9GicuZzQM9QSrrumKMXLneIkebIEKxEPFAz+0FuoZLE7n8gyMcLJXDpjvirjUKQt/9ROAhKer21vODE1/Ulq31Esi2v0ZnX5GYIpxm6w5x7u7p5pvOCg0ToSmoIuQUVIoSK6A9lGa17/zw0R76oORWDpoeehhhEot6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4RkWXMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4RkWXMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E201F000E9;
	Sat,  8 Aug 2026 02:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786157538;
	bh=VMponFb58GzrWVHKtWdwHyBOzEDy/9sU+VcgNlGyt40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4RkWXMrE77ONbBOo3E1eTC1gqxYf0bahJTsVuB7x/3UqaoYc2i6Qus3obSofu0Nj
	 6xLmsdStE6pgluFElrmY8vLOCrwebxsbixhKZAllGTpTEf3XZTxgcPzfp/eB7gPprB
	 7QTu0lR7J6Y9UdNNsOF/NTk0Puz6NFwJzj/8tltjuDkO/2p0fMXnESrRxhalTO/aTM
	 ZUaPJvmCPgoxwYW28x80r4gwxKbjaeH8zgP5dpm4LaS/9OoAzMpBKEwP46oanXKIMx
	 uxwEyZ056sZcW+n4xprNfOmIKV4YNy2+sarTuTe1qisdX/g64Rn6ahDiqzR9G1EX/O
	 1DOfoBvk91ABQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
Date: Fri,  7 Aug 2026 22:52:16 -0400
Message-ID: <20260808025216.4027230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072959-timid-mortify-1131@gregkh>
References: <2026072959-timid-mortify-1131@gregkh>
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
index 5a43658111b60..61cc57b8467fe 100644
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

