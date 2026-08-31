Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174B3C583A
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167001; cv=none; b=aD98iFqUZUUlqdcU9vH676fsjazan7BrDcvD32JcWOnBHIDJ3kIXJqMJHg0iOVfJmRdjPcXXAeWmisumJrl+VqS11k2pFnjcqsYSN6MmjVm8rh1xzFL1UJZajArhzD+uWgPreQZ0lSlWvvB1b85iyYQJGe+MBYd1NU4+5Nr9XvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167001; c=relaxed/simple;
	bh=WDPVoqDu5sgqGFzGVVr3SKyG9fWrWvmMgllNy7RqRLg=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=jyAmd/bBRmmhMuQJWRiTJMbiP8QH9sVlxm1CGjuDRLapRCoTBGyQR8DClZPg3PXkk74QMtPmA1VbJXWPEjmca6uBtHLwCD0wN3FmIQEdLpRlsfM6yIJs/B1uuyYkvyXazQ8mmqyKkxfjfFeoy8jvIMXaja5t8F8sg5DRBAePkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=z96MjZpJ; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="z96MjZpJ"
Received: from [192.168.16.44] (port=33631 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1x0xul-000000002HK-15Yr;
	Mon, 31 Aug 2026 11:02:51 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1788166971; h=from:subject:to:date:message-id;
	bh=WDPVoqDu5sgqGFzGVVr3SKyG9fWrWvmMgllNy7RqRLg=;
	b=z96MjZpJpKCrfR1WKnPAMt9AXz6nfUhSHWg8lfzjlFY2NachAy4RyDUML8usD31nYamIYEGYYOy
	mWxVfpO+tBFPagXqIHQpSuBmPRg/OvumWdPPBGuBZgx+xM+QvKz2HHc/ns8fHhg2HcjTq66oM8EwL
	jYmptrpR3bR+cHJokZI=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 31 Aug 2026 11:02:50 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v3] Bluetooth: hci_sync: pause advertising for the scan address update
Date: Mon, 31 Aug 2026 11:02:32 +0200
Message-ID: <20260831090232.1726063-1-valentin.kindschi@fiveco.ch>
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
X-SASI-Version: Antispam-Engine: 6.0.0.1, AntispamData: 2026.8.31.82719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODY_SIZE_6000_6999 0.000000, BODY_SIZE_7000_LESS 0.000000,
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
also a central - every scan start therefore issues a
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

One caveat this widens: when HCI_ADVERTISING is set,
hci_pause_advertising_sync() also clears HCI_DISCOVERABLE and zeroes
discov_timeout, and hci_resume_advertising_sync() restores only
HCI_ADVERTISING. That side effect previously happened only with LL
privacy; it is now reachable on every active scan start, so a device made
discoverable through mgmt while repeatedly running active discovery would
lose discoverability. Restoring it belongs in the pause/resume pair rather
than here, but it is worth flagging.

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

A second capture on the same device, 221 s with an out-of-range peer
causing two cancelled outgoing connections, shows the same result under a
different mix of traffic: 2 LE Set Random Address, both Success, and no
Command Disallowed of any opcode.

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
Changes in v3:
- Resend, no code change; v2 had no reply. Rechecked that it still applies
  to bluetooth-next.
- Added the second capture described above, taken with the two patches from
  the "endless adv params retry" series applied, since in bluetooth-next,
  confirming the fix holds with cancelled outgoing connections in the mix.

Changes in v2:
- Rebased onto bluetooth-next: mainline renamed use_ll_privacy() to
  ll_privacy_capable(). No functional change.
 net/bluetooth/hci_sync.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6244,6 +6244,14 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
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
@@ -6272,13 +6280,18 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
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
