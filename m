Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604519;
	b=VHIafV509IOCMkx2NW+3/u6pCCQ2ABvbY5/d2QbKoht29IsR8NBvc7RX464dmjZO5t2g
	 khl51cIBm2+gE/B282MniaoJ00pGLOaUkU0xBL1k8YGc8Y475TT7aq/u0L60dGG5QOhoO
	 pR987CTTUyKH4mZr+iEyLnJy2dZv8NrQhuh72wYOKlVxGadnO0higU3zujS9+Zd64u8xK
	 T87RTc04Kb5dNPgfznYyFyVZjQOU7X2rc5I8c8vpxw39UC/vBxd0e3nghdfzdjQhQQ0Wq
	 pZWdiKRCXkFj7JtkN8wVm5k9hKOFuPizhhGI9Hx7iNMttHvMjGSWo024bVdAcMb4bTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604519;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b+uH6FkIR+6lNH5tJ+i10yyvRWiIULkfY+mflcGaBMY=;
	b=X9ed+zqiFo9JzG59osdFxsmU4Bcb0ca4u14cSuSThakorQbCR/qvVLiUEu9LZNKJGwG7
	 g4D8NR05dBIgRpNDKIpJFlFmOnIQ/BAPn5kArSMDQdX1P+etTya1C8Q4LtBFEEA8SPlqD
	 trYmxV8pyjjb4cUF9Oza6GGe4yNcKkclzM+w/4+iQdx2Zoko6LLoJicYhLy6wNfLs7sup
	 3ZVvw1QYMTB8UMUlVKC6P5BtTNHVm926qF71zzle9drFOWr4xiMgkYu09KMli49sEkax4
	 JT+Meq3YNAPJk2Dr+IR3jcoaZrhkkXS+r+y9ZzvN6ezCfo4vKK+yTWXTXL6N1sSZyxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dlWGFw1P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A4606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dlWGFw1P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA941F000C6;
	Wed, 25 Nov 2026 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604519;
	bh=b+uH6FkIR+6lNH5tJ+i10yyvRWiIULkfY+mflcGaBMY=;
	h=Subject:To:Cc:From:Date;
	b=dlWGFw1PLLMjVQNAEopqbW0nyUvbsS2Grd0NMwkf1kqwyNKZ1VsJuzNewK95S9wHT
	 WnAwzINRw9LZqfdtEiPkLWanpTWxPavlVIVt9azpdaZQ2ymnrtnVgxpd78WKvPxSs5
	 1fFJL+3z1wSDd/AlrgA13GrL5BJXN7N5b2ZWrGVc=
Subject: FAILED: patch "[PATCH] gpio: keep the chip reference when deferred setup fails" failed to apply to 6.18-stable tree
To: vulab@iscas.ac.cn,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:42:07 +0100
Message-ID: <2026112507-smasher-paralysis-af0a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7e899fe007d2ffc753e6aa5bc8f2ae0a802b9e07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112507-smasher-paralysis-af0a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e899fe007d2ffc753e6aa5bc8f2ae0a802b9e07 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 4 Nov 2026 02:53:45 +0000
Subject: [PATCH] gpio: keep the chip reference when deferred setup fails

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

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index db613770dcf5..5c489f4e5e83 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -924,7 +924,8 @@ static const struct device_type gpio_dev_type = {
 
 /*
  * An initial reference count has been held in gpiochip_add_data_with_key().
- * The caller should drop the reference via gpio_device_put() on errors.
+ * A caller that tears the chip down on errors must drop the reference via
+ * gpio_device_put().
  */
 static int gpiochip_setup_dev(struct gpio_chip *gc)
 {
@@ -1100,12 +1101,16 @@ static void gpiochip_setup_devs(void)
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
 

