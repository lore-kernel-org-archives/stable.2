Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF414E5344
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410991; cv=none; b=kxwI6ofyeVzdn4NDJhcfIK6dneZZ4qWD1Y3RU36V8RcVZczaOMqAb6BG19jsRJE/11uzNWdBpkCjz0ppMmwEiy+R2mpSQ3tK2wsbEtSZbJVmR1oOw4hF4U9gzlbdWkcA74ND1LAOZjRH6f5MEGcDPBTPStGtLytCbSEhkI7vBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410991; c=relaxed/simple;
	bh=FYx53TYVkBsd/sCWj2+zcUIj1usEdwFWXY81aK60Xlo=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=o5tV+/rrM8rFNF9pX/IGxVIFdOBMl6ZQKUTGVkgonuoxnxt1l5SKpf15m5C/+5duUDh6ws57qr5EAKkkYBvA2b3PTlfwBqh8W9cZJSmIS+BMpjQ0GilArkdQUCEzNOjAfitXukbpv+C2/CVU/geBq2azLrbAqWYPyWnSX4bc+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=HlX91qDT; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="HlX91qDT"
Received: from [192.168.16.44] (port=61408 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1xIly5-000000002xB-0SE2;
	Mon, 19 Oct 2026 13:55:53 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1792410952; h=from:subject:to:date:message-id;
	bh=FYx53TYVkBsd/sCWj2+zcUIj1usEdwFWXY81aK60Xlo=;
	b=HlX91qDT3pkkxgx+A9f4fPUF1brQ76i7AMgxhJ6YR2dBBDgyPVW4ev05SQqmXeD0DZn8CF6QxEQ
	I40ae2wNZeQfum6C5T2ESr4I5rtXndFwzRHykTyKK2XwIKJ56hRYBmz/jPlbKg9PrJWIjNiCbykiN
	12r62GGRFTZdP4v9MYw=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 19 Oct 2026 13:55:52 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v6 1/2] Bluetooth: hci_sync: re-enable legacy advertising on resume
Date: Mon, 19 Oct 2026 13:55:37 +0200
Message-ID: <20261019115538.45115-1-valentin.kindschi@fiveco.ch>
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
X-SASI-Version: Antispam-Engine: 6.0.0.1, AntispamData: 2026.10.19.112719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODY_SIZE_3000_3999 0.000000, BODY_SIZE_5000_LESS 0.000000,
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
 __HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
 __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_CTE 0.000000,
 __RCVD_EXIM_4_96_AES_128 0.000000, __RCVD_FROM_HOMEUSER 0.000000,
 __SANE_MSGID 0.000000, __SL_HEAVY 0.000000, __SL_LIGHT 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
 __URI_NO_WWW 0.000000, __URI_NS 0.000000

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

err is initialised because the extended branch leaves it unset when
adv_instances is empty and HCI_LE_ADV_0 is clear.

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
Changes in v6:
- No change; resent as part of the series.

Changes in v5:
- New patch. v4 of the scan fix resumed advertising through
  hci_schedule_adv_instance_sync(), which refuses HCI_ADVERTISING on a
  controller without extended advertising, so the resume never sent
  anything. Patch 2 depends on this.

 net/bluetooth/hci_sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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
@@ -2766,13 +2766,18 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
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
+	} else {
+		/* hci_schedule_adv_instance_sync() rejects instance 0x00 while
+		 * HCI_ADVERTISING is set, so enable it directly.
+		 */
+		err = hci_start_adv_sync(hdev, 0x00);
 	}
 
 	hdev->advertising_paused = false;
-- 
2.34.1

