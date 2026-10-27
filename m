Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793068368;
	b=Ik2ph6tlX1tdIHZkOL4W7Ik/v70bRxYW6gl8RvOGRlRL7DYysfVIX60OK7Kri6ow4d4b
	 oxkNBS63aC3CxHBB09JpNUiw9StZFunvalDIYSDytzvqfQTDrE10N4s0lu/2WnTfRL6Ul
	 l6chlfJgaaTUKOc/EdSl7rpmZ3r6rs59UadBblZeagUKyKRvnpv4tZ2ZKkoK2iLKCGjr0
	 nEGTLP/iQsyDQudsc16pjC/XaTfH55IKsxohJL7tJz12jJveESXNO+EpmFvkW0diFiadH
	 fjbmtpOTMpthK49+RJzkBU9Jth4rxAAre7ILc0D4TLikZqrwQafsrJNQPubTUmGY4uA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068368;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=N3BH6uXe99G+oYIrm6du6+/iVxKoG1o0BHyZ52mns6A=;
	b=TxsoxBR9O+DaLHmjJJEFAx3R1lzjhy7Q6awaRFNOKZs1pJLQmYmnYPLQHZV6IjXOQHAD
	 mmWuSn+d5UMajGqwGUFaGDgnb54Z5CUF6KAQ+t4w7fg70LMMB1B2vAsA1hojL1Ov/0i4X
	 RcAzyDrZBpM+wRDLwDJYGpoAjGI+OuVn3wpQ80wNRFYn4H2Q3STnlLIEPirczD++xEqZr
	 Cn+xP8tQoD29riiICTlLTraM7pc/5JTqCLzKs0n6PV3AJyxHYoyqMXPn7vrp4hJzdnmhJ
	 KWLsrepSLuC9V9LgX3KDDNa15hemXBWBwrBPdq0h8tabTzK1PEYxEJnQVOgp6Jl9gMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hUlKQzoI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE409606A31A;
	Tue, 27 Oct 2026 02:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE409606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hUlKQzoI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvy6gYv09TbDoXpicWxxfmqle+MPzj561JPHTLorp1xrRKC222kwXcDBsClk9dAxwwilgdUhyyXJWHPRs4DlJDU8oJd3e0QA+u2NnTV03zKN6Kl8yfQCSoAWXEuf+rGpypuW5ShvsBmhFplcCWDRm7XMAL7yCx+f6fDb/x6t+yUDbngBGgIziDzJU9KXHKy1ocBTHKiGXHd2qoq+orczAMgxeD3wE4rgzqV/4MXtlEwcjFQLfG+hurMY0v2MsVbephi1JcRAWv+6b5paab+6Ts3FWg6H3izxdZcY3t+L4PdBGYIcRzN2KzMIcwByP5FET4EjmoOfVUWEgh7kffci7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3BH6uXe99G+oYIrm6du6+/iVxKoG1o0BHyZ52mns6A=;
 b=l0dmqg3AQ3QeDacb3b6o2s5xN7jKTtrDr4nYI57jXj5fVH3D6p4tbdGFjWPKE3EVYtTGN7YKp27fCPzALLsgvfmdJ+bqGvx2ogv43pBnEXAasasI+muA34fe2pZt5QEWSXSRIipcL3XoE9C9zfpWdSmHcn8lCGnKu3YP6/UNzvuGrA/97iqOnC/fpeZgYK0+k3zjmB8H2DdBKE43U4S1QpTM8hqNqZb1Qm8aES+c4YuUXl2A2QN8pMFSByg0xH5U2NK9lGUS0EvMtgfE3P0txeBbD2WEmrD+TNJsd9AgHW7Kw2ZZIrx8C5X76soJmrpLO0ZF2Qpovh0bZMKtmdN4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3BH6uXe99G+oYIrm6du6+/iVxKoG1o0BHyZ52mns6A=;
 b=hUlKQzoIuQcDHl/kiw7G3I5CSgeIhiKTqHiOIghWlm7S1ZOMIBsL1I8EKKJPEGRQK4O39aCws+Zp/NsxFhp8Bsvi84loI7c47DpWXkmBmDQRhXzVwqhJxMi4xoWM0nXDLfLoDEckt8i37HJc7G80uohAQe6yM33DHwfZ2RL4/nW2FGUyqAgzyc1CS469xqx5s7qzvHQrjmZ7UDJJvV/1BMnj2By0Ne90c2lBPPNu1v+egy7ZHJ1udDleKhmwwPYoC02lWlkpTEE4jwVXMaoPAW2IlYRbMlJ+1fQt2zsNVE+YhPy7kheBjqbXS7YRdcxX1aws4BXcW8nVhY1URYog7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:32:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:32:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 22:32:38 -0400
Message-Id: <DMF9OO106FGX.3P7TZUBGHUFII@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Gregory Price" <gourry@gourry.net>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Vladimir Davydov" <vdavydov.dev@gmail.com>, "Michal
 Hocko" <mhocko@suse.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Lukas Czerner" <lczerner@redhat.com>,
 "Carlos Maiolino" <cmaiolino@redhat.com>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Daniel Verkamp"
 <dverkamp@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Stevens" <stevensd@chromium.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "William Kucharski" <william.kucharski@oracle.com>,
 "Chris Li" <chrisl@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Nhat
 Pham" <nphamcs@gmail.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 11/16] mm/shmem: rescan after nonuniform folio splitting
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-11-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-11-703206d5fa0c@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0219.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::16) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 11339e87-026b-45ac-87ae-08df33d29255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|6133799003|18002099003|22082099003|261026121527099003|921020|56012099006|4143699003|11063799006|261021123027099003|10067099003|261022105027099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	oFs/tqf8Wf2nVZMSwXdSlABPs+Kj1HeIdgWAVuR/1YeI5CGk4IGTlW5+nfOl9vBEj0FGLTgE0lnDB5BBtCZ2MGlZ3qTmcVgMpXKvUCm6T2priOwBe/7Scu6ZcfBS1g/oHbSP04dvoZ1sbOEhaHhVPFtrpI3Ics0FNVvgIw1K1MtKotTfrAZFOvcbhvrmz5i00jfW6gMqRDW5hK62A0UykEUPWmJS4sbnR6F2uGExqQXWIPvXNKWzkNLsBcCQ1JYrx0fCOwXLW6LC6d8G3IWXeRKxKuxsfq2ZCx2ExOgbfqt4ADA3swAtzLVQUw1ngQh7iwVSuRQD8d98bVnrFfgS2R/XsteiXtN5lDxJiIUr4Mv7Us1JpWl24yT6XRRc9TFzzeCaVORqdpud2f0Wsof03CdGF45PlRLj36EXRDQ/kpVorm2p74t9e9n8w5eb+pzB76Df+36Z28XUFKPIjvDUeJNEOqCII2UURleuaMmDS5elIvahzsovmxhnk+Ljn/w2zCYDkgk2ApzMpqxRhBgEJ6xjg/CWcd33pl0L6ZVbkx7A9KEU9avbet+PrBtWvT8JQMcc2xoiAHg56UHdNPfnKejPDeHGEM5QJYZz853iM3O1e1RTIjYdYgy6iceTAnPfIbC2D0FVz6ttyu2bX9cvq3lXWV/Em6mJ0s3c+cKe8WvmO825NST7e9fW5Au8MVYMRK/kaNsGzfEpYrThqcGzow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(261026121527099003)(921020)(56012099006)(4143699003)(11063799006)(261021123027099003)(10067099003)(261022105027099003)(261009223027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjlnUkZvUkhlTkhvYUxlRkczNnZiR1JEcXMvT0JiM1ViR2x2NU5HYjhYSWZM?=
 =?utf-8?B?ODRRWXk2ZUxFemROS2tjWVJza1hKMWxTSmJodHBpNFlzZXhrNTB5bzdsNFJn?=
 =?utf-8?B?dTJCR1FFWlNMUGRqREJGVnJZbjE1djVVclFPQ1g1bXc0K0dhcWRRS1lFOXhC?=
 =?utf-8?B?N0FZY2ZqZ3Q2bk9uenJ3WkRkMCtpTDFjWGVPZ2Y5QzI3Y2NPZCsxQ3lEa2Qx?=
 =?utf-8?B?WUlTaU9Md3JjS0I4KytoWmtZUnNYOUFiQVZnelhmUm1zTjlpWFFzZVpHLzBk?=
 =?utf-8?B?ekNNd2NGdkRid2RlMmVKNTB2NmR0cTFNaU9rbFJEOGRIcDdzRERFM2JNQmlB?=
 =?utf-8?B?azFRclpZejFHN21VWFZhSHo0UVNXa3FlSmJyVUhvYXpVbmlCNXovQXduczcv?=
 =?utf-8?B?WTh1NWttUlB3WUNvUVBQWHUwbkJQTWNlZm1rczFpOURBSlE4bVlabGF4Nm5B?=
 =?utf-8?B?bS80K2Vtb1d2VFB0QmdXOXlSYU5YWGlzUTZtOWFPLzJjS0pMWks1RWNCdVdM?=
 =?utf-8?B?dDhmZnIxSWc5ME1GWm9UVG9YWUtyUVFSYWI4WkpPMUhVTlI3VUtzbmZCU3ZX?=
 =?utf-8?B?ckpXdzhSTkFaWGY0OTBKY2R6NThwRmRiK2t1UXhjN3ZETksyenNUcjJqUTNK?=
 =?utf-8?B?NThDK2tKbnR1VVVGQlVQUUtzRVdKd0lweEZ3VDdCM21FcmMram0wMkZJUUY3?=
 =?utf-8?B?dTRLS1hLVDhlWHFudWFaQ0hSVHk1SUpZNHpIaUNJQ01YMTgxMWw1d2I3My9r?=
 =?utf-8?B?K01aZXBIZFF2UzV0cWw5elFFd2hKWXp6cTNrcHplMmN3U21MbGkxMnJEWFRq?=
 =?utf-8?B?NEVxenFyWG9sMnNzNk1pTklmZm1DdnF3UGE0TjB4Mjlkcm1Za0JmV2VTUWky?=
 =?utf-8?B?MndVSmZSQ0ltTE9kdjR2YWxVNUhDT29XZ0hQRXVFL1lTNUpUUWRzK0JzS2pj?=
 =?utf-8?B?T2FudldycFpwTEQ4djJNWVJiSGVLUnEwK2VYZDUrQlFVa0lYZUFZRldQRVpY?=
 =?utf-8?B?YVVnem1EcFFWUnZDWWR3cEIzZ09JQzMyM2lRUnBCcE43S3ZWUVBKOHppMEh1?=
 =?utf-8?B?alJQcU1SRGc5cTFvUTFXZ2V2OVBNSVR0SURZbzFEZlNDUmdUUmZTRWVjbGoy?=
 =?utf-8?B?ZHlXRTJNVEluSHhkQVBJbWtHZFFGUEtFMzJIK2ZONVNMMWVvNGFZUUE3bkU2?=
 =?utf-8?B?bHFuSTcrVHdYbU1QdnV4M0toSDRjSzRmMDB3R25XdmY3MSsybXdza2hOVVUw?=
 =?utf-8?B?ZElaUlZ0K0NhTUtDcFRKdWxrRGc1S0dNd3BudGIzLzhzaGliN0J6czNTaXVt?=
 =?utf-8?B?RG5UdDZkbDZnNFFiTEUzZHlzYUo0Q3pORE5wdThXWk1mZ1hWeW82bUVaZkxy?=
 =?utf-8?B?d2dxa0E2cVIwOHNtaVdiaWlIWHRUcmp5UldPemdOMHhKUnJoTlNOZjMrbi93?=
 =?utf-8?B?bEdiQmZwWWFaYm1wTFhEZ1ZmOTBaMHVHSUhRbE5QS25UaTFnUnR0WVNTVUk1?=
 =?utf-8?B?clAycmdBM2VHdjVqSkx5MzJ5d1Zia0lWZkhSbFlRdlVFKzNoRnY4MFY0RUNB?=
 =?utf-8?B?V1hLMzRVUmxJZGl0b2xYUDQ4M2poc0pjUkpOQmRjbnVud2lEUDRWYTFXZktX?=
 =?utf-8?B?L3FxNk02Z0VTaytNMWdSZitDb3BZZXhqcitZck5xSFJ2Q0oza1REQ3NhcmM4?=
 =?utf-8?B?OVNnTVBuMkV4cmxibGprSHh5dThKS285a0VpRU5LMDN3WHplckZ4MGV3VEN2?=
 =?utf-8?B?aXFBQnVaNUJiSktEY0E3cjlPUVRkeVFIT2N0ZUF1eEo0YVlvaGVCelFwbGFo?=
 =?utf-8?B?VVVSV1FIUHJrVXI5ZlcvM0VuZ213UDJFSXhheko5SEgxblNud2JScWtsUnYz?=
 =?utf-8?B?UHRTcDJVRm1IVjA2eEwzdm53YU9nYTNhbzIvbUlkR1h6blpQbHVQTHE2RFN3?=
 =?utf-8?B?eEtMd0s2cTZtb3FJaU9tVGZraWpzeGJ5SEJ4bVpKenBxWkxlUklDYzVyS2Mz?=
 =?utf-8?B?S25XU3pHY3ZDbTA2MmdOMGt0Q2N2OTBnbXN4clQybnBzd010YlI3M2pOK1hx?=
 =?utf-8?B?RnBLRVZTK3JpRjUyNDB3T2MrSVBZdHRmWFlvVGo2SEFIWkx0eWQ4VWlVRktk?=
 =?utf-8?B?RWNwSmNoSGJYZmlZTHRGUDlHUWhzcTJpWVVIVVZ2bFhGZ3hEUWdpMnB6VTZW?=
 =?utf-8?B?M3lsL3B0bTlReFNiR1VCcGJFRHFOWE14ZUE5LzY2WWlFa05DQ2ttNFEyR0Iw?=
 =?utf-8?B?dytobmxOQVY0aDZ1ems3a0dsVnJHRGx6M0xaVFU0Z1AxKzh0UEhqNkg5ZnRF?=
 =?utf-8?Q?Mpaf1AbPXb5fcwGEdj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11339e87-026b-45ac-87ae-08df33d29255
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:32:40.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swuUTHbhu87Sxd8UTHFBEHl5riQqZCes3Prm4jzfSq0OAQy6Mm4Kgkr6LpiLGThx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744

On Mon Oct 26, 2026 at 5:40 AM EDT, David Hildenbrand (Arm) wrote:
> The final scan in shmem_undo_range() restarts after a successful split
> only if the original folio is no longer large. A nonuniform split can
> leave that folio large, so the scan skips the newly created folios.
> Hole punching then leaves pages within the hole allocated even though
> they could be discarded.
>
> For example, a fault below the hole can allocate a 2 MiB folio after
> boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
> folio successfully but leaves the original folio at order 4. The scan
> continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
> The hole reads as zero, but the pages and their block charges remain.
>


> Restart when the original folio is still in the mapping after partial
> truncation, identified by checking folio->mapping. If the helper
> removed the whole folio, no rescan is needed.

This paragraph is no longer needed after Zhang Yi's truncate fix, since
truncate_inode_partial_folio() returns true only if the folio is split.
The function returns false when the whole folio is truncated[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/mm/tru=
ncate.c?h=3Dmm-stable#n282

>
> Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operati=
on")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/shmem.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>

folio->mapping check is dropped and the comment is adjusted after the
patch is rebased on top of mm-stable because of the aforementioned
reason:


diff --git a/mm/shmem.c b/mm/shmem.c
index 7cf5a4d9d1ace..ddea31f44fb32 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1477,18 +1477,12 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, uoff_t lend,
 				} else if (truncate_inode_partial_folio(folio,
 						lstart, lend, NULL, NULL)) {
 					/*
-					 * If we split a page, reset the loop so
-					 * that we pick up the new sub pages.
-					 * Otherwise the THP was entirely
-					 * dropped or the target range was
-					 * zeroed, so just continue the loop as
-					 * is.
+					 * The folio was split. Retry the scan
+					 * to find the split folios.
 					 */
-					if (!folio_test_large(folio)) {
-						folio_unlock(folio);
-						index =3D start;
-						break;
-					}
+					folio_unlock(folio);
+					index =3D start;
+					break;
 				} else {
 					/*
 					 * Splitting failed, but the part in the

--=20
Best Regards,
Yan, Zi

