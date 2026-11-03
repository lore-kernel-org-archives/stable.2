Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695308;
	b=ufq5ec1yyldQVV0TN4b9SjvUokuTI8akTBmTlUCNM4Nos11O/xq12CI95jo8eHsrqq9D
	 UvPMv/o5TC96QOVy1IGUaXK5Ovqo8xE4D1i+eskc41MBYN1IxBYRpKX35d2xueqCZtaem
	 LYWkVIaeMFWWAxiw1WBPx8qCYE2v1JB3fOLi3Ug2dEmOIMNc2kA8gE/pOElfXSbSyn9SL
	 lvj8GcdOJM4QdgsdoCXCWAq7UvgabIO3WAJayfR29ZFSAbgFdcS47Uoui3EeqOLXhHuNU
	 oUZRiR7txIgZdG4L1ycZsIxtFOYSU7F+iIC3SJKlJXoxZKs1b5wWhRU3YEqq4hmp+oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695308;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=++Bqjsg5bX1MIM7qYhDWBt8d4cQk/ObUeQfvWN8szRs=;
	b=DshmYzLjkcDueNvlce72x7u0OnAvhgyp48qAEcH0wFZ+bPlAs7M1sqyNNeiVMFt7ug1+
	 tpeULgXs/xhBhJrmO+neGJJ+daEXECVyIf765uN/UouAagm4mUIeYWpir8hc/rMyjikVm
	 jp2/0CWtEFMyBZWaLyL/ogGnRKugHMuIAWGKoRW333LcnD+bAqzxK2LwbPXHxYYkTIya7
	 wwLTM4BeQhouqgLfVNMjlR2kAhgYX47pffSR21bQrwgzycPgsItv0XI0uBduy4UZ7oKDN
	 thzsywUyG+l3PRMz51DSaeqhUYVAqWOJzf1ZpEMJ94gGfZ31YLN/8+8V1MMaOMjfPzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=SqpJgT5U;
	arc=none smtp.remote-ip=115.124.28.1
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73687606A941;
	Tue,  3 Nov 2026 08:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73687606A941
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=SqpJgT5U
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695296; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=++Bqjsg5bX1MIM7qYhDWBt8d4cQk/ObUeQfvWN8szRs=;
	b=SqpJgT5U4lEAl8m6EOBqi/SWl1coByvVBuxQnZB/vwI0csVXRoh5qb5pUutmxUa2eOEEcX51j3UiKeSNAIspSBMpeHnqZfdbiPwy3R6aLqa8l5kK2MPOF+wSHDdJFQrnBWTDdsC6JQ9clLVL8WHgTuX0ZP6o0ZVbp3Rsokd9Ams=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1382582|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00236558-0.000370812-0.997264;FP=10195804445534228212|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9C5_1793695295;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9C5_1793695295 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:35 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: joydev - avoid an undefined shift in the legacy 0x read
Date: Tue,  3 Nov 2026 16:41:28 +0800
Message-ID: <20261103084135.426629-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
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

The legacy 0.x read path shifts the axis values by the calibration
constants that JS_SET_CAL installs:

	data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
	data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;

JS_CORR is copied straight from userspace as three s32 values and
never validated, so the shift count can be negative or wider than
the type, which is undefined behavior: the shift compiles to
whatever the architecture does with an out-of-range count, and the
compiler is free to assume it cannot happen.

Clamp the shift count to the width of the shifted value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/joydev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 32459fd8a7c1..4740099599bf 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -353,8 +353,8 @@ static ssize_t joydev_0x_read(struct joydev_client *client,
 	for (data.buttons = i = 0; i < 32 && i < joydev->nkey; i++)
 		data.buttons |=
 			test_bit(joydev->keypam[i], input->key) ? (1 << i) : 0;
-	data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
-	data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;
+	data.x = (joydev->abs[0] / 256 + 128) >> clamp(joydev->glue.JS_CORR.x, 0, 31);
+	data.y = (joydev->abs[1] / 256 + 128) >> clamp(joydev->glue.JS_CORR.y, 0, 31);
 
 	/*
 	 * Reset reader's event queue
-- 
2.50.1

