Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787488;
	b=eRdSo+jaAiTbn21zcn0UU8EAjLuQ+x7QMmbMAr33blI8YPCrHxef2G3LrJLz47IXPEXy
	 iJvW/jbr2fAc1jkVbXc/i3g5h3zKgACc9JaVIwFJs/b9WdOKncD70E2fymgktJeiFbfGu
	 PMG/CWPtdlFeFDquO9JHihO7oBf6nMA1T+/+tb2mgsOQnBYzb/FlmEc4CBpUbLYBp8apC
	 m5Ro2uAmO6ESQzVCKTvqZYhNVNV6zF/3lm8HT/8LXsbNOSkXo/y+OtuGdjSNnePuP5mwh
	 EiF6w5ILXe0MWeju5F6EFD9iu05WeGeoJ+oX9bFzDK1Z0wiL1GAbkb2Sa5T+UdK07gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787488;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=Zfo3H2DVXSEm3U1wLHu/CQbo35QCCW4YqgWXFfojTIc=;
	b=1CUuTZMeJnQ7XwmRQzjCRmbEgBD2Elj4QkExJFP3vhI0X+vCUv4rBDk9InIj7vl/rboZ
	 4I6Db+c5lbboBaU280x7J9I1Qfn+9amIRns+3TIqIxOn+DskcKRlXZwIWKi9hRITTdE1c
	 cux63vPHxuJaWZ7lojlKb77ICZGplscHBt/T0gabeVj3kRMFkfifOWb3Epom/UK6x71gv
	 dJ4/Eo4NFYUC/5E+I3tL8e4xh2EEXRIMxfQVY6GkEzyinZWtucKIM3+HuQzVbQmf14UCV
	 zDXAQ5aClbmBzvAJtaQMXWoPzvdlAhIyaGpHPRdyFbpCM63fMRvEAzMws+41RJOVpLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Z4sUDsjg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.3
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011003.outbound.protection.outlook.com [40.107.74.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93324606A31C;
	Fri, 27 Nov 2026 13:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93324606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Z4sUDsjg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt1FhDVSSPsEs02ppDIfHhzGEI0WuKaRoVOk050z+odmUWKC7tN9g7Uu6XqCSbKHPbqWDkH4Nl3vC64cKPBeA4rk5Ov2kks6k9/Cig2vORQfju3mYqPDgCLQP8cm4ww/33/BlFXDKMoe2xUvTP25alBBzvuiJR8TanwkYH/sWC+BCwj60UvUokmSjSOUflNr02NFvvPIDVy0V3QyMdnfmvyIuiQgOwBOd3jApbSfcez2U0sauTVbSGDfzgq/zbpP/HcWUF9Q1Jnu4RJjBk4wDKbJFFeEUvAdPyxsAqxxMPP41EIdXz/lVkU4gtQXElAsBQGAVN9RRv9YP0TJiRhZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfo3H2DVXSEm3U1wLHu/CQbo35QCCW4YqgWXFfojTIc=;
 b=Se3gQL/OpXpI+6mj4Z/VuaXE2Hx0rTA8ylhjijW1BR6P66W4ba0sBHASbp3ujLauCXE67yR51angMvScY56FHo6v9tQlnFl174OHNZfP6FP/4x7FOY9pWE19DJCLf4tchLCLGPEDs0+qrfMiHzMgCt+D7AZVp2oXrH+pi2kwf5JY6MtmQbZrcJFkF/86zEXsZXmoHySKWxQYHFVEenFnVxSDn/TgFRrVqCPm5BEWYkWbVJDx9l4AmN9gnRBVdzflYd3PocnEkvRma/LASbjzXkcXRjzTbrjqS3++fLUIOQz/WW6asd85SiJxmINDoFQfzTK0/784DyoNmgFUioQLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfo3H2DVXSEm3U1wLHu/CQbo35QCCW4YqgWXFfojTIc=;
 b=Z4sUDsjgZ+TrWcPSAaJ8nNsW3tnaEv1fPwQ6RQxmmpInd3fviSxnTBb4y1qN5Gi5soI9gO7iY2uslzaLmqGwGrVoQWGhIBMrWvqIgM9PKbeeWaa8XLFnjK3okM5SykjHlMaEkcwgGeZKSIKAHa3nokllyiiu9VOJlwLAzFpI404=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11) by TYWPR01MB7307.jpnprd01.prod.outlook.com
 (2603:1096:400:ea::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 13:51:25 +0000
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4]) by TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 13:51:24 +0000
Message-ID: <d132b7e9-ead1-4f6b-a3c2-7240b89156ae@renesas.com>
Date: Fri, 27 Nov 2026 14:51:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] i3c: renesas: Fix zero I2C SCL rate on pure I3C
 buses
To: claudiu beznea <claudiu.beznea@tuxon.dev>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, stable@vger.kernel.org
References: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-0-2e76b87209bb@renesas.com>
 <20261026-divo-ssgrlpcsrc-2966-i3c-v2-1-2e76b87209bb@renesas.com>
 <bd8014fe-6a77-445d-b73d-e87404638593@tuxon.dev>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <bd8014fe-6a77-445d-b73d-e87404638593@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::20) To TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11)
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
X-MS-TrafficTypeDiagnostic: TYYPR01MB15118:EE_|TYWPR01MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2956d4-8272-40ff-a0e0-08df4c8d867c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|4143699003|18002099003|261009223027099003|261009221227099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	jCeLZr7PB/SXjpp0MLhCNulA1HblVsB7f6nYO/Xwh37XtD4Ry5MOZwuWd2i/6FFZvuaMy5q3ROt1HB6LejiS/U30U2DFkD7soywZ9KWtt/Xxerhu5cwxm5VbRWRkZjPEABgTI8JHaYLIMH3B01lazK0XXJnmeqG8TrjgvPsNne+ac1ok8ifKgcXnU7k7lYgX6msipEvSpGkJJx/pG7TGJORNqx+ex5dAJzmSzIxswip/7a5wnt3E2RkSq3Y7fX/y75LNXqEcaa/lfU/LjK5eVfIBKEniBHh2GarA9zK1Odu1haXmQBOEiy1hr9Z6kqZNkBXvE78U5oosqzy6JfYGFQLFCktt6krPCCL4MXIynsK6vO58dAepLdOXVNreKM0cEAwAX/ivNgGMY+vNmnll1rjVcm4lpl/cm1UwxexRDKTXw4dzZOzC643ae0ehraD9GCLKRtyA/UKVoqVXv3K4hV8AVbrCTBQsHz8uxQW5kyrUcdGCycw5z4sPD5q3lGvYhVgDVQ0m66+AJC9q4kvgMlo7dQ4Avu1rr1U//AkLTOtF9KRHuq85CIIM1aMhM6hEo5Rjr7fj/LrGHjsu6X1RRQ3N3MPOrfECKafB0cLwH27ALT/PCptBB182CYcXNgqYQ+bsMGGmuOJOLA9clwzaqP59TI04lAYQ5GpEXFvu6e26J5kNUlUhaCD62N3Z4jK2j0Lp5nzFvVfTJnhO3Ih1+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(4143699003)(18002099003)(261009223027099003)(261009221227099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmNMdmNBSU44amU5V0V1NDNhcU5aWEpTcGxlRU5GK1hSZEpYRDJ6ZHRVT0dC?=
 =?utf-8?B?cTIwTmVhS1VoeFJFOC94aGFjd0c3RzZ0U0dheEVqaHJQUjNaRHBsMUFqV0Jm?=
 =?utf-8?B?emxIVDNiYjhMaEhpVzFXL1plSnNwYW03OFpRQVZWdGpreUx3VEM1bm1oR2Zx?=
 =?utf-8?B?aVk4amUySlk4ZHJjcU9VQWlQS09rKzRsN0hMS0RjeTdrYkVCbkprRE9Cdy8w?=
 =?utf-8?B?b1U2Z3hibUJYQUlWME9icEFQOFhLOVpLS1gxMXgzMWd1b0UwUVlCQ0M0M0Ur?=
 =?utf-8?B?aXRzNGtOaHlkVEl5RzRZdFN1MUdEQmorV2tlU1dNWHpuRnAwb1FZdCt2QTJr?=
 =?utf-8?B?RnJsMnN5MjdBa3VsbE5YUUorUllzc0ZxNHpnaDl4OU91LysvRE9ZcUdCcmNp?=
 =?utf-8?B?bTFFMCt2enFzUlpvT2d1M01kUlV5SnU1TGVWOENxOXlQalBZNGdYb3JjMEpB?=
 =?utf-8?B?RWFHNEI4UXJsT0ZwQ0JMcXBsV3ExWlR0VkEvUzFyYkhGSlZTQXNZTUs0K1Ry?=
 =?utf-8?B?akgvalJCWHdEeitXTFVKa3pSTVJXMDJrQnFIcU9VbUdSdzNXMkVCSEFzUkJQ?=
 =?utf-8?B?N1dHRUYrbmJsN01jZUpOY0hsbzFickFRdy9TTFFVR252NWwwOFFmVTN5K3Vq?=
 =?utf-8?B?a0RlYythN2Mzb3o3U29jcnBUNW9JaGliQXY1NG1JTmQxK2FOeFV1WTVIOGlM?=
 =?utf-8?B?eWFjdFpXaWM1T1BtY0p0QWpaWjVBTnM1SzB3SCtacUdsWjFmY3U3Vndjd3lF?=
 =?utf-8?B?TllIN3RVcUFqVGV3MERQL0Z5dENOamJXem40cEM2RW9pM09YOUtJWGZ6eXpZ?=
 =?utf-8?B?ZmJ1Y1NlN1RPdmMyWmM3L3g4M0lEbFdRT0VyMG9RL0ovN0ljVjBFdk5kaWhB?=
 =?utf-8?B?WEZVSjlHc2I0Y0hWWU1XYWNSQTdyQW1WZHJqcWlyU1FaNytwamxlN1NwR1Vm?=
 =?utf-8?B?RlJ6dm1JMm1TU1dxYVpPWG4rQ1lXS2JINURwVm1VcHlObUFlelExWHMwNW5S?=
 =?utf-8?B?bVZVS21IRFh6YVhiZ2t1ZUJaU0JBNFVCMnZKSWhkRitkaVBZblVGUFFEaldH?=
 =?utf-8?B?azJzNCtxYWpVdlF2SU1pdk0zRGNRMUVUTHJKbk9sblRJQkxWSlpvVzVYcUli?=
 =?utf-8?B?OCsyWDZHY2VvU2xjMFl0K2xVRXdGRndFQzhlY3BMMExkaE9OLzRMVW5qY2lz?=
 =?utf-8?B?bElKa2lHNUtyMUFhb3hXL3R6UjF3SjBpR0JNZzJtM25JOTFpbGZ4VXhWejR3?=
 =?utf-8?B?d2Z0NUVDekxuM3hPZldCS3pKMHVxakNsUzY1NzZ1T2tlTEdSRmRqanJwY2s3?=
 =?utf-8?B?eXFwTWdYcXJxV0djcE91YlpDcmZVWmhBRytzNlY5ZkJRZHlTSmhva1lhNTVh?=
 =?utf-8?B?V2RlMEU4WnNPMUZReGthbUY0VTBtV3VWQjVnd2U0SW1rNWdVL0lEbnVqNjdS?=
 =?utf-8?B?S1RXY3FveTFrbU1tOVZtVEpld0J1YTJWcnFSc05kbzBMMkloNUpnSXpiNVQ3?=
 =?utf-8?B?UmtwaHkrd2ErT1pvRXNQY2dDeDhveXRycmZ2Y05YdWQ0eDh3OEtqU1JNbGpi?=
 =?utf-8?B?VjJSMis0V3hLOFZuckxhbVpFRE1oMmRQRlJYMVVzQ2Z4eXlIYzVHSWxDTkN5?=
 =?utf-8?B?SFhrN242RS8wc0ZGZmNGWWxVTlBlcjRqTjN4dUxyYnJZTG9Kc1FaUzZHdWZo?=
 =?utf-8?B?K3BaUUYvRWNrdHJJelE3Szhzb0dwUkhUK1EzOEMvNmFCNDlJUDJjVnhsWkVD?=
 =?utf-8?B?QUIwQXJ6cGNqOXJobzVDWmw2ZEpTRkVBMkkzQXFvdEFmbnZDa2tLM0IvRERC?=
 =?utf-8?B?NGdDOEhmMXlkZ2ZMc3k1dWtKNDBFdWV4U1Bua2tHVVZSMmZMY2pvY1I2ZEVX?=
 =?utf-8?B?aHJnMEJ3UjdrMFZRdXd5SG83TjdWQmR4VXZwQ29pM0JtcmN5ZUcrTG1ya0hM?=
 =?utf-8?B?d3pNZFhFWHV3TnNQUTE0WXZRVU1sNkVYaFF6NU84WUVNcnpJZFdUV1NNVFpJ?=
 =?utf-8?B?RXFlNHZCdk9VYkwraTUyaW5EY2lFY1dOOFN1a0VrSGw5N3lWdDJ2VWQzYS9k?=
 =?utf-8?B?bzZDNEdUc21ERnVvbG1qT0dsYW9VYldWbU9TdTltcjlGSS9EUTQyd2t6UmxO?=
 =?utf-8?B?blVVZmx6WWNHaHRIUVFKclBIV1dQSGUvVDJ0ck9TSG81MkkvaEx3ZWJNejMz?=
 =?utf-8?B?dStwZStFdG50MnN3SGl4UDkwNXNpOCt4ZzAwQzNIU2NlczZHbEV5L3NEQXcw?=
 =?utf-8?B?N1dYRjFKekR1OE9FMzJqc05HcmZTODRRd0Judi9WOWQzelFzRmFma25ManpI?=
 =?utf-8?B?elpWdU9JVFpYU0lZeHRXV1JrS1VUOXp0cW01ck1qVVFuK2FXZkhkbFlEcXNG?=
 =?utf-8?Q?j+wx+zhAeENYhzIE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2956d4-8272-40ff-a0e0-08df4c8d867c
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:51:24.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgmXsENx4njtMFIbbJCyalU+AWzcUlC8Bmylu/NWVJGeuGG6/rkz4kCU+2H9P81QsQcLQoSUeQlU1X11PbouwXHc45js2BjIBaUkaNmPbq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7307

On 11/27/2026 10:12 AM, claudiu beznea wrote:
> Hi, Diogo,
> 
> On 10/26/26 13:35, Diogo Ivo wrote:
>> On a pure I3C bus there are no I2C devices, so the I3C core leaves
>> bus->scl_rate.i2c at zero if i2c-scl-hz is not specified in DT.
>> Deriving i2c_total_ticks from that zero rate programs a zero-width
>> open-drain SCL into the STDBR open-drain fields, which are still used
>> in pure I3C mode for example in DAA.
>>
>> Fall back to the 1 MHz FM+ limit instead, the fastest rate an I2C
>> device could have, so that a sane open-drain timing is programmed.
>>
>> Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas 
>> I3C controller")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
>> ---
>> Changes in v2:
>>   - Substituted if/else with ternary operator
>>   - Picked up R-b from Wolfram Sang
>> ---
>>   drivers/i3c/master/renesas-i3c.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/ 
>> renesas-i3c.c
>> index 8b264f72e55c..78d0a2c4a19e 100644
>> --- a/drivers/i3c/master/renesas-i3c.c
>> +++ b/drivers/i3c/master/renesas-i3c.c
>> @@ -579,7 +579,15 @@ static int renesas_i3c_bus_init(struct 
>> i3c_master_controller *m)
>>       if (!i3c->rate)
>>           return -EINVAL;
>> -    i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
>> +    /*
>> +     * A pure I3C bus has no I2C devices, so the I3C core leaves
>> +     * scl_rate.i2c at zero if not explicitly defined in DT. The
>> +     * open-drain SCL fields of STDBR, which are used for the DAA
>> +     * pending read, are derived from it though, so fall back to
>> +     * the 1 MHz FM+ limit instead of programming a zero-width clock.
>> +     */
>> +    i2c_total_ticks = DIV_ROUND_UP(i3c->rate,
>> +                       bus->scl_rate.i2c ?: 
>> I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE);
> 
> The manual (at lest the RZ/G3S, Rev.1.30) mentions on the documentation 
> of BFCTL.FMPE bit:
> 
> Set this bit to 1 when using the transmission rate within a range up to 
> 1 Mbps (Fast-mode Plus [Fm+]) of the I3C-bus specification. Set this bit 
> to 0 when using the transmission rate at other rates (up to 100 kbps 
> [Sm], up to 400 kbps
> [Fm]).
> 
> In case the i2c_total_ticks = I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE should 
> the BFCTL.FMPE bit also be set for the operation you mentioned? If so, 
> maybe set the default to I3C_BUS_I2C_FM_SCL_MAX_RATE to avoid any 
> further changes?

I checked the RZ/G3L manual Rev 1.00 and this same block about FMPE is 
there. However, in that case shouldn't this be applied to the whole 
driver? For example on a pure I3C bus with a bus speed of 12.5 MHz what
this section says is that the bit should be enabled. I checked the 
driver and neither the BFCTL register nor the FMPE bit in the register
are defined, so if I understand this correctly the FMPE bit seems like
something that should be addressed for the entire driver on a separate
patch and here we can keep this speed, but please correct me if I am wrong.

Best regards,
Diogo

> Thank you,
> Claudiu

