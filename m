Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFC416860
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359133; cv=none; b=LWH7OJj91a2lDb+tvZWHvKJQ9By0VWuLSNZnGRWQzz29+wRFNLqsPKY+j0iWJJ0udhyb4cSLI591hvHGPtUotxCAtnUhSobkzieShBIrtxINcnqawQ9ty6M2f8cHAzcZ033aSqlmUA6Rsjip+m2MnMtNhiYFzeESC7UGKqVxtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359133; c=relaxed/simple;
	bh=HqWq8i/0bV4wgv6r4UWN8emiGH9RY/0p29dWRBWDCbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2sOpXR/N0WYq+hskjTg2PlP9g3vvQ8ftiBkY+58FWzGq35viLYP9PW8PJ3pukokmfVIZzeovnxL7efLQAf83pJKbnnI1I18pW77V6xC6FiZcjn8IPRIUFFwr7VmaYYG20LpSe28AUUGB6FYE6UvJOxAfNRx113r2G0FdGEkAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIBF5Zpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIBF5Zpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CA61F0089B;
	Wed,  7 Oct 2026 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359132;
	bh=P1zQirGMQeh1wduMVX2BgAihUzb3HCwEqDpZd34sCnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NIBF5ZpweYdN+RlYurNR7bMLrtV4WIuGpoRGDMPMmXQeGxHGR6l7mX7cf4leK0Ipt
	 oaN9Cygi90s6cBflhjEYt87fmsLSJ2OYRr07i+WBdDZVlg09yKStoKbuT/X6hQ1ewj
	 yAo3dlXKVOwi4Il9hdFmblMEFUAmem13xS8Egfotq/oIrdb28IJFOA1FgowhfBcy59
	 Oiq/veJeE72BmWybrx9WEWl0XWW/0sO5c3vPpf6CXmZ8RB8ZrMRuNMIgfvOiaTS+5F
	 SMiPFFPiKbabNF8TB/dZoVo62YLjRAMqL+z2zg1dKJzTfQrIiGHJrwEjRzImznZl4l
	 0xv0jXEx3RLKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: adc: axp288: Add TS bias override for Haier HV103H
Date: Wed,  7 Oct 2026 03:45:29 -0400
Message-ID: <20261007074418.1744094-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100612-vanilla-wages-9fe4@gregkh>
References: <2026100612-vanilla-wages-9fe4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ sashal: Adjusted context to match the DMI table’s empty terminator formatting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/axp288_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 49fff1cabd0dc..3b7612dcaba6f 100644
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

