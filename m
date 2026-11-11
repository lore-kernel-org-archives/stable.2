Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400108;
	b=x2cm5dtnM5BV1QTndn1wFak3gbbbh9XFAJIB8DC+g7uy4+xPm1RxmoJVrFX/PZR1SipV
	 IQEVyw8lvPoO5ZhFagHH/e0pN1evXizDMY7Fcucn0ShMZYE+l9v7sVKl2NeVccRxWti2Q
	 oZ5ShjYIE5hr09PAX6aZo6OcuMioRkvRuy/ryOPTuBE7o+cny0ApsfWeXjAUeTIWkkgQY
	 0uJjZ11N+fLUF840ZiSQuXlSbQ9YIJmvHzUOE77XvWxP8OtpA4H2chMXSDihi3dNjl8N8
	 up1HJFyOlhIdiSduu85njRizYWys90iSDG7YKZh0uZPZGPleau5XgktfmJJ2qUYuGTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400108;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=UygaY/0THBIcmeOPpaFI7KFOlHMXgClDcPq+jXPHeOY=;
	b=GnvS4wi7UsYHr9MFInRU+dn+FEas+N6GbhQA6pd/vK5wHm90PQZJtySbqPxcuZur5wQM
	 w/4F20zUM1z1umVwxq4weMYoQzhkF5B7PZRzB+dhnRomL2g/2DLv2lfHZeGtjhKo3LbJh
	 L9xqeKWMiSK3BWFcbQjSOZNQomuB1rOGh/Nv71QesINnHPU74Fi3m+Z/0DuVwldMLi6IS
	 2nMWNDb92NBCtwXifvcYWrTgrVqhprL6tTA/Tpis8jWkCWTmFXHLz9Lp6Qc/5tmRT+JPJ
	 9WN5k00kBBofq+xELxOOTHm7p077bmnybyJvPWXF8L6hEvl0PrizU5EaymPeJeQ0/rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=aVpgv3vP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.125
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021125.outbound.protection.outlook.com [52.101.65.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B72606A31C;
	Wed, 11 Nov 2026 12:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21B72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=aVpgv3vP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKBKmtryUtI8gdCohwWFv4cvTIUE1ytvIr66c3lydWcjdh51CtrsUysR9SwrmN6TKjeAbO98RzdVry7C7g0gaYKn5pBxDQOADGdbIn6j+Vxns7+2gjbj+3AblXc0HFJZjF6fb5dr28Zfm19wZTWqsxPdvmFFf3n9B7N0WfEnlwo5D0N/qZdLkdSBXsjjnDU5xJdmyhztw6icgFlqNbwX8M2EHZcoT89OFsSJx1N4sHfcD/RC3sBlz5FkCyLR8bE0jZLza+ok3wtTt+74y6mHrHCnYkOIIsBVwIlGuBLAevuddciRnr8ZPqMtvQwX7e4KRIiUH20hX6JVaHEy1wHNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UygaY/0THBIcmeOPpaFI7KFOlHMXgClDcPq+jXPHeOY=;
 b=mEqkJRq75mi/HJvM75XJJbBMl0kxUbuMA92FR6roaYga4dIVU5q67njnkCQwczqVm9u+jgG9Syw+uIj5VfJyL6kTrLj1QxEPVTS5Chsri2eBJ1Q6SRDwUwmUD5O0FvholIrfdrQD+u+LxYcCruYegn3GarNd7stH0vuKpOw23EuDhvnRpGuxIRt6CozC2aeJ83ajoQaZSuHWT76h9b03xCC4zYbSbOoa69vP4XAV3fUZv5nxMWSadQbYYLCym8q+m3LQ1rNsR6+6LXju35MhLMJbfulaThAeZPdwV6ikPyaHeWs05I+5aaoH3HSz9igCckHVolJTVD7PLypGCU/Ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UygaY/0THBIcmeOPpaFI7KFOlHMXgClDcPq+jXPHeOY=;
 b=aVpgv3vPjqXm57EK5MGM1utxII2K8jNClXhuzvIz23YuW1HlJ+vamaOzM4eBJCyZnS3m9BCdEaos9j0ja/l5knPyPfanTX/j7WN3qFD2PsyOD+NyLxu90v8Ghb9WTdOO6rtHuEuDvPRRJYJ3kT9cFf5nmcd9Co/IBg3TuT7G4QBZZNha/H8itNUBgW792jYkYaSDzySbkF1kb4Fl3ovmq7c8k3gLiEoq4AFRhLImJIEGoHOqm0vW2a5tLn11MEO36DCmeGwmfhhI3jZdMkoLk02UzEll56rM4Bkw8+Jg5oDzGx1Kw1xkt2LIr5AtDeniaMN7+lSksslHrksgklkRiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AM7PR06MB6737.eurprd06.prod.outlook.com (2603:10a6:20b:1a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 12:28:18 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:14 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH 0/7] serial: core: Power the line transceiver with the port
Date: Wed, 11 Nov 2026 12:27:59 +0000
Message-Id: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9f9GoC/0WN2w6CMBBEf4X02TW0Qqv9FcNDW7a4CZfaAtEQ/
 l2QGB/PZObMwhJGwsR0trCIMyUa+g34KWPuYfoGgeqNmciF5LkQsPdNC2M0fXJIM0ZIUwjtG25
 YWiW99by8sG0fInp6fd336uCIz2m7GI/w/6Czw89vP39MxbWEbqgRmkADoJLWKmGlF1zPYvdbk
 xDc0HU06mxW5wKi46xa1w9fD2vP1QAAAA==
X-Change-ID: 20261022-serial-transceiver-supply-9e5b76fbf153
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=4427;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=v+e29rJwbyCwNlzkafkWZ1JNsiFr0lYh2F/blLhzvBQ=;
 b=9imYNOqnPtX62ebbIQWFkf5I47TtyFYsSj/DnN4noZ0hDtAE55XPRe9U+2hdwreFYMwCRUSRb
 31UzVA7/MPxA9LbA2wBLBOr0lG8dvPVSWIqNSOrdROaFoqm3vhNlSnc
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: BE1P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::13) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AM7PR06MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aca2e51-5eae-4daf-e3d7-08df3fef418c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|23010399003|376014|366016|1800799024|38350700014|261102123227099003|5023799004|11063799006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|56012099006|261026121527099003|261022075727099003|261028144727099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gDJddm2xJXSpW6aipJfBPs4bZulwhOx09znaOZUexhwSeXNCPIXKWlpz2BkhkP0ynn/cHhomV8bWvSs1WXpjShAFYdrbfdtCu8db7+bnl1EMQ/HTCvZscwdlEgyK0+tjwYZ544ropTJoV9ksiXjxRwYie9b5LWh44eErEcG4IWyNIvWzz/J8E9cfii+4Y9FwXlg7pFMMhHfYJ8Kl5S5TflielJzV+ffg+8yXR4SjlgAQqk+yVgQUpsSKa9j7h688Tf7tR9+JQXJQoF8+mDodC14a3GXbcHTPQzKNbB01+tqCYPGjxneYu2jFIY5ApmGyN5RRgg7bZAdQamo4YVZWrbZBs+F+/2/a2bwundaJprVKGfu9rNIFL0ysY1H3Tavocc2rVjPhyS/jFdgf1y953CXB9mzLFZXiLkFbwGFp4WdkC4C9iR4wsnLeuLs0E0ftP1WzOzgpFN/IHk0rYnR12KaYUHZPmB1DKUmUJHQTHoLGTO3X8b+7pTtXFh5d+dxNmVVndli/J2NPDz6DR4u2tS0vyLxBzQJh4YTLuc4SeAUi6TsX75LAgJ3Owmfl0tKLSnRg8ADV+SXKStfWmF7mdcKDHX/0zZNP9PNkk/nNXhnp82UOQW8XTGjdZEM41AfbsA0Fu+1A8TYZosz2rHB1zCDp3GibiZ/O5snAJ3Hvg+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(23010399003)(376014)(366016)(1800799024)(38350700014)(261102123227099003)(5023799004)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(56012099006)(261026121527099003)(261022075727099003)(261028144727099003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enpOaFZ1QUZvWEl2RkV5dUZhUHFsdkhxRGZzRGcrbFJQeW1WUDZlditUMC94?=
 =?utf-8?B?NGJxcjI0V0phQlRxOVp4Wmc4SExVb3hWQXVXNzVrVXA4ZUtXeGc0cys0NGVm?=
 =?utf-8?B?ekR1Q3QvUGl4VVlsai9HTzhqV3BNL1NLY0VoUE90ZlBWWmJ3NXVtN1krY3dv?=
 =?utf-8?B?VG55bk41WGxRa3JtZ2RpaWhwZGhNSExKdXU2Z0xObUdnQ21YU3h5LzVJQWJP?=
 =?utf-8?B?ZFBoQWZ6Vk5RcElCcHliU2hFVGxVMFZQcldESC95R1JJb2RlK2ZaV2NTUWZB?=
 =?utf-8?B?RjhMM2xTRmhKMVVqWU9wL3pTaHFVbVFEUzhjNTBXMnFNVDc4STZpR3lLbm90?=
 =?utf-8?B?Ri9TVnYzK1loNTdwRVVBSGhzVlZOUmVZWUNuSFNORzAzdmxJOGV2N1NsWkU4?=
 =?utf-8?B?ZFMxTDJtYWFZbXJSUG9XaStScXlUbm0vSWNuNklFSXhJSDloSmZ6Qnh3V2NL?=
 =?utf-8?B?VFdKWEREak9Nd1UzZDcvWno4bUxvWGhJbzJDc1lCWFY3d1duME16dnNkd01P?=
 =?utf-8?B?MTdqaWRRWUo5Q0lzWkk4QkVSdnJlNnhzL0YzQ0tHa1l1RUNTRTVid2lXeXNp?=
 =?utf-8?B?T1VCL2h5eVJFaTd5Ri9ybVNFLzFTV3l2ck1qYkwrNnhHTFVady9nVlVxNVBF?=
 =?utf-8?B?aWlRNE81NCtaR2VQZE5KR0Q0RU1BK2pSOC9jR2laWW1oUElQRlRieTAydmdx?=
 =?utf-8?B?b2wwVDBIUnhtRUpwNFBzM1l1a00zaXowSmxjWkVVUCtnN3dmbXJtUGdYdXN0?=
 =?utf-8?B?dTc2WDBocTUxd2tHQnpFSzA4ejJ5REpYaElaS1ZRNnBoNU9RSnluQUJ6OTNO?=
 =?utf-8?B?cVcweVlMM1NIWFFpTDJlRGdKSU54MDBXbHNvdjF6WitPTWMyUkZpM2lPMHRG?=
 =?utf-8?B?SEozT2JmLzJpYXU1K2k0M1VCcXlnMHR1VVhoUUtkU2JSZjZEVnhISXZ5Vm5m?=
 =?utf-8?B?ZHY0Z0R3Qlc0cDdmeUNXZE5ZZDg1WlFCY1F0dmgyMG0wb2IzR1lUOGkxdjgr?=
 =?utf-8?B?bG1ndW85aVEzeUo4VnhWdWJaTm5GUTY2M0JvZ1o2T2lJWHR0TlU2M1BSenZa?=
 =?utf-8?B?ays4SWNiZFVaTFdvR05HbllTTDA3a2xZbXovSWNYS0M3bXp2T2VCelhYeUhT?=
 =?utf-8?B?ZDE4L2hLa0tiVGJzb3BMa1N5eEtUL3BaWDQ2OHU5RzJKZ2k5K2Fua3R6THQx?=
 =?utf-8?B?T20yZmRRa2tiYzNWeENPTE40QldSVC9xM21OR2lFWjJZVXFocG9ocXNsbUlw?=
 =?utf-8?B?dzFuL1VOQmF1RFF1Vk8xem9PT0laWCs5QWN0YWw3MncwVVUrRTVUYU1SNndm?=
 =?utf-8?B?RTkydGNMSXBKUGZsdnBMSklTbzF0YVNKK0p1Z0lkdno4bEhzRzFZNkp6Wnp5?=
 =?utf-8?B?WGZaTjZBZEovczdGZGo4UFUxQVdReERFTmdPMVlnT0NnOVRKQ0tvZUhrTWt5?=
 =?utf-8?B?ckhaWHlLdjY4OHpWbGNzTnBGUENiQXpESnFDTTdEM2NlVW5pODNwWVJaME1E?=
 =?utf-8?B?eUQwQ2R6ZHhjOG9vNGxaR0J3NHpzUlI5NG5mNjlrdFVqYktwYzhDS1BYcUR0?=
 =?utf-8?B?VFZ4dXUybFpTNVY2K2JhYzQ0Qm5tL3prTlZYYlFMWGtQR2Nva0FEeml3Snl5?=
 =?utf-8?B?Z0FkV0NCR1IrZ0lJQkMwb3dtK3kvNkV5cXZtczdHRHRHeUFkU2ZUNldNQmRX?=
 =?utf-8?B?emNkNHpuQWc0dFgzZm9JK2lyd20zOThVTXBmaTNhNUFsaVpYck5wNXNGbEg1?=
 =?utf-8?B?SjdQYlFneStWdUR5RHlBV2szSmlCZnQrMGxjM3AyUHhLK0djYjBxVklVM1RD?=
 =?utf-8?B?eWVGTno4QWEvVEVmd2JrUXVva3dHb0xBNkFUb01saVRSUkZlSXFaR1Q4M3RU?=
 =?utf-8?B?WHp6OFZPNEZVU2pwVTRIL0Z5UTdiQzVoYVNrSFRHdzdCbXFZSkFyL21GT3oz?=
 =?utf-8?B?ZGtZVFl4OUJydDBLWVdDQjF2WlY0YXFDYU0xSXAvQ3BGQVZjN0JjNWFrV3Ry?=
 =?utf-8?B?R0lOaWxWWHN1SDlDejl4MncxcTdKbXRrMEZKWHF4TnhOeFd1K3BkempzeVJu?=
 =?utf-8?B?M24vRmIwdGhaYW5HeE0zU0RxWnFIN3dVM0tYWWUyMkhNM3ZORURlMjJQQ0ZE?=
 =?utf-8?B?ZkZ0L0h1VDVyckZndnhtT2lRK1orY3g1a1dUZVZBMHpxMnlmcVp2UkxpOFlo?=
 =?utf-8?B?RXAveHB2dGppWHkrTlBRKzdZaVZwMk5uc2ZFR214NDBUQ2c5SFlKRDdnZkVy?=
 =?utf-8?B?LzVoalFtR0tiSkUzcTc3cFgxc3ErVzJucmwzZFQ2K1cyQlpMekp6bDZqRW13?=
 =?utf-8?B?RE5lby9wL0w3TElVT2VTMDRsZTNiTklyTFNZZlk0ejFsSW9RKzU0QVIwVlRa?=
 =?utf-8?Q?90uvgTTsz1ds7tvM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aca2e51-5eae-4daf-e3d7-08df3fef418c
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:14.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txHmSJJuYVsIv0ZrnswI1vafAzsTHCrlmRengBc4C1Dbm/vto9gQx0w6HUQC181RlxXRuLP2hgwmIHlAXlEdo7FNSio0tY65J0jNfsiFB9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6737

A UART's line transceiver (RS-232, RS-485, isolated or multiprotocol)
has no driver of its own, so it stays powered for as long as the system
is up, whether or not the port is open. On many boards it is the
largest consumer behind the port and can be switched off, through a
shutdown input of the part or a switch in its supply.

Patch 1 is a max310x fix that stands on its own: a GPIO lookup that
defers for a later channel came after the earlier channels' ports were
added, and the probe then looped for as long as the GPIO provider was
missing. It carries Fixes and Cc stable and applies without the rest.

Patch 2 describes that switch in serial.yaml as
transceiver-enable-gpios, with transceiver-startup-delay-us for parts
that need time to come up. Patch 3 rejects the properties on the
dual-channel SC16IS7xx parts, whose two ports share one node. Patch 4
lets serial core request the GPIO when a port is added and switch it in
uart_change_pm(): on before the driver powers the port up, off after the
driver has powered it down, so the transceiver is never switched off
under a running port. That covers open and close, suspend and resume,
registration and the /proc/tty/driver read. A console port stays
powered, as it does today. Without the property nothing changes.

Patches 5 to 7 are for max310x: the transceiver is requested per channel
from the channel's subnode, and a new per-channel flag,
maxim,tristate-when-closed, three-states TX and RTS while the port is
closed, so that the pins do not back-feed an unpowered part behind them.

The series applies on top of the rs485-select series [1]: at
registration, serial core sets the rs485-select-gpios line before it
powers the transceiver up, so that a multiprotocol part comes up in the
configured mode.

Tested on an i.MX6SX UART with an LTC2873 behind its shutdown input and
on a MAX14830 with one LTC2873 and three ADM2484E isolated transceivers
behind switched supplies. On the bus and on the isolated supply: no
drive and no back-feed at open, close, registration, /proc read, hangup
and unbind of an open port; the last character of a write followed by
a close reaches the bus; data in both directions between the two UARTs;
a closed port's unpowered transceiver does not load a live bus. Suspend
and resume were not tested on hardware; they use the same
uart_change_pm() order as close and open.

Tool use: Claude Code (Anthropic) was used throughout. It drafted the
code and the commit messages, reviewed the series against serial core,
wrote the hardware test plans and analysed the logic-analyser captures.
I decided the design, in particular powering the transceiver in
uart_change_pm() and the max310x three-state, reviewed every change
against the code, and ran the hardware tests. The code and the messages
are mine to defend.

[1] https://lore.kernel.org/r/20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Tapio Reijonen (7):
      serial: max310x: Look up all channels before adding any port
      dt-bindings: serial: Add the line transceiver enable GPIO
      dt-bindings: serial: sc16is7xx: Disallow transceiver GPIO on dual parts
      serial: core: Power the line transceiver with the port
      serial: max310x: Request the line transceiver per port
      dt-bindings: serial: max310x: Add maxim,tristate-when-closed
      serial: max310x: Three-state TX and RTS while the port is closed

 .../devicetree/bindings/serial/maxim,max310x.yaml  | 16 ++++
 .../devicetree/bindings/serial/nxp,sc16is7xx.yaml  | 11 +++
 .../devicetree/bindings/serial/serial.yaml         | 14 +++
 drivers/tty/serial/max310x.c                       | 62 +++++++++++---
 drivers/tty/serial/serial_core.c                   | 99 +++++++++++++++++++++-
 include/linux/serial_core.h                        |  3 +
 6 files changed, 189 insertions(+), 16 deletions(-)
---
base-commit: bc71431221f5ba8bb33918399552636e059c2c45
change-id: 20261022-serial-transceiver-supply-9e5b76fbf153
prerequisite-change-id: 20261019-serial-rs485-mode-gpio-e76bb72b6f21:v2
prerequisite-patch-id: cbd0696a89bd2d2c80a6a1767d30e1521a1365eb
prerequisite-patch-id: 7e8ceb778d3d7189c06b6a4730cb3ae30039c174
prerequisite-patch-id: f3cacd874a4d95dd58b19ebd5ce19db6489be5e2

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

