Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935C242925
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978988; cv=none; b=rnehgvLlxrnETc+5N5nLBxInk9GCij7O0cshMNYVElswt7drODGyvCZNV9SQ5NlWKv3A+ctU7QU5dJ/iXQtf4c/eTn3IIi161dYrvrfrE0GjzSOvwuZSUc4AahewIVEby5EdGRf4ooxvJ5u7+7rCdbfugV7QzvgIoQviufdsgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978988; c=relaxed/simple;
	bh=2bqgYurh8iwQTQa/keWKcKZ+VVDHHq6p4qTQ51UEFgU=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=iqdKBWJCrjTfUDx8r9Oyy7TqaSArVJBqKjmR0slI465ndTYTaIKjMoCYCbDuRsRziqqThrwKMBLOqCoeQnvtW3H8Zz6eqguNvC+kqv661ecVGvKJPZVSATTgssEOVlhaPUHmk9YOKNCCk5BJI1NZMzI4JvzXX5QWrQ9IV8ed7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=tQVpC1Ge; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="tQVpC1Ge"
Received: from [192.168.16.44] (port=36555 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1wvyrU-000000003Qi-1n52;
	Mon, 17 Aug 2026 17:02:52 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1786978972; h=from:subject:to:date:message-id;
	bh=2bqgYurh8iwQTQa/keWKcKZ+VVDHHq6p4qTQ51UEFgU=;
	b=tQVpC1GeX6MtWselDfMHgV2bAboiyXgOQRtYfvEmbKSXtAV6wZs+EhqrBxUXeZQxZZRn5evJh0g
	wr5CdDf4AaEcyKUfd/UFuA8PzlrCaxTSiPz/fCBmqV1GvRcIBIMcUhf5W7dyYf0CPCGdWyo4HG6tu
	IQD24pr8FvyFZ1pW8Ws=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 17 Aug 2026 17:02:52 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/2] Bluetooth: hci_conn: re-enable advertising only for peripheral role
Date: Mon, 17 Aug 2026 17:02:39 +0200
Message-ID: <20260817150240.520181-2-valentin.kindschi@fiveco.ch>
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
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODY_SIZE_3000_3999 0.000000, BODY_SIZE_5000_LESS 0.000000,
 BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
 DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IN_REP_TO 0.000000, MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
 OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000, SENDER_NO_AUTH 0.000000,
 WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000,
 __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000, __BODY_VOICEMAIL 0.000000,
 __BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
 __CC_REAL_NAMES 0.000000, __CT 0.000000, __CTE 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HAS_XOIP 0.000000,
 __HAS_X_MAILER 0.000000, __INVOICE_MULTILINGUAL 0.000000,
 __IN_REP_TO 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
 __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_DOMAIN_IN_REFERENCES 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __PASSWORD_IN_BODY 0.000000, __RCVD_CTE 0.000000,
 __RCVD_EXIM_4_96_AES_128 0.000000, __RCVD_FROM_HOMEUSER 0.000000,
 __REFERENCES 0.000000, __SANE_MSGID 0.000000, __SL_HEAVY 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
 __URI_NO_WWW 0.000000, __URI_NS 0.000000

hci_le_conn_failed() unconditionally calls hci_enable_advertising(),
although its own comment states advertising should be re-enabled only
when the failed attempt was made as a peripheral.

hci_le_conn_failed() is reached from hci_conn_failed() for every failed
LE connection, including outgoing central connections. For a central
attempt this enable is redundant: hci_le_create_conn_sync() already
restores advertising via hci_resume_advertising_sync() in its done:
block. Because hci_enable_advertising() only queues the work on
cmd_sync_work, it runs *after* that resume has already succeeded and
set HCI_LE_ADV.

The resulting HCI sequence, captured on a BCM43455 (no LE Extended
Advertising, so legacy advertising is used):

  LE Create Connection                     Status Success
  ... 13.8 s, peer never answers ...
  LE Set Advertising Parameters (0x2006)   Success   <- done: resume,
  LE Set Advertising Enable     (0x200a)   Success      HCI_LE_ADV set
  LE Create Connection Cancel   (0x200e)   Success
  LE Connection Complete                   Unknown Conn Id
  LE Set Advertising Parameters (0x2006)   Command Disallowed (0x0c)

The last command is the queued enable from hci_le_conn_failed() running
as a second hci_enable_advertising_sync() pass. It clears HCI_LE_ADV
(hci_sync.c, "Clear the HCI_LE_ADV bit temporarily"), then sends
LE Set Advertising Parameters while the controller is still advertising,
which the controller correctly rejects with Command Disallowed.

The disable-first call at the top of hci_enable_advertising_sync()
cannot prevent this: hci_disable_advertising_sync() returns early
without sending anything when HCI_LE_ADV is clear, so it is a no-op
exactly when the flag is wrong.

hci_enable_advertising_sync() then returns without sending LE Set
Advertising Enable, so HCI_LE_ADV is never set again. The legacy
software rotation loop re-arms hci_schedule_adv_instance_sync() every
HCI_DEFAULT_ADV_DURATION (2 s), and its "already advertising" shortcut
tests HCI_LE_ADV, which can no longer become true. The command is
therefore retried every 2 s indefinitely:

  Bluetooth: hci0: Opcode 0x2006 failed: -16

Observed on a gateway as 5326 occurrences over 3 hours, ending only when
bluetoothd was restarted. Connection attempts that succeed do not call
hci_le_conn_failed() and never trigger this.

Add the role test the comment already describes. Both other
hci_enable_advertising() call sites reached from a failed/closed LE
connection (hci_cs_disconnect() and hci_disconn_complete_evt()) already
guard on conn->role == HCI_ROLE_SLAVE; this one was missed.

Reproducing needs legacy advertising (ext_adv_capable() false, so the
software rotation loop is used), simultaneous peripheral advertising and
outgoing central connects, and a central connect that times out rather
than failing fast.

The Fixes tag points at the commit that introduced the advertising
restart into this path for the directed-advertising (peripheral) case;
the role test that the later commit 0b1db38ca26b ("Bluetooth: Fix check
for direct advertising") added to the sibling paths was never applied
here.

Fixes: 3c857757ef6e ("Bluetooth: Add directed advertising support through connect()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
Changes in v2:
- Rebased onto bluetooth-next; no functional change.

 net/bluetooth/hci_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1262,7 +1262,8 @@ static void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	/* Enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
-	hci_enable_advertising(hdev);
+	if (conn->role == HCI_ROLE_SLAVE)
+		hci_enable_advertising(hdev);
 }

 /* This function requires the caller holds hdev->lock */
--
2.34.1
