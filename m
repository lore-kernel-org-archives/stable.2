Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135189;
	b=s98/Yxb5Mrn57MugWh+bx8rLQUK4mV4JFiilr78YKwJydyThQSUjOA+dGCHky0h6IFtP
	 n7Rou9BrEGpAjHJvRmSEFusZAdlw2bmUfZpHHCjurIG3MD1RZED+jwVYGqh0Mm8CD7PbW
	 0+MFl9tplOyDJxJReVCw5InXHKnqPjFH2H3HMIW+7e9pQVsBnnoL+UN/n3bE6uzTX3hKl
	 /OL3I9m884G2oHEu9ape/m7lrg54MOLPIdzgghGjbmJzZ7s+rWqw9hLeNX1X08sAO7+3V
	 K7leAY/gzDFXzDYpv0ifCOUuLVZ41jUgQBm0GPh1AAm41uPSkQtdnlbxjNOAWN8zUFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135189;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=yBpPgmf/Z5kBVhNe9jsCWVrIZ8nsAMvxqoxsEY8ps8w=;
	b=3rAzQ/gI/a9P6M+BKy132bttBO9tywMfeUQizmHbTAISUASwjxG9LSGOVTxBVjDbuiBv
	 +TKqCysRe+Q3c/ULOMFJXP9na0zZQIkWnaxs3GWHZAIXTt7qWIiBAVpn/MoH/MOg2XPLb
	 S82UfV6DUPfwHrTej3jcmTe5Z5eww6M2tzZpafPa/F+Gg2+v3mGD51YvVkT0BzYCz8Zxz
	 G3H4rhlDrHGJ2gp1RBCum8Unbtv1x7JMaVG1F/vVrrddzgS+a8YsDOIQpajEP+RiJ+ibm
	 aYxQg6bTdsIIZ4kNrXyS3PPU3MXfr7eaNKbO8U+qW6n+rHu9K5OTcvMi/cUzXwP81PQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p+6r++xN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.40
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24154606A31E;
	Tue, 27 Oct 2026 21:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24154606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p+6r++xN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/SwW8mowA48Fhn0pYUdSRxIcvD6g+RwSBgkmK5Oo7hIJjY078r1GWgOmNpn6mcpSEpbhxySLYkTB0eiWeWcjXSEoBupj+anfQ2qgyTeIh1LyhLNtxCXo1BRb/e1zBUhtX2wvJ5RtBoDfByzOsKgzUt0n1dK/jGtb97xcKc5EyIRr1eInjHuGc44mAxwRcNH/j5828Z8HdeKDlMrqD3qt0oyjdsQJupj80gEwSowXg77l79H1jY8Ws0xXmQ5aASwmez6n3IKYjfEKLRHUPYIB495n9ANvO3Su0uq/3mnCZURpwAJKSC4VZm6keT6qsN6C2xovolGjJjmunmwHwwtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBpPgmf/Z5kBVhNe9jsCWVrIZ8nsAMvxqoxsEY8ps8w=;
 b=a2R6PEOPg4NHW2De4W/cwXSi7vreOp7+DJeQ5/lgqdmvG4XWAICy9ILnYU9I9YoVhZ908AYAApinMkYqAHZm2aIaHnq+m5N74S+Y71ulj+B72u3Pz6WVOfkW0tehnXjVQX7gxMHPy1U6ImEL+0KcaDShaIOyqPRCKBvCAKAoNXNY32JqhqW6D+BIj9CJArisQe8RxHpg4xU1MC1IdDSDvJKQkie8K3fMF3CZ9E4wxAGm74PoEKKubeaSXNft6rdjpNkqY9eUTQkueFz1piwbC1XnCR3tYK1mRMeSqc7JMBl0cyXL2MHr0YOzycxEZNNnau1sTrD064v04Yk+upy//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBpPgmf/Z5kBVhNe9jsCWVrIZ8nsAMvxqoxsEY8ps8w=;
 b=p+6r++xNP7QcH2s7EvxPL1CheNCa2pL2Vnq/NgqaEDdG8HGPM3ShueC2WuxTLKJjepwGDBgRYTjZUz3+Oo02sLcergGZYZjrh3E108HRvW3OFrfXIogilagLnZLtFvhRdrYDT79luAoY4Ls3lKxbejve8dz/6AYM47sL8TV8Ycyl1t0kbdl5lJgK62588/VIA6aB3vBjqkdWDPWRrz1XW9scOfLm7ymOjP1NNTAbic9gERgh4NlgRfQfr5USL+KAL8IRsd2MXONRHHme1tHS2gZT6gHMs7qgWYpsyxYOg/Efw5MGs09FZ2s9wlW//SJoBPdjtbG8Ih8cspbLfw4UQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA4PR12MB243497.namprd12.prod.outlook.com (2603:10b6:207:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:06:24 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:06:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 17:06:22 -0400
Message-Id: <DMFXDEKXDCTK.18NGYX7YY37ZA@nvidia.com>
Subject: Re: [PATCH v2 06/14] mm/shmem: stop retrying folios that cannot be
 split
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Chris Mason"
 <mason@kernel.org>, <stable@vger.kernel.org>
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
X-Mailer: aerc 0.22.0
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
 <20261027-fixes_shmem-v2-6-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-6-86a00952acb9@kernel.org>
X-ClientProxiedBy: YQZPR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::19) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA4PR12MB243497:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4918f7-2698-4bfd-9836-08df346e28a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|261026121527099003|4143699003|56012099006|11063799006|261009223027099003|261022105027099003|261021121427099003|18002099003|22082099003|6133799003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	vChHJU0InHoUvfwklS9tzaair91dZvxzp20UqhVVIirCTAZt/w5uL7hwzWt41FXr4D/wNWQRiKV+LbrsSg//okKs8YxCgJc9uClIpMyGTOXRvbdkfDM05e34h18e9VAMHQz2Au4nDpftU0bKL70+ZjwZxaiUMtBXB0XkqTdj6xbWAVFyI9nKOo0f6aNPvolISinogLy1FN2ygEvfG9MBG4iaU+iVc/vaF5JWhiUKW5lTPj9+fXnzZNU3jlz93vvb8EDWWpML74YI8L4u3BI2r2szdN1K7LgPDFNGkPhZ/OXUG9jHL6/7EkSBoGbhFRYaVL6rowGbdSDB5flYwYog/D6wvGnq2aS/OrV83Ge7KEaKy8drWSCteMu4/Xce6NtwQbfmUiyjk+uAQVdT9kA72YFxjVng6x5c+sfHYg7t44c3bgRiVX91Om8pabB2Iwaqsfe7WGdKyGP51RNK0Y1dQCK/RveLs4nRRftlr8vG83TB2x4dhdCfqASoqpB7d8KAjMnwZe70FNaSCvksnXt+SBDn8UkJ/OcX8jkjuXc7/9zxS4DZKfDyF65KlW7GouyQJ6QPR4jHqDvSn9xZLUKP9cQDzjMlfa/u2tDEf5TX4RKDcZVzfISE4MNCEmyp0gVbUbKhQANKYgRWnbr6jqMtW5i6M4vYbvKrCZKCSNONXPd/r0rpL+RLGpIF465x3qX3jWoH+XwncpG8k3ZUloPbFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(261026121527099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003)(6133799003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGUwSkNrTUFkTlQ2YzFMRVl3SWllSjNXZHdUYXJmclQ5OVlJZXVwb3VFUTZF?=
 =?utf-8?B?blIzR2dxWGxQcmNoWmYwNmoxMVdpL1l1UC8vbm10RVJrK21IcUdhVUNiOWhG?=
 =?utf-8?B?Rlo0R1RHOFVJRExsMWgxWkdpWDRRTG5qSVE1bytISmxKS2VvcTlScitYcVlm?=
 =?utf-8?B?RjduQzlZNkRqUmpaQVBMbi9kdUJTRmVaTkdIc1VYVWFhUlMrUXBHc05TS1B4?=
 =?utf-8?B?c3dSeWEwZmhFSVNIYjN4VS8vRUFES3NMZktEQStqWHJMN2orUWlDMzlQVEVi?=
 =?utf-8?B?b0g4NHNldXVZNXdabDR2MVJ6Q1lyNWV6K0hTYzhReHlTemJKOW5nSVY4ZTVX?=
 =?utf-8?B?UmxmUWsxRDdla0NHOEdiekVHVWZ5d3d6UnNOSTdsNFMzWXdRMHRDU1BzOW5p?=
 =?utf-8?B?QTlsWnkveTdCN2hqYWZPam9tKyt0V0IxQkZ6QnlIaXpsM3lIYlRQM3lXb0dT?=
 =?utf-8?B?RGt3bjJ4R2pLSHM4blhodnNXdXFHeS93UFczeWRNM21hTVNlZ0FhSmlmMnBJ?=
 =?utf-8?B?MEJVbENiSVpISEhoY0pQbVNsM3g3NzFsOVE1NnRxdVpFNXo4OXc4ZElSNENk?=
 =?utf-8?B?eFlsS0Y4dUdPOTJSbk1RUDZ3enk2Q0hZVzY2T3lRekt4ZTUyMlNaWmhudXN3?=
 =?utf-8?B?Vkdob0ViVE9ZWUdxWklXY2kvR2VaREFLa2ZFQ1lkUDRxUkZ0VFpGSkYwaUpw?=
 =?utf-8?B?VFJNQlE2L0d0eVBLNnVneWs4TVVWZlRld0ZPcHZBV1kweW1NK2tQVlFZNGpZ?=
 =?utf-8?B?NnVCaElBaG1PcWxWVDhqSzBRRXprSkpGWENZeGVidEh3M2VobDdJc1BqQlJK?=
 =?utf-8?B?S3NDRmd2Z2xQK0pvUWFPdE4yK0VVNkJRMGFFY2JnRWxHYldKbU5uY0c5dkF3?=
 =?utf-8?B?b1U0OHlPTGRNdkFHS1lwWlA0SE8wOTJreXpaQnBKUEUyWC9RWGlYYXhOc0Ix?=
 =?utf-8?B?ekdaVGtXY0NlcFBtandEa1ZlV1pSc1A5WStDRjZMdnZBTzFpUWVqblJPQXdT?=
 =?utf-8?B?UDBMcm5BRVhxYkkrQ0hOL1BPVTdnRkwzMGlYRjN2VDgwVkxvZzhBYXU2NFBM?=
 =?utf-8?B?YXJmamNSRm5CbEZjRGlpb2dqQVZIbW1nckVpcGxxdkZNTHVBYmJ0NmN3R0Fq?=
 =?utf-8?B?NVJvOWdqeWEwdkd0NkhUL0hLaHJiOEN5NG5GTVN2MGM5MFV4dUV4TWY3eTFa?=
 =?utf-8?B?VStjb2VuSWJCcHQ2Q0ZmSUgxTkg1NnpWMnFnK3hkYk1iRmgxSlU5TnptV0Uy?=
 =?utf-8?B?SHRRdkUzMTFXRWFkSDE2MkQrQ3Qyajl5RDViQTkzQkFTUy9saitVZ1EyeDRo?=
 =?utf-8?B?V0F5b0E4U1VwYTVTYWNrME5vOWRvVEhWVm4rLy9GODF6OVBIS0JNOHFOMHNK?=
 =?utf-8?B?VWRVOXIwdUwyNjhvTDdJNXZjdkVOdGlhY1hGNElVWXJ1eVl1cmJvN0d5b2dn?=
 =?utf-8?B?QnlUUExBUnc4OVdObjZuUTRXYmRGSlBwdVY3UXNLMGNwYUZ1MkUrWGZuMjZr?=
 =?utf-8?B?RDA1UlprTkNNdUJwSUQ4cUdnK1c3eElOdGxmenVmRTlSVXpHQit3SzNMaExu?=
 =?utf-8?B?SWNrL0RvR0dyUUFyQW16SGlYVUNaOWpua1FPeEZHSU52T1dkeCtFcmQyanI3?=
 =?utf-8?B?TzZpenJxNGlhVUYweXJSWGw4aC9QWEkwUzNuT3JGd0VKeW5zYVZsZVA5K0Rj?=
 =?utf-8?B?RWNzUE0zbDFxSzNieHo5eFRXQlVGL1BEbTRNbGJmRXhpcFZFYzJnR202WU91?=
 =?utf-8?B?eUg4MWlubmM1Vjg2eVYrMW9XUWNwMWlqaTVZNC82R2pqZVNMRFo2Smw3bk1k?=
 =?utf-8?B?VTlnOGFmRGNFY3lGNWFncUkxbHZ6cGVkNHZZeEk3QWlQU3R5em1kRlhNZitW?=
 =?utf-8?B?S1JTUUxxTU5UdUs3WUo4YkV1eGY1T3M0d2RwaXBtanFQc200U1g2YTE3b1d6?=
 =?utf-8?B?VzFyR3VYVm82UERpa09VTHNHQzRaQ1oyaU12QmpnVnBLc1ltU0ZQeXRsL3hu?=
 =?utf-8?B?ZFRmVmFiT1lBUUJEQ3N2dzVIejBnNGYzNWE2R0JDMHNQaDU2NUVFWklpRjdH?=
 =?utf-8?B?Ym5hV2JQTzBzVlg5STR3TUcxZ0FaVXhNSjNCWFpiL1lpMnRlYjVja05GMFIv?=
 =?utf-8?B?QTVZYnVvQW5hVWpGbThtdEhjaTF5eFN1ZzFkVGhla3NRdmo3Rk0wWmdxNUhL?=
 =?utf-8?B?c1E3bWZ6V3pSS0JOZlJ0aG9HZWtnUjQ0SEg0M1drRmhZR2JtSTdJeG5yRTJv?=
 =?utf-8?B?WjU3bkdocDhGdTduOUZ1eFpXSmdVelVWNlZoOUU4YUZiVStHYWdVdlVyRjJD?=
 =?utf-8?Q?7OOwQVQCjgqRlkpk/w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4918f7-2698-4bfd-9836-08df346e28a1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:06:24.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk7QUD1sckccvYit+Oumc6/BGuOuqfIUNm+diIMB3yi2HwLzTyRJgXSber4LMNwT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB243497

On Tue Oct 27, 2026 at 9:03 AM EDT, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> A fault or collapse can insert a large folio crossing EOF after
> shmem_undo_range() has handled the boundary folios. If splitting that
> folio fails, truncate_inode_partial_folio() retains it when it is dirty.
> The final scan then repeatedly finds it because it restarts from an
> unchanged start.
>
> Truncation keeps the inode lock and ignores fatal signals while looping.
> A concurrent unlink() can then block other directory operations while
> holding the directory lock and waiting for the file's lock.
>
> Advance start past the retained folio, whose truncated part has already
> been zeroed. Do not move start backwards if the failed split has shrunk
> the folio.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> [ david: split fixes, simplify descriptions, adjust comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/shmem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>



--=20
Best Regards,
Yan, Zi

