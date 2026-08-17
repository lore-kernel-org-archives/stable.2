Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25392D2495
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979030; cv=none; b=OdfW4O/PqJvqTQ3Kd//o1loFefZ4jyHtPYCrP+egWSoN/h4dTL2aPd5thkL3XKJmg12iqAAmLGwQQgWGhmsQplNJ7XxiHszJkR8UugrWE7BKDBvU5dnkhTdsPDXtWtEs1nPxzEUpjdKGIhAhBcBp+1t3yYPi+2uXpIuJDadLekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979030; c=relaxed/simple;
	bh=7vaSm55LLHRF0VVxmX9sNutPgpBJRHnWqqTLsuTsGYI=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=Rm2AlCn3ybZfmwNRGgmoTUm1cXWgfN/upmw9dZj8Mken6ovBUo1g1ZWvU5hcYSKJViaolLkPeOFxFaaNe6TU3/3yybEfrzUe3EQmFH7xTHpXuL+YHbZNKcjRynm9VO5UnesDoiWOf7emhu5pnUgk1sZ8yiaGQsOX8IFzBCSrU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=4Alqt6v3; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="4Alqt6v3"
Received: from [192.168.16.44] (port=36665 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1wvysA-000000003dO-1sVF;
	Mon, 17 Aug 2026 17:03:34 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1786979014; h=from:subject:to:date:message-id;
	bh=7vaSm55LLHRF0VVxmX9sNutPgpBJRHnWqqTLsuTsGYI=;
	b=4Alqt6v3ZJZuXFZVNzsq0hL3h1y8z9o/jeLdnhd4MUpjrNa6JPYwrSX7gS+RoJAfZ6wqeWh2Gj6
	//5Sa8nJtzJspsqAIDVkcwyS8anLXfxtP5RTuaE+JQl2Q4Gyg0hlak1Qr3B8oQg0CuIeYew4SeUYA
	F8P8iteH1eloMomPFzQ=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 17 Aug 2026 17:03:34 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: hci_sync: pause advertising for the scan address update
Date: Mon, 17 Aug 2026 17:03:23 +0200
Message-ID: <20260817150323.520207-1-valentin.kindschi@fiveco.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: FIVECO-MX01.fiveco.local (192.168.16.44) To
 FIVECO-MX01.fiveco.local (192.168.16.44)
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 6.0.0.1, AntispamData: 2026.8.17.142719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODY_SIZE_5000_5999 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
 HTML_00_01 0.050000, HTML_00_10 0.050000, MULTIPLE_RCPTS 0.100000,
 NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000,
 WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000,
 __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000,
 __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
 __CC_REAL_NAMES 0.000000, __CT 0.000000, __CTE 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_XOIP 0.000000, __HAS_X_MAILER 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __PHISH_SPEAR_SUBJ_PREDICATE 0.000000, __RCVD_CTE 0.000000,
 __RCVD_EXIM_4_96_AES_128 0.000000, __RCVD_FROM_HOMEUSER 0.000000,
 __SANE_MSGID 0.000000, __SHIPPING_ACTION 0.000000, __SL_HEAVY 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
 __URI_NO_WWW 0.000000, __URI_NS 0.000000

hci_active_scan_sync() calls hci_update_random_address_sync() with
require_privacy set on every active scan start, which generates a
non-resolvable private address and programs it with LE Set Random
Address.

BLUETOOTH CORE SPECIFICATION Vol 4, Part E, 7.8.4 states the controller
shall return Command Disallowed (0x0C) for LE Set Random Address while
legacy advertising or scanning is enabled.

Advertising is only stopped beforehand when LL privacy is in use.
hci_pause_addr_resolution(), called just above, returns early when
!use_ll_privacy(hdev), so its hci_pause_advertising_sync() never runs.
On a device that advertises while active scanning - a peripheral that is
also a central, such as a gateway - every scan start therefore issues a
command the host can already know will be rejected:

  Bluetooth: hci0: Opcode 0x2005 failed: -16

The address write is not retried either: hci_set_random_addr_sync()
defers only when hdev->random_addr is already set, and it never becomes
set because the write keeps failing, so HCI_RPA_EXPIRED is not used here.

Observed on a BCM43455 with Privacy=off, one advertising instance and
continuous active discovery, at the scan restart period (~10 s):

  < LE Set Random Address  Address: 02:16:91:90:F1:D4 (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed
  < LE Set Random Address  Address: 26:90:57:96:9A:3E (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed
  < LE Set Random Address  Address: 16:32:01:BC:B5:CE (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed

Pause advertising for the address update regardless of privacy, and
resume it on every exit path. Previously the resume was guarded by
use_ll_privacy() and only reached on the error path, which matched the
pause being privacy-only.

With the patch, the same scan restart on the same hardware:

  < LE Set Advertising Enable                            Success
  < LE Set Random Address                                Success
  < LE Set Scan Parameters                               Success
  < LE Set Scan Enable                                   Success
  < LE Set Advertising Parameters                        Success
  < LE Set Advertising Enable                            Success

Over 35425 records / ~4 min of btmon with continuous active discovery and
advertising enabled there were no Command Disallowed responses of any
kind, against one per scan restart before. A central could still connect
to the device, confirming advertising is restored after the pause.

Tooling disclosure (Documentation/process/generated-content.rst): an AI
coding assistant was used to investigate this and to draft the change;
the patch text and code are its output, reviewed by me. Inputs were btmon
captures and kernel logs from the affected device, with the request to
identify what re-issues LE Set Random Address every ~10 s and to fix it.
Three earlier explanations it proposed were discarded after being checked
against the captures: bluetoothd restarting service discovery; RPA
rotation (excluded, Privacy=off); and the static-address branch of
hci_update_random_address_sync() (excluded, both random_address and
static_address read 00:00:00:00:00:00). The cause was only established
after decoding the command payloads, which showed a freshly generated
non-resolvable address per attempt. Testing is as described above, on the
device, using btmon and a second device to confirm connectability.

Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
 net/bluetooth/hci_sync.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6170,6 +6170,14 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval,
 	if (err)
 		goto failed;
 
+	/* LE Set Random Address is disallowed while advertising is enabled, so
+	 * pause it for the address update. hci_pause_addr_resolution() above
+	 * only does this when LL privacy is in use.
+	 */
+	err = hci_pause_advertising_sync(hdev);
+	if (err)
+		goto failed;
+
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
 	 * private address.
@@ -6201,13 +6209,18 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval,
 	err = hci_start_scan_sync(hdev, LE_SCAN_ACTIVE, interval,
 				  hdev->le_scan_window_discovery,
 				  own_addr_type, filter_policy, filter_dup);
-	if (!err)
+	if (!err) {
+		/* Advertising was paused for the address update above. */
+		hci_resume_advertising_sync(hdev);
 		return err;
+	}
 
 failed:
-	/* Resume advertising if it was paused */
-	if (ll_privacy_capable(hdev))
-		hci_resume_advertising_sync(hdev);
+	/* Resume advertising if it was paused. hci_resume_advertising_sync()
+	 * is a no-op when hdev->advertising_paused is not set, so this covers
+	 * both the privacy and the address-update pause.
+	 */
+	hci_resume_advertising_sync(hdev);
 
 	/* Resume passive scanning */
 	hci_update_passive_scan_sync(hdev);
--
2.34.1
