Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011010.outbound.protection.outlook.com [52.101.125.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC022496D56;
	Mon, 14 Sep 2026 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418239; cv=fail; b=gXupRSJs24ONERT9pIMx1v+rZeUuzTfVclTpVk+yK4gERFQPlVwfbFjjHwlUXjJ3FlQ6eInXr++bgGJ2NO3TGGkv/ZTPCaacyjyZv/APuzXZC08zl7ZVYuPx4oFw2bxVHDwRl4cY+MS2Dw9yhkxJzMVT3Oct+H6mNLCKtKBDb9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418239; c=relaxed/simple;
	bh=FZsFxb3YpRJY0NTWRXqsoEn+YdaJp1SBy+9HNyFJ8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jmx4lC0mkh6xYwlUMGCABLGj9KGaExHA1wxwaug2dkCC1hfJ49j2h8BoHRZohJI34K5IZv1ZnPonZZjE4v/8Y74CgQMPaNAA1do4O5SldvAbKao6uEEOt1Owjci1gpD22X4G5pM10awrWYJ0/3k8LKHRDERIUgMClnJ0Z1q6Olk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=HukmCVxc; arc=fail smtp.client-ip=52.101.125.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="HukmCVxc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBAbbdzXGtGTIcDGW/s6edYy4S1fxHCQGiVvu+yTf5I+h/ji/CB/sdWeL2mzbdR5/k9/5oW67vPlcWhm8aunFcOuV/J3xuzgRCPHQdD8RnEPTb+llLdu4DHBv+ihIfgRQ9LZTReUQDUyBXIwKsi//0PfirXAnlEBz6B5jcny9OUx87AL9NX5XmRrAp60rxL7sgJE8rhuc5OZKzns2eMzHliD+G66s50tRO6cpzvFNGY3l9Rf6Q+WFg60Yl50pqOVMcv3yej5pTbe8ipopXE9e1DjWtMIiWZT+/L72ZnkdNocljt9qu7eA0BDUWPcoJulrwn0MVj6LHl1dl02lTDmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjRd2/KFe+ZoMMAx1xG/bWi9V9epDXIfK7DIKCJEePk=;
 b=RKYqzHUAdkrSWlOf9rxBBSXO+zrDclRmOGJ8O+dfI5T75LOCjdMZDTEOUpx6XURlE5BCzqTxL96iqqk/ji2jA1uZQA8ZRoNGBRikHuJnw1+HdKAZo2Ed1HaaMf7enucBmZ4GgrBwrDMOSiZ86BDfZgRzXdAMhSZ+TeLHXExRZ/kJ5aNam1kNIDAMOO5/G1u8u7wlSNUdVMYvPluuJYpTHwjSE/H/bilfZaX+RPi3897DwvstdsPb3bNz/8xVRyoWtTQwCmQBzsyByjv589tJylV/DYwxbdY/YOTs9HQ0dHkiFl59Vvcf830qngQ1V+7jzOsDck2EH6oVjC9fUrldjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjRd2/KFe+ZoMMAx1xG/bWi9V9epDXIfK7DIKCJEePk=;
 b=HukmCVxcdFCYVLIXwftwhd5Gu7MsXpRIxteNuoAVC6RC9LB1YgE7whogv3V1DowyeKi3QO4owB7FtGnb5OO8Om8Sv5GCHZh1XaQPheiYf1LVgohNnlUDcgehwCvNO+hiPpCkrpS8GUeGZwHvY7sc+MdqIN5It+1igsHnuTUh59M=
Received: from OSTP286CA0112.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:225::12)
 by TY7PR01MB15390.jpnprd01.prod.outlook.com (2603:1096:405:246::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:15 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:225:cafe::a1) by OSTP286CA0112.outlook.office365.com
 (2603:1096:604:225::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:14 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 067913000437;
	Tue, 15 Sep 2026 05:37:11 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/15] counter: rz-mtu3-cnt: put runtime PM on initialization error path
Date: Mon, 14 Sep 2026 23:36:00 +0300
Message-ID: <20260914203614.2035277-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|TY7PR01MB15390:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9dfe3be7-01a5-4ad3-2942-08df129ff62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bSiXjP80Y45vDOHjIMmjiU/QLjxrxkvLIjWoAnRx5fokZeYV+SFWFyAq3L2ZwNlK5yf3j2a8yZ9059xxxiycWgEbI5u6bFn11Mdep3thHHsCUe0Jvm/Pyqy3Yhc548NaFiAvlGd4lnF770hQieyyNDLyCGhvS65aHYn0EcEwzmTUAPgToXrfXSD/4Id9jQVSw7z5ZEwAgoAIbcLl+mvOdo9YEhAmmYh9bEXKjtpYsOOX6WRD5Ai4bddPKX3UZwjrfufL64W0EYw3B33tPESklAgWSGnKEEjPtTuOIYpkHfU5PIumNmqbjcvNGfkeR7CXpLtWRWUp+FJI8RA8APdK/PTNE1fdKQr35dKz5YTQlAGVacTH6Et/fzzr7/kixG0oOQjMOR5tMkUk4AuW8VXhm+/Bo78rHEueEejUJK0YAldn1+eorOKg/84ybVEE/1R4EaPrt8/Yu6vUW18gtsvgILjEr+Vy+pZbp8cfzTxZvNbAQhWSAU8eWazlFW82TTW+JxqmAjbNPVCsDye8fQJBgsN+FG/J73c/vKBHN4IFPD2SdHv+63+dW3AIzqmtATsfZWF+M4NmxbvjnyOtBC8C7KsVungn4SDTTFnahXI588BVwa8kLMnZKoVleIsM5JLPcL9p7ah4K8n+F+VpEILfjMYoJWSloZrXAzQW+FxHAoavXH9ekiuxfM+D0Eex/SM+k8kGGYEn2NQ921Bdx28q2Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9Olz+J4pgR7UAHC2FCc56/UWjvvV/6yq9dQlVBK6Tzs4XoneFrHEIDIgQVK+u3d8B8LJYrUBvyjaq2ShUUggkImLpqDfTj6FNjgC52JL6zmnPda3gdmnu5i0InU/CJUtGhmV4FMlDV/t8DVkORIcki7fBVJd2gKUAFDIyvHWlIWr34zicbt7pn4LKmlITrMWOIMOD9gOwdp1N03G7mC9IiHPnlImyyPFcbU5Ufbc43JLG2HBTpK42xOrsX4vdKNiMdmXomEBSIKn8yU4rpuxYWPg35bv1P8/wCM/A2Fx48zxDeoMOQJWPdb0GI7LdJs141vUNwkTPKfF0Sp8+AEQDd0fkM7uIGUNMfxmtmvBDDdqy9LjGMmQK24CHudDpaAHL677zVaRVM1Kf5FufwcUMWammg1kvnAceCLz0YNWxBbPe0v34cuyChvbGG9ency+
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:14.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfe3be7-01a5-4ad3-2942-08df129ff62c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15390

If rz_mtu3_initialize_counter() fails, the runtime PM usage count is not
decremented.

rz_mtu3_initialize_counter() will fail if the requested channel is busy.

Call pm_runtime_put() in the error path to decrement the usage count,
and flip the check to keep the success path straightforward.

Cc: stable@vger.kernel.org
Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
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

