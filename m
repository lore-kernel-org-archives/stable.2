Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795792642;
	b=Ugz8QS2kLgoUBJ18IsEqlcGcamONLSyHIJDoLvciwB2R1X4lKLr2E7t+DcpxDS7CvYXR
	 f3clGTsn/ME6s9LvhxC+uKjI7PE3T/0TSwByM2/fR68e9/F8gZyeq2u/b5dbUpS3obBdm
	 dNfqfQwnO/VWvFp5uZQBxkyo0yC68rGBY5px45d0ee1jZv0UVNWZH27MLVFuRnJU/Moy6
	 nB/xQFiFL5Ba9rMtckwkZdGaGjB3zurRVEufRGmJTaqqoAh2Zx8XkQEhObWUMPfS0KZxi
	 meivrDt5kAWk57+Yijh439QSmQ3FQO4BVmAw5B+MZIDJL3nMxK+zBSgjOExYB31zjnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792642;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=qLgxlEF95K2QKcfJ2jJc9Gl2AxmgeKzFdnbN8+YadCs=;
	b=3x5WC1Yfo3xB4DPj01JduEGT9O53ekIBlsEOVTS2m5zSq+ysvdgO9pgijzwv+FOo4BZx
	 sz5p8OIWyJZltw7kII+Luss4VRodfbypkLVlONecHrvp29WZQQIse/5lybB5XbQRRovgH
	 a89N8iy+5R01FxZ7rUSWvKDcKo2Jf7Yqz0WEY8xEHc7Njph6MzW4QJ5qtN4o7tiU/TfZR
	 32snn3JbTR5mSV/Jy2nNtBZyGlWMbDpNigKf7vqLdo3/0flrSypwAMuwMrwyAB2+XWGGn
	 eUSayEMZpBSKQGvkvAQS4PZYA4Ggnw1M65rW8EAjPQ/2/CKFzGx4JEH7JpGUl8R8htg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=coLSzTja;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.25
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797E606A31C;
	Fri, 27 Nov 2026 15:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2797E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=coLSzTja
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnOba34qWkDyN4pnv3Vep1UZ2PSuSYjRcVXlEymx1FovHrPEe5YsQ+IRpmloV+fZVhPmr7n8iyxtTmd//iVeCI56Yl4aQZvnPnMYz6KH+p1Et1ia9J2NYmeYu4/6GVRcB9eZ9NqQhuao38snWfH7hQW4hnVuRrJQFlsbD1BzqLVfzyl1yBs8lab7v1G57uzmZ7avZrDOPVw+twiLh7ifcDl/LIlsxASbABJx27qiHmNzIAryj2o0WeYFutMtR8mmrC4/84RYGQ2B6E98BaBrOZRzApYoz1Jpj/hefz9UsAWKXDT7UwZElRSfxicjP1m7gllK/lDPTPNEje8/bOcCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLgxlEF95K2QKcfJ2jJc9Gl2AxmgeKzFdnbN8+YadCs=;
 b=w9emtxNJOkazu7oBcLXV4yAXiMSb4APAIb43ewGiFoNNB9q3Oz0BgeXlu2Q9586whMp8YHgxxI20efyESSPdxvBJ8eapGIfNOoQPMclIxZ5TB7th1MT8hyNaodmdWoc3y7XzqTHA30om8x8dsYb296iaoY1zTIBTZagyPoKzjhyXsqUgPNdFAX8b3yX+XSFInFxIzqGqQr9/ofNVoUDG2iv/l8aa1B490XLi08hw5aQNPz2+tfsl4c8BAnfvpW7pDX3cORWii78YBUkUHkQwyauFHA5ioLMtS93xL9MSRU2Ya044dQdb7PRGuPlYjTM2etmqG+3r3re114u82jRdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLgxlEF95K2QKcfJ2jJc9Gl2AxmgeKzFdnbN8+YadCs=;
 b=coLSzTjaVEkJk+Lo1npgJozj0415sK7sU/1eypZ/JdXrLZNvQMJ/1g1cUDolMsgeqvvyXCFAjWdB8dJIqPVGUGMFloNQbYsn3F09h4HDcqjY7qjEWZjgzBjh//YHBCswQjPh74XOc03X+jYCdnT0ZeLDRDtUL2qwkMmJO1JN3t2QUKdd6cI6TWlRq/0LhSZ81/wS3sQM/lgZ3Vgb5lLVaYfM5Nhm2RPS+FiqK7NkVRhoglnSvXuf33ImTVk6L0SgN2LYCe6nCH1T75t8a8Pr1SZEMzrr73TdpexdRllDw2i/iOgzpdqS6w7xjsfQFVz0P3MPbJKPJx8DMh9POrFaew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH8PR12MB8429.namprd12.prod.outlook.com
 (2603:10b6:510:258::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 15:17:18 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 15:17:18 +0000
Date: Fri, 27 Nov 2026 11:17:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
	Alex Williamson <alex@shazbot.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
Message-ID: <20261127151717.GO114472@nvidia.com>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a@eucas1p2.samsung.com>
 <20261127115849.2780625-5-m.szyprowski@samsung.com>
 <20261127143740.GM114472@nvidia.com>
 <feec2436-ad15-4aa6-a53f-800869bfac21@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feec2436-ad15-4aa6-a53f-800869bfac21@samsung.com>
X-ClientProxiedBy: YT4PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 359f8386-e91d-410f-7343-08df4c998691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|10067099003|56012099006|11063799006|5023799004|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102130727099003|261009223027099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0TpEwr6X4KEM4uBTUBl8Xzk6Sm1Ubz+BWIocT5EglP7UXp4hFMM0ZxF3U92dsoYAR57cA9YM3YHh/ba7W/jGFR7m3Uk+gDK639ChsQOi9tXiOcc9fIl8OY4EH6t/9o9W6du6wVWx/68tD74UMW4kfnc3H929TfIWjwh7SWW1Q+jn8+istBOYfEbp/iQhL9EMRh+OmCUOBJBWBql36qfTKCND5avdnKJso4NhEnFMiBfdPEWety0qNCPXDbVMMbR8HB5pjv1U+TvqY5rLuIRi9AADm5HAuT8GXq9EpFL5UdycieHA/iJI8qHY/6AhEvkp1H4oYO2+FMp0kvQiP2Lb7fR4qjl55HebCKGIYv1dqYuMt5tUBTPgFS0XXJn+/fBSMdkFgWwcA4VQASO1QygiMMCXzOy/fuyqbaZCgSEwIkR2vKsSE8/rWvOSWCSAUw76p5S1Lp8ADv8RXNupPFQZwZ+vrRRh7mRHMHkCAQhRiQ5wK0ocO0+WGeOPzbTFMvwtvRYbbZtQ75VJQcLVxxpDzAEWcA54p8e1UNy+wy9anSah54ZbGuewaqBzvVNhHjexwhdDXEVzWZjILtUtC0sw8gvaA+HNPl8bTBL5jKSzoiCC5AHjyl6+b/oDpFByBEHh9dT7CyCyvzobTD0OFIh4g/oEMdcUmgr1PoOWBfEaHYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(10067099003)(56012099006)(11063799006)(5023799004)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFh3bXRITnZqb0RjTis2RFp5aU9DT3FYMzFqZHVoTlV4dlRQd0N3VFQrcDAy?=
 =?utf-8?B?bjk4VUQ4ejNzckx4eXpyblN6alpkSkhjZ1dPcm8ra3ZhMENBeW9tRFRRa2Vr?=
 =?utf-8?B?ekNuR2o5ZElKQTBPc3NIeXpCeTVCcEk1MDZCSTBDZ0p5WkxYb1J4SFN0M3RU?=
 =?utf-8?B?YnhQL1V5emZyTkpaUkhKQlMyTUFyUHhhZGpKbXd2OGVacU1MZW9tWS9yUXlN?=
 =?utf-8?B?eUVoYXczQ3crZDZ0TjFTWVhNM2dKTWVia0Y5K0UvZEJseXhKYUxzVjRSaUtk?=
 =?utf-8?B?STQwVmNmdGNlZ3pWL1dkYUxxTTc4aU9YcjdVT2JaaW1Sc2lVYjdmNWRGV2FG?=
 =?utf-8?B?S0k4WEMxbUxCZ2Izc213T1MvMkcyYmd2dzR3WGtUa3I2L3djTWp6czk2Y0pE?=
 =?utf-8?B?cHpnYmo0TXM1cEUzUTVUbmdUbHFDRWRlNzl0TmlEakZjay9taHRBN1RaNGJB?=
 =?utf-8?B?QnVqbkw5dzB5eTRYTm1sdEU2SnhBMGQwVkcrY3gwb3ZIS3l5MHhtNzlYNDNY?=
 =?utf-8?B?UEx6VFg4ZWlnOHova1FzTzlNZ2djZjlvbFk3QnMvUFhYSUtDSUdMNGFrK3Bw?=
 =?utf-8?B?OG1JSm1oWGc4RDh3MlQ4MW9PenJyMk1hT2tlM0hHLy9oZDFMSHlHRTFzT2dY?=
 =?utf-8?B?cXArNWNVWW9wVWdBRWpjVDR5OHBYTjc0RHJzcTRjaktCV0FFTEhVYmFwTkZx?=
 =?utf-8?B?djhSRGlIRmtjY21Cc0Y4dHdGd3l3U2lqR2ZUbGE2SFFhYUx0ZXI0OEtCKysy?=
 =?utf-8?B?KzBhcnFnejhFc3lsLzkrNzVmTG5acUZKRlo2K3JURlpkQ2l2ZXp2VndONUFQ?=
 =?utf-8?B?bFoybjFMZDBRNHVjSzBNcUVmbXpiZWc5VTNPSzBpbzcrZzU4UU9PbDN3OXFt?=
 =?utf-8?B?SlhwNmtNY1hZSDlmWnNhZFBJeGJlUTZaaVNqWVExRkk5QkNqUklwL3FINk5r?=
 =?utf-8?B?b1BPbEJGNWtvbklZRUJGcFpXZ2g5Um44a1NrZXpJUlY2REg5U0dJVC9aSi9q?=
 =?utf-8?B?RGdjK2t4K3E2UjgxdmkrcGJZTDhmeUhhTDN3VUxhTG9jOHVvS1pteDNVR0RR?=
 =?utf-8?B?eXp1TUZCS0hHd0dHS3dxcDhOOFlmUk8rWFJQTW5YYVQyNUhhblNxMS81dkhq?=
 =?utf-8?B?aFNIcXZwT0R5K2NNdFB1QlVuOThlT1grRm9UcTFXSEdKeldSQlFHT1hhZTUr?=
 =?utf-8?B?bXZaYUNhdURhVzFKQW4yMS8zV0RNd215RmRqL1N0bkFERWMxdUk3UU1iZzVk?=
 =?utf-8?B?V1JCUzAyNEtOT3pqMlpwMmtlejFhUHNUM1p2YUZDZTZESFhscTJici9ZUGU5?=
 =?utf-8?B?RlZ1ZmtLN2dESGNIMHZkeDg2KzZRTzZlYk0yTjNXRTJ0NUtpR1RLMXphZlVi?=
 =?utf-8?B?dGF5NFRYb1Y2SWY3Uitva0VsTkp5OEJlU2hOcGorRUNCb2txdmc1M3dVejg2?=
 =?utf-8?B?VXJjSEVFb01SUHN4Y1ZrVUpJbi9GUXc3allrbGtUczNYTGgzZkxzZVNXYkow?=
 =?utf-8?B?akdySWZaZk45UWkyQlZXVWl6Yk5KZlNoS24zNFAvQURQdVJZTE1ZTmVZR0sy?=
 =?utf-8?B?cmhtNWMrWG40N05mOUFleDN6dFJ1REJaWDVHOXh3NkpBbWVBM0s0VGV6UkxL?=
 =?utf-8?B?TkhwZ3J4SHJCbnA3cXp3OWVXQWVLY0p3QmNIYmFBMFV2cC9yUVJXRmxjMGVw?=
 =?utf-8?B?TEpEVkdLbzg4MGxHNENkQm5ISll1SkJIUDRQR1lDak1xZTJUSXllalYzZW0y?=
 =?utf-8?B?ejV5Y3lwY3J1L3IzOGF4WVkvTE9KaXI5UDV0N0crcmR4WEVGMXBoVzdyY1Iy?=
 =?utf-8?B?S0lMVEtSVUFYeThRR0wwcklTV2JoTEZ3MWZ5K1AvRUU5WEEwNGs0Ni85bnBq?=
 =?utf-8?B?T2Q1MjVSd0NMZzlnenIvZW05Q2ViK0M5c1FwMnNOaXFyVGxHMWJnVjM2Skh1?=
 =?utf-8?B?QWc5NzRUb01ES05NSmxSZ2h2bXRFb0E2SDZTcEppV2g2Rkc4aW41UjIvOVpa?=
 =?utf-8?B?TFhoenBBak1qdzBQT3lLUi9zMDMwRHR1OUptR3lLc0R3UmNVbmd2UTFLbDlo?=
 =?utf-8?B?VnlrdHhsVVF2bDN4SGVUZWZOb2g3UG5XZkdrVFVIbmZQUjNoZUE5dFh5aXVi?=
 =?utf-8?B?cDdkTFBYUnllUW1tck50bHpubFZHVWswTjZKSWNBRWJwbU5JWHMzRlpGNWFE?=
 =?utf-8?B?UTU3U21SaitjRWFGbzYycWpDOFRIUU1lMUFCOGVQUS8rcC9TdHpnZFk3M0Y1?=
 =?utf-8?B?T2NVck12bGhCc0cycVFqMUZUaVJWbWZML0RBS0V0V2xLdjc4REY2S05sSThy?=
 =?utf-8?Q?ATHzNi6r0mixgFBpoj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359f8386-e91d-410f-7343-08df4c998691
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 15:17:18.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMtCiXrSbtRj3p6M0gJioIkvbq/UTjmE5MMZGx+SMGYCOMlAwUAuT6dAuXxjQ3ZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

On Fri, Nov 27, 2026 at 03:45:15PM +0100, Marek Szyprowski wrote:
> On 27.11.2026 15:37, Jason Gunthorpe wrote:

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0e329ecd7dfa..106da975bf0f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1892,11 +1892,12 @@ static void __dma_iova_free(struct device *dev, struct dma_iova_state *state,
>   */
>  void dma_iova_free(struct device *dev, struct dma_iova_state *state)
>  {
> -       struct iommu_iotlb_gather iotlb_gather;
> -
> -       iommu_iotlb_gather_init(&iotlb_gather);
> -       iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;
> -       __dma_iova_free(dev, state, &iotlb_gather);
> +       /*
> +        * Nothing is linked any more and every dma_iova_unlink() has already
> +        * invalidated the IOTLB synchronously, so there is no deferred
> +        * invalidation to wait for and the IOVA can be reused right away.
> +        */
> +       __dma_iova_free(dev, state, NULL);
>  }
>  EXPORT_SYMBOL_GPL(dma_iova_free);

That makes sense, but I'm a little lost why we needed the
DMA_IOVA_USE_FQ ?

If any queued gather was ever created then the ultimate free has to
also be queued. But the comment implies that queued gathers were never
created in this case?

> @@ -2190,12 +2191,13 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
>         struct iommu_iotlb_gather iotlb_gather;
> 
>         iommu_iotlb_gather_init(&iotlb_gather);
> -       iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;
> 
>         /*
>          * We can be here if the first call to dma_iova_link() failed and
> -        * there is nothing to unlink, so let's be more clear.
> +        * there is nothing to unlink, so let's be more clear. Only queue the
> +        * gather if there is an unmap whose invalidation can be deferred.
>          */

Not sure what this comment means now? What invalidation cannot be deferred?

> +       iotlb_gather.queued = mapped_len && (state->__size & DMA_IOVA_USE_FQ);
>         if (mapped_len)

I'd probably put it inside the if..

Jason
