Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192904;
	b=vRXMq9xXTmqCkBWHUsxrlL+UZ9RPyB3HQpzYUs3hphckW6V674fWbxbv3FimRrGH60tB
	 Ws8AOycS5owZp9YRVJYUgJZ9BtXYY2WPn3V5MuqVZnX1UiGYYu3c1BSQVJuIwBnQQIflo
	 NveCxObCFjgUpocgyRUX5sw2uHCL1IOuzdkc7jB7ocCQtnKvR/s51hhVrt3Cr0c5IWGSB
	 3jBWvYdV68R0J8fCYcP0GM8f805Y3MigwGyG9JnhKAbOqRSpxJGFJ9HGu6Y1E0YRj0G93
	 spS7U2DlLIomed7h7grc+KXoEZx7uwAYD7Uxv/JgzefR5/E9jy0dofCcAJhtH36HCzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192904;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bQ5+bITfzuq+veNb492VEMx3XK8Bmo0XZ4JKqh6kUJ4=;
	b=okbu7H9lkJLMSoKAx7halLQCJOQNlJbzmdk8KQLTRPg1s3F6LK2IdDPPdsLqE40T1FpG
	 h4yFEN0hC9vOdu28mcaY91tU2gCnBqv9xAyW/NioMNxN5lrac0qG6Xbk+W7ND5Vltepj8
	 ZgRcIo4rWopYdJer7YAvfmlqqatcHMAnTgbbqSote16TBq1WW1mBEtY87tMFJiWWSsZeA
	 kKw0XJCOLaC4u3w5nTsxi/WWMm1LuaEBOdS3Ac/bErZlg4MI6Ph3mAl7/m0SgRrnfq+Kg
	 wTTMht/1JGizEYTKqToks0S7uI3W/IxBHcIzaKkIYIekhexbf5XEo1QDFB6uyQevmFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzZ8cp6m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177C606A320;
	Mon,  9 Nov 2026 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzZ8cp6m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7926E1F008A2;
	Mon,  9 Nov 2026 02:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192903;
	bh=bQ5+bITfzuq+veNb492VEMx3XK8Bmo0XZ4JKqh6kUJ4=;
	h=From:To:Cc:Subject:Date;
	b=nzZ8cp6m30hsOnc2VK+tJp6IRDtHr5f44eCdmqcHpgz4CYSyeo519dbRIe36XY8xG
	 wvCg+8RN3piMO/pCEEDYMNzJ1wSqjFXYhgK/SfWnfPH5/F6RiTXGi+PylOqa03LocE
	 pwcDjcsOYrHpoPsN/ZLxVB8Qag9GD/3KRRlltFL5fCBe4+slhQPyD8THfcc6ooDYWr
	 5VHauWRwedqKjtW3I3JlD2b3LpFTK6C8ALvKno5ISmwlNJqs7jAWTDJ94WxFBHIQAD
	 RgV1XKA0t/gD7bFWdcmlwhKBkaaz5XcrhY5zZn8GXDpJy0ZXYxQohXRvJb91w1AIOV
	 jULeT0QxWZjBQ==
From: Jonathan Cameron <jic23@kernel.org>
To: iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: light: st_uvis25: notify the current trigger when done
Date: Mon,  9 Nov 2026 02:54:54 +0000
Message-ID: <20261109025454.1260519-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

The trigger handler calls iio_trigger_notify_done() on the driver's own
trigger rather than on the trigger that is currently in use by the
device. The driver does not restrict which trigger may be used, so if
another trigger, for example an hrtimer trigger, is selected then that
trigger's use_count is never decremented and it stops firing after the
first sample. The driver's own trigger use_count also underflows,
preventing it from firing later.

Use iio_dev->trig instead.

Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Another LLM found one as part of refactoring how all the code around
triggers works.  Definitely the wrong trigger. There are lots
that access the right trigger via the wrong path (shortly to be
cleaned up), this one manages to get the wrong one in many cases!
---
 drivers/iio/light/st_uvis25_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 94d5261b2663..5c63a68948d6 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -248,7 +248,7 @@ static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
 				    iio_get_time_ns(iio_dev));
 
 out:
-	iio_trigger_notify_done(hw->trig);
+	iio_trigger_notify_done(iio_dev->trig);
 
 	return IRQ_HANDLED;
 }
-- 
2.56.0

