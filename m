Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3D314D05
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758398; cv=none; b=mJcsBwNTjmXEKd92T/jiLAe1y04mRDRtdt8+1rWsrJXlsWoxsLtKW8zstxjKNYrboh9nxwWZow8SqmCoYv3JutAvkiZaQnqqmbuZOEsnY0iZa5Bp2daWS6nzcBrwxf++57soQRFC3+oG9LWf1Qisex4RkfQu2ym5AQO0L64e+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758398; c=relaxed/simple;
	bh=6/kUeBVLIQBCAC+VTNsg6tbxZefohlGjIrXL6j4mjIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHd8zkTAbg6YBzrey7ZFgOI0h6rGAWIZLt/FSxBgO8yWzyuzlCG5vbUJoL8cVCkqdn1k7E9khIXxIWjmp9UQeFENZrZzvDUIEvO9QZK9Erl7NzCJMZChdA04lftJ0dbwTrQk32soAsqw31MmZrbqiZixqGSJMelyfdVtNbv8z2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvhlp1kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvhlp1kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE361F000E9;
	Wed, 26 Aug 2026 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787758395;
	bh=ZJSBls3YqMNYyebZKQjpnXzq/cMsRm2N7PAzNR5j3UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lvhlp1kxrbKDxISJwrdCvWIEW6mI2gA/gXP9EVh3o9lpqeEORS0RDncyiCfk8D/hK
	 Z6s4+QJp/qNYkWh/HGn+jdz9CQZ89H4t18C9C28uv5z4HEtKJtUSuHMH9v0QVUSyxV
	 nd+1+9Xg9pyLEeGvh7T++v4aNBwGQxPdJpL+rr9uTy4GUhcY1ui+Lq4QuITBTWGzQm
	 rRW3YxDIDjvzLL7WziMQ9q98qaWfWv+t2iEzbVcLRkflua3wato2dcaJVtjgJ3iUAU
	 VpP/n09AH73eFw2TkuVkQY48bA5w17W3EwNDe3uUJ6bFc8uzjoiPjZPBGzlqBhLoQf
	 4Lp/7q/LDnWsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ibrahim Hashimov <security@auditcode.ai>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] HID: uclogic: fix use-after-free of inrange_timer on remove
Date: Wed, 26 Aug 2026 11:33:13 -0400
Message-ID: <20260826153313.1183802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082555-mummify-culprit-6c6b@gregkh>
References: <2026082555-mummify-culprit-6c6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Hashimov <security@auditcode.ai>

[ Upstream commit 506fd50a9027340f0e9dcc587d10ccb03312dba6 ]

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
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ changed timer_delete_sync() to del_timer_sync() in the removed line to match the pre-rename API on this branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-uclogic-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index f8708a1ec7cc8..f901a014bcd21 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -477,7 +477,17 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	del_timer_sync(&drvdata->inrange_timer);
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
2.53.0

