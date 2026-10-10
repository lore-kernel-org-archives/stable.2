Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4C388391
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599129; cv=none; b=g3WW0pgv2N7Fhrv61clFOUHQFxc9+JdCsYllZVEdhDjSDuox/DpR2XVBijX2gN+Flw4Nk3YRPCgEHttBqqnSXhIxJcRgOPQz9Y5V/9yhpYFIIsELn6nQ24zcQ5rHJVXsdhm5YHQbJH43LhnEoeOpy9GEto6YTyV3RV+P1tgEI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599129; c=relaxed/simple;
	bh=jG668c9pumR9eYL+PsJx1EYCB5rmYBMIAIbOC/mGMVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7MD7sTNSpf69NivDfMeQKQubaetl7BTio8Sg+2dMiaS2PblDNrbYdEFVTOcHJ5KdjQokAbrGCv3zFZwhAHOM7aj7VAFWBS+fXA2DCTz71DKdmZJXer+brwG/w9vx1cg7Y8zra1ecXbIyFZmqsisUPkc+mqxd4z4CSsPknLdGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XocOuEvR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XocOuEvR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b06f58380so41923f8f.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791599126; x=1792203926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B6IhWldgJ+vg75hzlzOeZRqSblIL+h7oCFOcCeJ7YTM=;
        b=XocOuEvR/xWMuKseBKk6YWgg586LyT6tHDM4JuZGMyVcB+BcWHSH0P5/8+goySG44b
         HZAkNCx0O0x+WjB+DqPKdN4fpfny9V9JCTGQ8GgDnQ0I0lh+V+brMrNP1MurmP9olMQq
         thy/lJgfrOitdZrchloxyd1bPpnyYowlcVpciIKwhHeLTN/+1EXCjYgwzHWMV2MnNUKj
         uYpbqZMFQ/4Xl2jhOXB8jHJJk1uOjY58z9BO48j1zDFt4+WGbVK2NmpF4cnNIVlwkERz
         EIfQtGu/U4UlCOKOatuwhsilOavldNVc4o9/LpizN8YCOr9tCbYLfGMkOyiOEUnrrqBx
         mlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599126; x=1792203926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6IhWldgJ+vg75hzlzOeZRqSblIL+h7oCFOcCeJ7YTM=;
        b=POdYHfw6uWp5PCBj/MtITdDmgIlrOl9/MHle9ugwPTFaM49mq3yND5gJD8EqD9ecat
         dgx++fEmn7RSCU2trJ4Yonsjof/AGAyttIuBYvbFH5lJ7LFbyS4u/6qwTwivd40TjQ+b
         aA1bB0x2RYbtomCfqaVLe7qj8CAWHhTud7m52FfhqSDQJUbKOxaUEywwC9VjSL/oKK7A
         OJ58lKBqK7PwTQCEVWkNhCEEJcWxfD/+51OiR48eBABT26itt80ubNk9d+Emf0GnfGN4
         ohe5sESkSAJU9IPhmABsSOkSCL0DoLdzTuYp7XYHbn5eK+NDy9sSHjjmlP8Nl02zDZUm
         2ezQ==
X-Gm-Message-State: AFq9FYLMNNqk0ygo84KvaNwAyNx4+XyBNjCBPOhHpOMB5Gn96wBCYOA9
	iZt3SCRmLqqgGZjhEVGLLR9QdCeXsvXwjKMqg5lpvoBMY4M7j6I5+YYUeunYRt3diOznaA==
X-Gm-Gg: AYBFou3SqD6onVzJZdTO0hGVPhzfv35OsUcGkUHT4PPY6MnoBdJxjyBuhEA4+0SEvTp
	8Mm54ps3BINKxol9Ew/Cbg98KyML7tKA6M6EV6McuqSQZHY6meYTVXSpoqiLsO75ZEorG4QqIIn
	8ZeVi4Kfj+PiTD8akFCGFyojxzIqltvgsRc9h1LATBR3r8apTXeWEuHLOfratiZF7HyF/CKwJI9
	bLIVEi+IGwUcBVMso4o4sTaD6gcpdX1RZFfE+S0DMcCKNmpN1EY3EOts4VJuEKLz47RYr2mC3Uu
	QYBBMeBdYvmufK7+4wsDK6SN9AgW9ENDxuzD8+kL/Mh5TwEciJN+M0swx1ERcev3vgkz/P1Ma+h
	sQ0wWPaoHqU2cKMw+yWkMBjwhL++LF8JteAEHCeVWD4jN0yocBF3PVH+lp8faakKbGCakVotwJD
	Mqrb9aHy9RWqonYjh/YEkQJ2T0XKb5VYfcdlDC/v/BFZssIBkDkIiHS8B9Pa+KsUHUVOwPWcQ2O
	wKJLYPfcRnAsDYvS5kMPmKCoxKraiql43FNAY70+xaeIPWYCIBaeCk=
X-Received: by 2002:a05:600d:82c6:b0:4a1:8469:e6c3 with SMTP id 5b1f17b1804b1-4a18e471decmr78950215e9.1.1791599126157;
        Fri, 09 Oct 2026 19:25:26 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf214a1sm109550225e9.7.2026.10.09.19.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:25:25 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: stable@vger.kernel.org
Cc: Jiajia Liu <liujiajia@kylinos.cn>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 6.1.y] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
Date: Sat, 10 Oct 2026 04:25:23 +0200
Message-ID: <20261010022523.2789588-3-yaroslav.voytovych@gmail.com>
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
8ffde2a73f2c. The same backport is sent separately for 6.12.y and 6.6.y.

btintel, btrtl, hci_qca and several btusb entries (Qualcomm, CSR) set
the quirk on this branch. On a 7.0-based kernel with dc16388d45ec, the
13d3:3503 entry now queued for 6.12.y, 6.6.y and 6.1.y, that QCA9377
hit this race twice within four days: discovery stayed stuck the first
time for eight hours, until a suspend; the second time for days, with
every Start Discovery answered Busy.

Tested in qemu on v6.1.189: a mgmt-tester case that forces this event
order fails without this patch and passes with it.

 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aa879b0b64cf..c6cf8b348314 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1748,6 +1748,13 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 
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

