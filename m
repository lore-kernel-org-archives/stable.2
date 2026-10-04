Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010006.outbound.protection.outlook.com [52.101.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2606472F90;
	Sun,  4 Oct 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136142; cv=fail; b=OamnPE3UGrak0L8F468muNo2Oi8y248CPQ+kmnAo7g7FTiUOz5raEOJR9qFEoDZH+X5qHmpJDGBkQd2FUaIXd5N3DBiGt2BKFcWgermAHgVuxZbm3spBKX7FE3nrLrm7CsxbCXmpcbUnLm56XUtIGPW3/N2fKGXePgJOkbrHjfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136142; c=relaxed/simple;
	bh=vU6zBmPDVWbBgYOZ7xV2N18EGAcwGXXzjTNh39IrkCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFyg/np59ElRDCC8M9nHMMRX3PTjmSLyMKZ1zIsr7jLuFVcRly8HAH7cw9/IWoxfhvvQ0eptqQB/egIeZdLehNt+eqJxDSCaFQwp/cq0OSz9g4Wcv4f67t7voO6FvWhFx+o+33zTZzomH+FiQyA9r4x66ymlI7dWHS1JEGx+/zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=QQUtOkUi; arc=fail smtp.client-ip=52.101.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="QQUtOkUi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcyVItASx3XxiaZ6qd3Aw/QTNkxUCCwoz7WBmwq+bcjkKWdWkX3NuSqGp2mNs7ZAGb+0RfwJy3516i11mAvY0uUiIw3Rd6LZ6krdRrE6DaOoo/ZDb2pSB0JyfLmo6n9JNyY5LQFpFf16Qxm7y61fRov4IblDyXD5NxR/IZmwPix8GB44xlNwjX1vlyifxzWYK6eaid6qfOejTQy72556xqipsWoOndjVsUmQ2uK2GcAwbKXCYyMVre4Y7cKG3MXAOrwarzSxOtENLZ3Lk8tdWhBqexiFgKvPoe4U9zgIDZgaPfR3WyVwTzQHf0u3R69GamWMTE0Q9et1IIqPXC2osQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA5mdpuCMyWNUTq5cYgaaHSYpI55VhXyh8K7YrhUZ2s=;
 b=twxOz/1h8OHP4Vo235AXPlvFM+1cGrWWYaIJR1v1NmFyLNQw/TsJHUE1Xo3M/0w6RddYYcKJZsXTd+YgmhkuNNXTjRTJgqu2i1jjHyk6NPhAtA5SJhlwfNOHF3/+O60OigMxvc4f36KG/uLH1GDgJK+tfj8qng4UP8gBZe2tiu+bzJ0QjqmDsu9ROIVOIinXQgfR9t3BWDjTEQpWiZk3TshN78OTyMkRXFc/bKd0+3hSek5hqmwAVXRQBUQbNK49OAzJmjxNVw43ecgA+4kurd//l5KK7XEnWk2V/NcMdfw7cuRVkb9vpnhkPXp4aKxlqcGsxdTAyfdNbHcV6v2NAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA5mdpuCMyWNUTq5cYgaaHSYpI55VhXyh8K7YrhUZ2s=;
 b=QQUtOkUiRuoVjFtw0uWiuz8KTOHJUxibB8KoqUdx30xE7DZHt1+wrtAvKAUc2zL2oKO+02CB+wWOjex4SYxI8pbpbYYmjjo85YFaRc1VLiVQE/Ig6DNdsQI/hs3UKpOiihxXAjK6kW5fEuuMVGvutnpIoDhmzz5Qu7IoGvrNr5c=
Received: from OS7PR01CA0157.jpnprd01.prod.outlook.com (2603:1096:604:24d::20)
 by TYCPR01MB11803.jpnprd01.prod.outlook.com (2603:1096:400:37f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:48:53 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24d:cafe::36) by OS7PR01CA0157.outlook.office365.com
 (2603:1096:604:24d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:48:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:48:53 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F04603000246;
	Mon,  5 Oct 2026 02:48:50 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/15] counter: rz-mtu3-cnt: put runtime PM on initialization error path
Date: Sun,  4 Oct 2026 20:47:38 +0300
Message-ID: <20261004174752.507499-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYCPR01MB11803:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dda778f7-c81d-424d-9b7c-08df223fc17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nn0Ifj6+vyPBlsbL0laP8qUD4PzVD08WOYwFwb/SMLTjK8gT7NBhK3wLJEHYh+aBrK1S0VcwKbzpu6DlpVyh0nk874RvjT+KYcal48iBvzaevEjfMP4xauNuUfsavQkmtSXQBVxvZH4F1MdiHmopNqjPw5pFDqikX1IuD5v7RNnyGNpNtzVLl8tQ2olUHW6+Z29hwARTTJ0poheaOlFI6FFkMiSFmKrk17rvAiDypUlVdXzyerp9O1oLb3UYFc5NtF7CljeiAsvcp6vzv0+y2N2qUk6RH/NGxQo3GUZYiUMz4K0dI37s1iI0UwvtWblafep4pyCSLWQD+fqvoh+IPeGMCvNszoVOORw1SPLmfGE3loQSDxpEuSSZNl0C7xdHOdHtcEpsTrmY5KXy9LSlkGdRqR65cTpyl659EDWE0+BIkLHuwB0Gdnq2zpoZEuw8hthNsKmCSTBNLgsY8ypbdgCH8qE6pSArDQAv/qO1Z+i8Q7mQtWEY/pr5cOobHaUN1MXnk8TgxvPgvoUpBwuse3PDjisvg/qmjbiahW4VZvju6N7mLNLLjZaiHQxXdmRfVohmX1tbzm47KaAraxiCY+xwWfIEd9t9aEZKeimnXKPXip7zh97pjdZ+5cWW8Vyn+KH45mFTAKFY/WCkQ2k15KruJzwGAShjsmDZcL6bJhQ8MJberXyfxRXVSH+fXZ7qdzkKS1M7dJX7DHxhxyuHeg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rE/y+Zo1EDKCbsDlcvOfGi5Hy+NlnJojeebOkUhq/BUutGyiaIL4WRJJvXoykBkEpHEsFarpc3eJMhJXMVGXNDDyd8aWDg40/LozZTcYaNrSw1KCe5xUZFOn/r2kxw8txioUrVi57M6wYSLSM9jPYxf6PwQZn+HHAC3TRTcojtzvWmbQMLFsA/3zIdZ4sWV/XVGfoHXY6zEDvpToQQ6/0XMwihfuZurK2OsAaX9WoOeE8KlpG5Ay+QraTA0UhYBxwWnL1vDNXKOiiEBYdCQ+QtI5e/ruKHWhiCOLqZtUho1AkxjklVy/cTXDlkP8JNd4g/4L+eu2SK6SaMKiBC9a1TioMoBjoxnW3qk1tuDQgSFm8BjN3QqzRN1YS0pV4CRBCtulRhVHeZ2pgDSWydp8CFwBPv+myJqGXECRsP+pePImNZ2G3gJGnB2gNDqRAl4B
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:48:53.3588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda778f7-c81d-424d-9b7c-08df223fc17a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11803

If rz_mtu3_initialize_counter() fails, the runtime PM usage count is not
decremented.

rz_mtu3_initialize_counter() will fail if the requested channel is busy.

Call pm_runtime_put() in the error path to decrement the usage count,
and flip the check to keep the success path straightforward.

Cc: stable@vger.kernel.org
Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..48f183f0b54f 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -506,8 +506,12 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	if (enable) {
 		pm_runtime_get_sync(counter->parent);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
-		if (ret == 0)
-			priv->count_is_enabled[count->id] = true;
+		if (ret) {
+			pm_runtime_put(counter->parent);
+			goto exit;
+		}
+
+		priv->count_is_enabled[count->id] = true;
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-- 
2.55.0
