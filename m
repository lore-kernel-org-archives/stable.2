Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013D39524E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451095; cv=none; b=mOWRg3thkDoUbotr9ypMyNbj1my5zh0F+ooXYeuzDWaWgF/KrogEDvE9/55uy2h0VLr8jmgFlByU6ApyvvLqb4tqPWdbQIFWIeD2nsHq/sgiFsn/uRa0iDalV28MwZewE4gSQa6rGzGSAZkxQfYM3NkNdTzp0E5zbsBoYLNfjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451095; c=relaxed/simple;
	bh=zgJ9AtTdSIkQ90Om/CXas7Dimf0BgqPsiJZ4DNoz7BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rg3NnhdCGCQ0oA3YIuWoATWPKwRj49lCJj5Zu81xGC4h9EQhC1XK9LlHr90aTxjiuffvUlBY3LDEd6fU1vowKXYShy2DHvE8po7ig2vIeGYDcMyn7CbcrMNNOAzlQwN+SZQaihC8sdkiB/6LfGvCkVPoVZLzlETKUo+9o6nBLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j14dNrE5; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j14dNrE5"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b6dad2382so1285040eec.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 22:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451094; x=1783055894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qxi0SvECdeeSU5h+tXAOyWZUcGzGjMbcI09ZL3GmHI=;
        b=j14dNrE55HWrb7y4itIyEIo3viNAlqHSI+3E03wVpdcJkHPu7nB1Inh/E0VdaZFwy8
         EEq3I0Jf4tCgYl9KMRQuzSQI2F2msuAcDfLcXfVCkoYhoXDoQa4vGLZgffFQDnbqmWYf
         n/FK4ZvKFSATRldWJ1H4SUi9dVAYZB3IQFfEuXN3F9lK+LkZbSuIDMFeIBDqsC7Y8BTl
         sHyQ/p+I901qBahedP8l8mVEph5ogNJHLYjeC+4mSmKWeFeZAtq0JADWRlOxQMyszYC9
         DRkiKpJa+8MtxPiPPTjbB9TR9PKB1nd7WwuS37VkQrjgwGwwaENu1Jw49Jp0P2iFgsKH
         uTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451094; x=1783055894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Qxi0SvECdeeSU5h+tXAOyWZUcGzGjMbcI09ZL3GmHI=;
        b=XuSJXzQBRKPCs4XvBDqG6yIYO3dcdjzQzYoWaqK5qSlWW1wytISCgMON+w2N56u9t3
         QbwRjtc1aPeJMnV24caAJN7PDmS0MZzlcqpQgtRGTf11dAfAtdMh9oFu7PnR7iPpJ43w
         kwrwbDQffFtV1tEKLC63ld9mBqs2FaSv9eW5eY0Eal6MF58sOe4cVyL1nrMGEZPOMz3t
         e0BadmwiSl9WBAp+YN0OIqWBrq9VQVA0/s9eBa38vwLn0h1f+rkZFtbYIE8zqltUXQyG
         xNwmrHj4MK4Xl7xPsVOz+1i6IXq+tO7645aJz1ICDZ8nqm8LcDUgEObmZdftuUuLfVJX
         VSbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/vsP7RXEj/lzclaxo9Ct7SzwcQWHziW/ZLoAo7Y8PqLjlsiEpDOntangZDmpjSJ+9Qf6csAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqbrHmR/YZsLsP0HnA2wazQj7qHnaO/pcjbc5+Jdwq09UJ7Lfq
	AE0JjDgFvhZ8/DT32VfuU0seynubldF0Sa2ClJJP3OJrJvL4KhfDDCZN
X-Gm-Gg: AfdE7cnYxO+6hQJ9DnkZBNB7iG/PNAaJ5f7tMe0TymUL+ldI+LG9XYq2Oy47LvE+k9I
	6VdERyo+q3lz5tZDgxPXrABjlsqR1xN3C7ib39lRpFwMlnQiml1F8QHmw4DebnC+XFWGZSUtHpb
	3kNXUREO+3Xenp28qqdoT9Y0yl8NBh2NRWJCJK7hRfqA7OaRJoQUVDlUT5kgNQpkhAdpTYo9wvr
	AOxEWRYGHx3ybESPx8+QTsXm/ljVVOKJUjZs5vSPMFMvxYMSLE05lUmZp4loKRHY3Bevdg4a2qh
	bXPfNTVRe8Zs2fJTSrkBld7Zbvh9Gsyi6N5wRsifgSGznaWpi/UoEe49o3T6WUWhFJqzMZ0ESms
	nYA21hNmbzHzkBN8vouLRLyP2wWJuaopEy7G1te8jssBSPndPtTlztq5Iz5vymnF2e76nIJi2KV
	ujeqfGYEqH/7K1A+jJh7smqk6INwU7IiFtYMTr1ROG3XtabaHAoFCrl92Kl1RawAi/y/CvHobGA
	gw6
X-Received: by 2002:a05:7300:e6c6:b0:2be:833c:149d with SMTP id 5a478bee46e88-30c84d46fcfmr5444139eec.28.1782451093588;
        Thu, 25 Jun 2026 22:18:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/10] Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue
Date: Thu, 25 Jun 2026 22:17:55 -0700
Message-ID: <20260626051802.4033172-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, rmi_f54_buffer_queue() waited for the worker thread to
finish but ignored whether it succeeded. If the worker failed (e.g.,
due to a timeout or register read failure), the queue thread would
silently return success, delivering stale or uninitialized memory to
userspace.

Add a 'report_error' field to struct f54_data to store the worker's exit
status. Check this field in rmi_f54_buffer_queue() after the worker
finishes, and mark the buffer as VB2_BUF_STATE_ERROR if an error
occurred.

Fixes: 3a762dbd5347 ("Input: synaptics-rmi4 - add support for F54 diagnostics")
Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index e86dfc9ce7d9..c86bc81845bb 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -106,6 +106,7 @@ struct f54_data {
 	u8 *report_data;
 	size_t max_report_size;
 	int report_size;
+	int report_error;
 
 	bool is_busy;
 	struct mutex status_mutex;
@@ -340,6 +341,12 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 		mutex_lock(&f54->data_mutex);
 	}
 
+	if (f54->report_error) {
+		dev_err(&f54->fn->dev, "Error acquiring report: %d\n", f54->report_error);
+		state = VB2_BUF_STATE_ERROR;
+		goto data_done;
+	}
+
 	ptr = vb2_plane_vaddr(vb, 0);
 	if (!ptr) {
 		dev_err(&f54->fn->dev, "Error acquiring frame ptr\n");
@@ -610,6 +617,7 @@ static void rmi_f54_work(struct work_struct *work)
 		report_size = 0;
 
 	f54->report_size = report_size;
+	f54->report_error = error;
 
 	if (report_size == 0 && !error) {
 		queue_delayed_work(f54->workqueue, &f54->work,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

