Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420445;
	b=ibgZElarEfGF2BRWCxRrxOx1fSnS6RKzNj/VCYt7kDzXkIBTQzEqPaJnYtIYmuQbcGzs
	 z+iV+DLdD7HgudB8D2M2MmfFfgk3pv5SnaFyhzRgrg1GGN2GkS5Kcl3afihMcBvecp29y
	 hhmH+g/yIx5Y2CMmMJJF3u84iSURdUgmJAwyAE14LsQ85nMlHDnTL8FtyBbHq703Bs/E3
	 4YNoBzN00aS1uulRgsyGtreRTlBXu3o7xfuBGFfxc5Dgh6N5U71jGu8gZQwDzkunt1Agn
	 LSY1YmKjmVxW+xiGBQ/yfHhbZ6HFFBG0Nz0RCP2T7klHtQZyH4L4WUtocCvLIu9796g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420445;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GIMtN/V4X8FovWXLH2Jxatj9BkNalymkGlz/XfQQXtg=;
	b=i+8f+3pQ9IMC1mi/1/G+mc1B3iIV8RDmwigldSqMzfiz0EQ+kXOZC7aJCiu4cDuMMiRZ
	 462rIQnwRpTMnnZRyHvqU3IdpeBvK5SW1lZRLYTIC8udy+ObYmkPmCdaZl5dFtyzgjbsI
	 Kbl5qRIQHGtzaEu+5Y/PYlcHLN1L78OjDHfXhtVFxu4+lxauOj5x0y3cZTgDnZwrkKkXe
	 nzxXZbg5cWt9qgGL0262Ueu0SABaVSUNlqiS9XSgc80dIojR2f0EJOzXeqtuuwozCHXZB
	 imQB10/knWHgy0IIwKtDx4BK9NOv9a9gsxpPG1L+K5H6a+bmVr9umWusE4bvw0fauWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0pn8mk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CD606A31F;
	Mon, 23 Nov 2026 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0pn8mk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19841F000C0;
	Mon, 23 Nov 2026 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420444;
	bh=GIMtN/V4X8FovWXLH2Jxatj9BkNalymkGlz/XfQQXtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b0pn8mk0uFIc/q3Id1+UdA2qRScX3yDUd+unk7T9M6P/joLxqIJQksIWEXPbg/3Br
	 nmh8xdAh3XtFvK1iHkuK9FtguCaNu6yQf4O6JT3YYEon4w4TtMlOZwBxJ5YJPoQex0
	 6qq63jC/iI8ztjwM57hmcPN9yTKgECuqvetmq/RI1sf7gKUDzjBExLjy40jfvlPsZN
	 2niTifrxti9NielTUpRX95wh6pl2sWbMnPCUPJ/pSYyIiDQf+2ENk9PX/iyWB7b9OA
	 LRwgFcSZ55Tk2qubRpQQwO3xBbBunEn0fBnF7QKFAYG6UYi7gKHwOR2C8/pqoWkc1o
	 y2Gve1LaRDQNg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sai Masarapu <Sai.Masarapu@imgtec.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 5/5] pwm: img: Unregister PWM chip before disabling runtime PM and clocks
Date: Mon, 23 Nov 2026 07:52:55 +0000
Message-ID: <20261123075320.379664-6-lee@kernel.org>
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

img_pwm_remove() disables runtime PM and gates the peripheral clocks via
img_pwm_runtime_suspend() before calling pwmchip_remove().  While the
PWM chip is still registered, a consumer can call img_pwm_apply(), where
pm_runtime_resume_and_get() fails with -EACCES or img_pwm_disable()
writes to unclocked registers after img_pwm_runtime_suspend() has gated
the clocks.

Call pwmchip_remove() before disabling runtime PM, clearing autosuspend,
and suspending the device.  Because chip and its private data are
allocated with devm_pwmchip_alloc(), driver data remains valid for any
pending runtime PM callbacks invoked during pm_runtime_disable() and
img_pwm_runtime_suspend() until devres teardown runs after
img_pwm_remove() returns.

Fixes: 277bb6a29e00 ("pwm: Imagination Technologies PWM DAC driver")
Closes: https://sashiko.dev/#/bug/linux-b06bab8d-dbf2-4ba2-9f5d-c5e141076abd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Clear autosuspend in img_pwm_remove() and document why driver data
   remains valid for runtime PM callbacks after pwmchip_remove() (Uwe)

 drivers/pwm/pwm-img.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 91e0b19f0c08..7bf086b127c2 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -338,11 +338,12 @@ static void img_pwm_remove(struct platform_device *pdev)
 {
 	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		img_pwm_runtime_suspend(&pdev->dev);
-
 	pwmchip_remove(chip);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		img_pwm_runtime_suspend(&pdev->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.56.1.750.gf70dc682cf-goog

