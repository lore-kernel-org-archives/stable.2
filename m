Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918B23BD1B
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614526; cv=none; b=noP36jj0v0N1VfD9D6Efte0rrqfwbjNTsEO12EGr7s++AkEq7Am1a2+CM0mNgMCrfda42NVOLj6RNJpuUWgu+tyZFMn+3sspQrSKQtB1MAWnvA4A7osrKyz7vWBCUyDqRwvDwXEB59bJ7XkO9HqDj206w982o1Dv/Kd2/xYRvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614526; c=relaxed/simple;
	bh=PqIlCkJmtkmh7wSB8OP4i87rwCMmMANIsCJcEfZ1JPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InnTclyJAAurI4Y/CR3pJVR4BTF4tkmwXyjLk4wlPfDYE7twEAHqnn41P95lsPE5NlwmhCgBSVOC9SW055YE589lhP81wotXc4flAkqGRZ2LEgwtwl28JON9QSns+hWaBWdxyD2EGmmkePpakN4us6Gh6RRQR3TbzZN1LcIARfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT8YAk4s; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT8YAk4s"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1674999a12.2
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785614524; x=1786219324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ggmpKDlBjCfXFEH2bmuD64+8X7Nry2xQnXVVBJHK/A=;
        b=MT8YAk4svxTvLj8Fx8Dr3CJzxdal/95Hq25uzCgAjjVta7kyAytjEQPLUlGGTtdKX4
         zVM+m5tzr6BULVF11p82h/wQciUHpcjODS7GFojtnNfuRgUrZRtia+LmHtq8gchDLbWA
         xl1sqdIXRf2r6yB3CHqBRkoOC3n+ZULBF29rW+G60oAsUNXd1NgVtD6jbwtXC9/XKumw
         Q/2tOJNMHsYOKjMQqvgQBbKaHc+DVcHjn2tsRtR1i/yUCUzQx7qENLQJbA6VKUDnCVKr
         z+F040JbR0XMf3qzlo5bNZGSOm2UNS/kMzYnPAaWK1opuSSQx2FuIy4xYUShgbN1imis
         K2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785614524; x=1786219324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ggmpKDlBjCfXFEH2bmuD64+8X7Nry2xQnXVVBJHK/A=;
        b=Jd5Gv51qIzuewH3enkDGKVfS/XZtO9/QCROkNBe/Ca9IP64uYHJnlEC3Nm4Q9PVEjg
         P31e+N0Phfgfzf1BQopaASqwonJuKAQ+5dWJnJfxBYqhlu51LE0J2VUXBx/ICyzsG2ss
         YvLn8xBVfVU2pkXlWbam/1Ufc5+ji5AS0lKCQwVgBuhF0wPhQWsMVDoPhydrJYzCNT9X
         RWtoerG2CpzYh9N5lackuqfzpCw1E8iDoNkLBpELLhDeWAeamJNMRP8eqQeKmEiXAAu2
         81KYWLR3WNvSimBpzbDoYT1uCt5dU0JWtjaBtoaMCYsu8O3Z3OBxrEU/iAoC2W+d5Wi9
         eH7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqNy3QtM6RZtanGMno+E63395Bsaw8mvx9oq8e8HLgv901YGt9xo2PYmGIG/iHZSATCQfejYj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztV0mHukJJswsadJNXZyqIyaIb2zeEwzaYNWTmI/ebpCYu5gOc
	JAE3OO7gRkxy5o/EaVVVAFDW9Ef6o9Xy06VPWJV1XVTRbTTI5GDi42iQ
X-Gm-Gg: AR+sD12EYOQur0/ugAIF7EPdK0AHwLbxgelTUt/SchLkluMcxaF0jGZRP3ioClmdUHp
	PoyZ3/w+y5NpGOHy4sOS6EcHrSIuolleYMpWvhTD3PuszsRNvp/dsv0JSHOCyhOJQCA+iJD4IXn
	2LduFVvXxTJI1PgF2ordHg+KSsMcGAFXe8EwRyEsm1w7Km0Mo/WhrxqffoCyouHk88h+0CLVhj/
	wno1BFxSLFn06eKjnLnz3uH1iC9UJF/ynt8SpQtiQxfxxBJlbzPsl7sYTwIca2b+cZWe9Z92Yvk
	d9rDTE54zFilhuygsLRnx9X3uQKR2eswatcsWpX8r8H1DqtUtd0MqJmf+DRF3rkaQxKbydppQCW
	4ponAs8WMjHp0VBpNJQQH8S0dlR6bPxVevppA5P7Ujk8OSrpsBj25mtMF9hmIJMs5iej4zeBQpH
	/fzul+ELgTtWts6+YZtwsFxsFZ8QDt1+zL7/K66vBKEwmK1/sbzpyPfWUrai0kdQFKWayQoLbiG
	Z7WS7PVmln+97TAolKFb8R4L9ZeZ791fhp1h76rjFF3x2O1n4nAnkTcAQceevWKDj2vW9pHmFZ9
	0kG6DvhOpaIkeeMIyCpW
X-Received: by 2002:a05:6300:2206:b0:3c4:4272:b400 with SMTP id adf61e73a8af0-3c92a5bc504mr4747990637.18.1785614524305;
        Sat, 01 Aug 2026 13:02:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:7865:f907:f2bf:8664])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04506csm20980095eec.17.2026.08.01.13.02.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Aug 2026 13:02:03 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] auxdisplay: linedisp: serialize sysfs message updates
Date: Sun,  2 Aug 2026 01:46:50 +0545
Message-ID: <20260801200150.60098-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

message_store() frees and replaces linedisp->message, restarts the
scroll timer, and may immediately read the new buffer again to update the
display. message_show() and scroll_step_ms_store() can run concurrently
through separate sysfs opens, because kernfs only serializes operations per
open file.

That leaves the display state vulnerable to concurrent readers and writers.
A racing write can free a message buffer that another sysfs write is still
copying from, and a sysfs read can format a message pointer while another
thread frees and replaces it.

Serialize sysfs access to the display state with a mutex. Keep the timer
callback lockless, and use timer_delete_sync() under the mutex so sysfs
writers wait for any in-flight scroll callback before changing the
message, scroll position, or scroll rate.

Fixes: 7e76aece6f03 ("auxdisplay: Extract character line display core support")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/auxdisplay/line-display.c | 7 +++++++
 drivers/auxdisplay/line-display.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 915eb5cd9..fbac10668 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -164,6 +164,7 @@ static void linedisp_scroll(struct timer_list *t)
 static int linedisp_display(struct linedisp *linedisp, const char *msg,
 			    ssize_t count)
 {
+	guard(mutex)(&linedisp->lock);
 	char *new_msg;
 
 	/* stop the scroll timer */
@@ -226,6 +227,7 @@ static ssize_t message_show(struct device *dev, struct device_attribute *attr,
 {
 	struct linedisp *linedisp = to_linedisp(dev);
 
+	guard(mutex)(&linedisp->lock);
 	return sysfs_emit(buf, "%s\n", linedisp->message);
 }
 
@@ -267,6 +269,7 @@ static ssize_t scroll_step_ms_show(struct device *dev,
 {
 	struct linedisp *linedisp = to_linedisp(dev);
 
+	guard(mutex)(&linedisp->lock);
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(linedisp->scroll_rate));
 }
 
@@ -282,6 +285,8 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 	if (err)
 		return err;
 
+	guard(mutex)(&linedisp->lock);
+
 	timer_delete_sync(&linedisp->timer);
 
 	linedisp->scroll_rate = msecs_to_jiffies(ms);
@@ -444,6 +449,7 @@ int linedisp_attach(struct linedisp *linedisp, struct device *dev,
 	linedisp->ops = ops;
 	linedisp->num_chars = num_chars;
 	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
+	mutex_init(&linedisp->lock);
 
 	linedisp->buf = kzalloc(linedisp->num_chars, GFP_KERNEL);
 	if (!linedisp->buf)
@@ -531,6 +537,7 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	linedisp->ops = ops;
 	linedisp->num_chars = num_chars;
 	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
+	mutex_init(&linedisp->lock);
 
 	err = ida_alloc(&linedisp_id, GFP_KERNEL);
 	if (err < 0)
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 36853b639..13b56fe3b 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -13,6 +13,7 @@
 #define _LINEDISP_H
 
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/timer_types.h>
 
 #include <linux/map_to_7segment.h>
@@ -58,6 +59,7 @@ struct linedisp_ops {
 /**
  * struct linedisp - character line display private data structure
  * @dev: the line display device
+ * @lock: serializes sysfs access to the display state
  * @timer: timer used to implement scrolling
  * @ops: character line display operations
  * @buf: pointer to the buffer for the string currently displayed
@@ -70,6 +72,7 @@ struct linedisp_ops {
  */
 struct linedisp {
 	struct device dev;
+	struct mutex lock; /* serializes sysfs access to the display state */
 	struct timer_list timer;
 	const struct linedisp_ops *ops;
 	struct linedisp_map *map;
-- 
2.51.2

