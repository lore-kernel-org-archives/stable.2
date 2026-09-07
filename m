Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265F3B813C
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807018; cv=none; b=VbUSMA/UkOaROhJvOBPw4xXknqtMyb0J/RnR3OCKjuQRr5sQuwI3V8nthrIxvsPPuGpf7eZykrALYS7r5ShWKq7dqZmHTY1QL21UMJOrMS3GS//D5SMGfbP5YIW0zXlqNHGOd7rgeDFsFcfuE+XeaLEelw9mJJj72HEOsokVX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807018; c=relaxed/simple;
	bh=J9BZRX6oP1MPxPyLTPWVaWjRNa4HUnYcg26VY3Rb6Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nwd2KZfT8hXlpki7H1t9f4EEz0PLLLx9kaCs+8SDU2W+EgAte5erNHRLLzhhniYXusXtTrLElSB4EGFYT/5QKt7R5qj+6nvsVIZM/m6cGWSJVQCSG4dmL7cBZWdKmMBb3s4Jz7xiecrQSI31jahyannWsGFzSrBEgm9cxiuIAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEJve51b; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEJve51b"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1740e4so1740755e9.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788807004; x=1789411804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOfBbKNvf4wumPkciSn2R6wvTiBsYFrhYc9rrrbfPSA=;
        b=JEJve51ba4qmTYywtPrxmTgZDV+nx4L6v/EyhZZ1UBWMZDVUXMZVzNWpfZlfGkOm8B
         htGgT+WhPbUI3EVRc9DhocNSUlJKktQPMiY/VWiGX9f3m93iMuTX5kwEaqr9Au1FfwGn
         RoBHwY74HEhpMSUv8EdKs2wl62WkQ5TR/Ba4wwoSJxKes4avtnRDhky7RBRN6775U7ZE
         pvRBoJKxtUYO6yCgep9dzxgjjQzAYh3bNV+VTQwLJ7mQPc87KPSJjJpG+Ifk+Ijk57kc
         imjfcc/cw3VzI6iw0ZWzHJr4M/Z8RNDdAGh1NNfa2gvMIGpDgizfHFQt37sw5GobY+4X
         Gr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788807004; x=1789411804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOfBbKNvf4wumPkciSn2R6wvTiBsYFrhYc9rrrbfPSA=;
        b=Wj2PqGUcJoG0Zih8NFt0AdYewhJZLZdRw7bNUquZ/+j9+XpC8YD88thfDw7jYoa5JP
         P8kRXHBE9nrmqn7LhZvuPebnLQwwC9XUDmdWOSSoAf5CXPxvW8sx7esDy+mlrEpQXIJy
         dNSehV0Mlxq16d/Sg+NnnAu2sGixlyQXGFeTYU43NOQ/sst9dEJJmMcQBqzI20TDXOq/
         ALv9qWr72/c0CAUGQEMgSyL2W3TKqPb9r+4Vattju7KJt8TUJJ/T2YoonhEg89mONHu1
         ptUlHkg4W6XU37tumfNh48eLwrMT5wyDiTKqTJXLH7sOXJ9uagRhVk4CnfyXci20+pFl
         t8UQ==
X-Gm-Message-State: AFuF++npZ7N4ogu5HcKlv5I/PJ+fCjtZttdLVhVw8gT1zHupXK2+yeda
	3T+AeyFSG/HjkwBvWKUUA/5jqVTSaH5Ho0KguqpMyN6J6abEkj+c1c3qwRisY8xiisXoAw==
X-Gm-Gg: AYBFou1RB9HXpXsdcghaPjWab8Ydz3qYNVlnh3r0/ps6xFM7rEzgQLxOd3w6W4BDZ+2
	kOnREMH+FPuMa+kMcfD+g1Hut4KOwPic/C0aTr5N0F0A5wiGmy7RVsI7L/KJACQl0WWyLHbFRmr
	wsSiikf4lovDj7a3lDIjKVZ4T/RKWQfsjimE4XEeLxV7WN6Na0tTswum2HM8nKL/PgqYMYAq2eQ
	KFH0hs3hV01qQ+Wt9No+DE5cDIgxYLwdN72f0THwYP49cdCMyowyqJINMiR2xKF62jlmMWuyDZx
	YBzGPq1Dl0gsiZVSDFKzakkX+WpoQ4g7a/t8vlY90wEA/P/P/6UhaF1xtiWzjT2iDW1AvIu2mEj
	z2Ober+FEUI573Q1+Zu7afuyLQp+AXspayLswEWqsttLeNgs/jbY2zYlGOST9YyH7JfkHZlrjc7
	1KKEZQqJMBDvV3D07vYChEPaStbZqlkmQM2b020jscnM5NbQ24p/qsRkDyKEX67G2foGjWylCd4
	pFeA7uXss3NOkKxN4TBDwmFSbg/YisDAwu+0pM6oUoES6X+wTj+6WR0D5iduefkip/9+PIgzDlF
	Wtbsm0owLe8RWA==
X-Received: by 2002:a05:600c:a305:b0:49c:ff81:e062 with SMTP id 5b1f17b1804b1-49cff81e076mr147773075e9.2.1788807003690;
        Mon, 07 Sep 2026 11:50:03 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce591f846sm203600315e9.1.2026.09.07.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:50:03 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] Input: aiptek - validate raw macro indices before updating state
Date: Mon,  7 Sep 2026 20:50:01 +0200
Message-ID: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

aiptek_irq() derives macro key indices directly from tablet reports and
then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
the derived value in aiptek->lastMacro and later use that state to
release the previous key.

Validate the raw macro index once before it enters that state machine, so
lastMacro only ever stores an in-range macro key. Keep direct bounds
checks for report type 6, which reads the macro number from the packet
body and uses it immediately.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn
[dtor: fix macro fallback in report 5s to use -1]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
(cherry picked from commit 95dffe32a66cbed07fbfa7afed39d56d5014e04f)
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 drivers/input/tablet/aiptek.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index baabc51547b83..6210cd99d6291 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -658,6 +658,8 @@ static void aiptek_irq(struct urb *urb)
 		pck = (data[1] & aiptek->curSetting.stylusButtonUpper) != 0 ? 1 : 0;
 
 		macro = dv && p && tip && !(data[3] & 1) ? (data[3] >> 1) : -1;
+		if (macro >= ARRAY_SIZE(macroKeyEvents))
+			macro = -1;
 		z = get_unaligned_le16(data + 4);
 
 		if (dv) {
@@ -699,7 +701,9 @@ static void aiptek_irq(struct urb *urb)
 		left = (data[1]& aiptek->curSetting.mouseButtonLeft) != 0 ? 1 : 0;
 		right = (data[1] & aiptek->curSetting.mouseButtonRight) != 0 ? 1 : 0;
 		middle = (data[1] & aiptek->curSetting.mouseButtonMiddle) != 0 ? 1 : 0;
-		macro = dv && p && left && !(data[3] & 1) ? (data[3] >> 1) : 0;
+		macro = dv && p && left && !(data[3] & 1) ? (data[3] >> 1) : -1;
+		if (macro >= ARRAY_SIZE(macroKeyEvents))
+			macro = -1;
 
 		if (dv) {
 		        /* If the selected tool changed, reset the old
@@ -737,11 +741,11 @@ static void aiptek_irq(struct urb *urb)
 	 */
 	else if (data[0] == 6) {
 		macro = get_unaligned_le16(data + 1);
-		if (macro > 0) {
+		if (macro > 0 && macro - 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro - 1],
 					 0);
 		}
-		if (macro < 25) {
+		if (macro + 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro + 1],
 					 0);
 		}
@@ -760,7 +764,8 @@ static void aiptek_irq(struct urb *urb)
 				aiptek->curSetting.toolMode;
 		}
 
-		input_report_key(inputdev, macroKeyEvents[macro], 1);
+		if (macro < ARRAY_SIZE(macroKeyEvents))
+			input_report_key(inputdev, macroKeyEvents[macro], 1);
 		input_report_abs(inputdev, ABS_MISC,
 				 1 | AIPTEK_REPORT_TOOL_UNKNOWN);
 		input_sync(inputdev);
-- 
2.43.0

