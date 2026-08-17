Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAB282F29
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978993; cv=none; b=uB1J96GGRQnR1nEhxRJ3BjHpI1nQy30UBiDwRHCTold/9RbAhMEoEuvlIWVw4grxMQBrx6CBXmg/uWaRYRFxdxTDp6suY8AMiofcyoJ0SZg07K8bALo9Ro/wy/AAK4DeY7opYDZMA4oLKBK/PQxGSz9X+DtSOQJipZZa18Ovgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978993; c=relaxed/simple;
	bh=u6IA3+MZorn4q8oBxqHpzAK9EvJj+U75Xif8c84/rOc=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=cSJn68pGyB+nhL9Sr1nbHgAttczuqezKZRa6ODT+mobMavY5Eka20SFLDzVTwGVEZabK3qI7jCHExiFmAs+cc/U/XuDmvUEyc0auqQeu/qp0ll6sMBd+AmbWtusr3eAjre7aZHFvVe7YLyFZ722o7jai3wS3YpafIo9iLFNJrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=4nN7Ihb2; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="4nN7Ihb2"
Received: from [192.168.16.44] (port=36555 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1wvyrU-000000003Qi-22DZ;
	Mon, 17 Aug 2026 17:02:52 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1786978972; h=from:subject:to:date:message-id;
	bh=u6IA3+MZorn4q8oBxqHpzAK9EvJj+U75Xif8c84/rOc=;
	b=4nN7Ihb23dZfTYJ8dDrkV2Mz1CdF/YFUl/Y07YYNCGQ1mWw81HJg6XIx7YrQzkJpKArumQaJS1E
	RYxeZy8Mfe3l8c/LplaTT53oLToE3Kr3iI+wEi8NtbNj1fg5D+cCDkGpokT85ehyxovUfWr8nsReg
	Kx1jSKXRY9/p+iq2q9M=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 17 Aug 2026 17:02:52 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v3 2/2] Bluetooth: hci_event: keep HCI_LE_ADV set if the host cancelled
Date: Mon, 17 Aug 2026 17:02:40 +0200
Message-ID: <20260817150240.520181-3-valentin.kindschi@fiveco.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817150240.520181-1-valentin.kindschi@fiveco.ch>
References: <20260817150240.520181-1-valentin.kindschi@fiveco.ch>
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
X-SASI-SpamProbability: 10%
X-SASI-Hits: ADVERT_CODE2 0.400000, BODY_SIZE_3000_3999 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
 HTML_00_01 0.050000, HTML_00_10 0.050000, IN_REP_TO 0.000000,
 MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000,
 NO_URI_HTTPS 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
 REFERENCES 0.000000, SENDER_NO_AUTH 0.000000, TRANSACTIONAL 0.000000,
 WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000,
 __ADVERT_CODE2 0.000000, __ANY_URI 0.000000, __B2B_PROBE 0.000000,
 __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CT 0.000000,
 __CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
 __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FRAUD_MONEY_DENOMINATION 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HAS_XOIP 0.000000,
 __HAS_X_MAILER 0.000000, __INVOICE_MULTILINGUAL 0.000000,
 __IN_REP_TO 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
 __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_DOMAIN_IN_REFERENCES 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __RCVD_CTE 0.000000, __RCVD_EXIM_4_96_AES_128 0.000000,
 __RCVD_FROM_HOMEUSER 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
 __SL_HEAVY 0.000000, __SUBJ_ALPHA_END 0.000000,
 __SUBJ_STARTS_S_BRACKETS 0.000000, __SUBJ_TRANSACTIONAL 0.000000,
 __SUBJ_TR_GEN 0.000000, __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000,
 __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000, __URI_NS 0.000000

le_conn_complete_evt() clears HCI_LE_ADV before looking at the event
status, on the premise stated in its comment that all controllers stop
advertising when a connection is created.

That premise fails for Unknown Connection Identifier (0x02), which is
what an HCI_LE_Connection_Complete carries after the host issued
LE Create Connection Cancel: no connection was created and the
controller never stopped advertising. Clearing the flag there makes the
host believe advertising is off while the controller has it on.

Other non-zero statuses must keep clearing it. Advertising Timeout
(0x3c) in particular means the controller gave up advertising on its
own, so the flag has to go; leaving it set would make the
"already advertising" shortcut in hci_schedule_adv_instance_sync() skip
the HCI commands and silently stop advertising altogether.

With legacy advertising the disagreement is self-sustaining. On the next
software rotation tick hci_enable_advertising_sync() runs:

  - hci_disable_advertising_sync() returns early without sending
    anything, because HCI_LE_ADV is clear;
  - LE Set Advertising Parameters is then sent while the controller is
    still advertising, and is correctly rejected with Command Disallowed
    (0x0c);
  - the function returns before LE Set Advertising Enable, so nothing
    re-sets HCI_LE_ADV.

hci_schedule_adv_instance_sync() re-arms adv_instance_expire every
HCI_DEFAULT_ADV_DURATION (2 s) and its "already advertising" shortcut
tests HCI_LE_ADV, which can no longer become true, so the command is
retried every 2 s indefinitely:

  Bluetooth: hci0: Opcode 0x2006 failed: -16

Captured on a BCM43455 (no LE Extended Advertising) after a central
connection attempt timed out and was cancelled:

  LE Set Advertising Parameters (0x2006)   Success
  LE Set Advertising Enable     (0x200a)   Success        HCI_LE_ADV set
  LE Create Connection Cancel   (0x200e)   Success
  LE Connection Complete                   Unknown Conn Id  <- flag cleared
  LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.033 s]
  LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.016 s]
  ...

Keep the flag only for the host-cancelled case.

Fixes: fbd96c151cdc ("Bluetooth: Fix clearing HCI_LE_ADV for LE connections")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
Changes in v2:
- Rebased onto bluetooth-next; no functional change.
  v1's hci_event.c context lacked the hci_store_wake_reason() call
  present in mainline, so the hunk did not apply.

 net/bluetooth/hci_event.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5720,10 +5720,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_dev_lock(hdev);
 	hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
 
-	/* All controllers implicitly stop advertising in the event of a
-	 * connection, so ensure that the state bit is cleared.
+	/* Advertising stops when a connection is created, and when the
+	 * controller gives up advertising on its own. It keeps advertising
+	 * when the host cancelled an outgoing connection.
 	 */
-	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+	if (status != HCI_ERROR_UNKNOWN_CONN_ID)
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
 	/* Check for existing connection:
 	 *
--
2.34.1
