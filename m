Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533548;
	b=rHFt6mQTy4FJXTC0OP65RRzNngsCaLK/obtVF9Sc5FxTOApUcrc1Wq4FsVq7kHfTV1R6
	 o7frCbn1xu7iAE9lKx5atiS9O93FQF+of0kINsQimMf+equI2+Yh7J4DCHx8DEt5+qaTg
	 99iUxdy+L5+ibYM2T9O/24wl6gZL87KD66y3NuQdFUzTtv/z36vrvotB0EWdT2tf5/JMN
	 MNd4rO0fQf35egHQl67mPIgC7gGXwhbZW4NN/DH2YIDFK1LjRZHpVChRy7N44jlFWFl3+
	 RFoWZaINIulOwNSJm/apgZE6dQkpcT1uS/iJNmG+MqKWX2EoA/TF/4k80Gq6X0VNvNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yaPzTNzS9vcm8XrStwcS2srUboheOtzp4zjwgW7ODUo=;
	b=yjS7Q8dC1a7esLrvImeY4EM/YqBhZRhku3JPzUmdBeWXNHlaeK7fEy7DNHJNCJ+vwPZ5
	 z9KEvRMHTaifLCh3gio6YukXnZgeUnvbXKwZmD1TuqQmaELUkAjJfl0gD+CD9PKgCXUKC
	 VjYXlCbfqnl53GoG0kNEZWFmZQKPSMXSmc4Q5cKzmyJxVZ+Gh/ONw/xrecaliu4qv0EYs
	 GBKtGAGNVotpH+DVCMk4nU+/aFdEc39rKj0j2VmLp0UgN4MnXBCM4TUqvgDp8eFHIJzQT
	 gfOJJkY/+bHnh3oozlkJboKGhgiJ32G1a3N7sbaMCmtsXjSIOQd+HFI6aip7TV6ylyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bEwqGxVS;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06C6606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F06C6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bEwqGxVS
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-74ab99038afso495283137.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794533547; x=1795138347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yaPzTNzS9vcm8XrStwcS2srUboheOtzp4zjwgW7ODUo=;
        b=bEwqGxVSZEgiZfeUHyQ4X6j+xmA9YFMg9C3c9gdG2of3W17qoml+f4a8+zBqD9YyV3
         afUfBprGMFNiTDJkjTlcYr3QPvtjPnxtiSoeIyiNYN7RPgR/RHujwWORXFdtIYGNg0HM
         T7FrXAUhd+m4IiTKxaJLMSJrITTTeq9SeCfHT+umw8zMu9V/orjbRrNTbDm+yrCJ2oSQ
         DUq0u0/X1kGhn6HA90kIgmzUswvInFvGk17Q3uJcyRr7d69WGgx+ZrMHonAymgjobqg+
         TaK3oYMkg8FgMW8YUwp932/7qrhz3jqWlqMyfd76IXQ5Ky9ODaSid3hgv7J6xYlKx/nG
         Bmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533547; x=1795138347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yaPzTNzS9vcm8XrStwcS2srUboheOtzp4zjwgW7ODUo=;
        b=aFo1NdAd33wJiA6+ATo3pMOEUwbn68Up8RWMuc/bX8y2ll/TWA1DpjROKY5g5mZgva
         NAS4qCrsxYqSy4F5CKzN3pqSNQ975jZLmyXopz2ahAhedzKk6pcmVxELlNmsgXEtqGsw
         Z1b8LPdNPJUflf8Yw49j47mjrQBPQKQYyw0aM8IPxOg4+d3cQkI3U7ueM5O8bWEJtk6s
         kLkgeEx95LyjERagNE4fFYx1sNZpPQU9e93xalH3/x4ZOOL1fMREgh58WXxrFhQ+xRWe
         Xy9YP12lW1uD0i6CQ7Cp7pJ5/oAxz3g+D0awbFteBrxxbGuUjWcumZu2Fg8UqXE+/hEy
         o0rg==
X-Forwarded-Encrypted: i=1; AL+hErHmBWifyaXhPCFoBvEL3KJ1+8mkriU+dPRY3feOcaOjRjtGc22jYZWX4GhQq4h2Mgi+gR+kkvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Oczhc5srRk124c/MXKFlz5ZQRdO2xW2KzfEYXS2PvETIKquU0
	69PTRx/doReaFdYijJIlri5a1VLZ5svvhMgN8KZUdpRw4+OH7kV0yC7w
X-Gm-Gg: AYBFou25zuWWxx7d8QhIhcNFVqY3KawdEXTBFOwQWIF1SrZjL7UBJc4rQrrVfBTPUcq
	oameQxeUavbdPKIsbydGabtsdVP0b2x/3haj3Gv5B2JReQTvh/Ju2PAi5GpestAKLv0C3Eif9l4
	8Uw4tW5oOEuIEJJlJrMqFdaITetMkJE9kbqVV8NZTANLsiKrW2oJYj1zBlM6Kq1EK5fAbD3CE0P
	8SVPV4cFCmbuMOGK+Ai8QaPMWFQLqJSY90JYMc/SoXQKLB1W48qVPvLX5KMV0Rgh2Hpz6E14ydK
	pxw9wjpw+X/cj/ZK8Qt3k5RywI7snnu3QWBLfb+4qpA60BNEZd1znLUg951BA6bsTcbFjj6RV9m
	HBg9SMpUPFABCJajQ+K4KnyFnrbOJyAdpo5GN69gm9LoKdoED0th4IhIX1F/2UOWc4MsH1mj7xD
	t1FrLb+kpHEvpVj4/Wv589EbR9yfPynd9+ecUyf8YrbLj9gPqxGhYbwzbLLGW00GXnuByGwqgfx
	8wlnsPDfKUPFDYa17NG2fJU5TvCx5XYijA3HIrsAtZpwIivhu5U6qxlRyGEpBYeG7hZCKVNnIlc
	f9FzxjHgC8Gb+QhH5TDRiHoviZ2dSilPtmdoI0Hr+6h+e0ZqqG7skK8rOENpq4AeDG2hCnSfms0
	ddoBOsY3pE+WL1+2jgnEQ6A==
X-Received: by 2002:a05:6102:e0c:b0:7cc:1045:604 with SMTP id ada2fe7eead31-7d64d8b000bmr325444137.30.1794533546827;
        Thu, 12 Nov 2026 17:32:26 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:4b16:e82:1dda:bfc3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64be7e2e9sm796166137.0.2026.11.12.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:32:26 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] mfd: mxs-lradc: Pass parent IRQs to child drivers
Date: Thu, 12 Nov 2026 22:32:12 -0300
Message-ID: <20261113013212.470981-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113013212.470981-1-festevam@gmail.com>
References: <20261113013212.470981-1-festevam@gmail.com>
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

The MFD driver stores raw DT interrupt indices in IRQ resources but
registers its child devices without an IRQ domain or IRQ base. The child
drivers consequently receive the indices as if they were mapped Linux
IRQ numbers. IRQ index 0 triggers the platform_get_irq_byname() warning:

  0 is an invalid IRQ number

The children then try to recover the indices from their resources and
map them against the parent OF node. Besides duplicating IRQ names in
the parent and children, this relies on invalid platform IRQ resources
and fails when IRQ 0 is rejected.

Resolve the interrupts with platform_get_irq() in the MFD parent and
store the mapped IRQs in the shared LRADC data. Drop the child IRQ
resources and duplicated name arrays, and have both child drivers
request the mapped IRQs directly. Use the MFD memory base support to
translate a single relative memory resource shared by both cells.

Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
touch events are reported, and the touch-detect and LRADC channel 7
interrupt counters increase as expected.

Cc: stable@vger.kernel.org
Suggested-by: Lee Jones <lee@kernel.org>
Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
- Use reversed Christmas tree. (Andy)
- Check the return value of device_get_match_data() (Andy)

This is a long-standing bug that I reported in 2020:
https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/

This patch touches MFD, IIO, and Input. Since the IRQ mapping is moved
into the MFD parent, I suggest merging it through the MFD tree, with
acks from the IIO and Input maintainers.

The full backtrace:

[   10.540505] WARNING: drivers/base/platform.c:492 at __platform_get_irq_byname+0xb4/0xcc, CPU#0: swapper/0/1
[   10.555516] 0 is an invalid IRQ number
[   10.559627] Modules linked in:
[   10.562849] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc7-next-20261016-00003-g36062817a968 #17 VOLUNTARY
[   10.573732] Hardware name: Freescale MXS (Device Tree)
[   10.578934] Call trace:
[   10.578992]  unwind_backtrace from show_stack+0x10/0x14
[   10.586955]  show_stack from dump_stack_lvl+0x48/0x64
[   10.592170]  dump_stack_lvl from __warn+0x8c/0x190
[   10.597114]  __warn from warn_slowpath_fmt+0x94/0xcc
[   10.602232]  warn_slowpath_fmt from __platform_get_irq_byname+0xb4/0xcc
[   10.609027]  __platform_get_irq_byname from platform_get_irq_byname+0x10/0x30
[   10.616337]  platform_get_irq_byname from mxs_lradc_ts_probe+0x18c/0x378
[   10.623247]  mxs_lradc_ts_probe from platform_probe+0x58/0x90
[   10.629174]  platform_probe from really_probe+0xc4/0x2cc
[   10.634649]  really_probe from __driver_probe_device+0xa0/0x1e0
[   10.640721]  __driver_probe_device from driver_probe_device+0x30/0xc0
[   10.647315]  driver_probe_device from __driver_attach+0x94/0x158
[   10.653466]  __driver_attach from bus_for_each_dev+0x7c/0xd0
[   10.659280]  bus_for_each_dev from bus_add_driver+0x158/0x1fc
[   10.665169]  bus_add_driver from driver_register+0x7c/0x114
[   10.670901]  driver_register from do_one_initcall+0x60/0x294
[   10.676721]  do_one_initcall from kernel_init_freeable+0x19c/0x24c
[   10.683073]  kernel_init_freeable from kernel_init+0x14/0x10c
[   10.688997]  kernel_init from ret_from_fork+0x14/0x38
[   10.694200] Exception stack(0xc8819fb0 to 0xc8819ff8)
[   10.699335] 9fa0:                                     00000000 00000000 00000000 00000000
[   10.707591] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.715843] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   10.723117] irq event stamp: 146363
[   10.726729] hardirqs last  enabled at (146367): [<c00adbd8>] __nbcon_atomic_flush_pending_con+0x120/0x1c0
[   10.736770] hardirqs last disabled at (146372): [<c0008f38>] __irq_svc+0x58/0xb0
[   10.744618] softirqs last  enabled at (146362): [<c0032c20>] __irq_exit_rcu+0x148/0x1d4
[   10.753153] softirqs last disabled at (146385): [<c0032c20>] __irq_exit_rcu+0x148/0x1d4
[   10.761603] ---[ end trace 0000000000000000 ]---
[   10.766374] mxs-lradc-ts mxs-lradc-ts: error -EINVAL: IRQ mxs-lradc-touchscreen not found
[   10.766456] mxs-lradc-ts mxs-lradc-ts: probe with driver mxs-lradc-ts failed with error -22

 drivers/iio/adc/mxs-lradc-adc.c          |  43 +-----
 drivers/input/touchscreen/mxs-lradc-ts.c |  30 ++--
 drivers/mfd/mxs-lradc.c                  | 175 ++++++++++++-----------
 include/linux/mfd/mxs-lradc.h            |  10 ++
 4 files changed, 113 insertions(+), 145 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index dda5182a5076..1222997649f4 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/mxs-lradc.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
@@ -39,28 +38,6 @@
 
 #define VREF_MV_BASE 1850
 
-static const char *mx23_lradc_adc_irq_names[] = {
-	"mxs-lradc-channel0",
-	"mxs-lradc-channel1",
-	"mxs-lradc-channel2",
-	"mxs-lradc-channel3",
-	"mxs-lradc-channel4",
-	"mxs-lradc-channel5",
-};
-
-static const char *mx28_lradc_adc_irq_names[] = {
-	"mxs-lradc-thresh0",
-	"mxs-lradc-thresh1",
-	"mxs-lradc-channel0",
-	"mxs-lradc-channel1",
-	"mxs-lradc-channel2",
-	"mxs-lradc-channel3",
-	"mxs-lradc-channel4",
-	"mxs-lradc-channel5",
-	"mxs-lradc-button0",
-	"mxs-lradc-button1",
-};
-
 static const u32 mxs_lradc_adc_vref_mv[][LRADC_MAX_TOTAL_CHANS] = {
 	[IMX23_LRADC] = {
 		VREF_MV_BASE,		/* CH0 */
@@ -691,9 +668,8 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	struct mxs_lradc_adc *adc;
 	struct iio_dev *iio;
 	struct resource *iores;
-	int ret, irq, virq, i, s, n;
+	int ret, i, s;
 	u64 scale_uv;
-	const char **irq_name;
 
 	/* Allocate the IIO device. */
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -725,28 +701,19 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	if (lradc->soc == IMX23_LRADC) {
 		iio->channels = mx23_lradc_chan_spec;
 		iio->num_channels = ARRAY_SIZE(mx23_lradc_chan_spec);
-		irq_name = mx23_lradc_adc_irq_names;
-		n = ARRAY_SIZE(mx23_lradc_adc_irq_names);
 	} else {
 		iio->channels = mx28_lradc_chan_spec;
 		iio->num_channels = ARRAY_SIZE(mx28_lradc_chan_spec);
-		irq_name = mx28_lradc_adc_irq_names;
-		n = ARRAY_SIZE(mx28_lradc_adc_irq_names);
 	}
 
 	ret = stmp_reset_block(adc->base);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < n; i++) {
-		irq = platform_get_irq_byname(pdev, irq_name[i]);
-		if (irq < 0)
-			return irq;
-
-		virq = irq_of_parse_and_map(dev->parent->of_node, irq);
-
-		ret = devm_request_irq(dev, virq, mxs_lradc_adc_handle_irq,
-				       0, irq_name[i], iio);
+	for (i = 0; i < lradc->num_adc_irqs; i++) {
+		ret = devm_request_irq(dev, lradc->adc_irq[i],
+				       mxs_lradc_adc_handle_irq, 0,
+				       dev_name(dev), iio);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 2970d9eb9c2b..c89aaed9eb8d 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -18,15 +18,8 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/mxs-lradc.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
-static const char * const mxs_lradc_ts_irq_names[] = {
-	"mxs-lradc-touchscreen",
-	"mxs-lradc-channel6",
-	"mxs-lradc-channel7",
-};
-
 /*
  * Touchscreen handling
  */
@@ -601,12 +594,12 @@ static int mxs_lradc_ts_register(struct mxs_lradc_ts *ts)
 
 static int mxs_lradc_ts_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
 	struct mxs_lradc_ts *ts;
-	int ret, irq, virq, i;
+	struct device_node *node = pdev->dev.parent->of_node;
+	struct mxs_lradc *lradc = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
 	u32 ts_wires = 0, adapt;
+	int ret, i;
 
 	ts = devm_kzalloc_obj(dev, *ts);
 	if (!ts)
@@ -668,19 +661,12 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 		return ret;
 
 	mxs_lradc_ts_hw_init(ts);
+	mxs_lradc_ts_stop(ts);
 
-	for (i = 0; i < 3; i++) {
-		irq = platform_get_irq_byname(pdev, mxs_lradc_ts_irq_names[i]);
-		if (irq < 0)
-			return irq;
-
-		virq = irq_of_parse_and_map(node, irq);
-
-		mxs_lradc_ts_stop(ts);
-
-		ret = devm_request_irq(dev, virq,
+	for (i = 0; i < ARRAY_SIZE(lradc->ts_irq); i++) {
+		ret = devm_request_irq(dev, lradc->ts_irq[i],
 				       mxs_lradc_ts_handle_irq,
-				       0, mxs_lradc_ts_irq_names[i], ts);
+				       0, dev_name(dev), ts);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index 30a66e268169..d16dfea89207 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -18,12 +18,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 
-#define ADC_CELL		0
-#define TSC_CELL		1
-#define RES_MEM			0
-
 enum mx23_lradc_irqs {
 	MX23_LRADC_TS_IRQ = 0,
 	MX23_LRADC_CH0_IRQ,
@@ -52,84 +49,111 @@ enum mx28_lradc_irqs {
 	MX28_LRADC_BUTTON1_IRQ,
 };
 
-static struct resource mx23_adc_resources[] = {
-	DEFINE_RES_MEM(0x0, 0x0),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
+struct mxs_lradc_soc_data {
+	enum mxs_lradc_id soc;
+	unsigned int num_adc_irqs;
+	u8 adc_irq[MXS_LRADC_MAX_ADC_IRQS];
+	u8 ts_irq[MXS_LRADC_NUM_TS_IRQS];
 };
 
-static struct resource mx23_touchscreen_resources[] = {
-	DEFINE_RES_MEM(0x0, 0x0),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
+static const struct mxs_lradc_soc_data mx23_lradc_data = {
+	.soc = IMX23_LRADC,
+	.num_adc_irqs = 6,
+	.adc_irq = {
+		MX23_LRADC_CH0_IRQ,
+		MX23_LRADC_CH1_IRQ,
+		MX23_LRADC_CH2_IRQ,
+		MX23_LRADC_CH3_IRQ,
+		MX23_LRADC_CH4_IRQ,
+		MX23_LRADC_CH5_IRQ,
+	},
+	.ts_irq = {
+		MX23_LRADC_TS_IRQ,
+		MX23_LRADC_CH6_IRQ,
+		MX23_LRADC_CH7_IRQ,
+	},
 };
 
-static struct resource mx28_adc_resources[] = {
-	DEFINE_RES_MEM(0x0, 0x0),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH0_IRQ, "mxs-lradc-thresh0"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH1_IRQ, "mxs-lradc-thresh1"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON0_IRQ, "mxs-lradc-button0"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON1_IRQ, "mxs-lradc-button1"),
+static const struct mxs_lradc_soc_data mx28_lradc_data = {
+	.soc = IMX28_LRADC,
+	.num_adc_irqs = 10,
+	.adc_irq = {
+		MX28_LRADC_TRESH0_IRQ,
+		MX28_LRADC_TRESH1_IRQ,
+		MX28_LRADC_CH0_IRQ,
+		MX28_LRADC_CH1_IRQ,
+		MX28_LRADC_CH2_IRQ,
+		MX28_LRADC_CH3_IRQ,
+		MX28_LRADC_CH4_IRQ,
+		MX28_LRADC_CH5_IRQ,
+		MX28_LRADC_BUTTON0_IRQ,
+		MX28_LRADC_BUTTON1_IRQ,
+	},
+	.ts_irq = {
+		MX28_LRADC_TS_IRQ,
+		MX28_LRADC_CH6_IRQ,
+		MX28_LRADC_CH7_IRQ,
+	},
 };
 
-static struct resource mx28_touchscreen_resources[] = {
-	DEFINE_RES_MEM(0x0, 0x0),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
+static const struct resource mxs_lradc_resources[] = {
+	DEFINE_RES_MEM(0, SZ_8K),
 };
 
-static struct mfd_cell mx23_cells[] = {
+static const struct mfd_cell mxs_lradc_cells[] = {
 	{
 		.name = "mxs-lradc-adc",
-		.resources = mx23_adc_resources,
-		.num_resources = ARRAY_SIZE(mx23_adc_resources),
+		.resources = mxs_lradc_resources,
+		.num_resources = ARRAY_SIZE(mxs_lradc_resources),
 	},
 	{
 		.name = "mxs-lradc-ts",
-		.resources = mx23_touchscreen_resources,
-		.num_resources = ARRAY_SIZE(mx23_touchscreen_resources),
-	},
-};
-
-static struct mfd_cell mx28_cells[] = {
-	{
-		.name = "mxs-lradc-adc",
-		.resources = mx28_adc_resources,
-		.num_resources = ARRAY_SIZE(mx28_adc_resources),
+		.resources = mxs_lradc_resources,
+		.num_resources = ARRAY_SIZE(mxs_lradc_resources),
 	},
-	{
-		.name = "mxs-lradc-ts",
-		.resources = mx28_touchscreen_resources,
-		.num_resources = ARRAY_SIZE(mx28_touchscreen_resources),
-	}
 };
 
 static const struct of_device_id mxs_lradc_dt_ids[] = {
-	{ .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
-	{ .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
+	{ .compatible = "fsl,imx23-lradc", .data = &mx23_lradc_data, },
+	{ .compatible = "fsl,imx28-lradc", .data = &mx28_lradc_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
 
+static int mxs_lradc_get_irqs(struct platform_device *pdev,
+			      struct mxs_lradc *lradc,
+			      const struct mxs_lradc_soc_data *data)
+{
+	int i, irq;
+
+	for (i = 0; i < data->num_adc_irqs; i++) {
+		irq = platform_get_irq(pdev, data->adc_irq[i]);
+		if (irq < 0)
+			return irq;
+
+		lradc->adc_irq[i] = irq;
+	}
+	lradc->num_adc_irqs = data->num_adc_irqs;
+
+	for (i = 0; i < ARRAY_SIZE(data->ts_irq); i++) {
+		irq = platform_get_irq(pdev, data->ts_irq[i]);
+		if (irq < 0)
+			return irq;
+
+		lradc->ts_irq[i] = irq;
+	}
+
+	return 0;
+}
+
 static int mxs_lradc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	const struct mxs_lradc_soc_data *data;
 	struct mxs_lradc *lradc;
-	struct mfd_cell *cells = NULL;
 	struct resource *res;
+	unsigned int num_cells;
 	int ret = 0;
 	u32 ts_wires = 0;
 
@@ -137,7 +161,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (!lradc)
 		return -ENOMEM;
 
-	lradc->soc = (kernel_ulong_t)device_get_match_data(&pdev->dev);
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODATA;
+
+	lradc->soc = data->soc;
 
 	lradc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(lradc->clk)) {
@@ -187,38 +215,15 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	switch (lradc->soc) {
-	case IMX23_LRADC:
-		mx23_adc_resources[RES_MEM] = *res;
-		mx23_touchscreen_resources[RES_MEM] = *res;
-		cells = mx23_cells;
-		break;
-	case IMX28_LRADC:
-		mx28_adc_resources[RES_MEM] = *res;
-		mx28_touchscreen_resources[RES_MEM] = *res;
-		cells = mx28_cells;
-		break;
-	default:
-		dev_err(dev, "Unsupported SoC\n");
-		ret = -ENODEV;
+	ret = mxs_lradc_get_irqs(pdev, lradc, data);
+	if (ret)
 		goto err_clk;
-	}
-
-	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
-				   &cells[ADC_CELL], 1, NULL, 0, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
-		goto err_clk;
-	}
-
-	if (!lradc->touchscreen_wire)
-		return 0;
 
-	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
-				   &cells[TSC_CELL], 1, NULL, 0, NULL);
+	num_cells = lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   mxs_lradc_cells, num_cells, res, 0, NULL);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"Failed to add the touchscreen subdevice\n");
+		dev_err(dev, "Failed to add subdevices\n");
 		goto err_clk;
 	}
 
diff --git a/include/linux/mfd/mxs-lradc.h b/include/linux/mfd/mxs-lradc.h
index ada3d81ee277..d36951f03da2 100644
--- a/include/linux/mfd/mxs-lradc.h
+++ b/include/linux/mfd/mxs-lradc.h
@@ -19,6 +19,9 @@
 #define LRADC_MAX_MAPPED_CHANS	8
 #define LRADC_MAX_TOTAL_CHANS	16
 
+#define MXS_LRADC_MAX_ADC_IRQS	10
+#define MXS_LRADC_NUM_TS_IRQS	3
+
 #define LRADC_DELAY_TIMER_HZ	2000
 
 #define LRADC_CTRL0				0x00
@@ -153,6 +156,9 @@ enum mxs_lradc_ts_wires {
  * @buffer_vchans: channels that can be used during buffered capture
  * @touchscreen_wire: touchscreen type (4-wire or 5-wire)
  * @use_touchbutton: button state (on or off)
+ * @num_adc_irqs: number of ADC interrupts
+ * @adc_irq: ADC interrupts
+ * @ts_irq: touchscreen interrupts
  */
 struct mxs_lradc {
 	enum mxs_lradc_id	soc;
@@ -161,6 +167,10 @@ struct mxs_lradc {
 
 	enum mxs_lradc_ts_wires	touchscreen_wire;
 	bool			use_touchbutton;
+
+	unsigned int		num_adc_irqs;
+	int			adc_irq[MXS_LRADC_MAX_ADC_IRQS];
+	int			ts_irq[MXS_LRADC_NUM_TS_IRQS];
 };
 
 static inline u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
-- 
2.43.0

