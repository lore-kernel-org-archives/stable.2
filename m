Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605638F659
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327706; cv=none; b=sNnSM+n98h+RJwchv6KBM25twQ62oINg8WEPQ9jnPFqB5ZdSEKn3qrSrqw6/l0y1kawB4UJnk+VBbJBEQwTg5QLZeonPABdgfLH+wMKkRko92fBtx/urwVsXxsxh1nqH3hRKzp+2XsiBs6nKddZMyVqIJZAbM4iFwH6WBxqFin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327706; c=relaxed/simple;
	bh=sz4GE5UZkFlUYZOEejeNShGGHZyb/yr9VaGXbV0JW3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDmbiOw9vST0rmo2MZVuGtURUhxmvsnxgLHiH9Eb/XxKbi17ePp+xVsggiaGr632686pc/s5ev21s1Q8aPmBdl39iTN4YLVBKORP9WremKCKFzk0vggQRZ8Vt1frGoZZ2SI/U1HYZbIShmaUFSt1/ijUXdYAMYRqtN3GHjIV3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtLXN3tG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtLXN3tG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a06b436dffso6831b3a.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327703; x=1792932503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnheYDRM6vYnCG89OFLcuiT1asg22kwip+wXziGfAlM=;
        b=RtLXN3tG3URGJV11DxejzEe81zujVlzksMwyUgMKIU9I4mS4T+68MqxObJpy+HDLnT
         2Xqj3OuyqxCHxK9S97WMRaRzcZHpgfWNiFm0ghpUZyO4dxVUUd1lbK9fqx1oRjWfe++j
         aH/yWpypRorEgNEA1atZg1KHHAE9JED6CWSNJQzLKDfSjfbqcMghbNzO6Eddi9+6HfBQ
         IJLs5LrX7bKZDz1huK0h6ALFZiLTBuKI2D07fiXFZRZQjQhLz49udqgdq6qcFfM17ml+
         uOEX4TsG/S2eRU29nUk1D3qsr8OAeMhMHVzMo+kC+lkGv2P2/sVek+pLT+9wQ9uK4w42
         9UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327703; x=1792932503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnheYDRM6vYnCG89OFLcuiT1asg22kwip+wXziGfAlM=;
        b=HPYUsXM0fYogfOOBgopgQ3GJvNQfkv3mhLtb3oy/i1iO7eImnfv8kwmsrikGtFTxWt
         oktfEJU8W0HrZDV7oG4WjguLypM6ZKZ6+bxyl8Mb6EWseNIo4QQwRb9R3J/dS0+emyEK
         mN/mkGhsLYYPB3DhePf04I+gctqhBJibAGtUOyLykd71S1jIUujW2pZBs2+eiZH4ce0A
         opng+KEoBLdSuvnanqieJNaJiY2yzwLZNVabQqi3tGSzzze45z+XIwft2OCIMnsEnYHU
         ET4kQxR8D4fjudlxZhVo6oNItXup0vyjCLKFururPT+xN2cJapX89116rhC53Cwz8qKk
         B/lA==
X-Forwarded-Encrypted: i=1; AKwUvBzUkR6x49qB6ErB1Y0onWr2xxZyUFY2HmjEElqBK4aaMWIl8QFcZyZiGTgUtD8+7bOWhfTfTx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXJs0RFEdfkrllncqVEJqquDV3P9EJNwhFZuv7A/IjmGIeDmZP
	BJO1v/PhKWwBTf7Oq8+hT3FbCrVdrodi51/ufWTcvA1xzIcGdZtDPVjt
X-Gm-Gg: AYBFou09ny7J86GCM2v7qdHtcOmw/ah60iT5kzOdMN9YiuMWJ3w4VKIyt4MedNubvW/
	d24Nh05jLLlS2K8hgSOrlvnBh1S+LeYZ0idCfLOQOHDlYSIqvR+ibxmYOcYlVDKcHf+W31bqqAB
	Y4J64JKvaOfinDc8ER0uEqoowAzmOVYCLf2RKT9NYz0P3sLvamw1kbsAvuW665w90icq8WQk5j1
	naRqQV1gATlF28zyiBb1BUSpcFTY7xA8tgAbih7jFU3LRWjtYcWxtlwyXXJhDTQWTdB2yjyIDlh
	s98V3UNIclxBIrt0IRiyzGfHIu964AV+gsTyQStmAYrxuusUYw95NQ7lS5jG2GG0liaYZSZ0j4p
	BdHe6A2NwviB+ygQf49cphvKQ78uKbusw/kCviCUibbz8yNfAXTK4xYe8pLKpt8zgNW3JRyBv5i
	kpdFb/nZORlfgPvLlmNJc9Xm/Rius79gH6GFwJFW3c6tpTNMz13cm1BQw1Wc+NV3cEnbjKAsNt2
	0rHCvjRD4BBHt60Zv/UEeI=
X-Received: by 2002:a05:6a20:43a7:b0:3dd:85a9:55b7 with SMTP id adf61e73a8af0-3e225f84339mr3880841637.34.1792327703067;
        Sun, 18 Oct 2026 05:48:23 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:21 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 6/6] HID: wacom: add NULL touch_input guards to remaining touch handlers
Date: Sun, 18 Oct 2026 21:47:55 +0900
Message-ID: <20261018124755.850888-7-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_24hdt_irq() (also handles WACOM_27QHDT), wacom_intuos_pro2_bt_touch(),
and wacom_bamboo_pad_touch_event() dereference wacom->touch_input without
checking it.

As with the other handlers in this series, touch_input can be NULL when
wacom_setup_touch_input_capabilities() returns -ENODEV during an
otherwise successful probe.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a34db1505625..e3fff2471d43 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1483,6 +1483,12 @@ static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
 	int num_contacts_left = 5;
 	int i, j;
 
+	if (!touch_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < finger_frames; i++) {
 		unsigned char *frame = &data[i*finger_frame_len + 109];
 		int current_num_contacts = frame[0] & 0x7F;
@@ -1654,6 +1660,12 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (touch_is_muted(wacom) && !wacom->shared->touch_down)
 		return 0;
 
@@ -3418,6 +3430,12 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 	int x, y;
 	bool valid;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	prefix = data[0];
 
 	for (id = 0; id < wacom->features.touch_max; id++) {
-- 
2.53.0

