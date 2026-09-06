Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013081.outbound.protection.outlook.com [52.103.51.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EA3CFF4C;
	Sun,  6 Sep 2026 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737883; cv=fail; b=q7NPOby9JZMpL7X6dREVy9MmWu3qvnnkbd5O6l++aEhMG2X+8j1QiFVf/jeV7MMfLoEejkJHFJfXNf0BT27Hk6+DNZNSjnuotQBAUPYF/ZqNjouyYMryUtIO/3bFZwdYQqaxN6I2Idq7tRhGgGcgJQfzeBiiPEIzJCLyCsJRZGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737883; c=relaxed/simple;
	bh=R0dndap8i4snmZ0KjezGEnqHAtRpvxUbCA7TYkzaqjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJ8Rz1VPa0VqOo9TF1X4sWaeuD4e0hQtfUr69isDXVAAOqLbnKaI9PBLwomHNOwzsjlcDjRU0MpG0bNRdj7rJhxorKzlTCXOi1dsNmDHFkHN1pB9BYFquGwsjW+q21EXXZowC6vnWm3V7wDcoGCtF+xMomWpHVKS5C+H/AbrQDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ju/UvPgN; arc=fail smtp.client-ip=52.103.51.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ju/UvPgN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6G21zR4ub610/m21wFoh8/y/JRbpkCqFukqbMq7H37wsUa2b8Z+C0xCtD0isGhCjgTEJWqWCW/gaNkgCs4AnFa3HYvhqeYxGxanMgpV24LWjGyd6ZDsRUBWrpDALOgpquhH6MESD0m5JAh55jbUyno1X/AiHaAJH6QNeQbuYdp6Fqgg/KexeRXH9UUhu2c0tBJKzhGDErGuxg6B0ipkS7f4AiBtcGFBzZsXH9JvOL/+6CgOjocthKI56OQAGwi+tW0P3+1pIGhwFYOeBkkr76AYKBgRdl4srMAuo0TW9BYposTh1R7uUhJG8BMInygo+SVyW2sBa9I2hTzS1Ci1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLxstcRiIN+2mRiXwunWWdUCqlucPtZ4zAQLv/BFGYM=;
 b=gTzv9e1ykBVeiHxlQQxRbbdUYBDIKGVulYf3wSBGyY1P4GBy6G/ZQTfZEC/6mlcA+UbGHTV8yEQrVYGTUWe5nGbKfaiJQy4wJkPT9XwtQ649yKZaXHmjZ4UwxJ7SRz6Bp7yHl4C+0u+HpbwPXDB+2/onBcxXpfbzwnSAN5P4cjPWgL7M0ETC5JrANMsluB5HrfOMQbxQuWjZ17E3LB3jyXDODQPXl7vMuNyrxGJnbtVPSFux2GnwwoEd1iUyCPwj6Oss/oh5TDDcqL1Esmb6D803PJ05mbATfTTUj5w6s6vaBRkzuFVyV89tfVVq+MzWk/YYql/aSCCAJbflM+CoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLxstcRiIN+2mRiXwunWWdUCqlucPtZ4zAQLv/BFGYM=;
 b=ju/UvPgN8v9pOr/2Hkqhy2+pn9PvnZUjsEfLnT4lXO73tFR1RCgfN26F3vyfnLznzVjTxqHsKjzFtcrzxL82bqHpSxLU9u8k1e2WuCKAUGeqvGA0YWxE/toCeS+g+ss7t5oeOqJQCcfC4EK4N/P7bRTHsBfPL3l00+4xXZcc8IQUK2x8Au+RCi3+TGMQwMMMh1pcMLit0ljVkZpB7rF84wfeq5tqKl2C2wSR7vJdlwtDZ7CZf8ZhFsVSHrGs+dfP/yqJ+HWBMwGt6gU42k0krvnqItktJYvZRiJWF1B/rN/WM+3CrcgQC6dA94hDuC/kMZFckNu9DMzRGucw3seDXg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:37:56 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:37:56 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] net: ncsi: validate MAC and VLAN counts in Get Parameters response
Date: Mon,  7 Sep 2026 00:37:52 +0100
Message-ID:
 <AS8P251MB0001E99A1865DFEC3C3A16E7C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260906233752.87773-1-elb12345@hotmail.co.uk>
References: <20260906233752.87773-1-elb12345@hotmail.co.uk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233752.87773-2-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a26c869-9fdd-47e5-2401-08df0c6fe0ef
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5072599009|4140399003|15080799012|25010399006|23021999003|25031999004|37011999003|19110799012|8060799015|41001999006|12121999013|13031999006|440099028|3412199025|26104999009|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JH/LVHWDYSPbIEhFrD+rVT5gstWgy23bTwqZJmhmqY3Q/O0YQ/gawElLzMBn?=
 =?us-ascii?Q?uL0GeZVLQ1+Oj48RSwIMdfGBnxpW73ztHBhKy7x/gq3Lq9kqhnh0iPmcHoJ+?=
 =?us-ascii?Q?PjbOpssH6RcDc6qjvkks7bXJ41Gyr4M4jdSkyRG5iMgJSkN+VPbirxhEv1kJ?=
 =?us-ascii?Q?Bhuh9iwWfw1RYXCYP/p0eO1Yv92DOfQpcvwR2l500sfjjnGJEEBrBeGJxdZa?=
 =?us-ascii?Q?2/BrTY2fB6Ax8NmJ3b68MJtIMljlZdh5Qqx4PzplnNVLPzBI7/+jDpCRdOQL?=
 =?us-ascii?Q?mmcO1BHifNVu8OxGgVjJ1v7SCCPpBAjk8PgtReviPU5RSfakQ7Dlex8Umvkz?=
 =?us-ascii?Q?mqib+YiJ4sPzdT0btyge8Jfw0k2XpEw33pT7fO83sqFEVhU8Yj3OoXkHPLxP?=
 =?us-ascii?Q?Mql53AWS+wdN3Ucfa5v/UVS2k1Kiasnu9S2GsMK/LMSH+o44o8QmYAEme+ba?=
 =?us-ascii?Q?fliomDRN6BDj/cEkAknQNwvNEA2JLOdNLZ4/sz/v1XAQVw5yxnpeA9RChr6L?=
 =?us-ascii?Q?R7SzjNqREfRLvACVB2gNxvY1pKdlCVAyNlDKEqTcy4NWBIcbfn+s+OwTY8Py?=
 =?us-ascii?Q?YBIVo7UIXxLmRBP7cc2cJ2L8MgGRUVV2Rsd/UVBUGpTM6v/eSwzOgX3VBsa5?=
 =?us-ascii?Q?q8veIq81s5duMA/Mj4hjF+/4lq1GOiTcdoIYdbYal7SP/C++L2Yp0UaY7JKN?=
 =?us-ascii?Q?FtYtXIixHF+xPWqLMHoqz6hyAXeKeWsyE0u6KBjlbHmq9qnk4/n57KmdEBGj?=
 =?us-ascii?Q?2pRV3o5qd0LDHbHvkTml1IEg6bEZlC2HEc0hEP79xCaS1LzJA8sVdnyszgyM?=
 =?us-ascii?Q?VfgkZV7m7YE4CqD+RM8nMj3frcwflQ99T2cpI5NN4t9DZJdTb855oBXF3LB5?=
 =?us-ascii?Q?qVmYSa0r9oXMTDwCSJVZfWoEVzsMMMIeyGETm113KaDP0+2aZxT4pPN4YFPU?=
 =?us-ascii?Q?fag/uintYm8eyQiFehb2W5I8Q/aAEpJ3Hg5PRIjKZWz8fEYUFs7YjBMyTHBD?=
 =?us-ascii?Q?N7DkupP2D+R5TK1XNv8C/sw4QtFI23OBQYbkn1aPn6xzouaTQuaetTujB4iR?=
 =?us-ascii?Q?ajIgeGCLTlLvQSpA5cIMmJ9u2WJ38N2K9Puo8rWTizvLheovud5IIllymKCk?=
 =?us-ascii?Q?PevH7RDukjU8?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHE6JmZ033aSGomzBgaC9J+MGgW6Jl7TyWZ8zOC1yynokejGUe97mhHc+oN5?=
 =?us-ascii?Q?rel3Quy6xduNufV6GQxxp8u4sGUMjQphW1iDwR08KoeiCT11ynEcxxK58vQl?=
 =?us-ascii?Q?v/gZkrgVTZjgxT0myL0LYqPoYm05awK9J4QW1v/MS8jqohPI0RxmsYWC13AL?=
 =?us-ascii?Q?b7nbG9el3xLWneUHkPWEjXOtBqB7lItKPPuYbIS+hPXFAR+J/MYSsyJg5Smj?=
 =?us-ascii?Q?Dzhywnf/4NJjSNnKgYlpu/k51Y+52YPTbzFPCEh2eNmsg6GA0FSE0R6o8Y5L?=
 =?us-ascii?Q?tHYRyLYwHcEEY5i05Ji87FZKxLe1RB/FZvxNqeCxKGdCDMIpgpTZPACHu8ZQ?=
 =?us-ascii?Q?rBAhtN63Ymohc1inZYucYYfjbFbZh6i3WFRe5qd2qWNO/qVAFNZXjmqSI84m?=
 =?us-ascii?Q?5Nj0mW6nfjz1WnaEiz5WNSN6mNgx5/ywC2BYiFLTZTnU81oHcm/Yt53fq7OL?=
 =?us-ascii?Q?8HugVb3j6mhx0C+nN12yY7PpMlw0ef1ak9zCT8oFsZKTG8c31ncEyngTt71H?=
 =?us-ascii?Q?eyZ9EpQrk7qbYbc0ugzoMliNPgwnuS6QGsje1ieszBNMuBso0uW/WG3Du21Y?=
 =?us-ascii?Q?aSzAPq33oZaLZ4/3tn6n9rayTrPGBG3LqQB8PA6Eo4jsJRJsSN+imqujoiR+?=
 =?us-ascii?Q?w1d9cv594qbgk+3spu7dDQdgIJBYkmU+alu76BeIHVSEJ2wIOfpVnPtLFKSX?=
 =?us-ascii?Q?5IGiN4Wf6xfoLfbTSxqnN4XSK6XjIta2QdFtfbtuLgfu+fY0lvA55UM3ztud?=
 =?us-ascii?Q?tKUOPTCZ89s/f4SMI9qrKRhjqy6V3Of0A3qWO+o0qaJ3oAudug0haLqUVE7C?=
 =?us-ascii?Q?N9Fv03/EicQ93wc7QabUiRTeuFl9VD/4AO1cSsNgGKPtoYMxjYvaOAyN2QB4?=
 =?us-ascii?Q?uMLy52LrjfbhpJCWMc+TqGfwcNk4yfNLtFC2GviEiKpZ79FZ3rDa/ybwHpPm?=
 =?us-ascii?Q?C/e0yckUM06yXnTwYnuk0i5TIIOOadlsB9wJysZ2jv5GF/GjvBtfy1LsA6b8?=
 =?us-ascii?Q?yRq24lXIZyQwee0NkZDmVsmuOVSUUVvOmqouqrtHv/uAoyS5O8Rx+nflyPPE?=
 =?us-ascii?Q?p0UaxuAnYD7Z7dXYDV9Defy4York38/+oIz4dEnJcD/7v2BYC/1nNaezdFq6?=
 =?us-ascii?Q?X8YdAye8LvUagng8UFpqZzgGP9N6hAIA9UlyD5+a2RzDCdFemalcqUlgNtln?=
 =?us-ascii?Q?QK8DrKseB/5VI+YiknEq6+X6mboFGuHCLPJIaqW2nLTEpaP0v6uCcLZdmRhy?=
 =?us-ascii?Q?IgHqomMpeYEpHSpMhTv8ToHwL2ETnltFYlQq5cKCHA5pPBWlJ5S0pGsccE/l?=
 =?us-ascii?Q?6ag6LgdQqUV7quS9gD834LppJuolPLorlxFTClbUdA0HZle/eve5SxCKSJWZ?=
 =?us-ascii?Q?3/zoqIXs3QKmMr/VYZYTuC5Vvce+FPT64l8Gqpv6jzmrReZjCfFFL9Ab4+z+?=
 =?us-ascii?Q?dXQyFsLsOA0qnvvzF/YFBic1wqag9+U0?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a26c869-9fdd-47e5-2401-08df0c6fe0ef
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:37:56.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

The Get Parameters (GP) response handler iterates over MAC address
and VLAN filter tables using counts (mac_cnt, vlan_cnt) taken directly
from the response packet.  These counts are not validated against either
the actual packet length or the filter arrays allocated by the earlier
Get Capabilities response handler.

A malformed GP response can cause:
 - out-of-bounds read past the packet data when iterating pdata
 - out-of-bounds write to mac_filter.addrs[] when mac_cnt exceeds
   the allocated filter size (n_uc + n_mc + n_mixed)
 - out-of-bounds write to vlan_filter.vids[] when vlan_cnt exceeds
   n_vids
 - bitmap corruption via set_bit()/clear_bit() beyond u64 width

Add three validation checks before the filter table loops:
 1. Packet is large enough for the claimed MAC and VLAN entries
 2. mac_cnt does not exceed the allocated MAC filter capacity
 3. vlan_cnt does not exceed the allocated VLAN filter capacity

Also check for NULL filter arrays in case Get Capabilities was not
processed first.

Fixes: 0b49507fc090 ("net/ncsi: Resource management")
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 net/ncsi/ncsi-rsp.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 1401528dbd6c..88f3b8db0289 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -884,10 +884,38 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	nc->modes[NCSI_MODE_AEN].enable = 1;
 	nc->modes[NCSI_MODE_AEN].data[0] = ntohl(rsp->aen_mode);
 
+	/* Validate the response carries enough data for the MAC and VLAN
+	 * tables it claims to contain.  The variable-length area begins
+	 * at offset 48 (right after the fixed Get Parameters fields).
+	 */
+	if (nr->rsp->len < 48 + (unsigned int)rsp->mac_cnt * ETH_ALEN +
+			    (unsigned int)rsp->vlan_cnt * sizeof(__be16)) {
+		netdev_warn(ndp->ndev.dev,
+			    "NCSI: GP response too short for %u MACs + %u VLANs\n",
+			    rsp->mac_cnt, rsp->vlan_cnt);
+		return -EINVAL;
+	}
+
+	ncmf = &nc->mac_filter;
+	ncvf = &nc->vlan_filter;
+
+	if (!ncmf->addrs ||
+	    rsp->mac_cnt > ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed) {
+		netdev_warn(ndp->ndev.dev,
+			    "NCSI: GP MAC count %u exceeds filter capacity\n",
+			    rsp->mac_cnt);
+		return -EINVAL;
+	}
+	if (!ncvf->vids || rsp->vlan_cnt > ncvf->n_vids) {
+		netdev_warn(ndp->ndev.dev,
+			    "NCSI: GP VLAN count %u exceeds filter capacity\n",
+			    rsp->vlan_cnt);
+		return -EINVAL;
+	}
+
 	/* MAC addresses filter table */
 	pdata = (unsigned char *)rsp + 48;
 	enable = rsp->mac_enable;
-	ncmf = &nc->mac_filter;
 	spin_lock_irqsave(&nc->lock, flags);
 	bitmap = &ncmf->bitmap;
 	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
@@ -902,7 +930,6 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 
 	/* VLAN filter table */
 	enable = ntohs(rsp->vlan_enable);
-	ncvf = &nc->vlan_filter;
 	bitmap = &ncvf->bitmap;
 	spin_lock_irqsave(&nc->lock, flags);
 	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
-- 
2.43.0

