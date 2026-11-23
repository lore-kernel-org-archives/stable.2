Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420438;
	b=piqfohJBqJYSmNY5/3KAi1DuI/jbFvOgbNh4owbKZQMO65FMHShlsacPCOEKVPaiYf5G
	 QDgvrKpiPbwOa3GJYMHQTazNlsAdZFWUtyi6MQVNS/OXKlc7erEG3d7Lgx+FTleVeZXtZ
	 vrm7UwWAo7yFlvT54DH9N3WDiaWg5kqFq1kU96fnQhWkNR2PdFbwoxVGNuV7v6IyqMCw+
	 fifu1cdV3SO4Uo4gOXO/QmqTrtYxi14BAyjUxTpeDR0OeelKaevUtkgNAXZjAjrMC9/DV
	 O92B06Koq9ur6jDb/UXrXlnoKK6Z8wEmmQV+Yx/RE7pbYUZ+EPSGANa3UZpXtx+pQXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nRgKwDlM71b06rNQ5/43AOR0ALDiZu7WP2FU65RRKH8=;
	b=qOrq4rwmZHDnPySd4jbAbFF0MT6jjBrs5C4hV7Ds4VhI0Pnry2ir1UJ9RYSD7pgpbOne
	 PwNIB5jH1s5u234mly0Poj4KdxzFCilAZ9p3fAyONAVnV4NZc8EbMk8tN9m1PadVgVQED
	 fe+8rLZILU0xY5cxLyHOUCOg6MGNlaYB8sZPu7P0782y6XigLPqmwmMfwC2pdr6VbiLAr
	 mVJc6JAPjniMy6+ydmZN2nGnEaSR2+7HJwCtcJQ+KFfF+nO/DhjNCv4B1QsPqfgooXage
	 VbLObmw/9Z/H0stWkrWhtPs8hWfjgrIzBdpqgP2En8EnlBp88AKIhEusiewdGbmjoHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/N9+Gwn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13154606A31A;
	Mon, 23 Nov 2026 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/N9+Gwn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D3E1F000C6;
	Mon, 23 Nov 2026 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420437;
	bh=nRgKwDlM71b06rNQ5/43AOR0ALDiZu7WP2FU65RRKH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/N9+GwnNxcNKOoFryRYQfqgWuIJC/am/3AtmtF/L0dfjdg4d8IQW7JkB/B7iCII7
	 n6muFq7YYsvyjo5dPrvIgvRqVS+x2jRLKhUKtumZbOEiwMETi2btmErEWUtxsdazFg
	 PB2RN+Ezzy76L5Yqj+d5VFacfNx2Ri91ZLSahkwdSULp2YUh/YG63UqJUI0EMY036L
	 ieQ6stJ2/oaNO7TfoD0gQio9oc7B/T2K6fAqOvGsnm6hh4UfrZ2Z/+0YPQL+Pdiy80
	 d9rXL3BhPVDoqic7BM5ze51YlwUjbcBayMWwFI8speR3luVRq2VhEKR1U3m35Qr2gi
	 9ZgwqKyrxPdUg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Gokul Praveen <g-praveen@ti.com>,
	"Philip, Avinash" <avinashphilip@ti.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 4/5] pwm: tiehrpwm: Enable runtime PM before registering PWM chip
Date: Mon, 23 Nov 2026 07:52:54 +0000
Message-ID: <20261123075320.379664-5-lee@kernel.org>
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

ehrpwm_pwm_probe() calls pwmchip_add() before setting driver data and
enabling runtime PM.  Because pwmchip_add() immediately exposes the PWM
channels to consumers while runtime PM is still disabled on the
initially RPM_SUSPENDED device, a consumer invoking ehrpwm_pwm_apply()
before pm_runtime_enable() runs causes guard(pm_runtime_active) to fail
with -EACCES without resuming the device and accesses unclocked MMIO
registers.

Set driver data and enable runtime PM before calling pwmchip_add(),
disable runtime PM on the error path, and disable runtime PM before
unpreparing tbclk in ehrpwm_pwm_remove() to match.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Closes: https://sashiko.dev/#/bug/linux-28b36a80-e4a9-4bb6-97bc-7ca02895570a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Clarify runtime PM state prior to pm_runtime_enable() in the commit
   description (Uwe)
 - Disable runtime PM before unpreparing tbclk in ehrpwm_pwm_remove() to
   match probe ordering (Uwe)

 drivers/pwm/pwm-tiehrpwm.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index e3407d0a1f7f..73fe2f91243d 100644
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
@@ -485,9 +486,9 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
 
 	pwmchip_remove(chip);
 
-	clk_unprepare(pc->tbclk);
-
 	pm_runtime_disable(&pdev->dev);
+
+	clk_unprepare(pc->tbclk);
 }
 
 static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
-- 
2.56.1.750.gf70dc682cf-goog

