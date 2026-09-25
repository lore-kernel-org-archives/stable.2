Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26F41CB31;
	Fri, 25 Sep 2026 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339906; cv=none; b=MB7NHfQbkqZ70WJgk0yRsMHknDIJ2syEL+S3fwd7NgkNTdhk5jySpueAW4dHu4YXq0OYoOICOI148Ii9QAIHw+vY3YCxK2Tl60xHQKj5nBnEcl7B2SfITYgwBC9S6mJf7nius4kA2ILo4xUyTvRxAIQsnm1qAyD8Sswk3TmqxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339906; c=relaxed/simple;
	bh=bUKM7GAj7RfmtMhTJItSx+lMXOSuuGzZWTuTo5ImD/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozBbFNWr4VkzazOmNmfjxh9cRl/IYYGM0+T6Frec1UKSA8dFL5rKORePFjsC+//n8DD7ZFAD40X5Q2y/lIwdB4Q9MOAQS6/6NpBGX43RPst1wKl8aT/W5Y3yRouFMSJP0Dz3RJx2xj9zRaKfKHW6k2LZhRGI/Q/skMYDEbmc+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ISSf/tqA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ISSf/tqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LC
	j1gS6mo+8bA9TVubBcb0q4WeEjMzjeJmbHoKOVv9s=; b=ISSf/tqANPthljrCKs
	ffTfZqWSE0PmG0mBAt382veh8FMr06CacyotBKczDtcq1Ve/dkWVExt9eZhjzICg
	76d2DV84COuDve62TY6DrqYi4bMdAy9bR36FspMFqCLtyf7jGoWtXJR7ZFImxjgG
	5//EmUXJ2DVsVCEJ8AZF1Qw6o=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_5u5arZqp98VAw--.59006S2;
	Fri, 25 Sep 2026 20:36:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <lumag@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tiny: sharp-memory: reject devices without match data
Date: Fri, 25 Sep 2026 20:36:08 +0800
Message-Id: <20260925123608.2082429-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_5u5arZqp98VAw--.59006S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF1kCF4kWw4DXr4rGrg_yoW8GF4xpr
	4xJF90kryDJFnIka1xGa1DCFy5Z3WvgayrGFy7AwnIgrnxCFyUZryxK3yYqry8JrW3GFy7
	tFnrJrWfWas2yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhoRS2q2arpTXwAA3O

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

sharp_memory_probe() immediately dereferences the returned display mode
to calculate the pitch and transmit buffer size, causing a NULL pointer
dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the display mode.

Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 7efd7b567f3b..049e98f657f3 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -557,6 +557,8 @@ static int sharp_memory_probe(struct spi_device *spi)
 
 	drm->mode_config.funcs = &sharp_memory_mode_config_funcs;
 	smd->mode = spi_get_device_match_data(spi);
+	if (!smd->mode)
+		return -ENODATA;
 
 	smd->pitch = (SHARP_ADDR_PERIOD + smd->mode->hdisplay + SHARP_DUMMY_PERIOD) / 8;
 	smd->tx_buffer_size = (SHARP_MODE_PERIOD +
-- 
2.34.1

