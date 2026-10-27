Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793079454;
	b=rOWkxcixGK27x41jE+MWwhdx9Q8/XZXrLSlRQUz07trQlCMVayMpVSE0SJ/Hz8TcpQQQ
	 0tUmKEMfKKW2UiPiAbAaeT0uEBE0VqR44MumxBa9WINih6EkRobsc5fLIe8RpFRjJL1j8
	 LL6XJ6eDItLZsU+egnrOD0TLRU7YmknTkHStLBkFk77hTEPurG4g1/RTMdecad9UpaIxe
	 MCNQz/X1oZ8oiBxHgyYOO59vNhyrmKIuMQ++MMdg/K9arN7HUEQkr2o2xRsxlEh97zzlv
	 5V3erKglmdkpXGvHr2v6Of/q4/soltX1QTCH3KxmO4rnu9EcgOinuujsxcp4G7cfUrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079454;
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
	bh=km/ZbnwCeblWO/9LVQmtJ2M3VXn1MeFnmF/YAnlG/C0=;
	b=Rm+srHrR1PMewPT/nH5pw3QXpAO4PM4exAHtRKgIZw6DzpGl5vlhyyYIqIDuGVGyEJGT
	 ZPJfsjBZYenVmICegZIjxNQ/kbCxBNXkIf4np0uSlr/zIOsWZn0nX2erowp46TIuZ3zFl
	 Ca0xONAwwfIyBWH9EO28bfoX0fjnSUs1dR9z+TcYBqBp/K1OG9VME68E7OzURnebIAk4D
	 C+BBlZOiMnbLLJPDQCUp3FQGYWKLZYyiyTfXWx+Ua3XwtVu2ouXrL3wwe9Dmz96t7KRhX
	 GVLTFjvSuOoH2gBJusSgWLIj/e7HutXLrLEaxKv6RY78zTYon9ZopomC85gMT2IvBqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=JA3leZY4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.69
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F3606A31A;
	Tue, 27 Oct 2026 05:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D3F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=JA3leZY4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2qzkRpW+XKigiXg7p7DdVaHBLvUU7yciEysiFxhr3SYAgwe0VcLdS1cYCE97QI95HnPnvnXFHDI/ma09Xp23t3g5McGkdp31KQ7tSbMFsZfTLcCymQaeytM09PMeK3E4sdKPdSQ0fkCMA7m43nv7kwDnVGYR0oIokVKi9/ZX4ihIezLpwYGNsequ9qx9EYFi5Wh0Adr70bDbvHKQ3CUNaVGNBOhq8jlNMapbvPXE+xhhABFuwRTnxXIx1n694OHiCI0KGFogjhzszCngtWbbJOTa2D9v1yisWl6Jb15TYgPfNwsssj9/d04QmutCIwlmr+0A55T4rEMKP7xXwXhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km/ZbnwCeblWO/9LVQmtJ2M3VXn1MeFnmF/YAnlG/C0=;
 b=Dkuj2uHrMgW5uFGcOZj1tq8nEcFe2VdQw8PQOg9XgYo1x0zvpKszICRnSCYXtPuUWw2/D2+n4UWKjZXqe6Kxk/qhAeeuSmy9uS5NWSQP1raD+1k/I0EZArURjm066NUMh3zFGvaR6D6GXasqbY2W74CHG/mKyJY03aYup2skDhw7OKq5if318OiQTizTv3QN4yhdRv2gHgJcXC4nzYl1DOOCdSbDhEZXB4Z9Cf3CGTR/Q/zJZC8i6d1CSSwA00wbBrWyZ7g0YgPLfMpgQMYEL9NtyhrVsmKi/st6WAksXpzor49hfMgI/Sa3/dCgNJtp/mQGrA6+p/PyOXJHCKu3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km/ZbnwCeblWO/9LVQmtJ2M3VXn1MeFnmF/YAnlG/C0=;
 b=JA3leZY4grbL8CseTJQoQ46uF+TB0EjlQZkQfxsP3D+oy2Jzv11368DPPvwnfZubBlDm6oz+CFDjOO0qSP5VcLsVOVH5+rnXvdzjX47nhX6NZr1Idc+8W3DCLAL96Qy5Lb3oO+6JI8Ftdgp+TGTJopVAxsx0ML/lHKqkCSx6JWijNScyu4zbH1CTyBgyUrzO1Z+QGfHb2tyKBrMQie+STo88Cjxnf3jNBsZRfSEfZXHKILQ5Oqei5XnfUfbVEmoK5V+YrGd4lg+kgB2a9OaDDvlfriiGDHIpn2wwP9wEWtcl8gP0zInGCC9g+f+LxRRnmR+fZTrj+tXtsE1jkTHSfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 CH8PR02MB10899.namprd02.prod.outlook.com (2603:10b6:610:2b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:37:31 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 05:37:30 +0000
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
Subject: [PATCH net v2] mctp i2c: fix double free of midev on netdev register failure
Date: Tue, 27 Oct 2026 13:37:15 +0800
Message-ID: <20261027053715.1623087-1-kenny_hsieh@jabil.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DM8PR02MB8087.namprd02.prod.outlook.com
 (2603:10b6:8:1b::11)
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
X-MS-TrafficTypeDiagnostic: DM8PR02MB8087:EE_|CH8PR02MB10899:EE_
X-MS-Office365-Filtering-Correlation-Id: 74105503-ce29-4a17-1130-08df33ec64b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|7416014|366016|1800799024|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|18002099003|5023799004|11063799006|38350700014|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	TNpFKPxL48YlOYRWPmYbla53+KrgslEjIi5GlU0S6W2BHfzhe20I5WufF8fjuG5lu3gFse+JXWEtnnKVAaJfZPUgrOvMzdWMfQSR/qptXtRDVmCOiREOIS2PqfRLDb0B1MvUoHEh4fJuYlIQYkQ8HSWQSObsaWWRj461oWOj2RznOPIIBiXU3WU+qiCXXZruizXCsjJMHZ/Zczkv89izgmS+cBXdPch1c3mz4iMgo7WdeXoO+xz+X3Z6iZOyrNJnFE0d+0Z3gMIJkX2Ki/VIjiFL73GsxuvEYiCs+xPcAtV635QdVlhNTzPWeSspG6vUKaHhw+rl8IbJtpcHp9rrB2BuU2rTZM8PgebPOJMsZjjXodo1emUaktIM5QLbPLZvZMuCSpnuwiO1xCTaiJt+SMXZakZc+THnSkib8pntpmX54JiN42Jc54LQsxXd/AyW85hww67Au5SnDgqpKcnhn8Zhf7NEEbJtryFnVFQNRqD7kENgH94dj9MQLYBMc6fXM8yDKrLmKfmKnDFL6N1jVIBcEQLqn4DS5xWoFzLHfgj241WmQ+5LLf9TO62/2rHkxIzo8kCfuKQAku+IFhmBRBOPwOXU3bV/WdEX3uhO8TxWs97Zf6k41JmKNyCdcYaAxJk/4gEsUQ9kViixiLI0pDby5URhcDiQceDtjwxD4yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(366016)(1800799024)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(18002099003)(5023799004)(11063799006)(38350700014)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ehcKSMMueUIiNcp235AwzyaDJi1yJ5yrffTWnHrsfKapU7D2APkFR3saSYV8?=
 =?us-ascii?Q?uUSsOWLwjuF3jJYyOAAQ0ew149Fug0l0AtG5P3lSD5vjZpiDwYg5H+UswtOU?=
 =?us-ascii?Q?QM8aUXqlRUrjKIJvfsyaoRaPT+fIxqPFfEbC6IXGlaA/1tOZD/OGOZqOoP8V?=
 =?us-ascii?Q?qzyBssf9NZnyCwO3pQpO4xZto/ZlhOCRFlsDDjT4TXUPsuL4hDHKZ0pbZ+qN?=
 =?us-ascii?Q?vy+PLpJCXe84ROjpIQDf1zoKm+eL/LBFoyrJuynyGl9yVMys6I8YY+yr563D?=
 =?us-ascii?Q?wh67kUIeM6IyuflcJ5dVQfBIq1fFOUsXfU1M7Yugu+h9iDUWDMKBC5waoFWR?=
 =?us-ascii?Q?TQWJasN0sbGJMV4TqV3X0+UBXSKbptBlIgbTYF9WPB2qQUCejbubChvhkrT0?=
 =?us-ascii?Q?oiPsH27GaEoJiCih338oAah/njuF8S34j0d0OGB8W6PgsMOLIagnUD3xzFdQ?=
 =?us-ascii?Q?quhq3xMlI0TYLeHmUwwXcd8d13veKtHW6vHiJle5K+ni+lBwce4C7vpjegn0?=
 =?us-ascii?Q?5wvqNazjwYlhMETUS73oAzjc+jysnK8pskZ2Fruz2RwgqExcLLzygwpPs0LF?=
 =?us-ascii?Q?PaM5HzHis1pdIsezOfrJAJU+njnYcTRtkL0pyOSoycx8eNfSF5CbWtKqUU+k?=
 =?us-ascii?Q?/HAsdONqjJgn9GGIEUexeSETKrrByk5Tgn6v6dx+KG6TzGSnFdOlYSKiYWxB?=
 =?us-ascii?Q?6QEAwRx4NkBs+QJhNUD4+JXNd9nMAOZaFtzIfGhKkScIRa2dZIiN6hast4LK?=
 =?us-ascii?Q?JMyg1qgvVjrilA+6i0elQOin1ua7m22SdLjEiYc1XndBxYC9aryu95RR86XH?=
 =?us-ascii?Q?SAaIOlpin3XZfRaUdxl1aK7z7uaxmcgiEJJ9ybVde0STtWFd8hIKn+dDqm+s?=
 =?us-ascii?Q?Y/XmfZ4U7a8HZc9FeBYQC6E2Di2LzFk6BZKoeJn44LIUpZnFreqLQzmVk9Z/?=
 =?us-ascii?Q?XuA1W7sNXiImA4v41mjuw7cILHk7vqPO537/UL6cs89KBotPe+gcd/lWia+9?=
 =?us-ascii?Q?uacC4Yjep2ji93OS3upOaRailaxctFg5dgh6aAAlEIOeO08bHCTLCxwk1XBT?=
 =?us-ascii?Q?FN2xbZO2LT8l99Y06H9B23pFQMlbJJ5s4/RsjFXeoTy6zvdvdVy92wPHim/a?=
 =?us-ascii?Q?QVy6CJJ/uF06wtHGAkMeYBxItgWLmO4KrHA0Mda3C/trQd4elw6a/JRmjxOC?=
 =?us-ascii?Q?5BEaYmXOZO7spTvoXzta7ev0/MBQYLn6nTsfLibafK9Z7hG46tRszOG1r11U?=
 =?us-ascii?Q?p2H4lxUHutK2QAAUYEW7LBE3Bcks2xBzaixjRKy3gatThvfahY5oeuSt0N/u?=
 =?us-ascii?Q?COWuKo2ngqSjl1+DAUGA2A0wYCa9IJ5+ARuCuJKqakVqwObd542fkdP0R4dw?=
 =?us-ascii?Q?u7PMwllH84bPMPVQmFsclr7IkyMVg1oGx+tloLwML3VPWpCD5foXyK+damSL?=
 =?us-ascii?Q?OponAkoAYvPL6TIJb7hNdREBdpDDOJoeimfChLzRgOGIhgMO6fQwlDmksQVB?=
 =?us-ascii?Q?4sba8gO3MWcryUm33XZHvhErKGy029XXB7EACYRo2r0TSG0rr7XEnjukor0C?=
 =?us-ascii?Q?O+k8ib1+7hOcBG/a++n96F8BPXj4V8Fgl8tBSj6M2m3t/j8l7/tIA39u2Cdm?=
 =?us-ascii?Q?UoWC7Dj8RUwu7wNA/0+tztQ1uIXLMQFih+ngTXtyr16RygtNfp3SmnYjQ17P?=
 =?us-ascii?Q?2kJLlZZ7DqRfopHaCXu9GC79INz2oGt3amILEdLMrzJ1Hcj31n0J9u/dlr+h?=
 =?us-ascii?Q?rrrTLTvn6A=3D=3D?=
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74105503-ce29-4a17-1130-08df33ec64b8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 05:37:30.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig+jv5lMHwK878iqcQv0r4I+OHeBVeWVeGkxhe8l4sXUtfFSdsolS32ql9fkWCAagNkOevkj8+F8D5W0mTjzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10899

mctp_i2c_add_netdev() frees midev if mctp_register_netdev() fails, but
register_netdevice() may already have freed it through ndo_uninit,
mctp_i2c_ndo_uninit(). midev is then freed twice: list_del() runs on a
poisoned entry, and the adapter and client lose a second reference.

Remove ndo_uninit and free midev only where it was set up: in the
add_netdev() error path, and in mctp_i2c_unregister() before
free_netdev().

ndo_uninit was there to drop mcli->sel's reference, which would block
unregister_netdevice() while sel points at the netdev being removed.
mctp_i2c_unregister() now does that before unregistering, keeping the
existing reselection.

Freeing after unregister exposes two more things the old order hid.
Flows released while the netdev unregisters queue the unlock marker,
which is embedded in midev and must not reach kfree_skb() through the
purge. And the bus lock, an rt_mutex taken by the tx thread, was
released by whoever called kthread_stop(); the tx thread now drops it
itself before exiting.

The double free was pointed out by the Sashiko AI review of a pending
mctp-i2c change, as a problem that predates it.

Suggested-by: Matt Johnston <matt@codeconstruct.com.au>
Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Closes: https://lore.kernel.org/netdev/179239912623.3135.11352652156626817288@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
v2:
 - remove ndo_uninit instead of making the free idempotent, as suggested
   by Matt. The unlink and sel handling is factored into
   mctp_i2c_midev_detach(), which mctp_i2c_unregister() calls before
   unregistering; mctp_i2c_midev_free() still calls it for the
   add_netdev() error path, where it does nothing the second time.
 - take the unlock marker off the tx queue before purging it, and have
   the tx thread drop the bus lock itself before exiting. Both were found
   by stress testing the new order.

Tested on an AST2700 BMC with 20 iterations of removing and re-adding a
netdev, and unbinding and rebinding its controller, while requests run
on it. dmesg stays clean.

v1: https://lore.kernel.org/netdev/20261022031704.2295541-1-kenny_hsieh@jabil.com/

 drivers/net/mctp/mctp-i2c.c | 64 ++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d33..4f4c715b4 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -109,7 +109,6 @@ struct mctp_i2c_hdr {
 static int mctp_i2c_recv(struct mctp_i2c_dev *midev);
 static int mctp_i2c_slave_cb(struct i2c_client *client,
 			     enum i2c_slave_event event, u8 *val);
-static void mctp_i2c_ndo_uninit(struct net_device *dev);
 static int mctp_i2c_ndo_open(struct net_device *dev);
 
 static struct i2c_adapter *mux_root_adapter(struct i2c_adapter *adap)
@@ -628,8 +627,11 @@ static int mctp_i2c_tx_thread(void *data)
 	unsigned long flags;
 
 	for (;;) {
-		if (kthread_should_stop())
+		if (kthread_should_stop()) {
+			/* Only the rt_mutex owner may release the bus lock */
+			mctp_i2c_unlock_reset(midev);
 			break;
+		}
 
 		spin_lock_irqsave(&midev->tx_queue.lock, flags);
 		skb = __skb_dequeue(&midev->tx_queue);
@@ -711,7 +713,6 @@ static void mctp_i2c_release_flow(struct mctp_dev *mdev,
 
 static const struct net_device_ops mctp_i2c_ops = {
 	.ndo_start_xmit = mctp_i2c_start_xmit,
-	.ndo_uninit = mctp_i2c_ndo_uninit,
 	.ndo_open = mctp_i2c_ndo_open,
 };
 
@@ -782,6 +783,31 @@ static struct mctp_i2c_dev *mctp_i2c_midev_init(struct net_device *dev,
 	return midev;
 }
 
+/* Removes midev from the parent i2c client, moving sel off midev.
+ * mctp_i2c_unregister() needs this before unregister, as sel's netdev
+ * reference would block it; mctp_i2c_midev_free() needs it for the failed
+ * register path. A second call on the same midev does nothing.
+ */
+static void mctp_i2c_midev_detach(struct mctp_i2c_dev *midev)
+{
+	struct mctp_i2c_client *mcli = midev->client;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcli->sel_lock, flags);
+	if (list_empty(&midev->list)) {
+		spin_unlock_irqrestore(&mcli->sel_lock, flags);
+		return;
+	}
+	list_del_init(&midev->list);
+	if (mcli->sel == midev) {
+		struct mctp_i2c_dev *first;
+
+		first = list_first_entry_or_null(&mcli->devs, struct mctp_i2c_dev, list);
+		__mctp_i2c_device_select(mcli, first);
+	}
+	spin_unlock_irqrestore(&mcli->sel_lock, flags);
+}
+
 /* Counterpart of mctp_i2c_midev_init */
 static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 {
@@ -797,15 +823,13 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 	mctp_i2c_unlock_reset(midev);
 
 	/* Remove the netdev from the parent i2c client. */
-	spin_lock_irqsave(&mcli->sel_lock, flags);
-	list_del(&midev->list);
-	if (mcli->sel == midev) {
-		struct mctp_i2c_dev *first;
+	mctp_i2c_midev_detach(midev);
 
-		first = list_first_entry_or_null(&mcli->devs, struct mctp_i2c_dev, list);
-		__mctp_i2c_device_select(mcli, first);
-	}
-	spin_unlock_irqrestore(&mcli->sel_lock, flags);
+	/* The unlock marker is embedded in midev, so keep it from kfree_skb() */
+	spin_lock_irqsave(&midev->tx_queue.lock, flags);
+	if (midev->unlock_marker.next)
+		__skb_unlink(&midev->unlock_marker, &midev->tx_queue);
+	spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
 
 	skb_queue_purge(&midev->tx_queue);
 	put_device(&midev->adapter->dev);
@@ -827,23 +851,17 @@ static void mctp_i2c_unregister(struct mctp_i2c_dev *midev)
 	spin_unlock_irqrestore(&midev->lock, flags);
 	wait_for_completion(&midev->rx_done);
 
+	/* Release sel's reference on the netdev, otherwise
+	 * mctp_unregister_netdev() blocks waiting for it.
+	 */
+	mctp_i2c_midev_detach(midev);
+
 	mctp_unregister_netdev(midev->ndev);
-	/* midev has been freed now by mctp_i2c_ndo_uninit callback */
+	mctp_i2c_midev_free(midev);
 
 	free_netdev(midev->ndev);
 }
 
-static void mctp_i2c_ndo_uninit(struct net_device *dev)
-{
-	struct mctp_i2c_dev *midev = netdev_priv(dev);
-
-	/* Perform cleanup here to ensure that mcli->sel isn't holding
-	 * a reference that would prevent unregister_netdevice()
-	 * from completing.
-	 */
-	mctp_i2c_midev_free(midev);
-}
-
 static int mctp_i2c_ndo_open(struct net_device *dev)
 {
 	struct mctp_i2c_dev *midev = netdev_priv(dev);
-- 
2.50.1

