Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852BC435502;
	Fri,  9 Oct 2026 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550498; cv=pass; b=IhTkrBbFfavX5KE82sI0Gqq/tUFRqhfFIzp04H6M/c0d8IrqXDoTKe+q89MnNgFvqWcZDqRNfX1hPl2p0Wv2swKG09wvQXM7nXj76tOKdVQE7MU7GeYjvotTSYiEhNo6/sDg6auufTj8TiQeM6B584gR05XrzXKshI3aqdrv8Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550498; c=relaxed/simple;
	bh=67LHSnnQH70Y00/BN+Oz9e7VZ7db7pj3ZvATgr+Enzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXQGfJwTzyzP9fCr3Sj35zyKUW1Zoi7zobACIJsiF78XuM9mMNkF1MXSGBO6n2mTXsakN7uMbaRWcJQXDauh8Em0PQcjtIfbpcjeuoPjHesGygk4MRm9Y8z9RwOROSqPIzjOHNXr4NS7JcH9ELry3AO0JiH8/SOFV2Lx1hiFNwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=R626ddYX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="R626ddYX"
ARC-Seal: i=1; a=rsa-sha256; t=1791550467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Msswt/S1cP5xRjOX031hTAZSKM6YZ1Hd8PHxb6/Kzooey+Vv9wyHxOnkh9PTRHss7jl4nPgYLElFQ6V73NMGBtx/sjYGS6ukoHfCXLdgvox+gTXdzgDdka1LArjUIB3cpxoa0MxHWabQeNlsRqqurfB+kTz60ThfYMPADwAert8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791550467; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WK2/xePAavyPQ7uMEHbAlzcxOMZbodYmtYkdnaWWWeg=; 
	b=KoQx8Cs7byMYpJ3dgyl+syhgcIFVPUvnBHZDSybrpXlLs7CHUwcppGz9iUlw9dz5NB47ch1nT8X6Zvq23mbIdNNKffhHAg22Awz2FPXYVR6RdR4fbR0lV8LfRgVl0vOjG/iwIdFJN+gj3x+IotRBDzbp9gPRucqgeEOjmvuf6Fc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791550467;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=WK2/xePAavyPQ7uMEHbAlzcxOMZbodYmtYkdnaWWWeg=;
	b=R626ddYXz8DQVyVQDhbtn+khaoZXuETG1bf8DTCaIhNRodNoy0dPinDiLMq3zhA3
	QbvYowe7tSR21VR5fFoKYq5or2htDp+9vakrDs4fYfm1XUz8rNTbEOhCXnis2GfMJ3Q
	ACvYMvv7hOFlG88pJDzHYX8mUqaNapuAszJVG63J5uv71E4pN7ituEHbM2UerTR9R3N
	o7e6zSmGeFymaP2G7vgynIRvVRRx3ZKuGZv+g93Kh9oFY6PQZmm52CFsjoFUhFtxn1q
	IjjIYQeHjnCcpnEx67UhFgZ4O8QysMLmwcVEfuS/F10aVeMsyJ8QgMT4O6ENRLu2Btt
	QXgdWcod1w==
Received: by smtp.zohomail.com with SMTPS id 179155046539766.00006101887811;
	Fri, 9 Oct 2026 05:54:25 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Fri, 09 Oct 2026 20:53:44 +0800
Subject: [PATCH v2 02/12] platform/x86: lenovo-wmi-capdata: Do not stop the
 AC notifier chain on error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-lwmi-wmi-new-api-v2-2-402828382679@rong.moe>
References: <20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe>
In-Reply-To: <20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe>
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

