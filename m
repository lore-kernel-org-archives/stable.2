Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095670;
	b=ff2nLNbZETFfYxWm7qiOxo0zan2gXAeS9Mnb1CR9g8HHupAnV4ZhJIG9CgWv1sVAsDUw
	 nu9N39Y3P9rPcRyCgTAVb94Xh56fz/pVWkf080NUpwoC30CsiCuXZvjq9tTCKwZ3OFYvS
	 ZUwhYQPRS/darcsPbRK0GmCnGoKCf06Ikrk9ARBTARkdJD5P1FM5mJMGp8h92EbYolTqg
	 8WsrN0XI7sLu7/GsKvk1LtVLxM3yQm0wTF2zLEDBZ6PoUDgdUkzKuyoGwZZB5xUXCz8mf
	 XwwwwsvVlGCv7ey3RgppPh6P0iUcvT6diGhoMsuwt9jeIMW9VgvH1B73nsoDjlvQVKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4eg3MzMz3s0AXHWCLO8iv+So0EnkURZvsGiXUFWNdW8=;
	b=OSfipq+zx05EqpfJ5GmRMrgTcFEm1qTyDyvMBkY/uPF6alGjRDsy39JivXsC5VoAtaNh
	 DdlMERlAtJwscQqfaxBFZfo7r0ZtG4U0zIheUxpOgpbsysYgwuC8cKzBJyDPxU0H91tFQ
	 0aWG1f/hDCvG/C2c8tij2SqAwITvycS/qHiCXJTZY6lJmJ5qciupa/dohL7xMfpA+G5A9
	 PhzCH54TdpHTxgaqd9c1JQ4MaTQGijlExrUsXjK19x6RX15Fhl9yGWbDn8rdEW3yuz5Q8
	 GfIyy6dS6HLfTJY9y1Axym9IUuAHD+pC8yGCe/CWo4/LRy9El0wv0m1hlHok3+9NEOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vW2zrRe6;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877C606A33A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D877C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vW2zrRe6
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc81984fceso854408137.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095669; x=1795700469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4eg3MzMz3s0AXHWCLO8iv+So0EnkURZvsGiXUFWNdW8=;
        b=vW2zrRe6xtNvO0adxHnrjiJ5kkXbhEjpfO28DfKlmGVVzVaCULXQ1zb2+pSfnE1zdl
         RDBlE1Q/fvFqgWd9h2+0mPG+nNSYFWThvqpP1c0ZgtgCNRiZxTlr5v6yNqTsHPO3y3ZG
         vVBws669lmUvni+nfqQO8aLofKqYP5tEjeaYVjnkd2PqI0iFY7EQL5I9RYL/t3054gwE
         e3PIumEfqiorSp61ZHG0SR2Pdj29HoJdg/izuxpRNqZ+KpU0J/ZTNaoPLfhakFhhu7dX
         o1TpBwJGiI0ilLnwMM8Qy3UfZpbJapIvtDQwaLDFaa8m2kTmxkxyQW3gMYeRZSl2okIv
         g1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095669; x=1795700469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4eg3MzMz3s0AXHWCLO8iv+So0EnkURZvsGiXUFWNdW8=;
        b=v3JjcPrUPpF2Ev5UFhhEWpngZkcv2Vkvv0sESOMMIW3r8eYXve73IBd6ebcQbaKzog
         V1eGpIlELwNYxrmwCSiWiTAO7nMmyXmv00veY3Poj2i8lpyIIc1WCy7aZgZYF1zheJtA
         0BnM+67hIBv4qV5h4zURIDxW7gE6PfxA/NpWfDZlyZuiGDU73XLV6xTTW1wxY1pr07h2
         5Pa8vMoVScYwwkfvx4nzZex2B0hBhervaobgd15zhSh+6GkeSukLlT+CWPkwm4gcORDz
         oL89APvNQaG0OxIeT6Q5XdSdKhMgqwUWCGesuhDJ8JHgB8G5xXbcmek3SLxn3y++lO/t
         LtPw==
X-Forwarded-Encrypted: i=1; AL+hErHGzMtggPNQps3eePtsu1cUZXFNZx0awhkxnlYU/dTA9JantnTkIXrow5WrxDYw8JJuR99swIQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8seZILR074heVZnO5ZRCZZ8uFa4viI6HMhfprkSCscZMzxsZ/6
	E4bWDPLRThIhT/WsPb7pjQ5h6ketbUDKBSxURVNHHZv1u35zhbJjwfn0
X-Gm-Gg: AYBFou08s7DnuAtk56+3HEO6Sl63zgLqYPe2arCJcJcUW20JJxm9HbsKD66uIPnPSVc
	sGdvZEgrQjYWAhLSAJS1lwNMMflH3p1kGgSM9aLHTmmxlZzSd+8F941uSmn9Hmi/GOK106VJTqI
	ov0SfDtbnXV+vfI5kvHkSQYBbN+T3FrmH0UlHGcvKmbgAzGMNk/mx3ODhwyyjBw9rcpqChbMKOm
	1PnapoOmRr6AoxSULopv7muouUQGorRci8wPxT0BuqFmULaB0YNoyeVZbxUM2PqHGztHDGB6v+m
	Kyuzj0HutDGLuwS0Ou6IEGaUCjQrdld8aQN2zhyvNWu0KGZw5WGop5+tcqRAfqsSvuqdBjbXT8q
	/NZ4YWAt4qZgWpjC70MDbAGrhKwcIWQMRqNx3J3B6n8tUJOV3H6Si96MbGm5SExMAub0tcpRV05
	rCQQZLAfUuKNfZJLxOrkIEdwSTOZoaPz8/pu+kmJ//+GAqKJ8Rx+OnOIB3LLSHBn9eO9F0Ge1rP
	6qd/PbRZ32wkdJYJrS7q9S/9MlVGAv6Dulj0C+BeZiErPw4zlhS4yELpy9Efv0jAEEsssLFGHR9
	4xhHYV73x8V6rUtDm5KqBMoPjz0GSOV6KdyUq/z10iAWlF8OXxVJihtw69EsNzWV1QXFAT6hAkJ
	eTPKSKsWgB2MKtdrwG24=
X-Received: by 2002:a05:6102:3754:b0:7d2:9f38:c45 with SMTP id ada2fe7eead31-7d6ba3bbfd2mr1955603137.8.1795095668639;
        Thu, 19 Nov 2026 05:41:08 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:41:08 -0800 (PST)
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
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 3/4] mfd: mxs-lradc: Pass parent IRQs to child drivers
Date: Thu, 19 Nov 2026 10:40:40 -0300
Message-ID: <20261119134041.16611-3-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
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
request the mapped IRQs directly. Map the MMIO region once in the
parent and share the mapping with both child drivers through
struct mxs_lradc, removing the child memory resources.

Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
touch events are reported, and the touch-detect and LRADC channel 7
interrupt counters increase as expected.

Cc: stable@vger.kernel.org
Suggested-by: Lee Jones <lee@kernel.org>
Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Changes since v4:
- Correct the commit message to describe the shared parent MMIO mapping. (Sashiko)

KASAN is happy now after unbind/bind:

echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind
echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/bind
echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind

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

 drivers/iio/adc/mxs-lradc-adc.c          |  53 +------
 drivers/input/touchscreen/mxs-lradc-ts.c |  35 ++---
 drivers/mfd/mxs-lradc.c                  | 184 +++++++++++------------
 include/linux/mfd/mxs-lradc.h            |  12 ++
 4 files changed, 115 insertions(+), 169 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 64dd3a9995ff..989ccfa4ec00 100644
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
@@ -690,10 +667,8 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
 	struct mxs_lradc_adc *adc;
 	struct iio_dev *iio;
-	struct resource *iores;
-	int ret, irq, virq, i, s, n;
+	int ret, i, s;
 	u64 scale_uv;
-	const char **irq_name;
 
 	/* Allocate the IIO device. */
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -703,14 +678,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	adc = iio_priv(iio);
 	adc->lradc = lradc;
 	adc->dev = dev;
-
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -EINVAL;
-
-	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
-	if (!adc->base)
-		return -ENOMEM;
+	adc->base = lradc->base;
 
 	init_completion(&adc->completion);
 	spin_lock_init(&adc->lock);
@@ -725,28 +693,19 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
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
index 2970d9eb9c2b..25280f056fc7 100644
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
@@ -616,12 +609,9 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 
 	ts->lradc = lradc;
 	ts->dev = dev;
+	ts->base = lradc->base;
 	spin_lock_init(&ts->lock);
 
-	ts->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ts->base))
-		return PTR_ERR(ts->base);
-
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
 				   &ts_wires);
 	if (ret)
@@ -668,19 +658,12 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
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
index 30a66e268169..aa55f88399ef 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -20,10 +20,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-#define ADC_CELL		0
-#define TSC_CELL		1
-#define RES_MEM			0
-
 enum mx23_lradc_irqs {
 	MX23_LRADC_TS_IRQ = 0,
 	MX23_LRADC_CH0_IRQ,
@@ -52,92 +48,117 @@ enum mx28_lradc_irqs {
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
-};
-
-static struct resource mx23_touchscreen_resources[] = {
-	DEFINE_RES_MEM(0x0, 0x0),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
-	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
-};
-
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
+struct mxs_lradc_soc_data {
+	enum mxs_lradc_id soc;
+	unsigned int num_adc_irqs;
+	u8 adc_irq[MXS_LRADC_MAX_ADC_IRQS];
+	u8 ts_irq[MXS_LRADC_NUM_TS_IRQS];
 };
 
-static struct resource mx28_touchscreen_resources[] = {
-	DEFINE_RES_MEM(0x0, 0x0),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
-	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
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
 
-static struct mfd_cell mx23_cells[] = {
-	{
-		.name = "mxs-lradc-adc",
-		.resources = mx23_adc_resources,
-		.num_resources = ARRAY_SIZE(mx23_adc_resources),
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
 	},
-	{
-		.name = "mxs-lradc-ts",
-		.resources = mx23_touchscreen_resources,
-		.num_resources = ARRAY_SIZE(mx23_touchscreen_resources),
+	.ts_irq = {
+		MX28_LRADC_TS_IRQ,
+		MX28_LRADC_CH6_IRQ,
+		MX28_LRADC_CH7_IRQ,
 	},
 };
 
-static struct mfd_cell mx28_cells[] = {
+static const struct mfd_cell mxs_lradc_cells[] = {
 	{
 		.name = "mxs-lradc-adc",
-		.resources = mx28_adc_resources,
-		.num_resources = ARRAY_SIZE(mx28_adc_resources),
 	},
 	{
 		.name = "mxs-lradc-ts",
-		.resources = mx28_touchscreen_resources,
-		.num_resources = ARRAY_SIZE(mx28_touchscreen_resources),
-	}
+	},
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
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
+	const struct mxs_lradc_soc_data *data;
+	struct device_node *node = pdev->dev.of_node;
 	struct mxs_lradc *lradc;
-	struct mfd_cell *cells = NULL;
-	struct resource *res;
-	int ret = 0;
+	struct device *dev = &pdev->dev;
+	unsigned int num_cells;
 	u32 ts_wires = 0;
+	int ret = 0;
 
 	lradc = devm_kzalloc_obj(&pdev->dev, *lradc);
 	if (!lradc)
 		return -ENOMEM;
 
-	lradc->soc = (kernel_ulong_t)device_get_match_data(&pdev->dev);
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODATA;
+
+	lradc->soc = data->soc;
+	lradc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lradc->base))
+		return PTR_ERR(lradc->base);
 
 	lradc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(lradc->clk)) {
@@ -181,44 +202,15 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lradc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENOMEM;
+	ret = mxs_lradc_get_irqs(pdev, lradc, data);
+	if (ret)
 		goto err_clk;
-	}
-
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
-		goto err_clk;
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
+				   mxs_lradc_cells, num_cells, NULL, 0, NULL);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"Failed to add the touchscreen subdevice\n");
+		dev_err(dev, "Failed to add subdevices\n");
 		goto err_clk;
 	}
 
diff --git a/include/linux/mfd/mxs-lradc.h b/include/linux/mfd/mxs-lradc.h
index ada3d81ee277..ba90bf174ee8 100644
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
@@ -149,18 +152,27 @@ enum mxs_lradc_ts_wires {
 /**
  * struct mxs_lradc
  * @soc: soc type (IMX23 or IMX28)
+ * @base: mapped LRADC register base
  * @clk: 2 kHz clock for delay units
  * @buffer_vchans: channels that can be used during buffered capture
  * @touchscreen_wire: touchscreen type (4-wire or 5-wire)
  * @use_touchbutton: button state (on or off)
+ * @num_adc_irqs: number of ADC interrupts
+ * @adc_irq: ADC interrupts
+ * @ts_irq: touchscreen interrupts
  */
 struct mxs_lradc {
 	enum mxs_lradc_id	soc;
+	void __iomem		*base;
 	struct clk		*clk;
 	u8			buffer_vchans;
 
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

