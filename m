Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420295;
	b=LPyTCdkHyHOdaitFf+CLBib4y5gVMR7TioeebrPY4ae9l19XnCjv6b8zwm/fS5hTl11A
	 4Rbj31PEH3Zu7YDpcnCWnGVRUQpyqinI6M7q2/1wRTfI5PkgD5dm8IVwH78/y5bGLK8Y9
	 a2J9SNApE10G+5Ddn5z6KwiapqrPpNrnq4is+WnhB6qhWuyUpqGmEoqEGRWx8EyFoplG7
	 WO2LNkMzwbNA7R2eQCNtY4/ZwvBussdPMPlIUfPseaDot519f2SyIdmYNyl41Yq5Hdmck
	 i5ZgsMqw4gtiO3QZ2/2LMPPPRNZdhJA7/8jGMIcX5CjQ8vqZEWx8LnW55ylwNqexyew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420295;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oazF4+IESuembcd1tmGXA1W/tSrKsfNqYpwuKjqwHus=;
	b=0NUQAe4j+NTdGBQzn0WqzbuWzFdMZQikUaPg695LVMMzf4055/pthPkDAycokAbT7G5A
	 4l+8aaK1sD4ADd5iM5WWFFRhvBBZ+yiWb1HqzuGp3bnk2fwLP1N79XlcDyiV9yHSWpLyR
	 gKXbtVkRfNiTQS7940DabNgzm/gbUP1pKM8abvNrukb/sRIuK5hzLzFobuLZaCplPho0T
	 7uirpcwE8p7fBkEV1jTkyuma3BUsiN/v0pASF+cCz4ACjJw/M2c2fovDE+LC2rJE14XpS
	 QesodGOb7YhBU6eET1RAku2/MVA7bt3MXsSPkfVn8FtGdsrDOD0NNE66H/0OnX1uIAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oAw/MZxR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E14606A32D;
	Mon, 23 Nov 2026 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAw/MZxR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D11F0089E;
	Mon, 23 Nov 2026 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420294;
	bh=oazF4+IESuembcd1tmGXA1W/tSrKsfNqYpwuKjqwHus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oAw/MZxRKAaHI/0Jn+L7RisNTjper98Nn7krMKpqlG0xbESKfwvMYrPelp5ZJ6O0c
	 WXWIWui4Xy2tPCQiWiRhV+8pSN9NNu0/XGtnLTlGJAKz9ElbAS1k6ZojdtPNAsHyZ6
	 w9KHQI0tTtYos3m06HPxHBrVAwekGSRrzdjnAnvPQIRKY3GxwKhBihNxQGoM22xrny
	 f6TGmzhJWctg69g5RnBml+SJh94967rJ4yMirKoFTMgSvCHJaEOnvyHxqO3lF7S+pg
	 fJZehShZaXATK+ZjrIGXVnentbDNReUg7sOLX3yJ6ufOB2A6cMrHLDmswHtTiBapNN
	 XLtm3mupnQYKw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH v2 1/7] iio: imu: adis: Clear pointers after freeing in adis_update_scan_mode()
Date: Mon, 23 Nov 2026 07:50:27 +0000
Message-ID: <20261123075122.373060-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123075122.373060-1-lee@kernel.org>
References: <20261123075122.373060-1-lee@kernel.org>
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

Cc: Radu Sabau <radu.sabau@analog.com>

v1 => v2:
 - CC Radu Sabau (Jonathan)

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
2.56.1.750.gf70dc682cf-goog

