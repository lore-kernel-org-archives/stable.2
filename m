Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17C3DEAC8
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324032; cv=none; b=kTSyZ0tbggm+8QC5MmtcSneik5XB3MQNGGgPIegtoMTDxonpJrHegvFaLfUy1IAApR3HakcVZk2clLHL+VjX2knZjZg5CfEe/E5dco3MuaHWS2DQHO7bmbrKvGEJzamz4aIuTRvRMloLlwtD6B6uisV4tUq3TiHS/fPM8Qw9M8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324032; c=relaxed/simple;
	bh=o2u3tmJ4dbMJ8f3Ubk+i85Rmq4bTjeWeJ9eBvYu7rDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lgga3LyqCgci/2l2dwlVz9X4DSIhPVZ+60FZdUJXaHRgqFCmPtTzNqoSLM9MJBQYPJIFOrhp8DKG0B1nHWx8SWQzXXopmjH+MlkNZmToU8NBo7cOYrmqsNBo5D3zK76Of7k97Alg0pNjUzrTn13qXqGH8E4sgjoxuVlEQtG0ciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU30eZiO; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU30eZiO"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1943979a12.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783324020; x=1783928820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y41AW65ugwoCZQW1jZyzd6ERQyYcwsnWPoHTIi1U8oQ=;
        b=HU30eZiO+XODkeoqTRPlMy11WyuhFZ+VF50Tn5gaGl/u1GsThYAkDNEZRl8MQEH3jD
         1OhIbKAOhr3xUcjcbcD+MKE1LAwhcESNTD52UeRfa7tfOOZNqUPRi+XHn3juvipVbUtL
         v7bhzbhJpSdVpjuZL8+24nxCZu5op+me7MIlMjw/DDWh67lDzfZME5xSIZw1652Bhsvy
         H+htdp1Wuch4lZx3yekB4SXOJ74SihBGmZ7mm1hHqirNQjzX7Ks5VnrOYvGn+c5IMce5
         TlKFBT2SDFKqLDRwgzAd0TYE0ljm1j9WmXQVQQZt5DhxZSmDrn8jUDA+cTno/8aK34OV
         P7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324020; x=1783928820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y41AW65ugwoCZQW1jZyzd6ERQyYcwsnWPoHTIi1U8oQ=;
        b=lTQbV0mKzNSqPbMa049DT74yoeXqRy860be6P9a7/5GL1Kfy9mWQ/0+GprB+SX/ja1
         w7A7wr1V2qpozu60P/s79wP1NpQaPGlPQVjkyEil70BDjS6tsisZUwdc1txI3idbZ7bB
         1Em7OUz7OMQj9KhGRcrikCk47tW7br+NNKcWYoXG50XzvWEEOokffuUcI217xf+ie81q
         VmdNmm/8Hj6t1e9z/aR5u/c0QeJHaaWdft3qr7iEaKkxZZm8Hev2ZKy9NnVin0ukaiOb
         hNjlaCjAfGDPiurnnv3oAiOyknBY7Z2BJxpIGgdmlQHz4FARjtuRXsG/AARhyhOHA2Dr
         pe/w==
X-Forwarded-Encrypted: i=1; AHgh+Rq3lxrEqwxZYHWLzlz7cEfd2nvVYThxC720QFOroLG6XMzQzc2xX9Vc8d3/2vwevpG5n3JUtnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC61B3L7zTwGFpfFBcHTnqKDvYZs7zi0kvJGlIPuTRa98eCrlr
	5jarqnV0H/OqQExud4qyoIKN0zvu1tPzJ8ZA4z52FZv29kO83/eA9rj+/X3RpybM
X-Gm-Gg: AfdE7ckPk7qI7csH/g1u9LC3JKZTRBUKZzkPyYqsLh+z0maCe2/ItZ3+J4Y78vH+zF0
	xTaoXdLNuSrbZlQc/LEQnLj0S2wm85yE7c7dO4USML1LlS+/kbfZrfcYAGgpPh2UnAQrRojUpuo
	iBzvvB1Zg8hQfHDD73mLmnXtl1hICZNlF/UPuV5dD34mKW51SpN8YPWrmCxoSJL45UsR1qESjXB
	UPgNP5oVJmN5g9S1ZXq8x8FSn4/1+SeHNmc38mRnnEz6YKyY+DnDMOYxLLHpf02nD57ZNb23aDA
	FpQD7f7iStVlQRKX2cu+6f+wbzSjAep21ltc7VrTc3jUHTGAxi+Cjav2WROL5V08Yk0+4F+lBmS
	K2s3H0J+9YnnhxHm3vK83YdhDAHaTvJzRCnjbZRYewWqKLWKHbyD6zForBY1MaQhOr59MtYCv6L
	Ni/K6ZMuoXcxToZ+I8FlBCSb7ltBtNvx5IHppigg0Ez6g=
X-Received: by 2002:a05:6a20:5499:b0:3bf:a8d7:4f4a with SMTP id adf61e73a8af0-3c03e50ca0bmr9757761637.40.1783324019938;
        Mon, 06 Jul 2026 00:46:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm67081836c88.1.2026.07.06.00.46.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 00:46:59 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] iio: accel: kxsd9: fix Use-After-Free in remove()
Date: Mon,  6 Jul 2026 13:16:51 +0530
Message-ID: <20260706074650.96042-3-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kxsd9 driver currently calls iio_triggered_buffer_cleanup() before
iio_device_unregister() in the remove() function. This order creates a
race condition where userspace can still access sysfs or ioctl interfaces
while the triggered buffers are being torn down, potentially leading to
a use-after-free.

Fix this by swapping the cleanup order. Unregister the IIO device first
to guarantee that all userspace interfaces are destroyed and no new
accesses can occur before cleaning up the triggered buffers.

This vulnerability was flagged by the Sashiko automated review system.

Link: https://sashiko.dev/#/patchset/20260621193036.78549-2-birenpandya@gmail.com
Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24af..7569201ed3c75 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -477,8 +477,8 @@ void kxsd9_common_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	iio_triggered_buffer_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-- 
2.50.1 (Apple Git-155)

