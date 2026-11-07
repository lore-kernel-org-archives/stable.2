Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794085365;
	b=qLQqyOpSoJsVlHa4RKqGZ1PR1/5KagAD6aZlf8gqiCWDzMnNjnGSxlc7RfQhKspQIYQB
	 69gpYnautPcVff1rd3pD42PeVTlizThfg6vKY8dQKLLY0rdKcTUijCBTFnPmipDZaMrld
	 RUZpo+/IO/64eTYvvNa3t4ispYC/qO9CnjODJROjognfVKOJtGvvg5Y96WSHAtfaU7/9m
	 hQ2GXKAcpbzTdpXswQQcoueILeQyw7kO3z2EwrRa216mvcRXX6MnFbAtysBJbmWT0ksDT
	 /6zMIPQUNmlXGPvNr7MfUAu+K5QoWREjcLnkgX9AqjaCmNjSy7RKRJHP+RoIe/9hNEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085365;
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
	bh=MKHU+4DRXS0RhctV74r2rIwlyFr1nl/RYdFCsfJXTkQ=;
	b=0eLjuYAcFZFDrQtxr+Ix0y3R8Yqai8V05YIo2CxGdosW/iwf+fE2ob8RWngz0nO0TbEP
	 mmOSk87bMOzta1Djjtfn/Lz6OReZ+fzid1+iSCJCVo2cgk97HcW9ObAUd0Ca8qKhBtji3
	 GTwkodI1JNRpkBlPAUPD3nbUfY7wBJwbd9AaaK0w+3JhqJ3JpOwsBtQS96b+0mTdD7SJw
	 QPz3VD5I30rDnomPh2epn1KKrDmSYc6bK2sQZlFRcbDNFnc23IcCKgeZ7PG1y4rtdysQz
	 njP/42PvupHV0helWaiLSbr1JEAeh4LqLsxL4mR4CcHDH5zsmCdXO/jW/4E+6nj918w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=STl5LA0r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.50
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A1606A32C;
	Sat,  7 Nov 2026 21:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1A1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=STl5LA0r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz/rdUZOJrwRYCO8LOcwpFsCjuqJvOtSw8BOr8w9rDJCfY7lXxyQMFmUQW38nTlwXmnt5bNeD90dHREo5xA09u6Th0kEy6ocEQXCLw84y32PHuNwgwgJVORkBhhP+LlACkmQqSRZ49uZcsHyblogHZFA+lAbnKzMQy58nWJxpmf28AOxH9AFUVPLMTl6gUwJuJPkJ96Mdb+OZm4cyQzaGwQCZZyUbDM8hxegnMg5jwPHjj/6WtALUVqkye7gFBueMiZkINal5Zv+YB628uPCjkqsvl50iAaMc8MEXq6jnvKVNAL/y6V3y3oqNsbpnIIEhMANstzIMQAfn/eGXzRx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKHU+4DRXS0RhctV74r2rIwlyFr1nl/RYdFCsfJXTkQ=;
 b=DT0KWj5p3AbHLfGaw04VNAplBtz5BxmB4cv3ylJwMdyh5EnZRhD2httSggfFpZLaeKx9MVuoP383cgMDvBXXX9SVpOL0o7Efr251jkTKRXcqcvENK8rphhzpOQ71ZPGMt/k0EL3IzrL6OTMJYbJmzIxAsSKH/8XAOatTILMFBf6WCV31r5M18Era/huWmBQUuFn81qNUtGXSILFl1nAu+O0qkFBrNl2vk8JOKrzyiJBMJB06S2+zKarJGVV2DvWJMrkczbWoPLXcM6djP+K/1sigpXPlskNvA7knPwVXHnLN4qsbCjbPtxJYmCPRbExO6og050jkJ99h4qLGxvoMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKHU+4DRXS0RhctV74r2rIwlyFr1nl/RYdFCsfJXTkQ=;
 b=STl5LA0rfbnxco0/2lGBXYtthXGzHqWmRGjrgjtwREhdcCuEwQcZM2G6tdHMqLLMHbeGug841NFdxa564NkT/pwE7OlNYwMo6eWRGq2YYrCQNQMOhgXyJTHZ70GkKAyX8xfS4F/HavWQ76xbwFZoeQ+L2PUzWw2biCWkW5ToqoUoMPA8HdlN4lJS5fqzrRubK2H4uQ+ErMnzgT5nkv1PqY0akVgf/s6xqkLohy/loz7yzYvWMjXeLRbla/gea4Cdl6TET6TJoBhJFApKECP8Cilw9KbIUgk+OiCv2I8pN7TzU51ABXflmiA5phfeB9B7aWGw4jGNutC2Q+BDBgzvZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by PH0PR08MB6988.namprd08.prod.outlook.com (2603:10b6:510:a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 21:02:39 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%4]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 21:02:38 +0000
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
Subject: [PATCH net v2] net: mii: Accept link settings read back while the link is down
Date: Sat,  7 Nov 2026 16:02:36 -0500
Message-ID: <20261107210236.721901-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0052.namprd14.prod.outlook.com
 (2603:10b6:610:56::32) To BN0PR08MB6951.namprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|PH0PR08MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 5487de31-0431-478d-8e2c-08df3d127496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|261022075727099003|261021123027099003|56012099006|261021121427099003|261022105027099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UaQUBmKAqYbdfXpf5+4wZZ5bt/TaCpffWirkjYERybCqYpO1tyVwFVg1HRAESPNl7X1CEnYMSiOYGipoJdAJuo5ZaVKnUM8VsLhKwkty3btfhEFBSQzaLKI1W5KXkxgEGtvFqb1v0fAYgZB4qcNzA4XP2CWV8xrxCg6DRafIldSXOtBTunSXEk4i0pRyfEyNNfil2qKODMAB0uFQwNrHsjbtJCYlB5xHJjw0OqTw8tvzuvcabmUWuMFel0X4oWmdWNjqw1UbZZR90cN0yFuKkGTaKfj0vMZBG0bdM/E/5k1W72KtanpmB3J4/1EdfHKB3/rhcEgSTt68JYo1KZHZEjyk7sKloP6fp9BcZ0TEKGfckIt3LGjb2htDEBel9xOeDQNVOj7WyqpyKJ7Q8OtnjmU6g+qxY4yWXslZt2LeqJHPBj2JUKAs2fsrKUQQgYBV0OZ0OX5UoR7zliQ+hCpaMq+6nzvkapZ8VwYzR1Jzv2qpSLQ7uyZ0u+agdf8N+Cqf0PSTGfyy2NgmXVEiglTzzSI729diAuhhKaltbIDO1bQhTuQ9rBA+v90lKmGcBDKDtNZ750iAFBxoC5qAe3DYPqgtsbnQWtJ6OE+WbZlSPEOqmYgfR27KAKwCm334ywku
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(261022075727099003)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kX0anRbBCfQ75MvnzUTd9hsSZm4pbBhLk6ojRpwz1ccU/CjNXNy0tjQWkFSj?=
 =?us-ascii?Q?Mxk5MujEb8xvA0mxxufsOWYDSOa5S5an4CvUYfyV81qV0paBcVHAlUcV2Bx0?=
 =?us-ascii?Q?8hGnNVjA1fODvKq6NFtdhGcJ8FOuvwkH+Z0WKorB/55U/BuyCH6TTxnG+3Yb?=
 =?us-ascii?Q?MPaiOKOAvgMvplLFam/3KG6vF43h5Yf/1CTj/k+qBUcNRKwgRz0hfy2ZBbGy?=
 =?us-ascii?Q?4+Q7XAnptZCOVyMyLDM1/cpwdlpgMNgFuv59YQuM+6G6aVYrdlHwZljZh+6/?=
 =?us-ascii?Q?7grGkn9Zd2bsW0AbdH56KrwYQj7fq+JSVP8hxG7Frvhtna9PiWgsDGD11d3k?=
 =?us-ascii?Q?XhnvcvkWyymuiqQkgW8ke5CuuDSM0Z+bQyN/mboh7mDkfJ1TfnyCfKUQY47V?=
 =?us-ascii?Q?iWAHwhmsLR6kX0ir/JepVSuveeZacT9ejoNlCV6i+wX7ETy5uWZY442rm/VH?=
 =?us-ascii?Q?mJJ6QFSy7IvcWUnbcKO79ZEA0k0GKmmH+YIMt/t5s1l4p2Euywa5yspumPIq?=
 =?us-ascii?Q?uJzyk7yEyWmU8LxgLVWWlzlSBpgn7L67Sz+5X+wul80/fPlYZSjv/q0uz8Qh?=
 =?us-ascii?Q?PW+B0+XAeuAK1ajaHh0N08eQScv4jfh0lyECX3qACYBVwHlWMPMM9z+TNMTu?=
 =?us-ascii?Q?huZKNNZWT1ZAkZCr/tK7HlEL6LRaUFjQJb3gAWGa7eyfShV1Hi6u8hJ6VY/8?=
 =?us-ascii?Q?Q4hDpkZgddQo+xPjVThJ67mp4sRDFXk66Gs/2LrSowrVFaSWOah/k/PYlUmx?=
 =?us-ascii?Q?BpgYDOUdOHQFDUtdF34fo+peJghyPdd+QvLLsWPMUM+0MKS3GpB0SzW9yZ9L?=
 =?us-ascii?Q?VqhTwj0yb8Y/+SrSayeNkORCsKAlxIbIyf7q46phekdwR7EsSD0LarSDYSdN?=
 =?us-ascii?Q?buphdkOf55SSvJ/zdbe7ZMJlnO7WAiGNvYbdc9D8ssx65FU3mwPoX0za7TZH?=
 =?us-ascii?Q?igJq2g1Fv001dgSAFG7rNAmwRFWwClGhIXsKNmBzBN33qCUbu8Az7OsbLfiq?=
 =?us-ascii?Q?aPydAUfxC/1qNlq7wAML7p8rZvud+wjipkcfE2c20r+N8lqrFQoEwdB8D/wP?=
 =?us-ascii?Q?S0tOKSND/tpL8wmHQ0TC05ATXDNJHiOXRn2a6JYsTEzoOC381OT2o1ZnOz1W?=
 =?us-ascii?Q?1Dzj1E8p0tLdsvWs7IPcRnDXBxteCF3LYz7pTqWfLzQlwmkGtl0c7j1VOA0M?=
 =?us-ascii?Q?G1wOHQneddytF92c7r5vs1GCq0Fr3CACs96bd/PEOQ2rR6Fif47m61mR/Dj6?=
 =?us-ascii?Q?QuaBFZ4b4bywXiYazhlJJFk80rpxAg0EytBZbGi8vahu6GBcCsd3O6hpWs/G?=
 =?us-ascii?Q?eVoyY5iC/dT+s4xMM7qsyfBUquaNcBmOZlBEdaK1+jj5kfw0U5iOQQYNrur0?=
 =?us-ascii?Q?6Wax2Udj/78jRnU3ydWbBACI6UAMf+Qyn114EBx0Ip7mzYpQoST1jqfnKax9?=
 =?us-ascii?Q?haHctz5nOqt2FvcVX+MymKWRUeMg4XizYka6z0lqwOxjRs/A1YlWVvNbJD2+?=
 =?us-ascii?Q?SVmoE4DLXovKyzxQwGZgMM5XN7AVm+jNjBVkQvE7gn4jgJDgmYeuarF3+RxF?=
 =?us-ascii?Q?Sr/vY+TiaoCq4ibNrEivmU3E7hBmT7NCt9/QGUO47Sw3PS7nud9q78ux/pn/?=
 =?us-ascii?Q?2Wena6kflJHWwFYGnLSdDoQkctDpGwIEqe3KQUFJWJtFKNfM1UsHZ1yP/M89?=
 =?us-ascii?Q?lzDkbGh+dxQK/VUcTXr1lDBHtOhc+yTNp6ws5BOSANoS37E0OpLOni+OY5Kl?=
 =?us-ascii?Q?FAwCvPR6ZQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5487de31-0431-478d-8e2c-08df3d127496
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 21:02:38.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWbgA9nI3uWbEzpyw2kJmI5mqPk/E5Ld2Ik5+wwca8Rsh2pUx15axO3ATyO0GywVnWfqDQM96FLe6HdSwG5wXR50CG7+8+1wI5ytU99G8Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB6988

Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the
network cable is not connected"), mii_ethtool_get_link_ksettings()
reports SPEED_UNKNOWN whenever the link is down. ethtool changes link
settings by reading the current ones, updating only the requested
fields, and writing the result back. mii_ethtool_set_link_ksettings()
rejects the unknown speed with -EINVAL, in both autoneg and forced mode.
For example, on an ax88179_178a USB adapter while the link is down:

  # ethtool -s eth0 autoneg on advertise 0x2f
  Cannot set new settings: Invalid argument
    not setting autoneg

  # ethtool -s eth0 speed 1000 duplex full autoneg off
  # ethtool -s eth0 duplex half
  Cannot set new settings: Invalid argument
    not setting duplex

pch_gbe_set_link_ksettings() already works around the same failure by
replacing an unknown speed with SPEED_1000 before it calls
mii_ethtool_set_link_ksettings().

In forced mode, BMCR holds the configured speed whether or not the link
is up, so report SPEED_UNKNOWN only when autoneg is enabled, as
genphy_read_status() does. In autoneg mode the speed is not used, so
accept SPEED_UNKNOWN there. All other speed and duplex checks are
unchanged.

Fixes: f6f2e946aa4d ("net: mii: Fix the Speed display when the network cable is not connected")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
Changes in v2:
- Report SPEED_UNKNOWN only with autoneg enabled, so writing back the
  settings also works in forced mode.
- With autoneg enabled, accept only SPEED_UNKNOWN and keep the other
  speed and duplex checks. v1 accepted any speed and duplex there.
- New subject, since speed is still checked with autoneg enabled.
- Tested on an ax88179_178a adapter running v6.18.54, where
  drivers/net/mii.c is identical to net. Both ethtool examples above now
  succeed. A direct ETHTOOL_SLINKSETTINGS with autoneg enabled accepts
  SPEED_UNKNOWN and still rejects an invalid speed.

v1: https://lore.kernel.org/netdev/20261106195544.4146568-1-anthony.pighin@nokia.com/

 drivers/net/mii.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 37bc3131d31a..225488f2438b 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -199,6 +199,9 @@ void mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 			cmd->base.speed = SPEED_10;
 			cmd->base.duplex = !!(nego & ADVERTISED_10baseT_Full);
 		}
+
+		if (!(bmsr & BMSR_LSTATUS))
+			cmd->base.speed = SPEED_UNKNOWN;
 	} else {
 		cmd->base.autoneg = AUTONEG_DISABLE;
 
@@ -213,9 +216,6 @@ void mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 		lp_advertising = 0;
 	}
 
-	if (!(bmsr & BMSR_LSTATUS))
-		cmd->base.speed = SPEED_UNKNOWN;
-
 	mii->full_duplex = cmd->base.duplex;
 
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
@@ -333,9 +333,11 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
 	struct net_device *dev = mii->dev;
 	u32 speed = cmd->base.speed;
 
+	/* Autoneg ignores speed, which is SPEED_UNKNOWN while the link is down */
 	if (speed != SPEED_10 &&
 	    speed != SPEED_100 &&
-	    speed != SPEED_1000)
+	    speed != SPEED_1000 &&
+	    !(cmd->base.autoneg == AUTONEG_ENABLE && speed == SPEED_UNKNOWN))
 		return -EINVAL;
 	if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL)
 		return -EINVAL;

base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.43.0

