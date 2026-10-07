Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B346AF27
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364131; cv=none; b=T4xYdFgLgkG79x2yvTF/4pE2nJnSEWwbd93SJY4P8dI+2gcuK9Z1aG1RJaC5NVaH+FRi8Ok+0LlxenvAwFXXmWbK3+23hdpYAEqGZJjbafcIYsDuWOWKZfrtL4uPYZIk3KDJkgtjumZa11EhXyGoNNRz9uOfBucSNF5llLFT4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364131; c=relaxed/simple;
	bh=0J05XmRZUz09jTNdL4B9Dn6yGTcFuoslrnESvTJiklk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+v1qmxd8/H8g/bHEpPN4whK9CnAnsBM09khpZl6j3cqojruCA6p4F50hJD2jm6nRWC74dLehUO6OJs9qAIFXShWrYfaJuzK6vz0jTLMnxIdFExuLQeye8eEH3EY/ycyTTe3zTet5YLvUy7FmIPGk70ukZgZ84/VcEWxnb3bXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZwUQabi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZwUQabi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA4B1F0089C;
	Wed,  7 Oct 2026 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791364035;
	bh=F8wMp5UUqBpJmtyEy1gvnOq5V+dVjAWwT2vvIPQdSj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZwUQabiqedNeVNrNlywXXplkSxQt0OCrSFIgxedNMrg1EBGMdwUxJ+HYB8+T0b4Q
	 O5Ardu5sh/x6xVL3h50rn7OeBV2a+DzFx3yL6DO0E1Snu3xXoKWldukYPFOb1GyHoI
	 lSYruzArJzL0HtLfHpLI7Dj+Fp5bM/AIO2kHMhS1kznbOCWIh7tEbs4u335kpV9P5D
	 K5DbhhyZqN1WgTBIagjggsV5ENfnPgbWsdmrO51CYKiszL3U7k/bJiCBdvQGhL+/2G
	 RTLjvWr2R0M/eiiG2l9/CSpVxBWQFnCIxDxSuxdGiT/3YgDRjnhverVzApKXvXK94X
	 H8ohPl3tP7M7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Janani Sunil <janani.sunil@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: adc: adi-axi-adc: Initialize state mutex
Date: Wed,  7 Oct 2026 05:07:10 -0400
Message-ID: <20261007090651.2021301-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007090651.2021301-1-sashal@kernel.org>
References: <2026100609-decibel-passing-b1dc@gregkh>
 <20261007090651.2021301-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Janani Sunil <janani.sunil@analog.com>

[ Upstream commit 549b71ce050637dd32678371ad76c445a2f8c9aa ]

The AXI ADC register access paths serialize transactions with st->lock,
but probe does not initialize it. Initialize the mutex before registering
the backend.

Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 431b023aff3d7..2945e7ea0ae2c 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -715,6 +715,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
2.53.0

