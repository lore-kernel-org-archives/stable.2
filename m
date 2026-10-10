Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60A383339
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599129; cv=none; b=gTn/WkXhGleEoL8TuL6tb152ApbDRiz8uOzZd2rhrPeF19q8n/rKd/DSeRmY1Qo3KH8Vhi6/Pf1jBkqg1mMbjqZ8iFYxBLKc9KXFmxTVWADEYoW5Ew3Ee8Ich/MI8RGlJwjoI0BWfoCtx+/E8FI82MKALckant31tWxyUwvTMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599129; c=relaxed/simple;
	bh=zxUd2nHeqKmz3e9OMVy0TLwrXVOVd2FlYOFEdJg87jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bERtBd0L/b9i8Wkf3x0MdQnSRXqm1LKSgjN0011q2QWVP89leo5oqoAndg5lrKXCv+8Ws8zDQDoa+GGGygRmNAtcAmPmkdszaviWOS3FTsxOQS2m0OYU067xW8qOewsa2SslseybmWXB4ay4V8YND8RrBzejP8JR3Lg3+gkzVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpzInBcI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpzInBcI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b0f063b7bso33066f8f.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 19:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791599125; x=1792203925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LgNElsNMjnuc/Lyal8E5Ov47I9c5Dg/gjP8NoHfb0wQ=;
        b=bpzInBcIpbGogCxzo8igXLZ0zoXRcUGX9VG65EOPJt4hMnbB4uit7EDT6Tk0ZM+c+x
         l6kaGRy3d7pajuezeaQMQ6Bx8joQ1z8ABo/BaVmp2qtSMZjuarI1EcgVVx/PqKruO6S5
         v+km3wkXjodBfkQzwY2DZH66AHa3S0EvI6EgnpTbwXi23giZGIfmnKQxXvP7dOA0Ln/k
         JU4PaeEwsPTZupXcoVkJKTuM4T6OCkf6ZQvKVzAnHyRzXnNb0+ZyfVy7XVgnYNXyKBjh
         3xCmmMt8VKaxd1JOlA1cS87Lq7cW9D6ODHNfJzAZ/dmWRfcBOGljxp3xCTBsSwJTJ7vu
         qPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599125; x=1792203925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LgNElsNMjnuc/Lyal8E5Ov47I9c5Dg/gjP8NoHfb0wQ=;
        b=Pm7CQSVtVjo5VRW7bJF7ofY7pJfxX7LRDteyXk+9KcA+qySRQQ67tqgHZVk2KyLjfR
         VG04UZjPGE+xUmxdpGiuVRr8o2EdAOzD8JrEGxPzvBzmuwvoKr1UCIXtB+BhfJm9J65w
         g+F6TqK5uZx4aMG3eTLygvXxRh8nBczwX/Hybw2ONLTN8/+Zb3qsYLfhfCdMWIDlP196
         SdVKa7ois4FnEJ6jwje3y5vYYW1rObN6CXFE2mYC2Cs2gSdvvPLfyR9Lu0xaZQZ6zefn
         QybLcVrc7RAorQq4lbMpepNueQ5hg3jkXtruvd16jdMogCQJCbGpCjVOXP20ITVUNKe0
         R3aw==
X-Gm-Message-State: AFq9FYKGpaOlvz+S9r6WaGesbqZyB3EdVJnZp8ybD60+2VY5qYwUlO60
	BTQ+dtWOBUwU469oanEAnUhonM/SyyRNW5bkJfoT1naCSA5Av1Wl9nXlb1zhC3oAuvLwOw==
X-Gm-Gg: AYBFou1GSI91Xy89S9ovhK+6XiTkRbpa151GrXaBNiSnichHy+D5VXl7ZteR+1yl8sA
	qF2jeoqrC+8fUMWQ8zNJm+1Xlqmw47kCn1cdGI17f9eN0TT1WoOXE/hKhKYgOv+qYk/fvkdieV7
	7QtGeg06bhx56lnaB50vsKOz1GWagZpSwravvWlzCSSxRirSz/kf+HXlPhdKUW/uGrwISNezgox
	JpSiM6R6XLT2uVMovC/eUKTxLNXP+Js5njkL7ZoRzViNujAwvq6g25tU7djTUFISClAzeCWakfl
	jcGRu+WcGd9qpsjU3w9GB61EByvs+C/9R6nkwuinrroWZ4w+elCNBRhCZsgluhUlrf5GzIDwMqc
	MEaWEex8+wLdkKzGvAxkgbj8fHEfNFRpkkV/W1dxIpRWG3y8uEr5uTTJnF5Pli5/+u3k37zK2NO
	zaC1qEUw2paz9oX93Tg4It/+NfXtVdpFFKWp9W2JHPcYvR/9fNIH5FyzlTSWK+smG2WDeTfjBSG
	OC77pb2RUUfOowX63R2UtbIiI/Gnt/xb2z3HhAMvVkaXnlDAfELWWPd
X-Received: by 2002:a05:600c:8b02:b0:4a0:1973:f05a with SMTP id 5b1f17b1804b1-4a18e47e19fmr76290995e9.2.1791599124595;
        Fri, 09 Oct 2026 19:25:24 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf214a1sm109550225e9.7.2026.10.09.19.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:25:24 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: stable@vger.kernel.org
Cc: Jiajia Liu <liujiajia@kylinos.cn>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 6.12.y] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
Date: Sat, 10 Oct 2026 04:25:21 +0200
Message-ID: <20261010022523.2789588-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiajia Liu <liujiajia@kylinos.cn>

[ Upstream commit 96d006ae6445679436b945593950fd465eba7e76 ]

When hci_inquiry_complete_evt is called between le_scan_disable and
le_set_scan_enable_complete and no remote name needs to be resolved,
the interleaved discovery with SIMULTANEOUS quirk gets stuck in
DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
state. No one sets DISCOVERY_STOPPED in this process.

Add state check in le_set_scan_enable_complete and change state if
the state is DISCOVERY_FINDING. Tested with AX201 (8087:0026) in Dell
Vostro 13. Discovering disabled MGMT Event below is reported when
running into the above condition.

 @ MGMT Command: Start Discovery (0x0023)    {0x0001} [hci0] 10885.970873
         Address type: 0x07
           BR/EDR
           LE Public
           LE Random
 ...
 < HCI Command: LE Set Extended Scan Enable    #38205 [hci0] 10886.131438
         Extended scan: Enabled (0x01)
         Filter duplicates: Enabled (0x01)
         Duration: 0 msec (0x0000)
         Period: 0.00 sec (0x0000)
 > HCI Event: Command Complete (0x0e) plen 4   #38206 [hci0] 10886.133295
       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
         Status: Success (0x00)
 @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10886.133414
         Address type: 0x07
           BR/EDR
           LE Public
           LE Random
         Discovery: Enabled (0x01)
 < HCI Command: Inquiry (0x01|0x0001) plen 5   #38207 [hci0] 10886.133528
         Access code: 0x9e8b33 (General Inquiry)
         Length: 10.24s (0x08)
         Num responses: 0
 > HCI Event: Command Status (0x0f) plen 4     #38208 [hci0] 10886.141333
       Inquiry (0x01|0x0001) ncmd 2
         Status: Success (0x00)
 ...
 < HCI Command: LE Set Extended Scan Enable    #38242 [hci0] 10896.381802
         Extended scan: Disabled (0x00)
         Filter duplicates: Disabled (0x00)
         Duration: 0 msec (0x0000)
         Period: 0.00 sec (0x0000)
 > HCI Event: Inquiry Complete (0x01) plen 1   #38243 [hci0] 10896.383419
         Status: Success (0x00)
 > HCI Event: Command Complete (0x0e) plen 4   #38244 [hci0] 10896.394378
       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
         Status: Success (0x00)
 @ MGMT Event: Device Found (0x0012) plen 22 {0x0001} [hci0] 10896.394497
         LE Address: 88:12:AC:92:43:69
         RSSI: -101 dBm (0x9b)
         Flags: 0x00000004
           Not Connectable
         Data length: 8
         Company: Xiaomi Inc. (911)
           Data[0]:
         16-bit Service UUIDs (complete): 1 entry
           Xiaomi Inc. (0xfdaa)
 @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10896.394506
         Address type: 0x07
           BR/EDR
           LE Public
           LE Random
         Discovery: Disabled (0x00)

Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci_sync")
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Iaroslav: test the quirk with test_bit() on hdev->quirks, as
  this branch does elsewhere; hci_test_quirk() does not exist here ]
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
7.2.y and 6.18.y already have this fix; 5.15.y and 5.10.y predate
8ffde2a73f2c. The same backport is sent separately for 6.6.y and 6.1.y.

btintel, btrtl, hci_qca and several btusb entries (Qualcomm, CSR) set
the quirk on this branch. On a 7.0-based kernel with dc16388d45ec, the
13d3:3503 entry now queued for 6.12.y, 6.6.y and 6.1.y, that QCA9377
hit this race twice within four days: discovery stayed stuck the first
time for eight hours, until a suspend; the second time for days, with
every Start Discovery answered Busy.

Tested in qemu on v6.12.112: a mgmt-tester case that forces this event
order fails without this patch and passes with it.

 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8a7ab3e755af..53732f8ddf63 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1756,6 +1756,13 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 
 		hci_dev_clear_flag(hdev, HCI_LE_SCAN);
 
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+		    test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks) &&
+		    !test_bit(HCI_INQUIRY, &hdev->flags) &&
+		    hdev->discovery.state == DISCOVERY_FINDING) {
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		}
+
 		/* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
 		 * interrupted scanning due to a connect request. Mark
 		 * therefore discovery as stopped.
-- 
2.43.0

