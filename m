Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458755;
	b=E3Qd6hFBJLMV5NM4X12AvGVUvUsOyrsG8v48yOXDso+TRZAv8+74SVHoGBOlM2OfNBd7
	 Yh9OO2nMMujhq3HmLwJvjL/uuJUdEHzuDh71K1KXpeqBA8KFDxwXNYN1+XgAhMf+H0BSb
	 DRvep4W47xc0v0emuLyWosFRMATX0qNilOK5Ta44rolo6MBBIrtljqj+iqf2OZddZR2KR
	 QPHwZn/7zSzXDz8ywMJd4wzO/kO4lW+10aZaKeMFWGgfOq0iyPiFHKmIn73VDc1Itg6CU
	 OfhscE+xouZ9cnGHQlKIMUrLcWqVrXJI+Vb4lYCjl8zfszRX8FcaFXQFPa2hcTevlQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458755;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HvJ80RgiDHHiWONrDSVjrqusDm9p88+K6dsNBXZazvM=;
	b=cwp4zxHfwhaDpBfG6+JMBJHPcfGgYpslbNf9Ms9Os4trsmpRv75YvX4i3XsGQJDiolWf
	 DLpFJC2CQTczC1VOWciFvARFvetHh7/BpPxA+OlOEnxJJWWLcntrMhqw9YGLp2SS8OKfN
	 +OR9V7JIId6wKZPBImlrboOcqBEy6nuhlXtW2GSLCmuCb80GfVtqQKC6CGW5GxDVEYag+
	 f0qFi/UvnSRELgkKNlQoNH4lIVDGXkUwgNkHDMWE1tHDaT1ZRToy7+v9Rosk9maTbnAPO
	 vcTUX6xKRcSNnTjYjohYgrCV1lC7Wx8vq6mCzG4bXV3YVI4CQ7aYHL6KcmIi5hyVjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnPlwgCN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E85606A31A;
	Mon, 23 Nov 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnPlwgCN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253941F000C6;
	Mon, 23 Nov 2026 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458755;
	bh=HvJ80RgiDHHiWONrDSVjrqusDm9p88+K6dsNBXZazvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnPlwgCNnlCPPvDKZU0SgfAT842VHn7NUEof9RII8AZbVTcW1humtg3170nXIhPro
	 6ftzYqsrEeKch24esZJ16cpHuGv4kvZaPt+IFheC6xjW65ToiaYLmFFPTexTf4/jAU
	 CXR6jSqqYn4ycrXiVYr/y5xcwwoQgV8PBAQhfly0qhq3XwkkKMHWdQ4E591r8rPGye
	 6+Za9Vo1/wg5z/j9/a3YzTzE6pRrUNeoS0wlqpjJiWyG+HMNMKwPlifXYu/mACMy7R
	 JKKqXkO7EhTjwkGDewo9E2joSaNm9Oe6aHqIiPEMUlMZK6h8ONlqKRhMUv3aYk/p6m
	 awdJJxF/wcpOQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] Input: matrix_keypad - only stop and start active device across sleep
Date: Mon, 23 Nov 2026 18:31:10 +0000
Message-ID: <20261123183200.3900004-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fixes: 7d0f351da460 ("Input: matrix_keypad - switch to using managed resources")
Closes: https://sashiko.dev/#/bug/linux-340f2a74-becb-415d-b1c2-6da8f05a8bd8
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index c2f839a3de90..81507e2a6126 100644
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
2.56.1.750.gf70dc682cf-goog

