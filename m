Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795547838;
	b=yP6+E75XVL45mX0mxW2boY+x/8JWCZbsvIUvN5o+qPCCU4zt0UU3nFPk7tYcLzddEYOo
	 wsYufBVjZaDUJddC3tq2O+ndL7o2+76ViEuadgri5Kljvb1H9d1gub0LaogpSyGPBelV0
	 BzKdeKv1ogZKCxBWYa8m/0A9k0cjB1Kf+cGmwhDT30j/fAOHyxqFgwqNG5xR+5FCzJl6g
	 Ht91fD+FLVYePRAi1QObFy21FN26v7bV/iwqdcwQQC2WIuJ3XmqpxmO5KOQcpYV15vmWA
	 6Xb/eJ4ekz90fUs4DC4neigORPiQwWp+2bfZe76HnPebH4iPQBeZsjaDnSKDp6ntEWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547838;
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
	bh=uM//dOam8DkJvuuXWFByFXD5vsyC5IJq/TeXum8HMPM=;
	b=U9eyfYrVyV+KVL4vjT7Me83ORB/QscYvIDZPN7uizUFvJYiKHU4rDwNumFU4TxLEwORH
	 C0oDZDeml8jFYSeXZNSh7/14fKsmmvu85FBikq8NvKdXOmrbCMbgYKV1izLfhfchPo3ZG
	 W8oroLpNOBuOX5FZM/gzLDuCe0Q8G53+ZFaWSH2ATOHm1ROt7YUFwjt5UIRk7AUsOBcqQ
	 HBeDPUoB1HeBXdzxv2HRRsXITYfZxOOboJ7m9bdlQlmHIdzaOPc0HGeN3iJ/zM2Dwt7Dj
	 yoLdBXvHdnuzsXKfWD6OsOmD+o/FYSKiA9XNsjXQ/n+L5FmlWzpm/QyPTO1l3GDzKkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lqrju3rg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.52
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1E606A321;
	Tue, 24 Nov 2026 19:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA1E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lqrju3rg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBIuC1GUcVTU1qa65JJFmOB0xjoLycPMa8gc/cSLwY+bG3JKGaVHDHCO6Mf0mO3rWOhDEbA7vfgOawVqAiMA/tBRqUFFdruWlQ7uMc489SL5fN7eIhEtvAGB/Io48gyCepE7dEUVqxrPmTuIF3AbgAz7wckb5hNjGUS4otpKSE95GHgslYLiX1Td6V9i+9CfpcyqkOOstvPx1cg88rwYfEXHU0+cx0IMCdt0Qa1LJj1uqyJos8ccugOb6pXtQALjGJkT2s5Qt0UQ3vrt1mEXjdNQjJlwnhshfOb7NpEZ0XjjnSBazKo7iW8DhDFJxBFUrqOeFuYhs8ME9xLR8//Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uM//dOam8DkJvuuXWFByFXD5vsyC5IJq/TeXum8HMPM=;
 b=XkHB8rQwIKcJv6nOZz5x2ZxPgu2HSeg/dKOLenoyVtk7MRoPasCGamnjIfJCGC3WgqA+dwW8SCd+D5tFXjuRmcREoXXK4ZF7l+9qLBeliBdCB1TYbP848nurhRH99rOqH9FzfIVpVQ4DR0B/O2R5J+36JhDAqwDI58EwQrjm87oHo0Muq43KKXGbNutjJySWS1rKUOpNz8d/5h6yrF9C+iS1qciOGln8PWCrHWmhn3KFTXq/U5KlCUwn/FuYjkVbaxmglNLbOD+tQ08gLA7MweQtNFBqBlNCPcIIkiNnJLBKPvwY2TVJOlCczQwT3YzgvZZuDG4fJ8SDzTnkqdQhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uM//dOam8DkJvuuXWFByFXD5vsyC5IJq/TeXum8HMPM=;
 b=Lqrju3rgR1fQXzuuYBcmDb+7DcixfpmY0E2uib4QzQAUPo/4DToGS2Ej/ekD+fpIP/XnHc53FH2/eOG4RNBgm/FzwiEjLO1q/SsNfL5BCdp9gPhje07tiXz3vtfdIaBtLyRjiISkdfR5+mbF+r3rv53tnYAac0P2Y3aRLaSznXwU0sQgxxTfL+5Z+XxOWdrXN0itdQ7iuTivzJE10J9k97/h0xa0VHV0Ho251VrRc2x9DgXdKXpX31ZJRmbjnq7LLVET2mLDGXuj0CPBylGknzCWpbjMbFtSQ9WZkrNCmpFjxXykXsbq8Jm4BEzwEgAXfTIZK2d2t+xNT52Nntio0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by DS7PR12MB6357.namprd12.prod.outlook.com
 (2603:10b6:8:96::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 19:16:00 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 19:16:00 +0000
Message-ID: <abc046dd-b8d4-4620-bc5a-08f12b7efcb6@nvidia.com>
Date: Tue, 24 Nov 2026 20:15:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vdpa/mlx5: Fix error cleanup when VQ setup fails in
 .dev_add
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
References: <20261123135646.3962652-2-dtatulea@nvidia.com>
 <20261123135646.3962652-3-dtatulea@nvidia.com>
 <CAJaqyWedvj6htnM4rJyrbynW3u1k=6uLHrfuK05YvM5z8v1Hjg@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAJaqyWedvj6htnM4rJyrbynW3u1k=6uLHrfuK05YvM5z8v1Hjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To CHAPR12MB999248.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c32b03-0881-443b-439b-08df4a5f5fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|261026140227099003|11063799006|10067099003|261028144727099003|261102123227099003|261026121527099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	eYmVV8MAadIOPhtURzJm9M174YB8Pl694hsHBQLU1z5wpsa6NTvRD/12OpEAzovqKRuXNeklM6mOkrsr3vcuGNyYkWr6sRGM2GE2sqK7YqAfXjkxgHdejJbS9s93ap9O7ASq8ZXfLXDtmydVGckt8FPRUgll0fjSsj2H5C84kQFKHJ7m5D42vxM2ZAOw9gCvZ0kLJ44F82p450iejSIkHHZW3uv1gOxpEpTPoySy+AH/h6wAK/4swHmARlsapY7f5S+TodJDSR5davS6moTZv3lGWtWWACQWODzeG6trdPH9P9QF7p6GiOo2sY9jD0BtD9OFGPeIzH8GyESEDA9PoMNkzKGGlUtdTDhuu/BaCBrk4MgFz98qFZLfki7Y+2/BXdGTLq0Hjpvqymw8nn/O4AXFUcoi0gzv1SNw7EOvzm1uRGl5truuDUaWOnEvyAbDCujlet84eRD+eZCAbcaaHaKvhLrceKjmADqN9z6Z21WEr1vdKUwSj3xLVS0vzK5Vxg/2pClN56NWzl4r9Rpb1Kge4QGrVy+gGH+GwR1D/U31hmbsfbua4NG+wj6ffcFQpTR1eVS7jW90CoQsTV6CrF/SfY4AhCTkqPoFjpV7l67xKKYAiQ/pdkHbccu3rCu2kn/CJ7cv37dSF2fT+CdPW8q1TL4ErGhg0laE+0RADCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(261026140227099003)(11063799006)(10067099003)(261028144727099003)(261102123227099003)(261026121527099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkR4ZU4rR09QUzI5aGo1ZzRGeVk5Ynh1L2FlZXFjRWtEZDF2Q2xMMXVmdit2?=
 =?utf-8?B?R25lb2FBSjVSZHE4anZQNWZaUTlrTnRNTmxOYVBocmNwdVpvMEE2UkxQZ2t5?=
 =?utf-8?B?VyttVGtUR3JLY21oTFcxQk1UeitZS1I5UHFoalhBa1lWV1c0Vm1tQ09lWi9m?=
 =?utf-8?B?cm5WdVlnRUl2aWxGei9xN0kxT0V3RDZxdWU4M3NuQ3VTU2hTV1N4cGtnb0FD?=
 =?utf-8?B?RUxjUWxnL2NjRFRiRDJ6VjVWcS9pUWRNVjFzNXdOclc0VTE5Y3JWTFp5VjE0?=
 =?utf-8?B?TTV1Q3ZHeTRwVDhBTmh5cnhiTFpraGQ0MHNadFBvdUw0OWlpTmJUKytmVUJk?=
 =?utf-8?B?VVB4VzlUbUUrNkYwcXhkTVA2S1RwK0Y4emJLMVhPUU15Y1BESzBrMWk5Sk0x?=
 =?utf-8?B?YVFYVWJVQ2lTTWhBb0Fkak50TEpBWUJCWHdBTlZMc0NRRE0xMFc1SmJHbnMx?=
 =?utf-8?B?NDgrMk55QzBGaHhyNUFRVThGbTZ6R2l3RENMQm1BMHB3c0JSTkRmdE92aG9K?=
 =?utf-8?B?QnFUUDliSFVUTlBQYWFTS1JiZWJvSTNUUkFKamowT2VHRi9HWll0VWxPZlAr?=
 =?utf-8?B?ZXA5SW8wMzVCY0RKT01UMnBxbGZoTXNuWU1QNWloUDF1SVdhS2lPK3RHeWg0?=
 =?utf-8?B?NmR5Wjd0UlRBemt5TEJyNFo2aFpVTWxDdkdQS21teCtoWExkYkhaRHdZM0Vp?=
 =?utf-8?B?NmRBNC9OcktqMXdaU3VTYWMyLzZKaXZJb3RWSzFhd3BiYVNQallzRlk0eU9D?=
 =?utf-8?B?a29vYkIzREp0UE4yTnpEeEV3cXJnQkdqMFUzMkpEdXd2a3RYWDVvU3lDbEE3?=
 =?utf-8?B?N2tXOW5mM3orTHZXRTFYM2EwcmZEcW5IQk5NM2lUVTAzSzl2T0wydGRGZTJt?=
 =?utf-8?B?d2VodWJUOHVIMjMvM3lXaFh5V1B6cEg2eVVHS1NTVXFqRXZkTGhPUjMwU1dq?=
 =?utf-8?B?TmgxRXZ6Rno5RkxqTzh2OUlJUVJVcWpQMTBqUkNNWTJpTzNhTG41MThOQ3Fy?=
 =?utf-8?B?K1lTS0ZlYmhGUHQ1dDMrcmhRU2UzSnd1aEt6eStzanhvc1JjT0ZyUmJ2SHJK?=
 =?utf-8?B?VUF5cUJSOG1WUEpVV1JFd2FuRW5Na3Q2RUttU1lZejNXNC8wbjljd1hxR2wv?=
 =?utf-8?B?bUIvS0lpdGI2TEIrMGNzT3VzT05PdmNMUmV5Mm42SXA1S054T1o4eUUwQkNi?=
 =?utf-8?B?eWRudGFRMGhURXhnRWRZdTkrK2o4M2dXbGl6ZG5qbnFxRUFTYzZvUmtlbzVR?=
 =?utf-8?B?Y2lwbmFycGNFMm54VG1sZUtBOGNiUEoxUWYvaWNWQW1FWGdVY1NqbXlHNDRn?=
 =?utf-8?B?aHZRK2F5RnRJenlIeXh3WFNBekcvNGZCTUpzQlUvU05zVEJKREM3K3IwZlhV?=
 =?utf-8?B?WE1HRVc4dDMrT3RISXZkSkVraHRNNFBsalJ0MWtJV2pScWsyaWpXNWIwWEUv?=
 =?utf-8?B?NC85SUQvUlh2d0ZtYVFjdHVIYTlyK0lrV2N2RlpPTUJFQjRZaVR4bXlkSm1R?=
 =?utf-8?B?cy9FM2o5Z1IzZVN2V09wMmxVS0FyNHdRVDV4L0NMSVNhNUFXeWhvSXlMOVJJ?=
 =?utf-8?B?Lzh0OXVOU0hZbXIweEpTYlJkNDhKMjhzUTE1QnlkSTV5eG12MkVvbHp0RjRx?=
 =?utf-8?B?Tld4YnhoMG1XTGIxMWxTWXljbXNwZEtiY0czRlR1TXE0dVhxRGtpTlFVNk9T?=
 =?utf-8?B?L3kyL0lFOGd4MnlrWHJSekpMcDAxY090Tmthanp3M0JMWHNvbW92LzdwUjZx?=
 =?utf-8?B?NmNzZlBwTVJRNUR4TllpY3hRR3NpbTV1b2xybTZ5Qi9YdXlzb1ZpMVIrWXBp?=
 =?utf-8?B?UFI0MkUycndQMnc5QjZQbUpmcGQ1djhMSlJheEY1N0Q5QmhjUVc1cVVWVGt0?=
 =?utf-8?B?bXk5QjRFSjA3cDdpczVISXhyUjAyU1RqdzIyb3k0UWRELzRITGtnZ0xWS0kz?=
 =?utf-8?B?VVlsK0VZdWQvUGFBeE02cjlUT3hrMHNNVXJIK1k2U0VMRVd0cEY4cEdiTWpO?=
 =?utf-8?B?SStkdVBwVk4rbXJXY1BLTXJRekVNMS9LaWg2bGR0NmRzem9tcDNZL2g2eTBD?=
 =?utf-8?B?NXJkeklUby9IZmhzd3RSWGNBY0o4V29XZUJsRzZ3cklLcmxzQVZpK3M3SkJ5?=
 =?utf-8?B?c2Vub0ZyWFRUSTZRY3lPSGg0MysyV0JlcnRVYTRudXJja1QzUlNhOTQ0cGNz?=
 =?utf-8?B?MDUrRTJvVDB1VTVDYVJZMXFidWMwMDJtazlnaitKQmRJeXp2RWVDVlZqUVAy?=
 =?utf-8?B?VXE2bXpMODNMcTEza29Xd2JsaUJjWVRtUHN1ODRreC9MYmM2NHRSYzU1cSta?=
 =?utf-8?B?VmNYblF2ZHRqdVZZZ0lPbm1pNlJpQzVNdjJETi9mM2RSTmZwOGJXQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c32b03-0881-443b-439b-08df4a5f5fbb
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:16:00.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVdxslBPZr9X3ZLtiPB1yQJKFeAGfHwB5AswW/8H3HpTR0fBu3+Y+tkcdKJ7DKcagd5TIrQQtChFRIuDFopuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

On 23.11.26 17:08, Eugenio Perez Martin wrote:
> On Mon, Nov 23, 2026 at 2:59 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>> When setup_vq_resources() fails in mlx5_vdpa_dev_add(), e.g. because the
>> firmware rejects the provisioned features (HOST_TSO4/6 without CSUM),
>> the error path unregisters the vdpa device first and then keeps using
>> it:
>>
>> - _vdpa_unregister_device() drops the last reference to the device, so
>>   mlx5_vdpa_free() runs and ndev is freed.
>> - destroy_workqueue(mvdev->wq) then reads the freed ndev.
>> - put_device() on the freed device underflows the refcount:
>>
>>   refcount_t: underflow; use-after-free.
>>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>>   Call Trace:
>>    mlx5_vdpa_dev_add+0x3e0/0x760 [mlx5_vdpa]
>>    vdpa_nl_cmd_dev_add_set_doit+0x362/0x440 [vdpa]
>>    ...
>>
>> - mgtdev->ndev is left pointing to the freed ndev, so every following
>>   "vdpa dev add" on this management device fails with -ENOSPC.
>>
>> mlx5_vdpa_dev_del() already does the cleanup properly so use that. Just
>> make sure that an extra reference is taken during the call to avoid
>> _vdpa_unregister_device() from freeing the device under us.
>>
>> Fixes: ffb1aae43ed5 ("vdpa/mlx5: Pre-create hardware VQs at vdpa .dev_add time")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 6830a80e8543..7a39b0bbbee3 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -161,6 +161,8 @@ static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
>>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>>  static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq);
>> +static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
>> +                             struct vdpa_device *dev);
>>
>>  static bool mlx5_vdpa_debug;
>>
>> @@ -4043,7 +4045,10 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>         return 0;
>>
>>  err_setup_vq_res:
>> -       _vdpa_unregister_device(&mvdev->vdev);
>> +       get_device(&mvdev->vdev.dev);
>> +       mlx5_vdpa_dev_del(&mgtdev->mgtdev, &mvdev->vdev);
>> +       put_device(&mvdev->vdev.dev);
>> +       return err;
> 
> As a suggestion, the cleanup could be more symmetric if
> mlx5_vdpa_dev_del checks for NULLs.
> 
It does, that's why we can call it:
- teardown_vq_resources() checks ndev->setup.
- mdev->wq is already initialized, so no need to check

My initial version was checking for NULLs and getting references in
mlx5_vdpa_dev_del() but then I realized that it is not needed and
it made the code more ugly.

> But I'm ok if you prefer this way,
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 
Thanks for the Ack.

Thanks,
Dragos
