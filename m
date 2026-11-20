Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160034;
	b=TTlRTpZFwL3o/wegcZtevqR7U67VqBb38Sw9XN9ADIlQ/Ep23rwEUerov/goGVFX4pUN
	 J0xhEUIWNb1LqL5GMJcrsquL450iFcdJDWOCrYU9utIBvfCK0388Mb/ULfCGMKtH1rrnS
	 +P/Wg05WJgRuBrgUVq0eTB+1yi5XwXvefhG2V7BF2wQAl7cfd9d+kOQDzGp5aGn7AjBEN
	 oob1Q5ur8P0/VP6whH0IZcq6+bUXG9BrTs4Y3M6TiHZXmLMYlZrnU2QVZShQ0jIzFKGpU
	 FaM/IHyf0ykua4nsnTrnVfBJDqpU9iREoUejATwJ2q0c/aN2IK7KXMfmfM4TKRNgFUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160034;
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
	bh=eAQi7S3GyZX7eyvOeuUFYIVL+pUpatKzVNNMaGWKXCo=;
	b=DsaJGtAAih9inTx9JZeceg0dliimxlQ2pPN9T751vi5hCFVyBa+GkEReE1qHWhIwFzO9
	 AEky7xkkvXrjVLHyHrmHnTVaDn1UCfHrGK+sO/HXVQIxGRzeHjmJ68Uw8i8OElC8aThYm
	 okRLC1b3EGrB5my2yfVEAc5dEhsJba/48eqlJhmf/WuDbTF+GibHvCRZPCAo8HhZsuqGQ
	 5SNJ5zrGDI4E9aRS9uBNl8ZUzGWd4OtwSmYUunOIzennldonr0tkJM1yS4wg8SmKwuaYo
	 hc+PKsA0Yrn9knhqdII2XRJxNjNJ7Bd3M0PyZaeUtRJDIIURRJ8GJOH+nUL0eiQtEeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=ORkJEbSD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B6606A338;
	Fri, 20 Nov 2026 07:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 099B6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=ORkJEbSD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+Gm7nJv3p6QIE2ksAeBOEKmvNbSJzn1h68GVNkbYSM3n2AQZJ9/BY1fwMI1Cyad4IxFpheST9QmyJowpdeCk7MjUiO51oKsc6ZKKu+iCWaz51BB9stjE7YDd+4/v9jbqLjtBs4KoFc4yIGmtJCn435s93hNn3bt8fV89Ujaee3vP6WhSzXQVD5JJaYu1IYXhlyDPRNoCH5fVG/6TuP/BnKlJcQlkz2nTrYwceRVSFXEa8iXm4e9P5/KfNF3UrzfvEDio17w0pIGWBGRrT8hbMaPtU4Dyv4iHfbP6ggjukaYakfZuDF+NQlaw6LzrxN6yLM4eKM1mOITCKpz9kOl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAQi7S3GyZX7eyvOeuUFYIVL+pUpatKzVNNMaGWKXCo=;
 b=rJdQP0dBGMLbTwvSOvL0XIEveEi2VoY767wYn5j55fBhLt7VtE4FEE8gB390cQs4cLDvfN9uFW1yBuex9dC85m2S4y7ANb6AVv7iFGVbumqOIqeIT33czeK8xUI3pDC1OnpXQPgPhZq1IOBMAhxgqBWvHToQ/9LumCfrVTHFyrLsjSayPdkdzGoZtvPjGveRGumRbP8GEmE5UK0/vTKgvHFvmDGI+MicYY821tAzLJ/TPbNyKbZEttEZ2pyAd8T5HC3us5gz92KduU4DiZzw66dfL2fnc1QGZJ285KGRl8U6ylR/TzZGlaVpTN3lfxBuuelp4M/WUvBNQAaWOuxUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAQi7S3GyZX7eyvOeuUFYIVL+pUpatKzVNNMaGWKXCo=;
 b=ORkJEbSD0qyInWK55gNY1eId+NPyhKQTrAp3+J8x3Ld2mBXjFv9kMtOqdmIRY8mPOEbO+iuTRD6ZZn9wtCzEzEZ1SsfbcOOB/Qh870NmM537OY0Kbjsw62NaycThKhvbTnZfKReruCIEopusTZRRROb4MUX2m+OiWHQg30FcSemUPDtcyfg9AmuT9jsWWNVUHZ12b+7Z2RxQPKqQqJdRYXaJ3wDUxHO4qxq5NbvMyxKVheMTK0DyZplEU1R+18egV9G/P9/Ra6CAWAhsHjYDnc8cBqsm2WkojWH1rJ1xbFBjxbbVS/9oCrbyI7sb3Pa3fmCYCcm6noUEkrRZrZbY8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS1PR06MB8539.eurprd06.prod.outlook.com (2603:10a6:20b:4dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:33:45 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:33:45 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 20 Nov 2026 07:33:31 +0000
Subject: [PATCH 2/3] serial: max310x: unwind only the registered ports when
 probe fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-max310x-teardown-fixes-v1-2-eb52c8b612df@vaisala.com>
References: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
In-Reply-To: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160018; l=3237;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=3eLLdp6l2yLRO5Rx9O9ssbEE7b23CxyifMRACDwzea0=;
 b=HoFoCSOsqwzmaIuWIgbJd6N9ub92Ur7fFCgIDRVfy040WhpN8XwgL1ZfQxfHlu0lnmdiJlcC4
 tkNRDcWpQmGCbvhsnndcdg+fPkUWYZHa1uU2x3Dlpc3VnMxLjQO0HP5
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::15) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS1PR06MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a50f6-c6a8-4220-2efb-08df46d89986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|56012099006|18002099003|22082099003|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	QZN0+i5vjEYTe2m8mh9b69ldwQ3joWhx8nHrZTSqvKVsdYP63hlDb94igKiHSmiX5X5rRnrulsW0zlGhcdu8qqL7+0fw8GtpV8sFbS1X0N6tYHUN8k2JnXlCtDNCXv3kVAs5A/iDh90HdWe4RUcxY6iO9cATGt9a9qOI7M4mPjphw4rDQR3WPx+PRjLTKoWYAEBwH2vkU6pESCxF/bVRyG7qEjVkOBGapk+74SZEfULTVGnTSQdX62KSFp8i0qKZ0xtd1quIEGID77ViwRQ4OIYJFv3xiNz30HAZkev+N/g4IGJl3DLK4fwvTjz82I4fnn3fOToP0vYLTpx1PSAviPB/BdGfzAsXzgBkhVEirBUAON4d8Zlwcrzc4kZH1vJarKVVfcL9ySwuo/aVtGVm4wzvwa9D20H6inBxk5bVK0NAe5B8IEgnaTrNDqGpBJ/n987fgKPah6AQbAGWri2uojUF/7yYLOmcQ7tUKurUjkDNExDoQ+d1UPq0Qsk4fKHAWpShvP2ANmbVG8I3hW1Hf5GSu4BgIJsJ4si0Wfimw6zcLY2iXOjJ5G8/wk0wbGAmXO2EdWhsALjM616n0qps3hv1YvajYk2PtksioAhwHC+nTsr41vryaQer9PjGosoS8jE2/jjB2fJiKfLpJwsJkj0qtdey/w2LrfXNM69Oc1XkqoKc6uz98DSJleVee9WsrhvlvEErT7RibFcxvqfnZvos0VPmcwCK3AuQDjLDanY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(56012099006)(18002099003)(22082099003)(38350700014)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWMwSG1xWlhNdm54NTk3UFVOL1ZwNFlhYmJOdDdCcFg2RVdsUi9LeFk2R2Rh?=
 =?utf-8?B?YUd1YXlRZWZvMituRTBPZzViTFJ3OWlLNGhaR3VRMHhONWRUUU9TT25zVzRC?=
 =?utf-8?B?Wnl1K25yNnlCVFRyM0N1MWwvOFR1d0JqdVE5bFZjM1hKcURYOWJodU9WZEVY?=
 =?utf-8?B?QUwxdy91RkRjZ2xhTmphc21oZEUycER0UGtpMEVKRUJ0OVlWTzNxQkI3MUlH?=
 =?utf-8?B?YzArbjVtN0R5WStNUmZ0U3dTemhza1dlUVR3WEd3YVBPVUZHWjFRYlMvbTVu?=
 =?utf-8?B?MStWTWN5VktuV2VZdlN0M1BSc3ZDb0hlRVJBSVhKYUNUUHFIQ1c3RUd0M2p5?=
 =?utf-8?B?S0I1aWt5bkRvR1drOW1Fd3EvWjF1OXZuN3V3WlZRRzdOUkJJMjNuOS9pQWdB?=
 =?utf-8?B?dFlneGx2dkNvYWtEVDFZSzVSSEJsam9XWGN3Nk0wK2xITDE5S0FjQ3l2L010?=
 =?utf-8?B?eVdvY2NqWUorVnpkK2FLSFZlbzFTSGxMVGZQWkZKU1pqcloxcFZIOVhBbnRa?=
 =?utf-8?B?eXlOL1BVYVRmMzU2cDRzU2VkVlhXV2s4eitudDV5MEsxQzZwZWNzNExTVUVl?=
 =?utf-8?B?cXFVakRtRzY5VTRNTlh1NGUvWEMxVGgwSFJ3cUpOWjJ1RHZpMVZzdFFxb1lw?=
 =?utf-8?B?T2UrMDRlejg2K0NRS2N3Zi9oYnBQSEcxZXo1aWxYMjF1MVR3clBzUm16RmtE?=
 =?utf-8?B?NmVseDh1RUNVbG56VFlkUy9HWE5rb0l6TUZNNlJyM2RneWtTU25JL051OE4z?=
 =?utf-8?B?NVJWekYyWFJlSFc4cit6TVZpalV6RVBaKzBRWEtMVno3Wi9HZ3pwZzYxMUNz?=
 =?utf-8?B?dFphQytmYlpwUWhxdUVxdVB0ZTRzUzZKSEFSZDBkemo5c2JuN3kzNm9FWDhG?=
 =?utf-8?B?SlBYTVA1VnNBK1h1OEtJNlFXMGk0dngzaFJUckR4SXhSUU9RM2lWZ2FWQmYx?=
 =?utf-8?B?ZEM3M3dCZjZIcGdFN2h3MVk1OTN0QXc3T0lqekFCaE9UdUFaN3FmY28rUE5V?=
 =?utf-8?B?MW1KTk53eWNGUkhQd2Q4WURlSmJMSzJPZFpPaGRlQ3hmWU41ejJUcGwweUNy?=
 =?utf-8?B?ZGltUmNCTnhRSkc0YkptdUdMWWVLZEtDcnZzVjJVUkFwZ2orSFNjSi9GMDli?=
 =?utf-8?B?cXpaS2V1WWVyN2o5cGJNZmg4MEFJUW5vaVRtR1o0RXZKQ2g3RmNRZkZSMEpl?=
 =?utf-8?B?c1JVWjZsR2oyVE1nRDJRS3VVY3VjNXcyYVVoaW8veGJQNy93OHR6M0R0emVB?=
 =?utf-8?B?L2ZPcmFKbTJ0V1REZWJxbHRhVXYrTzdKSUxIRXJ2Q3JkRDJsdTQwK0JBNWMr?=
 =?utf-8?B?bmZJNnRYZVBraW9rWlZXamJtdjB0bkxoU0RYajZOcUVRUXBmeHNCRzd5U2Jz?=
 =?utf-8?B?TzNFWkJ1OWtyRzBpQ3BsMkl2OHpYdVBMYVNLRjQ2dHduRzZUZGFKeWlyUmZF?=
 =?utf-8?B?amJ3VHhmNXRBQmZqajBjVE8yK3NOK0Yya2dQV1VqVlJMTzBxenRMajdnQlNm?=
 =?utf-8?B?Z3o4aXd6Q3RFL1JvSTNIbzRDR3lReTVKZU1yeGtlZ0NHWGtQZmFCZXB4VWJH?=
 =?utf-8?B?THJUdGx6V3MxTFFoUjZBTTZmdXVWa005MmhGMjcvN3ZLazFybWw2ZEcreUxR?=
 =?utf-8?B?aFNSRTZ5aFF3bDI4dWFWUk8vU3AyWGsvQmRETU10L1JGMi8zWXpmbVFaVTZO?=
 =?utf-8?B?dXZkcVNCQ3NONkM4dEwxQ0ZWY0NUZHVLRml4OWFRa01DQ0JrVTYvSmlNK1JJ?=
 =?utf-8?B?OU4zOVNRNDdPbEE0MG9oQzJUdWNxWU02WnRPRHNjYnljYys4RFlaR2VuUWhU?=
 =?utf-8?B?TDdNenpnOEExb25DN09hS0dTMzZuckl2VEtKQWRWNlI0YnJZUGpJQVVkZCt1?=
 =?utf-8?B?c3ZmU3JXOUU4MTBJTnFFNUpORlpoRFFIZ2lFME5zazBRVFVBYTFzeDZpVi9Y?=
 =?utf-8?B?N0ROOXQwK2oyZVZiQjVxdEtyS2hVakpncXdNK2ljMzNWRUNLbE9DQlNKWXF0?=
 =?utf-8?B?Nkw4MGh5SXZtOWZQbWtXVG40d0JHTThFM201YmIrc0RCMFY3OVZ0cGg4NTdR?=
 =?utf-8?B?WjB3ZXllWWdpNEFaZjBheUtqdnk5LzE4OFF3K2hXRlRzWVgzYWpEWkhneDk1?=
 =?utf-8?B?aDJBQjkwYjAzUXErMEFTY0JwVFRvenpRVUxEL2ltWVdaOWFKVVY0NnNZc0tN?=
 =?utf-8?B?dUJkNXdsUEdKR0YvRnhwS3hPZVZMRm9kSWtrUzRydmUyL2xOWXZmTDVvMUEw?=
 =?utf-8?B?K3J5MkJ3bEw3TVd0bUE1Z1VtUXpQb3JmL3E0dmVjVFRtV0hxWko4amQ0OWUv?=
 =?utf-8?B?WlFvc0xPZk4rZE5QNWtoRC8vVGVFcGk4NEhiTFl3LzQxZ3JiVkt3OU1OeThL?=
 =?utf-8?Q?CKGygROL0ipM9u30=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a50f6-c6a8-4220-2efb-08df46d89986
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:33:41.3359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awbCSin7w1kAWpBGBQgJfMRI9MQVhqWw1sdx/RcVaQuiLi2XjyVzxiA2ZzPm/+rzAKoF+PfGXUgbKz8JSTSsC0BlAeEy3ByTvXxV97OJL+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR06MB8539

uart_add_one_port() queues work on the port it registers: set_mctrl()
schedules md_work or, with RS485 enabled at boot, the RS485
configuration it applies schedules rs_work instead. When the IRQ
request or the registration of a later port then fails, the error path
unregisters the ports but leaves that work queued, and it runs after
probe has returned and the port memory has been freed.

The same loop walks every port, and a port the register loop never
reached still has line 0 from the allocation. If another chip holds
line 0, the loop clears that chip's bit in max310x_lines.
uart_remove_one_port() returns early for a port that was never
registered, so nothing is unregistered, but line 0 is now marked free
while the other chip still uses it: the next probe is given line 0 and
fails in uart_add_one_port() with -EINVAL, and when the other chip is
removed its port 0 is skipped and stays registered on freed memory.
Reachable with two chips when the second one defers on a GPIO, for
example.

Unwind from the failure index down, with the removal helpers, so that
only the ports that were registered are unregistered and have their
work items cancelled, and take the exits that come before any
registration straight to the clock release.

Fixes: 78adccac1ff9 ("serial: max310x: Assign port line automatically")
Fixes: 5d888f1c32e2 ("serial: max310x: simplify probe() and remove() error handling")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f5b32303353208d9f85ae0b04d38a9abdd398d24..179f5f4cc7b2f994c1dfd1b498878f4f7d6a3299 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1960,7 +1960,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 					       MAX310X_PORT_STARTUP_TIMEOUT_US);
 		if (ret) {
 			ret = dev_err_probe(dev, -EAGAIN, "port reset failed\n");
-			goto out_uart;
+			goto out_clk;
 		}
 
 		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
@@ -1968,7 +1968,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 	ret = max310x_set_ref_clk(dev, s, freq, &uartclk, xtal);
 	if (ret < 0)
-		goto out_uart;
+		goto out_clk;
 
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
@@ -2029,7 +2029,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.can_sleep	= 1;
 	ret = devm_gpiochip_add_data(dev, &s->gpio, s);
 	if (ret)
-		goto out_uart;
+		goto out_clk;
 #endif
 
 	for (i = 0; i < devtype->nr; i++) {
@@ -2099,9 +2099,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
-	for (i = 0; i < devtype->nr; i++) {
-		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
-			uart_remove_one_port(&max310x_uart, &s->p[i].port);
+	while (i--) {
+		max310x_port_unregister(&s->p[i]);
+		max310x_port_cancel_work(&s->p[i]);
 	}
 
 out_clk:

-- 
2.47.3

