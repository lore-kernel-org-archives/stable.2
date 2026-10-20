Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.118.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493547;
	b=n3zf/P8UGOVm2EFeu6DKqWmLmQbWiNVrBqb0ElKSmIWOYYOjV+xUNbCO9XqZLq3hLrNM
	 6F03LObeK/wZBlGGjrrP2zDQ62IK/9zRdNY2PcseYbBX6dfxtzXNqTy3rwt2NUn3RwWAv
	 uN89hktkGfsBithHBvqBsRcI0FlX/ouKlgAro+kGGgTsOhTzRBdanVaajhHuVitLNjc7R
	 Ghnxxx98eT3CjPO8iHxa8EKVUip2MxUM0smsiiLMer3qcPed5RA0qzytUBy9QJt5IvMj/
	 hHGgoQk7W5blAc08AtKhLpPtaIuup08PbNWlemCC8vVsywzHK9ku1VPdqKIL3YioNRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493547;
	h=DMARC-Filter:Received:Content-Transfer-Encoding:Content-Type:
	 DKIM-Signature:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Originating-IP:
	 X-ClientProxiedBy:X-Sophos-OBS:X-SASI-Version:X-SASI-RCODE:
	 X-SASI-SpamProbability:X-SASI-Hits;
	bh=MPlnQbS3zYwvieySg42VRGYnZTNOWpovzbRPo5skf6g=;
	b=K40KV9+SrWRKWmc7XkJZa11WPjPYFhfBLQvfsv6WJ+I8T2i4NsFs+uakNSl65V5ZtrGO
	 dhi3dQbZcYQ2Cp8jreFT091er1fIj2TIryp6jcucTXu5uX5RzepHgjDHvp29sQBDfxLrg
	 +yuNToB2QkuYfrYU061Ww4YyM5Ws677KeItLTcUf4cmUBVgKSO8hx/fCC5Vf0RnvwnhgU
	 4vtkSNnFAyUcVnlJ4j9DGJrMIMqxw4fvzTmfB0VZQdIWnBBPgbpXg8+2oeca5oAZ1mHcK
	 tUIOL/YyjnsA/vluUw0GeVfW9Gk9Xn7ueANEu/7u2T0fnxWC0DngLNR0VwweaIsLfcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fiveco.ch;
	spf=pass smtp.mailfrom=fiveco.ch;
	dkim=pass header.d=fiveco.ch header.i=@fiveco.ch header.a=rsa-sha256 header.s=fiveco header.b=Wz4EUHdX;
	arc=none smtp.remote-ip=46.14.118.250
Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4C60A5BC3
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF4C60A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fiveco.ch header.i=@fiveco.ch header.a=rsa-sha256 header.s=fiveco header.b=Wz4EUHdX
Received: from [192.168.16.44] (port=17419 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1xJ7Rt-000000002B0-3Pl9;
	Tue, 20 Oct 2026 12:52:05 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1792493525; h=from:subject:to:date:message-id;
	bh=DR3y0bZEPNOYkjkt7ODRIeUtKeqxRfd+IOzNXHqkZ4Q=;
	b=Wz4EUHdXfY2YZ9Aw9n6Zq60fnT5rlfqUs3SNK1Fi2bK3oPjXz0SQLZFudhxA6wcfrbLMUuZefB3
	pOcLEWWpD1/GKKkns2A0YtxYBQApgbMZWrOcACTpvETcyRS/P9HBf0rF9eSawgflsabMicuOj/1WQ
	sYG2xrqtiA9+JLbVc2o=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 20 Oct 2026 12:52:05 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v8 2/2] Bluetooth: hci_sync: pause advertising for the scan address update
Date: Tue, 20 Oct 2026 12:51:50 +0200
Message-ID: <20261020105150.2863631-2-valentin.kindschi@fiveco.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020105150.2863631-1-valentin.kindschi@fiveco.ch>
References: <20261020105150.2863631-1-valentin.kindschi@fiveco.ch>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: FIVECO-MX01.fiveco.local (192.168.16.44) To
 FIVECO-MX01.fiveco.local (192.168.16.44)
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 6.0.0.1, AntispamData: 2026.10.20.95719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODY_SIZE_8000_8999 0.000000, CTE_8BIT 0.000000,
 DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
 HTML_00_10 0.050000, IN_REP_TO 0.000000, MULTIPLE_RCPTS 0.100000,
 NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
 SENDER_NO_AUTH 0.000000, WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000,
 WEBMAIL_X_IP_HDR 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
 __BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
 __CC_REAL_NAMES 0.000000, __CT 0.000000, __CTE 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FRAUD_CONTACT_ADDY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __HAS_REFERENCES 0.000000, __HAS_XOIP 0.000000, __HAS_X_MAILER 0.000000,
 __IN_REP_TO 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
 __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_DOMAIN_IN_REFERENCES 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __PHISH_SPEAR_SUBJ_PREDICATE 0.000000, __RCVD_CTE 0.000000,
 __RCVD_EXIM_4_96_AES_128 0.000000, __RCVD_FROM_HOMEUSER 0.000000,
 __REFERENCES 0.000000, __SANE_MSGID 0.000000, __SHIPPING_ACTION 0.000000,
 __SL_HEAVY 0.000000, __SL_LIGHT 0.000000, __SUBJ_ALPHA_END 0.000000,
 __SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
 __URI_NO_WWW 0.000000, __URI_NS 0.000000

hci_active_scan_sync() programs a non-resolvable private address with LE
Set Random Address on every active scan start.

BLUETOOTH CORE SPECIFICATION Vol 4, Part E, 7.8.4 says the controller
shall return Command Disallowed (0x0C) for that command while legacy
advertising or scanning is enabled. hci_pause_addr_resolution(), called
just above, only stops advertising when LL privacy is in use, so on a
controller without it the command is issued while advertising is still
on:

  Bluetooth: hci0: Opcode 0x2005 failed: -16

It does not converge either. hdev->random_addr is only set on a
successful command complete, so it stays BDADDR_ANY, and the deferral
added by commit c2994b008492 ("Bluetooth: hci_sync: Fix not setting
Random Address when required") requires it to be set. Unlike the
resolvable address a few lines above, which is reused while rpa_valid(),
the non-resolvable one is regenerated and rewritten on every call, so a
controller that refuses the write is asked again at the scan restart
period of about 10 s, for as long as discovery keeps restarting.
Observed on a BCM43455, which has no LL privacy and no extended
advertising, 190 rejections in one capture, every one retrying the same
address:

  < LE Set Random Address  Address: 02:16:91:90:F1:D4 (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed
  < LE Set Random Address  Address: 26:90:57:96:9A:3E (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed

Pause advertising for the address update, and resume it once the update
is done and before the scan is started. The pause does not outlive the
function: it is taken only when nothing else holds it, and every exit
resumes advertising, which also releases the pause taken by
hci_pause_addr_resolution(). A failed pause returns before marking
anything paused, so the error path is a no-op.

The resume in the error path is no longer guarded by ll_privacy_capable().
That guard matched a pause taken only under LL privacy; the pause added
here is unconditional, and hci_resume_advertising_sync() returns early
when nothing was paused.

One caveat this widens, raised on the previous posting. When
HCI_ADVERTISING is set, hci_pause_advertising_sync() also clears
HCI_DISCOVERABLE and HCI_LIMITED_DISCOVERABLE and zeroes discov_timeout,
and hci_resume_advertising_sync() restores only HCI_ADVERTISING, so the
discoverable state is lost. It reproduces today on an LL privacy
controller through hci_pause_addr_resolution(); the unconditional pause
makes it reachable without LL privacy as well. hci_suspend_sync() also
pauses unconditionally, so a device that suspends loses the same state
on any controller today. That asymmetry is pre-existing and is left
alone here rather than folded into a scan path fix.

Legacy controllers have one random address register, shared by the
scanner and the advertiser. Restoring the advertiser here can reprogram
it when the advertiser is non-connectable, so the scan then uses that
address rather than the one generated for it. Both are non-resolvable
and neither is linkable to the identity address. With privacy enabled
both roles already share one resolvable address the same way.

With the patch, on the same hardware:

  < LE Set Advertising Enable    Enable: 0x00              Success
  < LE Set Random Address                                  Success
  < LE Set Advertising Parameters                          Success
  < LE Set Advertising Enable    Enable: 0x01              Success
  < LE Set Scan Parameters                                 Success
  < LE Set Scan Enable           Enable: 0x01              Success

The address write is accepted, and advertising is restored before the
scan is started.

Over 119369 btmon records and about 12 minutes of the normal workload of
that device, alternating active and passive scanning with ten outgoing
connection attempts, every LE Set Random Address succeeded and there were
no Command Disallowed responses of any opcode, against one per scan
restart before.

Patch 1 is required: without it the resume added here returns -EPERM on
the controllers this fixes and leaves advertising disabled.

Fixes: 3c44a431d62b ("Bluetooth: hci_sync: Resume adv with no RPA when active scan")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
Changes in v8:
- No change; resent as part of the series.

Changes in v7:
- Reword the commit message: the resume on the error path also releases the
  pause taken by hci_pause_addr_resolution(), so it is not conditional on
  this function having taken a pause.

Changes in v6:
- Drop the comment from the Cc: stable trailer; it exceeded the line length
  gitlint enforces. The dependency on patch 1 is stated in the commit message.

Changes in v5:
- Split into two patches. v4's resume was reached through
  hci_schedule_adv_instance_sync(), which refuses HCI_ADVERTISING on a
  controller without extended advertising, so advertising was never
  re-enabled. Patch 1 fixes that and is a prerequisite for this one.
- Do not resume on the success path. hci_resume_advertising_sync()
  reaches hci_update_random_address_sync(), which for a non-connectable
  advertiser programs a fresh address, and doing that with the scan
  already enabled is refused the same way. Resume before the scan is
  started instead.
- Take the pause only when nothing else holds it and release it on every
  exit, so it cannot be released by another user of
  hdev->advertising_paused.
- v4 claimed the resume commands in the capture were issued with the scan
  already running and succeeded. That capture came from a build whose
  resume ran elsewhere; the claim is dropped. The capture above is from
  this version, on the device, under its normal workload.
- Fixes: now points at 3c44a431d62b, where the pause became conditional
  on LL privacy, rather than at the introduction of the scan function.

Changes in v4:
- Report the HCI_DISCOVERABLE asymmetry raised in review rather than fix
  it, with a reproducer in the commit message.
- Keep the explicit return on the success path, so the resume runs there
  and the function no longer falls through into failed:.
- Shorten the added comments to one line each.

Changes in v3:
- Resend, no code change; v2 had no reply. Rechecked that it still applies
  to bluetooth-next.
- Added the second capture described above, taken with the two patches from
  the "endless adv params retry" series applied, since in bluetooth-next,
  confirming the fix holds with cancelled outgoing connections in the mix.

Changes in v2:
- Rebased onto bluetooth-next: mainline renamed use_ll_privacy() to
  ll_privacy_capable(). No functional change.

 net/bluetooth/hci_sync.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d215432db..e9b2d28ff 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6339,6 +6339,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	u8 filter_policy = 0x00;
 	/* Default is to enable duplicates filter */
 	u8 filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	bool paused;
 	int err;
 
 	bt_dev_dbg(hdev, "");
@@ -6362,6 +6363,12 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	if (err)
 		goto failed;
 
+	/* LE Set Random Address is disallowed while advertising is enabled. */
+	paused = !hdev->advertising_paused;
+	err = hci_pause_advertising_sync(hdev);
+	if (err)
+		goto failed;
+
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
 	 * private address.
@@ -6371,6 +6378,9 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
+	if (paused)
+		hci_resume_advertising_sync(hdev);
+
 	if (hci_is_adv_monitoring(hdev) ||
 	    (hci_test_quirk(hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER) &&
 	    hdev->discovery.result_filtering)) {
@@ -6394,9 +6404,8 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 		return err;
 
 failed:
-	/* Resume advertising if it was paused */
-	if (ll_privacy_capable(hdev))
-		hci_resume_advertising_sync(hdev);
+	/* No-op when advertising was not paused. */
+	hci_resume_advertising_sync(hdev);
 
 	/* Resume passive scanning */
 	hci_update_passive_scan_sync(hdev);
-- 
2.34.1

