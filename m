Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794336320;
	b=w6KtRL5lWzM8+ILGH4Kvjpw6u96bPTg6Mg88EIwddJduu2fBE4SI0gwdKduz1Rqkzr39
	 O30OpDsVfZXGjoI0rh/PISLOHSU8zFYduM75MVDXLZPolsFQdr7ZoXC/OxHnwkXdH1gw8
	 4tdtTROel+muqTEovC6fLcnb1VaC85q4QgLayEPiXn+uQ1IsY7nKW3/6d/TphKpJKebqb
	 FnPV7YFGioUoqEGauMRtHUx6gd3O0fR8mMoUyL+3lhXGGsNllYLXeZfijGsQtn/GNAP5M
	 mabtXQSARHrXSEqhwONjjb7fvRD5vE32yrN0R5BzBOIdaTmyKkEGsmKMyHpn7yjBtAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336320;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y2Z6p0rnvD7QyYzBSAZx7M3Vo4KOHtLkKcIUDQHbcUM=;
	b=fnaD/oGL+v0QhNetHDfh0fgA3kCmnCjoitSJ8rPXa4Sr7mZokOU/5POlrxvrlcn5cJJE
	 xYF/Mgu1RNS/t4a4HUsR4UcdX0zKMlI7q7xp0u+XvxjSqz87ftoM0rFWYQzKBfQVrw5/x
	 zUveJAbYoYrS55cZq71bbt4Uln+cmu3QQk4t2oxRdxA8iQXK6HRPbh02f271Ok1EjWfWa
	 aHAqLXBkHdgj/xC19wIaXfS01FBsSvNv0ZSCHp5Ja/1OUjLj13VPz8MIpibKAgsWU+Iqe
	 BD3cHfUjZdBNrYaCuGCngWgYPsqjUAB/awxcnPShNmZ+mZjvrJaKGtE+EotLNKIkS6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=t+GxU5v4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.72
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020072.outbound.protection.outlook.com [52.101.189.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D27606A326;
	Tue, 10 Nov 2026 18:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D27606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=t+GxU5v4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHV9ruAoBdlB/uuqo8l6GCkvvTlXf3W4yWR2YjCIiLW17nn10fo7gysxbSjqiXpcVJy+x2hI1r4q3qVhZX7Zy1ArQNotcKcPCJmWsZhFa3RM3rU7N/sQzrlTeSfngKOPXzmmtzpDFJM6g/PboJrW9GuBSYksrqQiSsk/7q7JVvadggXSlQGcdCKIA/Db8WpQc4dHsGJSYqDIGEwZlshwtjs2XqwXYfFv2a+zI+WFvzhBss7GcmxZTcsg0r/q7HwVthHwmKHlxFB02x2iBCeWzL5X3mw8YX/nImwUoZ16R9fwvI/ipoybnApFkAjeYtqiprldQhOzYKvi6CcuEbWJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Z6p0rnvD7QyYzBSAZx7M3Vo4KOHtLkKcIUDQHbcUM=;
 b=DvBe7STMixEx8M6pmAfPODDHG4ogKbUkrargw5Nvp43L+Wv4qgL6mHc05nko+YlCeTTDxfXl0nU0B29Rq87H99A/my0X7CzDMqPxWmZeLIJciI06xhhY+n5ysRb4z8rW4rib4vIW0PNowWv05VkDAmpuFYHWI8ahm/ISdpgoQZJ4DqymZ2yy/W6sNgcT4p0iejeEySXyigUUx2rx+lX0XSDyuvNoHM63z6GahudFYhK6Cej92leH4E/Xh75mWXkpW4uy5TSXWbi3M23810nwK0LvR7aILdRHWzr+fJC4UgbH9ppGzghNEeKs8tKaWtFa5d+C21Ujj5kmnU7zaF8osA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2Z6p0rnvD7QyYzBSAZx7M3Vo4KOHtLkKcIUDQHbcUM=;
 b=t+GxU5v4EEBeb56QXR9eH/SjsdlHOctEjpen6CARCTUVWxZJlqaa+h9ra6YqWY8AQ+bDdWOVSzZA1VgRbnXJDw8Al9HfM769CRVWzT5SPr9qZYCVGWN9TF5yxbosL6wcAH4OJjudjbbiEDtPpNP+oWQ2rzFkBcR4lkbZAS2PXRRW42jr9nsrpHBrH3gzsbS4gRGaKqBrl2EsmlTJxeBJyLhsFo0Nrty+pbtj9SEFzaM2lWKtHsKatepxjjg0zjiw5KyjkW9ozXypvuoqlVplqXk6/sLGVZokLF/HGt1JIs76jL/2FgAoyBZbZrQtnmCjm8XHPuZ9i7yssPBQqQqpBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB5210.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:62::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:45:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:45:14 +0000
Message-ID: <bd1a4a21-bc1f-4a46-b6bb-80a76ac48814@efficios.com>
Date: Tue, 10 Nov 2026 13:45:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/mmcid: Synchronize MM teardown with affinity
 updates
To: Weiming Shi <bestswngs@gmail.com>, Kees Cook <kees@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 stable@vger.kernel.org, co+cab19e2ebe4d535a@bugs.sh
References: <20261110183809.3308868-1-bestswngs@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261110183809.3308868-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0421.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::23) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b9f1f4-90f3-4510-4df2-08df3f5ac1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|921020|56012099006|261026140227099003|261102123227099003|261009223027099003|261026121527099003|261022113327099003|261021135927099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YrogJPcz+qT3W4kEGmquMIsLmRldv5xCW44R0eiSwcn81nxk5hrRh+9PI0zDP8sBa/vK5EN/Suog3ul1ku998oE7ymUiuwGfI9pkdNrhXwCS8UoONdA4Ukw9u53Z7YqHoYSEJKpxWEc1NsIguLHp5Zn1Y0VxIJbLC91uWJS3uL7CdSCj3vnIr0ueak/FXLjl/zSwBTnUbpf3l6CjPE5Jjw10GTYa75FPytmAwH4+Im3H+YQDOLUsWwgZAngEqysaBs/QyJhu1ec34cRCahhkKpMYLvDVeHxGk6BHVrcMsydFhMibHJWicxs3p1Nhtt2BuTx7hqa0hKyG6kNXXiB5Br0GiUXBiEtBTzYuO49os2yiJTRaMHHBL+Nlok9kSsUsP+OCE2/Sp/6yOOH1cPXoGdbOOPIOGoCQZPw1njxgGq4MEwmXgsNyRtpFnfE8DyRmdbGeMkWMcECL0osMt45ROAdYahx7td+m0RFC2rWrpZO91Qxx6G/4USuso+HJArnwWQmkHcElfqTEd0ybuC3IwpnPINoNsiPXYiYOna5KjxYD1c0jpsXDg+ETKSPWX7lbej4/BqL2Yk2n3VJCTRUX5TEsFkyiBNsnCOFoFhyI0c5kzd96CDOWV3nZR7UOjA8WXMu2Jbfn/AO4dgpYXjv81w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(921020)(56012099006)(261026140227099003)(261102123227099003)(261009223027099003)(261026121527099003)(261022113327099003)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZENVY3N2MFg0N2NZalJOQ1R2M1cyMmhXTkFWcEZtUUg4TG5NRGo3TDBCSDhi?=
 =?utf-8?B?YURXdkpXNGdhZjFHaUc2SGQ2OTNtdlFESFJlWFUvL1N2S0trSkMrZXBrWTNY?=
 =?utf-8?B?TVNqQWU0ZmJFSGthcm81TFZ5T2RGMGlwaERnZXRFbEpWUVRBdkhYb3c3OWwx?=
 =?utf-8?B?ZEJWdk9nem1jQi9waFlxcDlFYW9uR3FJZ21LRnBKUFZwejJ0ZUFjaWd0d0Mz?=
 =?utf-8?B?N1hPT1NrNE92WW41MzdoVkh0dE1TM1NaQmhpUW16bFVyT2RTbXRZRHYwM3hZ?=
 =?utf-8?B?RnRUMEJrWTZNS2c4SklHeEJ2cUlkdUE1eTRZMzYzSElvcFB4NXJwK3dvaUJy?=
 =?utf-8?B?NnpqeHBHYXM3WDhuUitYT1M4anZVL1FIUHFUMXl1RjQwaHN4RlBsaWRibzB2?=
 =?utf-8?B?bjJiWVRRY3l0aXhvemNmZERoQS9hNTRyYW9wSVMzSEpqUW81eFZVeFFyejJ0?=
 =?utf-8?B?YnM2KzRzU000QWkxdFBXSFdOSkZKVDB4bm9sTllvbWRZeDJhaVcyekhPV21U?=
 =?utf-8?B?bHlteEQxU25PTGc2U0dPbkZFemNqQ3VZVktwUzlETC9XRzZEZ29jc1NQVTJX?=
 =?utf-8?B?U0RubHRJU0YyWnVCUmJmR2EveDVKaWJKQVNIMGZDZGk1M2xsODFQdEdhNXBk?=
 =?utf-8?B?VVR2eVB4L0VlN1N2eC8wYU9kUVlJNnZaUVRpY0VrU0J4QXZCMXNPbVdQRStj?=
 =?utf-8?B?SEZZVVZycTF1L0swQ0t0N0NZVmQ5a1dYb2xxMlJMSUZiY3ZveTVvUHZXVjBR?=
 =?utf-8?B?R2VZWjhFZ24xSktVMnJjMWtsTjc0Z1JkQ0pPZVlGVUorNW84elRicGFVKzk5?=
 =?utf-8?B?ZFJtVlpHc2srK2YwWjVIaXNWUDd6RG4zS2I5ZFU2dlVxd1p0MGhHeXR6TjNF?=
 =?utf-8?B?azM3dmpqb3hzYmlBYWM3aUxneURiR0lCelFBWWUxVm5nWUtBOUNWVzlYOXh6?=
 =?utf-8?B?YzlJZEp4c0N3emZKOUg1S3ovQ2FKYk1MOEVGM3NaVU9vUkZ2MWhIY3F4ejNx?=
 =?utf-8?B?RGNPdGp0WkJ2dmFtR1JaMTFTWHVPVGJLbUhFMmhzU25XYXpKK3Z2ZTlBa3Ez?=
 =?utf-8?B?NU55K0pYMFRFUlNWb0VVZUI5ZFhUYlBDKzVwQkY3czhaeis4cDVRVUVpamdE?=
 =?utf-8?B?RG16cUNGYUhJMDA5VUYrRnZJSjU1TldlcDNjdldQWThJNm5zczZ1S3ZmZFBS?=
 =?utf-8?B?K0tYZ3hFVnFNdEJIZi8vWndsZjZkYmRNWTV5OE0xUEVoVFgyNWZ5ZUl5YjFt?=
 =?utf-8?B?TkFRY0RxWUp5UnZMRHBJMUNGTWdtMUdvNzdIclVVaGZiMFFLZmNnZlN1RHNE?=
 =?utf-8?B?Ykh0SGlIakF1QXF6Smw1cVU4SlBwMW12ZzFTNjErZlM0TTNqL05FT0FSajBW?=
 =?utf-8?B?cDhNZ1hYY2c2TVJaQlYzQWdsV2lvWkRab3RoOTk0TWY5Z0EweDVDWEQ5cUZm?=
 =?utf-8?B?V2xsVXk1dzJLRU1tWXhCZjZiL3hhVmdIU1VOKzkwOUNrVVFBaE9tZHBFS2h3?=
 =?utf-8?B?SytMSDNDekVDS2RjZ0Z6WjY5L05KRlhVQ0d1VVlONTFrRWZQQUFyN01MVlVj?=
 =?utf-8?B?VWhFcUtKWTR0SkdFSDM2c2psNmY5cEorRmJNb3RBY3dRL3B1UFgxZjBWYmd6?=
 =?utf-8?B?aXVSMVRUbGgyK1d0SmU3Tk5sUE9iVjdzOVlsdlVQSW8vV2RLNHIyc3h6OWY0?=
 =?utf-8?B?d3F6NHlJWC9RZ1NDQ1ZhQlcwbzBDZTREQ0FIaFNlMjVhSzZoVzNkZHh2QTdH?=
 =?utf-8?B?VFRSbHE5enRFandLUlA0Zm1lZ0JGazVSWFNXN3NNU3dzRzZzL2lsb3AvK1J3?=
 =?utf-8?B?UWlsVlBLZFN6VnMyNHl6Yk5DY2lWZzlhNG9TSVk1bnNaa3lKMStzdHBGNks3?=
 =?utf-8?B?OFFFRGRidkJFV3dMdTN1RUJxT3RWbzUvOThIbmlzV2grZGRNWFV0azNUeGhG?=
 =?utf-8?B?YlZIYmZNbWI1N1ArakNRaEZyVFQ2QnZHSzArV2pHVUZ6REo2cnZDT1E0YTN6?=
 =?utf-8?B?NFEyTVRhcENnV1ZxVGJmVWtWeVhINFE1Yk5aNXY4a0U5SGxaWExPQ1BDY2VY?=
 =?utf-8?B?Q1p0L0h6SG1KbjhIcWtUd2JXNXhzdk5wbFIySzBJTU1xa3NpTDU0WEh3RW96?=
 =?utf-8?B?VzAyWjlTK3FjN1FBK0JyN3UzSlpyMExvOEZPdi9zTjV2TElSZGF6cTM3WGFN?=
 =?utf-8?B?cHdENG50d1Z3MnQ5Qjd6OHBwZk9HY1pLNDYwbmtYb1I3OXpiZUFvVFJISFFm?=
 =?utf-8?B?cTVhRm1sbkhlcXVjczh2alRWZWtlcXZYaHVpVndXVDJ5SlhuRVBkSXNtQ25q?=
 =?utf-8?B?Y1FVakFuUmVrTENjeXAzaUh0YlVDS2JRaWxZeWQ3NFRWUDFpekgzVi9tbmFH?=
 =?utf-8?Q?gBUOAI+TzXAT+H/NG3eZwWwKqj/AuS2qXz2Pc?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b9f1f4-90f3-4510-4df2-08df3f5ac1a7
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:45:13.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afaRN/17NCUpWW+gul7jq99gK7NcD8/pGmN4hzBV3KccL0+t3hee8XhwnuAayOqvKqk1DXgrDQUXpfKnzZkoiHApC3c+0Fzg9yTIFbmvjRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5210

+CC tglx.

On 2026-11-10 13:38, Weiming Shi wrote:
> set_cpus_allowed_common() passes a remote task's p->mm to
> mm_update_cpus_allowed() while holding p->pi_lock, but that lock did not
> stabilize the pointer against MM replacement. A same-owner
> sched_setaffinity() caller can therefore retain the old pointer while exec
> replaces and frees it. On architectures which shoot down rather than
> refcount lazy TLB MMs, exit_mm() and kthread_unuse_mm() have the same
> lifetime gap.
> 
>    BUG: KASAN: slab-use-after-free in set_cpus_allowed_common
>    Read of size 4 at addr ffff888123155e4c by task poc/5132
>    Call Trace:
>     set_cpus_allowed_common (kernel/sched/core.c:10835)
>     set_cpus_allowed_fair (kernel/sched/fair.c:10046)
>     __set_cpus_allowed_ptr_locked (kernel/sched/core.c:3224)
>     __set_cpus_allowed_ptr (kernel/sched/core.c:3258)
>     __sched_setaffinity (kernel/sched/syscalls.c:1161)
>     sched_setaffinity (kernel/sched/syscalls.c:1239)
>     __x64_sys_sched_setaffinity (kernel/sched/syscalls.c:1275)
>     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
>    Freed by task 5127:
>     kmem_cache_free (mm/slub.c:6757)
>     __mmput (kernel/fork.c:1204)
>     mmput (kernel/fork.c:1215)
>     setup_new_exec (fs/exec.c:1395)
>     load_elf_binary (fs/binfmt_elf.c:1024)
>     bprm_execve (fs/exec.c:1865)
>     do_execveat_common.isra.0 (fs/exec.c:1963)
>     __x64_sys_execveat (fs/exec.c:2047)
>     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
>    Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> Affinity paths hold p->pi_lock across the p->mm load and its complete use.
> After publishing a replacement or NULL p->mm, take and release that same
> lock before dropping the old MM reference. For an updater that is already
> using the old pointer, the ordering is:
> 
>    affinity updater                     MM teardown
>    ----------------                     -----------
>    raw_spin_lock(&p->pi_lock)
>    mm = p->mm            /* old_mm */
>                                         p->mm = new_mm or NULL
>                                         raw_spin_lock(&p->pi_lock)
>                                           /* waits */
>    mm_update_cpus_allowed(mm, mask)
>    raw_spin_unlock(&p->pi_lock) /* release */
>                                           /* acquire succeeds */
>                                         raw_spin_unlock(&p->pi_lock)
>                                         ...
>                                         mmput/mmdrop(old_mm)
> 
> The teardown-side acquire cannot complete until an updater ordered before
> it has released p->pi_lock, so old_mm remains alive throughout that
> updater's access. If teardown is ordered first instead, its unlock is a
> release that orders the preceding p->mm store before a later updater's lock
> acquire. The later updater therefore observes new_mm or NULL. An updater
> that acquired the lock before the store but has not loaded p->mm yet is
> still ordered before the teardown-side acquisition; it may observe either
> pointer, but teardown waits for its complete use before dropping old_mm.
> 
> All runtime callers of set_cpus_allowed_common() hold p->pi_lock across
> this access. The runqueue lock is not part of the p->mm lifetime ordering,
> so the grace period only needs p->pi_lock. Place it after publication and
> before the old reference drop in exec_mmap(), exit_mm(), and
> kthread_unuse_mm(). The last two paths matter on architectures which shoot
> down rather than refcount lazy TLB MMs.
> 
> This change was developed with assistance from an LLM.
> 
> Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
> Cc: stable@vger.kernel.org
> Reported-by: <co+cab19e2ebe4d535a@bugs.sh>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v3:
> - Document the p->pi_lock grace period and acquire/release ordering.
> - Use p->pi_lock directly and cover exit_mm() and kthread_unuse_mm().
> - Refresh the KASAN trace and provide a standalone reproducer in reply.
> 
> Changes in v2:
> - Replace the schedule-in deferral with an exec-side runqueue-lock barrier.
> - Keep affinity expansions synchronous, including expansions narrowed before
>    the next schedule-in.
> - Avoid changes to the MM-CID fork, exit, and scheduling state machine.
> 
>   fs/exec.c             | 1 +
>   include/linux/sched.h | 2 ++
>   kernel/exit.c         | 1 +
>   kernel/kthread.c      | 1 +
>   kernel/sched/core.c   | 9 +++++++++
>   5 files changed, 14 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 8d2b14e1d455..3196421cb81d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -905,6 +905,7 @@ static int exec_mmap(struct linux_binprm *bprm)
>   		BUG_ON(active_mm != old_mm);
>   		/* Defer teardown to setup_new_exec(), outside the exec locks. */
>   		bprm->old_mm = old_mm;
> +		sched_mm_cid_mm_barrier(tsk);
>   	} else {
>   		mmdrop_lazy_tlb(active_mm);
>   	}
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1c93da75226e..f88ab0445be3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2358,6 +2358,7 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
>   #ifdef CONFIG_SCHED_MM_CID
>   void sched_mm_cid_before_execve(struct task_struct *t);
>   void sched_mm_cid_after_execve(struct task_struct *t);
> +void sched_mm_cid_mm_barrier(struct task_struct *t);
>   void sched_mm_cid_exit(struct task_struct *t);
>   static __always_inline int task_mm_cid(struct task_struct *t)
>   {
> @@ -2366,6 +2367,7 @@ static __always_inline int task_mm_cid(struct task_struct *t)
>   #else
>   static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
>   static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
> +static inline void sched_mm_cid_mm_barrier(struct task_struct *t) { }
>   static inline void sched_mm_cid_exit(struct task_struct *t) { }
>   static __always_inline int task_mm_cid(struct task_struct *t)
>   {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index d5e7bc2af804..5f9979d6216c 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -582,6 +582,7 @@ static void exit_mm(void)
>   	local_irq_enable();
>   	task_unlock(current);
>   	mmap_read_unlock(mm);
> +	sched_mm_cid_mm_barrier(current);
>   	mm_update_next_owner(mm);
>   	mmput(mm);
>   	if (test_thread_flag(TIF_MEMDIE))
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index fdb8fb07f40b..e7b393cfdcee 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1682,6 +1682,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
>   	enter_lazy_tlb(mm, tsk);
>   	local_irq_enable();
>   	task_unlock(tsk);
> +	sched_mm_cid_mm_barrier(tsk);
>   
>   	mmdrop(mm);
>   }
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 04b62c16fa8c..d78a174b5405 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11128,6 +11128,15 @@ void sched_mm_cid_after_execve(struct task_struct *t)
>   		sched_mm_cid_fork(t);
>   }
>   
> +/*
> + * Pair with set_cpus_allowed_common()'s p->pi_lock critical section. Call
> + * after publishing p->mm and before dropping the old MM reference.
> + */
> +void sched_mm_cid_mm_barrier(struct task_struct *t)
> +{
> +	guard(raw_spinlock_irq)(&t->pi_lock);
> +}
> +
>   static void mm_cid_work_fn(struct work_struct *work)
>   {
>   	struct mm_struct *mm = container_of(work, struct mm_struct, mm_cid.work);


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
