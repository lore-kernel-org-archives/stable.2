Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794770909;
	b=yKFoqrlrpAh6qNz+ivUovm9cYuxdimkpAWcQEfv+Gh8TCer3CpW5BYfrmaPZapqHT9U1
	 lNNghbetRtrS0G36WdRTY3tZF27Tm+CjvO+pUXfUCcbdrBouqbw2BsbCJywIUiMn62O+Q
	 Nwgp+ZTiXUBE5z9Hc8syttgsHF0KvkmM5xgyJuDl+pb1oCsO7sObyU5X5Hy/TdSv5vNXV
	 rnqjhUZ5dYDWJP8vzqVm+Uyl7RY/Jfw4L882yciKRYWPd2jQKyHkAyPzywEE+i/jZzIlW
	 61op/XKyRsAgDjP0eA3Ms1aK0WuOII8eYRqmSnu5oYfG2OWDEgHsAhG86CGQRl6lAjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770909;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=UOdzf68upyWQEY74y7UPNoTUyYjNf3ubgd9Hck5dWAM=;
	b=haT+Z/W9BqkwTL1x6ZPCds5nY8CAIvf0iw084dezW6ba1sRLduW6YyciRewT9UkBJHAv
	 usIdHFS3lhAppWRJKQzg1ruKk6KJ4KGqg2CYgf6vyxmJ2uwy9D5Zw/nASDPElrtng5YCE
	 g9T35RqTCMOD+HlE5UEBjMupcquKFmwspu5LqVE8fJyMt+zCbDMp+2/l25kQmYhZDMvbZ
	 RTuhWpLRB4hVAdFswOLYeE9NsEIQWdGjjFO8MxT0+YLnxKBYEKvgfFknQPQ5Qeg0Sz5R6
	 m7GcdtA7zieuGO+PMRiM/z7mOqUVLuoDmhgOe1SYZuMqoUNrE8zYNN7jOEN/D2jrayg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=QIO4lf+B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8BF606A338;
	Sun, 15 Nov 2026 19:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8BF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=QIO4lf+B
ARC-Seal: i=1; a=rsa-sha256; t=1794770883; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UUxsCUBEa6m6mkEe0uWPcXvDchkQzosFE/KivROKt4et3xYeaY9B2GpPqIDBaTOIq/RQJ2K+3ODjJBigmn8JIvWqtP8fOBhBqiDR5Kd23vkR2VOzHAEMZVV2fu+9ysD5fbvjtoUfk16xnIfi0xrSPKJNxdYcdsByIFRogb2Z9lY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794770883; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UOdzf68upyWQEY74y7UPNoTUyYjNf3ubgd9Hck5dWAM=; 
	b=GCd9WdF/Icfk0wwdVWM9OZ4bsP2AGnfFA5MJymiNVQ3QkuMNVe9GRhRNr3LF5oy3zmTm4mJB4x5RcGGmM1ctBcowBePdF1imhQZ21m6Ot37B1bSjjq+fcO2g6/KrV6y/NcAWolSvhTR8dRma7JRGPamb13XuyGuUrZjeZZpdoB4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=QIO4lf+BAKr7/0ApAn9LLax1t+lisQuPYDbsP0AmFtbTHHRyxj58zgpXAtJvpAkPBSoZcAIm1m4DJ8m1DnXsNZmbWE0uyWHmLLup/p7qN2AW/REbFeZ3EPfVO7Nakq5JkwMvgEgFtIF977RUfgu+a3EtUWMi9pLIe9WiIg3oBVb/W40kXvWhqUJmCGrT0HFiO9nS2fC6JypaNOMRrTcoJ//XKONqhUnHE55tMwPFLAyC7+9T+cuklvyEqjUvCMbdoKnwxHOnh9R5tWTfDAXyxwfQjzS38QzTBZGhmgJTTiHvHLeceuwYpjgEOQR/ZyP4RvQoxL2roDANZKRjAHkIYQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=UOdzf68upyWQEY74y7UPNoTUyYjNf3ubgd9Hck5dWAM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794770881105493.91694378790714;
	Sun, 15 Nov 2026 11:28:01 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 16 Nov 2026 03:27:03 +0800
Subject: [PATCH 2/7] platform/x86: lenovo-ymc: Serialize WMI event handling
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
Message-Id: <20261116-ymc-82yl-v1-2-fac1a2b01a84@rong.moe>
References: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
In-Reply-To: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
 Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

