Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB24963C2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332961; cv=none; b=ZMJaQM86xnTMm6lIy5sMY0h9dJ511M7KpDsFfR4D+dEFDUdMrMuU+zBxE3JQSetP8Xkvzc0rLOQDTQ9WCTmAj9m00S5PDz8dVI8N7SM+InqS0MqJ4xcc2Zr9siWC+ky85IuHrZ2Hj3qDHMZt6Xa16EeZv0Kfg2XYQKW5Y4aKuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332961; c=relaxed/simple;
	bh=NP9r0H8Gmzr7tg+WFSzrWDv9ZsgC3Kbus/9Fabrhdds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=swloGwESQzCzRfvgCBWSnp+Dd0X53f2Z8cnnvAyvMbuF69zMGIyNl4SbISWie3XwWfvPJZM2EuFv0mim8gw48NO8ybrtF3LxxNaNTuLuLNX9u3raBFH842f6/H8vKNJWBzwlUySEPi0UcBvwn/+qUhEbW7pFdYRLp5rg6/rgtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sXkhkJWL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sXkhkJWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6CC1F000E9;
	Wed, 29 Jul 2026 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332952;
	bh=C+gwwKwP+pbSCASStqmGVZdrfVdly+6Z9iiKrNdvCf8=;
	h=Subject:To:Cc:From:Date;
	b=sXkhkJWLv/Kw+DeGuCB7hgjKyt6l3AY/qinOVPjHJVdNjjZe1Ile5etML1AnMsSzh
	 rf9IIb1VgJwccQxDdgJIoOf2I3C/Ezuwu1hfumb1kVINuxyXjebXU6ehsAPDJzUgbJ
	 F96oWD+mPa4VR0z80fu0nSlFLVqVBQVC+3Ec5VlI=
Subject: FAILED: patch "[PATCH] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP" failed to apply to 6.6-stable tree
To: chancel.liu@nxp.com,broonie@kernel.org,shengjiu.wang@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:48:59 +0200
Message-ID: <2026072959-timid-mortify-1131@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d091132889c1378dd0944a72f86eae3e4da1e4fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072959-timid-mortify-1131@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d091132889c1378dd0944a72f86eae3e4da1e4fa Mon Sep 17 00:00:00 2001
From: Chancel Liu <chancel.liu@nxp.com>
Date: Fri, 10 Jul 2026 16:08:35 +0900
Subject: [PATCH] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP

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

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9661602b53c5..d232c8f53061 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -808,6 +808,8 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int ofs = sai->soc_data->reg_offset;
+	int adir = tx ? RX : TX;
+	int dir  = tx ? TX : RX;
 
 	/* Clear xMR to avoid channel swap with mclk_with_tere enabled case */
 	regmap_write(sai->regmap, FSL_SAI_xMR(tx), 0);
@@ -815,10 +817,29 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
 			   FSL_SAI_CR3_TRCE_MASK, 0);
 
-	if (!sai->is_consumer_mode[tx] &&
-	    sai->mclk_streams & BIT(substream->stream)) {
-		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
-		sai->mclk_streams &= ~BIT(substream->stream);
+	if (!sai->is_consumer_mode[tx]) {
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

