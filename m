Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B83F5BC3;
	Mon, 13 Jul 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944670; cv=pass; b=h75E+O7JwZkXPXC2ys4D6Hehl8Dd90XJBzLjQi0/rDyUc+Vu6tSJGCOFt0S1gY1VUU/TiNwhrhFuv39V0inZHa2Tt2wWWI2BPuAZD9yQ1HioEUrWhqETHmG8b/LclolJMPN0jfBlvNe5khHM3Ij3mOkKpbYXEhrNn/uvCWyqvNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944670; c=relaxed/simple;
	bh=eyC6E6rAQIJvXAoC3kgFpROkc3vW87dqCeNfC07usuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzmiZOX1BRQo/yqr0tp5YpY0PyUALJ0o+ElnGNb9pyQcpMVA7Gkn1UB/JIE0TfJAp8HS1lr0YrU6AKa+H8CUFPv2kCHZFSJ4EadQ/ODKlnCfCEh/y8AICjHdvp5LmIXv3zJlyscttg6oDpOQn4r/TwTOSfCbfN8BFz500dd5RwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=YH29eaz7; arc=pass smtp.client-ip=136.143.169.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="YH29eaz7"
ARC-Seal: i=1; a=rsa-sha256; t=1783944649; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LjLu0x6S4hgedUWJn7eqyQiVuVNnIx945mZeQUAJrvS7I1eVUliKrOQr1yENnInyYbRiZgxe7drJbP8DxRAkerrJD/w+cwOEL5vaOu6F5ldVqNnphzbW/TbaFzkFmaXPiL1cVZAphMlUgqf4+mHOq5vBVBWlC2D2CHOaFuiom4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783944649; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E8kYnuZ+mHqqG240DydatPnqdSkhqOIaQs/TCFDdQSw=; 
	b=gAB6mrbLMMTqWW+YeUZCBw+38qv5T2Umke5aA5M12eOVBbIZzOOEuW7t1TAfWe5wnh9H+DCv/uzKUxCrvrFBtxVCBryZlJ302+ofopxvOxtfgeyql30WnL9JTyc+8LlFUy9Dgkui5TV0Rb/Bcj0EqkjQ7S2Go9DPAT5H61bbMoU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783944648;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=E8kYnuZ+mHqqG240DydatPnqdSkhqOIaQs/TCFDdQSw=;
	b=YH29eaz7yw+l9WQfExl9/HvznRTQnkt7okxuvlyY04qxOVkfas6PhfoWOib+IMR/
	SM72yQeSeR8lT0fN2kCx2mYpvtZyPF0L5d7w/BT1XG/0EJjnGEi6nWrHpbJZtlyg5uU
	KOsdw5a9hvb3P01zBvZO8u+LdSgWszRacjvBBoKk=
Received: by mx.zoho.eu with SMTPS id 1783944646279710.6326150205985;
	Mon, 13 Jul 2026 14:10:46 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: uclogic: fix use-after-free of inrange_timer on remove
Date: Mon, 13 Jul 2026 14:10:42 +0200
Message-ID: <20260713121042.2321-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

uclogic_remove() tears down in the wrong order:

	timer_delete_sync(&drvdata->inrange_timer);
	hid_hw_stop(hdev);

hid_hw_stop() is what actually quiesces the device: it calls
hid_disconnect() (which frees hid->inputs via hidinput_disconnect())
and only then stops the underlying transport, which is what finally
kills the still-submitted interrupt-IN URB. Until hid_hw_stop()
returns, the device can still deliver pen reports, and every pen
report with pen->inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE runs:

	mod_timer(&drvdata->inrange_timer, jiffies + msecs_to_jiffies(100));

from uclogic_raw_event_pen(). Calling timer_delete_sync() *before*
hid_hw_stop() only guarantees the timer is idle at that instant - it
does not guarantee it stays idle, because the report path that can
re-arm it is not shut off until hid_hw_stop() returns, several lines
later. A report landing in that window re-arms inrange_timer after
it was supposedly cancelled; uclogic_remove() then returns,
devm_kzalloc() frees drvdata (and hidinput_disconnect() has already
freed the input device drvdata->pen_input points at), and roughly
100 ms later uclogic_inrange_timeout() fires on that freed memory -
a use-after-free in timer-softirq context.

Reaching that window needs nothing exotic: a malicious or
malfunctioning UC-Logic/Huion USB device (or a manual sysfs unbind
racing in-flight reports from a legitimate one) delivering a single
pen report while uclogic_remove() is running is enough to retrigger
mod_timer() after the old timer_delete_sync() call.

Fix this the same way several other HID drivers whose timers are
re-armed from the report path already do it (e.g. hid-appleir.c's
key_up_timer, hid-nvidia-shield.c's psy_stats_timer,
hid-wiimote-core.c's timer, wacom_sys.c's idleprox_timer): quiesce
the hardware with hid_hw_stop() first, then delete the timer.
Once hid_hw_stop() has returned, uclogic_raw_event_pen() cannot run
again for this device, so the subsequent timer_delete_sync() is
guaranteed to be the last write to inrange_timer - there is no
window left in which a report can re-arm it.

This has been verified at runtime on a v6.19 KASAN-instrumented
kernel: a synthesized malicious USB UC-Logic device flooding pen
reports across uclogic_remove() reliably trips a KASAN use-after-free
on the freed hid->inputs list before this fix, in usbhid's
hid_check_keys_pressed()/hid_irq_in() report-delivery path rather
than in uclogic_inrange_timeout() itself, because that synchronous
fault preempts the ~100 ms timer callback. This reorder closes the
inrange_timer race by construction (timer_delete_sync() is now
provably the last write to it), but that captured report-path fault
is a separate, core-level race in usbhid and is not fixed by this
driver-local change.

Fixes: 01309e29eb95 ("HID: uclogic: Support in-range reporting emulation")
Cc: stable@vger.kernel.org
</content>

Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/hid/hid-uclogic-core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b73f09d26688..925178d8feb4 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -548,8 +548,35 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&drvdata->inrange_timer);
+	/*
+	 * Quiesce the device, and the report-delivery path it feeds, before
+	 * tearing down anything the report path can still touch.
+	 *
+	 * hid_hw_stop() disconnects hid->inputs (hid_disconnect() ->
+	 * hidinput_disconnect()) and stops the underlying transport. Only
+	 * once it has returned is uclogic_raw_event_pen() guaranteed unable
+	 * to run again, since that is the only place inrange_timer gets
+	 * re-armed (mod_timer() on every report while pen->inrange ==
+	 * UCLOGIC_PARAMS_PEN_INRANGE_NONE).
+	 *
+	 * Calling timer_delete_sync() first, as the old order did, cancels
+	 * the timer while the device can still deliver reports: a report
+	 * processed between the timer_delete_sync() call and the eventual
+	 * URB shutdown inside hid_hw_stop() re-arms inrange_timer, which is
+	 * now left pending across the devm_kzalloc()'d drvdata (and
+	 * drvdata->pen_input) being freed. uclogic_inrange_timeout() then
+	 * fires ~100 ms later on freed memory.
+	 *
+	 * Stopping the hardware first and only then deleting the timer
+	 * closes that window: hid_hw_stop() will not return until the
+	 * device can no longer feed uclogic_raw_event_pen(), so the
+	 * timer_delete_sync() call below is guaranteed to be the last write
+	 * to inrange_timer. This also matches the ordering already used by
+	 * other HID drivers whose timers are re-armed from the report path,
+	 * e.g. hid-appleir.c's key_up_timer.
+	 */
 	hid_hw_stop(hdev);
+	timer_delete_sync(&drvdata->inrange_timer);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);
 }
-- 
2.50.1 (Apple Git-155)

