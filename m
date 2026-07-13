Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC61366049;
	Mon, 13 Jul 2026 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935275; cv=pass; b=NPMo7gt1ac0e6gnwUfPRmg3YZeTDAMxo6nsSWzOhnVWGQq99+E6V7cwko73AOgcfpMaJua/o1PiEEUPBWcPCIyefetbZA45+hshMICozNodqKDXErzmN+3g1m+G5H01/SOzUz45Nqt1q8zetc0QdmzKzCBTRCFJS8wG8vUQfoZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935275; c=relaxed/simple;
	bh=aI2snIxBkk9bC3if3m1q/t4LctgZvdI6D3B4XIq2fws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpbu//AiYYE1V68aRoiHIq1Grbcl58bUajaYDRhg7efUl2gacYvic4EXAWENvn/oYjCcAXB4UDxvxis72Zj6ak4M58afce26CUFznNcifTvrK1LhHGWX49Ck90j03jP4i3JG3SOrLE2yvCLJ3j7gNDElyYGdml50bRVuocVUfXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=PrVluWd4; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="PrVluWd4"
ARC-Seal: i=1; a=rsa-sha256; t=1783935261; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Y2tWkfr2Jz/iI2UFhB37I8CynRf2UD7OipcHxLlmI/3+iFRm85D7xPnQDBt940vqLlBA3HfRAY2qkxURzyv0zmEyU+BnyAFuHacb0gZDCF5C52EHV70zG23PTpQY4cZ6E147nBTwuiBM0N8pRqQmXgMSWAIUIIOAi755/qg0UDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783935261; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rbJgdoFUqriWY4hwVjte34Y9bPdfOX/gwrXpevsZhCM=; 
	b=eCw3aSMANGACznC4QIcClTgVdbdIq3XgO94gEobBRLn8SL6ua/j//XcnroCQLjn7vOkf8sgzOTzMN5y/a64AKaKsBh1LoXAntf0PzQT/JVjcKsPwLw6ipHOiEUzfGAZtfZB/k9CiKJxpbAUfn0It4JR2LyQ2cK9xhDnNblpHo6k=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783935261;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rbJgdoFUqriWY4hwVjte34Y9bPdfOX/gwrXpevsZhCM=;
	b=PrVluWd4Td2ALIFQA0depgNwgoDzMi9aUOQEIRQPXGGPnEEaVR/B1f8ugvaXkMaV
	VYGzUWCVCYn/fSeW+U7GGS96qRDguZcR/9gJxcduhSgbamRB5+hNXmAkoHbO3Blbbpl
	vdm1hMPuJ40aXEZRr449HLa2++JrYa2xcpRwJXqM=
Received: by mx.zoho.eu with SMTPS id 178393525824914.186354409364526;
	Mon, 13 Jul 2026 11:34:18 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: wacom: validate report length in wacom_intuos_pro2_bt_irq
Date: Mon, 13 Jul 2026 11:34:14 +0200
Message-ID: <20260713093414.94337-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713075110.92469-1-security@auditcode.ai>
References: <20260713075110.92469-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

wacom_intuos_pro2_bt_irq() receives the wire report length in `len`
but never consults it before parsing. After the report-id gate it
unconditionally calls wacom_intuos_pro2_bt_pen() and then, selected by
features.type, a fixed chain of sub-parsers, none of which receive
`len`:

	wacom_intuos_pro2_bt_pen(wacom);
	if (type == INTUOSP2_BT || type == INTUOSP2S_BT) {
		wacom_intuos_pro2_bt_touch(wacom);
		wacom_intuos_pro2_bt_pad(wacom);
		wacom_intuos_pro2_bt_battery(wacom);
	} else {
		wacom_intuos_gen3_bt_pad(wacom);
		wacom_intuos_gen3_bt_battery(wacom);
	}

Each sub-parser dereferences wacom->data at fixed offsets. The furthest
byte touched on each branch is:

  INTUOSP2_BT / INTUOSP2S_BT: wacom_intuos_pro2_bt_pad() reads data[285]
	(the touchring byte), so the report must be at least 286 bytes;
  INTUOSHT3_BT ("gen3"): wacom_intuos_gen3_bt_battery() reads data[45],
	so the report must be at least 46 bytes.

features.type is selected from the VID/PID id_table entry and
wacom_setup_device_quirks() force-registers the pen/pad/touch inputs
for that type independent of the report descriptor, so a malicious or
malfunctioning paired/spoofed Bluetooth peripheral can advertise that
VID/PID and send an undersized report that still satisfies the
data[0] == 0x80/0x81 gate. The driver then reads past the received
report and forwards the bytes to userspace via evdev (MSC_SERIAL /
ABS_MISC / ABS_WHEEL on the pen and pad input nodes), an out-of-bounds
read with a concrete userspace read-back channel, and a true
out-of-bounds read on transports whose backing buffer is sized to the
(small) report descriptor rather than a fixed-size staging buffer.

This is the same class of bug commit 2f1763f62909 ("HID: wacom: fix
out-of-bounds read in wacom_intuos_bt_irq") already hardened in the
sibling wacom_intuos_bt_irq(), which guards each report id against its
minimum length before parsing.

Guard wacom_intuos_pro2_bt_irq() the same way: before parsing, reject
reports shorter than the furthest offset the selected branch actually
dereferences, warn, and bail out. Because the whole pen/touch/pad/
battery chain runs unconditionally per branch, a single up-front check
against the maximum offset (286 bytes for INTUOSP2_BT/INTUOSP2S_BT,
46 bytes for the gen3 branch) bounds every sub-parser. Returning 0 on
a short report also skips those calls for the same malformed report,
which is the safe, conservative behavior.

Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v2: the v1 check (len < 109 / len < 43) only bounded
    wacom_intuos_pro2_bt_pen(). As sashiko-bot pointed out, the
    unconditional touch/pad/battery calls read much further --
    wacom_intuos_pro2_bt_pad() up to data[285] and
    wacom_intuos_gen3_bt_battery() up to data[45] -- so a report in the
    gap (109..285 / 43..45) passed the guard yet still over-read. Raise
    the minimums to the furthest offset each branch dereferences
    (286 / 46) so the guard actually bounds the whole call chain.

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
+		if (len < 286) {
+			dev_warn(wacom->pen_input->dev.parent,
+				 "Pro2 BT report too short: %zu bytes\n", len);
+			return 0;
+		}
+	} else if (len < 46) {
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

