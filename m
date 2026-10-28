Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164171;
	b=pVwBFJSEnKdaY8NaVne3gFGVcfCuhFyFdWTixWBRQVDzZbQw6Kq3diVoxoctu7w7sNAR
	 jMnXbmq2ufS0ABgb7FChiOLIxDwaosLzH7s74XUBLAR3Nl5ac159Danw3SAdHQsZ1ge3K
	 2A45z/XhITeCvR83LiSpw9AAnCDHX98duD9D5nexnqVaHCmm5q0P5om1JcJMvLilmuU0C
	 lAsjdl7cHu3hzSBlI8fmN+yUq+fqIR2JDajbNYwEAjzR82TyD1Z65sIyIQOOBEgee3Mcv
	 4t3Wd9ZIcp3xN1c5RclVLmJ3VQr+Gp0rnppIg7UGpzfItRXdX6YWVsNlryqK9Ob3brg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164171;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Au/fNuooPMasC6MufA9sJ5KEIems8LEKOJEkmxlvz1Q=;
	b=1XM5K2JxGQDbXhWVYhAWSj6xjfevPYnGpXVxRoFTBDd/CoO+gd6uClmfUUUqw2dogBHl
	 TdWmFovnQl3CETsW7036zC92crRbhv1Grp0BFtJOHfDC8qYcKyL/9Lecw5RSZ2vZzV0CX
	 OPP1knGTBcdfRqce3/XYYScKXm0QRUpLUQIs39xI9XnAxsIzA7q9Go/QGRl1brV/EQ+Zk
	 ArEmeVMUa48I3Cb3pGhfkTLx4b5X/uOt+Xp0phbgt1Qj/mJQAdhw4qkKuLhOnewC/NnYn
	 ONNUQC/zMrHMYRGOSh94R5h7d3BPXiQSnOHLnrmBnUw5qzT/gKMF3y8dVX/x4FS+v0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dl83YiFu;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF681606A31A;
	Wed, 28 Oct 2026 05:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF681606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dl83YiFu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Au
	/fNuooPMasC6MufA9sJ5KEIems8LEKOJEkmxlvz1Q=; b=dl83YiFu7j/yih89Hh
	A1UiCyw27gwylAhSsV8k0KmEyddv3PSbrjrixqeP+x6aeZtec6+IPUjLV5mjo7BJ
	Hciy2w97Cj4R04rj+5OEyX+6JEqR8bgCr9bIRSBqIFLbEHA2dYymxZze/CR/JmI6
	fGAbiOpq8OMyNmNAN0ZFuc9Ik=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCX9KN9g+FqETcRCg--.63809S2;
	Wed, 28 Oct 2026 13:09:17 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: picolcd: validate debug report lengths
Date: Wed, 28 Oct 2026 13:09:16 +0800
Message-Id: <20261028050916.139950-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:QCgvCgCX9KN9g+FqETcRCg--.63809S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF15Xr48uFy7Gw4UtF15twb_yoW8CF15pa
	97CF95tr4DAw43Cw13AF4DGa4fA3s3JF17WrW7Zw1Du34rJryfGryjqFyY9Fyfu3yDCryx
	Krs0qrZ0kFyUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYa0PUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR0TTWrhg33J3AAA3u

picolcd_debug_raw_event() decodes several fixed-format reports without
first checking that the device supplied enough bytes for the fields it
reads.  A short report can therefore make the debug path read beyond the
HID input buffer.

Determine the minimum length for each decoded report and ignore reports
that are too short before accessing their payload.

Fixes: fabdbf2fd22f ("HID: picoLCD: split driver code")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-picolcd_debugfs.c | 32 ++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 1f7dfe60e9ba..3430ff036a6c 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -653,12 +653,43 @@ void picolcd_debug_raw_event(struct picolcd_data *data,
 		u8 *raw_data, int size)
 {
 	char *buff;
+	int min_size = 1;
 
 #define BUFF_SZ 256
 	/* Avoid unnecessary overhead if debugfs is disabled */
 	if (list_empty(&hdev->debug_list))
 		return;
 
+	switch (report->id) {
+	case REPORT_ERROR_CODE:
+	case REPORT_KEY_STATE:
+	case REPORT_VERSION:
+	case REPORT_HOOK_VERSION:
+		min_size = 3;
+		break;
+	case REPORT_IR_DATA:
+		min_size = 2;
+		break;
+	case REPORT_EE_DATA:
+		min_size = 4;
+		break;
+	case REPORT_MEMORY:
+		if (data->addr_sz == 2 || data->addr_sz == 3)
+			min_size = data->addr_sz + 2;
+		break;
+	case REPORT_DEVID:
+		min_size = 6;
+		break;
+	case REPORT_SPLASH_SIZE:
+		min_size = 5;
+		break;
+	default:
+		break;
+	}
+
+	if (size < min_size)
+		return;
+
 	buff = kmalloc(BUFF_SZ, GFP_ATOMIC);
 	if (!buff)
 		return;
@@ -892,4 +923,3 @@ void picolcd_exit_devfs(struct picolcd_data *data)
 	debugfs_remove(dent);
 	mutex_destroy(&data->mutex_flash);
 }
-
-- 
2.34.1

