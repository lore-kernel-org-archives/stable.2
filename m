Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897638AC96
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297512; cv=none; b=GxaftL1AWPDYufhRxQu/zHFqHqtHojoGEnNjGsfHS6dOF13kuQuLtGkjzhXfCQQtJbCDKf9IDGawGKVz/gnRVCvpTQfRAn+CQ9bxx2VB9jqAmwFG3ggBOEu1B+O2ash6Q/MDqUrpKe1rENyu/oBjxCzGGgYw6WQxycq64fdAVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297512; c=relaxed/simple;
	bh=aMSGu6twbkJjRdATYcZyvyhEUDWkIvFu5IhvQvcAceE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZgqhxEsdu0nI7DEXR1DoBmB6h2IRC5y2z5aAyw6CjQnFhzM0Jb93VzzFh9qWVJ55azVyHwGsPcq8qYarVMW0rcfnRkfSRV/YwGi4C9yzBxid3ATtHOi9PesrGHTCEmHMEW7W/0ZB1cFkXHhZUvx3gh0LkeuEiYivuEtNgbWQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oCG+8OQx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCG+8OQx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3811f512167so485603a91.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785297510; x=1785902310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwE/Kwnr9BPCU8EkGjoplXuRnm52TdDRkTVQHOPaAmg=;
        b=oCG+8OQxpGUrIuBZ2+IX4ovj6ZFMUkjgtIdgcOFpWn4kiAHHrqtFcyE32se3cq9U1g
         D1rQJbeqnn8TsLJm4Y7IkUU75Pa6FNfPVG9RHq+7WTyoYQRxASNRwnvQfeFLNx3Pb1NQ
         ntdybSt5tfwbZI1MlGBN3aTeWQoNW4RJooe8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785297510; x=1785902310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwE/Kwnr9BPCU8EkGjoplXuRnm52TdDRkTVQHOPaAmg=;
        b=mwxwK+HgnC7oz9Jebk1X+7wpJUFMzpYOv9etVJHRKB+uoerZyVMlennoN2hs0IN8U/
         bgUABNr+gy8X7Tc0wETKU9SDa78K9Ti48UiMHsnRwJ3RmtRBSY5INQILdFt8c2xxZh5Q
         PVth51YpQ+CHf9q29eMYRfCKet7G1ivv6aiLeE/2RSPhBRKXozAeGh/Z5OyKSLVMy/fK
         +zGFt8AfEqFnx6wBWbFf4BaRyWKL4T/Y14f0MBJ+GzoyXVplJmggqXdq2YSjtFKTgp1Q
         P+XqWsTeGsGnD3limlb0gq67MwOYTyaSBuXsQA1/8wR/Tflw5BpBhY0EUHpUzdi4swdV
         //Xg==
X-Forwarded-Encrypted: i=1; AHgh+RpTUyGDQQ/hijZKMumxWranI2Oebr5FEYjxRJyh/7NFFYt80tYI1ZRoMI+3QlU3VJC6DxI8U3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT65MIhY/boSwq8Nmmf8yw4X4Y5e46ZRdwwHXrsDwNzF8+Qzr4
	ztzAMKoUowhcJR5a5aERdiU0x6evWyA3+a7cMNTq7CLRgIxyHVrDAEncssAh8lq1VYzjxt2hyGC
	A/xE=
X-Gm-Gg: AR+sD1363AozUziqPBuWVgHNva/IOett3GibRMjRVbvaTRUqM7icHJ4epcWF0VzqKk0
	XRR5cIMRo/J3fQMWc5WPUiJSToGUOg5pJFPQyVJLusSj60AvRze9A+n8WTZjr0A9+VHAm4k/mzk
	WXRnbBwZa1elmP7+XqUdI6o48PkOrW4ObkQjgSJqPYrz3wV8LBYgUKYUkK3iMJ5aJf2D6z/Bfrs
	ba5CRBV5RmFYAB+2kwGl1uZtTUNfuvu2E9ihonMMIovyNew+o6mUKgy1B2h9gZYWHRSP1olOmBw
	SJubijXVVAZh82lFAr1GmrSdrfWGFzOqz8DQlE3ktFvB0vl1hFqBxCGNY/0izkBhSNEJ+FY34dJ
	anSADYO7qBhFt9QrDRSYNKn/1TG9FAkXXgfTThhOINDH6ZhJ4IrZH8sIIcmc2ZdSfZBFPZa5XCX
	84j/d0bClNKcw6MkhPx0oOLFdukT/Jicm84jluZhFmc9OYQzcJEQlleAUoQr1D/YGhvRqcdBPBe
	sDd6owtGnoZe9x6PHL8DQt5uAYRXImZwLMUWg+ckhfvtGO77hg=
X-Received: by 2002:a17:90b:3f4c:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38f6a308675mr5557087a91.4.1785297509963;
        Tue, 28 Jul 2026 20:58:29 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7eef9c5asm722087a91.0.2026.07.28.20.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:58:29 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Haoqin Huang <haoqinhuang7@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] zram: set default primary compressor in zram_destroy_comps()
Date: Wed, 29 Jul 2026 12:50:32 +0900
Message-ID: <20260729035820.751990-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729035820.751990-1-senozhatsky@chromium.org>
References: <20260729035820.751990-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram_destroy_comps() resets all compressors and leaves them
set to NULL, including the primary one, which is invalid
device state, as now comp_algorithm_show()->strcmp() can
be called on a NULL compressor.  Set default primary
compressor in zram_destroy_comps().

Fixes: 486fd58af7ac ("zram: don't free statically defined names")
Link: https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072..ebe2da955182 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2836,6 +2836,7 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->comp_algs[prio] = NULL;
 
 	zram_comp_params_reset(zram);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2853,8 +2854,6 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
-
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.55.0.508.g3f0d502094-goog

