Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402F3B27DB;
	Mon, 12 Oct 2026 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820222; cv=fail; b=cGbytMdOYR09tE/OWa5XayGiWvHw0Wk2tJf1goRyvdjHu1d7YJqiw0H06AutO4awdKdV/LNLgdFxSErVfJLPUJf5NQ4Sh4/79rqE0NldLUFq3MejYkykVJtX7Jhg+CWawe6t/Wq8ppAlJD1sIY/PdTx81pAGVG+w6azJc56KlBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820222; c=relaxed/simple;
	bh=LcXk7csBS02ZH6YDLFV4BA/BWVXrQ9uxT8cLPOasfkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qWmlUt5dXPoQ29+caUHEsfIwCf2uZIyd2tnNFz/7r6gLkJZnfhYcBYlX7NRBPyN1sZOvVXugTa0ILDsBoUvgIAwDGeLFUtTi3R0hdmc9VB2t1m8tUdgx3EWVAqPHBki/SbgZ/tKMUgrcPlayKUWZSJG/DLUTN4GwNCPyr8Lf3Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=jEGon7Gb; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RVbYkxzT; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="jEGon7Gb";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RVbYkxzT"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFg0De2563730;
	Mon, 12 Oct 2026 11:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Q757ybuTG28sMUHepjjOmGiOO7MRAtngvBGPMr6naaQ=; b=jEGon7G
	bt1qwXOCX2pQnputpGKZG6QFq4b+DnJjimWu70WuiuXx5bPdskWxY6361Ee5yukV
	wf22WfAHsIhNxg/YTAeY2EYGNVFQu7KtzlUUqMIU15Y/uglhsbRyGT+P4n2SBMp1
	exU+TSXMTuxrgmAnTQ1OwJWFeOWO7LV49k3x4THmINZ+lzrJmm//Uo7pXHlTReZj
	1VhkzFjLWYtLVW3S17nOL7pTM5mGz22NF0SXVdhgeYsXBDu069LUsUbsTEckr5Y7
	lA/WqVVSM63OtjHLlJFf83/t2TFz5g67qOfRePX9kDRAxYlZa36Z7h4+WnxtUr9v
	N7IXNnpoWmHnb4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q757y
	buTG28sMUHepjjOmGiOO7MRAtngvBGPMr6naaQ=; b=RVbYkxzTSimniq+mFrshP
	UQkqg2R4x/HWLnp6askNJJTpXliT14t1Qxsca27XdCQNjojSMcacFczFIVZPG7B2
	LeRPJtVDvgQwk+8qPPI6COXA81MmFEeeM/9mCXhzluq0vkASGpRuD/+o4kOwTbx1
	/HRzuzataQeHKliMc6mYr0xenEts6fvIaLe0P1BCHZqk5H+QpQt/22FL8lZxJcz7
	zAlyHC7vB5AP1Ew+v4nBHnIAdmTARYiAFnUbtoZRkFv2wk9Q09GLBQiMgdI8NW3t
	J0F7kPn/W32GkdQJ0OC4GGaBa0m52XtW6G3kJ74vrqf5C19EbvXXWU0KxRmvYyII
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h87dgpqdf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:50:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+vSpf/auC6o7A7/M4EhsCA5BF7TNgdaFY2qtwP2cv1mjnIRfy25eRReCO0CGP2RA+MZepApgIatJpZs7vfrpUv5bNysXI/vEPjBX9AUDEnaTG1cN/vtY2O+21XL3rIom5qv2ylyv4DaQ+FteW7pu2cSe1+VBro4PFHr/+RkD3q6XpSYLQU+SszMdO2M1ikWUtUXMlmDUaQbBgtfHNcBIrJFzgOJGPnokOqJy+QsPTSuOosRJWOHYq1Jo/tXsH7SSF6+UBMMkfKvwkMcNAe7v87BMlHeWcaQNewcI3v6AywZlI3eI9oVQ4fsWWOACVsddm7jEiSqMczjKG/oOFdNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q757ybuTG28sMUHepjjOmGiOO7MRAtngvBGPMr6naaQ=;
 b=ovxHp2wsiZFmLwJOrzldreLlKiVmvnCyFipt7xrUaHNHtGTKShTRL+ynFkM1CPGD1P03yg2gP1LgDYCZoU/H26f89EQSPneFwJVGBOTUF74Tt6+lhdokZ1z10BiRXWBljjY9uGAiMdJj+6GOyT/gHXimmdQ2ggnYoF7bpEb89Tk9S8oq70pmNJRjJpYWZIr9CcZWqgKADf2i4FEl8R96KRrZ2pqsaEghP+e4ak7W1gXP6MoiHdmdrGZbfxjhPv4mOUD985LEci3hr0WxXAj6mncTbWfmhsegwMxhjC/KiEfFnGWkzkjCAf2ylPUFcTWUEAqkXpGiBM+cMtt5KfhEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB6440.namprd03.prod.outlook.com (2603:10b6:a03:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 15:50:02 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 15:50:02 +0000
Date: Mon, 12 Oct 2026 16:51:05 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Alexander Sarmanow <as@discnull.de>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Parthiban Nallathambi <pn@denx.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: Fix reversed ALS mode bit
Message-ID: <as0B1EnPqfwRO1D-@nsa>
References: <20261012144315.1678195-1-as@discnull.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012144315.1678195-1-as@discnull.de>
X-ClientProxiedBy: MR1P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ec3b10-1e9d-4449-300f-08df28786fd2
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 TafQVoLSnRnKaK/WrNQDp9urW0sZ1soQ0xEaYzimu2uzKp4w1K2Z6jPSQNzYl/Js2qRw87eXI6krTI7zcZiKnKMcEj0bTI+I+me82DZgTFVBHgRzEecF/jkVZkWyMOcX34drMlpKAYBCJy/cYzygfh8cm1CkpTwGkCiK3Y5+tF1NUBPLuBJhBVeq0lb7t201hgQXCydEN24QifvpS8Q00so+UFiAWUhYfGnj7yiJEJMjnbNWhx1njyL0XaLBlAQB2lwvxKnobEtu4aUAGR96f+ksJe+VRAaKRBabky+4RNTqOE9HBgOxuRo6ZWN9AlD5wokJP2A2eKOlnvWz4EWaLxPAz4LdnKcNmVQDb0xrP4khVCwnoSIA5s5WTwyHktwHJoCYy95Mx8z+hkEiho76o1Qk9E7TehczwRLlxxSdVnSWOhA8xewJo6LuC33Y8CuTOY26zZ9Yiv4PSXFd2iADSj/uYpdjdhynJo9wCG7ZUc4jPD4Xa55fTOxpQbfsB17CsBwjfqd7p46ouvISSJSBEWpjaxnoOBcUlFxSjV697E0v4KF/aGjPrnoTGYys9ZtP11PmpTPCTPxWZBupXPBM18tYEt9UjBC8bQOmtBCUc+CiKQ5jglvzgAuneu2U2/vZkASplAOY5syIigbvy7yJNA+wNPbyy6CiT8rNEpez+Y4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TlBxYkJSa3V2bjNIQ0FBeEU2Q2cxZVdiNWJFbVFhWmpybk5MUXdMZFpvVkFi?=
 =?utf-8?B?dW5URnZKWlRXTCswdmR0ZnI0eW9URDJ2aCsvSCt2c3BDM2ZUOUQ5V1JESUVT?=
 =?utf-8?B?TnAzL3p2K1dCc3FXTGpUcXorb3d5a0xCQXZ3TExiRnlMNGZwZXNoL2hsKzMy?=
 =?utf-8?B?UWtRUVRyeVBTZElIcHVYZXg2K0MyV0wzK0pOSyszQmVKY1pLeSs5VDRqeGRG?=
 =?utf-8?B?bVRIOC9jclpuOU5vWWUwUHI4cjkzOE5VUUNnV3c0Q2F5WnY1bUdMYUxsMVU0?=
 =?utf-8?B?bmtYeXdrNGxpZ0NVN29McHc3NkQwaG01ekt6a2g3dno3WlJCNFR3QStkSVBF?=
 =?utf-8?B?VFZCZWJFTWp2dy80U0ZzUlV1Z00zRURPR0hxc3hPcHVMZDE0QlVieStkblJV?=
 =?utf-8?B?SjkvWFd2ZUREVmxlREkzOGFDN0Y5Y25PeUwyb01KNld2QU5HSVBpVEdINk15?=
 =?utf-8?B?cEtDMEJUbFVOVEZHenlUcjdSck85N1M5VVFqVmtXaGZXOG40WTExVGxkQWtZ?=
 =?utf-8?B?QmlsNC9oL3NsZzlYN2FvSWtoOXNnWkVTUzZTS211TCtHYk1XWlk1UTRqNnI0?=
 =?utf-8?B?ejJWaHk0bEJQb0FWSXhoV29VVXhEWDhweXJOTENxbGM2dytESHp5ZFdBRkRy?=
 =?utf-8?B?NmsrM042bmRRbk9PN0VWdE4yZHFHd2RKWlZsenViYXNSOHFJVk1MN0JuaC9Y?=
 =?utf-8?B?M0JVSGV1K1Z2eTd2K1dEZUpqVkk1Wm8vdFlnbkx3L0REN3IyT2l5a25rejA0?=
 =?utf-8?B?WFVVMHNVYmVNa1BZaVpHSHdzZksyejJjV0YwaUhTOTFIZGd0T1QzM2VSSmNN?=
 =?utf-8?B?VmpOb0FYdEdoMWFxY2FTa01YOCtua1ZjTVR0LzdlVFBxNlBuWkV3ZmVqaWlT?=
 =?utf-8?B?Q05YME5QK0pjVkE3bW1YS09PdVo1cmM5STNwZ1UwWWg4RXRQTWptU1BOVy85?=
 =?utf-8?B?SXQzY2tTRCt3UExWeWh1RFNkTC9BR1pOaU13L3ppcnA1UFBabmFCczAva0p4?=
 =?utf-8?B?VHM3alFJdXFPMzJwY3E4eVJsL2V2MUJDcXZhVVZaSE5XRXBwSm5kQTJYS1Fl?=
 =?utf-8?B?bisyR09Qc0ZoUUk5VlpjeXVTL3VQS1AwUkZnd0FkL0RiRm1hVTg3TjJEdml3?=
 =?utf-8?B?TU5xZUlIbllINWRZcFVKNFYzWEYvS2V4SU14OWh4YVlxQWcxc2tpVmlqQ1Qv?=
 =?utf-8?B?VkdwK1hrSEc5Wi9Bc3dOeWZNTGpsdmpqMzV0Q1ZkbloweU1ySEsxRWdmZmsr?=
 =?utf-8?B?ZGMyV1dJcGdiWXpoSHlwWGVvSEFQWmlHeXQ3YlhqMXhLb0g0b1VxWnZkMmt3?=
 =?utf-8?B?amJlZnVQSEJDSno2aWVoWkNWU29XcElBak1VYVcrSy93SUVseEJXaVN2cTQx?=
 =?utf-8?B?c09teWMvR3ppZndveTIxS2F4cWtLYXBueFIyalNyVXNPNmVxRWpwQ01ITkdU?=
 =?utf-8?B?aGtvVUhOcGpLNEVMV0c3Yk5aL2lMZ3J6bnRjd2VCdEFuc1pLenRGNGxxVTcv?=
 =?utf-8?B?NEtkRld4SEVmNzVwNHcrQVovZ0YxekQ4KzJKTlhhSTNXdExSeHdHT21WSkdx?=
 =?utf-8?B?ZktVeVFkNFpQNTVpQmIwdTRwYjlUWlcydkRnNVBkTzhUZlJWVXIwMnhTQ0dn?=
 =?utf-8?B?dFJLTnhteVp3OWtrcVFTaXpjbFA2YlRHZzV6MEZ4SWhoeUpHZ0E2eUJGcWxF?=
 =?utf-8?B?alJNaEsreGlFVmRYMjV2eDV6cWNIOTlQTVpMT2ZWNmdERElBdkJCcmNjYWRJ?=
 =?utf-8?B?YmdNcUdMRmhzQkNUMWlXSU42T3dOeGlFTmUrRk9tNHZ4UUZlY25HeDlXOFh2?=
 =?utf-8?B?MEl2czN2V0hUSjBMWGk3VHdxZ090V3RVOVhWeE1taENka0RKdGwrNVJEb20v?=
 =?utf-8?B?ZkE4KzZISy9BZCtLbDBKOXEzSkIzNmUvTnhUOHVJdm5pY0xMZitoTis0TGM4?=
 =?utf-8?B?bG5kRFE5bGR1ZkY3Qk83VG9zVE5XOTRzT1QyZVFrVk9yeGVYK1RzUXpnUjNi?=
 =?utf-8?B?QlhuVmIwL3RSVHk1YUtYNWM4clAwTUVHajJxSk14T3NXNnROZEM3RkRDNG9M?=
 =?utf-8?B?ODdxaFZsQlIvQ3h2N0M5Znk1UEdaSEVaYmY2OTZGWVY1NVRVT1RTalZKa2Zq?=
 =?utf-8?B?OWlWbW5qcXQ4eWQyR3NxbXJVMDYvc2RNZXMrOHRvZURYd0NvS2MrZGtjcXVO?=
 =?utf-8?B?SkxGREpPKzgwcERkZUZaSUV0N3huek9aSklyMk1rRUh6MjFFK0ZTL0c5dmtw?=
 =?utf-8?B?SFpCU1NHWDRPU3pLbWdDUU5MUEhIVzVDTzZwZkRFZFBoZGVkbENlb0dWVStB?=
 =?utf-8?B?ak10UWZjV1dmZ0JaODU4ekk4WUp2dXA2UUQ2bFZucjl2WWpKOW9PZz09?=
X-Exchange-RoutingPolicyChecked:
	ytPuhwkzg6BklfGiQqy4TUnxZteYvSo4Y8tGYIbuvpfvGIuPH1CZBGGgO99nzPOL1y5wqlyJOhXwwKR1u56WUiaR0L/9m/73nfrjpU2Fe+LiWLYyd3kdH+t8xXyW4RQMqHTpBZlJEbyDkEs8ifYs7RwwxHUhIRkr7rgZWtKMa5l0Af8xZf/I9DzsbmaRTqfakNceHPbPsl4dJuEB4N2aUfKhndsWjiGs+TopgYUgS4Y5m/HF9lU0Ees617BI9/6rZ0abRMdo0UgZdZQWuz8rbV55KzC0OSrKe0f4v6u2ISg0p08vNirjMZPNym4yV2hLSJ++yWJ1Gz5LRpalTTMntQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ec3b10-1e9d-4449-300f-08df28786fd2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:50:02.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kcw2MWwLhf4NI76J2ZTovyUHG5jBA/ZwvjsMLf7EWJLAhEV4OT1sbLjlemkVvu7iYdSwX/uvV7NvqoHbOHiTlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6440
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfXzZMDpdabxjlU
 436eMFBRurTP+bL/ScyyNOmOzYLJS7Y4Xtp1aLqCtSUJ1HfXJEzmSFFPDoJlHBLQTcUX/hQMIrS
 UtxQv+HaKNrm0JilvGBfxUqWBfdp4P/wzwrIYTWjuLKGJRw/HmrtFv0/0qPt3hUye7q/BHsXXfi
 9LWNLOtDiawNiwplvYBpO/vvYuOYEPZA+SSVsJAEdCVc6iBEAHv9NrMoDe3YpWhChQt8x4yR/Gn
 XlFST2blqSLnnsPsFnOacBG35i6JTlnoTrjVZss9uySRftyW0c0TtwlWa3xn/Dq1A39VgOFOs5M
 o4bhN5SCQX42fE/ElAu3AYZN+xtZc9/87FOse/DeGWG/0FjXfeeIwCGdpRuf0FiYePen/oDHnYT
 GLvz2TPq6nebY7F2lm/E6QsjKFU0lbG5SBWITroqmw20hDf1XqRx0FM75gAjcNxA4ubhrErcS8Y
 rBoETShZYMUIsCkInwA==
X-Proofpoint-ORIG-GUID: CXeAlnM8LNUHQJKIFl2wNlkG4P9Ube4Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfXzZYq4feHGKSQ
 xNrP/d1894sP3ImFUPAuU8+H3QfDKhy+QvUqC5cyBlu9mO8/tLqXo4fpIyAL63zsXc6Nswgd/Ss
 P5XR/Qut5+oC4w0c6ystZBYcOWrc6wZZCU7Vf2NUoVU/2mqCSLdC
X-Proofpoint-GUID: CXeAlnM8LNUHQJKIFl2wNlkG4P9Ube4Z
X-Authority-Analysis: v=2.4 cv=Ea5d0/mC c=1 sm=1 tr=0 ts=6acd01ae cx=c_pps
 a=P6W5axN73kUBBlOjEPV+4Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=Dxi561lRB7pugceqXaYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120062

On Mon, Oct 12, 2026 at 04:43:15PM +0200, Alexander Sarmanow wrote:
> According to the datasheet (table 2) the ALS_SD bit behaves the opposite
> way the current ALS mode defines are set, writing 0 powers the sensor
> and writing 1 shuts it down.
> 
> The current driver thinks the ALS is up while it's actually shut down
> and it's down when the systems powers it up.
> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sarmanow <as@discnull.de>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Tested on a Raspberry Pi 3B+ with a VCNL4035 on I2C, running Raspberry
> Pi OS downstream kernel 6.18.50. Checked with i2cget that bit 0 of the
> config register 0x00 is 0 while PM runtime resume and 1 once it's
> runtime suspended. Also builds cleanly against iio/testing.
> 
>  drivers/iio/light/vcnl4035.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index ce1bd42b0c7c..f1cc75245001 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -44,8 +44,8 @@
>  #define VCNL4035_DEV_ID_MASK		GENMASK(7, 0)
>  
>  /* Default values */
> -#define VCNL4035_MODE_ALS_ENABLE	BIT(0)
> -#define VCNL4035_MODE_ALS_DISABLE	0x00
> +#define VCNL4035_MODE_ALS_ENABLE	0x00
> +#define VCNL4035_MODE_ALS_DISABLE	BIT(0)
>  #define VCNL4035_MODE_ALS_INT_ENABLE	BIT(1)
>  #define VCNL4035_MODE_ALS_INT_DISABLE	0
>  #define VCNL4035_DEV_ID_VAL		0x80
> 
> base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> 
> Best regards,
> Alexander
> -- 
> 2.47.3
> 
