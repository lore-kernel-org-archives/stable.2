Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675676;
	b=uyaz3k4oMl+bfR8CL1ck5zMYmJfrtYKD5PqvJXO8/MV1/M36EnKFP5s09ZAPE9qkrLzb
	 8+xcebv/RfMw3ptaqXPon990m1BhVZfAXyCT8a/TkwrKBnTDMIbsqOQuBRp7sn5S70Ul0
	 Xzm96cHV60EP9WlfefaUyWl2aEJnQGtslwmm6igtwRNuObHTa+MMIWYhmYGp19g/GCQgk
	 IK0yTPQZD+/tu4AdbovyavQPBudAM294ndIk8uc3jXemDByl9mC9zVAtmb5IofhJZm+Qp
	 aQ+Og8RTq4vRT0pYOpFgbr5fqH/vGRFEF0EXtNyvj+0ULwZ7qtL++Rd1OUvz47tTLoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675676;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=c+BMZ/Bhsn2DpY2EQn+VzntybXZ2UACBm5iLxRxaZ5I=;
	b=npCgL2uU2i2j3h3+qVmePzqRjI68bHhkyh9BbhZxvKH7UGA7RsielEUWUo0iTGC7wn4W
	 1Sa2q7R/Ioxe7JoJ/xc/PAfbKBzjbaoHcqFdUhojRJ4qSbaRHv1s4vbJyZH7HQYm3M3Ps
	 FyJ6L7j97wRwBj4aq78Lus3ZWcmVBVWNBd08RcgWaEfLBOVlRIyBwcdcLhioK55GjKA9H
	 Q8Fx1lCA5K25J4GSYyP6IxskQ215jWS5wgnUOalY57N70bpQbLnrcgNJ5ehMrgbb062uM
	 yTH1GWcc2CgJhWwfCU3cxHJpy4VYlMMSq5dXibWRxSp25qWk15sr0tKVUzr8RMo7e4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X+uIVAvD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.23
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B6606A31C;
	Thu, 26 Nov 2026 06:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D11B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X+uIVAvD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLg4ZwjFe+s+tJWETGIiVGQSotzYlXhJhWRmce/bZ8AG3V6yyIYhxH9gyCeatvNdkAip/sc9s1Ei54ZBUwJ+FlA1bGiuGq06Do9uFMYUXI4mpOHXlJKJXJKjfxNz/9v/0noSWjsayA+2YQ/k4zPrIb/63R6rCAjfX7BzIPM6MkBUy4V8FHyHYzKXhkfc79p6Rw8XAWu2kpe++oiFdOtbrf++Yf47RFHPeRn/JUu2BQ8AFN7vzSQihr18A1L96Jc0/H9PcDEUS/jNsBzfvnjn4Q4l36s+fnJBvq4sB9Edhywk02BU7dhqmyT/Gl+Ojlq28rbocuxWhtv2e4V7enf43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+BMZ/Bhsn2DpY2EQn+VzntybXZ2UACBm5iLxRxaZ5I=;
 b=B+CKertZobAtRGv/eLaGwAOXz96bfZFJo7+H57Gh0m0RaWEQE3Oeyp3His2hKEadm95yL5b4YTMA7JhuFJhoQLdDRxwhhDEKHEfIAF5fQLMIPickNRKu02ITtaEVtZdxJw4Jwabbs+FHfLP7ItJoe6gFZ7QppHT8QrDGB134BHvFVGG9+ngNdyZjJYRh9e2hJIdPjEemyKfDeQKDn2Iu25lOJBUVlNUhD6Je3bmFiRDeVXoS4rrJCfU/yOtT1mWsiH9lxy7vrZePmQqSgRzQRgDm2+VojqZmFowFPaqzA+BIs4QQxCrNxfq7MljReDAlERi6eQT6PM9LlUskAYsF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+BMZ/Bhsn2DpY2EQn+VzntybXZ2UACBm5iLxRxaZ5I=;
 b=X+uIVAvDeiryCKicQkzEfVeQi/CiIQtb2CGWEcuNRSn+WTA3ofDdXJynyij69VIGdxP8zJW0Xs+oj1ll/GHjjCbi20ERzjh+o6In6dFKAr375rkg6xOYYi/115hjvUaS1VGxzXGsCfKajy98ttVPwEAomNh+vy4/MrQJO0r3KBZiob9kSGVJs2QplkOBHPLhnW7gPJWcbQ2XacSq1Cn+XIgsGNrbUqhfLdSs+YSzErOXlz8v0mF3W+pJ9VwLrhC6TbIM3mvLwPlUxDfe+JjNrxmE2NBSNY7l3HaR8n3PjTezPJI2GD4WrWTtWlpz6lhAdJ+B92Ca1Mf5Kqw1s3AObQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:47:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 06:47:50 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH v2] gpu: host1x: Cancel the fence when a syncpoint wait is
 interrupted
Date: Thu, 26 Nov 2026 15:47:35 +0900
Message-ID: <bE28ymIUSh2y3qW_UGpq2g@nvidia.com>
In-Reply-To:
 <20261122-upstream-host1x-fence-cancel-v2-1-204760056348@tsv-stahl-riesa.de>
References:
 <20261122-upstream-host1x-fence-cancel-v2-1-204760056348@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS3P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f4::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1e1add-2f66-424c-5bcb-08df4b893057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|366016|376014|10067099003|56012099006|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|18002099003|22082099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Tax/EDdEkaKpPRS4h3L8pzlfN1A6dMRrpQOn0m7ZDgG5k9k0J52LdHjHtgG6xhQplceDWqE27HxJhR0fd/GBYTVsGuTFxvCNQlHBCWDk55M0xQlIqStz3nAuTmGPrNWzN60Jv/0T6eYFDU5NAELb8Fmm+MpFqtYjd4nPW8F9QpGaM3rDON33DsKaZI7d0ukWIiIT077cBXCUcZPCTVgBQ7xCWHAno3yAuoeSogJ6sAysHK81d3vyRPke1LBBsRDgVWKDljx4rHEqfXR7JP7BkR8Op87Vf6d7XcXCyLpu/IHws5jQ8Q12g2Xpo/sRCtquSr2IoklgiWdWtlD4IBbVCNzvQ3zfrgNlePu7OP5qtNav9vGfyLi7UDQJVuIGwD15osYBeq6jMJm90lGVVW78YV5dix6oCX9Z/ih3aOyOsTMxWQ9Av8HCZA+NQdpIOZtbZU61d2b/lwi2n92n8yJC183glrJvn6J6atTv27D82Fm/GtymJa31WxHlQukRhHjPgHJYff/sP5FjdLGFxP6tPLuyTJuQKOgKHO0efF9lH4gI7OF4m8pOl4L/tfTTK57ZFq3vBi6uY6GKKKLR7jCv4bYTc601lQ3Pf4mD0ZKAAhgcLK0dMWL0xhk3Hqkr1cTEhrYepv1ry+rf1oS7fPat0vjGQny3s8WVbWQYYydlnyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1d1NlhRb0RYaTl3VXpYTVZMWUR2YXo2SCtyWTROSldRdDVYZ040ZG11VnYr?=
 =?utf-8?B?N3hRRXJvVGJ3L051K2ZmWXhnL2FrZGtKTE9NN3pmZkJmei9oMERzdFVyVTVa?=
 =?utf-8?B?SGFVZDhCaFd6YTI2ckdISVRWNzJxQkMrZ0ppajJtYW9sT0s4dHJSU2g3ejh1?=
 =?utf-8?B?VHFWRXAvMENrL1FSTlE0elc3MEFnU2hWRE5tdWpVWE5OYzUrV0FuWTE5Q1dr?=
 =?utf-8?B?dkN6eGE4WXFKbldUWXMreU5NVkllQzY1RkxLZFpKT1ZXbkZZRkpYZm9xOEVN?=
 =?utf-8?B?bUNwRmFmd2RlMzFBZ2VoTWljRUpaamVWcVI2bk82UjhsSTV4cUxMNmErMkgx?=
 =?utf-8?B?eFhqTWhxZTNObmtvL0tlUy83aS9PaTFQSTBjc21RYXVxclc4N1lGT1loc1dK?=
 =?utf-8?B?WTRsVFVVVmFGUUZKUzVNcWt6eENBcTBSNXlZcFhzUE9uMkxkZGg2RkZJcE1T?=
 =?utf-8?B?VFVSMks4cEl3eENaWkd5YjFpR0VKaDBrNldaSDlRMWpUSTJEdWI5dVcxM0Ew?=
 =?utf-8?B?ampRbzJrbDRRQmllMnRWZ0IrTlcyMFZQMXNKVEgzQWN2M3kwc1ZNbGFRSHVZ?=
 =?utf-8?B?VC92NitBUjNCazFObGwrckxZQU52OVZBMCthVWNMSUJNZUh3VTNVQ1lldDk3?=
 =?utf-8?B?NUk0T09NNjkzU2NYdzU1UXdVNDlaZiszZXFrUUltK0lmMFRqRm1vWGY5YmRU?=
 =?utf-8?B?UnBPQ0NndG9kYmJUWjdocm5PRVgxR1pSWEF0QUkvOUY3UHp4dVh2MDZnekJW?=
 =?utf-8?B?QjA3QS96S2FFbHY5bjVIbzVHbzZyQUU2Y1k3akVac2YwY053VFNjeEY2Qi9l?=
 =?utf-8?B?SmhRYmMwZ1QvVkhqYXBZdW1EOWxZazVtTm1nSHFpVHhFczFlcS9LTVZ2emJP?=
 =?utf-8?B?MzhUTGJSWVlKYjNzclFjWTRueWRDanVxd0puaDlmZDMrKzQyN2RYMndhaUsx?=
 =?utf-8?B?OGE3MHgzdEI4eCtkTmo1T29ockNWY3NQMm5ITVpvaW10K0x4cURBUW1TZ080?=
 =?utf-8?B?TGFMOTY0UkN4OXZ3dGRHNWh5cnpHVkVyQnAwQksvVVFrYXdGSW5ZK1l2V094?=
 =?utf-8?B?dU10MEJIMzlsNlpVa3hnU2xMTWFldWFUWkdMMllFNDRFaGpRZVV3a3dKbDFo?=
 =?utf-8?B?eVJJUzJVTi9OS1QyVDAxaGo1bWpQU3RtYjhkc1NBM2lhdWFsMjRpSk1GdmRz?=
 =?utf-8?B?T21IU1EzUDRNVTFpdnI1VG9DaTdKUCtBZ2IzYTNVQ1JHTzFKeHJMTENhTGdO?=
 =?utf-8?B?RmxJNHZiWm95SkJVWk9rQmRxTHNGTE82elY0dkpab3ZSeFloVStoWk82OVNK?=
 =?utf-8?B?Um96NHhPSFMzSG5wWTdXekQ2dHpHMHllTXl0ai9KYVF1SGMrNnNOeHp1dDlB?=
 =?utf-8?B?T08xSExCTjh6V0p3YStNbU9WVUpXVFZVOGdHTmEzNWxDVW5CcXBhcE05SUxm?=
 =?utf-8?B?Y01UeC9zZ2p2Qkoxa29jbWQvN3FKREdwT0VSM0xOa1dLUXFGUkxDTGk1UG9Z?=
 =?utf-8?B?TzFxdW13NWRvSWo0b0g5Ni9nMmVKbWM2dDFKMkVBN3RPSWJ0bmMrMGFuRVZr?=
 =?utf-8?B?d2tIQUo4aGxiTktXZnVyakhJeVhDdDdTNHBBL0FNVTkrS0x4MkFFREl0SWND?=
 =?utf-8?B?SW9BSjJVL0VsTXo0dnc4RXY3SkNUNTZvMjZPSTNmd2pianlxNk03NUpjbWpC?=
 =?utf-8?B?VVR5Nkw2Qm5RNnVEY0k0dEVSRHVVUm80N1NzMUV4WHZHcTB0MlprY0wwVzJh?=
 =?utf-8?B?eEJsU25EcGJKb0JxYTk1ODlLbmxVRFBMSEV0cnYyckpIT3RTVmt4dTdrWlBX?=
 =?utf-8?B?SkkySEpBNEdGdUxkUWFReURGdnZ3akxhSlcwKzZBbHljZkNjM0RRRWZhT2Zl?=
 =?utf-8?B?ZEhFOTR0Vk5vVHVOQTd0Mnd4bzh6elEzbjFvN1hQdE5mT09XcE9ob3FaNytU?=
 =?utf-8?B?RHZVRnYzZm5GdXRWQ1lUNCs0YkIwdzc0MEpYZTBoRXBnSkY1L0xIbVl4ZDE0?=
 =?utf-8?B?M05UYnNRRkJyS2podTNSeXdkNFRNUDJTMnpoTHdOYk52WGUwdGRkVHVzWFN4?=
 =?utf-8?B?azM4dTFuNkltMVZYNXo3N2ltSDVtY2lNa09Ld056NktoRGRuOWgxbXlNdVU1?=
 =?utf-8?B?Vzh3eFB5dUZjTG9ROHZXQ3BMbVpLM0lEM0M1U3N5M3lXZXM2QjI5WGtSdHdN?=
 =?utf-8?B?WFJGYzZyVzNCdVFDbVpiKzIrMFIrTExZcDVmMFROTm9yaFBBaTNQNU1aM0Z1?=
 =?utf-8?B?SG12TCs2cWw0b2tUVTFBUVNFQkdnRFZWcWhabE9MczBqV2FTRVVjT3VRK2Jx?=
 =?utf-8?B?TzVkTmVtdjJEVmhzanA5RmF0ejhnLzJtanZKVDRvNmZ6Q1kwK1dRWkwvdzlR?=
 =?utf-8?Q?j+e4jsVmHF2DLmZ9P9jTUIzquI231WOWAGYGT2RX9KXpL?=
X-MS-Exchange-AntiSpam-MessageData-1: mrsRAu/JI5mZWw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1e1add-2f66-424c-5bcb-08df4b893057
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:47:50.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPdBWjxtPq4qGWgO00f/AGP2BCnxTbb+C+RH6dza1p5uhTG4nRLYmRfIeb0mfbf5cCvl1irwBqrY4K7LEPgeAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

On Sunday, November 22, 2026 6:12=E2=80=AFPM Patrick Fischer via B4 Relay w=
rote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> host1x_syncpt_wait() creates its fence without the internal 30 second
> timeout and cancels it only when dma_fence_wait_timeout() returns 0.
> If the wait is interrupted, dma_fence_wait_timeout() returns
> -ERESTARTSYS and the fence is left on the syncpoint's fence list,
> holding the reference that host1x_syncpt_fence_enable_signaling() took
> for the interrupt path. It is freed only once the syncpoint reaches the
> threshold, which may never happen.
>=20
> Callers that retry on -ERESTARTSYS allocate a new fence each time.
> tegra20_channel_capture_frame() retries in a loop without delay, and
> while the syncpoint does not move, for example with a camera that
> delivers no frames, every round leaks one fence until the system runs
> out of memory. Svyatoslav Ryhel reported this as an out-of-memory crash
> in the VI capture thread; the allocations in his report come from
> host1x_fence_create(), called by host1x_syncpt_wait() from
> tegra20_chan_capture_kthread_start(). The DRM syncpoint wait IOCTLs end
> up in host1x_syncpt_wait() as well, so a process that is signalled while
> waiting leaks a fence the same way.
>=20
> Cancel the fence whenever the wait did not succeed. host1x_fence_cancel()
> is safe if the interrupt path has signalled the fence in the meantime,
> as do_fence_timeout() then returns early.
>=20
> host1x_fence_cancel() can also run before signalling was enabled on the
> fence.

Well, not before this patch is applied, which is good to clarify, but=20
not a big deal.

> fence->list is only initialized in host1x_intr_add_fence_locked(),
> so host1x_intr_remove_fence() would then see a zeroed list head, call
> list_del_init() on it and report the fence as removed, after which
> do_fence_timeout() drops an interrupt path reference that was never
> taken. Initialize the list head in host1x_fence_create() instead.
> host1x_syncpt_wait() does not hit this today, as
> dma_fence_wait_timeout() enables signalling before it checks for a
> pending signal, but the cancel path should not depend on that.
>=20
> The leak was found with the help of an LLM assistant reading the host1x
> and dma-fence code against the call chain in the report.
>=20
> Fixes: d5179020f5ce ("gpu: host1x: External timeout/cancellation for fenc=
es")
> Cc: stable@vger.kernel.org
> Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
> Svyatoslav reported the out-of-memory crash, and he confirmed off-list
> that v1 stops the leak on his LG P895 (Tegra30). v2 changes the code,
> so that confirmation does not carry over to it.
>=20
> I have not run v2 on hardware. The Tegra Note 7 I work on only
> captures with Svyatoslav's out-of-tree VI/CSI patches, and I have not
> tried to trigger an interrupted wait there. Build-tested for arm and
> arm64. The DRM IOCTL case in the changelog comes from reading the code;
> I have not tried it. The same goes for cancelling a fence before
> signalling was enabled, which no caller does today.
>=20
> The retry loop in tegra20_channel_capture_frame() still spins without
> delay as long as the wait keeps returning -ERESTARTSYS. With this patch
> that costs CPU time instead of memory; how the VI driver should handle
> an interrupted wait is a separate question.
>=20
> Tool use (see Documentation/process/generated-content.rst): an LLM
> assistant (Claude, in a chat) found the leak by reading
> host1x_syncpt_wait() and the fence code against the call chain in the
> OOM report. Claude Code then checked the finding against the code and
> wrote the change, the changelog and this note from my notes and
> instructions. For v2, the chat checked Mikko's point against the code,
> and Claude Code applied the change and extended the changelog. I
> reviewed the change.
> ---
> Changes in v2:
> - Initialize fence->list in host1x_fence_create() instead of
>   host1x_intr_add_fence_locked(), so that cancelling a fence before
>   signalling was enabled is safe (Mikko Perttunen)
> - Link to v1: https://patch.msgid.link/20261113-upstream-host1x-fence-can=
cel-v1-1-89f453504222@tsv-stahl-riesa.de
> ---
>  drivers/gpu/host1x/fence.c  | 1 +
>  drivers/gpu/host1x/intr.c   | 2 --
>  drivers/gpu/host1x/syncpt.c | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
> index 1acf579c562b..f77a391b9195 100644
> --- a/drivers/gpu/host1x/fence.c
> +++ b/drivers/gpu/host1x/fence.c
> @@ -134,6 +134,7 @@ struct dma_fence *host1x_fence_create(struct host1x_s=
yncpt *sp, u32 threshold,
>  	fence->sp =3D sp;
>  	fence->threshold =3D threshold;
>  	fence->timeout =3D timeout;
> +	INIT_LIST_HEAD(&fence->list);
> =20
>  	dma_fence_init(&fence->base, &host1x_syncpt_fence_ops, &sp->fences.lock=
,
>  		       dma_fence_context_alloc(1), 0);
> diff --git a/drivers/gpu/host1x/intr.c b/drivers/gpu/host1x/intr.c
> index 30f3dff4487b..380f679b4d7f 100644
> --- a/drivers/gpu/host1x/intr.c
> +++ b/drivers/gpu/host1x/intr.c
> @@ -47,8 +47,6 @@ void host1x_intr_add_fence_locked(struct host1x *host, =
struct host1x_syncpt_fenc
>  {
>  	struct host1x_fence_list *fence_list =3D &fence->sp->fences;
> =20
> -	INIT_LIST_HEAD(&fence->list);
> -
>  	host1x_intr_add_fence_to_list(fence_list, fence);
>  	host1x_intr_update_hw_state(host, fence->sp);
>  }
> diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
> index fe74ff6fc6f2..f9c871f218f3 100644
> --- a/drivers/gpu/host1x/syncpt.c
> +++ b/drivers/gpu/host1x/syncpt.c
> @@ -247,7 +247,7 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 =
thresh, long timeout,
>  		return PTR_ERR(fence);
> =20
>  	wait_err =3D dma_fence_wait_timeout(fence, true, timeout);
> -	if (wait_err =3D=3D 0)
> +	if (wait_err <=3D 0)
>  		host1x_fence_cancel(fence);
>  	dma_fence_put(fence);
> =20
>=20
> ---
> base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
> change-id: 20261113-upstream-host1x-fence-cancel-0b32753150d6
>=20
> Best regards,
> -- =20
> Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



