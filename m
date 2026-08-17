Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07030432BCD;
	Mon, 17 Aug 2026 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994867; cv=fail; b=tMehU+A/i/5fqVQyTMX2lKYHv1Veb1/sISv8gx89RIoh2otBsKKY4+re5ZP1pou0oT09qt9vpZ3VTVNNs6m0We2ywM1bA2nL2t9jXFdLDYXRpye7u5UZ7w5pCZhtcPC3uRs/H6wGYwyqDUmfGdtJrLiafJYcJfvHR7+L1EGi9K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994867; c=relaxed/simple;
	bh=f9LUw4lqD5X7tCxAHnqfJca8NPjjRRbkr3M4NzjjlvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d2zU7B7rkUFbMafc/Xa/b9sbnrujb6VmtVGg4R9+PIGLvjCj0he9t4eNeZ2gMxs/AdQ8F7ur+IGExwB5n8GzoiJphpbvg9pzcYxM3+yccaFgfnQtTxBYfFzosS1keHEouBMO2W+HFjo5W6VlToBpcB00SSG1dCbm/qdq9HIH7UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=h7whn352; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="h7whn352"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEhWMUJJ/wCXfRNzoNdEPj9ek8lF1nyRWnWzijKBGNobgAgRxO0+L8kjtBLcIKn/JVeIltyIn62cHFge70X7yOUz8xQhy7wwN4d3vIk/L+wv2PGkn9zCPlTVl9p8nD4Aym4b0Wu8dDq6YcDKqJKjOtkDMniDzvoPvST9exG2Y4Hwxwd+7vTr/Ufp44k1oHcO410YqbjHOX/SJwUSjFLw86CxQ7Jf6D9aYbIdxXgv54pWP6vc3inju0xdzscekaLwihql2AkQUrKrJkT35XrpqQK19hLd1tmOfiDv/NRV+0AEnywrOGk8aqbZOF98yC83z4xy4SQMGujd+9LxLWfOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9zSS4RKywqUkQ1Skes7MLcHplT2NiOb83gJ4gYBmHM=;
 b=WLe+qjsSQfPghENz/i9NyiFTF1EaBteii4ZE+Yn0Zn65meGsQ/JqewEUm/PSZcZRXyUquVdu7RKo61Q1RfgAH21+2xE6yXX2li3ypqGzU4Bmj11KVZVA/rgTZ8H3uf6nOtyoJjTwfu1cJNYazw1B1/ozCU37vAn4FiXoX816NRxKvvPg5Zkv6YqLZuTWEbQk/PwKbaV+d0qki/2pZLGSHl1KL4iTnRoZyvfmTUHKSBo0eOeGqzqKvFlCFJNs+TptjRbs5APfiTXlZmtgAyaXNTzQmAgI4ah8/QVJxKLPd75+7WfZ/uHNUmVzUu5UPpQxiM7UAiOLAZgVms5XHm2sOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=google.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9zSS4RKywqUkQ1Skes7MLcHplT2NiOb83gJ4gYBmHM=;
 b=h7whn352q8jdiIEZBQcYUoUykXdwLqiplpjc7jyxr1xliXyPGVRXKiamtnyFWxwxk4x5mq+OWSBGqq4DGbqBKiOnCYArJ+sZsF53RFNJamHFC0JjcLS2qEsUnXoUdkEE+RG3ttYWFH00xN1J3OL10NqfAd+STXfppLOwtwm3DY8=
Received: from TY4PR01CA0072.jpnprd01.prod.outlook.com (2603:1096:405:36c::7)
 by OS7PR01MB13860.jpnprd01.prod.outlook.com (2603:1096:604:368::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:27:41 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36c:cafe::40) by TY4PR01CA0072.outlook.office365.com
 (2603:1096:405:36c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 19:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Mon, 17 Aug 2026 19:27:41 +0000
Received: from demon-pc (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0467A300022C;
	Tue, 18 Aug 2026 04:27:37 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuen-Han Tsai <khtsai@google.com>,
	Sonali Pradhan <sonalipradhan@google.com>,
	Kees Cook <kees@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Felipe Balbi <balbi@ti.com>,
	Jim Baxter <jim_baxter@mentor.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_ncm: restart the TX timer if the TX freelist is empty
Date: Mon, 17 Aug 2026 22:26:38 +0300
Message-ID: <20260817192638.437798-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OS7PR01MB13860:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6ad11ccd-03a1-4756-f98f-08defc959aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	HLdLK2bvoZCHn2vYDPoouDb73U2WOo3xwMmVTnBkH81aWSo/hTWtBaFLa9UJMIZO+PWnQRdg9xEXqzD0IW0O6xHkVr6W+R/n9E3d6VGQApI0fsf2Of/Ea3mUPPGLeKPM0TuiJ1RpyKoQRgDTcsKWJlQJu90P+LEhNSzeg8g6MciypsGgUqQgbJl0wf7EzlWEFgTQFnG1/Rz3+l1Si3WLuX/CD9LLjjQ1XZENZQajV48PX/I5XDw4Vfjd7EKJbITG+XWJz/RaclsaLhRp8lTDFJQKAmS8802/C8x3TIjYtx92QasAECAZ0+Bf8SMLFoehnmaoHUkKFuwx+L5difx9UnvB8ZZ96jKOd2E7Hc0UAyl3ejKnmW9JVTAiAmtTyxJPyw/xeXlWFxOGW6Tz4TBkAAWTnHNarmWaD/ERdr47moq6am/OSvG5q81KeMfMfBSYbZUK+dZV+TzWtvNNL33naOSFNJ7wwuxLJPFz2kBtGFIYIZSAgXpp4h6SD0b2Chn6lgcWtQdG7LAbdk/5Bf/DkwjJ194eRWvB3kOd2MUNzKyarhGL5lb2XJfTJT04TRCPr3ku6aYkYn3hZ/FVIwDZRwCmEipGme5rfzfqCsM8sni2as3GpCaN2YndwrHhqe8YfjVIT6QcRFX1jJ8rxvijXvMSiOABECDJX3PUY3h2yskvUx7vyNH8XgntimB2XxA574JY6n1UKxFqQOBrWatfnw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wXSaWupc/UGYI6YsAwvhBV+mr2UmPmvs31syvnxcZygDc1Clai910GCdAcM7tg21h0tIHoCQPMTVLJLj7vPi5wcjaOhyOQIF/j/OajKqKB3HX81sQY21zOSUR8C4cakBzzVR7ot06noTMT7id+1wkuCptCrwbJDw+ZeONFaXMRBrcpRFSIDkBNo26oIECfJDh/HsartbFIUqErfXOQiGkjA+0y/TiSwdAXkW2FiklkTtuGcmNwEZbaBoMygqOv6AGN2lwNoWtDo0hTMpi5FdCnbbW/JrjHgTBF/BQCk83Rdaoq4CtTGUP/n2fXIffIpj6tzIGJ8SKs1/JOO5p5UK3mLMK+lPScP/ZlbLSsPT6E/XAViMXWtd5iZL6skfcJXWrUlR9ytyvu+2kTJ4jTf86CTU3iKapiwVjQdhzD0v3aLmhY2NlX0SwV1PudtxtMOL
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:27:41.3474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad11ccd-03a1-4756-f98f-08defc959aff
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13860

ncm_wrap_ntb() aggregates datagrams into a pending NTB, which is sent
either when it becomes full, or after 300us since the NTB was started,
using ndo_start_xmit() (eth_start_xmit()).

ndo_start_xmit() returns NETDEV_TX_BUSY when the TX freelist is empty.

For regular packets this is fine since the networking core will requeue
them, but for timer-flushed packets there is no logic to handle this
situation, and HRTIMER_NORESTART is returned from ncm_tx_timeout()
without checking eth_start_xmit()'s return value.

Under sustained TX saturation the request freelist is empty most of the
time. Since the timer is never restarted, small packets keep getting
accumulated into the NTB, until either TX_MAX_NUM_DPE packets are stored
or NTB_DEFAULT_IN_SIZE is reached, which is an unknown amount of time.

Check the return value of ndo_start_xmit() and restart the timer after
another 300us.

Cc: stable@vger.kernel.org
Fixes: 6d3865f9d41f ("usb: gadget: NCM: Add transmit multi-frame.")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/usb/gadget/function/f_ncm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index bf02545b37a2..1f521c1898d0 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1148,6 +1148,7 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 {
 	struct f_ncm *ncm = container_of(data, struct f_ncm, task_timer);
 	struct net_device *netdev = READ_ONCE(ncm->netdev);
+	netdev_tx_t ret;
 
 	if (netdev) {
 		/* XXX This allowance of a NULL skb argument to ndo_start_xmit
@@ -1158,7 +1159,11 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 		 *
 		 * This will call directly into u_ether's eth_start_xmit()
 		 */
-		netdev->netdev_ops->ndo_start_xmit(NULL, netdev);
+		ret = netdev->netdev_ops->ndo_start_xmit(NULL, netdev);
+		if (ret == NETDEV_TX_BUSY) {
+			hrtimer_forward_now(data, TX_TIMEOUT_NSECS);
+			return HRTIMER_RESTART;
+		}
 	}
 	return HRTIMER_NORESTART;
 }
-- 
2.55.0

