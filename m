Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047433;
	b=utvVb6igDOG/594GxApsJ8uv6VgB3gW1LLfsnzmudHmB96HudttmE9TJC1sEZmkQnNuY
	 SaOqWmPQS72VZuvzpmGTVF+PHeTV3mmKYz9+QU/IfNCT+R/hFQ6DYQqDehHyfUx5Bxb9I
	 o951FURyvU4TvFQVa1tBe/Z80YQK+gPSvDCmUV7k+FJhXcG7lQI7yz+nG8v6878jiHsgi
	 Uk3X8ASFcXf9azP9YnjF1oX6wVIVE8WdtcPu28d+szXBfI4zcrAda/oem2NJ8VUJb+p9G
	 /5XHEnAgjJ4OxhN5jt43BhiQDK0D2wJOxt5CAO/rE6A8ZPUH4p2YlMgu9jbZUo1EV3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=StZ4eUJAj7hp09U4zhu6WHF7pv/AOCxS631dXesu5mk=;
	b=s0cJw01+hYYgg2n3tDb/iCFzFenesKiadg3XdDMKKF9/vQobAamm5v5pUReU6VYWowwp
	 3+Mv4vV2pSaXA1PSQtarzDQ7XINc1VJ0tfL/uo0LQSg4r/420/mrgQbfmZxE7QhoKJNz6
	 th+UZRNWPTdTSlmOVV8Nwgc86z/uGA6/9osWKOjAe3XTCVhuPXElaGQFMX/CaNCgltY+t
	 M58NVqPgpaTRhujO87iWSIjeV98BI8KVmOr/mYV/AKGgZcde8WDNBqgQ7+KgX08j/aE7b
	 NDTnaB3UeqBgx5FngFM/F13yrYsd0Yyktp5Hh1Igqj+MS5IofcCs66EPBCDNsecwv0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="adn1ZV2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FB606A33B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adn1ZV2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9A81F008A1;
	Sat,  7 Nov 2026 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047432;
	bh=StZ4eUJAj7hp09U4zhu6WHF7pv/AOCxS631dXesu5mk=;
	h=From:To:Cc:Subject:Date;
	b=adn1ZV2/Pek/t//q2S93QgO+vwtui76r5EsLBRfn+G5spS7OI93dlkKCofoCphp4p
	 D3olyMKYmP8Z0uRVXEL81wFb7Dqs5N1kd+dtSJD+k49vhrxVHS1iZ5QtrBdgc1ORF5
	 s4UNO88gWv6lZSUqKXAuK5UYnw7hLlMdAtvKN9Uwcrm0rEeCNBVDJnREY1SyhumBU+
	 +kQvJqIdf1vPRXinYdh033xWsZWmTYSkNjIWifSxgAhpPZy15S1V9sj1n4Xop7FObr
	 UvIp95R6t6CJwHej3Fe1dTZtpohlNmPGbqqgUhIczEFiIWVTjleE7DLFIP9dkyjl0r
	 Ib0JY3r3E5lUA==
From: Sasha Levin <sashal@kernel.org>
To: yaojiale02@163.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: adc: ad7192: reject devices without match data" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:31 -0500
Message-ID: <20261107053031-failed-6.6-7f7a119a370e@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7f7a119a370ecf6c8d4ab9e9ee0a8cdd77afedd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053031-failed-6.6-7f7a119a370e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




