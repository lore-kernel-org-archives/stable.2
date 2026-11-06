Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994954;
	b=Cv2bjZHLXtUStbCiyNfcZAmXmxtf7eVs1zJ6hIJyrHhlz5u7L/WVkrLYs3AGWbXg8itN
	 hm5t/JpBXU2XvYROZ+t04Vc6rn1WkUcUBY5Z15+HYhRdRJLxwByJv5K4DgVk68kxYmsRZ
	 hx/XlFndj+joTra9GDx+KDrk42btr64ofKJw4/eSHSbgEBheIw3sPDoO4m8B40wQXVGQv
	 1kjALSvRGZWhLmdVG0TVYJnSnThhhrJVmmzilpm03EnRrcMPPgTzqar62O8Tac+BEY5P4
	 AQubv5HWBKMf+12PUkrUjlKGpEbsrfeqjipTT9C4Bqruvmxcfku5f0oKUat19nTjN7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994954;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qT7WW7vcZBPtLuk5JhrI7XyB/AaW+R0jW2UYvnd+i5I=;
	b=Qh2Oy4pdCqGaKjJy/qMSn68thoE1+vyqkIOH6d3ueYtAP+AHJZa2KGfWONfxek108AnW
	 A2D6ATZa1/Lh0PS0vlsZltdcw/QT4vBeTkLuL8HIUXUOnhA8iIY02pWCPrKd2nR+jwleh
	 rRxSothp9g7Jpe2kb9v5ZgFyl4k+cUSIWd7qfFj1XapnM9K4Q71CghvDCNDanVdhhXhPh
	 zXHjD7stiMIKCV/RB655AmB4c4mg+aCvk3csm5AA9sVXToxEAbtUdmBxt52FZdCxD8NbZ
	 fJmRBTeXfWM4wXGtFimk0zSJLgQSiltTtZBNtfjKsQfhWTywvTvOwYv5i/kUoNuCRnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=mqnCf8M6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.50
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4C606A326;
	Fri,  6 Nov 2026 19:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E4C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=mqnCf8M6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuyRoJwHTlTzCR6L8mqUPEHZtlUSWIHI61Z38z45dW6OzpD6T+n/QiNZbqs+jcoGjWQQimHxGsc+sUy0/s5g/f3YCTcLcOfiFI25JYu4L2T8a864SVHIIOl68O9G/wwewDsAc6q2n+5q//v00MaLmkZiyRs7pJMIE0Sa/rcUzaC9qbs84aSISruROTiIsaQIDTFviRjPAMM7TU4jkAzZHS7N1Qov4s1C7FfeUu8Me2ygTafqRXXq3Ae5UWJwZjzgobXF5SU9tmalT+ZasrRO4+fS/DH0XhczWi8b7SB4aVpz+EeQMr+FKxH8nJQWBMU1v9ij+U5RhjB4JjSOyaz/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT7WW7vcZBPtLuk5JhrI7XyB/AaW+R0jW2UYvnd+i5I=;
 b=vEgrQMjk/xenL+0tv/z7OQqd9rI5oWQzIKFjvmY09e/d4kr2kRs/vz5RK5+akKLDDQ7NUwJ/qU5nZXweo14iTJFokTA6XY9xMcWfLcT8pSTqb66gTh1yXd36o047p3o5LDhUH8As8QwwJKgIwVlECOMN7k3xwC48ELU/FzEL3jZjBxZxSyqXwI3b+pLaa2TuYELvHI8dnmPelKY7BpM1PBLt9YIE5kK3SSNsb9k7K2zqLgDz5dAxpC7qkG80ataYw5fWzJSs3P0okREBsDZ2+CI90pKHTSCM/M5E6lkgxjg8yeNJOdgp0CSrOhIOUfBUbB6QmPFdR/phcocetjINWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT7WW7vcZBPtLuk5JhrI7XyB/AaW+R0jW2UYvnd+i5I=;
 b=mqnCf8M6O4AONQ6EEENmO0K4WbBrQuM9V9ID/iUyLsTB0+gZBok4LLzpHYNulHeL5QB2nI9hGppg1bX+kjKQtmTKkaekqTKb/bfydQIvruaqyVVVfEnH78ut6tFn4PQCp92Id2OBlHJoqSbcHBbCMquwcMrxANUUN4iRg/btPb1oTXwWBu0bewiXasx9AhsqN3GsIWNQu5VrbWbVNIxsdXcYalFDkFBlr886qBfWCW/UEvuUBkWyhg66OBsOWv3xE+qd83f0g+tAudXW+K8b9eBn1wgUbnhKQKwQYvEWQgWIZK61MMaw/cxrVRaehAc22quRA9erciU91cE+CNUK2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by PH8PR08MB8487.namprd08.prod.outlook.com (2603:10b6:510:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 19:55:47 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%5]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 19:55:47 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: mii: Check speed and duplex only when autoneg is off
Date: Fri,  6 Nov 2026 14:55:44 -0500
Message-ID: <20261106195544.4146568-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::12) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|PH8PR08MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: dafdbbe6-a7d1-492e-fa8c-08df3c3ff365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|10067099003|261028144727099003|11063799006|261026121527099003|261022075727099003|261026140227099003|261102123227099003|56012099006|261009223027099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	3aPU4BgDjlPy/DIwa54NfVAcRmQtdVrr/dw6uMut4VmeTlQpuR/XrXdRYuywJWlWPNcLYTLlM2Xou2iYqctJaNnhsHlP5qjQdR1dOHE7keWJc6j70SkZpUiFrZ+cfA5pcysjaC1zxbv91CAvrHlALd6erWCYNa/75uMmfG39IMMpWytRfHOIrk9iAaXFbjRn8M1xWgEor81e2OvmA6WOBAuIJ0VIDVa80JAAPl3KaWjCnBt76HLQCSA6wEjRk4DoXMirTwQtkscvKQQ8EFHqiE3yanhiutcHOZdaULBUvLZj1KWP78mbyeRn4aa8a1qAcWelTtaw3aRtzfp7mBWHzUd7DuDF+V9hePNkx3+oK1zn5Lu10ckPFRIuUJU+2ZwOEJmHsGs5o2MGs/vYUiOVnhAGkHqbZZIcpUZZlhZ/tc9AURaY5Yiomo7XZoQGZsnqRvZtKbdAaxe0eU9k+TaESge3KH0rFMC0IOt8VTJ+gkRik7YOmWVnrh/rxr5rB/k2Lzg2XziCUJFrxtixJ4WTCqNETbvYC294b6AljkZ7R05D+L/Un4umU+AXqS4dVMztAYXuPPSYrloUHhwi0mteJ67pwHnTQhbTOrdxTFGfltuqSLiLd3k+O2NHzMlHpNPthVG+MxYu7JRdiGVcfW/rGOlEwY1Gff0OzCcGr6LHRAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(10067099003)(261028144727099003)(11063799006)(261026121527099003)(261022075727099003)(261026140227099003)(261102123227099003)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BnetGm9L2XLdg0iXhUacoGzw6djt4fcxkmTACDcdTcW0gGluoLyvj4qwJKzr?=
 =?us-ascii?Q?nnzJ7J5Y4StBxdYUgil0To4hqusDM7ULtVvxV0P+EdBpzlhM7b/Q5Btg+NNJ?=
 =?us-ascii?Q?iBVUZYPmGtLLoa7b443S1sYNp/NroE/QwB1JOST3KHA4T2CpRov8HZf5G0a+?=
 =?us-ascii?Q?PnLmGxs7oq/YcIljV48m5ZQ8LDc0m9dynaubyBDg7oMjTbsYjhol+jK+vsiQ?=
 =?us-ascii?Q?7a+8JfEQoK2ITryvzTTmtxNkKQwAJ2HzSmQDkLNaVK54kLQnYrJUX3mBRB5t?=
 =?us-ascii?Q?d4pLLt5lcwCYe/oxXWpED+6JVb05VRu8tnJfY9tSrHo+eWljIzSRbTH5TFPT?=
 =?us-ascii?Q?bxgHtGwAvqW4F7rInAKNh1HN858NJjzxAJD4YfA0nv5hBZ2PrHO1K9UPEcfi?=
 =?us-ascii?Q?ZAh8SynBJ/EMYGWD2m8b63OOniHL+B46mkmyIHildBOgXJQU1cJielLA6TME?=
 =?us-ascii?Q?NtscQcw63cRHB+Skcc14HFgCwb3XKeMNnoBj08hOjfHL5Q2KvLbYA3vxJfVb?=
 =?us-ascii?Q?XwwF/XCtipjWgA7pKD075xM4GZeKFOXF/AHjg4tr+mhT9j0Igxay9yBKxsps?=
 =?us-ascii?Q?TR4J3jyJbTAqS72NxP8dY1ruc6ney8YdrFUyh+Rm0QftLHeMKcz+e+K/duX/?=
 =?us-ascii?Q?hsY0q0wjIU97fEYrkeZtc6j/4cKtXiuAD8aX+SIVqN8o8f7IG2ZTIF7BKnWt?=
 =?us-ascii?Q?T7XwRBt/9JoPsUGQHqzkxr3RQC5UiRaoOt3kcBjOAhUDb9tlmLBPoMRGb+Gi?=
 =?us-ascii?Q?MOXRgYRVHfTY2QqWzZPz9sUZG6ix7mT5d6BPCngEv2Y7B5RGKsBVUM2/QQH+?=
 =?us-ascii?Q?mPhjeSuG73cpqr/SeoEinzAfCeDjVpGY0To2ft/0eP0+MiPweWKquMUEri+l?=
 =?us-ascii?Q?jfahW9d6FvgiP3KNYhdGBp5M5L42ifeysPVtb5ob23d0UaKLVb6LrjmQUaB8?=
 =?us-ascii?Q?53nOZJ44XWps68GT4XQWqUdtetrec2MhfdXWmmj89c+oBOG4hHND4cZerU27?=
 =?us-ascii?Q?icN0igvHqRHOJ4tCBPwUbIxoL1rAJ5Dnio+/VzxmvKSyUDRBLuNLi+CFi1zo?=
 =?us-ascii?Q?WXds3vhrIHXGHHWs0jeyJmNQNe+TG4zrEzVarkCcV40X82mmEdVFZ2hZoocW?=
 =?us-ascii?Q?9znJmlI5PGK/YXRpeX85z4d3voZZOY+Hx8LGNigeT2Vs94m2pSDFuLG9vsyT?=
 =?us-ascii?Q?2MIRN4T++WqCsSdwt/LUMc2h9kGwhMegx0tblXOuw4b4GyKwTg389Dcfz7lg?=
 =?us-ascii?Q?OrGh/rZ/T3YniVX9PTXN0KsuOZON6uIQj60AQTi4eD2pcb0Xoxyk7lgI1PFU?=
 =?us-ascii?Q?H1IxIfUkfN/C58hIiA0txgvtW6gWmmNtFo14Lea0169tyK0//MenR0rkEvsB?=
 =?us-ascii?Q?m2XBFUXKykitY+61WRi9GNpNC8BEuOE/+ye09odkeOulH1Msic+tUyqaVf20?=
 =?us-ascii?Q?nN1lMWiaAhAF7Y3VjdcRXez2gc9Ot1xhqs1BviluHJFyPLBFeLuhlAWn9nDy?=
 =?us-ascii?Q?YMrw2I9FMUBFmrjOXEBiiY17iZeiEmbkL7W5hx6V/G++vcItawd0YU7EwpxW?=
 =?us-ascii?Q?2CH79yE6bkf+Rj/7MqBfW8KbtjlbXpewWoy2meht75aktVF9ACTk0WktPd6l?=
 =?us-ascii?Q?3X+82GUGw9Afw3n8TVaSgQzBSMV4jeKEvW79Tdcbrme4R991tul1ZHngFdiA?=
 =?us-ascii?Q?s/KDtYP3LM9voDcLg1rfFoQpq7gEr+TINrBW0mbtQ0EOdAByn7hdTT06LSwY?=
 =?us-ascii?Q?ik/MSYoJ/g=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafdbbe6-a7d1-492e-fa8c-08df3c3ff365
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:55:47.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1ouwTOd/s8Mu0vPwa0V9OTqoHoE6IanxAQnVCkCIiF3xj+/HbenHYIGkLRdKN3qM8uaZOVKQKEyR+YJpGtt1XSNE9woOOjn1cudT61SHsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR08MB8487

mii_ethtool_get_link_ksettings() reports SPEED_UNKNOWN while the link is
down. ethtool reads the current settings, changes the autoneg and
advertising fields, and writes the result back. When it does this to
enable autoneg on a port without link, mii_ethtool_set_link_ksettings()
rejects the unknown speed with -EINVAL. For example, on an ax88179_178a
USB adapter while the link is down:

  # ethtool -s eth0 autoneg on advertise 0x2f
  Cannot set new settings: Invalid argument
    not setting autoneg

pch_gbe_set_link_ksettings() already works around the same failure by
replacing an unknown speed with SPEED_1000 before it calls
mii_ethtool_set_link_ksettings().

The autoneg path uses only the advertising mask, so check speed and
duplex only when the link is forced.

Fixes: f6f2e946aa4d ("net: mii: Fix the Speed display when the network cable is not connected")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/net/mii.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 37bc3131d31a..439444637537 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -333,12 +333,6 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
 	struct net_device *dev = mii->dev;
 	u32 speed = cmd->base.speed;
 
-	if (speed != SPEED_10 &&
-	    speed != SPEED_100 &&
-	    speed != SPEED_1000)
-		return -EINVAL;
-	if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL)
-		return -EINVAL;
 	if (cmd->base.port != PORT_MII)
 		return -EINVAL;
 	if (cmd->base.phy_address != mii->phy_id)
@@ -346,8 +340,19 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
 	if (cmd->base.autoneg != AUTONEG_DISABLE &&
 	    cmd->base.autoneg != AUTONEG_ENABLE)
 		return -EINVAL;
-	if ((speed == SPEED_1000) && (!mii->supports_gmii))
-		return -EINVAL;
+
+	/* Speed is SPEED_UNKNOWN while the link is down; autoneg ignores it */
+	if (cmd->base.autoneg == AUTONEG_DISABLE) {
+		if (speed != SPEED_10 &&
+		    speed != SPEED_100 &&
+		    speed != SPEED_1000)
+			return -EINVAL;
+		if (cmd->base.duplex != DUPLEX_HALF &&
+		    cmd->base.duplex != DUPLEX_FULL)
+			return -EINVAL;
+		if ((speed == SPEED_1000) && (!mii->supports_gmii))
+			return -EINVAL;
+	}
 
 	/* ignore supported, maxtxpkt, maxrxpkt */
 

base-commit: 19a227903e65c7a9c179156485660a4e017575fe
-- 
2.43.0

