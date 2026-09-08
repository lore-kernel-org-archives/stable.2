Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010021.outbound.protection.outlook.com [52.103.33.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99157C9F;
	Tue,  8 Sep 2026 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837989; cv=fail; b=cq35nZOITaw900ETGB/StFmDhEagnHxQoJUO2tQB4WW7Mp2u7iXbUIYVyWde4CP0ma/XuW61/UphxeTNX8o4cg1nTQ/09FTPgnoa43HabVzfS6zdy338xxRcw+6VKv1SQUGXexzynig8jBINhg/NLoO5PXLYcnMf0UJWKVxAu3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837989; c=relaxed/simple;
	bh=p3n9b6TtH82OOeqN16QAdctR/As+SPZkkT/Z/6bIcUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkIQu/26394xOUWGkcKuuwlJZyQ3cio09h8S1x8eRfbd6FjjLL6IBLTuN1ueIW3LPyNI7eeKMuTuzStgLbYK8Wl3Temv7h47KemINR1VmfZYiB0YCYARtNn5MGpum/C2Wpp7ls7dm6qfMlKKbjD4f3cnyjn+EpXBG7QMQOTipDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=FhvbBdBs; arc=fail smtp.client-ip=52.103.33.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="FhvbBdBs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfIeWhDzma7OqTW79R7DVU39Vqbi58SZGPDZN7DMSLqEbhghsidQi5P5aBtSobmOkN4YulVO0GMPs8ipTWXJyfFm0teqOKK4Y0gx1yrK2thKN6/OrktsQGY08dk1LyABNjrNM20gij0VtiHCWAmPaMHYS1rav9DYfLe7Uf/5YcO4dymmHHN5u5CdnBq9ThgvpJ33W9j7wEkve8HpHpagzlpQFgGqZzBgPJDk88tLOUSyIODnKA7cy9guGX+thXDD0MbcLd1XJl1eOoFrmpRXzg1DhiEutEUMCSFC74Ny+brLqqUf7fsP5ZVrXwBkSiQdZJYHRGt0YPk44wUhXi7H9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYvEy1+85mtPLOOGemaabsH9jBeixK8M/HicGJ2rgL8=;
 b=EMzyn1TJCkl8bARCjsBucO+Eu5JiDLTjgQbTwwok28gzRm3nBFfHItaB7bmrf7rKZUzJpebWIx8K7XtrMrINLWMfOcgVe/DdbG/NtgRg9aWiWk3GDvbIUp/ebve1nXjB37i2vJ35m2WN7z6fPOCCaywjRhYMwg8/VtgohIynuPEv4aRa6okvKCBB3KNtSld34DYXEZdDHl+ylUPunh7Dzq6YaEuB0f21jpCpmKto9+Zw3FtatCGb44+gXsolYRMm6pa1ZCbtP4HYYvvLbLkaWjh4ruJqzsV1Rqc0psdls78D2RHHOd8GWlDuMyMdEDPa7xrrH0d/YmEeDE2pkSE0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYvEy1+85mtPLOOGemaabsH9jBeixK8M/HicGJ2rgL8=;
 b=FhvbBdBsyEfPwhvUEgKviMTv3+cI710Q7ND3QrN0Sltj7imDlNqIuL5zsnpntYynPqhOXslvJ2cfbyp/xPPRYwxgr98pevsbIaDniz93jLPgcunsIxHOTfK4Xn/RjYhYb0ompzXCcr8+bfcNC8Ts+/NcQLqtmgRSBHMWC/Xode6Cn45W6kViOyLN/nhH44lEKc9+wpNCIUKxwO0eOoy/uuyeZj7Jua39Ao3SUYog6grAbK5Qv3GHAAosNaKHYxfpmpDJfn4IbevMc7S46u8B1Tmk/ZTnPWAp51MZ9ejuWbrXnki9DurClWJ0msu29xh9XMuLSKjrWCe7YyCd9dLYQw==
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:1d9::15)
 by DU0P251MB0697.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:329::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 03:26:24 +0000
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35]) by PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:26:24 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7996: validate TLV length in mt7996_mcu_ie_countdown()
Date: Tue,  8 Sep 2026 04:26:20 +0100
Message-ID:
 <PAXP251MB0010F4199498BAE6B474D845C8B12@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <AS8P251MB0001CCE8D1BEE1F330D9E57AC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB0001CCE8D1BEE1F330D9E57AC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:1d9::15)
X-Microsoft-Original-Message-ID:
 <20260908032621.124902-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP251MB0010:EE_|DU0P251MB0697:EE_
X-MS-Office365-Filtering-Correlation-Id: adb8a546-8dda-4e49-a980-08df0d58f5fc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|25031999004|23021999003|37011999003|2604032031799003|51005399006|8060799015|15080799012|5072599009|19110799012|6090799003|25010399006|40105399003|2607281247196008|3412199025|26104999009|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWtJejNwM0NsTHBTYVlSSUxkYzB1WWU5bkxGWHc2dXdXNFNSRk5DRjAvUE03?=
 =?utf-8?B?YlFTTFlSeEdSMVNtcFd0dFhuNExlMzdUR0R5OVZtRmNidHdOMTFIWVpmcklQ?=
 =?utf-8?B?NnlJTG13dnJOQ1JVY0F1OWw2Q3pyNjJ1QmFjT0w3aC8xNk9CRHpYaXNxbVRI?=
 =?utf-8?B?bzJZa3hHVmV2aDhEMGd0aFM4NHozeEMrbHBXTlUvWmFacGdVaGhkcFVkWGJ2?=
 =?utf-8?B?cm5uRjhHMTIxV0ozbCtYTU1XNnBad014d0tnZ2RwZHUvcE5SS21wODcrdWN5?=
 =?utf-8?B?Y1VhUU84QUcyRVpOWlEwc1c1QlhnaUtzNnhLUFpCejRLOHlqSDRucnhOREla?=
 =?utf-8?B?TmE5ZUZBOGNrdmpQTTUzZFhUUkJaU2xXRk8zaXhKdjQzL1hVOEFpUXNpYkxE?=
 =?utf-8?B?TC8yaG9zOFlVdHdqaGVEUFJkREtvL002MTJRWnZzT2N5WTJnZUxiVGdRWGkx?=
 =?utf-8?B?ZXQ1dzdUWUR2TnZ6R29XTHQrWWZYKzF2cm9XWU5UL3NlajFnU0dRd0QwSitC?=
 =?utf-8?B?RW8rblpJOUQ4OFlEOXJZQ0JiUXhjUlZ1bnhueHJoSlFXTy9BMlVjZUE3bkFu?=
 =?utf-8?B?ejhaNG90OTNTQW1JYnFGbStpVHpFQVluRTYzeG51NnZWY3NuWm05SDh0a2dv?=
 =?utf-8?B?RDJwSjdhdVQ2cDUzMUFMVzJIRXcwbWtxU1pHSXNSSzNXZlppZVF3aVM1Q0h6?=
 =?utf-8?B?TWhseDhha25sRTNYUWNzcHY1M04yQzJhOWh5clMwOEc0Ky9ib20zN04rSnFy?=
 =?utf-8?B?ZGl0alcwbzlkdmU0TlhpZGtlVHI0VnNqcDVFdGdqZHR2WTRNdmZCTFZkWTcr?=
 =?utf-8?B?dXhVeWRHNXpLMndKQms0ZGZ3M1FJSE1XN1g4SGFYTU0xeGFmZEFsaWdaL2Jh?=
 =?utf-8?B?SE5rRU8zQmlxeGpvRStWMlE3QzRuNllaRUJ4bncyTVoxeURqUGhVLzBROTdV?=
 =?utf-8?B?RHZQekc0VnhVMGZLOXNPdVZKK2t1YjVEUmkyOHhHN3pEb3htdE9hRUdSdEJW?=
 =?utf-8?B?QWhwenRnRnVPVUQxVStNR2wzZGxYcEEvZSthN0g2UTQ5UEpING1JQVhuYVQ5?=
 =?utf-8?B?NG9GNjJUYjd3UFVzVXE2SGNMRzJadm5KL00wdHNWV1A3VE9VWHRnR1Y0WVpP?=
 =?utf-8?B?WjkvSDRVNVpQTEp2dnozYUo5czREektTSllVazJnVGdzUGR4Q2IvVDlmUkhp?=
 =?utf-8?B?WTdVTng0bXJCeHRkaDNFTG5JUWR6ODdObFNabnNMdlcvNlJ4T29xNnBLVENs?=
 =?utf-8?B?V2RVcmlQelV6K24rWS8zMTVzM21uU0t3eXpRTEY4Ynp4VGE1SzQ5N01lM3VP?=
 =?utf-8?B?eUYzTExabUZQSjhaWUNHUjZSZzRFcUU5Smw2bnZ1enhQaFcyWGZYNXBOd1Ru?=
 =?utf-8?B?dWlMci83Y2FsUndrQmpXaFBjME1hTmxMb1R0RlJWZ2I5SG8rajFtSFYreFdm?=
 =?utf-8?B?bkhOK0dRVW9lSXZHRXQ1SGJsSmh5KzZUTGcvKytDanN4OGZISWZQbitwc3l6?=
 =?utf-8?B?VEQ2VU9ockJINGtXUXk3c1NPcExqcnhsNG0xZGFqVy9PQ0lhSWRyMnduaTEz?=
 =?utf-8?B?d3J6UT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk4wd24ybEJ0K0dUdWR4MUF6QTJjUlRubzZQdXZGcFlHeHRvMXZ5RjNHemdJ?=
 =?utf-8?B?SXJ1RjFTL3FhcTVsZDhxTlNqRDVqUGRoZFB5ejQ1Ni9mb1kzd3dVYVBZcCsr?=
 =?utf-8?B?OXh4YnRvTUhYY3pDRlVjU0F6M25Tbnk3WDdmU1hVWTYrSGU1VXJyNnEwTmp4?=
 =?utf-8?B?TG82NlhEYmRXRUswcG9ySUV1cm1mWmFmK2RMME0zT1lNZ1pJTTF5TnAxQlVW?=
 =?utf-8?B?Wm1HOEx3bEQ1Uy8zbGx2TUR0R2QzbGJpYWVCcitOcUxEdzdJclFxYzcvM28w?=
 =?utf-8?B?VHlWajVDNUZ6VnY2RTBQb21COHB5cVFoblpsb1hhUGxMS1lhOXh5cGI5NlQy?=
 =?utf-8?B?djBkeUQ4VXBUSS9DRlkxZk5JazRXN3YwVTZQN3E0ZGxNMXM3YVhZcTYreDVZ?=
 =?utf-8?B?eTlOa2x6SDVNWGlVbTBzdUo3aVo0RWlDdnlDSlpUTlQzRTNMU2RSYlRkeHQw?=
 =?utf-8?B?ZUVPRnl5S25jemxFR2tuZFdPbkxxdlBoS29QalFaWkxYMXFYZmZRY01jeVk3?=
 =?utf-8?B?eVhtemhHZjRnTVVYS1JPRk4rcVMrclMrRmJVVzV4c1FHSHQ3QStCM2pVemlj?=
 =?utf-8?B?VVNIVjNqenQ4Rll5cFpmS0dwU3BFbTJWTUs3SUtZK0lBUE9xK09paVdCRk9s?=
 =?utf-8?B?OFhDczNPL3JvSHlydHc3MWx3UkNxUEduTGp1djdJODFZamJCNDF2LzhJVlU1?=
 =?utf-8?B?YjlVVWRTcmZVci9lK3pRM3pzUGZ2REU2Z2Q1akkvZERYSDhPUTdNM0plYnph?=
 =?utf-8?B?ZDE2d0FJOGhRNDZLNXowRWk2VlJtZGcwOFhHLy81c3lvWnZvNkZ4SnBjSG5N?=
 =?utf-8?B?bGp0UFNBc21LUFBleWlMZEdtTDE5S3FpakpMKzJ0VGoweWt2T1BYNEVFN3Nv?=
 =?utf-8?B?ckk1ZmU1UThoeFN0dkZvaWI3dG1WVVhmZG9lQTcyb3dVU1NOem9DNzdhWTU4?=
 =?utf-8?B?a1JPZHVHVStlUEJtc3BZQlJVR2pMbk5HL0NjT3ZSQWt4MHVCR2lBVjdtZ0hl?=
 =?utf-8?B?MDRmM0pvRjQyWkFSaWM1N25hbFI5UStaV3c3OU5yU2xTbURTSGJQZi9DYndW?=
 =?utf-8?B?YjljQjNOZVpibUo5d2VBSGUrM3c1Tyt5UytZU1htekVxNGEvbVdrSTAzeCtr?=
 =?utf-8?B?S0E4L2x1aEwxZ1d0anc0SlNZL2xvZWZkWG9Vb0podk8yUlBlcmFITmRqT0Rq?=
 =?utf-8?B?cFExKzRjOXdxaHYwVjVuZDNud1Awa2swejVZcU9tb0hZN3pDVVVVWk40dHhh?=
 =?utf-8?B?bGVreS94eHdra011VDdVVDBpOU92dk1SaGJSajMxS3BRSEt2YkZieGVsZi9z?=
 =?utf-8?B?VUxtRk9abG5PcmdyRUFrcFhPODNlNCtKK1N3YXpIckQyTnFaM3RqRlNvZEho?=
 =?utf-8?B?RjY1VTh1V0hUeUsrL3Y3N1BaUzJQREswKzlIQnVIVTZ6OHZ6RFhLZTZueHJO?=
 =?utf-8?B?eEgyQURldVd3RUV6c1VTN205UjhJOHFpeUxBaW1lU2ZwSmpnVndNOU1rVWdE?=
 =?utf-8?B?ckRsV09iWjNTNVgvZzRURVlBeHllRVdXUyttQ2RCY2lxM1BocHhLZExUbVNG?=
 =?utf-8?B?MWVhYWZSTWJxdmh5UWd6aUdXZ3BiN1JCVndIL1MraS9PU1R2bWs2OXQvNnov?=
 =?utf-8?B?YXFmSy9Xb3loNUI2cThwRG1jU05MM1J6alZ6bXhzVzY5ZkQwbEZLaFA2WTFW?=
 =?utf-8?B?a1YyMllQb0Q0QlJiSkZXejhZcUtsd2hzZGduRWFXdWEyTnBPN0kyN3ZsMzQr?=
 =?utf-8?B?ZHk4bHpGVlFFOHFhUjlQa0J3dDJTbFZpWncrMWZTQWM1dkRSUFVzRWRxc0dj?=
 =?utf-8?B?VXgwbm1udWdqOHhBYzBkSEdMS1hHNHhHWkcvdFpLRkFFVzBTMUt1aWZZK3Fj?=
 =?utf-8?B?OHJGY0RSV2dScHQyb2wxR0pqT1RQVWR3dUZONUM5MkNSeXVaMGN4K214Z1Rz?=
 =?utf-8?Q?U9OlfKT+MTUl7o0hbwDGQ5Dj0H2tGDgc?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: adb8a546-8dda-4e49-a980-08df0d58f5fc
X-MS-Exchange-CrossTenant-AuthSource: PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:26:24.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P251MB0697

Please drop this patch - there is no bug here.

The existing loop condition already covers every byte the body reads:

	while (data + sizeof(*tlv) < tail && le16_to_cpu(tlv->len)) {

struct tlv is 4 bytes and omac_idx is the first byte of struct
mt7996_mcu_countdown_notify, so tag, len and omac_idx all lie at
data..data + 4, strictly below tail. A length smaller than the header
re-parses at a shifted offset but stays in bounds and still advances
the cursor, and a length past the end fails the condition and ends the
loop. The zero-length case is already excluded.

The mt7925 commit I referenced fixed a zero-length hang, which does
not apply here.

Regards,
Aamir Ahmed
