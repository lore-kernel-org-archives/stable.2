Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793091387;
	b=aCsZYLsmx94C9W4u9RPRUTSh36Ci44iQ2zDk+6t8bNq8NsXLWVnx6D6kOa94rq2Viw1E
	 2JTgDt0hrM/BC2Yyg/6Y6HkzzzbutHEkVzFcqwNxqPmBBu2uC+Ufa2EPNMN0PgjvMmvhm
	 JVp4SqjJ2eM9eciL5fxd3g0dRHI9bScPWal07ylT/UTlSSm5RKuNUodQ4XRR0d0lsEe7q
	 F3PPDSQz9tsR3Si1ZxWeK5snIqqD4pnmON+HgXzHKZn4/gi00i0fn22il6/sHWv8QaEfV
	 +sG9QPZOtcmAMt4xob3DX+jhFwpOmcojiamtVKJk4cnOAu8qodvP/x9MuWs56h0Gh+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091387;
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
	bh=Sh6Cb0H/E7rHoF+sL/0wAJYeSnWo1vhOAZW4/nCvark=;
	b=3Df/fcmQUMHPR2BnhF7D9SrkS03g8Ka+TA3iPx7GO6ilm/v7Z7YkuD2kBkc/UBjqj9B5
	 NdUMlS6M6yO41kVCrGdzfLh5PXUJMkU5m/79eMEul/eeFdosGhP03otOiWp70jmYKf5HH
	 OsUyNcSkO9fsAk2/1+mubDy1OpigcYezqt7Nl6rwsi0W1VwQNGJ97xLSAQsr3/jEG3aWq
	 +FYb7WV7fV9ngpOrgDc3KtuBNjUpFUXqX5CA/XjQ9rqm8ZxeeVp/rQoVEWVp5iWqnOTOy
	 G6CQ7x5q3bqZKodAr5GDZT6SFQ8NPuzWoUbAVF3DBkko8uh1T4TpXLJ2zLzMN1ZPJVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=QVKEdzUp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.75
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023075.outbound.protection.outlook.com [40.107.44.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202E606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4202E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=QVKEdzUp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM07/ha4aqoMYtnEcK3W0W9XueKVcpVgdsD0PO6MvCZWq3qQdeCMSDJLoq7vgAEo8bEl6p3F9cCaMTHz98KsxZgbsK7mZ2THl7xOkUBU9c2w5mKusHcaXxjR9XnfPvy7ShnYW83ybmhVvdCYHABjXz5pFZbanBa/NIYp5SvTT68uP1eb5wcUm//dCWyKUpcwhxh6Ifiw///rDKBZIJ2zjTxhgENq3+YBfkSe5h5RZUBRtuQNcnNWYjDTtSSnaZgzEbBMew/szygFsp8AC0KnG08xsDNVlQL3wtzvGIUh90vlTttp/d/a21F6dENTOQEDMKhpU+4Uj+CUiupzHAp5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh6Cb0H/E7rHoF+sL/0wAJYeSnWo1vhOAZW4/nCvark=;
 b=TTfXWZEYRn8gu4Q0aQFTQRl0Da/ZbB9CYYvhzkEh70PzOPe2cVqqiQMfpn3F5Zw+8jnU+kylisFw9TdBYl3ZddGpjfOysciUO+4eRqcRY725kgTjbFueApjw23Dd7GkWUXkgbKcojrHEPJeOy+ySlrdgRCLgpdFUZSYSd6brCokvdRE29tn4l8TtF4vZvzULbTJYBOwYxSEhnUOmuE/0zhXgHG5BzGie0S7f1tYPQc3dc5INcCDnW3jhqvkt+zCSojnqlBU54PoNAuKzCU3APPH8Ba/ZXvF7CgExcHHjrJ8eNi94t1i0hpqllLvSwX4XX94E1LsBmdGoWuIE6rutyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh6Cb0H/E7rHoF+sL/0wAJYeSnWo1vhOAZW4/nCvark=;
 b=QVKEdzUpvSPkOTd07XykkArGMZWVtV8dPphOMm52lgBAb1gE2c2gBlQTcpUqdFFzE8/rSLZW1C4I+dW2CIajkY1INH5xyvXPmmBT10yW4edWC3SPqsKPT6wfS8Sv07gyEpLnlqMScu4oSavI8sh6vcOtgz8angid/oSKZ0i35pKVslTlfRunPXe3j7yPf6pdAVk7q+wrjMHnsBmqYatVTD9v1mnur7cQoN2nB16UcweREPbNhOPPBuR6wDvAV3BswDkjjy4C6YlfPagIAxpl6WOdrKfG4WakcEbMQJr5cD41xiVXk67J0Ni747Yj3a+8xFwf9fnU94jmfpHST72FRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB7459.apcprd03.prod.outlook.com (2603:1096:400:3ca::11)
 by SI3PR03MB9933.apcprd03.prod.outlook.com (2603:1096:4:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:56:17 +0000
Received: from TYZPR03MB7459.apcprd03.prod.outlook.com
 ([fe80::d306:36de:44d2:3a3]) by TYZPR03MB7459.apcprd03.prod.outlook.com
 ([fe80::d306:36de:44d2:3a3%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:56:17 +0000
Date: Tue, 27 Oct 2026 16:56:16 +0800
From: "yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
To: gregkh <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, 
	tuan.zhang <tuan.zhang@amlogic.com>, 
	jianxin.pan <jianxin.pan@amlogic.com>
Subject: Re: mm: call the security_mmap_file() LSM hook in remap_file_pages()
References: <2026102711371963416812@amlogic.com>, 
	<2026102700-astonish-whenever-37b4@gregkh>, 
	<2026102714443948547539@amlogic.com>, 
	<2026102715-carry-strenuous-652d@gregkh>
X-GUID: 519FF3FE-4BDA-4390-852C-10D5E907C71A
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.213[cn]
Message-ID: <2026102716561458946426@amlogic.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SE2P216CA0129.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::14) To TYZPR03MB7459.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB7459:EE_|SI3PR03MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a7d591-b5ab-4429-5526-08df34082984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|261022113327099003|261022105027099003|261022075727099003|10067099003|56012099006|261026121527099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	nL3aTBQxLpj1KzGP2WkCD5EOQ8XWWNvUftyO6G87lOWa1TJobgHaat4dgwXydaQpIfp85pYB4gkBZaoanJc4mcu9llkuZDHGyZQWpcRQWPZc5WKx8O9hTm9BOhrBox3JEQBM7cX6/caxHyfGaD7YDxN3mzM4w9h4Pc79GmGv/gZkjvWRX1lTLQ6cBkW0Q7haT28dY1Gkpkv9BrNTrAz8Bb5rgXCTPijD9ql+7mxCqwzc3PsUUIQiwxsagUZ5n5dZVcRfHrhaERi+VdisUkTA6sII80jpRQBN3SZAEFBITcaPgsIM13l7KDQTv0t3l4L1DsZOtLfz48KgOWvYo4H25KSBJqqNnMNKcM16hu8Kon1I9m3XD+AhM7b2V2/H4jbeUnausnMXRjHj2sVhAhYaHXnTXXeuWTkCbx8CLb5wIV+f6HYUVVUKUuQW/NVBg3C/Ko7laXank3oBAHJJrkPyp/9gSHvAuvAxzrkMBPtZ4O+jgkUvsbUEf3awDjIyiOnbDfML1KR51GWZaLPo4CI4vUHXt6pOwMr9vlrID0qF2r1Yrqsztp9N1ckYLot3PIHNafdgXoSlk+BsucNuQmFaHucZLBvtHF2GPtxP3iiPB5IF7cJq/0w6M/Z7V/mZapGUu6khayypeRpSunCKfymjLtTgEKsWy6bYS1YRoWEo6rU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7459.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261022113327099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(18002099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NjS1llWFhWT0JibEhKUlBZMlkzSTl1V0Y1OFZrMlVDNHFUcE5OOEsvUzdL?=
 =?utf-8?B?OVF2c3k3eHYwU283a2hKZnF0U3N6VWNFVk04SjlVZ1hCOThWN05HSGVMakd1?=
 =?utf-8?B?SHA0QzR1MkltTkVpOTBJdjNETmQrM08rZE1xdjNZYVR1eW5QZjhVa1JLaDYv?=
 =?utf-8?B?MlY5UW9hOE9kSldPaWVydXRteFJCRkJKREIrbUVPNW81ZGlnZFZKcnRmMEJD?=
 =?utf-8?B?YXZaUlRuQVk5TFVld2dnQXlOalZmL1lUYWlwdi9najNGdGU1bG1jSENiQXdC?=
 =?utf-8?B?elJNNW1oL0t3U0tTdHIxOE95Nm5Eb280RVhMU1IzUVNWL1lteld5WHBaV01n?=
 =?utf-8?B?ZkRrWGI3bG14U1lxNkVjKzJxUTcrREE5TzZCODNDc0thZnBWMGZUYnRlL1hX?=
 =?utf-8?B?S3VMcmZlcytZd0NCV2ViZW1OWFptcWVVaG5URlZGVUNBU096NnJUSkxRMnBo?=
 =?utf-8?B?aWRMU0gwNjFBVnA4VjlocCt3YSthM2Y5TVJBSmdEbFVrZk5xQkdDQVNIbHZo?=
 =?utf-8?B?a2IxdWxzZEF1TjhlUSszV3JuOWhaWDR1TFE3Q21pRE83Z1NLR3Jjb1doWms0?=
 =?utf-8?B?Z1hyV0JZZ1MrRzJZU0dqNmU3SVVsbjZWcWZ4WTVrN0huSDB2dUlkRXo0RnVt?=
 =?utf-8?B?NG53OHpCRmpEUkNyNGtOVVN4MUg2b1p6OXVFL3RPWDFLenB1TGgvYncvend6?=
 =?utf-8?B?M1NzcVJmWVZaUXVnMzB1Y1FwK1hxWkJXZnMxcnlMRjdWYzRrU2tMS0U1TWFl?=
 =?utf-8?B?bmIxZUlpL29Vd0xWWVVMbFlhN25CSEZyRk9PUmhzWHg3dDVTRG9ld2RwcnJr?=
 =?utf-8?B?TW5zV1MyVlV1Y1lKZ2lOTHhDd2hPakE0RS94MytrdVdjS0RQNVQ4SEFZUDlB?=
 =?utf-8?B?bENmSjQ4UmxpWFI1WWpJNGErdnBVYnFFNEEzYUVQUk5qWXRrQ2tENTdLcUV4?=
 =?utf-8?B?Z0cwRnUyajRwYVV3UlVTMVovb1d1bzl5K0ovNFkraHpvWk5Tc1lSNmhPc1Z4?=
 =?utf-8?B?NnoyaHVMdGVTL2tKb3QxUUNMTDZNZUZUK2tVTVdVRkJDKzFFYlJqam5YemVa?=
 =?utf-8?B?MEw3bndqVWpQZ1Z5NEo3aVpDbit6aWM1Slp2ZTBZd0RTSXdBY1diekNBOGpr?=
 =?utf-8?B?TWpYbUhlNEE2WXBwZGd3TW95VEVmVk43eER6RDkrWnpIOEhnMkhvTENrZy9i?=
 =?utf-8?B?eFZQTmVRK0c4VXBMTFNvNXUrSGNadDE1UGJpd3M1dGxTZTIyZFB4SGsvWEFJ?=
 =?utf-8?B?emExOWc2bS9HSTljS2JkMDNNQjZYRjhYUUJDVVZyK0NRekZsNmhhVklSdjZD?=
 =?utf-8?B?d2VxZXVVSmlRZ0x1d3RCeW5TTmNCaUsyUys5eEQ1RW5NVEsyM1BUOUdTa1R5?=
 =?utf-8?B?V1NnZWJJNUlqM3NhbGxjRmdEZWlPRHFJS3o5LzNLYWxzZkY0WUN3VktVRFUw?=
 =?utf-8?B?aG1DL1kxbHloaUR2MnowKzM3SE1QR2dXdTN2a3FVREQwbmRzVXZFZi9UWU5D?=
 =?utf-8?B?Y3BJOFczanE3dCtpcUZVT1ovYk5GOFgrMlFEYVZTNzltdGpGRTVhbnVYTXhk?=
 =?utf-8?B?OFRjQkZpb2l0ZGd2TzZxY1l0N3BGOWNWY2RwaHQrNHI0N2RTTmhRTEZ3UlFK?=
 =?utf-8?B?ZjBpYWVLbDBlU2dkeURQZUl3QVRkMXNFbitrM0FRRXZkZ08yZXN0Rm1vcC9H?=
 =?utf-8?B?OXRnd0gycGlPNlg1VW0yNWp0Y2Q1VitqRXRRNWZHcjVjQ1Q4MzNvTFM4Ti90?=
 =?utf-8?B?SDN0Q2xqZHhTOGdodDdQNmR4VGVEZlh0b2thK0F1Qmk1WHlhYnRYT0t3ZmMv?=
 =?utf-8?B?Y1l6cHBnMElVbU5RaGZPK2tpazJqN1cxalBNTUdqSFRNUWwvYUh4MnhPcUhJ?=
 =?utf-8?B?LzRPclp2b1VYRFV3MktFTndRT3FrY1NMQWE0b0lJclU1ZW1MZXUveFNOQnY3?=
 =?utf-8?B?NEhLYVNiQmd1TnFMdDhQTjNrRlM3VUxXK05pQTRRSDNrRlczTGZoM2k3L3ZN?=
 =?utf-8?B?Ti93Z25lbkEyQThNMHEvajI3TGlMMmU2bGdzNVhPeEJ6T2l5UUNma2crRHhi?=
 =?utf-8?B?bTNNODJla29LeG4xcFZkU1hqTUZzN0s4dUdSa2MzUkdSZXBWd2hFUjc0Szd2?=
 =?utf-8?B?WjRhK0FBUEZpcVlXRG8ydmhucGVtQ21UbjZqWm44MWxPNXNhdU1Ib213Yi8w?=
 =?utf-8?B?NHhMNndxVy9hVUFSYW1HMFBOUElqR3JHRXVJYll1UlBIQ2k4V1B3eUhaaWM2?=
 =?utf-8?B?SHZoRlBqWjQ3MTY5UlA3c3V0a2VXa3dCbzltc3BGckR1RGY5UG9zSWJBRVBn?=
 =?utf-8?B?R01lMk1aTEVYVlFkRnpFQVdKYXRUT05PdjVjcUlGQVpaV0V3MncyQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a7d591-b5ab-4429-5526-08df34082984
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7459.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:56:17.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W97wfgpjQx9NAZZA1P0CtQO9SnWfl+O74f2LwSUBawNioOsUnywpDrevbwiy7DpjP/lyn2nnA1mvaHh7upfz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR03MB9933

SGkgZ3JlZ2toCgo+IG9yaWdpbmFsIGNvbW1pdDoKZWE3ZTJkNWU0OWMwNWU1ZGIxOTIyMzg3YjA5
Y2E3NGFhNDBmNDZlMgpJZiB1c2UgdGhlIG9yaWdpbmFsIGNvbW1pdCwgdGhlcmUgd2lsbCBiZSBj
b25mbGljdHMKIHRoYXQgbmVlZCB0byBiZSByZXNvbHZlZCBtYW51YWxseS4KCj4gVGhlbiB5b3Ug
aGF2ZSB0ZXN0ZWQgdGhpcyBhbHJlYWR5PyAgQWxzbyB3aGF0IHdpbGwgdGhleSBkbyBpbiBEZWNl
bWJlcj8KVGhlIGN1c3RvbWVyIGN1cnJlbnRseSBwbGFucyB0byB1c2Ugb25seSA1LjE1LgoKSWBk
IGxpa2UgdG8gYXNrIGEgZmV3IHF1ZXN0aW9uczoKMSwgV2hhdCBpcyBhICJ0ZXN0ZWQgYmFja3Bv
cnQiPwpJcyB0aGlzIGZvciB2ZXJpZnlpbmcgY29kZSBCVUlMRCBhbmQga2VybmVsIGJvb3R1cD8K
b3IKUmVwcm9kdWNlIHRoZSBpc3N1ZSBhbmQgdmVyaWZ5IHRoYXQgdGhlIHBhdGNoIGlzIGVmZmVj
dGl2ZT8KCjIsIEhvdyBzaG91bGQgSSBwcm92aWRlIHRoZSAidGVzdGVkIGJhY2twb3J0IiB0byB5
b3U/CkFzIGEgcGF0Y2ggZmlsZT8Kb3IKYXMgYSBsaW5rPwoKClRoYW5rcywKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQpGcm9tOsKgZ3JlZ2toCgoKCkRhdGU6wqAyMDI2LTEwLTI3wqAx
NDo1MAoKCgpUbzrCoHlhby56aGFuZzFAYW1sb2dpYy5jb20KCgoKQ0M6wqBzdGFibGU7IHR1YW4u
emhhbmc7IGppYW54aW4ucGFuCgoKClN1YmplY3Q6wqBSZTogbW06IGNhbGwgdGhlIHNlY3VyaXR5
X21tYXBfZmlsZSgpIExTTSBob29rIGluIHJlbWFwX2ZpbGVfcGFnZXMoKQoKCgpbIEVYVEVSTkFM
IEVNQUlMIF0KCgoKwqAKCgoKT24gVHVlLCBPY3QgMjcsIDIwMjYgYXQgMDI6NDQ6NDFQTSArMDgw
MCwgeWFvLnpoYW5nMUBhbWxvZ2ljLmNvbSB3cm90ZToKCgoKPiBIaSBncmVna2gKCgoKPgoKCgo+
IEkgaGF2ZSB2ZXJpZmllZCB0aGUgZm9sbG93aW5nOgoKCgo+CgoKCj4gMS4gVGhlIHBhdGNoIGNh
biBiZSBhcHBsaWVkIHRvIHRoZSBgbGludXgtNS4xNS55YCBicmFuY2guCgoKCj4gVGhlIGNvbW1p
dCBhcHBsaWVzIGNsZWFubHkgb24gdG9wIG9mIHY1LjE1LjIyMwoKCgo+ICh1c2luZyBgZ2l0IGNo
ZXJyeS1waWNrIC14YCwgd2l0aCBubyBjb25mbGljdHMpOgoKCgo+CgoKCj4gZ2l0IGNoZXJyeS1w
aWNrIC14IDBmOTEwZGJmMmYyYTRhNzgyMGJhNGJhYzdiMjgwZjcxMDhhYTA1YjEKCgoKPiB3aXRo
IG5vIGNvbmZsaWN0cwoKCgoKCkJ1dCB0aGF0IGlzIG5vdCB0aGUgb3JpZ2luYWwgY29tbWl0LCBw
bGVhc2UgZG8gdGhpcyBvbiB0aGUgb3JpZ2luYWwuCgoKCgoKQW5kIGFnYWluLCBwbGVhc2UgcHJv
dmlkZSBhIHRlc3RlZCBiYWNrcG9ydCBhbmQgd2Ugd2lsbCBiZSBnbGFkIHRvCgoKCmluY2x1ZGUg
aXQuCgoKCgoKPiAyLiBPdXIgY3VzdG9tZXIgaXMgdXNpbmcgdGhlIGA1LjE1LnlgIGJyYW5jaAoK
Cgo+IFRoZSBjdXN0b21lciBoYXMgcmVxdWVzdGVkIHRoZSBpbmNsdXNpb24gb2YgdGhlc2UgQ1ZF
cy4KCgoKPiBhbmQgaXMgdW53aWxsaW5nIHRvIHVwZ3JhZGUgdG8gdmVyc2lvbiA2Lnggb3IgaGln
aGVyLgoKCgoKClRoZW4geW91IGhhdmUgdGVzdGVkIHRoaXMgYWxyZWFkeT/CoCBBbHNvIHdoYXQg
d2lsbCB0aGV5IGRvIGluIERlY2VtYmVyPwoKCgoKCj4gRnVydGhlcm1vcmUsIGFzIHRoZXkgYXJl
IHVzaW5nIEdLSSAyLjAsIHRoZXkgY2Fubm90IGFwcGx5ICJhdXRvcGF0Y2guIgoKCgo+IHRoZSBv
bmx5IHdheSB0byBpbmNvcnBvcmF0ZSBmaXhlcyBmb3IgQ1ZFcyBpcyBieSB1cGRhdGluZyB0aGUg
TFRTLgoKCgoKCkkgaGF2ZSBubyBpZGVhIHdoYXQgdGhpcyBtZWFucyBhdCBhbGwsIHNvcnJ5LgoK
CgpncmVnIGstaAoKCg==
