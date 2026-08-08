Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD135339B41
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786227550; cv=none; b=aHUKhuNuOeCPPsmlrobdGGH1cpD3S6uCHunODrh+w3GF3tstBNyw9tYVdbWT9ZFYOlF1/fKFyXPSy22iAopaW8myLNtjdDPnQE86CyjEgwtXLBEIiBv6TJLW+LEgCx9qXuiBa4fzMjPmypRMn0uZoFAOt/mP5o9BGRsWQ/KKs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786227550; c=relaxed/simple;
	bh=nyNP1EIU64FB3gZQkwJA9AoNKA1IzECGx1ODnGbi9pA=;
	h=Date:Message-Id:To:Content-Type:Cc:From:Mime-Version:Subject; b=tXHJ30rka3rPS7Oitp+HzQUQoLw6qgGJgRbDSRV365zJZk4XxXluArgw7OehIRYS6qsr+44M2Y6+N2onq9ZwWIqz0k8WxR4xkUtWZLojF+R/ObEvocBKOflnulU1NUNBwKRuNuB3CDoqN7at5iQtTLU5H2naQJbAZMCz5seyoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=UwEzGs1a; arc=none smtp.client-ip=71.18.227.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="UwEzGs1a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786227540; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=H1jmvl9NxK4FHPKbYDO1LavDSQSk2jduKWVtCmnCi/Q=;
 b=UwEzGs1aazYPvjRMSbumMm4Rl2lslVMzyiDqgDJmjxl+Vc+JrH2iJlxciA7/NxfF/6rvTv
 Z/4kRzE4fh2SCWVWaabmtEJkygAndvn1607zd6OhuoyrXrDUElCYhTgomEqNietqs6giSb
 R2elBFho9UCFdTezK69jKpATQP6KKJxjfp/n4+SbAHFAunPuEcGrV2WyzSs6sKh7qQA0yd
 lL5tqRBEFf8T+wBqwG2a04SMi51YK07Okrxdv2GPOwAXfKy3E1866z02YGaMO3YuOSfKVg
 ZyFEjoOob1C+cUmKZqX0Ztfk7MG+Orit5KlsfTClHFAmYTWhZS2VSdoVJUwTXw==
Date: Sun, 09 Aug 2026 06:18:51 +0800
Message-Id: <20260809-adxl380-fifo-clamp-v1-1-780d86ef25eb@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Sun, 09 Aug 2026 06:18:58 +0800
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Michael Hennerich" <Michael.Hennerich@analog.com>, 
	"Ramona Gradinariu" <ramona.gradinariu@analog.com>, 
	"Antoniu Miclaus" <antoniu.miclaus@analog.com>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"David Lechner" <dlechner@baylibre.com>, 
	"Andy Shevchenko" <andy@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEqrd2oC/x3MTQqAIBBA4avErBuYisq6SrQwHWvAflCIILx70 vJbvPdC5CAcYSxeCHxLlPPIqMoCzKaPlVFsNtRUd6RoQG0f3yhCJ+5E4/V+oaNetz3ZoVsqyOE V2MnzT6c5pQ+8kjGXZAAAAA==
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.14.2
X-Change-Id: 20260809-adxl380-fifo-clamp-f07a570d96b1
X-Lms-Return-Path: <lba+26a77ab52+13d34f+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: 7bit
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Jonathan Cameron" <jic23@kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] iio: accel: adxl380: clamp FIFO sample count
X-Original-From: Shengzhuo Wei <me@cherr.cc>

The FIFO entry count is a 9-bit device-reported value and can therefore
be as large as 511. fifo_buf[], however, only has room for
ADXL380_FIFO_SAMPLES (315) entries.

After rounding the count down to a multiple of fifo_set_size,
adxl380_irq_handler() uses it directly as the length of a bulk FIFO
read. If the reported count exceeds ADXL380_FIFO_SAMPLES, this can
overflow fifo_buf.

Clamp the reported entry count to the size of fifo_buf before rounding
it down.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.2
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/iio/accel/adxl380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 7dca5523091fc4c6a3c3bf7e388d5d0d507bee19..8a9d82e1d882aa45721013590ecbd86b083a15a6 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -966,6 +966,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	fifo_entries = min(fifo_entries, ADXL380_FIFO_SAMPLES);
 	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
 	ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA, &st->fifo_buf,
 				sizeof(*st->fifo_buf) * fifo_entries);

---
base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
change-id: 20260809-adxl380-fifo-clamp-f07a570d96b1

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
