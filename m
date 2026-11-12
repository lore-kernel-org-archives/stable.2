Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493906;
	b=3+OSP71CF/LhsvMMo7aT0tquP2FaVcQTqYg+3u0PVsmtCIADCIu00hdBrANJKPoI7HYL
	 OhYqyGDNVnFuYO91q8pB/y8RmT0hXYe1OFxdrUdYMY9p2jJr8Mm06/X4TcOYr3TMSl5Du
	 dkK8ukCRREaAefdq7zi1gUaFXu3vA6NYljJp0U8M6IGglad/5toeYV4a1/X//ygA/wV68
	 y8kxl0RZoVR96+v30GSBychw9PL+T9lsQw98woOH5EW5TXWPNUWNhizznMHohm7yhtW3A
	 W9Q0HP7hyaGe/vZ2Kr6bTC0Ib/ORzKUhPnfhN7nsLeE0w61rRF+eZaA9yHXPmWadu6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493906;
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
	bh=rxT4kHWK5q4yhkZx68qyNQZI08u7Pf2JQ7Kd54Rdovo=;
	b=JDn0Dkjuju1YUKleif9iTU0Nqtg2NXeDWM/yP17uoP2aLBal9cpNToGLE3sX9hbmORGL
	 SDpK9dKKsquF/M+5T94vGQdqlFwafv2/F5rRPKVJGBv6SF/lsl9peznY49ht8m5ti2Mqi
	 p413CgX7lltiZK9rhfXSUK/IzNsYcJF2GYGfXh7xcsKACn0mGf/4JZMZp9iQOAmHmWcxP
	 rW3LV8bzw5ancv+vzcqjI/9yxmT1rAuVM+xcId4pz8CPB+Q1YNAnu4BvucBD1e0C7ZuRR
	 MDMgx+MSr8pkjh24KEN3BpygPBAKw9q6zuK+4BlIzPt35DTKMi9dKyxBoSbuqPsdVAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=rygTqH2M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.1
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B4606CE7D;
	Thu, 12 Nov 2026 14:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91B4606CE7D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=rygTqH2M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+OI7NaFhLeMjhe70gat1OGE+LwS4xmcGMcdjtOCA6FJtlTZXapxehm5QYDkwAIo8LLOHYjeaXUCBjJFx0XVJhKI5j0pZ2xnioz6Y+371elAn1d8fWKAaQGwVvZJez1g+Yu6yKt5jmM7qCNyiy9t2TAidhXiwjfQK7g0top0vNOwVS3gpHRkOAoONbl1oqDTzET4g7nWWQ4/0t3FdOvmcMZOhmzBBrM/gGnyXlDUWQk1laBz2dXlnXpZ6bBNfTQFUkJg1YNB+jw9EwoTsvnLLbFahvGAtJEtPt8wekkcnnN+cH8QaTIn2n4KU8+XETYbQF82KYyyQr1lEkVuYc5qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxT4kHWK5q4yhkZx68qyNQZI08u7Pf2JQ7Kd54Rdovo=;
 b=M/s/Fk2oGVi5A7an1gNj9u9Mx+VXOSnHhZf9yuSEqLGZXQOwlxZIyBNvCKEQB4BrXqIwUQl3OZU7ayp9srb/k0IODDc/jMAs4IZjAxuInQSiV36tcvxNmQZ0odMcOCYVv28D5nqVcq5V4pK72qE3WhnAfXMd+DZuSSUWWLnOm8lO5EusumzoOsTvLVULNkojLF3DO/Fr8Lvk8FNSaRI3vKqPXRVcDrF4gAaa+hx2TJ9+7CQgbk/BzKpNGSwS5PZPXkmtjQ9CWWb+YCvxWFo0upUUNc54LIrmkeNHzImSjv2uHd1GQjhQreo0nIgRo8KP2sDzOboqeR0pgecPN53q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxT4kHWK5q4yhkZx68qyNQZI08u7Pf2JQ7Kd54Rdovo=;
 b=rygTqH2MXd78xLatvoDWWrLsqe1+jfUoAm4I7LgqnF8EhM+BcT1LgnzSZGIWXqt5DjQYH6WNXcNnyxGpBl6r1jJVOlfo6DuPZrTIu6u1ab8pxi87nqYSphxT2MrHmYN6zfOVqZhMRtBnA7kCLhyzv5NcH/IWKncMMLNrSasyvg9oRr67bGEyrzPs6GoV9E5KYq5v44pTTFA8lTjh/kr2vrrMPXhVmLKGs7gz5KNLiihnURYOoAREyyCtA6t07Bqr5SQi96AByFfCywhMvkdNwmz/aLohPoPTSFFKlToPIJrqbhVhs5gLEDwTPacW19jpVlZLE0n3t+T0Ts/ZLL/xUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by IA4PR08MB616472.namprd08.prod.outlook.com (2603:10b6:207:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:31:43 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%4]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 14:31:43 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: netdev@vger.kernel.org,
	Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: gianfar: clear the pending Rx skb when freeing the Rx ring
Date: Thu, 12 Nov 2026 09:31:40 -0500
Message-ID: <20261112143140.1395197-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:5:334::9) To BN0PR08MB6951.namprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|IA4PR08MB616472:EE_
X-MS-Office365-Filtering-Correlation-Id: f68d6695-30b7-4a64-47dc-08df40c9ac07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|5023799004|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qCRNieEQgCTYBDKr61lpWxEKndSuvjP5QX0UmBE9wMn4ULjYtn4NmsbV8NV+cO+RJxzkZ8bivNUn1ZC/6Pz0dnY8BPrvncyUu1So+VgsOL7ViEkX8Gsi6Z4k1yQ7GoGrkW4Vc8TgAeMWNZQSu+8savVg0DX9n34uQ17FTBgaxLSuE1+qJHU90ZFrxOFnGPtFL5Kpa0UEf+CPRkQ5Nll3s4FTrUzhK7DwSbHZxrMKbiRb4jhRgn1dtu7xV2aEVRyyYTb+sbrez4M+gO70WrjKnq+nfu5YtSxf0ZcXlvN25eYJIWrELxScKfxB+gjhbkyUrw7GLuO76ZvYHTIuWxPGPQKknS3bSxjEhaRsy1nEjEnVYqz8fcIHzEILjFPGpNOB7ySF4Rxk4jOSFplLsEWDngankZ2TaIzsRq2oBk2Sqy3XXqjDX5m7MaAgdh8lsNC+R6sFRwAJx34f5WesK7tYPjxC6ZsVpYNGevB/h4pWUto7hh81YP3mqmnU/MITlc/OqSd8jWdnSAXq1b0btel2bTm5nT6q7UsgUi/GVwtNxUcXNhoE9DiWvIObJ+8juBI14ikS2/HfLbNcfbEcXZu6pl0yh8uWdEolggPymhvlKfkwu+8WvffuV6rYf3fjMTV2Lni5Ry1X9IcVnM8bUD4ZR1KTljdmY6L6imoWmaJCbwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbs9k2gSvCGw0M0nHWEvMEbZW4PU5gCCdWIUKH0jx2lhYnFQow5FeR5t+M3e?=
 =?us-ascii?Q?E+0OBe42+e5acFbCqGfymItQsNJ9Eb7QdJiRc94fO/FFC6n5Ojmi8gSOKvzG?=
 =?us-ascii?Q?efSzhdFlq6XwrbrQuXDG2bZk5GPmaE8nAiSY5orMkwhNSP/Bf+iGdurSzdkO?=
 =?us-ascii?Q?dT7S/LPT+npugxYYh1Udkix7iKYuxU5jD+zAAaZf3li7bN8Kc/CSg7U1C5ic?=
 =?us-ascii?Q?OLprtXi5W5F9sIP/LMz2s1qrbJGe65ENGN7V+fPXs6p5YGluO4/CzDVEffuh?=
 =?us-ascii?Q?x7XYBN+RP4Yis25ye4h8R9cn3CqNkbNAiManxdAB+huptBkJf4Yrk7CQO9cF?=
 =?us-ascii?Q?151O5gtoIv5nyNwCU9DfD5uRVjmlRySHB/vnLS9jfjTIUDNLInrbS2BAdesL?=
 =?us-ascii?Q?GOylX9YmJLgKqySNBIYe4mriZuEks7lo15fWF3BZeXusX8lIvxAmwreyznRJ?=
 =?us-ascii?Q?Zc6GO8yrAzAkYI5cjqJqS2AOxGH63pWKgQhHy+ipAw7YIAnlSsdpvjYuVEQh?=
 =?us-ascii?Q?ZNTZgNPaqBBtkP8ZHCMiNZMkEwHcg5IKpUPEorp+bhc7AgObHsop9Mx7DWRY?=
 =?us-ascii?Q?0/ihzmg7uAyGalk80z1KWn3G7DlLKnJUs+LWlpilFRXECyPci1lfBj/nt2qW?=
 =?us-ascii?Q?Y8TJk+9/0hcVGY2MulSswi1S24RTgYB4YD2f0aHDeUfiiFi/nVZXxyX5AF3u?=
 =?us-ascii?Q?HoDB2G9PHATQ7K7dxK2F/I57WvQy+1J7QTdUDP9GucA3pq3dBIqR4Qu7Hs7y?=
 =?us-ascii?Q?F2BV79ZkurVPvJe73XzhKskx9EOYO/diAzBkGTjYT2OHfaUzLJY0S/jvdgVl?=
 =?us-ascii?Q?NCBcVLq0UlnPZESHE2FTQds28aKmlnUYRpc/RiCtAnEhCPoMNFjPcFQNGyBR?=
 =?us-ascii?Q?m0G56cgb0kw5q7KfNsd70492I4bHzFd/riYMSPXspfkFiMBbi3yZORpqcIf9?=
 =?us-ascii?Q?0d3g7nodZUm1/FA0LHokbic8ySKIh54iagVEqzMZwp5Oyl3wwxxboMT89D13?=
 =?us-ascii?Q?vC//mw0e2sIp1qYj58elkcYxtT/Fl/IcE8cWIN3jqGJFICOCHXsO04x0tRKX?=
 =?us-ascii?Q?xjd7MEY1C3/XjFqU1IrknblCf+HLICbp2TH0y3EXFqFmI1qNbV3VgSsPh4mC?=
 =?us-ascii?Q?mwh+anA8q0ODqDqk0vkP9a5aOApAyEaEKu2wWsM5iXYoNiLyvYjonKdMqliZ?=
 =?us-ascii?Q?xBCdlKNmIIpdCoES8YmaABqfIuLv1b06g+dQ9mqIOmyunPpHzGVC9SbfnsQu?=
 =?us-ascii?Q?UiNPdW8cunoWQn+e8cEGx1Pj9GD1g6cF2GyCJW9NsUti/cir8yQVaovlrvru?=
 =?us-ascii?Q?WcA2h6yntVg7JuHVqBm+d6Cr7L0bxmpnj7S3UYMiN5vqhvhqEGEXlomB6LtB?=
 =?us-ascii?Q?EyhZKb+uecGHq+T+bdMSKuGcgIfx5/jbIN0VrwC3XFknwkmdLcgrBVCySFP8?=
 =?us-ascii?Q?GeP8fkh65an53DsE55kLhJzvVPSFHxT+BRYUhRtQ8DId0gNXTO5rGnQ5vjEk?=
 =?us-ascii?Q?QPy4TSFmkeHEptkwLqqM6LE8WrFTzmxzCqDWzzl1ymqSFrijgVF95fjYb/dL?=
 =?us-ascii?Q?K/ekp7ESdJIs7J8H43T2lAC2LxsX+/qofIU9gJf9oXKsS1hxXEgJIg2HGD5j?=
 =?us-ascii?Q?eNE/7lBFQkf0CV4qjJUua2vCUVQOdy6QdXiBE8gatmJGhbK35FY3SnrkWKSv?=
 =?us-ascii?Q?zo329yy7Mzz7byjHSu6iH7F6SU5Xp6YoFrdcMapL7CYOvOycQMqeklL5e/ki?=
 =?us-ascii?Q?RJIqE5QClw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68d6695-30b7-4a64-47dc-08df40c9ac07
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:43.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L5+2aKGNmjWlHXwabsq2/s+GbJd7fw37e50I9JK0CxiIBwMPWc49jl6t0It/97bBYeToed9JstBAbibyeWyoUh7J+vgsG9x6yWwk24reb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR08MB616472

gfar_clean_rx_ring() keeps a frame that spans several Rx buffers in
rx_queue->skb between NAPI polls. When the interface is stopped (close,
MTU change, reset), free_skb_rx_queue() frees that skb but leaves the
pointer set, and nothing clears it when the rings are set up again.

After the restart, gfar_clean_rx_ring() picks up the stale pointer. The
first buffer it sees has RXBD_FIRST set, so the overrun handling frees
the skb a second time. By then the skb has usually been reallocated, so
the second free releases another owner's skb and data while they are
still in use.

Clear rx_queue->skb after freeing it.

Fixes: 75354148ce69 ("gianfar: Add paged allocation and Rx S/G")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index cf636fc5aafa..19010e08fc55 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1092,6 +1092,7 @@ static void free_skb_rx_queue(struct gfar_priv_rx_q *rx_queue)
 	struct rxbd8 *rxbdp = rx_queue->rx_bd_base;
 
 	dev_kfree_skb(rx_queue->skb);
+	rx_queue->skb = NULL;
 
 	for (i = 0; i < rx_queue->rx_ring_size; i++) {
 		struct	gfar_rx_buff *rxb = &rx_queue->rx_buff[i];
-- 
2.43.0

