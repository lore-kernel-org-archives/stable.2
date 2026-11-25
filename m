Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608326;
	b=mQUHbpx8hAlgw4tgQU1ph2jvEisONf+iMP0ttG2In/EYmIG9KXK9qHJ8Z9xoUIegKOcO
	 EIY7qUjrDgUgl7WWgSur5XlTBJOCyG9st0Bda0i+znMfIQ7U8s3fAcdBE3+W6JQDzuHXS
	 gTo8/3UG5ppuGV6W3ik9iNUIOjzB3qMTswkXeMKcjgYAYqovHvcxEHb7wDgPQve1NkLma
	 ec/bePubYpbQsOLhkFHsgmwLpqMagcs/NgoqEm+ViqZFvcWQVLl/6/3YN5MSaxaTcqhuY
	 D4D0qjC2LycAEXGV3mAHlLzDMh/RudwxCH0c/J2/hGfqF/9pDHGHkhwCep/MsfrQVvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608326;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=r3mmXNZDbaFRLCVBvWUEUprjDURp79UQZTToaOSehHc=;
	b=3y3MffBgKJNzC0KxEygCvS195bawekm9ZxyMT88DxY05hhA6WYhkOKV3sPyJJxk2YMAu
	 jpMM6ZFs71aggA/nNiXca19Zofwn6TkuYCWneBfxMd1BbN2opWK36La4+TWkVvI492stC
	 HU0xsb9bfT3oXmDIDOgRpoowEtLRGMha/FtlumrkKaqtzBCtjkQLOQWBUHa8q4HTha9d5
	 off3CmidmTv/ET3780LBtLQr1IuGLrIbwIClVXf8Fj72VgPnTyKKBMTmDx/tf9lZNKvbB
	 79NsHfXpyGf91DklG65EIx0k+QKmuVjMUf6EX1F3HJDmV5hrbeUxIy8ANZ/zyUrpZbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QY7j2uVB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2A606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QY7j2uVB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FA31F000CA;
	Wed, 25 Nov 2026 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608325;
	bh=r3mmXNZDbaFRLCVBvWUEUprjDURp79UQZTToaOSehHc=;
	h=Subject:To:Cc:From:Date;
	b=QY7j2uVB6FpP9JPDti/kVLgQA8OZ6lonMSHhcStr9qs3Xciel1QOvEAcp/urK/Zwn
	 eFcrQWXgcDps+tWmQhMFP3xcPIjWUVqwNLq77e8xJ3+DknShFRi+I25PVlm0OHNGfb
	 1YVO57aoMxKfNIY1NfjLocdWE17jzGB2SUagBtR4=
Subject: FAILED: patch "[PATCH] iio: adc: ad7923: add the AD7927 to the SPI ID table" failed to apply to 6.12-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,jonathan.cameron@oss.qualcomm.com,nuno.sa@analog.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:28:01 +0100
Message-ID: <2026112501-chamomile-occupier-b81e@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 594157b4f3f64db5833dee679194c33a5968f92e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112501-chamomile-occupier-b81e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 594157b4f3f64db5833dee679194c33a5968f92e Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 17:19:10 +0100
Subject: [PATCH] iio: adc: ad7923: add the AD7927 to the SPI ID table
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The binding describes the AD7927 as

  compatible = "adi,ad7927", "adi,ad7928";

The OF match takes the second string. The modalias of the SPI device is
made from the first one, "ad7927", which is not in the spi_device_id table:
spi_get_device_id() returns NULL and ad7923_probe() dereferences it for
the chip information. The module is not loaded automatically either, as the
uevent of an SPI device says "spi:ad7927".

Add the name, with the data of the AD7928.

Fixes: 1140f96cd4af ("dt-bindings: iio: adc: ad7923: adjust documentation")
Cc: stable <stable@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 44e014da9722..69fafb4aa4ea 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -366,6 +366,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{ .name = "ad7924", .driver_data = AD7924 },
 	{ .name = "ad7908", .driver_data = AD7908 },
 	{ .name = "ad7918", .driver_data = AD7918 },
+	{ .name = "ad7927", .driver_data = AD7928 },
 	{ .name = "ad7928", .driver_data = AD7928 },
 	{ }
 };

