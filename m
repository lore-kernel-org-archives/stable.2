Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791153;
	b=c5XrFSysA6lk2N7bIgf3xknOk4Qdp8JQqgUDqN0T8sL31sbWy8DCjsIOc/FRu6a/DulP
	 zxJZF318ZSCGWHnO9CsI5qxHLmNsSOe+XGVsF4Lhi459nXAq89ubWS2ShoqqJ/RSW055p
	 V7CKoVjzV+07m3apnCDHK7rUzSfigt002TyQvhie33pEpnrjUGbcrpZm7r/eBDzHM1PVI
	 shugHK0xailW7z+5ZXz7kJKfdctT/p0OYKvHyp5lqSZ/Ot/g39I3mLkC5P7/YwSQW06MX
	 QN+UaTDjmyyOqVOItZBznpXnj9oo113QViMKToJ+fQ4gRLoj5jZMDOVvkkQfaNqIukA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TI+JLkq35PD/7jmEqoWqvfXhE2Ug1oyIciBP2hglf3I=;
	b=ziyefp5wWw3mIgRmVB16fY0K7HJr3W2EspAmVbOb641h+RjWQhZCZiy+iMmDc8hL8i5u
	 e62wzrMHQ0CddVT5c6VqQPujYYxGCHMmCjC28lEP41AVmlDjX/DTFjZg3fkSuOQN38h/Q
	 NYvyWDAXva8TwgdtJR6bV8RVns9GQUbUbN1+U2cRefsXgMdi/0SczU8RyfQu4LC3rjMHP
	 KGdnAX05iocBvU/BRP1qtjW5y5WxRoQgk4y3Ecewa6KD4FZ663nRnGlLaXsMG1SDetZ7u
	 FaK8JLg+ykf5tWD5cUSSzQRGxPnhhqRVznfk9w8ZY4hWkmCn3O1uga9dQYh47qV+0Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IELTKO+K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B7606A31E;
	Fri, 27 Nov 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IELTKO+K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5821F0089B;
	Fri, 27 Nov 2026 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791153;
	bh=TI+JLkq35PD/7jmEqoWqvfXhE2Ug1oyIciBP2hglf3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IELTKO+KhBDgZw83AHHGNyEvCPJ5W+mSxiEtQ0AE7IWHeQje/3sptqGrtItjJVKjB
	 6HVTL+0zoRLvCmHB7lGRCJDpdYQ8KpfarakL7VWVpMy3LThyTci/JsEMRjJ7sNxofr
	 zLW1Gfr9saiwlQ+R69Wq0+p/M5GKg39BRuh2CqbjVF7peu4f9Obss3p1uicUQtcmm8
	 7MDeACAn/R7cRlPDf1w2mwWbGAHPxtKeSYqySas4sAeP3JqjhtOhbSq5kBXC1b6UTx
	 ZyhfXseA7QttGmP69zopTPkIs8ePkEDoWNFm6pNetRl7qqUZuie5PrCRlKdOK9OoWP
	 ROAgB7FPoCSWw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Uli Luckas <u.luckas@road.de>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 3/3] Input: matrix_keypad - only stop and start active device across sleep
Date: Fri, 27 Nov 2026 14:51:56 +0000
Message-ID: <20261127145209.2884170-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127145209.2884170-1-lee@kernel.org>
References: <20261127145209.2884170-1-lee@kernel.org>
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

matrix_keypad_suspend() and matrix_keypad_resume() unconditionally call
matrix_keypad_stop() and matrix_keypad_start() without holding
input_dev->mutex or checking whether the input device is active.

When the keypad has no open users (or is inhibited), row interrupts are
already disabled and keypad->stopped is true.  Suspending calls
disable_row_irqs() a second time, unbalancing the IRQ disable depth, and
resuming clears keypad->stopped and schedules keypad->work.  If the
device is subsequently unbound while still unopened, Input core skips
the close callback (matrix_keypad_stop()) during unregistration, leaving
keypad->work pending or running after devres frees struct matrix_keypad.

Acquire input_dev->mutex in both sleep callbacks and only stop or start
scanning when input_device_enabled() is true.

Fixes: bab7614d6d1b ("Input: add support for generic GPIO-based matrix keypad")
Closes: https://sashiko.dev/#/bug/linux-340f2a74-becb-415d-b1c2-6da8f05a8bd8
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Update the Fixes tag to commit bab7614d6d1b ("Input: add support for generic GPIO-based matrix keypad").

 drivers/input/keyboard/matrix_keypad.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 21c7df4e2e7b..370c08e6e264 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -268,7 +268,10 @@ static int matrix_keypad_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 
-	matrix_keypad_stop(keypad->input_dev);
+	guard(mutex)(&keypad->input_dev->mutex);
+
+	if (input_device_enabled(keypad->input_dev))
+		matrix_keypad_stop(keypad->input_dev);
 
 	if (device_may_wakeup(&pdev->dev))
 		matrix_keypad_enable_wakeup(keypad);
@@ -281,10 +284,13 @@ static int matrix_keypad_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 
+	guard(mutex)(&keypad->input_dev->mutex);
+
 	if (device_may_wakeup(&pdev->dev))
 		matrix_keypad_disable_wakeup(keypad);
 
-	matrix_keypad_start(keypad->input_dev);
+	if (input_device_enabled(keypad->input_dev))
+		matrix_keypad_start(keypad->input_dev);
 
 	return 0;
 }
-- 
2.56.1.839.g22a8290db9-goog

