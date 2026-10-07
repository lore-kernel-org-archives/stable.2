Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA54392823
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362371; cv=none; b=Fi7s5vg9SkzLbD3a3mTLWEuaU5eTgNkOa+OKEssI41qYfeHWwc81z+cDE7uO5F2Y2GnzZeRwN3mrecI2TOmJOpDjfdixFX15RWICcXX79uU+AVLQpSuhFgDkzsJSQaDCFZU/bA8sxTx83DFam9ZKgUJ2T7huJN59mxAXven4enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362371; c=relaxed/simple;
	bh=J78Livoq57GJznvlVhJ6buA8sr+ExYnbzwoQ+v1WUJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzCbff24i1ddn4TtuTZJjKTnePbMEtMbriWLaltClJVzCCc2fIWVHyL/AL0MV7lN/8ecn3i2LPm38eTtEvOdZUCkuUnIOAN5dXJngCkRl9iXf087HoNfx2+cyMN2XEL8n1DdmlTFcBn3GK2+DSdb1NGwvgGaMEIbjhOH/SfMoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgfr8DKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgfr8DKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE421F0089B;
	Wed,  7 Oct 2026 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362368;
	bh=gvsd6ddXs0jsldeBP71+VfaHcemL8EzvwcmdFAESn6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wgfr8DKveNQPfg0PIRfuoDS2Of8yF8q4ewy3mzqD1gdPRXi8kqbNTGd3ctyr2Onn4
	 QIbE5ZCvKi4r+qThoIuzBn42ReXcQmF2huOz7y1zFfYBrqXlq8WB+Cblc+8MO7gETq
	 vk61SL9YnrQZXDcL9nE+PNXaiB/hZWSXBOP59cuCHVMGm+u4hWqT8T1LSraXinYH/7
	 RUEAGux32/sdLQpkSG6e67sxRoQ8KZg6PZroi7OCgAtp6Mc4lt/Q1FBYNOwZ+5nLSj
	 9KwWCaoU+ED3P2R6GyfZlpXqobQkAQu7u89mUwWdr8W1RzKfb7fWWy9d0APM1pqHn4
	 b0eXsJnZStNfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: adc: axp288: Add TS bias override for Haier HV103H
Date: Wed,  7 Oct 2026 04:39:25 -0400
Message-ID: <20261007083727.1943692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100612-suitably-cruelly-83ee@gregkh>
References: <2026100612-suitably-cruelly-83ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>

[ Upstream commit 0f300db7b7315b2c7ea0e2d4437b88de162d191f ]

The Haier HV103H firmware configures the AXP288 TS pin bias
current to 60 uA. This causes the battery temperature reading to
cross the charging temperature threshold under load, incorrectly
stopping battery charging.

Setting the TS bias current to 80 uA fixes the temperature
measurement and prevents charging from being incorrectly disabled.

Add a DMI quirk to use the 80 uA TS bias current on the Haier
HV103H.

Fixes: 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling")
Fixes: 048058399f19 ("iio: adc: axp288: Override TS pin bias current for some models") # Add necessary infrastructure
Signed-off-by: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Adjusted context to match the existing {} table terminator. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/axp288_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 580361bd98492..3ccdfe9dea3f5 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -204,6 +204,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
 		},
 		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
 	},
+	{
+		/* Haier HV103H */
+		.matches = {
+		  DMI_MATCH(DMI_SYS_VENDOR, "Haier"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "HV103H"),
+		},
+		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
+	},
 	{}
 };
 
-- 
2.53.0

