Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86831316192;
	Thu, 25 Jun 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421164; cv=fail; b=DNsdTaj2bwkk1UPYmVPgUS6ptnIdmAnD04RNwFIWifdvxLGrTxITY+X0pe+K3IH+RopYDXogvjv42GsAOWnXxGjODAoJjjeSVffr564FQjQelYbITeb1fjCiUuVc4lLsYNT+rOUZf+ysHoWwoi7C93f8fyG81AetIZYkzWCz84A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421164; c=relaxed/simple;
	bh=r7CDOIVU5V0ZMQ06sYJj3L22SmGovL6oJEvN6yjeJ38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCARj6L9CReu3+X7viow0OMDfOjH4QpXenKdTem8PqdfkPPePyFnQG5LETEGJBS4f2naiQ3CuL2agotkvRIqh/Fg2kxfmD7AqXpGz7xQ9ZHgS9BRnXRYwqL+INTcW6YEOVbGoq32pwbwbAT4GZHjxkjYw9UAvYIZP9XoT16IfWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J70pGCg9; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J70pGCg9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMnlPpTLHts/hllBURziKbtk6CJW6qLIIvnIfyiTAlMr/n4SPOT9EwoDjS9raRHd0lLEkFvJHWwKivZhuJgPMLzDth56wVckxMv2NCEW3yuS/PlNlXBLkOwArnIbw/Exkry7Z+K+/uWxAed9IdUUCP43ILyOPlNQatFDZggeRN8a1rVRJP+X98wxFaGYeM44LzW6fBDxDSPx0maCMJQazDsiM1Hr0FJ/NHIvO39JvMyeFYNSXofb50IsH412UNVTxANHca3568nhVGsNgN4uAWOjX5jDfduYBzvq4HHEgAVkb9qd7AvIhZvLtqQdOEZ1U1Eyzf5Hb/tKuBz8NhgM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg6Y+5WlKWjeQhZYBT5GstahghO4mWd2BQBkECixp2o=;
 b=oe2hz4+LBO029Niso+8R6O4p+SuLeusrXLwGzFdwUVTLi7A4t66Osi1psE20RSkmoQxOsG8r3Z1IuzBmnxL8YGn8+HHIUEZWhK03QAGdvQUCA/H0NNBqwiVacYYawsh6qfPPsFK/dr1BEplCE4iu2ECAWSXlezBlJZiVGhvnk1I22QPMb9Xb3FRn7UPWESqGg2nOYcftEfKc4Q1525IJ0+fJ7cLp8EaPZUhO6kGdMugM1LXXhvM32Xu0F1Giyj2/i3MsEhhBGBNklJLV4Io2/euBvEfPsjVi0VJyuuSSaa0i6CT2hvyS4BsX6IJjH55689NIZKByijj2zYuO3bHxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg6Y+5WlKWjeQhZYBT5GstahghO4mWd2BQBkECixp2o=;
 b=J70pGCg97/50hnB4zKBvTzACrr0vSDHgXpFBHp3D+KOsCvoa3/TaOm8qGxM/EqfTH8YF7KRrWgi/zm/Q04VYt7jeQV3HfOU/5KbBHKxFkUG9/hXXNXAY2QgXdzdZWZogYlfMKKg8D6BPymU4dPbeM84vrkjO039M3sWTYBCxLVbaplZ6iL3U+HOnKREH7e+0a5EmprTKfstZ4qA++zhjO1toXdkRFKsCiidPFOz0CpzZ6UWZzpJyO8bmnJ9fd7quNSm8ULStxV0V0OvacO9XeMQsuKVekdALaC4MZpxXd7xYuvNnKZaSSv0DMUgWs2Lq20MNypjqK4Y5VFgUgcrt3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 20:59:20 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 20:59:19 +0000
Message-ID: <0e528a99-0037-4e66-bce1-dc3a974a75e2@nvidia.com>
Date: Thu, 25 Jun 2026 21:59:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
 unmap
To: Greg KH <gregkh@linuxfoundation.org>, Vi_ _Ku <vishalmimani008@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
 stable@vger.kernel.org, thierry.reding@gmail.com, digetx@gmail.com
References: <CAN+vipx-6gco_XMnV+JxbkRegJ=i8tSKFdBN4KcT16UceQduqQ@mail.gmail.com>
 <2026062523-shank-explicit-6e09@gregkh>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <2026062523-shank-explicit-6e09@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::16) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bb4ad6-3403-4dd8-b8e1-08ded2fca061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GfzTVceBTUmeHKMTHK/TRM8ll0WwzAMpDKuFAR0gJwEzEUwFp71yy1zR1smOWUx6cgO0n0BYpjy0egBSrETtVEcv2jPuM+x559ihHDfkI0J/rSIh3XFLyqP/x5jLLQMZ/vK8kZgvem9aon+EbcbKM0WO3iE2IR9aP6LvKjVclZtTGP9G4DGP4V8C4+BXlVi7Vco9MMuXepMqazdpS1NKuOhwZ2nZHXdWckzZaVX5aTBxnwTP4Cxbw6Ub99+DP+422q+FHVWkoZeQpXbXtOsbCt/9TUTj62SuSRwVbt3QDlPB/7ne/UOm1bYXAEwyO8ZtK+0IRrP+J/z8O0b72M1XLsreXiIo+45B2El4cLlq04vt/uDSAnCvGBsWF93+X2QmEwp8URITgrmD5WY7AqatQF/kMscxCQilWHpft8bSBJTGicHK8FR+dM4T5FR8FHJBvN5DkjEiKbAn+pJVjgSL/2igldxUbjFtwEZQheAxC3PJjgaHgo9VirNYF4N3Pvh466EC5snlkMAfUYRoGYsVSV7+uTmLwL9cIHAj3U+0wcHftGkxyWNRyIhl0n5S8QwOJOsEE84BaPfaPcKvdAAmp8OIP072NJ79LhFTlJIeFzD9jaSAhItOkxCCJuz9bIwJwElMn+l1P9gbSfdzHXpy2A08s/Sx8X4yCcfYYyhT3QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZXcXBZamdpcDJiQmlzSUEyWDBaWlo0c21yMllSNVpBUWJiN3JkK2w4bFdX?=
 =?utf-8?B?dHB4OG5nNTFQeFlUaC9PNnBvWVM3SUZSVFBRSk11bUlrbXZjM1FDeDdjSHc3?=
 =?utf-8?B?TFFtNkFrV2RGOU1SRG9mSndWL015RlJXYUY3YnpsK2NFUHBMeDE1WlFQdmpw?=
 =?utf-8?B?Nnp2ZFl0K0VPTGQza3JuWTJsaXZISHZ0bERDVlFDN01XMmtab1owdXlHQ0Ru?=
 =?utf-8?B?NTZsVFNCdzk0YlhzRGtPR0dSQUR4aDF0NmlRMUtXeVB0ZlJWbjFiaXlnTk11?=
 =?utf-8?B?YWxhK1RRV0k1c3pyYXNTWEduRm83NEJDT2dRSjg4UnAvQ09hbDN4V29MU3RL?=
 =?utf-8?B?d0l5SFBncVVLQVpEL2l4V0F2dDVwd1d3UnJHbUtxbmxXdjRLY3MxL2U2UjJM?=
 =?utf-8?B?YVFGRUMvSHhTYTFJWHc4NE8wZTFhWWJwcUJQS1Y3NkV2SHkzN1Zrc3dsMks2?=
 =?utf-8?B?RXRvUVVraXZ0NEJKL2pqeWxHUVEya0gvbWpNVllmWFJodkNoT2NwVHBuc0hB?=
 =?utf-8?B?elFwdms1NkszdHp5SmIvTU1VZHR6UW1TVXVucmRzWXhlQW4wNGs1NjBqWXNI?=
 =?utf-8?B?NmxEcmF6a0hwSGhoWXkvQTFWUkdwWlJBOUZjRkNsZENabk9FQ3ozVGxRTHpo?=
 =?utf-8?B?bXJBZXhYRW1GdmxSWjJhMlFHNXgwU0d4NUlMVUVFVWp5SzZlajVWK2hDK1lT?=
 =?utf-8?B?UkZ2Z2lhYXNyQ2lZTVJzbDdvdnllM01aZWNFNDFkWk5YMDdUaWU4RGllVTNJ?=
 =?utf-8?B?NVpvdmhSZXJ1MVZuRE92VllzSXJkYmVJanl6YTJYSlhZVVcrZE5tTHZLSElT?=
 =?utf-8?B?OUluZ241Q1ZVVnJUSnRWRVVEKzBhWkdEdTFGUnlOMDNnK3FNRHhnVXo5dGly?=
 =?utf-8?B?OXUyZThXWGVOZUlFRlJYTERWSzZlMXdZSmpZTVlMT3REWDlqK0lZaFZwMldC?=
 =?utf-8?B?WXNsMDFCZHJvbGNnc1Q5d3hLbTBYR0prVmVneVVoa2tkQXFZYWtqT05jQi9v?=
 =?utf-8?B?SFR4U3E0ZGp4T3k0RjFCVFFOYk1HbFo5Z2N1enFhejJ1LzFOQ0xhcXdnMW1X?=
 =?utf-8?B?QnAzOHM4K0RHLzhqeGhId0YrMkc5UHVQM2FPOFBvZ0Ztd21ER3RtNUlOUkJZ?=
 =?utf-8?B?WnNSR081R0dTM2pWcVF0M1c5OS8wS2lZRmhCM0psZlJqRlVZQUl2R3pscndn?=
 =?utf-8?B?WXQvWXpNNE1nVEN3bXA3bWRFZy96YU0zRzJ2YlowaDhwVEZvTFc1NE1lT2xm?=
 =?utf-8?B?ZlBtYXBRWjhNVXpiQ0NNYU9ZWkE1WXBUeGdmUmE1aU1lTHFrakV1Sm94eHVn?=
 =?utf-8?B?TWtWYitlblAycEl0Ly9zTmxiQzhoc1FyWUJhQ0pFcEdMNmlFYnMzYkZha3FE?=
 =?utf-8?B?Z3dZUXRNSjBLL05OVW1lUnNLVGVCdmQxR0prNGwxTWhkelFPbU9HczUwck5I?=
 =?utf-8?B?MmtISGI1V0gzVTZocXlaSVRxSEVLZFllY0pKR1IxR2d4OE9reStvYVV6c1Jx?=
 =?utf-8?B?NTBQQ3ZHQW14dERUcWRDcXlwWmZHMUpPdVJyV0VCQVF5MjZXMlNIcUtKVUJY?=
 =?utf-8?B?RTBZQ2pCNlVFZ212Z1NzcUFzbG9QR3dsL2xNTXlaUmJPeEg3eDdlcCtMUlcr?=
 =?utf-8?B?dDErSFNWd0JOaXpydHY4OEI3WGhHeGtvdHJVYjlwQWJCd2MwNThSdWZlMmNE?=
 =?utf-8?B?YTU2T3VlQVBhZ2pla1prVzhjeTN3d3pZTFRzUUQyTXVnMFNnbUpLWWtvMDVv?=
 =?utf-8?B?SVN2ekI2OWswRG9RSzV0Rjc1dW40NkpUTFowbEp3Q0Vpc3ppZUErVDVobk1K?=
 =?utf-8?B?UHRYQ2lGR1NiaTZHTDZjMENqK2sxTHF1S3F2N2t2d0E5aFpnL0ljMFVSMDJP?=
 =?utf-8?B?amZBZE0yTm1zNnNod0xVOEZBVTVIUE5NRWFCYmcwN3hJRmdhS0pZaHZBOFBm?=
 =?utf-8?B?TmhNVjQ0N0NpbzFVWi8xMWh1a01LUEg5OUt1Y2hnV2hZNDFIanROTkdNemxp?=
 =?utf-8?B?YkhKUHRFYlNMbVBLYytndjdBajZhcjRDMXRqN2kzRW5VRGJLc1FZdWRFaUlC?=
 =?utf-8?B?Q0ZRSTlyc1JQS3Fud3d5aS9NbE91b2p1RFJuU1F2WTU2dXBWTDR3WFl1MXdt?=
 =?utf-8?B?YzFEbnlQZU0zdER2MjZMcEJsSzNrU0FGVlo5U0RBZmhqaHhQRkxuUUh1aExn?=
 =?utf-8?B?dTFqVi96dHlrQm5WUnhmSkxMOHd2NjFoODROVVNNQjM1bzBGYWlYRGtucnNh?=
 =?utf-8?B?U3Z6eStkd2czb1pDcHhkTm9BOUlSMXhGbWJKczZHa0NjcDRsVkZuTVh5Qmg4?=
 =?utf-8?B?ZVllUTJ4UDZYZCtoaWxJVzUvTVB2Nmhpc0ZUdmxRMGxzY0xLTTJIWEJhQm5z?=
 =?utf-8?Q?fayEbAJsKFSaatuDJgbDSsPe4DOXHWAE3zrtmizwj8nuC?=
X-MS-Exchange-AntiSpam-MessageData-1: M0KlNmbddGp5lA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bb4ad6-3403-4dd8-b8e1-08ded2fca061
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 20:59:19.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxEF2lu+T0sEaDktYSIrJ/Z09GA8AOhUOdwokGJaAwYlBSO8DWNudk0jo/c2k2Dyl0qB4WT/O82ytCICc72MFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832


On 25/06/2026 15:53, Greg KH wrote:
> On Fri, Jun 05, 2026 at 02:16:47PM +0900, Vi_ _Ku wrote:
>> On Tegra186/194/234 the XUDC appears to post a transfer-completion
>> event when the DMA write is dispatched to the AXI interconnect, before
>> the store is committed to memory.  Under SMMU strict mode dma_unmap()
>> synchronously removes the IOVA TLB entry.  If an in-flight AXI write
>> to that IOVA has not yet been committed, the SMMU raises a translation
>> fault (fsr=0x402) that permanently wedges the bulk endpoint; the host
>> cdc_ncm TX queue stalls and fires NETDEV WATCHDOG after 5 s.
>>
>> Fix for non-control endpoints: poll EP_THREAD_ACTIVE until the endpoint
>> sequencer goes idle before calling dma_unmap().  Follow the poll with an
>> MMIO read-back that orders prior CPU writes to device memory.  Only
>> after that does dma_unmap() invalidate the TLB entry.
>>
>> On timeout, skip the dma_unmap to avoid triggering the SMMU fault.  The
>> DMA mapping leaks, but the hardware is already in an unrecoverable state
>> at that point.
>>
>> ep_wait_for_inactive() uses readl_poll_timeout_atomic() (1 µs poll,
>> 100 µs timeout), already called from IRQ context in
>> __tegra_xudc_ep_dequeue().  Change its return type from void to int so
>> both call sites can detect and report a timeout.
>>
>> Control endpoints (EP0) are excluded: their completions go through the
>> control-transfer state machine where the DMA is fully committed before
>> req_done is called.
>>
>> Fixes: d720f0f7bfa0 ("usb: gadget: Add Tegra XUSB device mode controller
>> driver")
>> Cc: stable@vger.kernel.org
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
>> Cc: Dmitry Osipenko <digetx@gmail.com>
>> Cc: linux-tegra@vger.kernel.org
>> Signed-off-by: Vishal Kumar <vishalmimani008@gmail.com>
> 
> Does not match your "From:" line :(

Looks like this patch was sent 4 times. I also had some comments here FYI ...

https://lore.kernel.org/linux-tegra/169ef7cc-e1fe-46d6-95ca-0f3514e806c0@nvidia.com/

Jon

-- 
nvpublic

