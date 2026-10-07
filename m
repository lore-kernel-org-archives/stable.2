Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A940EB8D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362527; cv=none; b=Ke2ZC9c9s/LCeiRo6hS0JllaTvcDNMRw+xPGvUr4z11WX3YGSZcwIH5BDCwOJaBUDDDG0VkNGQd8zs24vaSh0sWrSVyphGM1tTEsibEk5z9r6p9g9Upyt6ebqI8oWn8a4TGP3zBsni3xoqZXAd26WwD3IAoejiQSwWt3KJ35csg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362527; c=relaxed/simple;
	bh=6P2S2uWgl0lDCpyT0FItESVgyinvAn+CEU6hYqWr5KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DajuO2TwgaAUvWyk12bDs6WGa/fePEX0Y1bVOtklaqMkBp2uYVNYiHNga0z4tqYGR9zvF0u3ozukciBow/J3ADRQYTCBwYWRU+4wNJbT/4Ks29tsU9x0xW94pv5aIJaVBbaIuQZa8TITWepsGPngKwj80N1wGrJQpkPFsyVkBYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B808F2Dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B808F2Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3514E1F0089F;
	Wed,  7 Oct 2026 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362525;
	bh=4XQqtc1/pfaOzH0ihOmAhSIVvsDeaY/hPQN0zcmfJXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B808F2Dl3gHwj2y1Ulk/oSlTF0JV2j6MtaidLqUxax0k+XlV8cyntET74YNDT7WWO
	 btSDyJkWPZ7xkLUAhT7RDfo8Ldwk2eLSxinJKkSTZIz26Vp2bmCz7bPlVKrEwOPH6H
	 TMGDe7szUwPCAcY7TBd8vq/2M+WFrCU6LOys0WR5ssrwq/1zY/LcgNXIG8Kd/1vTyL
	 oov+0cA481zmiAfRh61BjC60bCjTprBvrPmhFko+FOJ6ZETU3RGK1Wi4MhTSiGnqGC
	 IKOITBnTLMjUYDCzLM/TDHsSWqcFiU+zJ+TW6FGkhcbw1uSIhw423oIlcZTbxZ0p/X
	 NBKqfHwOZfSaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] iio: buffer: use struct iio_scan_type to simplify code
Date: Wed,  7 Oct 2026 04:41:56 -0400
Message-ID: <20261007083721.1749559-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007083721.1749559-1-sashal@kernel.org>
References: <2026100618-wooing-curve-b2f5@gregkh>
 <20261007083721.1749559-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 7758562898033a3bd98a24d2a541c930b0fc98e6 ]

By using struct iio_scan_type, we can simplify the code by removing
lots of duplicate pointer dereferences. This make the code a bit easier
to read.

This also prepares for a future where channels may have more than one
scan_type.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240530-iio-add-support-for-multiple-scan-types-v3-2-cbc4acea2cfa@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: f0ea4824deeb ("iio: health: max30102: fix NULL dereference in interrupt handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 48 ++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 29b073698636e..c21ced54b7297 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -367,7 +367,8 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 type = this_attr->c->scan_type.endianness;
+	const struct iio_scan_type *scan_type = &this_attr->c->scan_type;
+	u8 type = scan_type->endianness;
 
 	if (type == IIO_CPU) {
 #ifdef __LITTLE_ENDIAN
@@ -376,21 +377,21 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		type = IIO_BE;
 #endif
 	}
-	if (this_attr->c->scan_type.repeat > 1)
+	if (scan_type->repeat > 1)
 		return sysfs_emit(buf, "%s:%c%d/%dX%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.repeat,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->repeat,
+		       scan_type->shift);
 	else
 		return sysfs_emit(buf, "%s:%c%d/%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->shift);
 }
 
 static ssize_t iio_scan_el_show(struct device *dev,
@@ -689,12 +690,16 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 					     unsigned int scan_index)
 {
 	const struct iio_chan_spec *ch;
+	const struct iio_scan_type *scan_type;
 	unsigned int bytes;
 
 	ch = iio_find_channel_from_si(indio_dev, scan_index);
-	bytes = ch->scan_type.storagebits / 8;
-	if (ch->scan_type.repeat > 1)
-		bytes *= ch->scan_type.repeat;
+	scan_type = &ch->scan_type;
+	bytes = scan_type->storagebits / 8;
+
+	if (scan_type->repeat > 1)
+		bytes *= scan_type->repeat;
+
 	return bytes;
 }
 
@@ -1632,18 +1637,21 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < indio_dev->num_channels; i++) {
+			const struct iio_scan_type *scan_type;
+
 			if (channels[i].scan_index < 0)
 				continue;
 
+			scan_type = &channels[i].scan_type;
+
 			/* Verify that sample bits fit into storage */
-			if (channels[i].scan_type.storagebits <
-			    channels[i].scan_type.realbits +
-			    channels[i].scan_type.shift) {
+			if (scan_type->storagebits <
+			    scan_type->realbits + scan_type->shift) {
 				dev_err(&indio_dev->dev,
 					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
-					i, channels[i].scan_type.storagebits,
-					channels[i].scan_type.realbits,
-					channels[i].scan_type.shift);
+					i, scan_type->storagebits,
+					scan_type->realbits,
+					scan_type->shift);
 				ret = -EINVAL;
 				goto error_cleanup_dynamic;
 			}
-- 
2.53.0

