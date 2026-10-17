Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF83A5E6F;
	Sat, 17 Oct 2026 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262600; cv=pass; b=iAc6oCXTcXEDORNImvErUNRx14k8UfY1Ab40/xY+DzJfJAktj2TJ3OpO1+bgoJ9OaVmoWE9uwubYP3Oapf558BAQDjxMDoFeAtQ1pyiQiIBdFCVPPL14I4Q7rWPM3js9UUgvoMc3SNmMMHtUQ1/UXAYWJQHi18BDoF8tv37twfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262600; c=relaxed/simple;
	bh=eiO5gm9snsDPd3SvjqUvaRPcTOldP7B0flR9rWZUp2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXVey36zYb3yvioce4yaeUAIQBUJBr+lP2J5n+xbEsyND9ncgingBJw/i15bHjxGtiltLumCs+7BZHupIDAGCmI2AdCjLuVADOGKrBz/2/dCSOqi1z3dCX7VBjkzwaCb4hHnjSrEpZ9VAy1ZbA2VCw4NmDb3AQJHUMU+uKuduUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=iGw9wGFY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="iGw9wGFY"
ARC-Seal: i=1; a=rsa-sha256; t=1792262577; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NT90/gWv89aTAdHp5xBFi9W59PDs/WPG9xEUizLJm/zsRFGdiWvVY+TE4zDi8Y8qMqeep+82LMNQdDimeVpA4dTNfHonxH1nEs28yj8FFaAYuY3YaBm5rNEVsshbn+ihDHOt4rOXS025YhaRnOY2tsWS2QTT5ADi8GV8jRUSyXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792262577; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0UkI+p2KaBppYji0GomycRUpxyn5jorwQt7/VnBco3Q=; 
	b=A0LMnrPJwjCwcXxeLp3fKyqrBTRr978NIMHHIUdUOQVg1H/S2EE+uE4HOVxziHH+vKCxWstb7nU2dFfpBD8dRm/5igWxXpiEpogKooaVSQZEPw0uP8KcWbLENkK541P5eDLmhexyhbvP17VxNRLAjnC+Q5FYcLo3GqnAdPMygxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792262577;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=0UkI+p2KaBppYji0GomycRUpxyn5jorwQt7/VnBco3Q=;
	b=iGw9wGFYINarnTCqKwhbD+ZFunMM0xANvF8AgyRDUQ38k9EdhyTAXZaGSavDd+sY
	P86bFKrx+YjdLrWETIu4EqX8l4sG7gT4Pgg6+V/g3cxWkT16sSQfmJ7qNRIpoOjlcMD
	mgAuYXZMiXZFOB6mSKqLYjOF1UYNiiWc9oBLruiOjNn9MtVVE+y41BSd3ob4VobqB2T
	huUu3k1Pu7r5VWRaS1IK0+f7laSLxT5sxt5p9fuAzZw7mhTUC82TQKWE1qEnvSGJWP1
	iu3AiyGIzwCGCuz9VR4PMGnWbGAsTgIv9l2ehM+uuFwoZ9RpKb/B2OSeobchLOKPQYT
	QFbisBZtuQ==
Received: by smtp.zohomail.com with SMTPS id 1792262576124316.56916271270666;
	Sat, 17 Oct 2026 11:42:56 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sun, 18 Oct 2026 02:42:32 +0800
Subject: [PATCH v4 02/12] platform/x86: lenovo-wmi-capdata: Do not stop the
 AC notifier chain on error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-lwmi-wmi-new-api-v4-2-aafef7956c4a@rong.moe>
References: <20261018-lwmi-wmi-new-api-v4-0-aafef7956c4a@rong.moe>
In-Reply-To: <20261018-lwmi-wmi-new-api-v4-0-aafef7956c4a@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Charles <hanker007@gmail.com>, 
 Navon John Lukose <navonjohnlukose@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-73bef
X-ZohoMailClient: External

Returning NOTIFY_BAD to the AC notifier chain stops it by preventing
later notifier blocks from being called, but our error is non-fatal for
other AC notifier blocks, which should continue to consume the event.

Return NOTIFY_DONE and add a dev_warn() on error, so that the AC
notifier chain continues. This also aligns with hp-wmi.

The function documentation was copied from elsewhere and makes no sense
here, so correct it as well.

Fixes: e1a5fe662b59 ("platform/x86: Add Lenovo Capability Data 01 WMI Driver")
Cc: stable@vger.kernel.org
Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- New patch in the series
---
 drivers/platform/x86/lenovo/wmi-capdata.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform/x86/lenovo/wmi-capdata.c
index d5e961566136..58787da959b4 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -774,13 +774,11 @@ static int lwmi_cd_setup(struct lwmi_cd_priv *priv, enum lwmi_cd_type type)
 
 /**
  * lwmi_cd01_notifier_call() - Call method for cd01 notifier.
- * block call chain.
- * @nb: The notifier_block registered to lenovo-wmi-events driver.
+ * @nb: The cd01 ACPI notifier_block.
  * @action: Unused.
  * @data: The ACPI event.
  *
- * For LWMI_EVENT_THERMAL_MODE, set current_mode and notify platform_profile
- * of a change.
+ * Refresh cached capdata on AC status change.
  *
  * Return: notifier_block status.
  */
@@ -799,8 +797,16 @@ static int lwmi_cd01_notifier_call(struct notifier_block *nb, unsigned long acti
 	switch (event->type) {
 	case ACPI_AC_NOTIFY_STATUS:
 		ret = lwmi_cd_cache(priv);
-		if (ret)
-			return NOTIFY_BAD;
+		if (ret) {
+			dev_warn(&priv->wdev->dev,
+				 "failed to refresh capdata on AC change: %d\n", ret);
+
+			/*
+			 * Our error is non-fatal for others, and we still want
+			 * the other event consumers to process it.
+			 */
+			return NOTIFY_DONE;
+		}
 
 		return NOTIFY_OK;
 	default:

-- 
2.55.0

