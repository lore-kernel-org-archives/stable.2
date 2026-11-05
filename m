Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889571;
	b=SgKGO2+Q3WMecuyfFtZW4CgKSlH8VfVGmr8p4xFp4WXmQFVmnP2D243hSXuMh7b79tRu
	 qBrohpG3QqW1otr9Lwsg3sSsm5c/o3VZgpUfgZBc6cjULjy3f9Gwyx2BVRup5PeD0W7DS
	 tUGXc7QZGXo09R6urr32gNkXnvV+lmifCBW7i7sy7N/kJj9DBrZ20hQGFDbRP70Ji3jPb
	 CeTWdJZd8Xs3BF884xIqk8JoomMu6UUqX8lVaBVFgJElvVTz43tnTXDlyQwiODb2juIrh
	 Ptsjl/n1SfzR1KEtlel9YjtVlj0lGblXKVVcbrw5SLLWlkBageP4JxWkMVvvwg1uQdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889571;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PSyN1YHPWqlEh6KBlb3S3Qwl9gNrCashcBnZD9ISPHc=;
	b=ki/xFpw/oaGF3u7GpyOKEaUZBhvqrkZU+Hf6kltHIOakcQcZMCedP8T/jF05XaKGFfgX
	 g3tXBK3HlSVKdXq0yU7Es5lheFQRO+aXYz8FSxzW/DU6cewlVornQSilplnwmqx2uyYrJ
	 EvT5kP3oP1sin0ZD0fF2BbPF/M2fWIWDAufZ+CidObFKW+RXu71wm2WhqRWNMKMiSGuDe
	 eKy9NzJtkPnOpYx3KslVybyA11BNLRolcCloqUDAp+Ia1mxqH9tUCcw71ElRoA/3ta160
	 hqGRaxCNPSF05gFqdJ5ckUFO2cG/GbIPFZRTikM5uLPs/WAWCSeHHeE/NCQOjnKDyeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSmzGqIK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586B606A33C;
	Thu,  5 Nov 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSmzGqIK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C61F000C1;
	Thu,  5 Nov 2026 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889570;
	bh=PSyN1YHPWqlEh6KBlb3S3Qwl9gNrCashcBnZD9ISPHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jSmzGqIKPUpLZZpX+iRhptsPPasIPHu0Htw6mu/9YR9pa1keWpXD5iVGK7+QR3xZg
	 oOrGhKnuBWEkdEKmvc06gyubXv6cx6sUW34F6gDFC0KJ63NTwkbySIyokOeeMutAfe
	 M/uRfUg7sfqwgWeGc5by5g5Po3ujzORTbphiVRU57ZohbTtjq5ZDtWkydRJt7NXpXs
	 y2PW0wXCOYLK8m1ltju0sl5aYNvIETsaS3kFjDnA3JAio2Nljg8PdutwN4oeW+8BLG
	 WDoD65VWWV2jkTwpdXp8GIJXZ05o4untu8tIDxRuad5YDZ6AiX72NUTVniookGTMUW
	 +Q0lDX8lXpLBw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Xiubo Li <Li.Xiubo@freescale.com>,
	"shenwei.wang@nxp.com" <shenwei.wang@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5/8] pwm: fsl-ftm: Enable ipg_clk around regcache_sync() during resume
Date: Thu,  5 Nov 2026 14:38:07 +0000
Message-ID: <20261105143847.2559586-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105143847.2559586-1-lee@kernel.org>
References: <20261105143847.2559586-1-lee@kernel.org>
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

Enable ipg_clk across fsl_pwm_resume() around regcache_sync(), matching
fsl_pwm_init().

Fixes: 82a9c55a2bb0 ("pwm: fsl-ftm: Added a dedicated IP interface clock")
Closes: https://sashiko.dev/#/bug/linux-858851cf-55a9-4776-883c-69c05f3961f2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-fsl-ftm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 35406b2e1925..9e5470e2efe6 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -501,8 +501,13 @@ static int fsl_pwm_resume(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
+	int ret;
 	int i;
 
+	ret = clk_prepare_enable(fpc->ipg_clk);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
 
@@ -522,6 +527,8 @@ static int fsl_pwm_resume(struct device *dev)
 	regcache_cache_only(fpc->regmap, false);
 	regcache_sync(fpc->regmap);
 
+	clk_disable_unprepare(fpc->ipg_clk);
+
 	return 0;
 }
 #endif
Cc: shenwei.wang@nxp.com
-- 
2.56.0.398.g882cbad275-goog

