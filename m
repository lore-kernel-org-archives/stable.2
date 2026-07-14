Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688543A7F4B;
	Tue, 14 Jul 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050802; cv=pass; b=BLm3XZQcfWW33gws9S3dfnJEEXy6g4XuQ8jwNsQIADeX0vL2cTwA23RURVDSDDrrFA3UeThWGMF8V0RbhThv3EEDXReYHz5IeUNt0NfA+58ot5M6nSG0/dT4EyE7gA4I6mLHFt1fHIV9bqj1b7ECllfbcrih1ZVOq/uO/MPOEgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050802; c=relaxed/simple;
	bh=psdTSGF3AKaU67y+gQSLLEMXasE1wXT987xSlmhpyrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyB+1pYqorEi8t520NxtFEHUkOQ3cDayEoYjFhmG+VBU7dbwuSEPQLulkHm9eEIdGbKAzHIUhlW1pFwEQ+Tksy5+FQ57pOVQkHl3PQBtwTiqD5s09nDk7vfkKwSHfhuulawYUuG4bHUsiaxmkwPHIXlfC8n9VhJMubXKQCsZFdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=iD7OvwSq; arc=pass smtp.client-ip=136.143.169.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="iD7OvwSq"
ARC-Seal: i=1; a=rsa-sha256; t=1784050791; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=L8WeP8q9Ox7GjzwsAMHqW0IK2uYhn49P3F4Lr9J8x61MQK1RA6ag3f8MKhxntoZT91DDsTdqTUDtOn6wQGCQZcBPeuwr7Nzh8FJTp1mVkLwkNhWqQ2cuFKQqCfgpwLZRC4rNieWZ7oM3dVxIUT0TynrhdTNIHFRFpVUDlsO4Sjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784050791; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zFqWeZ3Jt02eSvrNeae5L96Sq+f9ZDi+/NYNKF2lYa4=; 
	b=BUyeVuTVtczmiS8z0zVBTC4vRjGvSD56sto0srgQcTNvL0vVFdIrAlpbb3GY0KMztEHovboPOBtYvxwWg5bCniKGsHgHhasTBdNsCYpoQEDBapNY9xZ98P1lC2fwG/MrSJVlPkmTGxvfycUqeqJsE9LGTjp//zlY+LwZ9CpwSjs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784050791;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zFqWeZ3Jt02eSvrNeae5L96Sq+f9ZDi+/NYNKF2lYa4=;
	b=iD7OvwSqQInDfUCjRUglxFZpGtnweUONh70GNz8sHTb7YpUb78xmzWfbwpsIIYd5
	l2L6GjQvvBT2yHWzvnIxzfmHACKJc6aNUMfqhrH4QBpTFB14MPFmfwRfZspCveC8a7b
	hh2/7JA0bYhqBGZUDIcod/hdvLMFHYjGIXSD3/1w=
Received: by mx.zoho.eu with SMTPS id 1784050788969306.9952263238945;
	Tue, 14 Jul 2026 19:39:48 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: uclogic: fix use-after-free of inrange_timer on remove
Date: Tue, 14 Jul 2026 19:39:46 +0200
Message-ID: <20260714173946.73773-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713121042.2321-1-security@auditcode.ai>
References: <20260713121042.2321-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

uclogic_remove() cancels the pen in-range timer and then stops the
device:

	timer_delete_sync(&drvdata->inrange_timer);
	hid_hw_stop(hdev);

timer_delete_sync() only guarantees the timer is idle at that instant.
uclogic_raw_event_pen() keeps delivering pen reports until hid_hw_stop()
stops the transport several lines later, and every report with
pen->inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE re-arms the timer:

	mod_timer(&drvdata->inrange_timer, jiffies + msecs_to_jiffies(100));

A report landing between the timer_delete_sync() call and the transport
teardown in hid_hw_stop() re-arms inrange_timer after it was cancelled.
uclogic_remove() then returns and the devm drvdata is freed, while
hid_hw_stop() has already freed the input device drvdata->pen_input
points at, so when the timer fires ~100 ms later
uclogic_inrange_timeout() dereferences freed memory -- a use-after-free
in timer-softirq context.

Swapping the two calls is not a fix: stopping the device first frees
drvdata->pen_input via hidinput_disconnect() while the timer may still
be pending, so a timer already armed before removal fires on the freed
input device in the window before timer_delete_sync() runs.

Use timer_shutdown_sync() before hid_hw_stop() instead. It cancels the
timer, waits for a running callback while pen_input is still valid, and
prevents any further re-arming -- a later mod_timer() from an in-flight
report is silently ignored -- so the timer is provably dead before
hid_hw_stop() frees the inputs. This is the ordering the timer core
documents for this "timer re-armed from another path" teardown case.

Fixes: 01309e29eb95 ("HID: uclogic: Support in-range reporting emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v2: v1 reordered hid_hw_stop() before timer_delete_sync(), which traded
    the re-arm use-after-free for one on the freed input device (thanks
    to sashiko-bot for spotting it). Keep the original order and use
    timer_shutdown_sync() to disarm the timer, which closes the re-arm
    race without ever touching pen_input after it is freed.

 drivers/hid/hid-uclogic-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b73f09d26688..0b8a83fa6c5b 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -548,7 +548,17 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&drvdata->inrange_timer);
+	/*
+	 * Shut the in-range timer down before stopping the device.
+	 * uclogic_raw_event_pen() re-arms inrange_timer on every pen report
+	 * and keeps running until hid_hw_stop() stops the transport, so a
+	 * plain timer_delete_sync() here can be undone by a report landing in
+	 * the window before hid_hw_stop().  timer_shutdown_sync() cancels the
+	 * timer and makes any later re-arm a no-op, so it is provably dead
+	 * before hid_hw_stop() frees the input device drvdata->pen_input
+	 * points at.
+	 */
+	timer_shutdown_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);
-- 
2.50.1 (Apple Git-155)
