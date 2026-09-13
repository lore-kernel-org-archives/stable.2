Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC94BEE4C
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270920; cv=none; b=i4dDu2xvJC0BWugu4aPKd8S7CCuEwXwM0I4sfjAPZ8jJWqzh+jW7U8x21p70RpKEQJ6DoGEhxBu6kTM5nAeTo1XIp/ZbXOl6spskLrxUho/MIomlZ93BDmCIVnX3sUDc9Z+OaplHftT7p8ruJxUyEw4OxoEExcX+hOwkCh6ZQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270920; c=relaxed/simple;
	bh=MQi0CJ/fz7tg5s+eLvlNcw0LS2EBxH9xVWjWGdQ246o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBGheVLfOkG46R0HnG1N7jJ5m00A+v+U1JxjxMCbvIp0vmmmkZ0N3AByR/HkyWkfSky0yNouucvRr0aBElgI6PmvJ7MUu05bttrLFIqvv/8spVlzG+ywsXHbjjS8f2Rqca8Nx9M+KRsNB+OaHcwoNYL5gygD6P4Yy/BVJJtQLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDF799cq; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDF799cq"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a135ffb08so53516685a.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789270918; x=1789875718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJp5ud/myTFefNhCI2ZzWiRr2kbld/3n70B98OUzWtQ=;
        b=kDF799cqAa+MUyHN0lyY+sVQ6Bd/JIgTBMz0jogn9Ri+HGcyixWki6ER/ebPBggcV6
         jKWEtI3GRn2ng1byPwX9IhHpLv8CdzUsskW06GNZDVTu7NujZsvyfJBI8sXy4z8GfSsa
         zfhYAFgeewf14W0dSe876eKi4/5FIyNKOuPqa6/fGJ4AXTPKejwKe689DZ7YzRuJhpgF
         kgKrI1A9QW38gZSga+79dLl2jMLPsbSfS1EbjsjIIPmHO5EoTgo4s06gWCuILvJoullR
         WsdJFCvyJVM3Qxqs80+7gWdxqSw2O1N7kfEj4JkiyqSdND2JSsjwJTjprpuB24G5l8zA
         njOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789270918; x=1789875718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJp5ud/myTFefNhCI2ZzWiRr2kbld/3n70B98OUzWtQ=;
        b=BhrQ9hMuu/glH/PyHAM/UptC5hVaKDVGHbg9gQUVxwecMDJm2uhEWdOP2q7f95BVTz
         yrxM7vj8cTHnIp8v8z9PUbXMxA929j4q8nvUBjcdnfNIi+fx+RW2vaFKVQPA7Cj1MmQV
         rbwbpkUJ3isFE+TKmVqei586BMAYF6+yHRxxM61x7kzqc4BbWgv46cHDYwIqRpTr17se
         8m5tt8LFk87V5oxsZmof4vHuYoNrtSGJzuwjNPUDkbZqrIG+eyNZYihcCfYZBxz6Hnvc
         AQcxV6WPcxQ6Uq6n87y3C13muaKaOXGQ4MUPffNZnq6ZE6bbh1KV5dYbXfczkGFCO8Mh
         GBTA==
X-Forwarded-Encrypted: i=1; AKwUvBxPtw1Xb6InxtPlmSw95BZjzO1ZDq5XbzngvwbOK+OJAHWZ0Az88VtXXfksSJ44gTF4q04jqYE=@vger.kernel.org
X-Gm-Message-State: AFuF++k3OOIG3TEmceMCZVAq25gcVbh4R/nEEKKqGGSo+twNVYMhlovk
	32i/c1fMCd+/gVqUoUmpfQPxdbZEhYVLLuc5v5Qi3olEptYqv/1JzTw=
X-Gm-Gg: AYBFou0SSpHboyb8jVRuf6WFW91EcABsVXWvObZr8TWhVvTwfUao3jm0xecXQMRQL0+
	APQbtNhtH5hVoeX5I7xmSEaW+BQR0Uf7y4PZESX2MEek0Q8fUR7K+I+UVEf8sOqa7qPV8fS175f
	WkhXCVlCPmPqqxepxZxjuzu3szhc+/eowoAWJlfcj7XFiUwf5TlSsPSO8j527sKuOg9i7mGuV+i
	UwjTR+1fRsSXbqo+BU19tnkaFFttFS9sKnDS8cbdHtmYpCEVvFUSVqWK2wt78L6UiKkAjLD2xCN
	ZP8hsXo4BA5LALzdwSTNB62SS9vu5YoDJ4vw1L7ibu+GuRni/h+Rh9aWewMlTfWBIzX0/NRtqUU
	O9rd0oJpd8Kw4Zov8glqylY9vOr0GvWJRH52NxuvLkxv+qKGi44ZyD5pcPRRsK5DWpTlQIDRoph
	DmYnZrrSROGh4c02pUHPHw4+BIE5oUa0mD7UUKjTTa9guklqP0dFHW3Z6F+WF8pga5xpsXZSc1x
	6MXovRlLhELj9LPz1CAZ1aEXGtVuqJq/kV23PpRufcqVARrYAl2wwTd7TKKAsvqHzsvgoau6zF9
	YJgCO9u42neVBjU6GjagzYfufvv5
X-Received: by 2002:a05:620a:d8d:b0:939:597:e7af with SMTP id af79cd13be357-93a038fa617mr775671985a.35.1789270918119;
        Sat, 12 Sep 2026 20:41:58 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80d453esm652916385a.38.2026.09.12.20.41.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 20:41:57 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	linux-serial@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] tty: serial: meson: fix UART driver lifetime
Date: Sat, 12 Sep 2026 23:41:48 -0400
Message-ID: <20260913034148.15068-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving Amlogic UART registration into probe left the first driver
registration behind if uart_add_one_port() failed. Adding the separate
ttyS driver later also exposed a global last-port test: removing the last
port of one driver kept it registered whenever the other had a port.

Track whether probe registered the driver and undo it when port addition
fails. On remove, retain the current driver only if a remaining port maps
to that driver. Serialize the shared lifecycle decisions against parallel
probe and remove operations.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: bcb5645f99ef ("tty: serial: meson: redesign the module to platform_driver")
Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/serial/meson_uart.c | 52 +++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index a6cb2a535..4bd9d9826 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -80,6 +81,7 @@ static struct uart_driver meson_uart_driver_ttyAML;
 static struct uart_driver meson_uart_driver_ttyS;
 
 static struct uart_port *meson_ports[AML_UART_PORT_NUM];
+static DEFINE_MUTEX(meson_uart_mutex);
 
 struct meson_uart_data {
 	struct uart_driver *uart_driver;
@@ -692,6 +694,16 @@ static struct uart_driver *meson_uart_current(const struct meson_uart_data *pd)
 		pd->uart_driver : &meson_uart_driver_ttyAML;
 }
 
+static bool meson_uart_has_ports(struct uart_driver *uart_driver)
+{
+	for (int id = 0; id < AML_UART_PORT_NUM; id++)
+		if (meson_ports[id] &&
+		    meson_uart_current(meson_ports[id]->private_data) == uart_driver)
+			return true;
+
+	return false;
+}
+
 static int meson_uart_probe(struct platform_device *pdev)
 {
 	const struct meson_uart_data *priv_data;
@@ -702,6 +714,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	int ret = 0;
 	int irq;
 	bool has_rtscts;
+	bool registered = false;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -731,11 +744,6 @@ static int meson_uart_probe(struct platform_device *pdev)
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
 	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
-	if (meson_ports[pdev->id]) {
-		return dev_err_probe(&pdev->dev, -EBUSY,
-				     "port %d already allocated\n", pdev->id);
-	}
-
 	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
@@ -748,11 +756,22 @@ static int meson_uart_probe(struct platform_device *pdev)
 
 	uart_driver = meson_uart_current(priv_data);
 
+	mutex_lock(&meson_uart_mutex);
+
+	if (meson_ports[pdev->id]) {
+		ret = dev_err_probe(&pdev->dev, -EBUSY,
+				    "port %d already allocated\n", pdev->id);
+		goto out_unlock;
+	}
+
 	if (!uart_driver->state) {
 		ret = uart_register_driver(uart_driver);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "can't register uart driver\n");
+		if (ret) {
+			ret = dev_err_probe(&pdev->dev, ret,
+					    "can't register uart driver\n");
+			goto out_unlock;
+		}
+		registered = true;
 	}
 
 	port->iotype = UPIO_MEM;
@@ -781,9 +800,14 @@ static int meson_uart_probe(struct platform_device *pdev)
 	}
 
 	ret = uart_add_one_port(uart_driver, port);
-	if (ret)
+	if (ret) {
 		meson_ports[pdev->id] = NULL;
+		if (registered)
+			uart_unregister_driver(uart_driver);
+	}
 
+out_unlock:
+	mutex_unlock(&meson_uart_mutex);
 	return ret;
 }
 
@@ -794,15 +818,19 @@ static void meson_uart_remove(struct platform_device *pdev)
 
 	port = platform_get_drvdata(pdev);
 	uart_driver = meson_uart_current(port->private_data);
+
+	mutex_lock(&meson_uart_mutex);
 	uart_remove_one_port(uart_driver, port);
 	meson_ports[pdev->id] = NULL;
 
-	for (int id = 0; id < AML_UART_PORT_NUM; id++)
-		if (meson_ports[id])
-			return;
+	if (meson_uart_has_ports(uart_driver))
+		goto out_unlock;
 
 	/* No more available uart ports, unregister uart driver */
 	uart_unregister_driver(uart_driver);
+
+out_unlock:
+	mutex_unlock(&meson_uart_mutex);
 }
 
 static struct meson_uart_data meson_g12a_uart_data = {
-- 
2.47.1

