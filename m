Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792639043;
	b=4j/rhGIwcIXR4HSFIYi7C0uNmyXuDZe+zK0dh6QZfiERjEDkLhYYpJX37C09feM/58wD
	 Q5eIEM+m1+aCTy9taFw67LnB4x6bPpVweIGRHESAk+mKqwvoULsLYQfJGyMVixNSMds0t
	 sZpDo7bhTjzsAFIHPnUP7HSbFnTA7GQ9VCmHMOWYjjJTQoupaROhgWu9hzz9b4LVQcDMZ
	 4BQxkJl/bS3Xu9ZpM+Da1cer8DIgP76DyK61WTap4091jJhLyL0fXJKypo9OVX+1O4Qm2
	 bu+rgMaZDpHssWmiAoj5C3GGiUcLFXfO69IGdsPkq03xN53Z+VZu0lcozvmu5lMf+lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639043;
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
	bh=UmIWFT4H3ZNRbhmAOdq6JIpg69XUa91XkHX9t2azqUU=;
	b=Q6Ral5yaDBpJ2KTGYawI9UNy+Sa9e/Vx9vLwhneGpgywPySMuvmiajoZeXc555CUU3Uw
	 +64Npcw909vYwTzBnPL+vSmaS4PFoSRhcOA5GOFcQGSaKiK8IybNB02GXoDw6eeyuWKgF
	 UdOOyeLL28YR9Fb1Pviyu9qIGsIItPsqDp7GG2hOri+BNxpjcOwQJWSjynqScIIZdfybC
	 /EUIb0KRq8m58YxPAAOnnX87+jyEeZXUAjQg2lGmVYEoF/Cw/EkbX/S/fqTZjU0tH5mOe
	 b0F3FLaIHLsk4kET+vZROaT0wCq4f6237PnZzi8Ruh4d6sgrtuY9huHV23qyvHO+T4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=UP7gn5Wb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2B606A319;
	Thu, 22 Oct 2026 03:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E2B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=UP7gn5Wb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR7QyvKlM+TMGMmywzHp+ONxWnRx1KUy9+ePorEUNMQPM8NYTfqZu7xgZe3L0T6OP/HmbSg8Wz0dbyWvo0X9DlXn3s+SwLHn93sB7Vwjl2/uXubfc/9eZOtVkyY2gbBcqmKcUrB0KdybvamLSgSw0TR9gH9N4StathHTotyVkCZW9DS4lin37kIK7OU36+KQO1bolBzkmrgRji/2MQBYOmenjAoY8qQYBCxP3DVP+JukqYN7a5+xhg7FyoSL7vuYfKvnCLC3dgOfl1YPbuNkqY8JKhkhG2x9Iop06sCb/r8ZwpMoM8AF4pBCRlyfHprCLS0MDE+DEkJCcSDeVmu5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmIWFT4H3ZNRbhmAOdq6JIpg69XUa91XkHX9t2azqUU=;
 b=GnycfqVOcezGK+SwHXrjpI/EK40kaTkAOGYvsoDgJhYzDPVrauTRN7nkHZbi/VUB8ofw15KV3sGy052zUNSXIBpvSa7sRrbXbqUhgkLCt1+HK6+mTKoDrEKcn2sdsGBsLiRWtAFt8e4NoYZ3TZ3tvROtzJGIns5qyQzvya9hf6pRZIqsx5nCN9QM1Rt8Cu/hAMyz83MutdhPD3lAfC5mhebVmQLrvC7bYoxqjQXfchRVHq8Sta8/mPk4Cvki95NqGvcx3XurKX+AIojb0GtODqYS+7aSnD0T1xRvZ+HqcreuCWA7vGC/WP/Z4wxHsfo7rDEehkwntVSYQfmCP2j1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmIWFT4H3ZNRbhmAOdq6JIpg69XUa91XkHX9t2azqUU=;
 b=UP7gn5WbmrQzIo7C/kYN+GLiKGOjvAyiQGGN46uqmaSTI8kQB+43YJ2V8cPyR4x9CpGO7p+SRwDSavGjDviLvHaEsgtGmZrR+7UWgUERFo3qHikzDvw45IWV4nNLO/Bue4ChJY8J8k1jX/MbbD67oCxGCIijJfblnqw2X/X6EoksepU2aziiGGFieCGdo5kERHeyyOU7ONz4v8r1FlGPcxjDDt5DWxQPpsmqwm9+JoqJEqPRPxn3LJvHXi2rFQo7Axt+Tesq3UxbHGY2OLw65xlljHhsiwjp3NcH7GOpPKDlNSPzIZ8/tiq3uG/sBwa841Y8EAb23fcLhXc6Hn/i4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 IA0PR02MB9898.namprd02.prod.outlook.com (2603:10b6:208:48c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:17:21 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 03:17:20 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: netdev@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] mctp i2c: fix double free of midev on netdev register failure
Date: Thu, 22 Oct 2026 11:17:04 +0800
Message-ID: <20261022031704.2295541-1-kenny_hsieh@jabil.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11)
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
X-MS-TrafficTypeDiagnostic: DM8PR02MB8087:EE_|IA0PR02MB9898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f663e94-5419-46f0-30cd-08df2feafc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|23010399003|261021123027099003|38350700014|56012099006|11063799006|261009223027099003|10067099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	5vV6VFT0biK3pBbRvtRCkDYuyOyOQHa3NTrNEMY/PH1MJveg2E1/+stwbhZXaX7dwFUJL2nuSYqWxejXLsup/cLDmGrXBGOt/6YBsagEFjOYKxdxN7Mv2S3/Vi7uO+m7zNxdLefRYSByO/rstoWfkwNDsenoyzB45yAFrTXKm+qmXzrzIdpzbSowqZZiyjpsVzHK7Bra6g5CVNXX0y27N/e1BvZBnj2s6uy+Y+ixpX2YhJm5rKImaxeFaoXsf9QBlFnAuagNWgXfjMBL4i8oQXEDNRLtm4h5i/GB3x9/FS1YMxCjsMaQ5eNLoKoD92RydRpI/FsOmkxDwKO55n5/xxFA1YhLblp1sNR3BypOWkjsazLDIqJGpAKXDzWjktqMRaALpj/xDsQlhMFesENviEyEb7vzUogDxqAHNvMP5ETddy4c3ReJVe0fsvo8D0RgCBZtP/ZOj+PUHDXSsTx6FnLlNc7pCk1ezC+E4IUx05qmUUl/Sw33t2JEgt8S9+SXCUOP+Jm3wC6zSTJ0u4um5nBWIxY/JYUyVulvaFJRtT4xT7cu8DCuOJMdeVROHWT4h9t0aaz1CkVrnNNPwYf+5uO23hHFK4nYBoJAQZ3p+yB1zteI+WvgJeRp+TyMGQbw5aDW51oKheBb1Sd3CqNNOi7hnetA98Sk2kNx7oCr8QQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(23010399003)(261021123027099003)(38350700014)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7irbMKXqV0dIVwv3KqcJq3LyDBX8hnozxRPp4TOzydTbuS89EgHVngwlZT3K?=
 =?us-ascii?Q?RBcslAqnke9uq7+m+a9Dnkt2JRgosIy9pDEnpnTVuXXjrzTftGL1fVuA+4CY?=
 =?us-ascii?Q?sMpbclvzvgcsctRn0K31I7QK0MMwJWEZfvdfjoAlkmjrPmeI9D7V6nfD207C?=
 =?us-ascii?Q?fd9q4ZoaimbeK+b0nmtQItWP2jUOjfYyv8dbq7NbL0K9HCPIfqyS4/CC135H?=
 =?us-ascii?Q?Z3o2TNvvVM3pTkN3+KkyDaXBtIiJxlksQMexyeB3iD8qf8MuI6hfrqG03Kj0?=
 =?us-ascii?Q?pr8KCYHmyDQvz9BIN0lu4AXHu7xtfAGa8K5O5msdWRHQe63B3skek7jRTOf5?=
 =?us-ascii?Q?ztb6apH/Trr1A36YXeM2VwS+WStjSuokBjxWkENxoCYCqzgWHfFCaUVyJq3b?=
 =?us-ascii?Q?nDxsTAcIlG9MUibsFKT92Inaki5PdFqrTwUIbMLr4JbTJam3uVDQ5WjxIJyB?=
 =?us-ascii?Q?lz+jfX1JwYyk+VSoa9sRYBbbSeBSS8lb/vZ0d1DDgpD3OgLxHcTlCrLrnBBc?=
 =?us-ascii?Q?v1tRduzBzkX+BShMvZAkPGksOMNPmoPytq4KfMAH3arkeZ879ouhlpfA01uV?=
 =?us-ascii?Q?HujUIjfgw0Oo7jxdh3w1Ky7kpu9RhODas+K+Vsw5Jy8hSCiK6e0f1PCuYTlo?=
 =?us-ascii?Q?5VnXpXKtwnVay4BQ0ZOdVrlLvGeXk8eLpK8A5ztiie2vzxGsQH8bC0WulsJK?=
 =?us-ascii?Q?HmxBYeFFBZQbA8BCAxcCEo73hXVIuod4LKMxWsa8tn0mUKsDAdL/Rx959lUE?=
 =?us-ascii?Q?oIr9/nwccz4Y3w/bgnG1ai0XGPwFMHNunq5JOoa5vXo2bCpRDeypIDcmUO61?=
 =?us-ascii?Q?+hafv22/BxVBXeaF3xQ86i8f/IrVY3qdEyTzgYMiS7v30r9GWw7h9iree9P5?=
 =?us-ascii?Q?7y3ia/EDdqbbOlNfV3W+0MXqYAtpqoq+fcsY9rtcfQSgAv1BXOXEp6paIkVL?=
 =?us-ascii?Q?93tl5E8qN/zbvFzxHGUIfNKUYyadS/8nhajgBobmYhWcQTcj8ESLw0gINKlA?=
 =?us-ascii?Q?Uc5cjqHXffQDnSLwhLNlsjqYYZOhN1EtgqCyr9UUtHMnbNGQg6+ff5dFIf3/?=
 =?us-ascii?Q?6K4jydY+LEylXgvC5z7JHunRNNyBo4RbRNUkYpxUweLjKmmSQca+leqTSdZA?=
 =?us-ascii?Q?zTVMnIc24N/C8v3gZJje2gVYPrjKZdd++BrZcx1aZA+bQt589MXahpzP4yk1?=
 =?us-ascii?Q?AqyMCsi93EdQOx8dKEJ0tKEsR7vhiVlfHVGWQ9d9qyRfm/wD1l/MgotuQFla?=
 =?us-ascii?Q?2Oho7mS16hIdIRf0p/ci6qLJP95ydNXCru/R2i6byFKDvVeGC8ygRu5rmh7z?=
 =?us-ascii?Q?kVzeAczYE99szsGzOim3Bc/mRY/2SAvL9FnmfUwmaG/FCQ6dSC4mXakIW7pr?=
 =?us-ascii?Q?7aBEE6UMrGj1h7ce9oV/hvAt7xeZKV3t/N7tfCDUIKhJSJ0QlLJUgYmTSvXi?=
 =?us-ascii?Q?y6dElVTSmOsDJG8dmY0oOhqvIR/EcyKgxcrKSyWq4g7feC0qhwDHowwzLYfz?=
 =?us-ascii?Q?gRwnU+C0tF11cLMGcLlm2VBJ9JPdL3Q2ISdppMWmw9UUjzy/jmfmBjYBf5vJ?=
 =?us-ascii?Q?Lsp/kxnmDDMX35himRA6gc7X2+tqP6Qr5RuYR75DeeHVdmNm8H6UeiqUInuT?=
 =?us-ascii?Q?1AYi2dwWvc2C1woxloT1zkJBktV4Cmo8WMGIbJ3fRf8T0CEYAkn8tyJim81A?=
 =?us-ascii?Q?87LmumDlpeE2Ycy5O5k+e5Idy6OR0WtrO1k7axERvke+l4KTE2s3MR9mAMIX?=
 =?us-ascii?Q?cRSjIUlJbQ=3D=3D?=
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f663e94-5419-46f0-30cd-08df2feafc05
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 03:17:20.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKpD4KaM6yDr07UVgnJb2Qrcw2wZlyTe/eDQZjQEc7w5MtTLYLFMNtyciVb7rZjlF5mZ6imYH5vyhthKmF4Eng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9898

mctp_i2c_add_netdev() initialises midev before registering the netdev,
and frees it on its own error path when mctp_register_netdev() fails.
The netdev's ndo_uninit, mctp_i2c_ndo_uninit(), frees it too.

register_netdevice() calls ndo_uninit on its later failures: the
err_uninit path and a NETDEV_REGISTER notifier error. On those, midev is
freed twice. The second mctp_i2c_midev_free() runs list_del() on an entry
that is already poisoned, and drops a second reference on both the
adapter device and the client device, which can free either early.

Earlier failures do not reach ndo_uninit. mctp_add_dev() failing,
ethtool_check_ops() failing and a name that is already taken all return
before it, so the error path's own free is still needed for those.

Make mctp_i2c_midev_free() safe to call twice, by clearing midev->client
once it has run and returning early when it is already clear. Both
callers keep working unchanged.

Tested on an AST2700 BMC by taking the netdev name before creating it,
so the register fails early with -EEXIST. midev is freed once, and a
later create on the same adapter succeeds.

The double free was pointed out by the Sashiko AI review of a pending
mctp-i2c change, as a problem that predates it.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Closes: https://lore.kernel.org/netdev/179239912623.3135.11352652156626817288@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
 drivers/net/mctp/mctp-i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d33..bca379af3 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -788,6 +788,13 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 	struct mctp_i2c_client *mcli = midev->client;
 	unsigned long flags;
 
+	/* Runs from ndo_uninit and from the mctp_i2c_add_netdev() error
+	 * path, and register_netdevice() calls ndo_uninit on some failures
+	 * but not others. A NULL client means midev is already freed.
+	 */
+	if (!mcli)
+		return;
+
 	if (midev->tx_thread) {
 		kthread_stop(midev->tx_thread);
 		midev->tx_thread = NULL;
@@ -810,6 +817,7 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 	skb_queue_purge(&midev->tx_queue);
 	put_device(&midev->adapter->dev);
 	put_device(&mcli->client->dev);
+	midev->client = NULL;
 }
 
 /* Stops, unregisters, and frees midev */
-- 
2.50.1

