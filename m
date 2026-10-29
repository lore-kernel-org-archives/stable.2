Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300317;
	b=x/e9q4n4mnAyQSj+f1kfRFPlDzb5lSDdODrzGhcg6Xn3SKLlP4dSGezBnhdKU3A9iyxc
	 WbFzv9i/EmZ2qpg9+Qgjx9m3SSrmMboJg/nTvIPw0GF6VCVUMEFcfDDvNUkR+/5JWBxCN
	 Ktjwba0X/QWAQKQfkLXKiY5Lqsq6/x+BI4GEErmZSThNkc4gYnrThi4YTbAPcdUyERTPN
	 x9xvcVV3WEork4EB3xFgDY04x5eKJPbXXjVuqS6HlsaOD2y6VfJM4eQ41s9tXUK63f2on
	 B4vEH5tAahlSvGlMwfeQ/tM/NSLAynYe+U/lEqQqrQVdPBv2VGbmB0NTCZWfJCLzlOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=XE6ycAnMXu1bQU/ooZUSiqmjYw2pSbI0uNI5n7hv+8Y=;
	b=zwCEC2fLePtqyz/3sWvx0ek4DZlWM9j0sDKQL2KSOlaOrQlLYO3KXgLAvS3bqpZI1fWh
	 KM+cA/QDzThqq20uVURaBzaUHLfUOLDsMGjZrVhrkyIgaRKaLZlVfpkn3BADo2DGHoyA9
	 oFNDH8tBe49XqwRr1MBDpMikTEwTGK7BK+SgpQg/8yhg+pe98PPgIvYqSeXq/3VSnk1Mg
	 QqQn1xojKBPBD4PYLXQWGXoM1Kv6oFR5wxyYbx0yD23ZEfwLB8nfDfv4lbPSmm9ewKbld
	 j/X27uiK+ryEI6PIlj++YC6sbQgqlWXMqfLbiFYyC4jJLxLSP8AJmuaKVsAK8vSXRrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHGEAkqW;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E960A260C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3E960A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHGEAkqW
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-14394530ec6so2892732c88.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300313; x=1793905113; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XE6ycAnMXu1bQU/ooZUSiqmjYw2pSbI0uNI5n7hv+8Y=;
        b=SHGEAkqWPsT/YfAZqG1IaYNh/Bv6h62Oq9yHdJ8L3qMsjd8lyuM6qKjkLlqT4UXNS7
         Zf2sxePWISw+KvpcI8uv0soEzjR0e7DgqtAgGBvBNy8BkwFdwIPEuOOT/AMyMFllBvlF
         uvZu8/0tVUifVKo8chRZuPqM4Gj61Y38pa4LAKzBrjIUZ1F+YLgDp0ccem0OPDXwGMqQ
         6aGV6/TSroLOdjc6GQNYgpYWheQgsQaPv5aAvGr7lN5D4RkZhy23kBtQXQGNza2Kwe2e
         4LyD3LGciVw+u0+MLIPxrr2hyk2viQfhvu/jCJaQUYi+ea0FMCROZBh1rXsr20Lhmb58
         NPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300313; x=1793905113;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XE6ycAnMXu1bQU/ooZUSiqmjYw2pSbI0uNI5n7hv+8Y=;
        b=egDqFjzgZ4pbc0OhJigPousBdgvfFBFBgH5L0erCBj1dQPfUVIGl/jgtzXrqXTn8f9
         hzjTjxZYlDR4S1Fq4mDlOZS9n5HNFSubdXWAn5BMSh6OXR/b+4GxCm975iAPqdA7T0Ao
         s0siocNEb0ZzH7Fo+QxCuE7WJlK2RSol74JIXzrO4+E4jZQcxVXMeO7dRUfHqzymIpYJ
         ExyuevzvTfk0vA5KgYE1ODRiojGZn0w918b0MFC+ehPM0jehjLRhPQWKTovNMuGNNK+b
         hem84Xda+n2CIHlh51jrQsxpVWjZHms0DLY+9wSd6b9IBdNR/rquWGoTlt6mSXI7KcMI
         9vtg==
X-Forwarded-Encrypted: i=1; AKwUvBzlgTfEF1rs/gspX+jmQ78+14B6qmjF7xG/4b78kZVK5Ar5TT/bFVlIyiV8844aEYB0inKN8bE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFXcTsxkptmbueztviwZKPQU5ncMZFL9wMEIautnpOEDNkScuE
	3MLcBjfnULm1d8RfvUjtvclT49JjpzFDiX8sk/2KrbA9+3TVoDiz0ZZ9
X-Gm-Gg: AYBFou2CLEcIODOnqAcCECLlkyCkuGQcwwjLfQ/RjsLZZ8MwX3Wx/ukzUeiWgZPaXt4
	hJHYjprWE3j+6F4gV4PovjpAFvJX9PzZwEmyJTmbxUXvGpI/4R/in/lvaGnt9bQA0tpMGoA2WfC
	Bj6GDNjbRRKny8Su1fCv8w/SodM8qSlDTiF/KNiJ9NJu7TPQ2Dxpg41JTBK1zlLHkrrZ8iJRdxW
	YyKg7qtoMHKP7S3bgRH4PlC8AOfM7/tVpMu8Y7HkafHd1J+IMPIW4YLSeXUS+AJ+7tCWotXdtH0
	kfEJ17qg7GE8nd9EapKQyYXBKOP9viwUxcSOm4qmsPu68T98Qr/QBJPrry8+E728qj1Lqbpg/XE
	aSqjFAHFbHNhTwQzwrMaR2qtu8FNH0irg3r6f9ZGoqVXNDtEDEn3EykDzVUSBrFf7nCknsFqR+Z
	hsCNo3GyAPvbN3h2vwBdEeWSiyDCn1YGWufEL/KjbBQVWznXa9OjarE4q+6+1cBzhMTDg6qDa80
	TqSu9RNAIwxckSYFIxN2xgRnT2xycRwLBDgfokxEmr9uxQGRxMQ5TzOAB6cwnbFJ0meP8qVKE16
	wgdncjgtTzQKT4DsdQE56+i5N5zF1nLYKyTIVrJDhe8DuI1VUOnQbA07AKwg/t/8q8wzffs9l0I
	vOL+syeCof/4isRPuBw==
X-Received: by 2002:a05:701b:4589:b0:14b:cf58:ce15 with SMTP id a92af1059eb24-1a6d208add6mr7430450c88.43.1793300312786;
        Thu, 29 Oct 2026 11:58:32 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8310:80a5:1043:3f70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458fa3sm603891c88.4.2026.10.29.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:58:30 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 29 Oct 2026 11:58:15 -0700
Subject: [PATCH] gpio: sa1100: defer GPIO chip registration to
 postcore_initcall
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-sa1100-swnode-fix-v1-1-112f4d83d191@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEaX42oC/yXMywqDMBCF4VeRWTuQSYsSX6W4SHS000WUjJeC+
 O5NdfkdOP8ByklYoSkOSLyJyhQzqCyge/s4MkqfDdbYiox1qJ7IGNQ9Tj3jIF8kejpX04ND7SH
 /5sR5vpqv9rau4cPd8g/Bef4AD6TQWXUAAAA=
X-Change-ID: 20261029-sa1100-swnode-fix-11499713eb7a
To: Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Registering the software node and the GPIO chip for the SA-1100 GPIO
controller during early IRQ initialization causes boot hangs on
SA-1100 platforms because the software node subsystem has not yet
been initialized. At that early boot stage, attempting to register
software nodes dereferences a NULL kset pointer before console or
driver model initialization.

Nothing on SA-1100 platforms requests GPIO lines via gpiolib during
early boot before initcalls run; only the GPIO IRQ controller and
domain must be initialized during init_IRQ(). Defer registering the
software node, assigning its firmware node, and registering the GPIO
chip with gpiolib to postcore_initcall, running after driver and
gpiolib device initialization and before board consumers register.

Fixes: e4671f292ebb ("gpio: sa1100: register software node for GPIO controller")
Cc: stable@vger.kernel.org
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/r/2a561a27-a3bf-4cac-a4dc-bfbc5c859f45@roeck-us.net
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpio-sa1100.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index e4f3bf949b87..1916200ebbd5 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 #include <linux/syscore_ops.h>
 #include <soc/sa1100/pwer.h>
 #include <mach/hardware.h>
@@ -322,7 +323,6 @@ static const int sa1100_gpio_irqs[] __initconst = {
 void __init sa1100_init_gpio(void)
 {
 	struct sa1100_gpio_chip *sgc = &sa1100_gpio_chip;
-	struct gpio_chip *gc = &sgc->chip;
 	int i;
 
 	/* clear all GPIO edge detects */
@@ -330,10 +330,6 @@ void __init sa1100_init_gpio(void)
 	writel_relaxed(0, sgc->membase + R_GRER);
 	writel_relaxed(-1, sgc->membase + R_GEDR);
 
-	software_node_register(&sa1100_gpiochip_node);
-	gc->fwnode = software_node_fwnode(&sa1100_gpiochip_node);
-	gpiochip_add_data(gc, NULL);
-
 	sa1100_gpio_irqdomain = irq_domain_create_simple(NULL,
 			28, IRQ_GPIO0,
 			&sa1100_gpio_irqdomain_ops, sgc);
@@ -342,3 +338,29 @@ void __init sa1100_init_gpio(void)
 		irq_set_chained_handler_and_data(sa1100_gpio_irqs[i],
 						 sa1100_gpio_handler, sgc);
 }
+
+static int __init sa1100_gpio_init_chip(void)
+{
+	struct gpio_chip *gc = &sa1100_gpio_chip.chip;
+	int error;
+
+	error = software_node_register(&sa1100_gpiochip_node);
+	if (error) {
+		pr_err("failed to register sa1100 gpiochip software node: %d\n",
+		       error);
+		return error;
+	}
+
+	gc->fwnode = software_node_fwnode(&sa1100_gpiochip_node);
+
+	error = gpiochip_add_data(gc, NULL);
+	if (error) {
+		pr_err("failed to add sa1100 gpiochip: %d\n", error);
+		gc->fwnode = NULL;
+		software_node_unregister(&sa1100_gpiochip_node);
+		return error;
+	}
+
+	return 0;
+}
+postcore_initcall(sa1100_gpio_init_chip);

---
base-commit: 6d0933ae9d46674a6ea63a87e9e9ab4e662670c9
change-id: 20261029-sa1100-swnode-fix-11499713eb7a

Thanks.

-- 
Dmitry

