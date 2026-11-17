Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794896060;
	b=wtzi318xwx9+z+n6zrJ3mn+GGjmsLs+w38nRNNHwekfLZ+8nCGRrLRNetpKHi+hpagJ+
	 vHD7BsbyfG7YqrUingIYh+RXlIfjvAfXvJ3VWZHaaQsIj1SszSHbwNK1K0SpZWVEWSEvG
	 RW9xFrY3zIUU8SV76OlmIph+oOwjndfVrrrcPQJQxPkCqxJi3LbZ/yN5CXXKcEP6kCLBs
	 50Zo8YAG1cNbZrUNk8+VhCSRm4WjgifSNeo9pHpKlohZxLmgfVXO+r64/gSCalxOMKzWd
	 f3i63P7OZmCUIybTvL6smlZcLzVJmby0WFOZAfKiAAbi2l+LpzOWfsFeN+kAjuyR7Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896060;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=OMJR01tGfR6XPKYp+X5lr64RnT2A0RVc996lQeEafak=;
	b=CIKNbH92djwtSTDN9tHyRCAKY+2/sgECIqZU352l6gkSnQbLcCwmrN+bYCQ+NOs1Fkk0
	 zALyyf5b2WVcfLREj7P9lL5gg1XuYp86GXHuvn4+xM4kAQhBzcDvvJ/048vsfwyFpwHIP
	 TKZH16JMMoeLF2halzXLO1SBluqGbv/NE7ZXysDhyxhMynAKKLRSCbbZJOBqf5jWmaos6
	 1QBWel9/FFT9BySnm5S4+sSsnW2N6wb9LFjaAKavIze13x7CGa/OiheP8xLUPcJaNYK6T
	 PV45v+hZNWvBEd6dA51bncBUXuO3AW8kvpbVZeyrRaN0JVdjXJUNQbNhZQbYItyyAyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=q5BmCs9b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023073.outbound.protection.outlook.com [40.107.162.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E6606A31C;
	Tue, 17 Nov 2026 06:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=q5BmCs9b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKB5I85GBVxkwTpOhj0R139XoQdkTIathfowzootSaMr70pf9vOJbBjA1XweyoOOG2i3/CyIJgIafC0vLb6pnJRfEi5yHuRta6KRxcr9kIFeXRtSChLEmpbzehVSAq1KB9aYisWv4MYKFfF+Mt+5rAY4tDxr9uTEvUSxs52443BJ9JXB08QlWhv1jd8a/2T6tWKXrssCPut/D26+MMQxtmUIdZZ5bI6kc+LhmPAcyyKYjsKJTF2/09eC1c5oiirfboIVLbJos2+kozzXjQkaTkc72z3MgFJX8NSOiM5nbC7BArnqg5lcD75XhYWEP1+cef8dFYBd2p3N97ox/tUvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMJR01tGfR6XPKYp+X5lr64RnT2A0RVc996lQeEafak=;
 b=oFOj/BQkt6nYPcRKjTclp+5iZQt826MNc1KesL4Vy3TJmSqOUBvT94We9Ytgg0K0F1vYvHRhVb6Vi8RjTqAbeqkpMIT5aW//lEh6FR+zr5NZhfZGD3qMEInhbieIUblNYDAnE7oujBskEcfFuWl0ko96PZn5JSHY8rqAD4wMbCY2kuRXo93R9yNmgC00s/CbQ6hOegOEBMdf30PJhLIzIdxTdH/Jvt+uiUcRbzfnXUmpoGPEGfr1peMol9gCrGa+Vva/bn79k5ErbQ89Gl7ozhrHyhq1WZs3ffnn6hVQ4XrAwSU0KN1dOUqNzhVmidXiaNlFEkYIPLeQorW2JL4abA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMJR01tGfR6XPKYp+X5lr64RnT2A0RVc996lQeEafak=;
 b=q5BmCs9bYsiBrSMrmGeLuw3yiiSkUsmBku2cT9+71iYFzFgDESjyaXZPgow6APaEQqnyRDdT8rULttBeI+zzp6fcD27aHxZZ4hChI0hxSCUg533ksqEW2Z82ERPbduLc8vR6GZjqGxSvhIItu5vdXiuQ1KgQcZSVj2sEkaOSkAt46FLMcbf7dNkc3u61wJWYZ0wrDI0SMm9oBgsbP0zaR4t14HwUX3I3IEjbSi11TtUrzupADBTSsOT9rtyCLBC3aBluLnXoBnC1Agjm0kOiDe0kEsBfxU992qWp88cqVvtrkka/dKMphi5oP6AvzcXxvd8lzqHRlWbjKLttecus1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DUZPR06MB8724.eurprd06.prod.outlook.com (2603:10a6:10:4b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 06:14:13 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 06:14:13 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 17 Nov 2026 06:14:04 +0000
Subject: [PATCH v2 1/4] serial: max310x: do not advance the TX fifo past a
 flush
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-max310x-tx-fixes-v2-1-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
In-Reply-To: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794896051; l=5719;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=fZvX3tyRBXdZROy9Iqb6+M2b+LC3HTxFI7tN1ikb5ME=;
 b=fT8qefFdebV6v5qwBHs3eHNGbYHGQIHMma9ydlf9kfwegeivunZDQBUGTbgnhtpHgrsZCGCag
 42t2sDW9VG6CmGXvDg1/sxLLY1i5NFXTsdsI/6N3Xj9fY2tPqcm9P+A
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DUZPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: dc12c103-ddc5-4ee1-9096-08df44720040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|1800799024|376014|18002099003|22082099003|11063799006|10067099003|261026140227099003|261022075727099003|261026121527099003|261022113327099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003|38350700014|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	l8BUpTkv/MlsthY0INPuvy76mbHm5DwT3Z5LuMykhC5oXvXD+BRbJZwnESyhPikIpETC8MmnvvL2lUY+FQN+F+eyfOr3eAv2eqDv0fqw8yQfcs0O4W+7lmD2VenLcVx6kf5qFIZRKYcHePZOM/ZNbrOn0zaO6OHFBzANYbDXqf/oHOoApnONWpW63SujNSga3w+Qnyypy5klu5o23voujg91qWgosYXTUD9xayogu2miFrWzltCUgvDPaiwYPYOOfWpjJGZb6I/fRTo978NnwVCZ3ZXV/3XgDeZnuoy4n7hy0qHkmTiDOj/IfTrMp+ZfgwAW0LC2+RvVo2iiw2NZMquBU2DDqLHtaNwTFxwzXRaEobU6CGRn1bvTTTAsBwy0+2Yw44xMPoCQq9ESknfQ1SIesAv0qK2Gjbn1Fuat9DKRDRw2yL4l3IAFe4nbuMbd2cC9/TExPL6vIV6c4HGegiMCVpxTIujvkzN/m7GeIC345ZEX/fmrpk/9vUJ0ZVL4XoLrZi0Pp1XnKbvCs7J3cGDbQJRJHI3JUZsAQ9f9GMIeCmIorGQZkVVAECeesU73mVUY+N2CQWJMm1nOQjB2tZxrxQwrjss2Rns+FhC/hsN+DGrBgkvj9h4lGYbvRFeNB35AzW/jxQxSNrEdb1wR7cvQf53a4lQJqDKQ77RmH1JSLV3vzNOJsyWoI0egtN3MfVicCGiJA3TL3RtwdL7GGESASQAk3AgSvxshzVIaaUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022113327099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(38350700014)(260925021911599003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmhSaW9VUG5aeVZON1c2WkU5dVVxT3FoY2t3ZVZMWDN3a2kvY1RuUUtBMld0?=
 =?utf-8?B?S2thL3ZVbE5tVWpUL2lmOWlYajFaalBYVVByZzErSzR2OEQrdlZwMTJOVXg4?=
 =?utf-8?B?OUVLeXZxTlFIODNxdG51bnhMWmNyZ0RYVU94UVI3WU44bHdYWm1aaUxoUHZw?=
 =?utf-8?B?ZDczbjhoL08wdUc5MEs0L1lKQzE3ZkZnVjdlYm5EOHdaSGFpd3Q5bENSS29n?=
 =?utf-8?B?TGw1NzBNdmJGYlV2VnNmYjFpYUp5S2V1b01hbGpMWElFeWlDUTM0eWNQMGd6?=
 =?utf-8?B?QnRLc1RpZVV0ZmRwTEpGS2xiVmIwUmkvNWNoa1F5YXExN0x0VFlDd0pIblRj?=
 =?utf-8?B?Qmw3S01Cb1haYXRaZlE4ZXl0RmhXOGM5ZlZkM25IMDJKN1lVb1FGbGFjR0Yr?=
 =?utf-8?B?c2o3SG02M0pvdWUraXBWNk1WMFJhUFFacUVQUFVtYnJLYWg0TzYxK1JWWVBG?=
 =?utf-8?B?bWUxWEVwVHpiNzRkbTdFRXJheUZyc0JjOUEzKzU3eDZPOEFyVVh4WkVjNXE3?=
 =?utf-8?B?VzhZOHgwZHY0YUdvQUQzWnoyNnVWWkVvbFl0OVhDc1pWQUNCdUxlRFQxUU5G?=
 =?utf-8?B?dmF4MDZlMXRHSmwyRU5wc0YxdnQrSENqdVBqYlRuckVQTkZWTnE5dzlocjJB?=
 =?utf-8?B?MUVyVGpIT0l6M0tTTWhXdnBKQ2tXajdNZENDVHY3eDhndGRSdTVvMEM5aUxs?=
 =?utf-8?B?L1E2aHQ0UGhYTTlGc3F3K1pUMmdXeUNoMHpkZWlmbmNnY2IwcnMxa2YxMHNH?=
 =?utf-8?B?UllGczdEUVBtY21zY0x0NVJuSkp0d0ZFbHpXb0ZNVGlpdTU0cjhvNzZNOUND?=
 =?utf-8?B?bXVTMHlPYmFlMnhiZWlNeHA2aVUwbGkvY1hqcFlSS3o1T2J0cnpIME1TV1Vn?=
 =?utf-8?B?ZHJkVEVZQ1I5TUVXaEY5eUMzY0pHcXcycVVLdjRMZGoyZ0MxQ3FLM2hnNlhw?=
 =?utf-8?B?S0dxM3U4ZE41U1A4eDhrTHp3Wlp6SlJ5MjdVM1FpUEtSdXgyV0k2bkhiV2lU?=
 =?utf-8?B?T3VzdytocnRqVGQxM2w4SFNWeTlIZUhUSmZhenNCZENYcjBMemdGU1ExdWs3?=
 =?utf-8?B?eFpOOGxPczhLMEF1NDVSSTFQMkN3ZlAwM2JSaWFEeEZ3Q0dGMzRBMG1MUjM2?=
 =?utf-8?B?YzdFaFpucFovN3BhUmVXbDR0dTRXUW5lcmJ3elZIYTlGWXpTR21tVmM3MG5M?=
 =?utf-8?B?VnQzeEd3MittMlBCMFhCQkd6MVlvc0czOW5wTWRXMWZvRGtrUTNHT1BPaWRt?=
 =?utf-8?B?eS9laFZsanZhQU0ydnFaaFdtaVBmRzlMRmUvK3U5U0V6UndKU0lvVUt4ZWk3?=
 =?utf-8?B?SW1IS256OGIvVllaSEI2WVlMajRlbU5BRkExTkkvVXhSYzE1WlZQd293Qi9F?=
 =?utf-8?B?WWxETG9wSlZVYmN1LzZPTE9jcnBqaGk4ZXdiR29GQ2tLNGtTS3BGcDlyVEdt?=
 =?utf-8?B?bGVsRlF0MnB1bUFtQVpCQlhIbmNWc0FRZWFpcTE4bFV1RDdXL2R2NTFNWlc2?=
 =?utf-8?B?cHBxMG95UTZLT0N3Z1cyZlhkbzNwdGdyTm5TYnN1NUYrekhsOGsxK01DUkNQ?=
 =?utf-8?B?Ym9laXJRU2ZDVll5VVlKYjJiMDl2a0hRM0orenBDTFZiRGp0TzVqckFKWldC?=
 =?utf-8?B?WW82YWg3MVVtOFh1dy9PUDlmZENPS204N01vaHkvNm5lZ1VoSm0yMkhxbWxB?=
 =?utf-8?B?NEFEVnZDMnFYa2RQQkFjd0RMT0lDYllUZkRMMEZFa29WanViYWdCZitvZloy?=
 =?utf-8?B?WEd2QzZSaC94SVJDV2NHbitkdWsrMnMyekwvTWk2TFU5SXhUYno3aGx5K3Zi?=
 =?utf-8?B?NC9oV2h0V0t0VC9lSTJjdWtvdnFCaTFBeWRZOEtNSXhkcXVhdXEwbTJDSkJs?=
 =?utf-8?B?MXpVWTdLVUgyL2VLTDIxS0I5YXJnMEhGL3lkZmFudHM5MVpZdStFSm0zV0hm?=
 =?utf-8?B?Q05rWDRRNFdxc0s0ZEgrZWJXTG1oeDhpODZEVUxIZXNET2hwQzdUOWd6S3Yz?=
 =?utf-8?B?Ny81YzVmbnBMZDRoNUVWbmE4OEIvSEdhUS9OWGVveFBLSXorVklvVzhmY3VK?=
 =?utf-8?B?NDhRR1duTDBqVmR3YXdaQkw2aGlzdEVWR0UvelRNSWpHY1RmWjJ1K3FTa1Ix?=
 =?utf-8?B?dGEzdnBmSnZ1UFAzalkwVmlQaXJCQ0JRQnV4b0wxcUZ6QWtieUdja3NvQWVj?=
 =?utf-8?B?a2xGL0VmNVk3LzRvSlhsK0syMC9zaDBkU29TK3Vjc2VvS3pLTm1FSUVDQ1cv?=
 =?utf-8?B?S2hpeVAyc0RxWUphR0Z3eEZYMk1XSDZqbnhPNXI1WFJjMmhDWWsvbFFCcWhI?=
 =?utf-8?B?b0d1NFJNWFZwcG1TOEMra2x5Nmc5MXNTcTJicE9FNTRMbVhJTUFXdHdObTRq?=
 =?utf-8?Q?gbnPWsM/qVnqoc0o=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc12c103-ddc5-4ee1-9096-08df44720040
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:14:13.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7XycV0MSaKnmNmHzAW5AmAdsz8gwECnhjHzlvVxcG+tYaewsO4+UJdakmcauGekEDGwAcmrU3mrRMO4rC8YPfa2eYF70IY4hz+6covUuZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8724

max310x_handle_tx() runs from a work item. It peeks at the transmit
fifo with kfifo_out_linear_ptr(), writes the bytes to the chip over
SPI, which sleeps, and advances the fifo afterwards with
uart_xmit_advance(), all without the port lock. uart_flush_buffer()
resets the fifo under the port lock. When the reset lands between the
peek and the advance, the advance adds the chunk length to a read
index that is already zero, the index ends up ahead of the write
index, and kfifo_len() wraps to a value near 4G.

From then on the fifo never reads as empty: tcdrain() sleeps forever
in tty_wait_until_sent(), and while the port stays open the work item
keeps sending stale bytes from the buffer. Observed with a tcdrain()
in flight at 300 baud when the port was hung up by an unbind, which
flushes twice: the first flush left 498 bytes, the second found
4294967217, the draining task read 4294967276 and never woke again.
Before the kfifo conversion the same race left the circular buffer
with up to 4 KiB of stale data to resend, after which it recovered.

Copy the bytes into a per-port buffer under the port lock, send them
from there, and take the lock again for the advance. A flush_buffer()
callback records a reset of the fifo, and the advance is skipped when
one happened during the transfer. kfifo_reset() is documented to
require that no other thread accesses the fifo, so the consumer has to
hold the same lock as the flush.

The bytes stay in the fifo until the chip has them. tx_empty() reads
only the chip FIFO level, so taking them out before the transfer would
make tcdrain() and close() see an idle transmitter with up to one FIFO
load still to be sent.

The lock is not held over the SPI transfer. regmap hands that to the
controller straight from the buffer, which is why the buffer is per
port and not on the stack. The copy is limited to the buffer size: its
length is derived from port->fifosize, which TIOCSSERIAL can change,
and from a FIFO level read from the chip.

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 46 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0ed70185555eed745d905b36c8b8f162468dd6f..e6a740295b96653281a92f8d94999f06c2c74685 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -317,11 +317,13 @@ struct max310x_one {
 	bool			sw_rts_during_tx;
 	bool			cancel_tx_delay_tmr;
 	bool			tx_teardown;	/* envelope being torn down */
+	bool			tx_flushed;	/* fifo reset under a transfer */
 	bool			rs485_pending;	/* rs_work not yet applied */
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 	enum max310x_tx_state	tx_state;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
+	u8 tx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
 	container_of(_port, struct max310x_one, port)
@@ -911,6 +913,7 @@ static void max310x_delayed_stop_tx(struct uart_port *port)
 
 static void max310x_handle_tx(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	struct tty_port *tport = &port->state->port;
 
 	if (unlikely(port->x_char)) {
@@ -931,23 +934,41 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	/*
-	 * It's a circ buffer -- wrap around.
-	 * We could do that in one SPI transaction, but meh.
-	 */
 	while (!kfifo_is_empty(&tport->xmit_fifo)) {
 		unsigned int txlen, to_send;
-		unsigned char *tail;
+		unsigned long flags;
 
 		/* Limit to space available in TX FIFO */
 		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
 		txlen = port->fifosize - txlen;
+		txlen = min(txlen, sizeof(one->tx_buf));
 		if (!txlen)
 			break;
 
-		to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
-		max310x_batch_write(port, tail, to_send);
-		uart_xmit_advance(port, to_send);
+		/*
+		 * Copy the bytes under the port lock, but leave them in the
+		 * fifo until the chip has them: an empty fifo with an empty
+		 * chip FIFO reads as an idle transmitter.
+		 */
+		uart_port_lock_irqsave(port, &flags);
+		to_send = kfifo_out_peek(&tport->xmit_fifo, one->tx_buf, txlen);
+		one->tx_flushed = false;
+		uart_port_unlock_irqrestore(port, flags);
+		if (!to_send)
+			break;
+
+		max310x_batch_write(port, one->tx_buf, to_send);
+
+		/*
+		 * uart_flush_buffer() reset the fifo during the transfer:
+		 * advancing now would move the read index past that reset.
+		 */
+		uart_port_lock_irqsave(port, &flags);
+		if (one->tx_flushed)
+			port->icount.tx += to_send;
+		else
+			uart_xmit_advance(port, to_send);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
@@ -1094,6 +1115,14 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
+/* called with port.lock taken and irqs off */
+static void max310x_flush_buffer(struct uart_port *port)
+{
+	struct max310x_one *one = to_max310x_port(port);
+
+	one->tx_flushed = true;
+}
+
 static void max310x_tx_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, tx_work);
@@ -1732,6 +1761,7 @@ static const struct uart_ops max310x_ops = {
 	.break_ctl	= max310x_break_ctl,
 	.startup	= max310x_startup,
 	.shutdown	= max310x_shutdown,
+	.flush_buffer	= max310x_flush_buffer,
 	.set_termios	= max310x_set_termios,
 	.type		= max310x_type,
 	.request_port	= max310x_request_port,

-- 
2.47.3

