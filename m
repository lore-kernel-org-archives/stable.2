Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A936495F;
	Mon, 24 Aug 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584623; cv=none; b=YujIDTuf8P4boqzAQ19Di5YPIPkq96sq0a8w/XHuVCxB5GCtnpZpHRaEVrXHZLG/GfCTL+7sg38PgPXe689r5rCdrqnQUZNe3QQ1Bgr/KLN1LEZoVKqgHlbdaU9Gv8WAbb91GeG07xDQCdU0Geu274+XVuJaYT1Jzrzbt7RRxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584623; c=relaxed/simple;
	bh=fRJ0gKf5uO/XZ32Hs7F16FzCRovTRTuQtdGH0wb5UuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gvC9+uavPy6NwuaW1iC/1YMjZMGsle9n+ozX1zWhfZ1gyLASvEFD6FII0eT/wGuzv72Hh9uRYq17w+be6mnn4olW8U2FZP6SwGGfTCX3wyk1wj4frShJj8DEsXWUkzLnQjgNTF78AtgPKP78VXqBz3R+iXDq/E6BgjhLbvVFIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UirPjqKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UirPjqKo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEA54C19425;
	Mon, 24 Aug 2026 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787584623;
	bh=fRJ0gKf5uO/XZ32Hs7F16FzCRovTRTuQtdGH0wb5UuM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UirPjqKokG4rIN0F22arCqdXk+2LjX68mj4yYijzjGg6ySYDsDMy4SGllzYA0Y43u
	 +mavmBcKdVW/QAETyERCBqLS35k1AMJhZjJxBhy3Uixfgb24cMWeuv19/HPfuo/lxQ
	 Fd8s7N7ZCnzM0+wEHmqcRFLlgQxCaAKWPbvzr5aU3Aw1SE8gVupmGWhGJZYBzOKj0O
	 oDDpa9PQTw4V36e6tLza/6X9aA8RaeO9CvEMRI2ZPsTnjx+rq8qAA+UBZ2O+sC152c
	 iBtvINWUeCIawq3+IYhQ/GXNDnxN1p5YSyRJi24LnGkN8ukZFMjKC1rbIg7v1ByvAn
	 kXGjksC6TUsug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A57C5DF9B;
	Mon, 24 Aug 2026 15:17:02 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 24 Aug 2026 17:16:58 +0200
Subject: [PATCH] iio: inv_sensors: fix estimated value larger than
 interrupt timestamp
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-iio-common-inv-sensors-fix-estimated-use-v1-1-6e93506e7e93@tdk.com>
X-B4-Tracking: v=1; b=H4sIAGlgjGoC/yXN0QrCMAyF4VcZuTawlTmrryJebG3UCE2k6YYw9
 u6revnB4T8rGGUmg0uzQqaFjVUqukMD4TnKg5BjNbjWDa13PTIrBk1JBVkWNBLTbHjnD5IVTmO
 hiLMRdv0pDmcfnT96qLl3pjr6XV1vf9s8vSiUbx+2bQchNBsyjAAAAA==
X-Change-ID: 20260824-iio-common-inv-sensors-fix-estimated-use-147d698d2858
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787584621; l=1816;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=mt7gKJjjBCMn9wytqWTTXgvzfjqGHjP0xJ6dO7I7gEo=;
 b=mc/DmUjy1+bHfZNxWZm68zom2oxgTMovN+/tw02V1vmZWyi9yXJ7jSkPbXXFf+N387Yl2gHEi
 fSkCYbfSajtDeWqLebB7FMS0Vnk+8dmHUb1scbaBlLHXCLn1GHHV48P
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When interrupt timestamp interval is not valid, we use an estimated value
that can in rare case be bigger than the interrupt timestamp. This is
obviously wrong, so better use interrupt timestamp in this case.

Fixes: 8f4b627656fa ("iio: inv_sensors: better timestamp alignment when using watermark")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 88a82d1370c5..8c9e81a77e68 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -167,11 +167,16 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		valid = inv_validate_period(ts, period);
 	}
 
-	/* if interrupt interval is valid, sync with interrupt timestamp */
+	/*
+	 * If interrupt interval is valid, sync with interrupt timestamp.
+	 * Otherwise, use estimated value while ensuring interrupt timestamp
+	 * remains the maximum possible value.
+	 */
+	period = inv_align_timestamp_it(ts, sample_nb);
 	if (valid)
-		ts->period = inv_align_timestamp_it(ts, sample_nb);
+		ts->period = period;
 	else
-		ts->period = ts->mult * ts->chip_period.val;
+		ts->period = min(ts->mult * ts->chip_period.val, period);
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, "IIO_INV_SENSORS_TIMESTAMP");
 

---
base-commit: 22359083a9e74d538ce383d5c0ee30cc20182187
change-id: 20260824-iio-common-inv-sensors-fix-estimated-use-147d698d2858

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


