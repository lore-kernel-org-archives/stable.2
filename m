Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792767913;
	b=31LUB1HfR4FKvFE3nXRweKWytQQGeTq5kb/iSf0gEKU1u79EURt44HUxqwYyivil7aGN
	 PgHeeKOJ3ZEIAF7AoIiR99ppmbUHtWlkj61zR/Cygrd82ViSC4edOaK4ZfdnyvHuw5k8n
	 04kYmfn0s2e9z+WvTxqeWMz/ynXX7Dnr23Y4eXo4cHatrENdMbWc4RtnNp/77EzoRbD9E
	 46NSvnln/BTQxPj6Nozc13jWx+dMef/+eyimTwhw9AXRmrEJMjXt8dUQGyEkyLAE85Xky
	 wtA+wc5njfwOshdz4JKZ+4mGj7qlhSbNhNtamW8XLIuzpL2JCnAnafIyfA9jEZDmFww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767913;
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
	bh=+646b+o57UiNkDE3OZjlr5Spf6MqFBTc3TUadSFYObo=;
	b=Z7+E5BlfoDdLiaJA3Hqypalgpplppni/P9m0Kc96LRUFuuhZCr8yhIuHkvjCmFDs6xtu
	 2UvUMO8irgcP0Ad2ffWEcR4nEF5TKPFndYFEPfsEel4b9wE7dujUPTWsvZOcywf/xkTJx
	 YjQveYi65JXiFBHzs880xFlQt7nP/0vDclbuWBr81XZmVemipb1h2BoscZeQvMJGgiOgg
	 RWWvHZ1vASFpkO5wcbDiz2a82imO3ZxpcPYnxBslqCuttUchl3zbA2j4hb9Ldl4xMRcAS
	 BfVL5sd4FX3hpEH2iaK63LatiTBhT/Bk0tvBh2u48B01EGE4enyKl1f3OPoGwFp8FJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=g3Mv1+Vf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.2
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011002.outbound.protection.outlook.com [40.107.74.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC7606A329;
	Fri, 23 Oct 2026 15:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFC7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=g3Mv1+Vf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLEll3FC9X2lTbHyLvvCCUg52KL8J3AEGqph+rNROONJ+0ghrCTVVdzCnTSa2CQ6FFim8dRd2BHMC3xDL+6IpMHvCBNih9Dn6ckEQDKlU4uHGvIpg55qGYRsh/nr7QTq+DthJXnyEt092kP0Il7muoJGUqM/VEI/HVjK2I7/2PMDBsxHHsUASBLP/4s6EIsVBCVhXJYJW79MvpXXcK1Tn7fOf/+XeS3qQqCK7ewiPvWGZa2pE5fbjSX9QnSmDuPSonut4WpD2y+jdqT2zqe+AkyverkZCQ4utMDylBIh8b5jpcmu1k/sGj0t57+Tn3qBRQJgiEU5oXB8g+pbeQQGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+646b+o57UiNkDE3OZjlr5Spf6MqFBTc3TUadSFYObo=;
 b=VaM4yqHbYlXnplUXtKzQi6+Jew4cXp90KIUOG483YnsjdmVljrSGMWJpJnHue8ZINeuPOth+tF3Dpat+M9LOUjF+mkT6Q4pqqyJXzlO8OeVQSGPkqVcIVn8AbT23R0vcMYGz320V6pb934fWrd4n1Nroe8xTDHCYwVrHLoS1nOlJH6H5/inocAfEMM0TVFdBStPMkAJoklYWO0Ev0pK3xLBYmH7/ZfXonsWylXvJrFZ9XbfZceMDzSh5CypzPvz0+gbULQ0zL3JT2PWNO+E9Ziq+lKMU2d9xyxgu+QEVzug+D7D4aWlBU1H0FqbbC4x9SVWgwScHVdnAI1A7M/AuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+646b+o57UiNkDE3OZjlr5Spf6MqFBTc3TUadSFYObo=;
 b=g3Mv1+VfDymMgDflILMA5uLKXFXzuE9q1JHG2YBzQhL36OoWuiGsTl1gqJ9VzWjwYDKFU1PNbvXUUJXDk2sKNSO3nNOreRY0B35/QFqWr+fjYzmtXzBBUsoqgUBYJ3X7UEfQAJx1YysHFT4GJSj+zjAfxrwusI2YOyiYmm8ucyo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11) by OSCPR01MB15652.jpnprd01.prod.outlook.com
 (2603:1096:604:3c9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:05:10 +0000
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4]) by TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:05:09 +0000
Message-ID: <1ac3f002-5d88-42a0-b6e6-47cb6839e0f2@renesas.com>
Date: Fri, 23 Oct 2026 16:04:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] i3c: renesas: Fix zero I2C SCL rate on pure I3C buses
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, stable@vger.kernel.org
References: <20261020-divo-ssgrlpcsrc-2966-i3c-v1-0-30a47f25e515@renesas.com>
 <20261020-divo-ssgrlpcsrc-2966-i3c-v1-1-30a47f25e515@renesas.com>
 <ats2nSA-kV10hlje@shikoro>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <ats2nSA-kV10hlje@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0050.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::22) To TYYPR01MB15118.jpnprd01.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYYPR01MB15118:EE_|OSCPR01MB15652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a16dd63-e9d5-4a58-cc8d-08df311707ae
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	s97JMwqop3iI5K4xfXHjrv8dRHsFp8/QsF6CaXRm4NCE3GHlx8ZKLWVDMOehttrIK1ISGe/V2CcAXyhXmRsLnhVT4EI6MR8DPyCq6LGUTkezYdXw7aQMZR1S/52pikOu0baHier4vbUPmKULim9ru9tJLHK/CWuAP3bDMrIje5JC0BuyI4og01660B9Gv2c5spyLOSyKJJzLUSlhx705OZwPvNbFr2ljpSSzO2myS/54n2JUD3OiozrYYe0ibW5LkUveGk1UeyEexKKhzPefJD8n5R+KWX5W1ZAwxprDaFYLA60ZhBTwn7NMUEsVG0deQXi0NMWAiCZ0m3z7wSYjGfC/t2Ivd+KlTimWisWVj4OfWsxRmcCvE5K19oaZCufA8su1EDbKZucJIasT/3ZBO5jTLNWg5Lm1bSrOpij31Ubn1falhO2vqxm4pSHJB5BWC8XweiwZBdkaNqeDVDscHcG+Sktyi+vvp2Xs/PlHOeCLxLF/vtm/bqAODuuCvxa29lZ/2cZXznS0dEDAi9i7YnutHcOXGP5oje7Nh4chFp3sm/8xXHHEYRisHoY7yL4AGvKGIEtqifTBurU+kQncT57ITp9QffhQ5klL/+cZrI/QQYdqTo/Vs0JEqSaecfbeWHQJX4Xd9vJ2LhRSXThXupRFu8ybvVTfNOueKgKCJNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFVGV1VJcGFaYlFHTjJaVENJaiszKytEZXcxUWIzSWV6UUg2blg1WW9kRkRI?=
 =?utf-8?B?Um9EdDVzdnk2bExJRkZORHhGT3RFcjlwVk5wMWZXR2dmN01pd0FvRWpMd1hh?=
 =?utf-8?B?YmhTT1dLLzllS0UveW9ZcFB2bEJRdTRkWStmakg3bnd5cXRzSWJBRG5aYzZn?=
 =?utf-8?B?NFBnd01JQSt5SC9PelJEYXR5em9GS1RaUXNzY04vYzBDL2tYZlREdXFOQncx?=
 =?utf-8?B?UVFYNGdxVHp3NVY0TEJWZEc1U2VBM1VESTl4eThCRjZsem1ENWtVRmlPNitr?=
 =?utf-8?B?SHdWcS9HaUF5a2dIY2xmc0xEaS9qK3pXY0lWaGIzM252SlBvbllTTThRczAw?=
 =?utf-8?B?YkZsaUdBTlMxSlQrREdhU0d2aFFYNEZUdDhzVVViSktkZEd5L1c2eThob1pP?=
 =?utf-8?B?WjQ4WW1wRENEemFkQmlTRnlPNlkyaUc0LzYzV3VUc3kvSUROaEEvRzRvNWxu?=
 =?utf-8?B?cmdCWDV5Ymt0L092eTB5THJnVnZOaWwxczFZcnEyVkJyUzZSLzJ1THE3U1Zp?=
 =?utf-8?B?bVlGblh0Z0RERTB5TVc1elFObFdLTWV5VWJ2TnoyWDRqZGtwaUs2RjBjUFFh?=
 =?utf-8?B?cytBT3Npby90aDZwTG1nbnBDQm5SdjFKTk1zVDF3VHVwY1hYQWtha2ZpSkRQ?=
 =?utf-8?B?bHo1bTB5UDRwRkpUSVZndGJJYVM1b3BjYmFrS2lkTnZLZVJDTHFBL1g1SThj?=
 =?utf-8?B?YTRHYU5SUDRGa0JiT0c0TGJKbnJZYk5BZ1I5RUJGeUZzenRUbHRza21oZGJH?=
 =?utf-8?B?anFydFNnSVMyRUtvdy93R1FDR3IzakJ0V2M0bFJwUFgzNXNsTWVhc1FuU2hV?=
 =?utf-8?B?amdjajhGMjFuRk5tVk9OZTcwa1U2M2pDWWNubmhiSXlhcHd4UE42ZmEvMXZI?=
 =?utf-8?B?ejMwb1RiV1FOdHB4b1U5WEpPWkk3cHRwZSt2TUNzVHZhZXRVdFdSd2plQjEr?=
 =?utf-8?B?MXFHaUdpUklEYWVFVWZDRmtyMldHUVFiNlZPUUlNS01zUjE1TldPUTFqV0x0?=
 =?utf-8?B?SmJQUzEzUHE0UlRuZHQ3VjBUNk9jNlBTbHQ2dlpYUktINExWcy9md3FoK09D?=
 =?utf-8?B?RkIzbjhYNmI0eC9FaW9zQmxjOFVYK3dNVzh0S2VoSldZeFgyVW9POWw1bThJ?=
 =?utf-8?B?RDNEQzVyYXNEcEE0REZEaHlXVFZQMFlva3ZuQlBiWFM0bUw0MW9RUUhFYTZV?=
 =?utf-8?B?MjBwS2JpOXYvTUJ0b0IxNXQ5SHlmWXltUkNMVzVWOUFyS0RUS1lDSUJTYlFJ?=
 =?utf-8?B?WHgwVlByVnlhNTByNFBHZjBPN2RQSWFlNml5YndBT0R1aDhZb2ZEMmxremlh?=
 =?utf-8?B?Zys4eXRBUkF5djJvQlcwWVk1NFBEaHlpSURVVEQ0cWh4Y29vcUlNR2ZSb0tn?=
 =?utf-8?B?UGdrRHFYaHE0a3VCZ3pqdUJnTDhkYmZhTkxsVld0dVF4c0c0OXhJTkd0aUt0?=
 =?utf-8?B?NDJtUGFaQllvblQxbFhIRldpS0piK3FDM0pXcFJwaGNpVFUrTnVVc2hlNDV1?=
 =?utf-8?B?U0crUXBSeWY1NXQvOUR6ZmpKaG01TTNqZDA4Wm9jaXgvakp0cmV3Snp0RFlP?=
 =?utf-8?B?UVlYRTNUL0k3bDNEcHpJZmRRdUdDb0pFWmI5TVZ2VHRRdXZmMGxqL2liQ2hp?=
 =?utf-8?B?eVhkUkRLbk5XNFZ4WEdhL2piNk93c0VoaGY0bGVVeU5pSkp2eWMzcFpldGx1?=
 =?utf-8?B?TGJwb3ZpV0xxellWRnJtL2hVbE5KR1ZoakNKN1ZkQTZaRUc0NzVyUWE5SS9t?=
 =?utf-8?B?aDh1azVxYzNOR2hIUHZjNE9Pang3N3oxQld5WThVbm54WlNqZmg2alBzTjAx?=
 =?utf-8?B?eE42SVpMUWFUL3ZnQWpoMjRHRThoR0pGSW5zWUl0SUNDVVVzb3lVVnJyMkI4?=
 =?utf-8?B?WHo2VHBFWkxMVGp0MGJzbEFSdGxmQndraE1OeHdPNVlvWEQxYmxXcjBNUVNv?=
 =?utf-8?B?YXcxQVF5eDBSUFJKNEI5WGROWCs3SXYxeU5HQXk1NFdJVU4wVk5FVkx2bVlw?=
 =?utf-8?B?YzZGWklRc0dkQm9DRTM1dXNLeVgrcnowYWNyR1VwZEh0REt1WmpoZDlEWGZF?=
 =?utf-8?B?WG4vWWUxV1ZLRjdkOGJLcEF4aUw1OFU0aGNhUjJCbU1WTExLMzdZZUlpZGY1?=
 =?utf-8?B?US9XKy9nbGVrV3B4M25YZVFsU0ZHSWFja3BKR0p0eUYrWXhkdVBseVVGNmxX?=
 =?utf-8?B?a1lHUmhqVE91TVBTdkdoaGxOOTVWNUpWVlN4b2N5bGtPdTRiWmR4U2MyNjFr?=
 =?utf-8?B?KzhaaXZUSmkvUHVGMERlVVFRRVR6dk5zRW9ZYy9yK05yYVY2ZGpGdllVa29N?=
 =?utf-8?B?cXk1Vlk2bHZJOEFVMEFYRUpwYisrdlhIdFY1dlJEYStIN0V0Z29SQT09?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a16dd63-e9d5-4a58-cc8d-08df311707ae
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:05:09.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac7UVYfaWWHGKmeDIECq35lu81ZsezDhsb9/5ixNjvBEYKhdC2SJlGrI+897mbHvxx9TB9JJq+UzfSlbztu3N8V61woZaYtLLdQKaX2iRAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15652

On 10/23/2026 11:27 AM, Wolfram Sang wrote:
> On Tue, Oct 20, 2026 at 10:14:55AM +0100, Diogo Ivo wrote:
>> On a pure I3C bus there are no I2C devices, so the I3C core leaves
>> bus->scl_rate.i2c at zero if i2c-scl-hz is not specified in DT.
>> Deriving i2c_total_ticks from that zero rate programs a zero-width
>> open-drain SCL into the STDBR open-drain fields, which are still used
>> in pure I3C mode for example in DAA.
>>
>> Fall back to the 1 MHz FM+ limit instead, the fastest rate an I2C
>> device could have, so that a sane open-drain timing is programmed.
>>
>> Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
> 
> Great catch! Kudos for adding a good comment. I agree with Geert about
> using the ternary operator, though. After that, you can add my:
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ok, will do.

Thanks,
Diogo
