Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422207;
	b=DXa79jSwTcURqIf865eRiO1pvx0LNeonPyI1pgEgxkW+hVw1dwm6ial3TmfL+t5aLk+W
	 YXeSWAb7gpAKn2jstWxix3P0oJxElVIcVT0BYuzlr3b3P2jAPlQ4X67Jet6rJzmVsJjnd
	 v/X+uS9cKZI+PXL6NcHWkJHJf9VbNHwpWt0uhnFXoy0m5GQ/GYy2OW2bVgXHxB/mkzRMl
	 DQI9wLCdEC08x2ihbjKCL3xECCe/42ZmV6GjtHFuwy6UPYJbzTJf1Jacuj1+0ZPwE48lJ
	 UZkCxIRp1EAiazDK913ue7yQ2bXdi+eatMu2WXuSq8uhFLkmAjNoAjXi4//do5rWV+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422207;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=0UkI+p2KaBppYji0GomycRUpxyn5jorwQt7/VnBco3Q=;
	b=cLZl9ftc3dq4F9Xl/EonNInrfuMg4sz7RGlO5S1lsjjq56LbXl8Vl6+O6GP7cFGXIVF1
	 6H7SXE9vN6QkOrvwFP86Ds1MJENEdtv0APWnIlatFvrkanniKAfGhCgebnhbBfILTVqh5
	 9Dto1V1o865Fc6z2K/j4FaBbvga9ARJ5iob3hviy8nsdggK+WJ0L56qA/yWQxId98Vq0O
	 k6eNCBZZIj/z1KPNDrZjt470aC2iXXILtCA7jVGg5iRXFHlFfZycua6xC6PKbMH35TR8D
	 27nryaZH5NEGp9VZvstPkeV0u0HjMlVZVgWKTlR0hfhk0EqPidtSHftx1fQJUUFmljA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=i@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pJzxqwWk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C2607D37F;
	Mon, 19 Oct 2026 15:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E4C2607D37F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=i@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pJzxqwWk
ARC-Seal: i=1; a=rsa-sha256; t=1792422182; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NTCNK8fAaaUFkJGoktH/bsfTmThkZ0m5WtOpTkkfSe0j3JJTZkLdWCrykEurJKFxbnHgVe5spCP4JLvmQi9Sau0n1lQ7s4NiLYIkYiL4dMVjjSvqpH6EOzp5+stP3GTnpTBhAA3Sl9rXtdIQCOQMBn0cnGAuXOkLRAk3n/nEfoA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792422182; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0UkI+p2KaBppYji0GomycRUpxyn5jorwQt7/VnBco3Q=; 
	b=HX8GWlD/NBSM0ikdrZoVF5Pa68kVN1YVaitjnH2F0KhJAIRWLiSbXUtZPK8PaSzwjDRZyIfJf0P7RCwxDGNK9tn9jknLTJ0+bLC7EnLh0ALEtmJYPDQbpo/mxfmO9mhfMQhpXyaOiuxP9TwuaSXZRatWyV28d0UohdTsq5I58WY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792422182;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=0UkI+p2KaBppYji0GomycRUpxyn5jorwQt7/VnBco3Q=;
	b=pJzxqwWk9HJvgbQW8lNZ5hzLr54im2BVSymDHCth5qaoOBYUH5nHbn94PgVLlBaj
	XnwWjVTgHN9UQc5typjD//1Cp8GlA3rDIVk8MrDlg3m+bfYn4BS1cflZm250jPSasjK
	4DW8Lmmkj0u2qb168U+cGVj2YADKlG005JiSnbWlOz8Epozf9K0D2pkX0QVf2cVTgks
	QJ/qoH4jy4Zpw3u4VA1BlSMJ4O35AriT/6kd/jl6EJ9E9PZJ+8wsuIFGdtHPFo46luI
	63lhiGLUG7xyERZdMeB4yCAZTVgCGyJDnlhxj4zCDUv/OlWgc3BUOGoIsH1wCcPPHyV
	pA+6nve6Ww==
Received: by smtp.zohomail.com with SMTPS id 179242217902539.017621314283474;
	Mon, 19 Oct 2026 08:02:59 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Mon, 19 Oct 2026 23:02:24 +0800
Subject: [PATCH v5 02/12] platform/x86: lenovo-wmi-capdata: Do not stop the
 AC notifier chain on error
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
Message-Id: <20261019-lwmi-wmi-new-api-v5-2-71557d28d058@rong.moe>
References: <20261019-lwmi-wmi-new-api-v5-0-71557d28d058@rong.moe>
In-Reply-To: <20261019-lwmi-wmi-new-api-v5-0-71557d28d058@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Charles <hanker007@gmail.com>, 
 Navon John Lukose <navonjohnlukose@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6be7c
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

