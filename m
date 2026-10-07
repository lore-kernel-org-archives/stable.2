Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C873B6364
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357214; cv=none; b=SXTb1ZdIDsgaamt20eYWPvUl1MTZwZKZRoMhwtLm3g4RiTgtJw3HzfMsDi3/mEYgF1b+jfEfo09vM9NdkoSC0Nx++4/kyljKtFhvKKpR/3E/RqCB1IxvvYpXjNqmKWcPqgFeikVO6qXdZ1riAPEntDJcYjBKasZsj0Ek37wXaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357214; c=relaxed/simple;
	bh=oQ5ymwj6ZitPJ4/1OkBhNz9oKrecirznI/pOG1YIslM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPEZMJniL2WLuBQW3WQlsuYwYyh990zKd1bADmdZ3LHS/2SJpnB23QW9qtPmYfPIzavZLmVCW+li1QQdjNWGndqKRgqTyfpZxy0KYVSNIYVldQK/KjXVPd7Qz7Bpz4O3fn6GrDEQsRFo8f0pw2XMbtv387PqqPaNLybi4YWMZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXyoj2En; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXyoj2En"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8351F0089B;
	Wed,  7 Oct 2026 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791357213;
	bh=2Y0RZszvT36WBwy64ERWz29bJfIc8XgIhvMkowIWruA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXyoj2Enf4FnAzH05XJkbl4NVHh6evoTDG3LtpwGgw4kx4Ngn3rhrdE41TqvoUIoU
	 A/Cwl5VIjioaBsAtUP2XOlSPLbKRRGZsNCquzPuKKQHkPprm2TLtTY4ZMb+GZ4m5ui
	 1XhxEYlO5V9DbM4UOci+P2w+SLkSt6jFVRKK1x8/5xBVg17xawfSmS1l4zGCnEvDaD
	 XS5oxPrbbvhyt5qPNHbRyzFfe41g6QyxY3RqBLm+OWggqnaC1qoPsgyTj4F8Fsx2aK
	 Q/DhE9r/gKCquBFURuZoGI1+xZhgnMDhOojlD4Yy8jFqL2/aihAIaEbfjijfz/TOxg
	 bwDHCpIwzA5JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: axp288: Add TS bias override for Haier HV103H
Date: Wed,  7 Oct 2026 03:13:29 -0400
Message-ID: <20261007071240.1633399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100612-reminder-crewless-509f@gregkh>
References: <2026100612-reminder-crewless-509f@gregkh>
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
[ sashal: Adjusted context to preserve the existing `{}` DMI table terminator instead of `{ }`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/axp288_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 8c3acc0cd7e99..9cfe2e8c8484a 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -207,6 +207,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
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

