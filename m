Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793083486;
	b=E7bjSZlYerZEw45dylr/XGckuUrfa/uH1j0IuaVgtIe89erQ3j4jnO7+Buz7TkfSS0uQ
	 6ImsVgsfVBKGATCp+ag6cFGfRN3Mdkw+keubfqsFXl5XvXLH3B2NO+RlmDdsYpU49sVUx
	 fL6qHqsTj0pcBrydLlUpyEgVHXunedhL7G3hP/414nHpC0BwSII19jW1v3dszl31BfKNw
	 Gnegb7C77hO6b/ZM5+HP8ogsCLHuRIVFv8LUB8skEkG3xWY1/TPW3AsU+XL22VETTE1ni
	 sRXyCrdO1tW6p8CJQAqUZYWqOefNEw3hiFkL6z0USbM0uonIAbgFyS3a7aX01ZA/53w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083486;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:References:X-GUID:X-Has-Attach:X-Mailer:Message-ID:
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
	bh=wBxGzOsSDQgAAHBu3tPVejT03aVgR2L3MkpFdkb/pnQ=;
	b=i7CIYl5GfRhheNELUCH27bxlsgTi9fpyCelIxZ46KbBDUoymFVj2rkOi4xa91+Y72I9n
	 OJJCqPsntQPOUIET7zHiznC79D5riBnUsiqaViBFlnO32S7wt1vwyLGw+NSBpTwyAf5U2
	 nQoHxnpnPPgDrlxWi5HpbNSHnBzpMOnCiJ0DOadzzDY199mP5ha2Enl1tDcfzdu3dARPO
	 5Dt9lpgqd+wmnwQLI3eBCY819z/ojLVNN3OUJWwQd38U2qh5L3gQo6uRodvq02LvRCH9N
	 Cl/icPaViKL+W5hNoafQsLNFM9STpOeUK0M+lkGM6sk60QIQ/ZrmNeoBBUEZrbd7fbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=sq3A7yDC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.130
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023130.outbound.protection.outlook.com [52.101.127.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAC606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CAC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=sq3A7yDC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqROJiIOKjWJ4QY3Ugkx+yBEEVK9+ElhAsxuZ9rajzL0uopy6PhgYk2dPL+jk8BrIFH+DBS2coZu5wDWHPz6fNWhmy3Zd1urD9cis6MS9lODmxpAdXiFan0UD0dnWhAW4yMdLgadkfrmJBF/9Bn3d775JZ8Oc5iRhFCd+91abCYfJbCbbG3g9TNtpBTMnSvd9jafy45ppqx5pELBWtEhV/KYyw7REflIlB+aBqVaiMCODCU43qzstFxNmMuuAt6hIXidLsKL8S6ODqq7SC2zQ33L3pjES0fqynmzn/MvtR1YJz4LAGTk4fz0G+7HyjimiWMaS+zXvHS8NQe+leu6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBxGzOsSDQgAAHBu3tPVejT03aVgR2L3MkpFdkb/pnQ=;
 b=uyc7NmNtA+XQVl9ksJux7CHJKPKLTJTN40bZn9k6tRUdyp7svl2Q9yYovJwipmgf0eH1Dhzbl1h8jaIzua9goh5pVaEQM20gsoT95mJPFTpClmPwbf9W3vSax2MqBiuFnmGHByb5CKtvsI9oQvzQZr/CYqiglKRHKuuahJiM08HwFOosiSiblAyfZkw/4SGVCbrTvIHLZT/piLoh5F+kanBMWaDMLGS/6QrLzVnPx/5DUTngLCuqlo4Mn+l7/nDwkkoxSpZN6EwsyW0XMxX6P6WOoO8tsBlMFAcD117SfRXetF1JDDW2/2Oba2MT68luAr/1Be0l76rRTvEyhbcBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBxGzOsSDQgAAHBu3tPVejT03aVgR2L3MkpFdkb/pnQ=;
 b=sq3A7yDCBUsDb/8Bwf7aNyaTHOlZEORpl0mZZf6T4aJBCgAZhmAGDSu6JyIE3adk2T+/xAayCNJhsyeKObO01/TSiA0OKRl2sXmccCmN81r06tMrRp3z55ryrsej1NfOW6LaOkS21ZVxRyIy0KMZf0yOV3v+nd3R8kaiUlnJSZoCnbVf+vwL9VRb+d3UIVIAenwpC0i9DabzG62MrRrpGHBfGG7mP5GR1AVztK58/NgUuI7LnjfoCAT+RaYAX99JtitNq/I+OpZxnZ/OzC1oMVe6WonS6llgNYpWjz+nuRVQk2aqoD7CeINGcE1e3G2mxCoqncr6nXpKcsD0HKqFWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB7459.apcprd03.prod.outlook.com (2603:1096:400:3ca::11)
 by SEYPR03MB7698.apcprd03.prod.outlook.com (2603:1096:101:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:44:42 +0000
Received: from TYZPR03MB7459.apcprd03.prod.outlook.com
 ([fe80::d306:36de:44d2:3a3]) by TYZPR03MB7459.apcprd03.prod.outlook.com
 ([fe80::d306:36de:44d2:3a3%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:44:42 +0000
Date: Tue, 27 Oct 2026 14:44:41 +0800
From: "yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
To: gregkh <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, 
	tuan.zhang <tuan.zhang@amlogic.com>, 
	jianxin.pan <jianxin.pan@amlogic.com>
Subject: Re: mm: call the security_mmap_file() LSM hook in remap_file_pages()
References: <2026102711371963416812@amlogic.com>, 
	<2026102700-astonish-whenever-37b4@gregkh>
X-GUID: 74098077-E3E4-4BED-90B8-5D5BF5578D9F
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.213[cn]
Message-ID: <2026102714443948547539@amlogic.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SL2P216CA0167.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::16) To TYZPR03MB7459.apcprd03.prod.outlook.com
 (2603:1096:400:3ca::11)
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB7459:EE_|SEYPR03MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dd08a4-6f98-46d9-686c-08df33f5c7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|261026121527099003|18002099003|11063799006|56012099006|261022113327099003|5023799004|261021121427099003|10067099003|261021135927099003|261022105027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	pBxtu4DhCobPAp+QluEoHyUwOQm+2rVL+SV9KYNBRAwZc2U+F8YZttvjlczBH2Fmc8HNbmEzHDgTIEiIKC7nqn7ibm/d8KWLic2Q+Vd/CMQwa4boSbXJrbP3d8HxCBbpgKrJsGfOEl4EkLQU7SFmp4ogoH6yqhN1RU6SN8hHo2qVmT8eOnUCSl6ElFXsxIwfqK4cNcs1i9h33eW4bvhp63o+aYEy5F6Tn/yFzCxQPhG+qao81PI7P1tlLmsaBJ6RxYZE1Kw+E69EHWYH2MXxFEhgChKb83CLQ02EXeJaki6nyFHOsX/Cokryjh9mjlnmsmxzgIZdlLagVwWPnBGuRnLKzqRWjzL3APY71bYjL66l4/VQxLsEiHcaHK7nOKpGn9hjQbXDyB2mFCyb8JLOdg2Q7dyqutgiERU5I3NjADFfE1oHlP0SNvvDozWVTgNQhAErf2/LiNz5ry62BGNanLceKOtHKF5/67h7bZEnudmaRSFXCLTIJsA3SInsT6fqA1oQwaDMqNa/F7cse2ll1Q7yvvKn+m7pB88eJSjFDsDBon9U5I1WOVMs3R7xtcikvRyPYXaUSDKOrVFfumsABYK3MyyMflbqB4YepCtBEfQ8qDHUjF+VuCxf1rWljqglfMlhiICjGBmqQiMtBmk3jozlmJXdrijZ8IWJ50ftf48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7459.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261026121527099003)(18002099003)(11063799006)(56012099006)(261022113327099003)(5023799004)(261021121427099003)(10067099003)(261021135927099003)(261022105027099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUVkTGFBOWk1c0hZSU1TSENPMlp4RG94V1JTQmtFUjExNDV0ZHhVaU9UNWNP?=
 =?utf-8?B?YktKM2o1WCtsUzVBam42RENQVnl4TG50YjVpeWtzRzM2MWxRRjJCWEJCTW9u?=
 =?utf-8?B?ekQvWFArZHVTenRUdjBDR2V2NlQ4d09CN2cyeEQ4b0lGMHJXNE90ZFJhY01O?=
 =?utf-8?B?UWRCSmNPV21NV2JYZ1IvNVNnUnZNeWZGYzY3VUFvRnF3ZE5MT3N5d1BSWnRk?=
 =?utf-8?B?WXVnZzhkalFZZ3VpalZHVms3aHRwYU1LNTgycGtYZEhicHhmcTloTTRqQkdU?=
 =?utf-8?B?TlBJNU96TWZHdU5VU0kycEFRWXQ3Qm5qOEFpMFlEMUQ1c3lRNUQ4MUdvNThx?=
 =?utf-8?B?cWtVVjlQNmNiajErdjN6VzFUVGVveCt2dzlTa2NjRjRDSU42MGpRTUFVMGxv?=
 =?utf-8?B?NDBESktnUEVKRkRwL2M2ZnV1V3FXS0RjK21zNm4veldxY21QM1hkNU12RDNk?=
 =?utf-8?B?NEdBdXZrN1V4bEJNTzVGanVUMlBYN2lab3owbFpOT2cxMTg5NnJNTDZtTVpu?=
 =?utf-8?B?QVY2V0VERkQ1NFJodWpGOGlnSnhwaEhSOVJidUwyV2pTMWYzcEIxR08wVXlw?=
 =?utf-8?B?RWNWQ1VWbFRoeDg0TDIzMURFSS85TnVXc0xpK3FYS2J0ZnRIZ0dqemQ1SEhI?=
 =?utf-8?B?VjA1dHh4RGd0STUwYVduYk1RVzNhWDl6TnBzUXFjZ1k4bWVCbVVSckMzQzRi?=
 =?utf-8?B?UlpwZGNkRmFvdnl3NDZDc0RSN0NmZDlxam5RWThqNEExMzRqWmZzUVBuUCtx?=
 =?utf-8?B?RkVST2xjV2RBV29teFBMOVdTUzZyZElIU2RxWjFhM255RVEyN2tic3pJaGxi?=
 =?utf-8?B?dGxhNG1Ed0x1Mlk1R0hwakk2OUxNRU9keDFuRk9rL214bEZzbGNJbEJ1Vytu?=
 =?utf-8?B?K2h4aWZBSklQelE3ZVBzYm9oVVR0blNLRGVnMWVpRWhjeSsxMXNNMVpvVGpN?=
 =?utf-8?B?K09KZUlzVFVYRzhLa1lsSmVKT2FTYXlCTkF1bmpaS1ZnNUtpbEFHSmFLTHZ5?=
 =?utf-8?B?YSthVDhPeWRoZzJuZjdMay9IU3pOUlAzZTFsWWVPc0xjUExWNE0vNXJrUUlR?=
 =?utf-8?B?SE5ORFgzY2xTL3dOV3RZbGZtYmtvcHlNUlE4RmpPNnJjbWxaVWpDbkN3bHJD?=
 =?utf-8?B?dHk1bjdsdmdENVlia0U4YTUyOEh4eDd2OGF1bU43VXpXeDhYbkoyVXU3b012?=
 =?utf-8?B?MVlmMzNKaHV3L2ZpVUZPMUx5aVZqTmdHV1RjZGJ3UGlPbWYwVHZRV2xVenVn?=
 =?utf-8?B?TFJKTmNLMGE2SjJNY0pnay9VQVBsMC9MNUxMaFRRMEhFTy92aWVvOU5HUzgx?=
 =?utf-8?B?MUxoekc3aUZsNkVxeFRPS1BiaWd5bnJiYm8yVkZIZENZRk00LzhyVHVHNTVC?=
 =?utf-8?B?VDdKYnQwdEV4ejROS2hvL3pqMGJOT0VuUGhocVlZbjBMYWJpVHNpb2Foa08y?=
 =?utf-8?B?bjhnaVRqOVh1dkluUXJ2bll5NVpMdURsaGphNDdMT1lOSXZDcTd0R0Zram9q?=
 =?utf-8?B?UWpyQTROekc0QUlvdzZ1UlNsT29RUTRWOUs1WEhPTnAvTVVFZmFqb0xFWUE2?=
 =?utf-8?B?SWdlczdTT1ZVVCtsUlRBNWVPSjdZV2ZUK081cURTV2cvWTBnVjExL2NpdFNu?=
 =?utf-8?B?eXI2cVFMRW1LdzA2OEVHTGhLdm15VWVZczl0NjkxU25hRlBQbFpJcVZMblBQ?=
 =?utf-8?B?TVJQVmpqMHlla3EyMk1VY0VMR1NYMllpT0VSMGR3TEhneEFYS3pxZ0dEMFFa?=
 =?utf-8?B?T2ZmRjhrV2huMXlja0djelBzTE1CcFZzT3dHSGxQbEwvSVhyQUxFTHRJeVdX?=
 =?utf-8?B?UHlJaThSUVR1d0ZoVlJ0UksvNkp2R3BrZlhNdVgzTGlvZitxN2NFeG5aVjFx?=
 =?utf-8?B?Y2oxTzBEaERiTlg5c0ZkWTFNY0RVR3Z4dndSSjUvditEL1ZKaW5wVU1va3VT?=
 =?utf-8?B?bkltK2cxT3BnbVcwbUJFZjdGT3hjeHFZenJudjVXV2ZoSHJaWWIxdWdmRlVx?=
 =?utf-8?B?aVArOEtZYjcvSTJnMWJMd1dqRGoxZlVPRG5VMUFLdjM0ZVBoOC9XdGQxdEo4?=
 =?utf-8?B?NlZmMzBNa2xJMGZSUkFZQ3RQRngwSWJicUV3c2ZJRUVzWnZXWG1NSXhxb09E?=
 =?utf-8?B?b0FKL0xhNWN1ZDBRSjlxcGIzVzJxNTUxZjlRVDFDelRPRVBUVVhhSGcwekVJ?=
 =?utf-8?B?YXdSM3huc0dvTnFNU1k3UHhEaUlGT0hjL0MyK3hqZVo4QTgyZE80akxBTkRa?=
 =?utf-8?B?TG1wbndIMzhLQ05NNjV6bW9NSVZRNWlTai9CYnQ0bEROaDR0YVMxbWpXSDBR?=
 =?utf-8?B?NEd1dWFRZzVwM25aRHhEUFdXUUl0WnBFVk5oVmxhU3JoUGlxMXhvZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dd08a4-6f98-46d9-686c-08df33f5c7a4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7459.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:44:42.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCxsmivPHKQn3nIJex7fBj7PsxMkmoccqRbc+zxW4MxYU1aeVPo794/vrKuvcmYGzrOMTebPyfoJ6QlxNbrWGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7698

SGkgZ3JlZ2toCgpJIGhhdmUgdmVyaWZpZWQgdGhlIGZvbGxvd2luZzoKCjEuIFRoZSBwYXRjaCBj
YW4gYmUgYXBwbGllZCB0byB0aGUgYGxpbnV4LTUuMTUueWAgYnJhbmNoLgpUaGUgY29tbWl0IGFw
cGxpZXMgY2xlYW5seSBvbiB0b3Agb2YgdjUuMTUuMjIzCih1c2luZyBgZ2l0IGNoZXJyeS1waWNr
IC14YCwgd2l0aCBubyBjb25mbGljdHMpOgoKZ2l0IGNoZXJyeS1waWNrIC14IDBmOTEwZGJmMmYy
YTRhNzgyMGJhNGJhYzdiMjgwZjcxMDhhYTA1YjEKd2l0aCBubyBjb25mbGljdHMKCmdpdCBsb2cg
LS1vbmVsaW5lCml0IGNhbiB2aWV3IHRoZSBjb21taXQgaGlzdG9yeS4KCjIuIE91ciBjdXN0b21l
ciBpcyB1c2luZyB0aGUgYDUuMTUueWAgYnJhbmNoClRoZcKgY3VzdG9tZXIgaGFzwqByZXF1ZXN0
ZWTCoHRoZcKgaW5jbHVzaW9uwqBvZsKgdGhlc2XCoENWRXMuCmFuZCBpcyB1bndpbGxpbmcgdG8g
dXBncmFkZSB0byB2ZXJzaW9uIDYueCBvciBoaWdoZXIuCgpGdXJ0aGVybW9yZSwgYXMgdGhleSBh
cmUgdXNpbmcgR0tJIDIuMCwgdGhleSBjYW5ub3QgYXBwbHkgImF1dG9wYXRjaC4iCnRoZSBvbmx5
IHdheSB0byBpbmNvcnBvcmF0ZSBmaXhlcyBmb3IgQ1ZFcyBpcyBieSB1cGRhdGluZyB0aGUgTFRT
LgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRnJvbTrCoGdyZWdraAoK
CkRhdGU6wqAyMDI2LTEwLTI3wqAxMzo1MAoKCgpUbzrCoHlhby56aGFuZzFAYW1sb2dpYy5jb20K
CgoKQ0M6wqBzdGFibGU7IHR1YW4uemhhbmc7IGppYW54aW4ucGFuCgoKClN1YmplY3Q6wqBSZTog
bW06IGNhbGwgdGhlIHNlY3VyaXR5X21tYXBfZmlsZSgpIExTTSBob29rIGluIHJlbWFwX2ZpbGVf
cGFnZXMoKQoKCgpbIEVYVEVSTkFMIEVNQUlMIF0KCgoKwqAKCgoKT24gVHVlLCBPY3QgMjcsIDIw
MjYgYXQgMTE6Mzc6MjFBTSArMDgwMCwgeWFvLnpoYW5nMUBhbWxvZ2ljLmNvbSB3cm90ZToKCgoK
PiBEZWFyIDUuMTUueSBtYWludGFpbmVycywKCgoKPgoKCgo+IEFuIG1tIHBhdGNoIHNob3VsZCBi
ZSBiYWNrcG9ydGVkIGZyb20gdXBzdHJlYW0gbWFpbmxpbmUgdG8gdGhlIHN0YWJsZQoKCgo+IDUu
MTUueSBicmFuY2guIFRoZSBwYXRjaCdzIGluZm9ybWF0aW9uIGlzIHNob3duIGFzIGJlbG93OgoK
Cgo+CgoKCj4gW1N1YmplY3RdCgoKCj4gbW06IGNhbGwgdGhlIHNlY3VyaXR5X21tYXBfZmlsZSgp
IExTTSBob29rIGluIHJlbWFwX2ZpbGVfcGFnZXMoKQoKCgo+CgoKCj4gW1Vwc3RyZWFtIGNvbW1p
dCBJRF0KCgoKPiAwZjkxMGRiZjJmMmE0YTc4MjBiYTRiYWM3YjI4MGY3MTA4YWEwNWIxCgoKCj4K
CgoKPiBbS2VybmVsIHZlcnNpb25dCgoKCj4gNS4xNS55CgoKCj4KCgoKPiBbV2h5XQoKCgo+IFRo
ZSByZW1hcF9maWxlX3BhZ2VzIHN5c2NhbGwgaGFuZGxlciBjYWxscyBkb19tbWFwKCkgZGlyZWN0
bHksIHdoaWNoCgoKCj4gZG9lc24ndCBjb250YWluIHRoZSBMU00gc2VjdXJpdHkgY2hlY2suIEFu
ZCBpZiB0aGUgcHJvY2VzcyBoYXMgY2FsbGVkCgoKCj4gcGVyc29uYWxpdHkoUkVBRF9JTVBMSUVT
X0VYRUMpIGJlZm9yZSBhbmQgcmVtYXBfZmlsZV9wYWdlcygpIGlzIGNhbGxlZCBmb3IKCgoKPiBS
VyBwYWdlcywgdGhpcyB3aWxsIGFjdHVhbGx5IHJlc3VsdCBpbiByZW1hcHBpbmcgdGhlIHBhZ2Vz
IHRvIFJXWCwKCgoKPiBieXBhc3NpbmcgYSBXXlggcG9saWN5IGVuZm9yY2VkIGJ5IFNFTGludXgu
CgoKCj4gU28gd2Ugc2hvdWxkIGNoZWNrIHByb3QgYnkgc2VjdXJpdHlfbW1hcF9maWxlIExTTSBo
b29rIGluIHRoZQoKCgo+IHJlbWFwX2ZpbGVfcGFnZXMgc3lzY2FsbCBoYW5kbGVyIGJlZm9yZSBk
b19tbWFwKCkgaXMgY2FsbGVkLiBPdGhlcndpc2UsIGl0CgoKCj4gcG90ZW50aWFsbHkgcGVybWl0
cyBhbiBhdHRhY2tlciB0byBieXBhc3MgYSBXXlggcG9saWN5IGVuZm9yY2VkIGJ5CgoKCj4gU0VM
aW51eC4KCgoKwqAKCgoKUGxlYXNlIHByb3ZpZGUgYSB3b3JraW5nIGJhY2twb3J0IHRoYXQgeW91
IGhhdmUgdGVzdGVkIGZvciB0aGlzLCBhcyBpdAoKCgpkb2VzIG5vdCBhcHBseSBjbGVhbmx5IG9u
IGl0cyBvd24uCgoKCsKgCgoKCkFsc28gbm90ZSB0aGF0IDUuMTUueSB3aWxsIG9ubHkgYmUgYWxp
dmUgZm9yIG9uZSBtb3JlIG1vbnRoLCBzbyB3aHkKCgoKYXJlbid0IHlvdSBtb3Zpbmcgb2ZmIG9m
IHRoaXMga2VybmVsIHZlcnNpb24gYWxyZWFkeSBpbnN0ZWFkIG9mIHdhbnRpbmcKCgoKdG8gYWRk
IGEgbmV3IGJ1Z2ZpeCB0byBpdCB3aGVuIHRoZXJlIGFyZSBhbHJlYWR5IDIwMDArIHVuZml4ZWQg
Q1ZFcyBpbgoKCgp0aGF0IHRyZWU/CgoKCnRoYW5rcywKCgoKCgpncmVnIGstaAoKCg==
