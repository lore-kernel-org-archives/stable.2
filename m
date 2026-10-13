Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410595293F6;
	Tue, 13 Oct 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919641; cv=pass; b=R6TM6YGgqhnt/738yQqoBnzt2p1i8KAKiQpW8bzxMoI759yprypTvUXabACELm4yHh7CuzYOuFdKIR3k6N+Oj7xNg/jHZ8fQLsWK5poHVjixLhntTsiKY+JZO6+SAALcGbIzzmkBwK2M+7uPvWBBSYWag4o/w6ioZpdAjeI4GdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919641; c=relaxed/simple;
	bh=4GzbII8sIamAYawY/o7am0vulpGG42A3euUChRalJRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pms8Lcv0N1dhX0A4QmD5L0nQ3Khh3dneMwPt/7U+OmyVt/RVr4gguX18xOmYUCl6KkJ7CjfB+2mBpqTtlbaF3cos+wu0JhQFnm6lHnsm6rbZJwNEkoDh34Uc8uy2P1tq5ZJRSmdf+vJg6zetAeiBqyuUrEoV+RgdRRuoZ+COL4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=L84FIMPW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="L84FIMPW"
ARC-Seal: i=1; a=rsa-sha256; t=1791919610; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W2JkJ56cjy67tYwp3zsMJ+PSF49qDrnzM9k5cJLs2GxypdZB39MT3vtDA6KW/O/P0akSHuiLTJx6ZLjszEh2hsIqEPQ1BfmBm09rzYFh0zJMkyVgTL0W6bj2sO0dqINLS9cQ0w1mDCRjzGsfZQAMdsdK5JsuXIBw8qcNTjI2xCU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791919610; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IcPdH6CtfwpDA/3ia7xSD6GeQGC5k48vf5Dg9BV5+S4=; 
	b=gW4QnpI1PsdXaprcdV01QY3WsioGfgQJ1UzkXEzPAhNa/A+6CYwHTsI9Gf7YG4eDR80vl8RnSHzOrdXn9H0casBmGv7FAi/V86szrzt5WUHnPUIvObnxTJhHFiDNGYsGKMc7RWXOMEj0Y6T0Mh0Y4JqwwRZpVtvnrGJppkvvsgw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791919610;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=IcPdH6CtfwpDA/3ia7xSD6GeQGC5k48vf5Dg9BV5+S4=;
	b=L84FIMPWqCOacNaVzjlLETjKcYZwxJmiv+VvkYzKAqXNQqK1TI0f/r9nPCQ1+DOv
	G47k1i4uxK0TxFMUBbxqHl78y5x4n846YySBxtXQOLcxdJd0NSlorlWdkdN2aD4vfhv
	kaOXl7iwo+fWf5BTSv/l7S9L7wYxtSV2HRxOiLH8Yzod4wnTnHAuiqAmc5YGX+rMVrX
	YeOUctW3dz3mJhSoCXq61o4w+S1YXXnK6/BsIy8EUHjrWOgqiS9o6CjHtRvRm+LrvZy
	DE0KhFXsi7I8Nf/BEuP4uZ7vYYFu4K2nQY2zpNkaYRBD5p84UwcVS8LN0YM8qYVh71r
	9OcUec79/g==
Received: by smtp.zohomail.com with SMTPS id 1791919606417978.303282065655;
	Tue, 13 Oct 2026 12:26:46 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Wed, 14 Oct 2026 03:21:45 +0800
Subject: [PATCH v3 02/12] platform/x86: lenovo-wmi-capdata: Do not stop the
 AC notifier chain on error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-lwmi-wmi-new-api-v3-2-e1032bed1c81@rong.moe>
References: <20261014-lwmi-wmi-new-api-v3-0-e1032bed1c81@rong.moe>
In-Reply-To: <20261014-lwmi-wmi-new-api-v3-0-e1032bed1c81@rong.moe>
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

