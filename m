Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5ED364EAB;
	Sat,  8 Aug 2026 02:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.82.102.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157175; cv=none; b=NUjqj7ROOOvfZvhfjJUzboF16nWhW6Foy9ZoTV1WYPNmNU27/ZXzX9OidHH3osRmSe6DhCsH+3hyLaR4/CvybqLilFZ1rSIsjH48q/LxwPlyMvto/8jB1atBd8idSrYFaK/BjKsEe4IsEJdppaxRwglSVZ+i4A+WlaJZkv4jolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157175; c=relaxed/simple;
	bh=TtaLkog6I66g6v4MH+dZ40tuxTnXZ/tCxB3cXkkNyBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u3p1nPx3SaveuZp2WjN8g7QcCflkmVq3uEQVJXU4Rd3yEbrL6wRpeBXbjbQzOp65tU3jdmvTzGCivSEvYtDrrogtT1SpeDUxU71Kmx9/BiFbcpc9CTRLTBS75hGCEPzfpB5rZCHkhgihORa3SprxvN4edS+KZ0KTtbbCFZBOVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=holtechnik.com; spf=pass smtp.mailfrom=holtechnik.com; dkim=pass (1024-bit key) header.d=holtechnik.com header.i=@holtechnik.com header.b=lLIiWtk8; arc=none smtp.client-ip=35.82.102.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=holtechnik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtechnik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=holtechnik.com header.i=@holtechnik.com header.b="lLIiWtk8"
Received: from localhost.localdomain (192-184-175-24.fiber.dynamic.sonic.net [192.184.175.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: phollinsky@holtechnik.com)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id 28F6247CEE6;
	Sat,  8 Aug 2026 02:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holtechnik.com;
	s=default; t=1786156797;
	bh=4IMInZ+M2f7yXs+SHa9tJ8pApnmxuMXar7MxhiEiLw4=;
	h=From:To:Cc:Subject:Date;
	b=lLIiWtk8GqC85QqdZBbXaCqNan8EgY/melK5+NzwGmFVbLs06rv4zA4sKWExGG+1z
	 ZeBsdhiLKlQxus+C6VEjC82j0bbdBpjDDpY5Mek9wWRD5+oDdqGUbs/pRjkQS5r+YR
	 9Qt89bS1K45OvHHi5evhFby4mV4ti54lNfvDexlE=
From: Paul Hollinsky <phollinsky@holtechnik.com>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Paul Hollinsky <phollinsky@holtechnik.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] thermal: qcom-spmi-adc-tm5: fix all temperature reads failing with -EINVAL
Date: Fri,  7 Aug 2026 19:39:37 -0700
Message-ID: <20260808023938.57146-1-phollinsky@holtechnik.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

adc_tm5_get_temp() rejects any iio_read_channel_processed() return value
that is not IIO_VAL_INT. Since commit bb21ee31f575 ("iio: Fix
iio_multiply_value use in iio_read_channel_processed_scale"),
iio_read_channel_processed() returns 0 on success, per its documented
contract, instead of passing through the value type from the underlying
read.

Since IIO_VAL_INT is 1, every successful read now takes the error path,
so get_temp() returns -EINVAL unconditionally and every ADC-TM5 thermal
zone is dead: with no valid temperature readings the core cannot
evaluate trip points. Observed on a SC7180 Trogdor Chromebook (Lenovo
IdeaPad Duet 3 / wormdingler), where the charger and skin-temp zones
report an error on every read.

The check no longer serves its original defensive purpose either: since
commit 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale()
precision"), fractional value types are folded into the integer result
by iio_multiply_value() inside the IIO core, so the return value carries
no information beyond success or failure. Just drop the check and rely
on the ret < 0 test above it.

qcom-spmi-adc-tm5 is the only iio_read_channel_processed() consumer in
tree still testing the return value this way.

Fixes: bb21ee31f575 ("iio: Fix iio_multiply_value use in iio_read_channel_processed_scale")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Paul Hollinsky <phollinsky@holtechnik.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index bb6222c8cc5f..af72db6299cd 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -369,9 +369,6 @@ static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (ret < 0)
 		return ret;
 
-	if (ret != IIO_VAL_INT)
-		return -EINVAL;
-
 	return 0;
 }
 
-- 
2.55.0

