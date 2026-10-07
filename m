Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7440681D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362526; cv=none; b=UzKMJ+KQezGAkQDGrIH/O5T0NBrkrqIC8InqBaB62BziQgi7y8fESnR7LAfHQ5R0QYkdseLGy1v+yX//Z1o5QPlHAKy+eWCZBN6McWIjb0Ds2jHzOmepTGS34F/qqLkFKHrrdQwKEuVQwsdi5zKuBZMpEg8vLVzSczkfkvQ2/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362526; c=relaxed/simple;
	bh=gt46uSUIeUb47CY6SPMSsV8kbZhsRhtLMpYIoJKO/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1F0uXtO3bjUau4iUpI/fluLLa9BbZYsVCqCGwY23jjES4cIec86yNnRN0x0ZN+lAs5EYhBSARPQMZej+A2ts8F4lm7HLpG859wyRGezJE+EI3TiEY27mJpgya059NAH1aORnXE2bN0bFk9vHiiX0hPu8jRq/a1mX5tRAKRYgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVKy5VO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVKy5VO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914061F0089B;
	Wed,  7 Oct 2026 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362523;
	bh=N5vNeTZ62Cu/FkV7acQrNLmz3JEN1Djd4kHEA3UhuZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVKy5VO0T24b62i46Be6qz3VljCCJNH3el98nXJUhYrDHx2CY3j8yB9/Rs+TU/6Nj
	 LG/m9k79YZ1xpAuH5UnOKJSoLjcOfgOyglULGNG/37amGztWwEg7ZWYWEAhpO1kT0S
	 6OgRdHf084OZUb1heQO7RuBk2rdUmsEhWBVJAUR0ksvpcEmDvMibzcoiqzXpkejGX0
	 8dZQur1E+8OskUULPyi6EHfPNlE9HpClesPcNrm9r62w3UfhUmpsI03Fg6YJI+L0w9
	 ch8vXwCZ8rDYgFdpHz8eV+HGJlQtYW9lMueFyT/jlTH6BE0MQZ/uC29nXeQORvYkZW
	 YsuVFottTBxeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] iio: introduce struct iio_scan_type
Date: Wed,  7 Oct 2026 04:41:55 -0400
Message-ID: <20261007083721.1749559-2-sashal@kernel.org>
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

[ Upstream commit fd7179ece035417f44f7ecff086d6df674d8a5bd ]

This gives the channel scan_type a named type so that it can be used
to simplify code in later commits.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240530-iio-add-support-for-multiple-scan-types-v3-1-cbc4acea2cfa@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: f0ea4824deeb ("iio: health: max30102: fix NULL dereference in interrupt handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/iio/iio.h | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 2241a87c990ad..b0c5d53dc16a6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -172,6 +172,27 @@ struct iio_event_spec {
 	unsigned long mask_shared_by_all;
 };
 
+/**
+ * struct iio_scan_type - specification for channel data format in buffer
+ * @sign:		's' or 'u' to specify signed or unsigned
+ * @realbits:		Number of valid bits of data
+ * @storagebits:	Realbits + padding
+ * @shift:		Shift right by this before masking out realbits.
+ * @repeat:		Number of times real/storage bits repeats. When the
+ *			repeat element is more than 1, then the type element in
+ *			sysfs will show a repeat value. Otherwise, the number
+ *			of repetitions is omitted.
+ * @endianness:		little or big endian
+ */
+struct iio_scan_type {
+	char	sign;
+	u8	realbits;
+	u8	storagebits;
+	u8	shift;
+	u8	repeat;
+	enum iio_endian endianness;
+};
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
@@ -183,17 +204,6 @@ struct iio_event_spec {
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
  * @scan_type:		struct describing the scan type
- * @scan_type.sign:		's' or 'u' to specify signed or unsigned
- * @scan_type.realbits:		Number of valid bits of data
- * @scan_type.storagebits:	Realbits + padding
- * @scan_type.shift:		Shift right by this before masking out
- *				realbits.
- * @scan_type.repeat:		Number of times real/storage bits repeats.
- *				When the repeat element is more than 1, then
- *				the type element in sysfs will show a repeat
- *				value. Otherwise, the number of repetitions
- *				is omitted.
- * @scan_type.endianness:	little or big endian
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
@@ -244,14 +254,7 @@ struct iio_chan_spec {
 	int			channel2;
 	unsigned long		address;
 	int			scan_index;
-	struct {
-		char	sign;
-		u8	realbits;
-		u8	storagebits;
-		u8	shift;
-		u8	repeat;
-		enum iio_endian endianness;
-	} scan_type;
+	struct iio_scan_type scan_type;
 	long			info_mask_separate;
 	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;
-- 
2.53.0

