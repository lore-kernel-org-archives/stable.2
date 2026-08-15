Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38F64A8D;
	Sat, 15 Aug 2026 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760315; cv=none; b=NJ4/J/XxnZDSaE6CL3exwuj57UDizhGKjwC80XFhlnyQSJ0QZUs7O4nK6Uf/xhzh0+321+82s6qyRWE4c+a+IRIa9MlgNv87SNzl9ECX39JX4DA0au+EgHMv7ssdNEbMlhdepufJQHxByoKbl2Gcv0Im7YKRzG/gKTj79yVLrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760315; c=relaxed/simple;
	bh=UaMUGDPFquRNhBW1VdI1+n3QfJ8qxNqXQLZ7Qkax52M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F7DN3i3NV6oDjQ4N5c9L77gEd9tyTU0znC0aaUqIigRrrxaZ5moXMUSysBOIJeEqkup52zTUc2Mqeb84L4sVqeiB8mvHzkzEh0QL/1GDd2LZBnK45vtO1T4u4q5H0oFtw8K5fVj9szZOWqYP+VxieeQAj+sPNHiYEiFE1yNmFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UyxnCwhy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UyxnCwhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6S
	A2T3hX6apf5Dyo/juEdONBkszc0q1GdKiTHviSPDo=; b=UyxnCwhybh9jP2IFZr
	nxrihRUsAzpbMWL4yeNPYXb53KyfMwCUlZfeQC+uMm4GoOmXYPqshV5bE9qsyekt
	EdLzSb81zqgE+cSd4UVxdI1PNl2g46EomPJmHiT5jX+ZLX6J7psy9uh5sUrJcTIt
	6dK02S492Ukb0DVkCaskx6hS4=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAHza5uzH9qJW1OPQ--.12292S2;
	Sat, 15 Aug 2026 10:18:23 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oleh Kuzhylnyi <kuzhylol@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: hynitron-cst816x - ignore unsupported gestures
Date: Sat, 15 Aug 2026 10:18:21 +0800
Message-Id: <20260815021821.2896-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHza5uzH9qJW1OPQ--.12292S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyUtw13AF1DKw1kAw1DZFb_yoW5Jr45pF
	W5C3s8t3y8G3WrAw10ya1q9Fn0kFyxAa4UuFs8t3sxX3W3ur1FyFn2yF92yF95J3y7uFZ8
	Jw45Aa13KF9xAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRa9a-UUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC+xDJBGp-zHD1nwAA3l

The controller reports 0x05 for single click and 0x0b for double
click, while the binding only defines keycode mappings for the four
swipe gestures and long press. cst816x_gest_idx() currently maps every
other nonzero gesture to the long-press slot, so unsupported gesture
IDs can be reported using the long-press keycode.

Return an invalid slot for unsupported gesture IDs and check it against
the number of configured keycodes before reporting the event.

Fixes: c87a819bec86 ("Input: add driver for Hynitron CST816x series")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/input/touchscreen/hynitron-cst816x.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index 47d9cd7412d1b..d0668ac96f9af 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -92,24 +92,19 @@ static int cst816x_i2c_read_register(struct cst816x_priv *priv, u8 reg,
 	return 0;
 }
 
-static u8 cst816x_gest_idx(u8 gest)
+static unsigned int cst816x_gest_idx(u8 gest)
 {
-	u8 index;
-
 	switch (gest) {
 	case 0x01: /* Slide up gesture */
 	case 0x02: /* Slide down gesture */
 	case 0x03: /* Slide left gesture */
 	case 0x04: /* Slide right gesture */
-		index = gest;
-		break;
+		return gest - 1;
 	case 0x0c: /* Long press gesture */
+		return CST816X_NUM_KEYS - 1;
 	default:
-		index = CST816X_NUM_KEYS;
-		break;
+		return CST816X_NUM_KEYS;
 	}
-
-	return index - 1;
 }
 
 static bool cst816x_process_touch(struct cst816x_priv *priv,
@@ -169,6 +164,7 @@ static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
 {
 	struct cst816x_priv *priv = cookie;
 	struct cst816x_touch tch;
+	unsigned int gest_idx;
 
 	if (!cst816x_process_touch(priv, &tch))
 		return IRQ_HANDLED;
@@ -176,9 +172,10 @@ static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
 	input_report_abs(priv->input, ABS_X, tch.abs_x);
 	input_report_abs(priv->input, ABS_Y, tch.abs_y);
 
-	if (tch.gest)
+	gest_idx = cst816x_gest_idx(tch.gest);
+	if (gest_idx < priv->keycodemax)
 		input_report_key(priv->input,
-				 priv->keycode[cst816x_gest_idx(tch.gest)],
+				 priv->keycode[gest_idx],
 				 tch.active);
 
 	input_report_key(priv->input, BTN_TOUCH, tch.active);
-- 
2.23.0.windows.1

