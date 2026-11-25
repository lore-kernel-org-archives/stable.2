Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639772;
	b=V5ffe5gLbSMPLjEgs6LbUc69qJZA6IrlfIjlUDWZW8PkMgxElVUuGPcCkj4c7SXQPb8J
	 gSMDArFEIbuhDqsYaOQ5U2hD8Z//GgReSelxC72SObXfpVWu/tASa0pBj0YOpGUadgywJ
	 +w1GrkYclXmK59RvzPQx0G8FPQcOd5ZnjX06eoPeoh5X3Pb+X0w2yqZbQQYQX8Nl53KUi
	 UZ/hpCHlXBjta47/YtSxhYMqxWOpayIv0CAn+iGgOn9afW373+fYGbBNoOG4/FJ3k84IR
	 INW4kwfWZUFVOdBEY0tnQsD0m7BBSuXgHeFwC/QIGawVwyGt4ao/FABp8DkJ4slF+9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639772;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1bI+OtpCp2KhlpyB3qgQtS9cqo4c27tTeeEQttU6dcI=;
	b=J11XGviVdc/I2tLzTAs6AkGRt6vXsrEf9WDdCN9hxYDVEtFb+6ekukkPky4wxRejN5UX
	 c8S/YVJxvTbEPvcrhh+0LQ3DKI2Ia4DeQqtWyFJfI/EqaPAMOeE5HzwOvrBN+bc+XNpUq
	 gRH7zNjVC3pFoX7LG8lWgVtfkHD7oezpM0MVCPHcupl/kNAzwwl371Pueh9AFRdMnyjg/
	 JnfclDMZfoazQvBJlcubTZsFVnqC/NOi35aH6EFpF+UzKWTcJpZtA07AjBOL3zErZRHwW
	 8OSSvZQKYoeChfHyMOYDzhU0CI9xrA7qTJdVzYwUboV3FJsiJdfZBrC/TWOBc0twOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uwz+a+gL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uwz+a+gL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038961F000D2;
	Wed, 25 Nov 2026 20:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639771;
	bh=1bI+OtpCp2KhlpyB3qgQtS9cqo4c27tTeeEQttU6dcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uwz+a+gLm8cjDqEgTlh19OvJQimaljKOFd6QbL9sfU4n8LrryKZRa9oOxb2bozaFp
	 C5R54bvDn81+SXYDMDj46MIoh5R4uARlVyh1P9GVRNEAZP57VkaXWcJauuWsdP4ize
	 3KMSw3sfLXoENJyHMeVHuy4TKXLyg6POiTEM0UdY1XYm9YqBv7voO9FC0Px1BmPWk5
	 4GVFBq6MP6xDIRcOWaOlyUBN2opCohCdRHvvQrrkWTGSVqRkZkDRGfnGWakF/2L1rd
	 Gh5iMSWjfqJ1Pd74MoFKSHP6W1X0tcu1Tgc/EH8qJpbXuaC6EM4OpG2N5fkSCGvGMm
	 8NF5AS283bdtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] gpio: keep the chip reference when deferred setup fails
Date: Wed, 25 Nov 2026 15:49:27 -0500
Message-ID: <20261125204921.1452840-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125204921.1452840-1-sashal@kernel.org>
References: <2026112507-smasher-paralysis-af0a@gregkh>
 <20261125204921.1452840-1-sashal@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 7e899fe007d2ffc753e6aa5bc8f2ae0a802b9e07 ]

gpiochip_setup_devs() runs once gpiolib has been initialized and
finishes the registration of the chips that were added before that.
When the registration of such a chip fails, the function drops the
reference taken in gpiochip_add_data_with_key() with
gpio_device_put(), and only then logs the error through &gdev->dev.

For these chips that reference is the last one, so gpiodev_release()
frees gdev: the dev_err() dereferences freed memory, and the chip is
still linked in gpio_devices, so the next lookup walks into the freed
object as well.  Here the registration cannot be undone the way
gpiochip_add_data_with_key() does it, as the driver already got success
from gpiochip_add_data() and will call gpiochip_remove(), which unlinks
the chip and drops the reference.

Keep the reference and only report the failure.

Fixes: 16fdabe143fc ("gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20261104025345.1527526-1-vulab@iscas.ac.cn
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 20c1a0994f395..02d2abc65a119 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -884,7 +884,8 @@ static const struct device_type gpio_dev_type = {
 
 /*
  * An initial reference count has been held in gpiochip_add_data_with_key().
- * The caller should drop the reference via gpio_device_put() on errors.
+ * A caller that tears the chip down on errors must drop the reference via
+ * gpio_device_put().
  */
 static int gpiochip_setup_dev(struct gpio_chip *gc)
 {
@@ -965,12 +966,16 @@ static void gpiochip_setup_devs(void)
 			continue;
 		}
 
+		/*
+		 * The reference taken in gpiochip_add_data_with_key() is
+		 * dropped by gpiochip_remove(): this chip is still registered
+		 * and its driver has not been told about the failure, so the
+		 * reference must be kept here.
+		 */
 		ret = gpiochip_setup_dev(gc);
-		if (ret) {
-			gpio_device_put(gdev);
+		if (ret)
 			dev_err(&gdev->dev,
 				"Failed to initialize gpio device (%d)\n", ret);
-		}
 	}
 }
 
-- 
2.53.0

