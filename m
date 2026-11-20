Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795144634;
	b=L/IzHyWrcKMoZ2G5+LAbrYRY/AhoEJAJDJ169FVSP+ZMGXpkBsXh4GcUC8mkpe+fYkwo
	 yOTKdcHBv2W4gOqq2nb+6V81SiaNpHyFO3EjpTAqNiMqgaPrRn7OkOdFgHyjoZCHgJPoE
	 GmsassG7oI/X8oRkdznQsGhVuUUN+uAioExUbFyYq8oZgA9/Ld5ixGnNVw7kl2kbpdYtJ
	 NJQxJ2FEiYt/G94FJHT2IYaVCDeaKnCU8Zz0Qr2tQljO3hDwnNW94hh7dJ57ePnBkuj75
	 cuXqj/MdnqzrPEnJPLgR+ZcS9ygfRnnXcCMhIW0leROlcuVSVaEo68L1uIFlz7fF+tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144634;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RazoXDFEmTaGbLInOzJciezu+PHPWUaTuw4kUrHJbbo=;
	b=Bao7f3p/KLNEBRI//WY7nZ/ioPr3/drDzz6xMTmqZD+5q/dpR1uTvyd7Uw4UaIREiORD
	 CaPNgF3m1wRCQ/NeIlK9hZyN8OJD74unaFdNMDQXPV1JXPM8ZawHzPRvmkGcJLWnMykUd
	 bCPZOGyn4aIICxj2A9QUT3aMrmBRY3ndwPK2P+79W+ZihhDKECLnXsMRDOHH0yvr1eT2s
	 CEqLgtzvKYUMRmsNZN+IdqsmqHkrXZu1d0m50Yv9rHLn54M1Ez2E+lsIKDYtzTk6347rM
	 5JVvW20EiBvTbq4lzKRF7zXX+Gs5YUEooS/mQW9jiSberN1Odfl8BSS0rEX0jo3sG4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W5IIEQeC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.66
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890360A2601;
	Fri, 20 Nov 2026 03:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E890360A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W5IIEQeC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OA0dHY8VV7FoMN1rgucXjWc3yMlkIo2qmycOLQkYyWH2MlBpJGkyo1J3lYQUEPZuclnrAzq/47dgGUKqJN04X3yXDoXB+/z+Lf+3yONNy2fRUcIu4TsT8ZJ4bPYr/nLqSowWs22KAt2M8nmBQad5Ldk0qLwXYpx24gqQ3WyKmMjQ1U+4gn0u8GX2r6BLUq2LafTAxcWA8ThoIKk9lQuV1QDID/O+hZFlqecPoh09+Fb0yMd2uYqHzTucqqWypixtZ9dblz9wXKCRA+bCesWZwpnMIlqwURq8/mAuRSXWn4gm0q2kOLzYP6KPMQtpeQcZ1meyLVm5QhztsUTkT+hoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RazoXDFEmTaGbLInOzJciezu+PHPWUaTuw4kUrHJbbo=;
 b=xLkX4xPBeumDraHNMFmX1f99b9guwxq7OXkk9rcTRmlNhbbT3UPsAeDtlOQKMtzJM7X0yT1U3ToCI3VxD2L0efFyLi0FYv1RXN71oIIVW23531lq4y+nAGP44Lau+wl5dmk6IYJqs4u52aF/q46DJVHC5QEtdM8mvZqwBa6nAEFpFxCrhL6+gS5sQJX8tjMQM61o9jy3I9dHoU/skCjwJCxfBoG2FbVXbMMdGPGItdOLlorNu7lpO59+VcTer6IuRNhz3AEME6RzEctMbNbw+OX1OVBm5vsWTDQawTd0HIF/lWI26mdy7HcXdUsJEozPGAKuvaDqWk9fn1fb6nDTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RazoXDFEmTaGbLInOzJciezu+PHPWUaTuw4kUrHJbbo=;
 b=W5IIEQeC4mLSN9MoAfk7uGdmNiZtQHUb1Sh4fjkIb6Ax+l3bNUrm6KWas8A/YtSjwqAv4vDksmhqizIWMB0crfBhl/87YBp8LNInm0BJMMxQ/xDNb2paaLJRguIu5Ygo8r4s1QT7ihgAPV2WqfvOs5Tkjkr7JOuphQYOMWuc607DOBBWKuw61nWSU0ATvvhwaEOXkIs/r+lG6EiK3/U7kKwQzbEXInJDYOhPG1OtmJFafXLyzej0VBvCwrdxFj9tLOeJn7jvLFd4k9PDaqImzC2bCTWMmVqA4/8AIEIn2nV/0Hi7ZUujbwCDr/7JcHQ7PgVJGFwUhRuNOVjRc+sg8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 03:16:19 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 03:16:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH] gpu: host1x: Cancel the fence when a syncpoint wait is
 interrupted
Date: Fri, 20 Nov 2026 12:16:15 +0900
Message-ID: <xW4QZMkHQ7ahYXD5Tq5ciA@nvidia.com>
In-Reply-To:
 <20261113-upstream-host1x-fence-cancel-v1-1-89f453504222@tsv-stahl-riesa.de>
References:
 <20261113-upstream-host1x-fence-cancel-v1-1-89f453504222@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a4c41-ff7d-45cf-6020-08df46b4a50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10070799003|6133799003|261009223027099003|18002099003|22082099003|3023799007|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|261021135927099003|261021123027099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	J00Utffc5D3gdsULLmZ+zygnK6jgLd0wEPjPKf+nRCuaQMhKc4gW+MWuiIVGiYtOTDBvS8FyYlnu3etmNUQel1t52JlLfkbhOw9VmhMbubXaRdi7oaTUV9ZZEOFp+wZH+i6P9ZdZChfeA1BPBAz100CgxA/HM14vBGzNoY9GYd9kqOqOlEb7CJTdSpPaHE+HPGNlivTmBDQRHzWhV2mYmONWdxhZwqQOGTTCF+VxL6wigE6nbLwLp+E1KHeor+XZ0heaEOTb0qBXVldC07SzTbk7RpzS5XGkQs6/fK8XqYVZWn2X3+ejnRHp0T8+K2Eh48HTr2HOxOTMd/HPmfrsIX0fXr4f4kJf9SklUG74bbFrZD1sLdzlAcb3nBPqS91uThF8kuP9dEAl1AO4XK6in+1lTk/GZE5kGFJ7F7yQJ9Zu7C3gYHMZExC/8iFlc5YPCmLSPz9hF2FoEy3FpxG3sPYPeg2Ygz74ilq034yZ+P8LwoOQlkuhrO3TKdJIDVGMjtxuSQrHjmBMyYAsxseTVQVPwAuC8JJW9Hn5DtqYqODQjl+l9CO86JJp+bV0zmMwvZd0fg+tyDuB7uYxVZgFBt3XC7asTq7ZeK/j5BTGxmAWSyG22ZhL+feqhsGo/K27b3XcpnxG18jDnQhmYvDNfxoEsgd9I41QF8LrB+bRJqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10070799003)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(261021135927099003)(261021123027099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnpHY2NXV3MwZndjY04zM2xaSk9KUFNKREN0aVM4bUI5K0UxWDBOUTQyQ0RB?=
 =?utf-8?B?dzRSaSt4QXdvRHlBNzVzY2x6U0ErYnFQbjJramFUNlpJUzRGcjJoN0g2Q255?=
 =?utf-8?B?UHlWN3JmRlduWENEZkVCTDVMQUM3d2NHRUJ0bzVYZlU1RUhTR0VvUnU3SzBD?=
 =?utf-8?B?WDUrZThHZkEyR08vT3I0dHFhQ0JlR0hEREVNTkluV1NuYTEwZ1FjN0RKWFZH?=
 =?utf-8?B?TUJWR0tSUkVpVlFKNGFkMVNNaWRaSlFyVXdXcCtOa2VFQVFzRmd3M3daOWRG?=
 =?utf-8?B?bnBFWEtKU01POWRZQmFSNERlTDU2d29kT0RyZ1ZUL2lEVDdFaENLb3hlSlZP?=
 =?utf-8?B?MHRyNVF2eVo3dDNKaUxyaVVYNUdmQzlOb1Z3d1RpQnRNOXJNOFFHOXVYL1Z0?=
 =?utf-8?B?d3dFc212TXFvZmRKNk9DV1BTc0g1bThPYlBLS2xMYWc4SVdmRXFvWUdUR1g5?=
 =?utf-8?B?Q1IrRHdwRG5JaUFoZkFpV3JLYzhrNGNYRGlyYVBkMU1KbUtQT1VSTjhkMjdI?=
 =?utf-8?B?TGpVZkdNVFRTZlFza3dGbDg4TTNMOVJpWkVubHI4U0Nmemw1Uk5JbGxHR2Na?=
 =?utf-8?B?RTNFb3FUd3BNV2FxQWtaTXoxZHdZclZiSzV2QTNxck9mK1I1NVRzVmdQSWZr?=
 =?utf-8?B?b0wzT2lWUUNyeWtyRnpScEpnemxCNTNqbkgzN2wvcGRDV01lSzJvblFsd3JL?=
 =?utf-8?B?VUpiZS9Kb2hocUl1TnVhME1wWHkyMnFFR3liV2FsYzYycS90VGV3eHhSTU9s?=
 =?utf-8?B?YzRhTDRrOXhLQ3ZhbEZyYmVZNVVlaDZOcGhQSDYzTEhXZHFUc0lHZXAyZnJF?=
 =?utf-8?B?cVJQTGVzZ0dOd2t0R2RRcDBYekpOa3BJZVZkeGRBdXpnQkpOekF2QkN1NmlZ?=
 =?utf-8?B?MzJIR3BVakJlUTFvVXVQSXF4cjJ1VEs3ajdLUkQzS0JFbHhPT3d3eXN2bXZC?=
 =?utf-8?B?N2VYbFIxb09FK0dGZm1rR0dLM3daMnZEbG9EVGRLZ09ETnA2LzFKejJmWFJp?=
 =?utf-8?B?Q2trK0VhYTErdjVCOGt2TC8rSjgvcUFzSTVPYjJMaXhuanRSSk9yM3o3V1FV?=
 =?utf-8?B?R2JIZmRpa1VEb1pYeGRxVmVjOWNBSXhpNkNNUlB3bGZQUks2aVJTWUxucXE4?=
 =?utf-8?B?NzZxYWpXdUgrVXRSdUhWUnBBK3JHOFAyWUp4dXAxWnBZRVowdUZkUDBKV2NQ?=
 =?utf-8?B?NG9NUmUzaFM5cGNtVGNkaG1Oby9FUzBMd1cwbU9QVXpoSWFmeFNIM1Q2MTV1?=
 =?utf-8?B?NXdGYnNBM0xXZmg5L1o1cVBvVmUxV1RCZURaelpTa0dYUjZodWptL0k1dHk1?=
 =?utf-8?B?MFJKSmI2Ry8rc05XZXI5TUJjVitkVkt1WHZBY3AwZmlLNGhaVlJ6R1htblNK?=
 =?utf-8?B?dnh1Q1hPeDVhdFEvVjZOTXhrZDBVdzhyMWdMVDlFRHBUOHhjSjBwNGFkVUtN?=
 =?utf-8?B?WmQ2cVdheXlTTEVCbU9vdlZKR25PeDF2cHU5SXo2b3hJQWRhVzVBU215YjJE?=
 =?utf-8?B?Z2Z6Wk42SVFOVW9tS2t3ak9UUy9QSzhWVGN3Q3MwSkVpTG1Sc09MbXhjSmFt?=
 =?utf-8?B?aU5aWnNTaStqZ0tjNHpSNllvNEJIdHY1Qlk0MjZzRmlkZmk3K2VQeE1OQmRY?=
 =?utf-8?B?RG9rSkVrNmxIbUxTTWJsQ2VQL0pyRGNnSkFBVkRHQXNhNzU0Smx1LzZTT3NS?=
 =?utf-8?B?akRmeGwrazczUFkrRVRvQnMzUHlHYk5NNmkyWEpQMmc2aXhra2hvWnZ4NUlk?=
 =?utf-8?B?NWUyNkRxRUNzcmJWd3lMblZHM3dpTEZhZk1FODNVLzExZXVZY2tZUkJyOUox?=
 =?utf-8?B?b2dXOGQ5YTFRallzcEYya2VhejQ2bEFmOTJIV1E1d29xVVlxNlgzVS92djRK?=
 =?utf-8?B?RUZPTnovT0x0czJydy82akpqL2xjRWdmaVdnOFFHRExEc0NKbk9pRjdlVklK?=
 =?utf-8?B?U1dWMVZmeHNVZmlEN2x3SDN3b2YxMnE2Y1lUNHhuaWJLc3daYUhUL1dScEpi?=
 =?utf-8?B?RDREZWNOelJWVVB2dzNxUVh5SzVrdTlJRGIzQ3BOR0p0TGJUMFpSZXpmWHdN?=
 =?utf-8?B?V3dyTGVvWERoZERMR1RQVGR5bWNiemMwWGxQWDZkeUZ3VDhnakYwUmgwOTR6?=
 =?utf-8?B?d3ZRUU9EVzZIYWkrZ1RCdmxCMy80ZHFVMXdVd0JPTmVOWmpkV0VXckVNRmlx?=
 =?utf-8?B?UTZOelQ5NVF5K3ltTmlDYVhSRGNDMHhyQ3VXR25PQUYwaFJsOWtlU2xPT2ho?=
 =?utf-8?B?MnZTbmlhR1ZoQTVad0VFbTB0M2pGTFVOOFhZZ2h1M3Y5NERYVWpDUnBRbEtQ?=
 =?utf-8?B?ZkZHK3VSaHFVMDRIMnJhUlNpR3VJeitUSU9EeTN3MnRYNFBuNXpZclpkWFJa?=
 =?utf-8?Q?ju0q+GNVBGbum5A44k7H/mqgi6Us5hQI9joybffVt+FRX?=
X-MS-Exchange-AntiSpam-MessageData-1: 18f9NN6Bgdx0KA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a4c41-ff7d-45cf-6020-08df46b4a50d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 03:16:18.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 117Zfno2DXWsYhO4KsPXdVDvnuUwaepIG/6GzJWgi8aNtJUR/c6ELYW+UHjsX9LS/Sc1yirTEIyZ/vcwxrMMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

On Saturday, November 14, 2026 4:01=E2=80=AFAM Patrick Fischer via B4 Relay=
 wrote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> host1x_syncpt_wait() creates its fence without the internal 30 second
> timeout and cancels it only when dma_fence_wait_timeout() returns 0.
> If the wait is interrupted, dma_fence_wait_timeout() returns
> -ERESTARTSYS and the fence is left on the syncpoint's fence list,
> holding the reference that host1x_syncpt_fence_enable_signaling() took
> for the interrupt path. It is freed only once the syncpoint reaches the
> threshold, which may never happen.
>=20
> Callers that retry on -ERESTARTSYS allocate a new fence each time.
> tegra20_channel_capture_frame() retries in a loop without delay, and
> while the syncpoint does not move, for example with a camera that
> delivers no frames, every round leaks one fence until the system runs
> out of memory. Svyatoslav Ryhel reported this as an out-of-memory crash
> in the VI capture thread; the allocations in his report come from
> host1x_fence_create(), called by host1x_syncpt_wait() from
> tegra20_chan_capture_kthread_start(). The DRM syncpoint wait IOCTLs end
> up in host1x_syncpt_wait() as well, so a process that is signalled while
> waiting leaks a fence the same way.
>=20
> Cancel the fence whenever the wait did not succeed. host1x_fence_cancel()
> is safe if the interrupt path has signalled the fence in the meantime,
> as do_fence_timeout() then returns early.
>=20
> The leak was found with the help of an LLM assistant reading the host1x
> and dma-fence code against the call chain in the report.
>=20
> Fixes: d5179020f5ce ("gpu: host1x: External timeout/cancellation for fenc=
es")
> Cc: stable@vger.kernel.org
> Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---

Nice find, thank you!

One thing I'd like to add to this patch is moving the call to=20
INIT_LIST_HEAD from host1x_intr_add_fence_locked to host1x_fence_create.=20
Otherwise, theoretically, a dma_fence_wait_timeout error path that=20
returns before calling enable_signaling would with this patch result in=20
host1x_fence_cancel being called, that would go into=20
host1x_intr_remove_fence which assumes the list head has been=20
initialized.

Mikko

> Svyatoslav reported the out-of-memory crash, and he confirmed off-list
> that this patch stops the leak on his LG P895 (Tegra30). I left out a
> Tested-by so that he can give it here.
>=20
> I could not test this myself: the Tegra Note 7 I work on has no
> working camera path in mainline yet. Build-tested for arm and arm64.
> The DRM IOCTL case in the changelog comes from reading the code; I have
> not tried it.
>=20
> The retry loop in tegra20_channel_capture_frame() still spins without
> delay as long as the wait keeps returning -ERESTARTSYS. With this patch
> that costs CPU time instead of memory; how the VI driver should handle
> an interrupted wait is a separate question.
>=20
> Tool use (see Documentation/process/generated-content.rst): an LLM
> assistant (Claude, in a chat) found the leak by reading
> host1x_syncpt_wait() and the fence code against the call chain in the
> OOM report. Claude Code then checked the finding against the code and
> wrote the change, the changelog and this note from my notes and
> instructions. I reviewed the change.
> ---
>  drivers/gpu/host1x/syncpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
> index fe74ff6fc6f2..f9c871f218f3 100644
> --- a/drivers/gpu/host1x/syncpt.c
> +++ b/drivers/gpu/host1x/syncpt.c
> @@ -247,7 +247,7 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 =
thresh, long timeout,
>  		return PTR_ERR(fence);
> =20
>  	wait_err =3D dma_fence_wait_timeout(fence, true, timeout);
> -	if (wait_err =3D=3D 0)
> +	if (wait_err <=3D 0)
>  		host1x_fence_cancel(fence);
>  	dma_fence_put(fence);
> =20
>=20
> ---
> base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
> change-id: 20261113-upstream-host1x-fence-cancel-0b32753150d6
>=20
> Best regards,
> -- =20
> Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
>=20
>=20




