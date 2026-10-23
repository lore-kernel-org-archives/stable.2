Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792745685;
	b=4IDqMt/Xf7kCzCBXiWWz+v2hNpA/R0/jFw5tlPkSrnZcHe/Hi5xBxlzB7mIgpzUHAiWV
	 o+q7/qUPPVaQO2zo24vMdhVjQHgGogG/O6F/7gpWS7rM5KCV/rUBmE2cPrjIUzmERx+SR
	 4qsNEtgOmGYIZzyrNZdH6hX30z1ir7PGZiIFV9ufs0j6qKYsS6N22ZstS3/oaVfMMRjRM
	 LOQraQQGedlpXnEAA5H6Fvp0g9kxC6sOC13A2m+tk0wLrEi/8PWRrfDLDeHRABD+kjtJ6
	 6tBkos7Fc+/CxuF0wD+zJI7BtEIVXofzbncio4gS8INmhf5vW8e++rUZ9IZtgAesbpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745685;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=keS+Mb2+kayankKoQxT0EtUmES+ls4hsXkWi8D4VIlc=;
	b=ArdEuG8NgpJAPgsFEKUkmD5jcYSDUa2UtRjS9z9WyFl20Mbsjjk2ERgLhAaVN+l2xu9U
	 GgXdnrWWHGChuH8QjCOpmS5bENxJO0VcON7NjprxeBiDaPDmz5wpIchlBuspvU1LnQAI2
	 3HYy70O3SNdwXjRpUc7s+36QZ48y9+nT6vtH2cHeazAs10rodZdKVQDYbCZb0cRIssO4O
	 +r1xzAZcNyx5yloJc6Sm3ZIpieLpBQuHhHL/mfEejRBjs8aW0pznXL3zywciLDMQYG0I3
	 w3/JJUJcfXh/qlYYZdiS6avBtJNQQEbR/I2KyngYzI2Eval0d6L137zM5w5BqPaVOkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=GrB4qDoY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.75
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013075.outbound.protection.outlook.com [52.103.43.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D364606A31A;
	Fri, 23 Oct 2026 08:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D364606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=GrB4qDoY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTkQXdV2Bfh5ilmv4pvjbdcgFcIZMStJggl8dI/BZy1lFwcNz4NOILyLNhdRVKqMYfBZ9qsUBWhG1piBxUJ/WcAemmvgibsHCCJD+RQijwto/S3LlVlvgibfqQ54kUrVA33Vf/pXwJKn7WaKAHKPw519BQKq46pQOCnTVss2CVG76WqXJHsHnLE/RWyRpYwwzI7ipuoppahQJn4Z61z+SCZDq94Bzub5bRADNSonpLVJhYHI6mi6MCYdvbhXmiJ7T4AbHpnA17Q4Agx/PTzBJpkAliwY91EEALXx36li4GFyR/KcDvN7k+eJCqIOKafIc8U6yY6b66wpLH6kCquAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keS+Mb2+kayankKoQxT0EtUmES+ls4hsXkWi8D4VIlc=;
 b=Gpz/lVPAop4/8lzW7PvzTvNNcGxbVIbda4tDvnDZwT0kjjmV7p7Az5URcAQGxfgESg+KIJ3an73TfbtBYB9cqbWRVUv3RtNUCxEuM+3gdKU15WCbJHcX+nSUly2rAui+kSP9aqavOROln5jEh7XqwHLVqj5qH9c+DPWyBAo/XBrcFEq55ZpLv11uBbAekUDw2bG5BI9+mH0w2y3fnOxmxgnTYIWuqBbk5jSxn6t+vnm8pvotZSeM/iP4GHoz5RH5hIGtElqTKmGJtPeOdjJj8u6dkGtYWtoDPKn15WpTqSXpYI+R1/ree6EXOf0OLzAT+2CbwiLsnS9Qz19nV4X5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keS+Mb2+kayankKoQxT0EtUmES+ls4hsXkWi8D4VIlc=;
 b=GrB4qDoY9HPrWixZBQJuTsOlqlQ9/BqxElu3jBMCr9uFhUESv0zraAXEVJ/+lehjH3meF3XqIoIn+B5o3NL5cxvVGZjtFlW11YHCz6x6/n8uMAO0H+KyyDSzkOIlGjzVzJTQgalXNjUOWr0jXLdnsH6kKofiNo3eIcweX4dschLIL6ON/t65sZh30v/mBRy8Np1TGnu2a8X+7OwyyJEndA5sTnlfHlA15Oje7eE/OpWHWu5RTicqA94YdSBCoDmnUNKJQEqOV81CHe8hzWl2GSHKnd3xu5G4L1+ppnNDihdoGZV4o+bhAL+W6hx04IQixKV4hRNW9AdVrqih0Kgf5w==
Received: from KL1PR04MB7484.apcprd04.prod.outlook.com (2603:1096:820:121::10)
 by KUYPR04MB9655.apcprd04.prod.outlook.com (2603:1096:d10:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 08:54:39 +0000
Received: from KL1PR04MB7484.apcprd04.prod.outlook.com
 ([fe80::9def:492a:962b:46d1]) by KL1PR04MB7484.apcprd04.prod.outlook.com
 ([fe80::9def:492a:962b:46d1%6]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 08:54:39 +0000
Message-ID:
 <KL1PR04MB74849191EAE49D9DBCCD2BDEF3642@KL1PR04MB7484.apcprd04.prod.outlook.com>
Date: Fri, 23 Oct 2026 16:54:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Fix double free of the split page cache
To: Li Jinyue <jinyue.li@linux.alibaba.com>, kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, anup@brainfault.org, atish.patra@linux.dev,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 wang.yechao255@zte.com.cn, stable@vger.kernel.org
References: <20261022025248.477832-1-jinyue.li@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261022025248.477832-1-jinyue.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P301CA0043.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::6) To KL1PR04MB7484.apcprd04.prod.outlook.com
 (2603:1096:820:121::10)
X-Microsoft-Original-Message-ID:
 <3bd6586e-777f-42b9-86b9-fd267a98d971@hotmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR04MB7484:EE_|KUYPR04MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d78590-9a06-4ae7-7ddc-08df30e3458f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|24121999003|5072599009|15080799012|55001999006|22091999003|8060799015|19110799012|19101099003|4140399003|25010399006|440099028|3412199025|12091999003|40105399003|52005399003|11031999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDJjMVp2c1YvTzE2ZTBSV2FnanVOUWFvNi9ZSFZiajBoKy83aXEwT1paU2Rj?=
 =?utf-8?B?TmRUM2d2NWRsZGpGVVpYdTNIZlh0RmszRHNFNWpmQm8yVXJNVmtxWW1wbGUw?=
 =?utf-8?B?OEY2VHdHcldxUXM0NWlrbDFGWTdJY1hHSERsZHBid2VORDNTa2IzV1VVd1dH?=
 =?utf-8?B?ZFlwdi93M1VXcHhBN1FyVWNZbEE2VktZT0VvRXhYMC9TSCtmdVZjTjZLVmJj?=
 =?utf-8?B?UUtPZnBKN2JLMmF4UVF4M0F0UjNlVU9wK2k2ZWczd3V0YXFiY2UvWC9HQlNF?=
 =?utf-8?B?MFV3RElBZ3BiMDVTMklob1hKOWVsbkZjU1dvcmNRZkNzR1VVRVhEUy9nS3FJ?=
 =?utf-8?B?YVZuQ2ZXWmdSa3VWRmhtZ1djRTBFK1hBT0dkSm8vK1dzRmxmVWQyN1JFWUM1?=
 =?utf-8?B?eEc0eHIzUkdjMFU1KzRVZHFlNHFHQXpNbWtHKy9xelZLVHZkYnI3RC9FSEFa?=
 =?utf-8?B?aGUxNC9hYUxOZU9MWlRUTUdjOWlzSmRhSExKRWhRZU5wTENXVWdHSllXckxJ?=
 =?utf-8?B?SzJHRjZtemxyVVUvaTVyakxwS05NRDNRend2VzVQY3BXNS80aXkzdlVUV2pZ?=
 =?utf-8?B?am94R25JcDdiaUFCc203cGRaZU5QeVR1dnlGVGZtNVVXZTg1UnlxcmtDVkdz?=
 =?utf-8?B?d3d4WmkrUkhOanBLZW5jK3RsZDRVQmFUbzE0OTErVjUrTzdjcFpYUmQ3clV5?=
 =?utf-8?B?WmdjcWIyUTZNUGw1S3JoYnB2NDI1VWdSTlBPcHVaNE9ib2ZuWUZtczkyYXlK?=
 =?utf-8?B?TTQxU1dJSUdkNjVHT25GeURYR1FDbkRmMUZtY01TRDBMS3kvOWhWYkhXZ0NP?=
 =?utf-8?B?SkNoS2tKVDNaZnZ3bytObHN5UGQ0V2dIRnhYTTNML05tWnpKQlNhZU40NFRG?=
 =?utf-8?B?MVhod21vWFZtT3VGdDRZM3NXeWY5eUFldExQSUZjd3FaVUVGUDBweWh6cmRq?=
 =?utf-8?B?bkppUCtSTTRRbHVQVSt4ck10Rk15bEVHejREY2dzaHU4WitMenVsdHFiWnd0?=
 =?utf-8?B?dFdqbVhYdkNtSnlTYTlXakNjOUVCNHRJbnF0WEZWRDVPdVlhZWxvSGNWVTlI?=
 =?utf-8?B?VzVjeXFxeTBMWDFvYVJnUHVnOFFXUFozT0ZvY0RxTkpsWEZlc2xJc1BLQXVY?=
 =?utf-8?B?NnFSOHl0bENZbmtVeHVVYndDQTNma0huQklGTmxsa2FBSnNkQTVnNjNud3RR?=
 =?utf-8?B?OWg5Z2FIWlNjRHFXc2FIc3NPaWVxWndpVVRGWDdrK1I0bit2UlMyUXgyR2hY?=
 =?utf-8?B?dTlHQThUTDczK0RyUnI5bXZQRDBBQ2tHM1hnaXNTL3NsUy9md1FZUWw2ZXpK?=
 =?utf-8?B?Y2V1d2lqSUFRdmd5bEFySGN3UzNlem9XWE5TMWM0WTJLWUJQZzhWMVZkMlJO?=
 =?utf-8?B?eXFER3JzclVVMWZ6UUNsaUtjbG5tMXdFT210NGFnaW5ldldkOW1wNWxwUkZq?=
 =?utf-8?B?aGRoU1VENm1YcGJXMmNEbDlSTlBibVBBOWNQWkFhTlV2M3FtWXQ0T3N2VjE4?=
 =?utf-8?Q?31GFGhRsGebwkSdUXqg6N1dW1XY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVlyeXYyeW1TblZkTGMzZHhYKzBVeE1zQjU5ZXJWNExWZTBabTZCeDhHU25i?=
 =?utf-8?B?dktjR0F5QjdNT0lZTkdWQ29wN3B4OXdXbDBoWHV1UnZiTGVVZlMzS1ZqVHNJ?=
 =?utf-8?B?SXg0UVAreXVHSlpVaDl6RHMxSmpnbTdBV3BkVFRFM1ZrVVhJSytDUWJTclNT?=
 =?utf-8?B?QkJGdTVZbTc0YTZneHZ4WmhDczJ5Q3FCRTUxSklZY0pJZWNPb1FQTUJVRkNC?=
 =?utf-8?B?SVJkV05nc1RCMEsrYm9ZcWNTanpFTktvTGhjOGtjWG9FUlZYakNLMkVzSXkw?=
 =?utf-8?B?SkFiRDBOV2VVVWNNenBUOHljVkgyODJsTTRYZTJKd1IxN2d0OWFrWTl3cjBC?=
 =?utf-8?B?TWtEZUpWSkZhUVlqQlRxeGZFZ3V4N1QydVg1QVZvRVJyZHlTRHZMeW95eDR3?=
 =?utf-8?B?Qm40VWZMdG5oSWo1YWV5WUwrTm5va00rZ3NOdWszTzRGVWFyTDBFaVFWL2px?=
 =?utf-8?B?Mk9MMzJaSG9BUVUzckpJL3ZWVlpxMUpyaFBRVHJXK1Q2SDJwVTYxME8xcEFi?=
 =?utf-8?B?clk2NzVYS2JCcW0wSDdidkNjY2UwUllTNUlISU9RR2lLMlYyd1FxZmM3L09m?=
 =?utf-8?B?SEN0UU4vbGE3czNyZmtnekRMSW91bEp6NkJSTlJvUS9YQTlKZ0dFYmFNRmRJ?=
 =?utf-8?B?aTZnYlFITVh6TTh1U1p3Uk9pT1MvV1hDSWQ2RXpTSzcraTdjVnFFYU1NeDQ0?=
 =?utf-8?B?NUNiZUkyVURSaFJEZFRlWmxXVjBUNnRKZy9QNlZlcTRQVWFZOVMyZFFUbUJV?=
 =?utf-8?B?NVJRYjRFK3VEbnJNa1QvbGQ0Z2I5dHVFSUEyNE9pZnBNdEZpS1hVbWZFeVcw?=
 =?utf-8?B?dGFDa3Z1a3V6S1JkdmpEVzRraWhrMXRsNmdWdktHclI4ZE9RSHliekRvQlN0?=
 =?utf-8?B?Ujc5Yk05RVZ4Z3E2Q3RCcm5iTE9OSjhzZU1HbTFGdjdRZ1Vic084YVJLdkow?=
 =?utf-8?B?ZHk0MlhGSEdNa1BUL25uZWcrd2tQVFNyWnBQc3RzQ1A4czMrTDdqS2RveVht?=
 =?utf-8?B?RGJMZTZFeGhkT1paTTZvN0p4VS81YmdVWXNtdk1nSGRwRFhwbW1WeVZxS2Ux?=
 =?utf-8?B?dzB0Q1JKR0ZpN1owVmJnWUlrYzdWRnlSTHY0Si9na2xoRnA3T2ZaSGh6Zmdw?=
 =?utf-8?B?OHRNWkxxVFRncGdnMjg2dS9GYng1Yk5uTElnaFhYVjJ1V0crQlh5cSs4cUVi?=
 =?utf-8?B?SmVWUlMzckFUSHFMWEIydmJ6Wk9tR0srNkZleG9oNURRd1cySExHWFE4VndR?=
 =?utf-8?B?aVJmOWM2WXc2Y3RJVS9wVWkyRWRkallEWVJyY1RsWVVqWkpzcWN3MmUwKy9F?=
 =?utf-8?B?dnlDalI1NzlJR0ZDZk1rYzJ0ak1WYlpLWFlsRndOVWFwaVhadEt2SnA3aVNs?=
 =?utf-8?B?M0laUldISUh3T3lVTTFZYytUR0dLSDQrQjROL09XbjRtMXRkOWlPdVFUdHk1?=
 =?utf-8?B?akt3eXBqRjFRaEVLWTd6OHNVcW9QWG9ManZWa1dkZ0duTkNUcERHVFRZTHZR?=
 =?utf-8?B?NzZlQ0l0QmxuN2VsVUJtSlE4MkFrWFErWENyaHQremZxQnd6ZFFFLzVNeFlq?=
 =?utf-8?B?Y2lCODZVTXVZQkY0dzVoWFc3U1BnQlVTRjIyakVJSGpxNktWaDFRMCtaS1k5?=
 =?utf-8?B?c0RaTXdaL0lCUUZkWE1mWFZsSHEzV3JMUHRjb2twOG5hQkNsT2V0RThvMzJq?=
 =?utf-8?B?Mi8vb0tTT2lIUm95SUc1ZGkyS29XSU1rTzlpYjNaRXFsUHNZblZ1OG9mL3Fn?=
 =?utf-8?B?T0xXcXRSNlBaTWdrblFqWDFpano4eGZSUEJGNTJUc0U4dUpqR1Y2V3RuVmVJ?=
 =?utf-8?B?cnlWSmVPUmk1cFFIcHkrTVRqYkdJb3FndDdOWTM5dHEzSWpFd3NYVTJ5UlRM?=
 =?utf-8?Q?aSRYZ7ME5iG+1?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d78590-9a06-4ae7-7ddc-08df30e3458f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR04MB7484.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:54:39.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR04MB9655


On 10/22/2026 10:52 AM, Li Jinyue wrote:
> kvm_riscv_mmu_free_pgd() frees pgd_split_page_cache after dropping
> mmu_lock. It is reached from kvm_arch_flush_shadow_all(), i.e. from the
> MMU notifier ->release() callback, which can run concurrently for the
> same VM from exit_mmap() and from mmu_notifier_unregister() in
> kvm_destroy_vm(). The stage-2 teardown is serialized by mmu_lock and the
> second caller finds kvm->arch.pgd already cleared, but both callers then
> go on to free the cache, and kvm_mmu_free_memory_cache() does not
> tolerate concurrent callers:
>
>    BUG: KASAN: double-free in kvfree+0x28/0x32
>    ...
>     kfree+0xc4/0x428
>     kvfree+0x28/0x32
>     kvm_mmu_free_memory_cache+0x178/0x246
>     kvm_riscv_mmu_free_pgd+0x20e/0x2b4
>     kvm_arch_flush_shadow_all+0x1a/0x24
>     kvm_mmu_notifier_release+0x36/0x7c
>     __mmu_notifier_release+0x182/0x66a
>     exit_mmap+0x7f8/0x8c4
>     mmput+0x7e/0x2fc
>     do_exit+0x57a/0x22b4
>    ...
>    Freed by task 15956 on cpu 3 at 8926.103524s:
>    ...
>     kvm_mmu_free_memory_cache+0x178/0x246
>     kvm_riscv_mmu_free_pgd+0x20e/0x2b4
>     kvm_arch_flush_shadow_all+0x1a/0x24
>     kvm_mmu_notifier_release+0x36/0x7c
>     mmu_notifier_unregister+0xf0/0x328
>     kvm_put_kvm+0x32a/0x7b8
>     kvm_vm_release+0x3a/0x50
>     __fput+0x330/0x974
>
> The cache only feeds huge page splitting from VM ioctls, so it does not
> need to be released together with the page table. Free it from
> kvm_arch_destroy_vm() instead, which runs once after the MMU notifier
> has been unregistered, as arm64 and x86 already do. The error path in
> kvm_arch_init_vm() is not affected because the cache cannot have been
> filled at that point.
>
> Found by syzkaller.
>
> Fixes: 6c7f75ef096a ("RISC-V: KVM: Add the split page cache for ioctl context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/kvm/mmu.c | 2 --
>   arch/riscv/kvm/vm.c  | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 3e955d808743..74dece22d172 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -798,8 +798,6 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>   
>   	if (pgd)
>   		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
> -
> -	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>   }
>   
>   void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb76..a7e1b518257a 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -54,6 +54,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>   	kvm_destroy_vcpus(kvm);
>   
>   	kvm_riscv_aia_destroy_vm(kvm);
> +
> +	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>   }
>   
>   int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
