Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FF35B657
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075237; cv=none; b=J7MWe8G+jJRLA2bSHFWLp4XNaQrWaAq3O8tgvcaQsWZKjR8NLE8w8uAKAJcmeIxsrRuNVe3v00JdKaNjkPPo6698+AggNZVaTnEC2kL2SRwBnd8BVuEPTZcj8sXWOOOt6a7dsCCKLX3Mzt9TVcOToFmjVjWSaCantoHu/SVHXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075237; c=relaxed/simple;
	bh=vDRmyVtPtwkJb6HvfqMnry2OGAnn7/gHYaqmU4ddIzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSdx9uht4ipG0q5yG4ksPUNvyot8cgF/wYvkRxgmQmL08/SoxlYjnKCgLFDt8iKiLLlAGMQhoGQcV2UU7KEjg+MTX+1Ns8fSNAPYtPbKHSg+TIlTkEzUtIN3T1UJtNjizq9wgEVDr2bFh+VmJVnLio0E9FcCVa9GIEGhYJcF0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDnKdaz1; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDnKdaz1"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-823e4047037so4086400a34.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075235; x=1792680035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e07kfkNTvAlBHHu9qdyfXNwcc9Lq3i1qFJbdRfc2vow=;
        b=fDnKdaz1XTNL7i0UfiLXZWjHCMTvfmCx/hUCB4lUalw+SEy5iKO9dlYDCHY7FqEmF2
         lJ1slCTYdSb1a/emeFZfgkRl7YJnBhoNd0/j8PYUqcg7J6zp0xcfov0NVRxwsXQRqvGZ
         Qw+Rg9d0tHTcqjV5xqwE1KbYxrbw2mOUpY0bDnD5f34hsKknjoH82qqt1Ud/Zn9VkgSz
         auxgOLznZEMQ2SvFizhZORS2d4Ml8z8zA87aqLpKX0gdp5kyXKJ8rQafzIK4Wg4GnVOk
         fVMByIX8dAXIr5XNDxhmNw5/udLIttBkINHmrjeEA9fVQRV0c3VaY3lh1BUSLQo1LNHw
         LLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075235; x=1792680035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e07kfkNTvAlBHHu9qdyfXNwcc9Lq3i1qFJbdRfc2vow=;
        b=pgrfTDuuN4kTOD1d94e2cllVO2t3o9mttdMRmkj7VjTZYr1wqqwOAOAbmv7yNGRjBK
         JZ5KU8XU3hSFxz/OWR7J+6WcXd0sQlSOV4q4txV8qr0mokbNeay2CDkbZLhOXaUnxhae
         xUIyWD5ByYblKD229m/rYA1/W4G6zg2Z/7JVMimN6mgE0Snuj/a/n+vvMwmf4j2NNhgA
         Aa+M9P6Qy5kH2wMvBgfoGWxiDc+IgvFT1J62sNQk3uKD5Xaey+y4XlkHnw/ZyjXY1lw7
         Qy7+n844pvKHT+CUHfa4zQXXHAAkHbHsJhCplTkUfUwQXrib+llqg7SaC9zf9mQTesM8
         oewg==
X-Forwarded-Encrypted: i=1; AKwUvBwVBgIsU8sZdha7RYWA6bOMbMTPaykdY23jbOIygIEY6zxM5AjYQ1wRpZ8eX/cx/Xu5AP13FSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiL5rsDeo/4/Q7BOGsp6A9n5Lg2EUL0RXjSK5kDn1mcQFz6JUZ
	NNdj0BZa+pHz8hOaYpkeIMW8rHtp/BTwxIqDVSBoNckmhAho+Ai+7uYtY7yAxg==
X-Gm-Gg: AYBFou1OfLT1+xCwzGxr8mY0/qKgPRnAdbZi0Rp1n2EE9cbdajccYiROb/pFCHa1JxP
	dsV8Kik1iwgwr9uJ0L8NvXR60giYXuFqKQzrD8K4e/yYCGar5spGBesVX9Ddxr963a/cOlryka/
	ABtmZcSnRJwuE19ylI9FrZgWDfvYTdSD3qkh9YQrq0TIT4oeXzMMK2ORZcM6we+1mXus/1S8j/E
	ufpRynr+TjKkwOrxujKl8wj7FoJDEfi7CXI2EEaVo+EDky3pvtIDGHkDioqZThIGSq8K4dc+KBa
	PmYQ4AVEzM+ql4Du96ONNSgIM6hgqgIwIb5ri3G7dd9hw2kahP7R6ksQQSUOy8sIdg8Q40s9SZi
	JVG0zcQKcOm3KDdnqqywYmgC4eERP4nGgJr+by6PzmPHnvWP66Ynap8UPqhK0EZun9GR51JSOxP
	Zcmb5fx1cNZb4tNUgn1smdi4nTjLf5F1JdX/DUwBKl355YJ/va27/IbTN/Dq7+R8y+whfWJ6Cn0
	x81PRbt8OnszZjGFYi1+K/AJUXgDN5hGm5s0gNJh3Z9UUQ5zAM=
X-Received: by 2002:a05:6830:270d:b0:80c:d34f:5f63 with SMTP id 46e09a7af769-8309814be28mr18020603a34.28.1792075234818;
        Thu, 15 Oct 2026 07:40:34 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-841734ed777sm613414a34.18.2026.10.15.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:40:34 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] leds: tca6507: Fix use-after-free on unbind
Date: Thu, 15 Oct 2026 09:40:33 -0500
Message-ID: <20261015144033.56519-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the LEDs are registered with devm_led_classdev_register(), they
are unregistered only after tca6507_remove() has cancelled the work.
Unregistering an LED that is on turns it off, which queues the work
again from led_assign(), and the work then runs after devres has freed
the chip:

  BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
  Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
  ...
  Last potentially related work creation:
   ...
   queue_work_on+0xb6/0xc0
   led_assign+0x223/0x340 [leds_tca6507]
   led_classdev_unregister+0x26b/0x340
   release_nodes+0xb3/0x140
   devres_release_group+0x247/0x470
   i2c_device_remove+0xbf/0x1b0

Set up the work with devm_work_autocancel() before the LEDs are
registered, so that devres cancels it after they are gone, and drop
tca6507_remove().

Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
Cc: stable@vger.kernel.org
Acked-by: Andrew Davis <afd@ti.com>
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Changes in v2:
    - Move the new include to the top of the list, where it sorts
      alphabetically (Lee)
    - Drop the comment above devm_work_autocancel() (Lee)
    - Add Andrew's Acked-by
    - Link to v1: https://lore.kernel.org/all/20260926172115.543800-1-danishkhateeb03@gmail.com/
    
    Tested in QEMU on a next-20260925 KASAN kernel, with the driver built as
    a module and a test-only module that adds a fake I2C adapter and a
    software node for a TCA6507 with two LEDs. With the LEDs on, unbinding
    hits the report above (38 reports in 20 unbind/bind cycles), and so does
    unloading the driver in 2 of 3 runs. With this patch there are no
    reports in 20 cycles or 3 unloads, and the LEDs come back after each
    rebind. A W=1 build with GPIOLIB is clean.
    
    v2 was retested the same way on next-20260930: 39 reports in 20 cycles
    without the patch, none with it in 20 cycles or 3 unloads.

 drivers/leds/leds-tca6507.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 9afe2722986c..0f987e551f03 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -71,6 +71,7 @@
  * not recognised when matching.
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/leds.h>
@@ -735,9 +736,11 @@ static int tca6507_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	tca->client = client;
-	INIT_WORK(&tca->work, tca6507_work);
 	spin_lock_init(&tca->lock);
-	i2c_set_clientdata(client, tca);
+
+	err = devm_work_autocancel(dev, &tca->work, tca6507_work);
+	if (err)
+		return err;
 
 	for (i = 0; i < NUM_LEDS; i++) {
 		struct tca6507_led *l = tca->leds + i;
@@ -766,20 +769,12 @@ static int tca6507_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void tca6507_remove(struct i2c_client *client)
-{
-	struct tca6507_chip *tca = i2c_get_clientdata(client);
-
-	cancel_work_sync(&tca->work);
-}
-
 static struct i2c_driver tca6507_driver = {
 	.driver   = {
 		.name    = "leds-tca6507",
 		.of_match_table = of_match_ptr(of_tca6507_leds_match),
 	},
 	.probe    = tca6507_probe,
-	.remove   = tca6507_remove,
 	.id_table = tca6507_id,
 };
 

base-commit: 05b4738b0078f7d6f154f68068a11c8a0635e9df
-- 
2.56.0

