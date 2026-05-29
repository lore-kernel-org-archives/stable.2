Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD973655CC
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096927; cv=none; b=tmizBQLdN6935SiorZg+6zPfmyJoqOru/Vw4ijblBS+Qj+XUvIG2MIC8zuAX/xIcMZG1ZjvnYXOGKewDIVgvYAWa8ex2qO+X1KghweMI5XEzAB2ayTqxngMOYeQZ+6X+vQtrS/rgJRxI09ShOZbvHbD0GqMGxKubVibINyefTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096927; c=relaxed/simple;
	bh=C8GFGVN+gKD3pk56Nkmih2r0rKElQU4sTXNyORzHlvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cllCSzyTRMFSEVrZryrifeAiTZZ92YbdIUdaLlC7Cvt1dua1u6Th5XsRa+G/YZhirP7nbuoXU49lxGs1mg00hMOdgFOSu1Hi407IihFNT7CFb+0vhfcLyJxlEPYd71d0mxhrSV+mxVvvkjQBLq+9PdwxpRVQcs4SsT6dInxgbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6hYbcXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6hYbcXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B793A1F00893;
	Fri, 29 May 2026 23:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096926;
	bh=alJUwRneUt6BwB4/QgvYyEr/Z813KUsir/L5v4YgwMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6hYbcXYk2lFmY25A+sxOmkOdP0spP4TA38ypvnhkXvXJwH8dFVrpDOzGPq/5LC+N
	 3c8BpOr6hKpoVTpEI/dKArWGEccUTRon4QGdlvThtDmhHrJ2+I649VX2K8kxJL4J7u
	 oRnrt8IHxdhCnJWHs65A49Cg4zoyxJdO89g5V03KeWMZYj8ZGOktqc1upeZigP4R39
	 XGV7HcxUArDNyML5yBrzcYVIeEA7Hjk3uQrJBZZ4CillBR65Hbc39eDC3oKzoLEsIh
	 LpC9lhV36RQfbD5ARbCAlo3iFvjtK6q6rbZ96axPBkDSv0gGWssCc0z91535N5gLJW
	 ws5ZXB5S8YNUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2
Date: Fri, 29 May 2026 19:22:03 -0400
Message-ID: <20260529232204.1873991-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052818-stubble-amigo-9213@gregkh>
References: <2026052818-stubble-amigo-9213@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit cba6b758711cab946c787f7c15be92cc749b8e1f ]

This make use of hci_cmd_sync_queue for the following MGMT commands:

Add Advertising
Remove Advertising
Add Extended Advertising Parameters
Add Extended Advertising Data

mgmt-tester -s "Add Advertising"

Test Summary
------------
Add Advertising - Failure: LE off                    Passed
Add Advertising - Invalid Params 1 (AD too long)     Passed
Add Advertising - Invalid Params 2 (Malformed len)   Passed
Add Advertising - Invalid Params 3 (Malformed len)   Passed
Add Advertising - Invalid Params 4 (Malformed len)   Passed
Add Advertising - Invalid Params 5 (AD too long)     Passed
Add Advertising - Invalid Params 6 (ScRsp too long)  Passed
Add Advertising - Invalid Params 7 (Malformed len)   Passed
Add Advertising - Invalid Params 8 (Malformed len)   Passed
Add Advertising - Invalid Params 9 (Malformed len)   Passed
Add Advertising - Invalid Params 10 (ScRsp too long) Passed
Add Advertising - Rejected (Timeout, !Powered)       Passed
Add Advertising - Success 1 (Powered, Add Adv Inst)  Passed
Add Advertising - Success 2 (!Powered, Add Adv Inst) Passed
Add Advertising - Success 3 (!Powered, Adv Enable)   Passed
Add Advertising - Success 4 (Set Adv on override)    Passed
Add Advertising - Success 5 (Set Adv off override)   Passed
Add Advertising - Success 6 (Scan Rsp Dta, Adv ok)   Passed
Add Advertising - Success 7 (Scan Rsp Dta, Scan ok)  Passed
Add Advertising - Success 8 (Connectable Flag)       Passed
Add Advertising - Success 9 (General Discov Flag)    Passed
Add Advertising - Success 10 (Limited Discov Flag)   Passed
Add Advertising - Success 11 (Managed Flags)         Passed
Add Advertising - Success 12 (TX Power Flag)         Passed
Add Advertising - Success 13 (ADV_SCAN_IND)          Passed
Add Advertising - Success 14 (ADV_NONCONN_IND)       Passed
Add Advertising - Success 15 (ADV_IND)               Passed
Add Advertising - Success 16 (Connectable -> on)     Passed
Add Advertising - Success 17 (Connectable -> off)    Passed
Add Advertising - Success 18 (Power -> off, Remove)  Passed
Add Advertising - Success 19 (Power -> off, Keep)    Passed
Add Advertising - Success 20 (Add Adv override)      Passed
Add Advertising - Success 21 (Timeout expires)       Passed
Add Advertising - Success 22 (LE -> off, Remove)     Passed
Add Advertising - Success (Empty ScRsp)              Passed
Add Advertising - Success (ScRsp only)               Passed
Add Advertising - Invalid Params (ScRsp too long)    Passed
Add Advertising - Success (ScRsp appear)             Passed
Add Advertising - Invalid Params (ScRsp appear long) Passed
Add Advertising - Success (Appear is null)           Passed
Add Advertising - Success (Name is null)             Passed
Add Advertising - Success (Complete name)            Passed
Add Advertising - Success (Shortened name)           Passed
Add Advertising - Success (Short name)               Passed
Add Advertising - Success (Name + data)              Passed
Add Advertising - Invalid Params (Name + data)       Passed
Add Advertising - Success (Name+data+appear)         Passed
Total: 47, Passed: 47 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 2.17 seconds

mgmt-tester -s "Remove Advertising"

Test Summary
------------
Remove Advertising - Invalid Params 1                Passed
Remove Advertising - Success 1                       Passed
Remove Advertising - Success 2                       Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0585 seconds

mgmt-tester -s "Ext Adv MGMT Params"

Test Summary:
------------
Ext Adv MGMT Params - Unpowered                      Passed
Ext Adv MGMT Params - Invalid parameters             Passed
Ext Adv MGMT Params - Success                        Passed
Ext Adv MGMT Params - (5.0) Success                  Passed
Total: 4, Passed: 4 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0746 seconds

mgmt-tester -s "Ext Adv MGMT -"

Test Summary
------------
Ext Adv MGMT - Data set without Params               Passed
Ext Adv MGMT - AD Data (5.0) Invalid parameters      Passed
Ext Adv MGMT - AD Data (5.0) Success                 Passed
Ext Adv MGMT - AD Scan Response (5.0) Success        Passed
Total: 4, Passed: 4 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0805 seconds

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: d3f7d17960ed ("Bluetooth: MGMT: validate Add Extended Advertising Data length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 09232c424446b..94d29c4e5f21e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8078,12 +8078,12 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_add_ext_adv_data *cp = data;
 	struct mgmt_rp_add_ext_adv_data rp;
+	struct hci_request req;
 	u8 schedule_instance = 0;
 	struct adv_info *next_instance;
 	struct adv_info *adv_instance;
 	int err = 0;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 
 	BT_DBG("%s", hdev->name);
 
-- 
2.53.0

