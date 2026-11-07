Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046055;
	b=dUYDiXhXP7pML1A6PHVvoAGeM/5i8XgPV04ioxDKwocp+pUzeEzFL3I6v9BEFNz34uzO
	 4xhz2BrUJi7t4dTCAk7GbhJacezAgdUwU/aNGDMNAMx7RF1P6CyQpzqljFsG0kxyFQNYH
	 PWvmcAnJ08lGYGKEPJioWUwYC7s0SkW/qkDt4IPpZ1HltlOOr6gXoSCvtLlYmLCtTBQJb
	 Kwpa/iib2+d+JopMsWBCmzxiVjCWlvgC5KtuUm+WYEr5qs+gvUI1Yqe5TgSeHP0TJoX6R
	 d+PcwgOjImhjPLH2FWdvS0Ylc0cKkzvwt2lRP37JESB2jd2zqEtppdxEPUuCGNE9qqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046055;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BlowYOdipRzXy3PDLlZo3B1cflb7SAji0kegcsLa+0Y=;
	b=wpS0SGdOKRl4sssm1pBmjrtrxiatki83rT7OJIeBCjuePsZySzq8q4qEU8IuIL2Gt3Pr
	 60xUzo2qE1+Vlm5Dfq0uSOSBhkuRzyqAbBc4H+d88nZ2zbcEOEokB4Of8qlq95o8DJdgE
	 xERzHA9z4LJxPtoFXU0zJ+V5Na2S94b5YbyK4Po/2dtLfvND6j77UWyJxbsGeS9In+sXn
	 wtF0AqlN28pe28MfGOKQCooRBZiBO96XGGP04xNc05ZinJFl2CQMRWW7mBDqloCwppOhn
	 qZwWtn0iPOf4SdFAteqAkNRWjBzvQYj42neBbG+6x3tgwXAVwephLAhw3NILCDmw68Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aS/DHzlD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aS/DHzlD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BB21F0089F;
	Sat,  7 Nov 2026 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046054;
	bh=BlowYOdipRzXy3PDLlZo3B1cflb7SAji0kegcsLa+0Y=;
	h=From:To:Cc:Subject:Date;
	b=aS/DHzlDRODhYUg9ZMYIQ3NFywtifJyB1dfNczn9mva4S2YXconVv2ErybKjfzy4q
	 bKlHgBqYR/PFVZkrfmzORfL0udiCFAOcAdj7H7FwrwaQkJVdQ68ISdm6D2dYdlUuhL
	 g6weJKdm1mDjI9TNA0Q7nFeV6/wW8C92/Ju22IQlPENpafFADmGq5WBCJlTIwJIEU1
	 NXiFosPGs7XlUQ3C7JnwteV6kL/OZz/L3XCLT5LGJ50kNVFNCfbGmTFc8aaeamvp4U
	 keVGig/UEzC5XHZuyrJ2bDSHwHGSt91B921+wYI4qQJr/l7pRD5727KYx5agkExR/2
	 esRL/YEk1pYxg==
From: Sasha Levin <sashal@kernel.org>
To: yaojiale02@163.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: adc: ad7192: reject devices without match data" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:33 -0500
Message-ID: <20261107050733-failed-6.18-7f7a119a370e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7f7a119a370ecf6c8d4ab9e9ee0a8cdd77afedd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050733-failed-6.18-7f7a119a370e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7f7a119a370ecf6c8d4ab9e9ee0a8cdd77afedd3 Mon Sep 17 00:00:00 2001
From: Jiale Yao <yaojiale02@163.com>
Date: Fri, 25 Sep 2026 20:57:39 +0800
Subject: [PATCH] iio: adc: ad7192: reject devices without match data

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ad7192_probe() immediately dereferences the returned chip information
to initialize the IIO device, causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the chip information.

Fixes: c3708c829a06 ("iio: adc: ad7192: Convert from of specific to fwnode property handling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d8f5886fcf694..8bd8105463111 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1406,6 +1406,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.53.0




