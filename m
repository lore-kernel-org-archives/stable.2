Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EC330328
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883282; cv=none; b=L2Tz6lLlcR/4L6VmG01aUIl0hnxs62elxm2RYH534HOxvdBG0d5jlFApTKUhuQrmc0ui6Z+5fKCoKD7/K6R8OCpiHWJFV7wKNzzdj9yVBsUSUJi3OhvQTtu3dNaypljFkj8BnoU4hPGA2m0m+o5wMsPrX+7QVqQCVb/zUODKgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883282; c=relaxed/simple;
	bh=V/Ui34i5VcHhQ/iiyuPWIu/+9Lc/x3+flpKIsCussEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZclfKw1gzEeBvSFWV8tZ75acAo75O/NIq9KkDcTyhuMKHg49aKYfLYugxZxsJXb1homdvNLPkE2yHxkObzoxHpB7+km4gm6E2TWK3FBTi+BQWfFxWEN9yRbdPpCn0Ky0DUW1QFIQ4W+HRIKoj7AhplEsQSWnET3Uiijsyj/BM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQj/uZYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQj/uZYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19831F00A3A;
	Tue,  8 Sep 2026 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883280;
	bh=1mDfQ0fVX77y6P9bKCW1PbOr5oeqSem6IO36i6sRml4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQj/uZYIlAztDoIuURY8bGcSHpt3sHuBi6viYBmKggwchORHJNzW6hG3bfB9IPjzl
	 s/WCdjx1fWyiY2qJ01tY34hLYBaPKVzQOafJM1s89U5mC1YGtH2x+Dzr5eAnbj+4kc
	 fVLTkv7ORAOXGkqac62VCYEwe6Pf5Zc3bMDpwa3AaOcS6dZ9BT+sKkdwn5upp15Le1
	 VUek4j8SMGFrhvwYWn7VPD40Km96WhIKlaNxCpptE5Z5w5u9OcdT3/M9gCzoF46FFp
	 ctU/ddAuP4V0YQq3iu62WICOQ3pZqjSV1zRuwNdHqVPo6j/bqwDuKTOz55UccuyooG
	 Ghc+W04RI0vqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY
Date: Tue,  8 Sep 2026 12:01:17 -0400
Message-ID: <20260908160118.2547266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-moodiness-majorette-1570@gregkh>
References: <2026090318-moodiness-majorette-1570@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit abfeea476c68afea54c9c050a2d3b19d5d2ee873 ]

This make use of hci_cmd_sync_queue for MGMT_OP_START_DISCOVERY,
MGMT_OP_START_SERVICE_DISCOVERY and MGMT_OP_STOP_DISCOVERY to use
hci_cmd_sync_queue so they no longer depend on hdev->discov_update work
to send any commands.

Tested with:

tools/mgmt-tester -s "Start Discovery"

Test Summary
------------
Start Discovery - Not powered 1                      Passed
Start Discovery - Invalid parameters 1               Passed
Start Discovery - Not supported 1                    Passed
Start Discovery - Success 1                          Passed
Start Discovery - Success 2                          Passed
Start Discovery - Power Off 1                        Passed
Start Discovery BREDR LE - (Ext Scan Enable)         Passed
Start Discovery LE - (Ext Scan Enable)               Passed
Start Discovery LE - (Ext Scan Param)                Passed
Start Discovery - (2m, Scan Param)                   Passed
Start Discovery - (coded, Scan Param)                Passed
Start Discovery - (1m, 2m, coded, Scan Param)        Passed
LL Privacy - Start Discovery 1 (Disable RL)          Passed
LL Privacy - Start Discovery 2 (Disable RL)          Passed
Total: 14, Passed: 14 (100.0%), Failed: 0, Not Run: 0

tools/mgmt-tester -s "Start Service"

Test Summary
------------
Start Service Discovery - Not powered 1              Passed
Start Service Discovery - Invalid parameters 1       Passed
Start Service Discovery - Not supported 1            Passed
Start Service Discovery - Success 1                  Passed
Start Service Discovery - Success 2                  Passed
Total: 5, Passed: 5 (100.0%), Failed: 0, Not Run: 0

tools/mgmt-tester -s "Stop Discovery"

Test Summary
------------
Stop Discovery - Success 1                           Passed
Stop Discovery - BR/EDR (Inquiry) Success 1          Passed
Stop Discovery - Rejected 1                          Passed
Stop Discovery - Invalid parameters 1                Passed
Stop Discovery - (Ext Scan Disable)                  Passed
Total: 5, Passed: 5 (100.0%), Failed: 0, Not Run: 0

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

[ sashal: Reduced backport -- upstream abfeea476c68a touches 5 file(s), this
  backport carries 2. Not backported here:
  include/net/bluetooth/hci_sync.h
  net/bluetooth/hci_event.c
  net/bluetooth/hci_sync.c
  net/bluetooth/mgmt.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: ed5fb41d3b6b ("Bluetooth: hci_conn: re-enable advertising only for peripheral role")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c    | 4 ++--
 net/bluetooth/hci_request.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a9ba288afe0ee..0bbf025626902 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -787,10 +787,10 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	 */
 	hci_update_background_scan(hdev);
 
-	/* Re-enable advertising in case this was a failed connection
+	/* Enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
-	hci_req_reenable_advertising(hdev);
+	hci_enable_advertising(hdev);
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 39ee8a18087a2..33054088c8aa0 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -74,6 +74,7 @@ void hci_req_disable_address_resolution(struct hci_dev *hdev);
 void __hci_req_pause_adv_instances(struct hci_request *req);
 int hci_req_resume_adv_instances(struct hci_dev *hdev);
 void hci_req_reenable_advertising(struct hci_dev *hdev);
+#define hci_enable_advertising hci_req_reenable_advertising
 void __hci_req_enable_advertising(struct hci_request *req);
 void __hci_req_disable_advertising(struct hci_request *req);
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance);
-- 
2.53.0

