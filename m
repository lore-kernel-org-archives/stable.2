Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711E40681D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362528; cv=none; b=ENh2gCa4/ig+ozWyuXa+gZkp4UIzjv/bGQqa5xFBV8xjnM+xNiWCL3qV29faaLNS9ISd5s1sWwMBugHX74Quv3Q2bxZFB3m2wGgphEnRWola499Jbj3FEIT/aKvKRI9gFFLFj72v49iWVGguL68RyFIUabpCY4z3dk6i9sqFrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362528; c=relaxed/simple;
	bh=WtOvlcSqrfS905+X+HtepAF2mj1MdTuXNxZ93GFbYAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBBwPRPavGJUjV0OZ7K5eBt257UBEcpg9lgO99wR0KFaT1cfeOmbdrnmMHbgbUlVc5OHEaaCjOEJYTU9Wz19O8bkXmIvLRrqsduEr1Y+u1hleloEYHbuPXls6bHOLFogl7uZBOhoYz3dblPAtZL7EXEPNIUyZtjT7JIa70S7jro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPsOpZxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPsOpZxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FEA1F008A0;
	Wed,  7 Oct 2026 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362527;
	bh=pX1HI61d9hlM6zJrNKup9fLz3wzSnNU7Hyh7qesE1OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPsOpZxWTNq/ugmWoJJzzuI1DI7iq0iFQVA1Qp6yS6YT3bqruFCupsw/3yW9qS5Nh
	 /JcfLnec8axr3IvRWKuCUK2WVunW0dE6RFKeG04FL/1RPiHcOXRuTK3/QSj6IAnc+Z
	 8syW4bL8/4tS12NvGQ1TZtmavf7/C1oyTefk8TwxH6XYFo8TJj/KxAhL2yv0N3/4MT
	 V5JQQ336YvjZtvcGiCIZYNY+9WU9YPu6REmZvzHATndp2+cQavXI+rOkKBmm3Xwdq0
	 CRpMI/d1RM61QRxkSfOV93E7G+svQGOGNeWDPTOy4yqySA4iUidvMNxQb5y7MLTp+a
	 tf98c5BMNgN0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] iio: core: add accessors 'masklength'
Date: Wed,  7 Oct 2026 04:41:57 -0400
Message-ID: <20261007083721.1749559-4-sashal@kernel.org>
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

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit de79583ffe794663c53b77f97be814522d4edc4f ]

'masklength' is supposed to be an IIO private member. However, drivers
(often in trigger handlers) need to access it to iterate over the
enabled channels for example (there are other reasons). Hence, a couple
of new accessors are being added:

 * iio_for_each_active_channel() - Iterates over the active channels;
 * iio_get_masklength() - Get length of the channels mask.

The goal of these new accessors is to annotate 'masklength' as private
as soon as all drivers accessing it are converted to use the new
helpers.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>
Link: https://patch.msgid.link/20240702-dev-iio-masklength-private-v1-1-98193bf536a6@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Implement the masklength getter as a single-evaluation macro with an
unsigned result so that no new functions are introduced. Retain the
active-channel iterator and convert the MAX30102 interrupt handler to the
getter, providing the context required by the subsequent interrupt fix.
Omit the unrelated scan-type helper from the surrounding upstream context.

Stable-dep-of: f0ea4824deeb ("iio: health: max30102: fix NULL dereference in interrupt handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/health/max30102.c |  2 +-
 include/linux/iio/iio.h       | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 37e619827e8a1..43c16fcdeae19 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -293,7 +293,7 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
 	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  indio_dev->masklength);
+						  iio_get_masklength(indio_dev));
 	int ret, cnt = 0;
 
 	mutex_lock(&data->lock);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b0c5d53dc16a6..d04df1c8061b1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -772,6 +772,21 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
 }
 #endif
 
+/**
+ * iio_get_masklength - Get length of the channels mask
+ * @indio_dev: the IIO device to get the masklength for
+ */
+#define iio_get_masklength(indio_dev) ((unsigned int)(indio_dev)->masklength)
+
+/**
+ * iio_for_each_active_channel - Iterated over active channels
+ * @indio_dev: the IIO device
+ * @chan: Holds the index of the enabled channel
+ */
+#define iio_for_each_active_channel(indio_dev, chan) \
+	for_each_set_bit((chan), (indio_dev)->active_scan_mask, \
+			 iio_get_masklength(indio_dev))
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
-- 
2.53.0

