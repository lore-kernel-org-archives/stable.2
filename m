Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420423;
	b=3u3JnnMeyzXq6J0uK0iKmjFOXrCCCKib93x1a56uVh0+jkbU3Jr8pa1D/9kGM9bsvp8E
	 0CLPbTvCWxSiXc4ln7rcMN48CXv34KtbxfRXdTTmq9wvWzDME0DOlxLkiqMWzu1UsBxxg
	 oMuHKeV5pZzvDZO/VALUI2G2jKjyvlMaBSw3N4YJagDRFOo0eANshbMPtrncsNu3bltVx
	 7Zj8G7aD6cfDeObjQrAqOsbp6uQ2T5s1filLT4UM7ePdcdat00R+YQ7TOrN9oAdTlmNT5
	 8/RxH1gUCmGcgvyxMEydjE3/hYPy5MBc7L68gygUkMzhVWjKav3i5DhNjqaD3BVEeCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GVv08OIoxkHUOqh5dxS1INjcKu3ezZkS2L1WZ71xYs4=;
	b=IZDLYpV9tR5qUgukTSO0ppDImhuIKiOYFsoQuLZPWHp7op4FwM6+4lgHrjd/JMuM66Sp
	 mCSYf71uN1CIav8F3Y7Ot6cFPg4x3yO2EOnZlcuAVk/RPktfnAm8wghoges1k6LWLuN8x
	 1BsYxAot5uumxMaI8VfuN49vu6LP2OwPd5Cqq6IwTjqHcoS95CAsYrIrdlUHvVUbQjvy3
	 WrpuPiMPjk/s0qjIsj4xnC/wxYxNapqdJmqGXaZBs3XBH2peKuWV5Q/rcVcVr9BvEvtlB
	 ayDJXqtdxtoAQMuRZUm22tg4ve3IQJcGsPy0Zrc0tuRufbwEZXaQqM0m6qYiFSVQ8eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqKKJDxQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A76606A31A;
	Mon, 23 Nov 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqKKJDxQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886E31F000C6;
	Mon, 23 Nov 2026 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420422;
	bh=GVv08OIoxkHUOqh5dxS1INjcKu3ezZkS2L1WZ71xYs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqKKJDxQ/1w7p0ITSWdWVzt/ZO37JVsDTuC9DALpweTCVas6Lt/vNtNB8jqXRPps1
	 4WXQpAoQOSIVGfKg1IDj+Ueqqg92VIRrq09kwJCtuExfhhKEJP0QNL0XMqNXMxKhAv
	 Eeb/BBVny9xkGQdjexJPixOy78kiPHy/QggnJ/WAWSmJoaG959CXCuOIYxu3Bvd/oV
	 kvZnV3L3/8D+0LjRrajF+n7l/QV12x4PqaJmpYH2Sg+Qdad4JItv2zXuZ8nDCVCRUH
	 AbdfB5x0cf4k8znK67XHZ+HImUbms3zr582QQh+Sjl7NA2rFADfVlVXcMSRQE7TRiV
	 IU5sO29Tgql1w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Xiubo Li <Li.Xiubo@freescale.com>,
	"shenwei.wang@nxp.com" <shenwei.wang@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/5] pwm: fsl-ftm: Enable ipg_clk around regcache_sync() during resume
Date: Mon, 23 Nov 2026 07:52:52 +0000
Message-ID: <20261123075320.379664-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123075320.379664-1-lee@kernel.org>
References: <20261123075320.379664-1-lee@kernel.org>
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

On SoCs with a dedicated IP interface clock (ipg_clk), register accesses
require ipg_clk to be enabled in addition to the ftm_sys clock managed
by regmap_mmio.  In fsl_pwm_resume(), ipg_clk is only enabled inside the
channel loop for channels with PWMF_REQUESTED set, so if no channels are
currently requested, regcache_sync() writes to the hardware registers
while ipg_clk is disabled.

Enable ipg_clk around regcache_sync() in fsl_pwm_resume(), matching
fsl_pwm_init().

Fixes: 82a9c55a2bb0 ("pwm: fsl-ftm: Added a dedicated IP interface clock")
Closes: https://sashiko.dev/#/bug/linux-858851cf-55a9-4776-883c-69c05f3961f2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Move clk_prepare_enable(fpc->ipg_clk) after the channel loop and add
   an explanatory comment (Uwe)

 drivers/pwm/pwm-fsl-ftm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 35406b2e1925..a73cea34dd82 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -501,6 +501,7 @@ static int fsl_pwm_resume(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
+	int ret;
 	int i;
 
 	for (i = 0; i < chip->npwm; i++) {
@@ -518,10 +519,21 @@ static int fsl_pwm_resume(struct device *dev)
 		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
 	}
 
+	/*
+	 * regmap_mmio only manages ftm_sys, whereas register accesses on SoCs
+	 * with a dedicated IP interface clock also require ipg_clk.  Enable
+	 * ipg_clk around regcache_sync() in case no channels are requested.
+	 */
+	ret = clk_prepare_enable(fpc->ipg_clk);
+	if (ret)
+		return ret;
+
 	/* restore all registers from cache */
 	regcache_cache_only(fpc->regmap, false);
 	regcache_sync(fpc->regmap);
 
+	clk_disable_unprepare(fpc->ipg_clk);
+
 	return 0;
 }
 #endif
-- 
2.56.1.750.gf70dc682cf-goog

