Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889590;
	b=tpVeBacgocumRvGNZ3VuEW7AxNJoGqyqZily0khuRFTfkDM9u43YHgo+gi/MPTxQ078x
	 3FzvkjNqW809UiWMk5dWUGXX2Ga1bdKrW21tNjMGJqpz5X883BV3opW3QiFhneZFisG9j
	 KGyflu6yuuTQleXgruuIioEJPuN1WHGo02hWiE7kgVpwNJxO+kXoiKDMkSOMCR183IVZe
	 Ag8xLCFB03yQyx1StBtxBW+IzQdBPNUvdG6NvGo2TsqClLjW+3NDWY+LJ3oTuzHOgR4k3
	 /Z/RJUoem7t1r5tp8Ped1vu5+IdFwFrRaeu8DjU45ZBG16CXi/2kc6fh13kBJqMFdfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CbJzqumm6dA0wZlbLqKSwsPgM2EoAkbO9d/LUw80/cE=;
	b=Cpw6EQclRRLGZoTYcS4yjjV1ByNThjut64Nvvu+Qw4kO323c9OUCAZYzcSX/vGgrRWN2
	 l1JXL2nSE9+68tU5/mEjtQMt19AbsnSvDd/h9m+aixtqHsKfRjglKL977hJjLrc1N4XVm
	 chv+5lDefBM1Dm0j1u5RLMvwcc4tZVC1dZ0dejWDmJFuraS4s0AcmcKJQlu9ZssuMSMna
	 J5hJmqiKUS8ps/Gw34tlxuwzfzxxXTiVBzlPD+97IHzOLFgPCFtQbSOh0JbF9d0yyA6xA
	 lJ5TBlGeQf4MEsK6AY9igwn1KvqT7s+Z1L3wOdkNc0xuNUlDUOTuetS1jPWrhmie1JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WerkBn1N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA55606A338;
	Thu,  5 Nov 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WerkBn1N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D001F00A02;
	Thu,  5 Nov 2026 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889590;
	bh=CbJzqumm6dA0wZlbLqKSwsPgM2EoAkbO9d/LUw80/cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WerkBn1NOG+3vaHzNbxxlNO21ttoKDRSkI/G/U0MgQ3hil8byrV8zWTVP+uTOuI6l
	 CkIzlHdsOC7VY8VXmoyd51g28q6lthOWDoYzaktw8cbrgW2kcul9LgRBdj12vtT0pU
	 s7MZjI73Pa+rWs+BVxb4PHUUh9/p/0gVRi8gqkfYWZYhZDfMS/5IRd8buTkWnImX0Z
	 QisUp1fJDaok9Vrm0VqCjb+m8r5Qnf93tF26VxTs516kZPzH9qbbcT2YERsM6ULLRT
	 0P97gZTy2lh2vfV3tkfvicJu6JHM5mNA2TA68fOHg4ww/HijnzzjxAj6LErIlyK0Cn
	 N4vBXt2xnWTbA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sai Masarapu <Sai.Masarapu@imgtec.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 8/8] pwm: img: Unregister PWM chip before disabling runtime PM and clocks
Date: Thu,  5 Nov 2026 14:38:10 +0000
Message-ID: <20261105143847.2559586-9-lee@kernel.org>
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

img_pwm_remove() disables runtime PM and gates the peripheral clocks via
img_pwm_runtime_suspend() before calling pwmchip_remove().  While the
PWM chip is still registered, a consumer can call img_pwm_apply(), where
pm_runtime_resume_and_get() returns -EACCES or succeeds without
re-enabling clocks, leading to unclocked register access.

Call pwmchip_remove() before disabling runtime PM and suspending the
device.

Fixes: 277bb6a29e00 ("pwm: Imagination Technologies PWM DAC driver")
Closes: https://sashiko.dev/#/bug/linux-b06bab8d-dbf2-4ba2-9f5d-c5e141076abd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-img.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 91e0b19f0c08..b6e090674c07 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -338,11 +338,11 @@ static void img_pwm_remove(struct platform_device *pdev)
 {
 	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		img_pwm_runtime_suspend(&pdev->dev);
-
 	pwmchip_remove(chip);
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		img_pwm_runtime_suspend(&pdev->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
Cc: Naidu Tellapati <naidu.tellapati@gmail.com>
-- 
2.56.0.398.g882cbad275-goog

