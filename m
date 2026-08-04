Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849743F075B;
	Tue,  4 Aug 2026 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813250; cv=none; b=J2ViMziKHW1VQAmYLYXj6whBgU23kLGY77w/yCr+ZHdg2S8XmXbW0swuj03RcWF2BRMH7YORSEp2f+bY3UC25h6H4qNnewZ64TIGrvmmfZC79rm6Plmus3cFaGbyd7DQYLcsCh47B7MIAmzw6gWu15MzeAHNkEnms66X/fJfiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813250; c=relaxed/simple;
	bh=AgJFHO5LaaJu9FedrBZkXeR6m9k38PBwh2TW+aJUWTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQia6zcHj9/zQYNH6usHBmmrz2HcXYTFkH7HlnvOYy7o7O7NphWEn+iI37z7ncV8nDUdcBDTdIyb2sKMWf6/0AMRjUQVC0BC2OKi7nXkjIpZe8RKjMUIIJ1EG3HZDaCr14nGNU3BRY/K3PSMDFy0srIn+atZiMmEA55ufpbMbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iVbSvy/w; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iVbSvy/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Wt
	iCv8C/GztLeCsRCdX8B2xYQsnGnhX1Ga7iz6EtsNI=; b=iVbSvy/w7Vo3h3RxAg
	1pS78OQDXKPSbM7FEcmBSemXPuzKoR+m5aUh7psgAowoeQHzA4xtzV86pMSAk/nO
	X09nKaXlu2NAtrjaCiMQNtqT4yHpuDJ6HHD+obvs1F+VwrGDP1VRE27QA0VXAG43
	oOBTOpXzAiVFLd1ylyD1PsSrU=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDX3pjuWHFqNC0_NQ--.57319S2;
	Tue, 04 Aug 2026 11:13:53 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: hynitron_cstxxx: validate touch count and finger IDs
Date: Tue,  4 Aug 2026 11:13:39 +0800
Message-Id: <20260804031339.2379-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20260804020314.2082-1-m13940358460@163.com>
References: <20260804020314.2082-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX3pjuWHFqNC0_NQ--.57319S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF48tw4fCFy5KFy7GrW8tFb_yoW8urykpF
	WrG345urWktF4fKw1UtF4v9FyYk3y8GFWUuF1kt3WkW3Z8ur4j9asYvw4vqF1Yyrn3Jr1q
	kr10vrZFga4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPhL5UUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC3xFJg2pxWPFkLgAA38

The driver allocates max_touch_num input slots, which are indexed from
zero through max_touch_num - 1.  The current check allows a finger ID
equal to max_touch_num to reach input_mt_report_slot_state(), resulting
in an out-of-bounds slot access.

The touch count is read from the controller's report and is used to
index the fixed-size report buffer without first checking its range.
Reject counts larger than the supported number of touch slots before
checking the trailing byte or parsing touch data.

Reject IDs at the upper bound before using them as slot indexes.

The V821 Avaota F1 board configures the vendor driver with one touch
slot, so finger ID 1 is already invalid on that device.

Fixes: 66603243f528 ("Input: add driver for Hynitron cstxxx touchscreens")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/input/touchscreen/hynitron_cstxxx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/touchscreen/hynitron_cstxxx.c
index f6139b1a8681..05e877b0d877 100644
--- a/drivers/input/touchscreen/hynitron_cstxxx.c
+++ b/drivers/input/touchscreen/hynitron_cstxxx.c
@@ -293,6 +293,11 @@ static void cst3xx_touch_report(struct i2c_client *client)
 	touch_cnt = buf[5] & CST3XX_TOUCH_COUNT_MASK;
+	if (touch_cnt > ts_data->chip->max_touch_num) {
+		dev_err(&client->dev, "cst3xx touch read failure\n");
+		return;
+	}
+
 	/*
 	 * Check the check bit of the last touch slot. The check bit is
 	 * always present after touch point 1 for valid data, and then
 	 * appears as the last byte after all other touch data.
 	 */
@@ -333,7 +338,7 @@ static void cst3xx_touch_report(struct i2c_client *client)
 		sw = (buf[idx] & 0x0f) >> 1;
 		finger_id = (buf[idx] >> 4) & 0x0f;
 
 		/* Sanity check we don't have more fingers than we expect */
-		if (ts_data->chip->max_touch_num < finger_id) {
+		if (finger_id >= ts_data->chip->max_touch_num) {
 			dev_err(&client->dev, "cst3xx touch read failure\n");
 			break;
 	}
-- 
2.45.2

