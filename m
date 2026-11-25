Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604516;
	b=IMvjWwyuNsgSHnIJ8s82kFOCfPkglHcaAgmq2pF/+MwIeDGJ+A+WVdRozzbvTDxV26BQ
	 uM52RnL1TtnNWZ1TcmxloSyQhj83MSMi5dkmh0TnFL7hTjFY6sQUAzNv0fwFgPQVOXeGf
	 o69Q6Y/c3S8i6Elr1wXXZXIe/sjxJMMuq5lttc0gySBL7+Vnnp/coMvLYhea54Ldv1D1v
	 AlBq9tGucw4JZq+4gBsaDHROJcCkOIuBDQK3hw1UpqNwm6hwvoXdb+8g+6kYVAlDcUuvS
	 sCFUM9CLx+i9TW2jepngJ5MRTJLYOS6tU6JmSupagmzhlb69NNEHZiPJ7sI7jtnnkhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604516;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Yk+njX7V6RJGgP9XfgRvAms2BGE7/SBj8/cDzF81vYM=;
	b=giza7tHLb4DcisdMXNJCl9U2ri7hIRLtkfhChLqkzoEzClchooSGDE7XkNqaH7oPeM/f
	 n2bYb3XeAzBGGxN5GEKVYPcqt9wQ6lXAEkRi6TSF3Dx24KGFC4gAh2KHkT0IfWkDVjtho
	 FimvCvxaDQf1935iHGhma5m7ttjo9QmCy1mv4Vuay/TOEKGq5OHrVOCpudRd+IlXbZl8x
	 ActkXsQpd+B29w9dotg6ypkDttSqUNONVCFE4tZ3/3uBDLltGopVXrdsbuer3GfQ+CoWw
	 DkfSY4r19KHrOuY8OOcU2cOSlZ797QZECHbbuFRzOBu0UmKn/y7NItcvXeUj4iHaHZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zWaCDQ99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AA606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zWaCDQ99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61F11F000C6;
	Wed, 25 Nov 2026 11:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604516;
	bh=Yk+njX7V6RJGgP9XfgRvAms2BGE7/SBj8/cDzF81vYM=;
	h=Subject:To:Cc:From:Date;
	b=zWaCDQ99STjPkrZ8VxR7OVH84ruFl7TXPax/n3r1PQcXA+VNO2GCtYjuXye/kHm/Z
	 4QQm63vq21mFNZvohU/4dC0Sw1OvCug3U9HWBzLLeASrjCRNyL0hssRlAExdDWS6m+
	 Pxsu/Awi0W7uVj5ClXNdXRBkknlU2P/m5XElS//I=
Subject: FAILED: patch "[PATCH] gpio: keep the chip reference when deferred setup fails" failed to apply to 6.12-stable tree
To: vulab@iscas.ac.cn,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:42:07 +0100
Message-ID: <2026112507-repossess-kinsman-0ff2@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7e899fe007d2ffc753e6aa5bc8f2ae0a802b9e07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112507-repossess-kinsman-0ff2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

