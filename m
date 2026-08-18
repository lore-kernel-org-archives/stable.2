Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CF47884C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059821; cv=none; b=u8yQ8Ut/IDTOe8lsfkbWotc+H38D0+vOYVLck8tESDdWNUSCDNefvCk7GvgRZfqFbLPXBzgH8PnEx7mLzsor7jzOfwFikAWKhABj0g7+kZACyZomdlK1c+xlOjK6JzXFiGhzk/3RIuWxKmTeAvy79ygj/z707RphpE8yY+5Gt+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059821; c=relaxed/simple;
	bh=GcZ6gVgviXLmCcUpCRJ49yG184OqDRHwV8Vvc9hbBbE=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=lfDvDcLXPIpgeEti9eUEhYJz8EW8+g3aoSUPLpGOIkbXLYr+TNW1VhpujHRZErRrkOVO9YmktASrlYLbbbI0ArYM9B+C9yFaN9eRhi0hJ+bxWd3uQiBwJ0wtTy+2vafbl57a/dT3sezZIrBSl0flNsIZLX4sHKdmZH4JiekzYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=1ChuxtDJ; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="1ChuxtDJ"
Received: from [192.168.16.44] (port=15732 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1wwJsz-000000000TF-0DmP;
	Tue, 18 Aug 2026 15:29:49 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1787059788; h=from:subject:to:date:message-id;
	bh=GcZ6gVgviXLmCcUpCRJ49yG184OqDRHwV8Vvc9hbBbE=;
	b=1ChuxtDJ6osfoC8o44+PbsZIgu0NIzXYC2HSBllu6GkTWDFTOKTvyBXCw70Qxsh5GScta0ckZHv
	rrFCt4UOEpCsYDGdxKFgynLfGImgXhWq5wABOmmulyoBnGUwsos1JTpBFbesKp4MQtXSqWWhB+emx
	eukC1Oc0R8FOpxZoRTQ=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 18 Aug 2026 15:29:48 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v4 2/2] Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection
Date: Tue, 18 Aug 2026 15:29:35 +0200
Message-ID: <20260818132935.1083808-3-valentin.kindschi@fiveco.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818132935.1083808-1-valentin.kindschi@fiveco.ch>
References: <20260818132935.1083808-1-valentin.kindschi@fiveco.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: FIVECO-MX01.fiveco.local (192.168.16.44) To
 FIVECO-MX01.fiveco.local (192.168.16.44)
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 6.0.0.1, AntispamData: 2026.8.18.125719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 10%
X-SASI-Hits: ADVERT_CODE2 0.400000, BODY_SIZE_6000_6999 0.000000,
 BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
 DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IN_REP_TO 0.000000, MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
 OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000, SENDER_NO_AUTH 0.000000,
 WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000,
 __ADVERT_CODE2 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
 __BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
 __CC_REAL_NAMES 0.000000, __COURIER_PHRASE 0.000000, __CT 0.000000,
 __CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
 __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
 __HAS_XOIP 0.000000, __HAS_X_MAILER 0.000000,
 __INVOICE_MULTILINGUAL 0.000000, __IN_REP_TO 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MSGID_DOMAIN_IN_REFERENCES 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_CTE 0.000000,
 __RCVD_EXIM_4_96_AES_128 0.000000, __RCVD_FROM_HOMEUSER 0.000000,
 __REFERENCES 0.000000, __SANE_MSGID 0.000000, __SL_HEAVY 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
 __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
 __URI_NS 0.000000

le_conn_complete_evt() clears HCI_LE_ADV before looking at the event
status, on the premise stated in its comment that all controllers stop
advertising when a connection is created.

That premise only holds when a connection was actually created. On a
non-zero status none was, and the controller is still advertising: after
the host issues LE Create Connection Cancel the event arrives with
Unknown Connection Identifier (0x02), and a connection timeout behaves
the same way. Clearing the flag there leaves the host believing
advertising is off while the controller has it on.

It is also wrong for extended advertising, where several sets can be
advertising at once. hci_cc_le_set_ext_adv_enable() is careful about
this - on disabling one set it walks hdev->adv_instances and only clears
HCI_LE_ADV once no instance is still enabled. The unconditional clear
here discards that bookkeeping, so one set connecting drops the flag
while the others keep advertising.

The direction of the error matters. A flag left set is self-correcting:
hci_disable_advertising_sync() sends LE Set Advertising Enable(0) and
the command complete puts the state back. A flag left clear is not,
because that same function returns early without sending anything while
the flag is clear:

  - LE Set Advertising Parameters is then sent to a controller that is
    still advertising, and is correctly rejected with Command Disallowed
    (0x0c);
  - hci_enable_advertising_sync() returns at that point, before the
    LE Set Advertising Enable that would set HCI_LE_ADV again.

On a controller without LE Extended Advertising that is reachable from
here: hci_schedule_adv_instance_sync() re-arms adv_instance_expire every
HCI_DEFAULT_ADV_DURATION (2 s) and its "already advertising" shortcut
tests HCI_LE_ADV, which can no longer become true, so the parameter
write is retried for as long as advertising is configured:

  Bluetooth: hci0: Opcode 0x2006 failed: -16

Only clear the flag when a connection was established.

Note this is not on its own sufficient to stop that retry loop - the
redundant enable queued by hci_le_conn_failed() clears HCI_LE_ADV itself
and recreates the same mismatch, which patch 1 addresses. This patch
fixes the event handler reporting a state the controller is not in.

Verified on the affected device (BCM43455, legacy advertising only) with
this patch and patch 1 applied. A 221 s btmon capture with an out-of-range
peer at -90 dBm contains two outgoing connection attempts that the host
cancelled, each producing exactly the event this patch changes:

  < LE Set Advertising Parameters  0x2006   Success
  < LE Set Advertising Enable      0x200a   Success
  < LE Create Connection Cancel    0x200e   Success
  > LE Connection Complete   Unknown Connection Identifier (0x02), central

Nothing follows either one; the next command is an unrelated scan restart
70 ms later. Over the whole capture: 7 LE Set Advertising Parameters sent,
all Success; 10 LE Set Advertising Enable, all Success; no Command
Disallowed of any opcode, and no 2 s cadence anywhere. Two central
connections to other peers completed normally afterwards, with feature
exchange and a connection parameter update, so advertising was still live
across the cancelled attempts.

The extended advertising case above is a code argument, not a measurement:
this controller has no LE Extended Advertising, so that path is not
exercised by the capture.

Fixes: fbd96c151cdc ("Bluetooth: Fix clearing HCI_LE_ADV for LE connections")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
Changes in v4:
- Test !status instead of status != HCI_ERROR_UNKNOWN_CONN_ID, per review:
  a connection timeout should not clear the flag either. Built and tested
  on the device in that form; the capture quoted above is from this
  version, so the effect is now measured rather than inferred as in v2/v3.
- Note the extended-advertising case raised in review: several sets can be
  advertising at once, and hci_cc_le_set_ext_adv_enable() already tracks
  that per instance, which the unconditional clear here was discarding.
- On Advertising Timeout (0x3c), which v2/v3 used to justify a narrower
  test: a controller can report it, since hci_le_directed_advertising_sync()
  uses high duty cycle directed advertising. Not clearing the flag there is
  harmless because directed advertising is always bracketed by
  hci_pause_advertising_sync() / hci_resume_advertising_sync() in
  hci_le_create_conn_sync(), and the resume re-schedules with force=true,
  which bypasses the HCI_LE_ADV shortcut. le_conn_timeout() also disables
  advertising itself on the peripheral path.
- A stale-set flag is self-correcting (hci_disable_advertising_sync() then
  sends the disable) whereas a stale-clear flag is self-sustaining, which is
  the bug here, so erring towards set is the safer direction.

Changes in v3:
- Shortened the subject and removed hard tabs from the changelog (GitLint).

Changes in v2:
- Rebased onto bluetooth-next; no functional change.
  v1's hci_event.c context lacked the hci_store_wake_reason() call
  present in mainline, so the hunk did not apply.

 net/bluetooth/hci_event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5720,10 +5720,11 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_dev_lock(hdev);
 	hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
 
-	/* All controllers implicitly stop advertising in the event of a
-	 * connection, so ensure that the state bit is cleared.
+	/* Advertising stops when a connection is created. On a failed
+	 * connection it keeps running, so leave the state bit alone.
 	 */
-	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+	if (!status)
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
 	/* Check for existing connection:
 	 *
--
2.34.1
