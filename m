Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BC3932CD;
	Wed, 19 Aug 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149127; cv=none; b=bbu22SbNjlkcdlU68nF9M0bynguPilpNjQ3RmHBRD+NosPog4CsNvX4J7btamtURFQ4OUXUNmk/LNlI0plMQ3ZLjQuC/JCyM2TZfwNKe3pV1ni0Qw5/p71/8Iw9Mw3GY/rCv2GNM6p9972WxD2ni0gvLwQGpe3dvX9FYGIACAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149127; c=relaxed/simple;
	bh=FDcqC7yK+HUZxK6hWJEWGefrVRToM3+W6DEaIdbmuvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3tJ963Ms/Hskd3LVIX57o1MD3XGvsBWi+Yv2A1DZMx5GvpU/fiJCRBUFJpZ8ky6zX+okL2RBNhPHxt76CEUjkFXQLAoGdCC2nqBBmiXkzjKldehcC/X4LlAQAGhl2A/0piRaG6feqgVgXz9g/gBxEf6oO2vc9KGbY/UiUB38OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=JIdI711y; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="JIdI711y"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a93deeef;
	Wed, 19 Aug 2026 22:18:39 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2] iio: admv1013: initialize callback mutex before registering notifier
Date: Wed, 19 Aug 2026 22:17:51 +0800
Message-Id: <20260819141751.44223-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819014611.18db8689@jic23-huawei>
References: <20260819014611.18db8689@jic23-huawei>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01a636ea403a1kunmb3c26dc5141599
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEsdVktNT05LTUIeHUxPH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JIdI711yaopE/SjZ7xfiKf+EqHScjGeCZIpv7h00tRpmEn+dGLEd4COc5K2wzseFx38F4KXsnDNUlBoUH7x0kN9mL2DWIPk8aZqkVlqfF4EQPmnY0SpSDMgUCIfzixeTYNSwFZgleVJwKil+3tbTdybq3EiZUQcWbbO+G5JM5l4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=2KszgFWj7ls5VeqHqLyXSgARTHFRtBwixOrJj/mDkbI=;
	h=date:mime-version:subject:message-id:from;

admv1013_probe() registers a clock notifier whose callback takes st->lock
on POST_RATE_CHANGE. Initialize the mutex before
devm_clk_notifier_register() so the callback cannot observe an
uninitialized lock during probe.

Use devm_mutex_init() so the lock lifetime is tied to the device and
cleanup stays paired with the rest of the managed probe resources.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/iio/frequency/admv1013.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index d8e8d541990f..ff599b5c88ef 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -594,11 +594,13 @@ static int admv1013_probe(struct spi_device *spi)
 				     "failed to get the LO input clock\n");
 
 	st->nb.notifier_call = admv1013_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_mutex_init(&spi->dev, &st->lock);
 	if (ret)
 		return ret;
 
-	mutex_init(&st->lock);
+	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	if (ret)
+		return ret;
 
 	ret = admv1013_init(st, vcm_uv);
 	if (ret) {
-- 
2.34.1
