Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795474583;
	b=xDL577P3xSNF5voRg/zfHNji+2FthZpp/tO/PRQ+9GgJLhsRxdaHjLSDhNAEJ0Vbk0J9
	 Tdb2wvJkzpzJKI6ZvP7MpuwhhToc/WralU56lvZW6viinHBFCJ9WiF8fjIclJqpYxNper
	 Tkxiuj1459Y5DbKQzCW2nHFfjsJrKnh87jZ2acNuiGcYgRRIRPCHoedF4emNhOm5ieseJ
	 PXIKka2XVefVkYZ8z9LU/IbMUQZz/OVXDvw/9mKHUOiGXDnUCJQ7uc/h4p6OpRLL7LF9M
	 SwHlPI7Cj+4HPZFi058eRbb3y9esqdbnNyzYpZnPvC36Z4VAOC/lQU9FYTEZNOoeu2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474583;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=j0frWXDTGXB3Ge+mKWv/opT3qbbCm62LPoOdTei7k6w=;
	b=fYSpaoFL7otWgzJhqOsHgbcfNS4pQAa3sJmSVt8kWq4yOOcKnEDGkUGWPyWCOUWnHGF7
	 nfUXsFxoRbxXh6OWcWeBkxxsd5Lujx0zTbX0teLTCK6XgeHnuZ1poUe+FsiT+hm0iARTv
	 JfK4Z4nFv1g2lrrtmOgAk9+y5aD4uIEOZ+dhPPDpeO9brl+2fohNEFCqSxvqerTcGXWWV
	 9JmkwgLNuWJffoFcompQ+buQTZrTtyQkeMEssMxh4294QQYUaVYNqM2g725rmOGZeZY9R
	 Mr7QSAwBFGE4pRcUNML6kwL9B7X51XXMSMlSkq/B/AwTw7uG3JPLMDrcLSTJ2K1ShQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=c3A8UkN2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.94
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021094.outbound.protection.outlook.com [52.101.70.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FD606A31E;
	Mon, 23 Nov 2026 22:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A1FD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=c3A8UkN2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/jf5QbBuotHYIet/G3Jvw5rA5UbJ/YuyxRnq8/aHEa1LaC5ns2+WnqpIKT+xxgBMa6tq2uUOyUgtukUIGaI/FWORxpzGu56jfL/iGAxtxYWLztpMhEXpmc9N24iok6LCO+WVYPzomN72JqZik/mouQoS/Hiu1XLLx3cBzbR3YgKfInp5vqrz/nLjeoJWcrAoegZ19ymarrsP28Z1UGQuvVdf6U9eUqMBpo5tPFHE2STgPpQM+ChQzX+OcJpH9HRrPw2MbE6YLdOBShq+88CMvYupNujuYs/wLuW6HfkBYosWBgP94MtonZscFuPa6+o3EW0BtLxLGIDjt0x7h/pMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0frWXDTGXB3Ge+mKWv/opT3qbbCm62LPoOdTei7k6w=;
 b=RMjpnAp8MRm37hcppzbDpwIvDDqu1LfNU7emCAQlQyQd5AYi5HT2e45Hpean6K1orQCTJKC7WG6HQzGnRWFC9vCrrZNb9klM/c3n43755WmsYd7rlP88TzWb0O+8glFZyUn35fxk/I6+XmDJaFCJM1+XOiWeEqkiDoM2UmrLTDvN3xm2ZWqxroGVeaSVQjqDkqTI4Ki/loY7CaUg+SqbHMy+j7HW4y2eFSNJuBI4UC2U2eZ1yal7UayZgfO2ird7rB9jaRKUgVS1seFqB6DIApD0uoFPmLYe2TS+2RNKdEsPsw8vbcXRK75XdHSo6lG3sVgyVskjvBSYRJ7z1QRQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0frWXDTGXB3Ge+mKWv/opT3qbbCm62LPoOdTei7k6w=;
 b=c3A8UkN2LpCNvIAgAAKpkw52qwmcExH3lhce4goz7KNgN57nEhJwmHokwraFU1/jMx4zLXOzyvq4tmaZQXGRpfqhcOJVLfxqndgYRLTuSDA7lt4JaDZou4n6Oa7BRPOwmoP4kWFGStSdCDuiNRWOz/RWxh06ouMomObN6W6uZMc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from AMDPR08MB999846.eurprd08.prod.outlook.com
 (2603:10a6:20b:70a::22) by PAVPR08MB9089.eurprd08.prod.outlook.com
 (2603:10a6:102:322::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 22:56:19 +0000
Received: from AMDPR08MB999846.eurprd08.prod.outlook.com
 ([fe80::a2f1:726a:58fb:8320]) by AMDPR08MB999846.eurprd08.prod.outlook.com
 ([fe80::a2f1:726a:58fb:8320%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:56:19 +0000
Message-ID: <9bc0d7ed-0799-45dc-8d74-25ed66851a20@kuleuven.be>
Date: Mon, 23 Nov 2026 23:56:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: clear read bounce buffers on confidential guests
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
Cc: "jo.vanbulck@cs.kuleuven.be" <jo.vanbulck@cs.kuleuven.be>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "kas@kernel.org"
 <kas@kernel.org>, "carlos.bilbao@kernel.org" <carlos.bilbao@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261123205302.1034348-1-shukai.ni@kuleuven.be>
 <3a70a26adccc47b1bae3a22e4907174271703a10.camel@intel.com>
Content-Language: en-US
From: Shukai Ni <shukai.ni@kuleuven.be>
Autocrypt: addr=shukai.ni@kuleuven.be; keydata=
 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
 qQzAq6/nlHM/bMUHgzNXNIMB
In-Reply-To: <3a70a26adccc47b1bae3a22e4907174271703a10.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::23) To AMDPR08MB999846.eurprd08.prod.outlook.com
 (2603:10a6:20b:70a::22)
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
X-MS-TrafficTypeDiagnostic: AMDPR08MB999846:EE_|PAVPR08MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1b3e8f-78ce-49af-5093-08df49b4fc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|786006|376014|7416014|366016|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|11063799006|5023799004|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fFG+23Zkq4OZzBSamglYSelwAN9+lPDuujWnKN+c+y97eQmMPulzDEQL+e7Gh4sWnm50FnafF0/cQ+ztE4CiJccB6m3tCaavsxRB9IMkOiRNrZ8Tn/Vk9ZXrmm6y91iytwBDl63wLjVmqT7jmsj4lQSlaPlIO5HBxk6r1xmz2CI7MO7TEjJv0HZ2mxcRQmD+Wl0TePIbVV7YfMme+xrlrmA/zK8SpneXfHLmKPtn4luknSSeYLi4DXLH7twsbuAJBhjj9NffKUs2lcpUEKjkNxPAHsX484V6YpjiXVXTDtaFCxUqHWQZ9gFrWwvI76y1nhZNAdql6siyrrIfqkAmv04iGXu09NahmoCY8/NyBXShdMi3NlkeFOtAjX6Qs69yVu6GN/XAsliF2HILb6ubSWgAtncFOUe3brQJO7a+fvtp390//WEGWTGGb510kJJGTqwZ0RlMtGlsohqZ0DsULxH33XXc19z8W6kWJ54hn4lSVfVZpEXo4ftIndfXdYNk4jlNCjKo15hvICkqRm+ykKfuofQ7cTPpnVpRKMmjrhcUfyZLcpAdQzaf60QS0hLh0fdpqk9Eh9DcOJ3ezjNilvWlDdnhghogIoGGZIcncN0NPrS90+EA5KMf/6AhpIT3zTMOeKkhmvmmwi6vuhhlHz4fEGsOqYlZOFyZoZKxeXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMDPR08MB999846.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(786006)(376014)(7416014)(366016)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WldOdFA3dUJDYlF6cDM4alZ0cU10c0hCS0M2UHRZaTJnM3pZYTFsSE5aQmRR?=
 =?utf-8?B?cHlnSkhvdS83WmJxU0FWRmJwQkhJRi9obXdwWk1UWmdKTUV5blRNS1ZjNHpr?=
 =?utf-8?B?bkZkUHZkNlNpbTlqUGRUOTVEU0hIcFJTMGF1Q09FeXVGSDltVmo4aHp3dDgz?=
 =?utf-8?B?N1RGdERWTHFwR2QzUnE2MU5SbitDaWdWWElFYnA0cEVWNXczK0xZaUNsZEhO?=
 =?utf-8?B?WDBBZU0rOFJqb05JN3lkTWVnUzh4OW80bkpKOFV5UlluZ2JianAyVzArRXZm?=
 =?utf-8?B?eUNLTkZoTk12S0Z5dHQwRFk5ZytZaUFMMlpLdGFsWWREYm5RRU1UbzloQTdO?=
 =?utf-8?B?MTZESVZHU2ZLZDFlN1BJMk5WWkJpTDdpRWxJL0t1SE1HQUtTdEI1OXhDRTBJ?=
 =?utf-8?B?Y0FxSWpoWEdMbUZnektHalVOYzlWaDZwczNvaXlMZUk0WGhKdUQvSTNPY3pD?=
 =?utf-8?B?TzJBVHZTVVVnWDlvK1R0V2puZXR6ejg1cjVDejNJUDBGa2kzQ3dkdDlkUlhP?=
 =?utf-8?B?T2hyRE5xOGU0am91cXpvVy9WRHRzOVVrcmZzdU9aM21uaHdSSTBnWGFKSkY3?=
 =?utf-8?B?Q1BpcWtJbFExcURVWi9VSTIzM1lINy92bWFESmtVNGZXN1RJWmQwbGlreVI5?=
 =?utf-8?B?TEZDcjR0c0t6eWovdGdxV0V0dThqaWNwQ1RuTlF6YzJ5SEhEZmpjbFdlRHRi?=
 =?utf-8?B?Yk9yRFZ6MjlqZmJJeE0zRTJMY21HVnBkY1RLaWpXYVhnelQzQmVEZU16NDlC?=
 =?utf-8?B?UTc5UEFIcEk2WHJWT1loU0pKZVp6UTNtWlpBazI1cDZNZmpvYjZsanpLakM5?=
 =?utf-8?B?QkExL1VjYWRIREdnNjlVeGVRa21GRy9sNlhpalhDMnNzQkhoZ3djK3VIMFg4?=
 =?utf-8?B?bGxLMXNvK3ZXQm9DeWlxdkFObEhyWDcvM3RxY1d0Z3p4VlBFMGp6cE9JTGJ1?=
 =?utf-8?B?NXlGM0ZnbFQva1NaNkNNTlY4VFp4eEI4VDZoQ1I0SGpvOGoraUdRVm1oVjhF?=
 =?utf-8?B?bHRvdW5nNjVHOHd0dkdxdXBjYXZtcVduT05JS0UvZWczTTNOMFltN2R1aWVh?=
 =?utf-8?B?MTV4UVVoTUZTN2dRclJ3d3Y1d0Y1OS83MytQZjcybHJOZUNvNHNSOENWSUg1?=
 =?utf-8?B?dFU4Zy9sWTVCTGZ1UnNneVhxbHJ5U1lBbGdFZW1zRlA5dHVhRWRUZ2Z6WC82?=
 =?utf-8?B?T3ZUMnY1dWY3czgxZGxBMXJoZUpZaVp6eXhWeHo1VGF6Q1A1Q3dFb2tYbVRi?=
 =?utf-8?B?SzhkTytWQ201M0doSHd0Sm45Wm1PMTQzeFE3a3Qycy9lOGtBMW9KOUNEeXBQ?=
 =?utf-8?B?d3BKMDBTNkZoS2s0K1owT1JyeU5jcml5ZVFGbkEwSEtHMzNPMWcxbnZRbG5z?=
 =?utf-8?B?MmpIK3cyZ28xajFSOXI2aUlQc09QbVB5T3ZtZW5xc2pmYlg1UDFLR05VeGY5?=
 =?utf-8?B?aUlEdW9MU2Y4bEQyTTJuUUdwcWljWGJNSmdEaENsQU00YlpoNEZRSU5QMXV2?=
 =?utf-8?B?U0JEcDVvTkxydlNONjZPN2NBNzB0NWZEV3pqdGh5cTFQYnIvM1dyOHJwVGg1?=
 =?utf-8?B?NlZVZXk0T3MwclJvMnpOWWdnbzFCL1FOWXByMkY2U2tCZC9uaVAyK2NONnRN?=
 =?utf-8?B?WFRpWDZveUtTSzhvM1UyZzNpTUdTa01YOUlzMk90KzhjMzhROXhmUllHbW11?=
 =?utf-8?B?Vk9IZEhZTHBTL1ZGY3lESHR6UDRJTWg0NC8xZEJtcmYrZmFZcjVHM3ptSVVr?=
 =?utf-8?B?S3dtelgrYjFOL2hVYk5ZVW05VHhqcndOQ0pGUzBITkVTL1YwT1A1ajVXYTUv?=
 =?utf-8?B?Ty96Mm9KT3oveGQ1VVNMY25ld0FpRHl2NGZ2N2ttdXBDK3FoMjVFL05zeGxK?=
 =?utf-8?B?cUlqNWZxbWJmcWxxUEpJMDF0MlpaQlQ2SzV2ZGhGaTh2QjR5VUdzUUdKZ1Z6?=
 =?utf-8?B?UXpzam9FTTJlT1BMZUpIOVNCb2ZJdS9LblZvcEUvQjRGODZJQTlPN1kvYlIy?=
 =?utf-8?B?RjF6MkFaVTYyWXA5Wi9EbG8xOEplS3c4Y1JSbHZaVHlxTzR0Ri9WWGFLbnZN?=
 =?utf-8?B?QzBXbGFNdlJEcFBIUjExTzFVdnF0UjBLTnFwZjB2NUtuZ2piVlFoU2EvQzBh?=
 =?utf-8?B?ZnJOL1N5NlpGN0dYdmpZM1VwTlJSK0V2SGczLzZWSWlBNWZxc2pEK2ZxWm5M?=
 =?utf-8?B?d2thT2xIcVZqSk9Yd1UzcTloaWtIVnJYY3FXQjV1Y2ZtRnYvWXVjSFNvSzlo?=
 =?utf-8?B?dDZXTmdnTHI1cmhWay9SMnU3Ym9UenZCWUhWSFVpN0U0a0hIYk5qdkpKa0lo?=
 =?utf-8?B?Q0pEaDNCd3hsWk9OOW1uMjU2NjVWcElaanVpMDl4eVBNUkkwbWNVdz09?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1b3e8f-78ce-49af-5093-08df49b4fc7e
X-MS-Exchange-CrossTenant-AuthSource: AMDPR08MB999846.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:56:18.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY60TESmPJzxgekh9W2FyT6SyIkPAunv1WmsCbH2Js9kamByO6kjtGVDF3VgI1dqgNC1poDM1jmQPyy7pbDaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9089



On 2026/11/23 23:18, Edgecombe, Rick P wrote:
> There is an existing usptream position around coco driver hardening, that the
> drivers should be fixed. In some ways this another thing that could be fixed in
> a driver? The driver could zero memory before sharing it for DMA_FROM_DEVICE.
> 
> But the swiotlb was supposed to be sort of a generic solution to the problem of
> not inadvertently sharing private memory. Instead of marking an entire page as
> shared (which might have private contents elsewhere on the page), the bounce
> buffer allows for only sharing the minimum specified.
> 
> So you could maybe look at this issue as fitting into the general problem of not
> inadvertently sharing the private data inside the buffer. But also that is
> covering for driver gaps.

Thanks for looking at this, and we had very similar thoughts when 
writing the patch. Our impression was that in many cases the driver
doesn't own the buffer (page cache, dm-crypt, O_DIRECT), so fixing it
there seemed hard, which is why we tried swiotlb instead. But we may be
missing something.

> It seems like the fixes commit was arguing that copying the contents to the
> swiotlb buffer was more transparent. So this patch kind of goes back against
> that argument. That seems to be another point that the drivers should be fixed.
> If this is essentially more of a potentially behavior altering kernel hardening,
> then I wonder about putting it behind some kind of hardening config like
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON.

As far as we can tell, keeping the old contents for DMA_FROM_DEVICE
was never really promised. Before ddbd89deb7d3, swiotlb
didn't do it. That commit was mainly about not returning stale bounce
data to the caller, which zeroing should still prevent.

In case it helps, we have a PoC on SEV-SNP that leaks MariaDB data from 
a LUKS-encrypted disk through this path, and we're happy to share it.

> Ohh, but I guess the problem is the buffer getting copied could have come from
> userspace? So then you would have to fix userspace... But then this patch could
> also potentially break userspace if there is any partial write assumptions. Oh
> boy.

Yes, a short read into a pre-filled user buffer would now see zeros. We
did a pass over the drivers commonly used in CVMs and didn't find any
that rely on the old contents being kept, but we'd be glad to hear if
someone knows of a case.

Thanks,
Shukai

