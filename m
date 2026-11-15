Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794700809;
	b=Fg/Eav+SNFclf0inEwVABqpjRG8gyrNIAzTOAmAqtrlh5/8ZKa5tKip/ycZiDxGmNAJm
	 3+aTt6NCgvexv+TzPzFX9nkIyAjEi7qOwUqy6ocdTBECG3L3sFGuwQxD3T/XnHNslrMgz
	 kYEMWLy0DqNZfNUNc25VJhjdU6O7YaZ6dhI8ZTkT4fkkAq/4Rcj0CvmS1USmuyznbgDNk
	 khaccFjjmhMMgGu6mox2p2RKgCkmtZIis3zdv9dGFgkiJwewNEW/TfEwroLf/ZrjmGQBa
	 orRBxJ1wtsIG8Fog+43eh3fipjzj6H32MGd0QQU1Dz2xhrx9RtVC7JgKtPq0wZQJfqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700809;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=A4p/ZrzWv+7I/PwL/AzZiq9a/zXoUz1s7R6mVyTlBt4=;
	b=tu5dwIMTI83dvb1lAfPqXEtL31ucUOGl334OpyoSeJjTMaD0ALb34qoGoV2BTue6Ud3o
	 qyl8HNi7X2qSRHw8vIzqW+J7UBrGqULvx4PYMj/fx3Oh70Y273WraJe9WGtqEwGFPHQJx
	 jzlgdNMuvvQtsot1BL1Ll6hj6EFYDnbpDAc5156Pq0DhTL9ee6jjTkcmljfiDA+7TpHRm
	 DxhJDHi4Uv9XXT0t+6K75AH6DB/ht156gclT93z4qbBs4KP7mgbp66f11qPpasG7ix62W
	 lnPDALBx/OUoC2rCJR/DvRlcJMbKmzHjIhuwmKITw++VI22NUAFqwdU0KHV0expeaMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LCAIASZQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.5
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AB606A323;
	Sun, 15 Nov 2026 00:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0AB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LCAIASZQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Av8KJUKCtHc+zGzV0/6gyeXqm5JvGt5sOfPV47WecDB9A5EW73VzxJ1c8ZUGQSVUXKjaELRHEpnRj3HvqGzMwUjivjkyKXD5OhqjfY8zUxmUQKgaDWFQjbPIipq/qn+m14N4j8ASNRiThZ78wGHbMG/ELHapShq4nhaALDubx0qKqcyuRuRn+WCWXvqKZJFIsd6TAczQDvp9IBfaTANegJ47md1BG/z/nUw3RoFzSey242VExk5afW44uQowVrO34U9+Fgbrorp579Ya/GoLYhyFOhmSBduDePwtf/dUM3i5yXw71VrINkK3WXnLThr1veIMaSw1d8xSlMW6XftzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4p/ZrzWv+7I/PwL/AzZiq9a/zXoUz1s7R6mVyTlBt4=;
 b=lW3qT71LPgWjZplWWvwG2UlHOw8IYvnTV8PtORhmq97FfXwUeGtYDVo3PSyoYINER6ShMD3HmioSi4j7dzbnWJbxuHU2DZm6TCPCubMtX3E1g2IVFeSrY7f0RFgRmrMGjH7VHi58l/CPqlRPafCkswihXX+fwhyDOL9QSFv0qH9cVtKTADR6ipahBty+eXu2y1w2zWWYjFDnmVwE1bnVb6+LjjYBqt/fQ2vFVjsqIL5evKIA/JDI/u9o2Qefglhc0Yv7FZyMvaBmPu4o7//R4H7z0HZhinpHe96HNOfYtaj7zgcRj25cL/0UIC+5IRx7+XrxH+uB25ob6jfmX2Gp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4p/ZrzWv+7I/PwL/AzZiq9a/zXoUz1s7R6mVyTlBt4=;
 b=LCAIASZQc8OliH+5bGA8Em6OKSfO4VcMJpY5T3Q8DX0+KYRfp3sN0FflPtoMSqREEITVCZtFxS0153Xt+l3jEka7myIXpxIXWUCKWeY5D2glV3ON+psJQEUQ4xq7HQbySlDnFXipNcEwLNgz+fFZSx5CgvZlT0DRNvDXFx/FOtLZ/3tW/pf7dYBF6vpSf9XtoxQ6lomBKpw9/BHhbvTx33yLlT+Itok2C5U0rFKk0saIrSDxYwXMM38TbVIWRoTejT75hoWPxxy6kyOjv6maHVJ/+nSR7XkkNttWO8mnP9uCC0+4LFjYpqxYj/RePkD6TKcLR/gAyfIdXuA6Mrp8Gg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV2PR12MB966079.namprd12.prod.outlook.com
 (2603:10b6:408:3a9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 00:00:06 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 00:00:06 +0000
Date: Sat, 14 Nov 2026 20:00:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org,
	david@kernel.org, kas@kernel.org, dave.hansen@linux.intel.com,
	bp@alien8.de, rppt@kernel.org, stable@vger.kernel.org,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-ID: <20261115000005.GG3706007@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
 <20261114002027.GE3706007@nvidia.com>
 <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
X-ClientProxiedBy: YT4PR01CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::23) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV2PR12MB966079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c60e239-9d11-4286-bbe8-08df42ab6843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261026121527099003|261022075727099003|261021121427099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	++dRsn/B61Dvn3ujJnYcGqK+7QjOqdpcdKuC1NnguvPrGLS4tSAgVFjAP0yzVjzmcnEfffznd/ez128DKdPbEST2lFg4RolNHo+21rndJ1gl0lx4zRIKFDb4hHka+BsSBw8/y7NVF6PZqW9JpXTAPBgOOvn4k9wwYIhpJ3/PQyZ3ciJiYNN4irh/Tf7uRrZQc/OOPjvw1VmL/6ir3Io2PUX5AzTut+VvAvfIcMS3aHZZb3apGPca0nEliLheyYr1YUq4w+GB3K1yqW+2xkcwnEe9lYPJ6tiZhpExeNBbNYKxgwjTi/gG02mz5+0AwXwZyuiDcr7KziwJoIU2V8Vc+xpD95qklRfwOV3r3h5DX01hqDK8TQbsQ0STK3OoOU3Wirs0SANpaLJ6v2Sfv2wz6aJEWuwZVD4pzqyzbS0rTLLqbJAnppVZcigP+TgkD02u7VZqr1ra4gisaDR6Zc2Ex3UjCDp9S3o1Rzk5MhVAG/dmGjWT3JsLBV04kNhplGFuH/uc5JiBjlHjfXM3nUpqs6+FnWJOIKEUK14JqzZPbcMfxEPfeZeUDmbsku1xNFgDKsf0vBF3CzIMkzOUsnHAal2O1kgOocAqFCTUf/Jrqwct8OikFahW3QPmOFEukZHQMwRQ7D0g9ER+znuYQZydaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WSmFnDPMJjDXYgIDWj+HdFw8bpDC8+/z7kWy9iEcRf/FbaOly3plJi1NlqUj?=
 =?us-ascii?Q?xgvYZ/4uG7t4dtnGZU7d8smJDt+cuApWYFfodauSzJeppPMg76p5Fiqa5Ncw?=
 =?us-ascii?Q?pqvljfcii2+6w2QVq+QwWE7VwVgO8pRLods3vH6TJJfK5y7mES4Nj+NTRhKu?=
 =?us-ascii?Q?dGdORrFaEoq52dMwtI/Lo+ScJxNuoncHfWMQUrtbHHHk7DbYvTPorsIyTiwc?=
 =?us-ascii?Q?ybEBj7FVRVuQrzbgy8zTzr5Rv/SK1ZNmgMHCuVrul7taORPDj5KD3eY/jGxb?=
 =?us-ascii?Q?fshJpYHRbLwnKpbQufaeXZhhLTpiqlD/GnSBBeTB0hCStcGn2E6lcGxsJ/p8?=
 =?us-ascii?Q?PGu6rtNJvyB4iDM9kOi5+Ys3ZXnWSlG72C8l3wxWUIX9tGFlOizaBZgWDgbI?=
 =?us-ascii?Q?gkaxUOPgB9gtenout5btR15+RASjMgaqV7jPEszJ0iv7DzHg7V5XFu2SBxgL?=
 =?us-ascii?Q?tUw2By0LFK9/dLTGFd9GYpPloDUcS1JLLPCTFmHWx6h9g3uslcFfGKJKWLxV?=
 =?us-ascii?Q?GNurYEbTRSdqolGxv/ucJjXFsV2T4J/vX8PhlszGHavrcWgTaM8qqlvMgNa6?=
 =?us-ascii?Q?0LCpmkkZrnHQ02IVwkPwRb+rXahiKzj7K/bqL7tCsi1KrpKgAwwxP4e7oQ0F?=
 =?us-ascii?Q?l6G+VXaAgC0w5mB5fj6Pv4Gbkq0JXgIthBPKBoQg0iZYmh7kGkoMZI8sYfbz?=
 =?us-ascii?Q?ZhZk15EfB/GLRah2azOMbA/XhvEViJN4tZmgqwU1FnYD3e1tXxbILKHaO/BE?=
 =?us-ascii?Q?x401KHxqHxJLZOKeh4Utq7CVYgJAy6AuzWwq4ibxWM5bD8bzaKCysEESsh3V?=
 =?us-ascii?Q?mjrY/HwEQgQLqy02GGS+I3zO2tdMRv6FRASXkRbJsyLVmLnNriw5zivR/VEK?=
 =?us-ascii?Q?oD/tQ4FXnQiLAHbtG7ab1CpAppWWthiL1FYYPHfZzPLHddhzYGTW8zy2uchu?=
 =?us-ascii?Q?zVWF45vPc/25BtgXCMdum4UWQHtQ01ErGrH9Sdze+IDZ87L3QW1oL1OpFKDC?=
 =?us-ascii?Q?pzgo3DFEaAxO0w6ajPM9XMiXdHdGFPycRpwMDWmVBqLIq+Yh1eDs63El2SWb?=
 =?us-ascii?Q?x60QacfEQPYNv+9T7n6h2vPKnWj1hLIjtii7mZq4Bg1jr74Wew0ZLAu7w/wr?=
 =?us-ascii?Q?jVEq3kZgkBXnvdV8++Zf6bXY6GulH+D6oU5ikZ14cvbgORQKjL8JbLSULYXr?=
 =?us-ascii?Q?KGz0jhGncKzd57mg2wjdH3WyoahzyunjKPhk3Z+0geAz12D8DLgpg06N3dHx?=
 =?us-ascii?Q?16RZq79E534OskJ9Eynbkq6j9cjLbzwIx0UfaWsE9Q+Vv1uJy6TjpWdLwg2f?=
 =?us-ascii?Q?pSs3iT+rnQ2AKlwEbBR/ZtDQnM7aFCMdSarCIpQrhnkM2J+G7N4GikKWL5Sj?=
 =?us-ascii?Q?sb239cCONid08cjXLiLpvbjRurP3tZ7GuSg59xCAvrwZTCfsV+gJlL24D7K6?=
 =?us-ascii?Q?WS5EgqO7b0JOPO6LrgUT11MX25omDlNqE5xM99D2DWQWgVoY2MvbO4zCGaz8?=
 =?us-ascii?Q?WGWln5CB+79QgdLJk3UyJuNlbFdrcZHZaLwdGHl7ZMBiqaM3iAuapx5b7o7Q?=
 =?us-ascii?Q?8q04rDvy7+DpPLQoTKlmYe1rQnstom9FTwVK7AjdGYjfGh+hFwCemmUXk312?=
 =?us-ascii?Q?Dr+ywzdWqUqk9yGSzALDCxzqqnfLlPpaWdgRCLcoeafgUDh7esTjkX22aLQA?=
 =?us-ascii?Q?0t+HVbzSJ9ou6gm4hG1I2LmKO+09qUspuvKBdkY6A0MvAVuo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c60e239-9d11-4286-bbe8-08df42ab6843
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 00:00:06.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS0zo+EzwEMgz3cpqUfKsYONpdgupQ6RWa2PqCP0s0SbuX66w9De7JPYNuFf6zUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB966079

On Fri, Nov 13, 2026 at 06:10:25PM -0800, Andrew Morton wrote:

> How does this look for an altered changelog?
> 
> : On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
> : rejects ordinary stores to it, but pte_write() reports it writable because
> : shadow-stack instructions can write it.  HMM consequently sets
> : HMM_PFN_WRITE, which Nouveau turns into ordinary GPU write permission.  A
> : process with GPU access can then overwrite its own shadow stack,
> : potentially corrupting return addresses or bypassing that protection.
> : 
> : Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.  A
> : requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.

Yes, but it is not just nouveau, RDMA user can do this too and
that is far more common..

Thanks,
Jason
