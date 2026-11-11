Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400108;
	b=3n2rZAEPBPKqH9ukm8BFCWoq6C933TaJ3E2QPS4v4owirNjcVhLZmLf6j62h3/x1FeWD
	 43Q+n2C+D26lS0NcjnKNgfULnuSXP7w+9/RDG+JX8Nal9Z4HenGki5YzX9iDM0BXbXtwp
	 A8EXfkieUQagnNj/RJY9EpoQS3XXlno2fksH/Kd6AB9zb+Jd43t10x7VD2HdmmP20wfZS
	 pPiyYnbnKK9Bbl7NIX3b3plnwc4r+yfM3LDNEm1BBUGn347HyoKBFdso0Prh5SUl2ASGR
	 sXjeo2RglN57LAsfQz2I99FwJDvSZ3TFUo/66dZHKscIFmGlWcQ3djG1JoUxI7ElQuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400108;
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
	bh=MVJfMD4QWmSkDzOTCpOE0oPkr8BIjZuPT6YXdxnAuxc=;
	b=OLM+GH5PzIYDQ9E6Ov3U363r4voX/1DEd4PyvTZhYpozNZsonkU5fqUIs0UJ9OR267Tx
	 gu4kIUY6l0nOynGIHf7MhZOTOlARGO0LkltabbIKtGnvf7VIFIc7EiIZPk7yf7Tvc4ccC
	 Lb+Eyl4Bczinr5IQZs2GWKwp6Io4Q3sOXwJPnSyGQT+VKXufCdi2bGc6A3Opt8euN/jC9
	 BQB/xXEmUxnWCp7xnGtmEFpBqczWIS2dBkejgVUJdKeNhPcZ7gm5oGf8kaV/9NxkBVEP8
	 GJC/NknhqrWu+tNCk4iK/oJMgWVXT9oNabNwKmSRkbrsAeZSCv69SOFJsBkTEEMYcRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=ZXEtKzz7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.136
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023136.outbound.protection.outlook.com [40.107.159.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C47606A327;
	Wed, 11 Nov 2026 12:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C47606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=ZXEtKzz7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI1pUaeAMyZ7SUGXzOuWh3gcZQcBTHgfopnWS89lKYlDeXfy4BWd4B9Ah03DTGNrH6PIlH8mn90/bs/eCYEPxMSMWDFcehqnC33Uj2Qbz/Rpw+jQFu/3mXVaQoViolvoUf4Yytkhi5icbR2Z7i3oydBbmVD0qrcVMfJU2AHdxmB1TD2oSp+/5uyBD2e9Z+59qd0kzeP3rQarekQMU74LrwI2kLgpVyqQ404QmLJsg12mWUr/GWu/OcDqicrjntd8Po4GGLSOXPZTgCcKTeKgYWmD1rVv+mYftnJuZjZNmes8RJw0/qnMnO/bGJk/D7cLq5dmIvS31REuVpbcqlprig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVJfMD4QWmSkDzOTCpOE0oPkr8BIjZuPT6YXdxnAuxc=;
 b=mEczn+kdpgA75W7GAcb82xO/w7bfn+B/Yjro7Ae3KLQruKqIx/P2BZgXwOqU0RcbT0Tj5LOa8T1ilCXhvKhcW54rYQ4QiWsaBxw/QfMFpTmB6rcULM0crvwZsYM72HSkiPnHLROIacZ5Mg2TiaMEZtuaH5Vcge9u+BRtbvQ5Sk6/echuWHYSSP68U9Mg7ZeR1YN4OcaS8+hzYn5OLBQY5eMpZ0980wB8rT1K0yed8W+aX5UvhhAb80YMQOGGTWxcyDy5K3Jk5EqlHvyU+rDe2YlLMuuvhaGaJY5IBpTXLYrI9Ia/gS23HWKb8T0czlZNzUowTzVQwOjfeOGOJoID2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVJfMD4QWmSkDzOTCpOE0oPkr8BIjZuPT6YXdxnAuxc=;
 b=ZXEtKzz7ssTpLKNk/6L4wAiTtEL/xQuI/7ISxriIOS0ry0FbBflhpAOB1yEfxMbmMRSDW4MVfPdglFBKgKqES/e9s10WsP+s4xZUfdQ3L0/uFgK440Pex8ip9FXe3LQldknfpXexAofZ8o+V+6zGtGt18o8aEa0jUfDu1Mt2Ce9cFncGQxZO6hlHKVqxGUXDOzkoXbet7MsQmAzxwaklfwsI37qfGmoDJkOZpfAIZBAzAcGYE+4wlNTOLzQ37+JuUh4qFGg/cu2+XwH5sQqlsePWbjkDQu/8XNthLYCPZgifFbM/0E6swxYuMq9ScPK6SDWLaFshTIGqu6QPz1EwEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by VI2PR06MB9091.eurprd06.prod.outlook.com (2603:10a6:800:22f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:28:19 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:18 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 11 Nov 2026 12:28:00 +0000
Subject: [PATCH 1/7] serial: max310x: Look up all channels before adding
 any port
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-serial-transceiver-supply-v1-1-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
In-Reply-To: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=2720;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=RF28z920+paF4kFFam6PLy1kV9yfaSkASmN7bHHw9qg=;
 b=JNBfyEUiZxJNtpmaPFe+YeKqr/eSFCeExbGSk21cjYrOWN4A46Q0Na27DS7NZZRr21CeNKriM
 VpZHu2bqCE0DPKZDCywfuwgDlglpird09B2iBBQuNfq8qmnF95d6Ioy
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|VI2PR06MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de7ab92-6911-4d46-b716-08df3fef423c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|23010399003|38350700014|261026140227099003|10067099003|11063799006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|56012099006|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DKiuiafAk0ycF65nsmgUqOAhKZbvxv7kpK1ngE2kU/OKyoNf7itqT1/M5FUIw3+1Vvh3QqY7YGtAN5f0VHdMblBDPlYXfEE44pCkdYuZmJA0KUKomTfVXmfaog84n2qntRF8IaXuOFk/xTNxb9c9XhcjH69c/7WzprfTCL1s2+rVFbOCFxkNZIiCGlpGBjoSjCiIhyDiu4ijyAIvstZp9t7dTLJVajdHYvcnfdXyfCytEigr9Sj7tPkXTV9lvbBGHl3xXLlQ8x5g3fDzwEl7Z6rWMsERbU4eYvMa8J11JIivH/pgjqWJ61QZEDK3enmUyxwhCDB0+ZZsFLSLk+XoazcZCItPvfmQKScELtZJ3Rx7qrGem966ge60gmkGSpP2TghVE9U3rM4/sfmXglaPkbIEild7DHz/bCfngFKweS68xCRhSZ+i1NnjLOD+zbDdFcTS1q1SfDSTRL8wbcEMvWmbo4q90OMBDWIHw6jIaDUIJcjNQYZBw9axipAZiaPab9lg4qcDj+FVlKt3UIazNN8476la3XuRPHb8Z6mIdBsgxmzVAHsF1+fCIZvDux7mMdSDconD9dxrxMixlOYNgscDEQmiha7yLGRBA3BHUYac2CJDIzcuwDJh6Bp60tckQL9X9TEqrspeHaNkQvSZNhL+5hx1+Taw2BU1EfEHZokq3v/qYMbFTPVpzdMyxfkvlQ/1gh7MDd5rTfR+SSkzvxlul/ShQUEB8wHMH62YObs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(23010399003)(38350700014)(261026140227099003)(10067099003)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlhDd0ZHcFN6UFRhbWlvR2ZOLzJxazQ2emNSQVE0TWVoTTRIQmFISWV4T1Nk?=
 =?utf-8?B?cVVJVlU5NzFWTnJNQ1NKZjNnWUdQYm9yRU1zZWNUaENVUUYveXNxUForVGVl?=
 =?utf-8?B?WndRTGpLclk3ajRtSFZ5TXlrQ3M0T2FUQ0lpL2pEVnZiVzdCakl0ZFp2UmVY?=
 =?utf-8?B?WTA2TmFxOHdXMzVrWWtlTW5nbXMvOXY1MzJLTU1sdmYxZTVpdEoxeEZmcnZB?=
 =?utf-8?B?THJQS3d2bjlTdU9wd2tEd1I2NzUyVFFvaGNzbVlMTXNBdHF3ZVR2SERJaTNr?=
 =?utf-8?B?RURyZUc2dmJ6RE9lSlllUTlSYTl6MGlCOW8xMUxpbzFEYWM3QkxORUZGc2xP?=
 =?utf-8?B?QnhTZ1BpVjdJOUlaQVFZS2FFcG1JRWFqUWNTUW1FSDUwcGMxWXlIbHUvNXhO?=
 =?utf-8?B?Sk4zYVdDOEVORmZRVE0vbjZmVGduZDNibk5JVDFhaDdpRzlaU2J4RXlOcnZ5?=
 =?utf-8?B?R2wrUU5kOXRBTlFkTVNGNTBueVpxdHpZN2hWSTJXQTZvWnNRY2l3cUJhZ1Rn?=
 =?utf-8?B?eWlpYjNYWENMYUNReXlMNVByUlBDUlNMTVkwRWxkMVgvL293bTdMWFVLMWJB?=
 =?utf-8?B?TitxTU1KWXYycEVYMkVRWVlqZnNNVmgzd1p1OGx3bkM1STQxYlZjY1prNWVD?=
 =?utf-8?B?bUk0S1B6djFNRlowcmJHRHBJc2E5TjVOTCtibnExeisvczJTNmR0dDNxMDZJ?=
 =?utf-8?B?VFl0WkdqeW1mNWRyTDQrNFQ5aWMwS3VMYVlJT1JTUDMwMS9Ib2xzdE1WK3Nu?=
 =?utf-8?B?d0tvVE83MHNLd2NBUmRXVzRBdEdjNkRDWnczSGlHamNrQWZtb0JReG9sY2Q3?=
 =?utf-8?B?bk94d1FodEZNK2FXWWNaQmxoTURGa1N5TTNZWWlkMHlET3czOGtGSXo4SFlq?=
 =?utf-8?B?WG5DVGFidkRxTXlUYm5TMDJ0aXZzWUhWQzI3TmZIZkV4T2ZqUnpVWXFzZWo2?=
 =?utf-8?B?bkZ3L3RhYWVXTnNhVjlnRzRCb2pDYVZCcHFZUTcxdHZFK3hEcHdzQnk1KytC?=
 =?utf-8?B?NFJMUjlaMGJpa0dBbmsybk5MQmFuczh5Mm81RGlySXE4ZDFuQmZoRmNtUjNK?=
 =?utf-8?B?ME5FcHVCcVNQdnJKd2ZwenBQQ1RBMkllaGttanBaN1dqemticGgvbUJHUUh6?=
 =?utf-8?B?SXArUVVscXNoSDdkVUVSeGx5bkd2ZW5KdEpidDdDZDBYRmdiNnp1SlBCeUll?=
 =?utf-8?B?VXZHUUpPbHBYNTJ0NTArRVZDUnh5YmRjQ1ByOVBlbWx3Q1Vxa2xJUndLcGY4?=
 =?utf-8?B?bkMxWXVqZGtka1UxWWxDeUJKWGxPL2pvSEI0a05BbHpac20yUnpybFJNVFlP?=
 =?utf-8?B?UW1jaHBFcXd0VVpNbDZsWk9oaHJxejViMnNzU1VPTlhNRDVNYXhLWTJ4RDQw?=
 =?utf-8?B?cXdPeWF5VmE1cEx0cVpMaDRRQmhrV01rbDc5RXNGK1F2TkthRzZlOXdaMUFz?=
 =?utf-8?B?Ly9EVnVIcmRJdXlWRFQyN0dQaDVQaE90d0NSbkVwbXVoZngvMUtMdzF2elkw?=
 =?utf-8?B?U1BLUGw1cEhOZ0dlK2FZNVpWLzdhTlJFYTFuU2IvSW1SaDBNVU5FQzd1dHNV?=
 =?utf-8?B?MDhlZUxjSDd1REhzUmFiZjJ4OHMyNGk5VE1vb0czNHU5V2haVUlpczF6QnAw?=
 =?utf-8?B?dEhlam5ReWNkc0lxa1d4RDU3dk0yWjJJUE5PNmh5dWpaRERzR3FqVjJKazV5?=
 =?utf-8?B?OWY1UjJuN1NpOW5MYTE2U3I5SThDRDlTYjJCMENkNVFZWXBGWFVwelFEbnND?=
 =?utf-8?B?UXA2SW9lUXBhV3FHR21IcW9TbHdGb1p4S3hNWmQxaWU0U3lhc1NrWXpDSExL?=
 =?utf-8?B?bFMrY1BlOFRkNWJUY2RMVTJjZ2hSVlNWYzNTL3gwVVF2ZytjMzcvZXA4V0ZW?=
 =?utf-8?B?bGhwQUtpUlFqTFJ0b3NsYkJEYVRJbERDVjduUzVlVWpNeUlYaGVvWmR1Uk1z?=
 =?utf-8?B?NlZRSmhZQTJ6MkhTejFFVjFFMyt1QVZ3YWlXdC9xOTdzNC95OXVEY25IVHZa?=
 =?utf-8?B?ZW1MS0dhb3BhMnJ2ckMwQUsxb1RSS3U4UzA1WXZWNmxYbm03RXZlaEdkcjN4?=
 =?utf-8?B?M2lhUEZMSEJydVFlTDVqWHlsaHlwNzZtOGtMQ3h4NVgxa0RRWmt0aloxTWt2?=
 =?utf-8?B?Q0dQUlFzVnVXU3lOSzNha2ZyaE16MlR6eWJNbmpYN2ZSMllTY1E4ZTE4Z0p4?=
 =?utf-8?B?dmhJbjBoTzZmdVZaeWM3NkVleTlrRVRwQ3RFOWVSUzV4S3ZlUXdRK0ZGUDhp?=
 =?utf-8?B?d2VWVjNURDNPQlBXWjBjaHYzb1g4dWlBL1J5QW8zTUhsZ2g1YWI2WFJBZnZ1?=
 =?utf-8?B?REQ4Z2RtTllWZ01kaG9sUFltWW9ESWtQYUUzS011Tm5yUk9PcnB1cHFCTjc4?=
 =?utf-8?Q?X9Vjrbg0eWtSdHB0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de7ab92-6911-4d46-b716-08df3fef423c
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:15.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcWoAMrby+UoqM+WcB4La00ph0i0vlgx5lNFnwZB+r1Y2NT6vvV8Ut+J5y/m3NMTOwgHWSfLTZ/Tzxv2YZAlkw+Q+4kxWbLWclqh4PivW1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9091

The probe reads each channel's RS485 properties with
uart_get_rs485_mode() and adds the port in the same loop. The GPIO
lookups in uart_get_rs485_mode() can return -EPROBE_DEFER, and for
channel N > 0 that happens after channels 0..N-1 were added, with
their serial_base child devices bound. A probe must not defer after
creating child devices: the bound children re-trigger deferred probing
at once, so the probe runs in a loop for as long as the GPIO provider
is missing, see Documentation/driver-api/driver-model/driver.rst.

Read the properties of all channels first and add the ports in a
second loop. An error in the first loop goes to out_clk: no line is
assigned yet, so out_uart would test line 0 for every channel.

Fixes: bed094602ffb ("serial: max310x: honour rs485 properties from per-channel DT subnode")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0ed70185555eed745d905b36c8b8f162468dd6f..bdfdf4a9000bbd18509746bbfd8ed0ade8164598 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -2010,18 +2010,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_uart;
 #endif
 
+	/* Look up every channel before registering any: lookups may defer */
 	for (i = 0; i < devtype->nr; i++) {
 		struct fwnode_handle *saved_fwnode = dev_fwnode(dev);
 		struct device_node *port_np = NULL;
 		struct device_node *child;
-		unsigned int line;
-
-		line = find_first_zero_bit(max310x_lines, MAX310X_UART_NRMAX);
-		if (line == MAX310X_UART_NRMAX) {
-			ret = -ERANGE;
-			goto out_uart;
-		}
-		s->p[i].port.line = line;
 
 		/* Locate the matching "serial@i" DT subnode, if any. */
 		for_each_available_child_of_node(dev->of_node, child) {
@@ -2050,12 +2043,23 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 			device_set_node(dev, saved_fwnode);
 			of_node_put(port_np);
 			if (ret)
-				goto out_uart;
+				goto out_clk;
 		} else if (devtype->nr == 1) {
 			ret = uart_get_rs485_mode(&s->p[i].port);
 			if (ret)
-				goto out_uart;
+				goto out_clk;
 		}
+	}
+
+	for (i = 0; i < devtype->nr; i++) {
+		unsigned int line;
+
+		line = find_first_zero_bit(max310x_lines, MAX310X_UART_NRMAX);
+		if (line == MAX310X_UART_NRMAX) {
+			ret = -ERANGE;
+			goto out_uart;
+		}
+		s->p[i].port.line = line;
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);

-- 
2.47.3

