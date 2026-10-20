Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792505607;
	b=mRTCkM3hdeYNANWRpLBgdTUsYe8O6kBx093hiS/7RhSlgWZkveYjTNmIL7LQRYLjkZkv
	 lFt9BfuMWVD1AejUMNoo0KZs1sjQ1124BQL0quz2JZBXgBDINl3ynPflrIbgFESnem8f1
	 YJq4I0KlJL501s0JFd4zX0rz5xKlwcpvYTPE2Ryyuk6jFRUNzrpq22BxH6o9NT4sy3bGq
	 IRIaRVWlox4cS1ESHPSV+7v3oViuIaUHNaytix4wT1IF2E0inSSy1cQvujrJdA1FfNhkp
	 SM/TO7+ustTMT0JVNAgwZnrF/i9EdauQekKVvBBFFYNZn7rUKuIIkzdQDbj8u4sfZoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505607;
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
	bh=Kxr0nhqtQIO/3hUHg1GyihSJWJiBv6AMeP9ii4uTwnw=;
	b=VMHXqRB8YXS54ZZ/NP8VTVkRtgs7/HXQ20JnwAALbQUVMgIDNBywW6/TXMV8Akn7nzEZ
	 NIn1RuerB1e9MQAvla5OXwS+ZRcbvoVo9pmEXv3CCFw6hHFV/eMc3sUMiNkYJ/rb4yIV8
	 8b5LPzzU2AvZi5ak1pAd3Aul47cPBv9jOuOtaYssvWSzAlywKw7cSLRHe6vNHxAr9MvU6
	 /T1zpC23HtaS313LwdJy/cy+TKPtwkHOS/PQydvYRj24fITmg6Oar9YGkpp+iFoFVpPYH
	 k4vET6hjjjGOdbp63JRHOlua8T6dbQNyBvm6HaJPg0R/Z0CqWm4uPdgAU2Px2NqEPfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ps1Sms4n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.58
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010058.outbound.protection.outlook.com [52.101.228.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42C606C200;
	Tue, 20 Oct 2026 14:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A42C606C200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ps1Sms4n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSeXiEkZxo6BNg6RFPwoM76pRoIuDAXmVr57H2fiG5BPMIuXF29G8RQDMLX4+4HYQPJWhzJQLII2phhWr5DtjujQU8zxHeoB/LyNAwKGFzt4D2espxgK5RcDjYnj/4aFpAXZpikV4GxA0GNNgGH6GzlMYtF2DTwa9Tr9TgLzAawu1aCP6WZC2mZfaeswcHQxW1IgkVjoUSAWg82bei63i7Rs0vSaM3OTFh43rnW6f6MDk7Hg6w3DgH2p5LasQpNQNGGG6vUu5hAybMOroCp7IL9mrmGe0yu9xSfE72sE+fRvmTq/v0xS0sjGxxLFoyG+IZiUa5eVTpt9HhY/1ILCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxr0nhqtQIO/3hUHg1GyihSJWJiBv6AMeP9ii4uTwnw=;
 b=ZP+7/D+okDIVjHWGodW1tNHbfbisHBX3D6ihOJyMlg8hDYqJMVYfF0+0oQqTH8UTT0r/Nrexfvdl5OmEAyNpIlF0qX8NE8AmXML3F7n2CREYwMaOA0WKo16tDDPy1cg7Wzrgfo4QSr/sKLl2J8Rr4WOtyGVf3o/xXpuuahOyslU4LXIHoC+8oRSjO7yXhkQ8n5b1uviC7aOgoRX038naY+vPD2F/Z2sHDfVRixgAaqq+GTSDnsrWOWbTvvHfPA45yKLnDl8zt9lft26BFY9GTm5FV20hvn+qCZ3Dds1ZHinZKkcvlmPEgtVFrtcQZwQ/n9j2S1oakctBN++6l3uO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxr0nhqtQIO/3hUHg1GyihSJWJiBv6AMeP9ii4uTwnw=;
 b=ps1Sms4n82e8HanUCUS58eLxDmcL7uP/wloDPrtcsAg61nywXhnbzPrvgm0nYalgXEPmH+2AulMJyA4g+k4rbQxFg/Vdp59cEnop71D8HJxdVEByIEK+OP2OT6gLmxMOWgn6QBI5Fx1t3vFqjDxtSugozBFtVXs53+jtJUcNAak=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11) by OSOPR01MB12410.jpnprd01.prod.outlook.com
 (2603:1096:604:2d6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:13:20 +0000
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4]) by TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 14:13:19 +0000
Message-ID: <c4677ed8-d682-4d05-afbb-d517e59de391@renesas.com>
Date: Tue, 20 Oct 2026 15:13:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] i3c: renesas: Fix zero I2C SCL rate on pure I3C buses
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, stable@vger.kernel.org
References: <20261020-divo-ssgrlpcsrc-2966-i3c-v1-0-30a47f25e515@renesas.com>
 <20261020-divo-ssgrlpcsrc-2966-i3c-v1-1-30a47f25e515@renesas.com>
 <CAMuHMdWt8KV02C+N1dj=gcdJwX4s-_=+zRpsh+Za+f0HeHOkuw@mail.gmail.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <CAMuHMdWt8KV02C+N1dj=gcdJwX4s-_=+zRpsh+Za+f0HeHOkuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To TYYPR01MB15118.jpnprd01.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYYPR01MB15118:EE_|OSOPR01MB12410:EE_
X-MS-Office365-Filtering-Correlation-Id: bc855cbe-2237-46a9-0656-08df2eb44acc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gjto73ifIC8j454DdpYMGqik7W2tXF1125gKqDchDBDjhEXDN/r7zXfkDwY2ry/nH1ZI9AlRMubeZVdXc/+UvIJ2TeZdppjdWP7mhbpZ7gCGYPqMWoV6Sb8qQc+j7S9e9zkdNU+BZYTbIkd3DQSNBB63C+NT3WsPOYwGkru5SDLQh6O3dmAK5FOXZr2JCp4mo7TjpYOKHcV7m3sR2bq0ZsxMhdVpusxT9xmjrefC5NR32K1I5BRNMa/8G/LMJkf/nStvD6uh3OQovx9LEv//4jiSi8anf7Qxr8d652AGhMLR7g+CXvKHrY8PgI18C65n8rKYcFGXnX9a6cKgQGi4lWzt3oSSxtwNYMXxZH+nzHaGUnJCm6Y3FyQqYWwtmoqwYFG61kv5Q0tfZ69elj97sjCYMo5okKa3h3zFM+UbqLo704piJywf3kG+76OAv9F4IqM/O85MIDFwqx8I+cghxfHM7/x6u5V7X4ip0E0pkhStrWIqrSre/VvnzOFs1oTYGUG3zsnAV5yHoc4jutx0zSsvzU5qu/+N5Ulw1eujQPO174ZyOWJYOj9yTMggl9jrCAXM7HMP4K/4xEoGdxp/T67xhiSpbUP5dsynGCkqr+q+QQBsVPer7omlFBwBw0fGHsIZbI4DLZgTHDm+9V6us/JYhL//YhKB1PW615fMIio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QklOY0QydWRObFhzL3c4b0VXZzk5ZlpnUGtHSDJZQW5UV2FDT3ZxSy9FWU9a?=
 =?utf-8?B?WWFFK1dDc0lzUUk1VVBoUy9NelM0VFJjL2l5MHNFSFpBZ3Z4YTlGVGVzbGw1?=
 =?utf-8?B?V3RDYUxxYTJ4QmFOWk4xb0JxUnB1a1hNckFuclRqZnRIS3hvNzBXdmNZVm1l?=
 =?utf-8?B?VE5PRmtUUUc4bk5STWt6MTFvVWFSdEhTSHNoaFRvUUZ3Zm80NC9GcmpDZTJU?=
 =?utf-8?B?TlNVMzlCejRkcEFQT3cxc0ZOVzdoaEJuZG5OUEpVWjRkaWRQNHFaM1BncmxB?=
 =?utf-8?B?NDNTYVdmN1pWTkFMR3N1TU84UkZvUVhjN1V0SHNqbExsYzkrNlJqWUNUOVRh?=
 =?utf-8?B?Q1dUSXBKeG9oRlozVE5kcmlUQXVwOFI3U1J5Ulh5VG56ek9EU09TTEttT1pG?=
 =?utf-8?B?Um9PTDgxays2WHFiY0x3M1NBaC9VaGN2ZXVoVDVtcm5HS1NxU0hpRG5aSStL?=
 =?utf-8?B?Z01CWlZwajFDQWhDdm5EbEJUK2M0R2k1WDk3RnZCT2ZBSWRyNFhjbklIVTlC?=
 =?utf-8?B?TFBpSG91V2l0dnFmc1FqRGh5cWtXQkkvYnZrZ0pBdi9lZmtXQWtjNndzeng5?=
 =?utf-8?B?aUViZ3BENFlRZ0RyWHcxWG5MTk04SEJ6ZHRwaklSQzFJeHhXL0RlNzdwRGVU?=
 =?utf-8?B?OUYrbFR0NnphT0ZoRkhhbVBJa1AyUmZpNjhIQnVxOTk1dm1XMnFhVkM1YUxF?=
 =?utf-8?B?MjQyYy81MXZodkJwNjA1MFNTQWJVU0RZd1hHR0pLZGJYQmx4UTROZ1gzU0dR?=
 =?utf-8?B?SENmNnV1Q1c3VEhneVZqK2c3c3lUbHlkNlpvR0pCbjBKVTV4M2huY0xIM2g3?=
 =?utf-8?B?dDFia1RoQ2NJaFNaQzV6VjdUdFl4ak5iVVZ0SzJadE1tZjhQc3d4ZHVabXpL?=
 =?utf-8?B?bUtjSkdHUVA3MHN1akxQRmJFNjRTUUFlbm9ybXFPV0dBNE14eG9ubStxU2w1?=
 =?utf-8?B?RnF3QjZxSTlLc1B3a3VBTE54OFVIM0MxS2JtdGJPeWtaOCt5d2dOM0ZxNWdu?=
 =?utf-8?B?QStKNzU1MVZqVVM5SDFHK0xWVWtDWEl1d0k0OFBVajJnRFBOVmxKcnBjckJZ?=
 =?utf-8?B?S1lFUEVoaDA2azBSWmZUVkdaQk9MMXVMZFBDaWZlamZsZFJIWGI3WnlOR1RG?=
 =?utf-8?B?Mm5xaWVSVWFENCs1VEp3VFI3R2VJeG5nS0h6MnFSSlQ0QTlRN044RHhobzc0?=
 =?utf-8?B?YVZZcGhkZ1hDTUVLM1lxRzd6YjNEdDRKMVVhWkRZWkRPZ0p0WGtSUEYxLzV4?=
 =?utf-8?B?dmFzUVgvMDhZNTJ1bEJSV1hVbktVMWpWUlNwVWlLRFBhTGF2YUcvbVcvL1Ir?=
 =?utf-8?B?NVVhWkZDd1RSSnVOVlo1RlFWOXcrSVE4akw2L3JPaDJJZlhtQ0J6TUk4NTFa?=
 =?utf-8?B?dUsvT0JITWwxZEVLMm02c2Vpbld5RHVCK3VKTFlpdWJIUkthZVczL00xcVla?=
 =?utf-8?B?R2ZoVUpWM3plQk43K3YxemRXemx1SFoxZ3FUdk1mQW43UzJmUmJpNlUvdWUw?=
 =?utf-8?B?V3hkTlBaWnM3OWRtZGlyR1J6bkJQNXpBNmExcmQ1ODVXSmNmYXRMRUl6akwv?=
 =?utf-8?B?ZkV3SkhzU1FmT1NWQ0g1emVRMnh1SytHbm1XOXByWVJMemE0Nyt1dGxYcGVU?=
 =?utf-8?B?UWt2N0N4SkNpbGdwQlpSaVI5bWM2LzZqRldzVGhqV3hzb1VxVktxWk9Helpr?=
 =?utf-8?B?S1hrbVRxdHNHY20zNDVpL0ltNytIRmNsQXBDdUkzeU8rTEF3MDYyYlRwaThU?=
 =?utf-8?B?ZHFCdEsyRFhxSGxreVM0VUlZNml1Mkk4Rk5ZWVZhNDAyazhNcUYzRk9yVEFz?=
 =?utf-8?B?UWNPUHVld0w5TWw4aDdySTVNaTZ4bHAyVTFpMlByb2t3bC9yeUEycEtnN0FQ?=
 =?utf-8?B?T1pvWjYrRnRTUkVncU41VVpUWTY3N2NEM3JzeWhYOUlaYmxpdG1wbXl5a3Fj?=
 =?utf-8?B?RVZ1MDBnZ2NETHBEM2NQc2ZEWXRxMUxQRXJZSERCL1AvRWJUeVpILzJJQmlW?=
 =?utf-8?B?NUR4R2t3b01yY0poanRaWmtpd2hmczR2WVJOcEN2NEJmSWszSkxwZUJ1TVlZ?=
 =?utf-8?B?M25xU3U2VGxSNGVsWGk0bXEyZEViZkJhQ1ZiWE5WbFQ4b1BTVjhwOEtJT3dj?=
 =?utf-8?B?bW9qKzZyVG5FSEdkazZFcG1ERys4eWhiTDhRYW9lSkF6MVVieG5MYVdQTFo1?=
 =?utf-8?B?d2dTR2Z0SUgyeVlpRTJGTkhrMkR1eEZUYkR2SC85Z1Fna0pYeFdDY1VNdzdY?=
 =?utf-8?B?OGJ2QUJYMDI2cEV2ZHdiTFp3bHNYM2lXWUhIMGMrd1NaYm5Ob1Q4eDFqWkZm?=
 =?utf-8?B?VnAyUkUvZkorUVp2R0hRQ0NzVzFGVWtNZFZCcDFuL2pyU2tDY0NBdz09?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc855cbe-2237-46a9-0656-08df2eb44acc
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:13:19.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIep8+acIbn6lHubU+EW0HLQu2rFP4BT4kDKg5O/fkyvQOutISHLPeBY4Pfu+y58T1arZ/MXOH9BrZZZSE9yGJ+GSWyH0kMcALoG1qh6hUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12410

Hi Geert,

On 10/20/2026 10:27 AM, Geert Uytterhoeven wrote:
> 
> Hi Diogo,
> 
> On Tue, 20 Oct 2026 at 11:15, Diogo Ivo <diogo.ivo.sx@renesas.com> wrote:
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
> Thanks for your patch!
> 
>> --- a/drivers/i3c/master/renesas-i3c.c
>> +++ b/drivers/i3c/master/renesas-i3c.c
>> @@ -579,7 +579,18 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
>>          if (!i3c->rate)
>>                  return -EINVAL;
>>
>> -       i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
>> +       /*
>> +        * A pure I3C bus has no I2C devices, so the I3C core leaves
>> +        * scl_rate.i2c at zero if not explicitly defined in DT. The
>> +        * open-drain SCL fields of STDBR, which are used for the DAA
>> +        * pending read, are derived from it though, so fall back to
>> +        * the 1 MHz FM+ limit instead of programming a zero-width clock.
>> +        */
>> +       if (!bus->scl_rate.i2c)
>> +               i2c_total_ticks = DIV_ROUND_UP(i3c->rate, I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE);
>> +       else
>> +               i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
>> +
>>          i3c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i3c);
> 
> This looks like a good opportunity to use the shortened tertiary ?:-operator:
> 
>      bus->scl_rate.i2c ?: I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE

Ack, will change in v2.

Thanks for the review,
Diogo

>>
>>          i2c_parse_fw_timings(&m->dev, &t, true);
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

