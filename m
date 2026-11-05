Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889584;
	b=k7yTduNeDGNwFMjASSLztqe28UEA+9CPP96ASDJ77LDAAmL8ZFkkdCHpPH1fBExKtzDN
	 gu1AidSz8tkQdjGBMfIPBlel0DFRE2GrLbx62q427syrHnlaNTqR6FPGnprcPVqkLM6Vm
	 ONJJWvWlu+QVcf0TVwyhLJRfW56yfmmL0nLeSJLj5/FsDzVwsT3vN7MlIwO0UPiJQUWY+
	 O4iBUrFNxcDHG/A1IIRUtBjnkiwqHZBtMmBqbKQ33y9WwrrYzeUImQe22ga+ZqmsDralA
	 2+qnWAyLV58C3UtbSigBYpCy3+VG2VbcTRVAkUcIdHycc5Rjo/+Cthz4Q1vVwDFYKlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4ImYa1Cx8iIyrfcez67nPjEMG5VmhaevmSMkpwz0IJI=;
	b=GwSAvnVCmjV0nCMZK2WoaX5p7/RsKCInPtfMCVIyOmMITxkax6VH7+onLQTPc31Utp21
	 FkYQsnp4i05OoGZd/WYtXpGANDljjvYqJ+qmj5HBkqoDKoFGhOBZtT275Dax8dV4pfBa4
	 oXMdrdzugV7R5tfxSxehh/yLTQvUnxlyKBzS367SCGOTC9CZxVuoOQnu+Cug3WYQrBqvF
	 tqQBb7pfRzRhyqH/TaYKg3SeiCqs9JMr2a7rJ3+m3h/7C4Ks7YMZVf0Xq973f1wmaKxrP
	 QwtbRzwApu0RheSfmAMOoWhH9sAFljwINRsaOYSbeinwHG1mH3NVePvY6KXf2Z0jq6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKdLZM3A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED8606A32F;
	Thu,  5 Nov 2026 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKdLZM3A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A43C1F0093A;
	Thu,  5 Nov 2026 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889583;
	bh=4ImYa1Cx8iIyrfcez67nPjEMG5VmhaevmSMkpwz0IJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKdLZM3ACaM7xtcygy551j4vYZv5lQ4BhA5z8v5yzz67vt/tOq+bvqcDW7cEEafSd
	 RthYmtptxIgKX2Cvb13G3bvGqGY5twV1S1XzxZ9+8yA9olfsloHESsVVDjbWZsetaX
	 em1bRVQi1uzFJw0jQJznb70EbB0G3S+RbRAx+Kgry7Uqtn4R4TEIlQr9tBkOZTu/Oc
	 MZAHqmSf6blEGI+iT52Dl5pVgJb6S/dBPPU+LB0hmPuu/NinWowB9sZzhkrwcqSiWe
	 9YZOiAV3hviad/LtxjEqVXFKfFQg04Izf9dk64rTqySU8G7dmMZZHzeALmV3K4Ykv3
	 sFsqOCnSVks6w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	"Philip, Avinash" <avinashphilip@ti.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 7/8] pwm: tiehrpwm: Enable runtime PM before registering PWM chip
Date: Thu,  5 Nov 2026 14:38:09 +0000
Message-ID: <20261105143847.2559586-8-lee@kernel.org>
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

ehrpwm_pwm_probe() calls pwmchip_add() before setting driver data and
enabling runtime PM.  Because pwmchip_add() immediately exposes the PWM
channels to consumers, a consumer can invoke ehrpwm_pwm_apply() before
pm_runtime_enable() runs, causing registers to be accessed while the
device remains runtime-suspended.

Set driver data and enable runtime PM before calling pwmchip_add(), and
disable runtime PM on the error path.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Closes: https://sashiko.dev/#/bug/linux-28b36a80-e4a9-4bb6-97bc-7ca02895570a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-tiehrpwm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index e3407d0a1f7f..f9dd3b91c73a 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -461,18 +461,19 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = pwmchip_add(chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto err_clk_unprepare;
-	}
-
 	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		goto err_pm_disable;
+	}
+
 	return 0;
 
-err_clk_unprepare:
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(pc->tbclk);
 
 	return ret;
Cc: "Philip, Avinash" <avinashphilip@ti.com>
-- 
2.56.0.398.g882cbad275-goog

