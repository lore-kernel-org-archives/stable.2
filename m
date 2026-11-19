Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795111983;
	b=DMuACA/k8CPt9SyY3eFHHDD8KNcxmhpMtONB/Z0nVDd2CONfdTu/+fxEMpVnc+aGve2s
	 Fe4B+Ikb2hejiF+i4b8xDpgDb+3SbVRRAA2ZHSSSIjNiU1dSOTs4wm/jigKAtDG2HXtdW
	 3PzboEnMhQP3oDHHWBwA1SqdCC5W0N4jnJYJ1/WO1haRhU/TZoA3Hok1Abe/LpNZ3dRlM
	 Gp1zTK0suNy4YqbvQhu4mhzedRH80502GnytoAo536QG/GbVhysnwOsnEg6fPIE56nndn
	 j/A3KRSbeMtaogUnyfum1Kdl49KCb43C3w8GD1dDTNHl0Oe5Ad3muw4eEgeevhoCltQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111983;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=CK/lAgtEDAfolHjEzg5gX3I6q6BgxFTqGnz+SeIL8qg=;
	b=2UIhZtktYNjzwmKr/9zyRZKVOxHgvhXNQzSLasJFuKqhnwM36mpvErqVyoUJyWnD1wlu
	 l8I4YcKkhwYlS/6cJ4kyyx6HUJIN3PCmQVZLFLKMeefXTrrTPTSlv7J+xtrqMUrnU7XYe
	 nmr/pTqfvl87+VVHz8geHumSBsiusjNQGnzyrkSD0o9LvUGZssnQ4d4sSm+P8SqeuF+K6
	 Qg3817s+CLszFv9Y4H9rwfU9urgtWE2iJgrlXzS95Jol6OgeVS9/xe+aepmktrkb63MfR
	 9l4nFk0t0wUj6ZkcQNhLJaHX7ztPjRH4ArahjJagwHaB873QQCCzfwOZ8iprauTzhnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m8q8ttN1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.21
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC453606A320;
	Thu, 19 Nov 2026 18:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC453606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m8q8ttN1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZurYAvOjjHSaTyAGTh0BmaFiOwzPz8ABsDUrqVwwwWxhaevZTPpsnuXzxZj7rNvdRd5tDZTRjIlMYhGqEvXsRpcn9W29Z8LzZn+KdtyRvB5rT7BEs0ct2lQWVKdH32w9F21XOOhqCnxxNBAiX3UE3nzdZJyu1ciI81M2TXdHdLCGbv2vSui2pnGZptijq3XpsxcebiL42BhVPLaXhLzgpvriHQPgXhbdn3bG3GWQSy4xB/wzPkmZyzd8XTBAqL/Ok1LGvo+eBl40xBlJ1J9/r/Qffupjn9JnckuRKQy55RKsHSL6nlUCtQWbOA7Qsb8VhVePzCC1TUw97L8AQLXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK/lAgtEDAfolHjEzg5gX3I6q6BgxFTqGnz+SeIL8qg=;
 b=EQ1o0Nfo4VKKpgfuWjxsq9mZ12W5pxPPJU9/568rb4X00+NROBuzOJv3cKD7h+dYWEAT05oOi6S7EAPUHelBPbpifDc5mGgFJwfo5nzPpjUhFbx4E94RdBniw+vMo60/MxPiC/4DK5/o2gUE3hPgp3bl9JRdUmNYGG1HGAC8khDk6a/2Ug6ly7NODHY3HE75fA6hkQWAa4osci4DJzBhGttk76wmi10EcluCKLWG2rUqvMnamsYwFzUcfRGc8aUvzGzQESq18/6JinOWdgquesu9aTDpTPN5RFtm6z7yk/hSa7fgGFnQAdBsDwZYVUK8nzlyVv6zdBNjjse1r+HgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK/lAgtEDAfolHjEzg5gX3I6q6BgxFTqGnz+SeIL8qg=;
 b=m8q8ttN1lkKwHCfUZ1sGAwB4FVDDYRjARy2msUX3WYS1IK8uaD6UGB/37l1HwkmJsyTkc1ArQl91mi7ByY0kFP1QO4ieEdv+Sut+u1l9N0NwrZGasVB+WoHPwdk+BAtedH0wP90voO26gxK8a6HN1R/02l+CSxfl9LZ0TTZCXJ2nJ8z3G7Ae17YbSYCP6ECKxtBAaWmxS7i3nT7dkiIAh02zUCbd+0l24iYGZllF1VOrbk2oCEJAmhSyEtT3LOo75/hwPCN1DwIZH5eDWpMVzThHi7lsuO8/Bdd9BcqLgidA+q2FFM82QkCDAxxMJcNLXpqm6CSyQjWKESmFb9t/CA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by DS7PR12MB5720.namprd12.prod.outlook.com
 (2603:10b6:8:73::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 18:12:57 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 18:12:57 +0000
Message-ID: <d4f67696-5095-4948-9029-f657058431b0@nvidia.com>
Date: Thu, 19 Nov 2026 19:12:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Bound the KLM count of the user MR
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Petrzhikovskii <vladimir@dfb.sh>
Cc: Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nikolai Kalinin <nikolai@kalinidze.me>
References: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh>
 <20261119101523-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261119101523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: efc1eabf-b031-4f6a-2594-08df4668bd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261026140227099003|261026121527099003|11063799006|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261022113327099003|56012099006|4143699003|10067099003|18002099003|22082099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CDtJd7MzVEwzhLo5YgqiWr3xYb3sw3ZLgANneOxGCjJRrMXJjojwgqj4GdreiZb/DbWxmcq/47slnxURb6H1FYjXBivlfahqpUAmW2sCiLnJpgEAiKkS9NLLRgFjrl8VTsb09vMztpXjEJrY06ftI/RT+/hWAuOIzR3uoQyF9rvEAYuFOpvcZFiMiuFz8HEv83V5CP6wY3wUbm11Ti8ihjKKP/g5LHGUNRNUEDChvBEcndl0GmnKmh4ldsIXvaktTiidxBW0k0Ywaj9AkVePwJNjdibkP1Z4s5vqc4VQaxC7FGF2o2avg+Ky1NQrwxeqN0Q/dbpmVMkPP8sTSPj18Z6Ax0Sfiftu6UROBCVY8f7ZsXefDIhD4RslsWJ2Rm/nmggMnEUDTNmGRgmbANbf+KaaL1koCdenw5TH14mU2tyxdnhmJad3JP768HOkNpvpXAnFfdtiiz3EvmwIsXTwwXIZrT3w4cmsDXB+R45hKb54ge3iL36yr1HpRzlmhlKLkyF+9Q3AjjSeJOUMAYGG8jtQPlDo5K9766a3YOWk3fgIFzfxZuuEppJyxwc1TfCzI7kkRMi5V+lLebtWSxHrXFYTSTb7JtYHDNaP4eOTHM88RGOXESNl6R6kJL1xXzjSxExwfTiACHU5Qov88lFLBX4UCqJlNhVGjgZjzThKPFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(11063799006)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261022113327099003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ZuZGNGODJoa1oyU3kyNXkvb0NOSUhsSVltSWJIV3hCRmk4MU1lOGErWW1Y?=
 =?utf-8?B?WURsTHJJdGdnR0NvLy9jdS9EZ09oTHdBblF5QW83VERabStPS0JVSEFKTUJw?=
 =?utf-8?B?NlIxc0d1dHlDNi9JZTdWWW9Bc01iTk5CdjdIMnIzdnBpU0U0YVBqeGFzLzlo?=
 =?utf-8?B?ZDd5Q3BUQ3FqSVo2TXkrdk4xYm5RakJkUGdqY0dOV2ZGZ1JzWHdYS3VtSjRP?=
 =?utf-8?B?THMwRHlWdUFzSHE4UUcreTA1YTNYWFUvQmxHaGhhN1g5ME9FOHBtdEloQStO?=
 =?utf-8?B?ZzFwb0xRK01ma1k5VXl5VEU0SnBBdFh5WUpaREd3UVZTSWV6UkRUMlN1b3dE?=
 =?utf-8?B?K0llMk90eHRxM203SklSK3ZqRTQrMUlqcVNpd1dLWlMrUlI1OGpmVVRGMHNS?=
 =?utf-8?B?SUkyYlVMY2NRQkN4TmtOTENkWEp4aTRPWXVjdVBJdXRCK0pkNEt3OUpqKy9T?=
 =?utf-8?B?N1p5MDhiblhSZWIvc2YrMUUzaDdkcy8xZVlheFNNQlRqeFoyV3Y3L3E3UEQ2?=
 =?utf-8?B?WEhCeHRpdlA1MXdpRDdiT1BBdHdGUExNOHExMXYxUjcxc3ZQZTlqTWJ4KytC?=
 =?utf-8?B?ZkkrN0xwZmxzVzJUalVOVmZKRk5xVTZQUXhaUmVNV2U4emc2U1lyN01VcHNS?=
 =?utf-8?B?UkkxUHBUSWpqMk15OUNGZ3RCRjNhT1FLMzRWMjlmemp3THVRK3poM0ZqdkRO?=
 =?utf-8?B?QUpZQ25IYVA2S3NlVytvVjdUenFYYW5iUW5hbDJ1Ny8rdi9Wd2h1V2UrbndX?=
 =?utf-8?B?ZDFsYlhpYjFQUEowYzdka2EvYkhsd1pRSnNHNWZsZXhYMUg5dTNCaVk1dHJn?=
 =?utf-8?B?VVIvUFA5OWM3MDNsQkovRHlhd1lUVmh4Um14Yy9XZkxKc1BsWFBiWkgrL0pP?=
 =?utf-8?B?THYvbjd1ZEx0d1hNVERMamtNN3hDVnBQSnZuTTZvY0t3OWVhazdDZTNJb1lO?=
 =?utf-8?B?RkF6OFlBWWhmZDY5UkRFUUc3cVczQ1czUVhnOUY4eFE5c0Fub1VkbGp4eURx?=
 =?utf-8?B?NWxiajljei9lSkdlQSsydkx2eWkyNmZ2ZVQva2dkSjZQKzJuOFFWR0s4RlZW?=
 =?utf-8?B?UVhuZVBaSVZzbHRaR0J3aVM2SlJ1NlNnQWdMcWN4S2t5Q2lQT3NlUVc3Smlx?=
 =?utf-8?B?YTl6c3JIV2gvMWhhdEZIeFFFMTVxV1A0eVNhM25Va0phZHNONWpWSlVZTDhi?=
 =?utf-8?B?UmFvemU4VWZYdTZVUjRLaytpbUd1N3RoRUkyRHIzaDJFcXc1cEJ5SkEwSTkv?=
 =?utf-8?B?Z0IzQUUxeFp4aWFWWlM4VnZ5VndMQ3pGMXkxNFcwOGpyQ3FoT3RZTWo4cDl1?=
 =?utf-8?B?YkI5dVNsaS9rMm9TWXA0WEZhbngrOGoydVFoUUVUd2V3cm5hdEU1QkJaMDZm?=
 =?utf-8?B?WlBZQmg2akRMMjdlRHBMY1lXaE1UWFR3RDdia1RzTzJUVWpZd0VPTTNjaHk2?=
 =?utf-8?B?eXhib1gxU2hiM29ZV29tTG1ZQU9kRDhGMkN4a2lnTno3N1lsUU9DSml5TmI1?=
 =?utf-8?B?STQxMlRDMHdUa0xvb2lrYjBBSTc0aFpoWHoxUlJIWnRKNWxSTDNtVkk5cE1a?=
 =?utf-8?B?b1pLL2tNc0hXa1V4aFJZSmo4T1dTdWFsdHkvTkJQaTVFa0RNaFJ3OVhLQ1FB?=
 =?utf-8?B?OWdZT0NBNXovZ3h1VFhUZ0VqV3BDeGpqZFhxenU2TEh5ZXJpMkxZd2tiQjB4?=
 =?utf-8?B?TCtjRmZFb1RxZkV0S3VWeDZyZ3MzTitJTlJqSk1LenRuWTFvV0VlL0ZleGlo?=
 =?utf-8?B?Z3Nqd25UQUxzMitBWngrVEorTzEyTk1vZUdXUVlGSVBqdWtrUTNOc0t1V0k4?=
 =?utf-8?B?cGFPaDBKN2VXRnhIMjQ2QmY4eG43Qzd6ckNJWC9GUTBYU3M4S1pjZGZSNXA1?=
 =?utf-8?B?bDdoSFhOZWpMa3hML0FIeXBaM1UxZ0lnVzRMSFk4YmlDQWJlODR0azhzdXAz?=
 =?utf-8?B?ZzIzTFZaS0oySzAwN3gxMUF0T1NPZGgvZit3SUVNVSswRDVkdTdMK0k2ZWdT?=
 =?utf-8?B?Sm52ZFdxSVgvMHl6MU1aaHlKdkt0Nm1sWFpQVVJSUTdtWS9neHdMOHdBaHJL?=
 =?utf-8?B?Rlp6L0ZLL05DWWZobGlaOHZRNmVmcHN2eDFHeCtpKy9hS1ljY2dDV3d6UC9n?=
 =?utf-8?B?MHRyTjF2RnZJMDRBZG54ZXhUNU9DZ2t4RDdVWlMvRzlpbUZpWjN4cFEvSWNa?=
 =?utf-8?B?MmcyV0Y2VU56UXhoMGQxUnF6NTdCdFdMOWlJVjJSZXRBeDJZa2d0alZveURv?=
 =?utf-8?B?RnBzSTJZKzdHUlpDNHpGUTA2Ymh4elF3NWNTeDRVSlc2UEpNYlpSRE1iZVlS?=
 =?utf-8?B?cWNLbDM4VHQxVmRtbnVxNWo3NmxqNlY4WDI5VGZiQXJzaExjZ29XUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc1eabf-b031-4f6a-2594-08df4668bd16
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:12:57.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bSKrsvi7h8/of39f3/ae8skm91SjuCnqOyPDa4GCuwV8XJAeTuR8a9+iA29tLiywp1DMCaLEt8el/PIWzT5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720

On 19.11.26 16:15, Michael S. Tsirkin wrote:
> On Mon, Nov 09, 2026 at 08:21:28PM +0100, Vladimir Petrzhikovskii wrote:
>> create_user_mr() builds one indirect MKey that covers the whole vhost
>> IOTLB. It fills each gap between two mappings with null KLMs, one per
>> GiB, and never checks the total number of KLMs against the device
>> limit, MLX5_CAP_GEN(log_max_klm_list_size).
>>
>> With a virtio-IOMMU the guest chooses the IOVAs: the VMM (QEMU)
>> forwards each map the guest makes to the vhost-vDPA device. If the
>> guest maps one page at IOVA 0 and one at IOVA 2^58, the driver needs
>> more than 2^28 KLMs. create_indirect_key() computes the buffer size in
>> an int, which overflows: the driver allocates 336 bytes, and
>> fill_indir() then writes 16 bytes per KLM, 4 GiB in total, far past
>> the end of the buffer.
>>
>> nnuls is an int, so a gap of 2^61 bytes or more is miscounted on every
>> architecture, and on 32-bit the unsigned long num_klms wraps. The gap
>> is rounded up to whole GiB as (size + 2^30 - 1) >> 30. For a gap
>> larger than 2^64 - 2^30, for example below a page mapped in the top
>> GiB, that addition wraps and the driver counts no null KLMs for the
>> gap, while fill_indir() still writes one for every GiB of it.
>>
Please make this paragraph more human friendly. Enough to say that
the type doesn't fit the value or something like that.

>> Count KLMs in u64 and round the gap up without the overflowing
>> addition. Before creating any direct key, return -E2BIG with a
>> rate-limited warning if the MR needs more KLMs than the device limit,
>> or more than fit in a CREATE_MKEY command whose length is an int.
>> Allocate the command with kvzalloc(), because a list within the device
>> limit can be too large for kzalloc(). A normal guest is unaffected:
>> memory at 0-3 GiB and 4-68 GiB needs 68 KLMs.
>>
No need to say what the code does. Focus on the why.

>> Found by an LLM code review agent auditing vhost-vDPA backends. We have
>> no mlx5 hardware, so the fix is untested on it; it builds with W=1 on
>> x86_64 and i386.
>>
>> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
>> Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
>> Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
>> ---
>> Dragos, one question on the limit: the patch takes
>> MLX5_CAP_GEN(log_max_klm_list_size) as the largest KLM list an indirect
>> CREATE_MKEY accepts, as mlx5_ib does for fast-reg lists. If firmware
>> applies a different limit to CREATE_MKEY, please say so and I will
>> change the bound.
>>
>> The guest kernel change used for the reachability check is available
>> on request.
> 
Yes The limit is right.

> 
> Dragos, care to answer?
> 
Yes. Done.

>> ---
>>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
>>  drivers/vdpa/mlx5/core/mr.c        | 30 +++++++++++++++++++++++++-----
>>  2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> index 42f2f44b383c..1d84824ca429 100644
>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> @@ -32,7 +32,7 @@ struct mlx5_vdpa_mr {
>>  	/* list of direct MRs descendants of this indirect mr */
>>  	struct list_head head;
>>  	unsigned long num_directs;
>> -	unsigned long num_klms;
>> +	u64 num_klms;
>>  
>>  	struct vhost_iotlb *iotlb;
>>  
>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>> index b0c5ff23d022..03db8345c1bb 100644
>> --- a/drivers/vdpa/mlx5/core/mr.c
>> +++ b/drivers/vdpa/mlx5/core/mr.c
>> @@ -206,6 +206,16 @@ static int klm_byte_size(int nklms)
>>  	return 16 * ALIGN(nklms, 4);
>>  }
>>  
>> +/* Largest KLM count whose CREATE_MKEY input length still fits in an int. */
Comment not needed.

>> +#define MLX5_VDPA_MAX_KLMS_INLEN \
>> +	ALIGN_DOWN((INT_MAX - MLX5_ST_SZ_BYTES(create_mkey_in)) / 16, 4)
>> +
>> +static u64 max_klms(struct mlx5_vdpa_dev *mvdev)
>> +{
>> +	return min_t(u64, BIT_ULL(MLX5_CAP_GEN(mvdev->mdev, log_max_klm_list_size)),
>> +		     MLX5_VDPA_MAX_KLMS_INLEN);
>> +}
>> +
>>  #define MLX5_VDPA_MTT_ALIGN 16
>>  
>>  static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
>> @@ -338,7 +348,7 @@ static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr
>>  		return -EINVAL;
>>  
>>  	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) + klm_byte_size(mr->num_klms);
>> -	in = kzalloc(inlen, GFP_KERNEL);
>> +	in = kvzalloc(inlen, GFP_KERNEL);
Unrelated change for fix. Drop please.

>>  	if (!in)
>>  		return -ENOMEM;
>>  
>> @@ -355,7 +365,7 @@ static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr
>>  	MLX5_SET(create_mkey_in, in, translations_octword_actual_size, mr->num_klms);
>>  	fill_indir(mvdev, mr, in);
>>  	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
>> -	kfree(in);
>> +	kvfree(in);
>>  	return err;
>>  }
>>  
>> @@ -501,6 +511,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>>  {
>>  	struct mlx5_vdpa_direct_mr *dmr;
>>  	struct mlx5_vdpa_direct_mr *n;
>> +	u64 klm_limit = max_klms(mvdev);
>>  	struct vhost_iotlb_map *map;
>>  	u32 pperm = U16_MAX;
>>  	u64 last = U64_MAX;
>> @@ -508,7 +519,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>>  	u64 pe = U64_MAX;
>>  	u64 start = 0;
>>  	int err = 0;
>> -	int nnuls;
>> +	u64 nnuls;
>>  
>>  	INIT_LIST_HEAD(&mr->head);
>>  	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
>> @@ -521,9 +532,10 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>>  				if (pe < map->start) {
>>  					/* We have a hole in the map. Check how
>>  					 * many null keys are required to fill it.
>> +					 * The hole can be nearly 2^64 bytes, so
>> +					 * round up without adding to its size.
>>  					 */
>> -					nnuls = MLX5_DIV_ROUND_UP_POW2(map->start - pe,
>> -								       LOG_MAX_KLM_SIZE);
>> +					nnuls = ((map->start - pe - 1) >> LOG_MAX_KLM_SIZE) + 1;
Why not DIV_ROUND_UP_POW2(map->start - pe, MAX_KLM_SIZE)?

>>  					mr->num_klms += nnuls;
>>  				}
>>  				err = add_direct_chain(mvdev, mr, ps, pe - ps, pperm, iotlb);
>> @@ -539,6 +551,14 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>>  	if (err)
>>  		goto err_chain;
>>  
>> +	if (mr->num_klms > klm_limit) {
>> +		dev_warn_ratelimited(mvdev->mdev->device,
>> +				     "map needs %llu KLMs, limit is %llu\n",
>> +				     mr->num_klms, klm_limit);
Use mlx5_vdpa_warn(). Rate limiting here won't help: the other prints
will trigger.

Thanks,
Dragos
