Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.118.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493551;
	b=FYMNwlvW7WylkZxq/1VQbKl32gx8QY1TiOZUMIGlOWHM6l9pJWAQZ0AWrCflCicmjqM8
	 qzQjMyjqsz8xgxbpehXUNpNmj1w24rXWlX03B990Wg1rDWPIqYN0nVxIM50CvBmJ5tt+P
	 FRYkJdiU73Ori3l7vUWndAtybLTDbBROK81AhxXgdL5/J/ggTvG0gDrr+qin96Tn5PEtg
	 ppyAfJjxnwjFBMkrQozMqW0cACDGBNOp4JvJeQ38vkhztkiR6MojVectI3WQwpelphy37
	 3I5xzHzdfnIveUfhGUoay8N5TJzHq8yQsPvgEo+U+unwsBe0DB5YKvyvYvuSJooC7qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493551;
	h=DMARC-Filter:Received:Content-Transfer-Encoding:Content-Type:
	 DKIM-Signature:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:X-Sophos-OBS:
	 X-SASI-Version:X-SASI-RCODE:X-SASI-SpamProbability:X-SASI-Hits;
	bh=nzDqId7rohNd7F8gR0YI1rYGcZuf65PaJTN3QFstVP8=;
	b=ryfN2HSHcGpVY0P9jDq1w+AIgSFNzM7XKOCkr99pxQYuDCqjNdP/aP5RJMXenxat1cNF
	 Pj930h2vcGZ8+J9PwObRh+L1leKj+zt61kgZH9MS7LYI9CBMPqd6/ngM4R5ZjtrsSmmsy
	 9tp2I7tiuzNolvjOzUfc3NTu99w/qs1ePzhzIUtVtgA+tMvbiPiXknW6m7rWn/BbGq5BV
	 4KfPulCCe5hTtUl84bcFAvEC55G/7cJ0rP71CR5muib9ZCf5MDpdDGnUD/+zrrcgX+xgJ
	 Vm66SD/ex1huPqsRh0AAzaZLfe3bxHy22ir1+XM/wxPtdbkLd/QBCIyf8HhFGjng3yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fiveco.ch;
	spf=pass smtp.mailfrom=fiveco.ch;
	dkim=pass header.d=fiveco.ch header.i=@fiveco.ch header.a=rsa-sha256 header.s=fiveco header.b=BCCe+bGP;
	arc=none smtp.remote-ip=46.14.118.250
Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204460A380A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6204460A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fiveco.ch header.i=@fiveco.ch header.a=rsa-sha256 header.s=fiveco header.b=BCCe+bGP
Received: from [192.168.16.44] (port=17412 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1xJ7Rq-000000002AK-2qQ3;
	Tue, 20 Oct 2026 12:52:02 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1792493522; h=from:subject:to:date:message-id;
	bh=1xBBu1FERZbXbIeZlyLgOta86H3Ud+NDUuigX/nq814=;
	b=BCCe+bGPWvcMWwUEFZgUb4AswlYNpqKV1yT+rh53+DPEb3o3z9tN+8GhKGwxomNjWCL18cztxM6
	ATDetnC9+nmLlZfMZSyBTI0utOiOq0BKoPjHWzegZzS0nVJZ8RUccaOD7RAw06Hai16brYJGmtGUi
	o5ws1R66p5w01vsO43s=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 20 Oct 2026 12:52:02 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v8 1/2] Bluetooth: hci_sync: re-enable legacy advertising on resume
Date: Tue, 20 Oct 2026 12:51:49 +0200
Message-ID: <20261020105150.2863631-1-valentin.kindschi@fiveco.ch>
X-Mailer: git-send-email 2.34.1
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
X-SASI-Hits: BODY_SIZE_4000_4999 0.000000, BODY_SIZE_5000_LESS 0.000000,
 BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
 DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000,
 NO_URI_HTTPS 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
 SENDER_NO_AUTH 0.000000, WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000,
 WEBMAIL_X_IP_HDR 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
 __BODY_VOICEMAIL 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CT 0.000000,
 __CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
 __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_XOIP 0.000000,
 __HAS_X_MAILER 0.000000, __INVOICE_MULTILINGUAL 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __RCVD_CTE 0.000000, __RCVD_EXIM_4_96_AES_128 0.000000,
 __RCVD_FROM_HOMEUSER 0.000000, __SANE_MSGID 0.000000, __SL_HEAVY 0.000000,
 __SL_LIGHT 0.000000, __SUBJ_ALPHA_END 0.000000,
 __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
 __URI_NS 0.000000

hci_resume_advertising_sync() never re-enables advertising on a
controller without extended advertising.

It restores HCI_ADVERTISING from advertising_old_state, then calls
hci_schedule_adv_instance_sync(), which starts with:

  if (hci_dev_test_flag(hdev, HCI_ADVERTISING) && !ext_adv_capable(hdev))
          return -EPERM;

The flag it tests was set a few lines earlier by the resume itself, so
the call returns -EPERM without sending anything. The return value is
discarded by every caller, so the failure is silent: advertising_paused
is cleared, HCI_ADVERTISING is set, and the controller is not
advertising.

Observed on a BCM43455 (no extended advertising) after an active scan:
btmon shows the pause disabling advertising and no re-enable in the ten
seconds that follow, the device does not appear in another controller's
scan, and btmgmt info still reports "advertising" in current settings.

Enable instance 0x00 directly in that case, the way reenable_adv_sync()
already does for the same situation. Instances continue to go through
hci_schedule_adv_instance_sync() so the software rotation loop is
rearmed.

This affects every caller of hci_resume_advertising_sync(), not only the
scan path: address resolution changes, accept list updates, discovery
stop, suspend/resume and the end of an LE connection attempt all leave
advertising disabled on such a controller today.

The resume does nothing when the controller is already advertising, as
it is after directed advertising was started for a peripheral
connection, so it does not replace that advertising.

err is initialised because the extended branch leaves it unset when
adv_instances is empty and HCI_LE_ADV_0 is clear.

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
Changes in v8:
- Do not restart advertising on resume when HCI_LE_ADV is already set.
  With HCI_ADVERTISING set, a peripheral connection starts directed
  advertising and the resume then replaced it with undirected
  advertising; the l2cap-tester "Direct Advertising" tests failed in
  CI.

Changes in v7:
- Enable instance 0x00 only when HCI_ADVERTISING was restored from the
  state before the pause. Without that check, removing the numbered
  instance that was advertising while paused reset cur_adv_instance to
  0x00 and the resume started advertising that was not running before.
  Reported by Sashiko.

Changes in v6:
- No change; resent as part of the series.

Changes in v5:
- New patch. v4 of the scan fix resumed advertising through
  hci_schedule_adv_instance_sync(), which refuses HCI_ADVERTISING on a
  controller without extended advertising, so the resume never sent
  anything. Patch 2 depends on this.

 net/bluetooth/hci_sync.c | 10 +++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7ac26daba..d215432db 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2733,7 +2733,7 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 static int hci_resume_advertising_sync(struct hci_dev *hdev)
 {
 	struct adv_info *adv, *tmp;
-	int err;
+	int err = 0;
 
 	/* If advertising has not been paused there is nothing  to do. */
 	if (!hdev->advertising_paused)
@@ -2766,13 +2766,19 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 		 */
 		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_ADV_0))
 			err = hci_enable_ext_advertising_sync(hdev, 0x00);
-	} else {
+	} else if (hdev->cur_adv_instance) {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
 		 */
 		err = hci_schedule_adv_instance_sync(hdev,
 						     hdev->cur_adv_instance,
 						     true);
+	} else if (hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+		   !hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		/* hci_schedule_adv_instance_sync() rejects instance 0x00 while
+		 * HCI_ADVERTISING is set, so enable it directly.
+		 */
+		err = hci_start_adv_sync(hdev, 0x00);
 	}
 
 	hdev->advertising_paused = false;
-- 
2.34.1

