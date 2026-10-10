Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364E387363
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599128; cv=none; b=ceDOyty1XciH/idlBgO6GRnNP4AVOM4KCeRnzIEPI9bAr9sX6UVsFhh0uFTxMJX7VV/+FdIuvq7j0NqTwIJ6JhGdB2fXb0LyNsknvANi07rw466fbGcAta3gjmiYJqQOlkG7Ck3/HHvPOlAL9QxN9Q3IvGLx322xJjguAXRjzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599128; c=relaxed/simple;
	bh=49JRE8aEpsMdLMYh4Hcossf1+iFDCLZdHC+Na/as6go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX+LSiWCSbzwQtxj8SAfEBc1+34gQYdxn6ubU/dscfmlr/9WT7it2p5RSeFF9kOBG7+4h756CXpKG0b8pxhpbjFar3wFx8uzEjZgXunxI7/D3M6o9jnfWcecEkj0qoMo0rMgDdoHTIb6kgxdXAdmCRleqaSX843XGmj3RsC5Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB/UJlQO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB/UJlQO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49e6b771d06so966695e9.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791599125; x=1792203925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=31t7Ie3u2VmVVNbW2POrrYExkcT5d4xEi7A4yJSr4lc=;
        b=gB/UJlQOrh9e6JT4CigeJXbjgcwGuQnNwHzHu7zWOe0yqdwSEUR+9AjleC8WfeAsKc
         nbXgrqpDlGf8Ejt0KCWSMS7CsbRSID0uJ9xz6033JpFmFvylydM80eRIOsuHHwXr6ZsZ
         7VYaTZGuRhUZG3yDCnVqEpnHuIPnm9de7XpOr36hJ221Hq+LRbjmfjrAxTPH9xPQZR+P
         XARFcZ1Qa+GqWX3VCJ76HmWtn6lva9zx5ndxHgZ7JpFrvn2TyHhgCae9seTi5NdhsetZ
         OCqHWGzvmWwB/W7NF9DpLPvO2KIH5R9wcT7oyhsDz7Gsc8W5SJW30yGKowgliSxRJujA
         QsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599125; x=1792203925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31t7Ie3u2VmVVNbW2POrrYExkcT5d4xEi7A4yJSr4lc=;
        b=1itULhwLOltoWQoQNMYYo0dFbr3UMXN27vnCQV15+uqnrC51pq+T7ao2IoISeMSjnr
         Q5CCKK2PGNbQ6T1vtMhoFzN20seyj8wU3Mc1zrs+j3iN4oNu7v2RNbDLr69X3C0kUDER
         5Fxo9laDqPq1BDMs4IS+OFpjJEkKYv5KYBP/VQYOnz2Wn5dem3/s3lLoHO4MRQIjqw0P
         N13yMrlQkgHEsA+M+TjiviVO0f0jn3LOiI5lnHAviRWK+nJJwqZ6BOops7EsSVsntnym
         21930iMXEClSrYMAMLulABV59tf1rwVNTBhCPNgP8RsEhjZT4hXeTb2+vA55IbSgyTLF
         ZfUw==
X-Gm-Message-State: AFq9FYKsEkJC/LaNu+lMsNUPZvjGlurgOz9N58z70GnVfB7sy3ZcJWEc
	MMsKw9MLoFZoDOkpkaJWcOAR0pnrDf8RbGJqsnLN9/zTNpGXuS7mkSynJdI2/Qau8wxEkQ==
X-Gm-Gg: AYBFou0JR+q/6ont4vz1ZsBt9pRVn6yDXs7jS7vpNC+zON9ePLXzkeUWxtQb9837m/m
	eCWoBm7DM9mW0ONiQBr+zOfLZISuzb1SH31kdTjXT+wr1by4q6QAL8cNFWenBc37oQ4JVvsYFJV
	LZ7OdUSc8LEzK9eI7AG34EU6OSJzY5cGnF+9bR0/8PxBMIN3hqgcA6nGjIq3wyI7t3SRG2J6dIQ
	Ld67s3eVrZ0SDP8dYVq8CTnm8SG1kcAlmPIiD6IdFFq60NJn8OpgITMeu2UCyJlPZvy1n4PwlZV
	d4bqkq7kMBu5LVUquwSljmpnc3u1oyg6eO38iP67k23jaPFUD87Omua20ZV5NUKSyNpRwXsPRkO
	jnE5hqL9zSFEs3V1FdTmiRJZ7VFAh+CqoDXvdHBljH4/WGfTMAHIda+ZRS01XaQYaC7zVEU7fYb
	6sHlNwpVbWaEJHUAcR3CXUbOFntn03vb+iy6vcLqh2o101fPgEAdkc5X2Xn+Arw2GMTHoZ0KkxB
	v8FL3kiFs2E8+PyYxvqb1yKgA88b1wSLobS4G8uZny26qlo+ch6GTg=
X-Received: by 2002:a05:600c:a086:b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4a18e3ea887mr68067965e9.0.1791599125328;
        Fri, 09 Oct 2026 19:25:25 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf214a1sm109550225e9.7.2026.10.09.19.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:25:25 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: stable@vger.kernel.org
Cc: Jiajia Liu <liujiajia@kylinos.cn>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 6.6.y] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
Date: Sat, 10 Oct 2026 04:25:22 +0200
Message-ID: <20261010022523.2789588-2-yaroslav.voytovych@gmail.com>
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
8ffde2a73f2c. The same backport is sent separately for 6.12.y and 6.1.y.

btintel, btrtl, hci_qca and several btusb entries (Qualcomm, CSR) set
the quirk on this branch. On a 7.0-based kernel with dc16388d45ec, the
13d3:3503 entry now queued for 6.12.y, 6.6.y and 6.1.y, that QCA9377
hit this race twice within four days: discovery stayed stuck the first
time for eight hours, until a suspend; the second time for days, with
every Start Discovery answered Busy.

Tested in qemu on v6.6.158: a mgmt-tester case that forces this event
order fails without this patch and passes with it.

 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1a6fb75f2c1e..d5f2be878390 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1754,6 +1754,13 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 
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

