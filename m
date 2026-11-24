Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795544316;
	b=uBY4Z7zg4ctE6v6qXcaGk/ZVLrfHq6dyLKBy3PesOmbg8/7VuMkWDPR88PU7fvO58rBz
	 paJe58u7F5E/UUbB6Ce9oeT9Rd1PdycMa32OgWR9uYdSKQOf2mmrTt/oXwKzZM4iVafEj
	 zaHtH55eLtXt1e5koghXDYV8Fm/jyxKn5sKMNjyDJCW4emHDsML0fx3v25StZNhkDNhvd
	 qQJy1pAJ/e68r/DjLmwrNK2cio+kUY20nOdWmCQ66ifh2yUdvjvm38QTs2V539LR1OQQP
	 0YSm1EKBiRrNMoHWIwn50dTwZ5HMfDahJMQnk3zF97KwxfK7QkDvnW+wZvbLDw+HqNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544316;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=QxFNOD5lI1FgrJVbksc8scDCM7jrgscRTbGCvMXijrE=;
	b=yqZoS8TRxEJFpERli2qm0XJimj3HF74biYB3uRw/lKImK0I2gpVOE8yVRA1DacFMv2BD
	 Wy7tIUhgrD0lm7WmXL4PX8NEwMPpkebdgTnsVNIto+5d0jPjE1j0pVeQaeUBmid+cXFKW
	 02eTnBk4l7YtqBfp1/Tq335+VqQlPczR3DY7ayFnPcKbMLT03mUGzN/o/9D30WkElefEl
	 opY8B4yG+H7mSIeJuOrap/W4Ep82/B+TCbAhkjrK17RpfaoBp21JAPPaoMYxgh5T2gwI4
	 ySLd5b5K5rgv8305Lug/nYXJCM1gtUUMotETXA8WU0wANAYOVQDmiDIKDIRyZCMwrTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=IOCG+6lO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F45606A683;
	Tue, 24 Nov 2026 18:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F45606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=IOCG+6lO
ARC-Seal: i=1; a=rsa-sha256; t=1795544271; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GFLnHaygwLAVKwP9MxfLxPO1Kg70AahzzVjonsyAYWPpsXNvB9Z0VTdx5QKkU/BLgeiqze12L7Ej7M1umLZa6aA6Ng6DqgyCQTRYCAmyz8WYBjPbwpdKfd39Q0JPqdP+LevTX34bJ3acah3cFMJlao9Y2Yc4XHNwYOt9xLAVP5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795544271; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QxFNOD5lI1FgrJVbksc8scDCM7jrgscRTbGCvMXijrE=; 
	b=h6G0lmImi6aoIaxa2g85J0n5/Md2/iU28E95+d5W63TUpVPHMbRlr9CU3RrU8TfPcKcQuzsM6rP7xGsC0NkkmUMFIFgKntrcUpT1+h26CjTNDHxPyQhUo6jAJYAVJKslyl/UUEOLqp8K9Gc7xskvwM2D75gPmvgyoUHDeimSpvk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=IOCG+6lOe27hHHtHSjMF8FIBMFvtB9dYVNKeQ1cD/iMC/dH7uWK/yAVGZFTGHt+033aLf8OXC1+S6pOI/BI739k5gK+V7rdgFHxLUVeM4MVxQM3jj6f8zXuw8mPpnL0kte9HIIWpXT03x5PErjZGFwQ++Z0M5X/IYZAd3xxmNbBGiSAnPX7HMeC1sP7tz4aUF4HoOKl3mOPeeyDrSgJal+SvdrfS/jHivljsOZGQsD580axPfi5Rhy3ngIOisAcMxjai3R6SV4JprM1CpGi11JJAGuQGYqg8WrtmAUHNA/LgaAfPRVx8DPFgc+h31AxJ47rn2cMMitbByOr7QsOCKA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=QxFNOD5lI1FgrJVbksc8scDCM7jrgscRTbGCvMXijrE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795544269370734.1361204959647;
	Tue, 24 Nov 2026 10:17:49 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 02:16:58 +0800
Subject: [PATCH v2 2/7] platform/x86: lenovo-ymc: Serialize WMI event
 handling
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
Message-Id: <20261125-ymc-82yl-v2-2-624bdcb3c50e@rong.moe>
References: <20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe>
In-Reply-To: <20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
 Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: Eduard Aliman <edialiman20@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahir Faisal <mahirfaisalantiq33@gmail.com>, Rong Zhang <i@rong.moe>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

WMI events may arrive in parallel, causing race conditions, e.g.,

  CPU1				CPU2
  query: posture A
  				query: posture B
  				input report B
  input report A
  				trigger EC with B
  trigger EC with A

Fix it by serializing lenovo_ymc_notify() with a mutex.

Fixes: e82882cdd241 ("platform/x86: Add driver for Yoga Tablet Mode switch")
Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/ymc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/lenovo/ymc.c b/drivers/platform/x86/lenovo/ymc.c
index 70f3ae20d3e3..eba22600161e 100644
--- a/drivers/platform/x86/lenovo/ymc.c
+++ b/drivers/platform/x86/lenovo/ymc.c
@@ -10,9 +10,11 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/mutex.h>
 #include <linux/wmi.h>
 #include "ideapad-laptop.h"
 
@@ -60,6 +62,7 @@ static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 
 struct lenovo_ymc_private {
 	struct input_dev *input_dev;
+	struct mutex mutex; /* Protects event handling. */
 };
 
 static const struct key_entry lenovo_ymc_keymap[] = {
@@ -82,6 +85,8 @@ static void lenovo_ymc_notify(struct wmi_device *wdev, union acpi_object *data)
 	acpi_status status;
 	int code;
 
+	guard(mutex)(&priv->mutex);
+
 	status = wmi_evaluate_method(LENOVO_YMC_QUERY_GUID,
 				LENOVO_YMC_QUERY_INSTANCE,
 				LENOVO_YMC_QUERY_METHOD,
@@ -137,6 +142,10 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	if (!input_dev)
 		return -ENOMEM;
 
+	err = devm_mutex_init(&wdev->dev, &priv->mutex);
+	if (err)
+		return err;
+
 	input_dev->name = "Lenovo Yoga Tablet Mode Control switch";
 	input_dev->phys = LENOVO_YMC_EVENT_GUID "/input0";
 	input_dev->id.bustype = BUS_HOST;

-- 
2.55.0

