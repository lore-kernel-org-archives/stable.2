Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EEF3A8727;
	Tue,  4 Aug 2026 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809018; cv=none; b=pLUhFKQObYseQpo7CkKJ3z8PeHpClxDhJ4ahQk2qSE648jDvTPughX2VEqBcEiYhZvgfXPqtJp4CUrrz3tzDpF8zj9BiWEr7jp6GpGj7ZEKAb1nzumzbAkL+NHxED//VrXL8+FwyEvZF6g810GCTmg2xOIzyaor21BCJFyTTrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809018; c=relaxed/simple;
	bh=iNMVomHg8I32vAkWDWlNZ6mgRFyjYtiT5lPmKRgS6ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hoWE67YiJ/xSsT+vcNQmnVxIpW22UN0UJkDqS3E+BfNVmKkSjHpWy9jYWejQJ8HRpqVhqsi19802CTlw86oHhaYETqu9ekPRCWudWfqpjOiRbXlqLVNtN2lQPMkZyydas6a0g4edPLc6ux09yTG7AtQxHiCg3IkK1D95ojim2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h+O5E+uM; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h+O5E+uM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Sy
	VSkU+ujJd6QQoT3THOSCN1ySxKY4xKCpBJpir1wCQ=; b=h+O5E+uMow+RHoUIaD
	4E3S1D3xDnjn//w9WcCFWBCescFwq48Z8xiBEFKidOP3qfKfnoNLIrn1J0yElJ7O
	l1BcuNUyrv1NhX+7rAiE0fvb5oDrMA44dewhHDlXbP1k6ZtdJ4Du3yknEl38DfXh
	/oyEdWz50kiquqAbK5/UrRVRk=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAn2GFuSHFqW3tdJA--.28212S2;
	Tue, 04 Aug 2026 10:03:29 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: hynitron_cstxxx: reject out-of-range finger IDs
Date: Tue,  4 Aug 2026 10:03:13 +0800
Message-Id: <20260804020314.2082-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAn2GFuSHFqW3tdJA--.28212S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF48tw4fCFy5tw4fCFW7Arb_yoW8GF18pF
	WUGryY9rWkta1rKw1jqr4kuFyYk3y8GFWY9F1vyas5W3Z8uFWjvas0vrZ2gF15trn7Xr4D
	tr1jyrZ0ga4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Un6pQUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC4BElX2pxSHG+QgAA3V

The driver allocates max_touch_num input slots, which are indexed from
zero through max_touch_num - 1.  The current check allows a finger ID
equal to max_touch_num to reach input_mt_report_slot_state(), resulting
in an out-of-bounds slot access.

Reject IDs at the upper bound before using them as slot indexes.

The V821 Avaota F1 board configures this driver with one touch slot, so
finger ID 1 is already invalid on that device.

Fixes: 66603243f528 ("Input: add driver for Hynitron cstxxx touchscreens")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/input/touchscreen/hynitron_cstxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/touchscreen/hynitron_cstxxx.c
index f6139b1a8681..05e877b0d877 100644
--- a/drivers/input/touchscreen/hynitron_cstxxx.c
+++ b/drivers/input/touchscreen/hynitron_cstxxx.c
@@ -333,7 +333,7 @@ static void cst3xx_touch_report(struct i2c_client *client)
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

