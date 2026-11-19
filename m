Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102325;
	b=S3+QuGNuoN22gOIJSy0/hWEd8SsWBzeJ0uIYF/4Eis5fxMJPkgRahDiMyR9qfsx5UcYQ
	 VUQrRdVd/3T+QIFpSaykII6hVIhglGCxSPNNhF6lhw/8jHzuYP6y+t3yePt9JeZvJ3ACM
	 /6QJDesr49qRQ591yO+EihfQ6UB20VQyrCmMTJR8400llm717H+0otpSiWPehq/tjZ2/i
	 7IZMn3+1nVTjJBCUTp910bRjhQuDxW3eu/DdZxIc1aC1My+zR7VElDcHCLibWCLt4YJbC
	 8Ixord90hwfA+l/oo5XCu4S0x26KCTpf2dcMfEwa7tyVBdUxFYzpDJToYlBQUFf8GcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bspJPCzBXjOSr0lbKiju+1jvDaWAkbU673HeUfrBbfI=;
	b=2MnKGeAt/dgtbe3yiDQo61EdS3D9NVu9raNalm8VYvRepgcb5KOKrgdVhKw1pa4p80RT
	 abBySco62QwzmDrgyfUIWHtutOrSsyi8f5LkPFr+x9jZNHHPsSAdiI8O7YcKtKH+aFCeX
	 w57dLrtDrasqG5I/Y+7nDVSd5dkAoLvCllpUlE87NshSvGrveMo59ytu65wQH/sdCH6c/
	 7K6tgR86KN7hczY/AbkUPQAsZYs4LUpz3QI4wudtBi+a1sD0QOte2WFIRJyHukvZOjkER
	 3Aj9hSTo89bJKnfj4llLdPjc5IL/AE3anC3Z8DIs+whxdBxyfGsiFjqeH+VYBEWSQJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfhWcqde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABE606A32F;
	Thu, 19 Nov 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfhWcqde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D298B1F000D3;
	Thu, 19 Nov 2026 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102324;
	bh=bspJPCzBXjOSr0lbKiju+1jvDaWAkbU673HeUfrBbfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PfhWcqdeZFGHfC/e50VXK0ocs4AItUUVP7hGgh2aX1kZu03Wk/6YKk2Y1+ozl4zJn
	 S7VtCYLDPrT40MJExaamsUsXtSUo4ZT7DmWRcKW5+iDCqSf3kf5+Hz1gdITrnaqK/D
	 g6h2LWje4YdxbA75v8lNvqbi25YaeYxIVSHkB4LyhbRzk9f3g2bwldPh/XAgz3sftq
	 Um8qHCGwsJsvw5Ft6l0ndt72Dq3iDFHxDjHvrF6XEQg20XSR7JhngGP9TslnudXoX5
	 QMnCMn6CfWA0k1q5kUXnRc5dFKTICq7QeFzj2cALNN490JYpmds2sK2SN50txJQ70P
	 xjvt4e+hAuEMA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux@analog.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/10] iio: imu: adis: Clear pointers after freeing in adis_update_scan_mode()
Date: Thu, 19 Nov 2026 15:30:34 +0000
Message-ID: <20261119153151.1397003-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adis_update_scan_mode() frees both adis->xfer and adis->buffer at the
start of a scan mode update without clearing either pointer to NULL.

In both adis_update_scan_mode_burst() and the non-burst path, adis->xfer
is allocated before adis->buffer.  If the adis->xfer allocation fails,
the function returns -ENOMEM while adis->buffer still holds the freed
pointer from the previous scan configuration, causing a double-free on
the next scan mode update or during device teardown in
adis_buffer_cleanup().

Clear both pointers immediately after freeing them.

Fixes: aacff892cbd5 ("staging:iio:adis: Preallocate transfer message")
Closes: https://sashiko.dev/#/bug/linux-966f0cd4-488a-4d69-b8a5-449c751365d2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/imu/adis_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 501da4eaef69..9d317b627eba 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -74,7 +74,9 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 	__be16 *tx, *rx;
 
 	kfree(adis->xfer);
+	adis->xfer = NULL;
 	kfree(adis->buffer);
+	adis->buffer = NULL;
 
 	if (adis->data->burst_len)
 		return adis_update_scan_mode_burst(indio_dev, scan_mask);
-- 
2.56.1.708.g77570a6a1d-goog

