Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D335F192
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681442; cv=none; b=o+u8NehPd1sTLPVyCT3WjfgITSvNtBw70stowdb4/XHoKyVIZ27v8igWD6ANpSHuKrKKQzVDKrcSAP664Em68y+drHJpAar3zdrCrZ1X/t7B3CcqYaMPHG2GOVbbq7+MuPEVxFpwDIAzcL3UDMel6wk48PaE4HVaDCe27L7V+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681442; c=relaxed/simple;
	bh=va+yoR4CQ1BU31YI/sD+3BMcmji42CM+9+HM1hdomjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g10jk7uSKAExhaflT49eqqzWk67Uz+C1Jbh0uQ6260GJbegoeOXE7oysMmLKUWsEVlQyWbtRLWRIlq/jihoH9yXU2GFgNzGOYO4svu4L7ZMWyhg10wxunqToAIXUzXq8uXm9LUwD/IcI07ume32VrmKKAc651bkZ/r/n6Vna3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5MKBGA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5MKBGA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FB01F00A3A;
	Wed, 22 Jul 2026 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681440;
	bh=pXn7kSJc6s+ARjs0WjV313E1iZCfSAbwhqyNZq01VUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T5MKBGA5Cw25czNQh7QpHEKvpEVN4V6C4Lten9ITnBT13taZ+jtBLF4NDfA9xoBxd
	 1VPs8jjxclqAsfIxLsFDhaRr2GnsYYhEHB/fxsWw0Eg2HOyRnROl7jQH/kuvboqZlz
	 OKWJiRrYvXa93DbOs21BOKFKH0xocixI1XIZwTI85mRoRCnkv273nqhx3d5jgpVlG8
	 3hVjSWMZOH98jHcYmq9kwMNVSV73JvYLsl72+vYmAg/NPP6U7xLCiO3iF2Rb4ycuhK
	 MViCRQd+yR8Fr2VpmzEA7clgUN+4bwfpIMssQocCt923Kj2qTw/7pCrLePRnwyk3Rw
	 A18PNQiF3WCFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	sashiko-bot@kernel.org,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: mms114 - fix touch indexing for MMS134S and MMS136
Date: Tue, 21 Jul 2026 20:50:38 -0400
Message-ID: <20260722005038.603739-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071610-maximum-nuttiness-8da1@gregkh>
References: <2026071610-maximum-nuttiness-8da1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit a6ac4e24c1a8a533bb61035184fdcc7eede4cc8d ]

The MMS134S and MMS136 touch controllers have an event size of 6 bytes
rather than 8 bytes. When __mms114_read_reg() reads the touch data
packet from the device into the touch buffer, the events are packed
tightly at 6-byte intervals. However, the driver iterates through the
events using standard C array indexing (touch[index]), where each
element is sizeof(struct mms114_touch) (8 bytes) apart. As a result, any
touch events beyond the first one are read from incorrect offsets and
parsed improperly.

Fix this by explicitly calculating the byte offset for each touch event
based on the device's specific event size.

Fixes: 53fefdd1d3a3 ("Input: mms114 - support MMS136")
Fixes: ab108678195f ("Input: mms114 - support MMS134S")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Reviewed-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://patch.msgid.link/20260616050912.1531241-1-dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/mms114.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 9fa3b0e421be2a..dac9fadaf87355 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -196,7 +196,9 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	struct mms114_data *data = dev_id;
 	struct input_dev *input_dev = data->input_dev;
 	struct mms114_touch touch[MMS114_MAX_TOUCH];
+	struct mms114_touch *t;
 	int packet_size;
+	int event_size;
 	int touch_size;
 	int index;
 	int error;
@@ -214,17 +216,22 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
-		touch_size = packet_size / MMS136_EVENT_SIZE;
+		event_size = MMS136_EVENT_SIZE;
 	else
-		touch_size = packet_size / MMS114_EVENT_SIZE;
+		event_size = MMS114_EVENT_SIZE;
+
+	touch_size = packet_size / event_size;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
 			(u8 *)touch);
 	if (error < 0)
 		goto out;
 
-	for (index = 0; index < touch_size; index++)
-		mms114_process_mt(data, touch + index);
+	for (index = 0; index < touch_size; index++) {
+		t = (struct mms114_touch *)((u8 *)touch + index * event_size);
+
+		mms114_process_mt(data, t);
+	}
 
 	input_mt_report_pointer_emulation(data->input_dev, true);
 	input_sync(data->input_dev);
-- 
2.53.0

