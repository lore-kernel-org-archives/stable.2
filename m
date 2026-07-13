Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AC3911A8;
	Mon, 13 Jul 2026 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929086; cv=pass; b=t99N6KtUntvxVvgyglICqby19BU4kFnVMBes/GCdCmaFbJWTqvBL8It+zNDhpLLpNgteAm2UXcUtI4HB9228aNeZuZjHm5OLskiwVgfwlt3S68mfavPLxH9PonnXeYTOUmCccDAXdY5MNGU9sW6NKmYuZ7ZQiDQDxHT+5je+Txs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929086; c=relaxed/simple;
	bh=Zn9yp04dkxcptICWzcylSB2YzRs1BmVv0mxKAOMhbIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFgkmJh+IGHs/9Haffe3jpDQVrUGsYQYW/T/nkIxddAX8J88kg+1aBH2T2QBFYwT32VGCwPYydIKIlXc5xOhvgzfqLA9qSdoT3tXGfnqF9ksPXxbE4dRWIG1EvNhaNZg68wL1miVhuZzyo7Ih03CD0k8wsKJ3oYLuveWgmO0/38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=SZH76zsB; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="SZH76zsB"
ARC-Seal: i=1; a=rsa-sha256; t=1783929076; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=a+OIq9XkmEcFpuvC/8whmc1brhOc+kdLqw4DE/oQy4BXQETsxoibMhYSPWKk1xudwxV3WNyjbz3NmhtPUaacBLAfsFHkt4EZbNZSqg1NuLjXdVI8AAz0ey6RBLYD0IpY2krXhGXLB9JqnV0MBDuWI6C8MiRZ3oficNz8CR9eh64=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783929076; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=puQfJUbqWOxh3XTCnl2QiqtxHk9PU07MjOqSaUFegmU=; 
	b=jtTcm8m3SriHxdUOGc0wUbBI8t2wAbhb27+UKWP5hC7YfYoETegTS0ox8pHjeJ6tJyWPoPsCI7AgZNZFEwsLx2AugE+sZp9PgB5Zb0/82YbLtbKwiNdZ5YGRe23AFITFFTCEEoLxaG+FuakFjljq1c8IeyBg+ID2FK+FU5de93c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783929076;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=puQfJUbqWOxh3XTCnl2QiqtxHk9PU07MjOqSaUFegmU=;
	b=SZH76zsBo5oqoJvb5C8mFhcMTFkWsQ4SOf9aBCA2C3vdnaybAoqp5+at476dP+dE
	wGFHQLmEzYd5/c6/NXKspAAY5QSf4/O8dBbKIYgvLY6LqB/mR/ju4Ro1dOCXvv5UwRZ
	CQZBgOxKZJiAqwANQAboAbYH4ChRJesbsCaYvyJU=
Received: by mx.zoho.eu with SMTPS id 1783929073212890.3778375842252;
	Mon, 13 Jul 2026 09:51:13 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: wacom: validate report length before Intuos Pro2 BT pen parse
Date: Mon, 13 Jul 2026 09:51:10 +0200
Message-ID: <20260713075110.92469-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

wacom_intuos_pro2_bt_irq() receives the wire report length in `len`
but never consults it before calling wacom_intuos_pro2_bt_pen(). The
only admission check on this path is the report-id byte:

	if (data[0] != 0x80 && data[0] != 0x81) {
		...
		return 0;
	}
	wacom_intuos_pro2_bt_pen(wacom);

wacom_intuos_pro2_bt_pen() itself does not even receive `len` (it
takes only `struct wacom_wac *wacom`), so it cannot bound its own
reads. For INTUOSP2_BT / INTUOSP2S_BT devices it unconditionally does:

	wacom->serial[0] = get_unaligned_le64(&data[99]);
	wacom->id[0]     = get_unaligned_le16(&data[107]);

i.e. it reads up to offset 108 regardless of how many bytes the
peripheral actually sent. features.type is selected from the VID/PID
id_table entry (BT_DEVICE_WACOM(0x361) -> INTUOSP2_BT) and
wacom_setup_device_quirks() force-registers the pen/pad/touch inputs
for that type independent of the report descriptor, so a malicious or
malfunctioning paired/spoofed Bluetooth peripheral can advertise that
VID/PID and send an undersized report (e.g. 10 bytes) that still
satisfies the data[0] == 0x80/0x81 gate. The driver then reads past
the received report and forwards the bytes to userspace via evdev
(MSC_SERIAL / ABS_MISC on the pen input node), an out-of-bounds read
with a concrete userspace read-back channel, and a true
out-of-bounds read on transports where the backing buffer is sized to
the (small) report descriptor rather than a fixed-size staging
buffer.

The non-Pro2 branch of the same function (INTUOSHT3_BT, reading
&data[33]/&data[41]) has the identical defect at a smaller offset.

This is the same class of bug commit 2f1763f62909 ("HID: wacom: fix
out-of-bounds read in wacom_intuos_bt_irq") already hardened in the
sibling function wacom_intuos_bt_irq(), which added explicit
short-report guards before parsing:

	case 0x04:
		if (len < 32) {
			dev_warn(..., "Report 0x04 too short: %zu bytes\n", len);
			break;
		}
		wacom_intuos_bt_process_data(wacom, data + i);
		...
	case 0x03:
		if (i == 1 && len < 22) {
			dev_warn(..., "Report 0x03 too short: %zu bytes\n", len);
			break;
		}

wacom_intuos_pro2_bt_irq() never received the analogous guard.

Fix it the same way: before calling wacom_intuos_pro2_bt_pen(), check
`len` against the minimum size each branch of that function actually
dereferences (109 bytes for INTUOSP2_BT/INTUOSP2S_BT, whose furthest
read is &data[107] as a le16 -> byte index 108; 43 bytes for the
INTUOSHT3_BT ("gen3") branch, whose furthest read is &data[41] as a
le16 -> byte index 42). On a short report, warn and bail out before
touching wacom->data past what was actually received, exactly as
wacom_intuos_bt_irq() now does for its own report ids. Returning 0
here also skips the subsequent pro2 touch/pad/battery calls for the
same malformed report, which is the safe, conservative behavior.

Runtime-verified on a v6.19 stand: injecting the truncated report
via a spoofed 056a:0361 BT peripheral leaks bytes past the declared
report length to the pen evdev node (MSC_SERIAL / ABS_MISC) before
this fix, and the same input is rejected by the new length check
with no leaked event afterward. KASAN itself stays quiet on the
fixed-size uhid staging buffer used to inject the report (the
over-read there lands in-object); on a descriptor-sized USB/BT
buffer the identical read crosses the slab boundary and is a
genuine KASAN-visible out-of-bounds read.

Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/hid/wacom_wac.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625..89a191cf1924 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1548,6 +1548,19 @@ static int wacom_intuos_pro2_bt_irq(struct wacom_wac *wacom, size_t len)
 		return 0;
 	}
 
+	if (wacom->features.type == INTUOSP2_BT ||
+	    wacom->features.type == INTUOSP2S_BT) {
+		if (len < 109) {
+			dev_warn(wacom->pen_input->dev.parent,
+				 "Pro2 BT report too short: %zu bytes\n", len);
+			return 0;
+		}
+	} else if (len < 43) {
+		dev_warn(wacom->pen_input->dev.parent,
+			 "Pro2 BT report too short: %zu bytes\n", len);
+		return 0;
+	}
+
 	wacom_intuos_pro2_bt_pen(wacom);
 	if (wacom->features.type == INTUOSP2_BT ||
 	    wacom->features.type == INTUOSP2S_BT) {
-- 
2.50.1 (Apple Git-155)

