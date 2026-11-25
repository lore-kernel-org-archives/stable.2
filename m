Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630178;
	b=w7KnIofPrG4O+y+CaU4Qgj9VVYuZD3yI7tDPNl/jyaYpmcfmID8f8l4h15G0CuuW2gnS
	 ZnLt7HzWdvznUOKjk6Wm0Cg2bh0UyU9zGDn+1mUCuo+Ktfl8NnfiRdEHpSFhwqjdm5wI7
	 k4H0hxUEJK21y+bEQHRf3wHua2ZGCF9JiJOANQrI0rBv1ipinHoXiNtCgZacxJZ1tILeA
	 s/mUPAyDKN04+vPeA9owO4scSSVzMDgxjVGNJ7Mg+ZrS+afp0AHXE22DA4tCMOCzfz+R+
	 dMB6nv5WyvrErF0hJAOi7nNDe2lYPbbSAOZXmqys725C7WGYsyqXwWk5Rkf2sn64ZTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630178;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=Z0sd2p2w8g/E6dKVKe7xrIpR79ZuVn/raKaxHWztKwc=;
	b=J145uVVWRI+MWyYakyMQid9MRsEX75msoIKA5ZY5RuKCAjdQu708B6k1Y6Ytn1fck02G
	 7qZ2cncgjWH/ndbWb2qNi+EL6OyA2iDFhMy9YoJ1xbeM6UtdcC/eTwJPxMHaZUNgfwYKZ
	 qTjXA64EclYgxGFhH//rI0QyMvQTHlov+uy6GgyBqPPBxIsopznOEHyxK/4JEbSDNrOYc
	 O07RUwcxWFtE8/LB95FU+KE21Vq/X/nLxesP2rLWmxfAMV3HE3U59au3oc0PzasvNg4y3
	 P75iW2Kcyzl43KFHA6W0877CrFYB6JtITl/iB1llWr5AJLFEqTD1I6V2XnmZ2E7gXZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=cmE66od4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA3606A321;
	Wed, 25 Nov 2026 18:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20CA3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=cmE66od4
ARC-Seal: i=1; a=rsa-sha256; t=1795630131; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QxiU+s9v9q2SkB5V5fSeHtQYYL0xGyXzmiza+Ux07EJNmbqa4EoIb+8PW0m1/QU4ZhPJ2gqKwbNClZz+vq6LzO9ukkzt+f8mY3qxm140NbD+dKwuBuDvsOcqBlStMIkmr9+ejEwkDXYUqGFbMDOWj0hqr2+jGnqGWPKb+mp5cvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795630131; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z0sd2p2w8g/E6dKVKe7xrIpR79ZuVn/raKaxHWztKwc=; 
	b=dn9J6TYq4QLMtInEef/9GrrpIPbdqBsD66bZj0ftmBXfjuF7qy2slEZa57vfvLB9DDCM1cqOKt7+7az+SZ+ALtfiCPlQlSxI1cDYrH4qHChhQhcW3U7fwZpDpNqu1PpSDQ+FdRTezBdLWeXjLNau4F/Ztq1OFpY2jFpgeKVaf9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=cmE66od48+2Ls6ZauvNgqxBjkgWf3VEC01oKWJOhvRYoNZd0K5WaJmG/XuJNeDWc9zPZ5KefjrtU21aThtXErngYR8wzePLvMi4MDxaSJHJ0xoEGD7jGYnCJI+vd9y120kTj5+KWgyyP4M8yr7TtvheK9Ij/npuTbksaXeMjh9/Oeuf8LELg1+jXpK2tt2damJoO2JFJaJniWvWMAreZWsveBm41RBRJ63gl+IXAOSCF40MEz2EBQKFzd/6fBRmZJJFQSZQ7CUZe7WXvkCT1uQzZBQlcqOU1nP36Zfz3RztXJ5+zaPOPZn83bjdpgPTYpCpj0RfU/vKFj1WtoQSmrA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=Z0sd2p2w8g/E6dKVKe7xrIpR79ZuVn/raKaxHWztKwc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795630128785648.309770875165;
	Wed, 25 Nov 2026 10:08:48 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Thu, 26 Nov 2026 02:08:20 +0800
Subject: [PATCH v3 2/8] platform/x86: lenovo-ymc: Serialize WMI event
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
Message-Id: <20261126-ymc-82yl-v3-2-e30842671ec3@rong.moe>
References: <20261126-ymc-82yl-v3-0-e30842671ec3@rong.moe>
In-Reply-To: <20261126-ymc-82yl-v3-0-e30842671ec3@rong.moe>
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
Tested-by: Eduard Aliman <edialiman20@gmail.com>
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

