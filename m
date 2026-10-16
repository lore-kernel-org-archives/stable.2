Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E13B71A3;
	Fri, 16 Oct 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150044; cv=fail; b=V3gCHN+K674VR790Cjl+oq+P2jRFILFwU+65GUeW2XQ43JIqna62XldYrzL9e5gsN+S9/r1MXD2nH3g4ZtS/4oMX3SP43k2Q2f22TuvWK01L+ujq4CtfkYYEAVWRwwq3ndkdeGQIxopjNZBoiisUajrbJaHZVT4hXunENzbVnyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150044; c=relaxed/simple;
	bh=47wWrjauqlDq/AbKNbvUA3NgHeSIUq6mBK9G32RaJLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sXsSv/ft9lPoEjhkP6oCvWU0O+gkMQRwXVq//xy5vKRNugK0ECyxz2eDh1+H1teJeAtNGydBOpftZMj7zD6a1peNylq+Yvsa3l+8gSVWlQhJPLRT8dorYwOMR9gSzZHdWPWc3xAQPyoK9XT8BrD+pLSRgOZMElrqqdYsBe0mtFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=azW5o2g5; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="azW5o2g5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHHZxv4YEjHXrOJ8/qVCNrBDdrhngEBaBP2Ae27zuf78cRh9vZ7zzrMCIflEmOjshVPU2sjc+wmLV+NBKRdeGEVSKZI9gS2hbWFbFV/+b+HmtVA7H/cszBaiNi6A0tZhQX6VUxcVn+7OjhxVgARPl5qJlvaWMA6tNsNZOSNebRcbfZDyXr7s8tHfpCh4R89+tSznTaoxpfkEiyTod51alSe/whk+4g4ItaOG02bkIbuh83orIBBru2TqAjUsAsAWWdOFDjIWYetIixEcDGPFg5PxkvolWxTQlYKNHbCHFpJkq/kknOMQKLQ7vqL42a7/K3uzTKf6LNJYQYKBz/0uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX5h/qjGdWNkd6QSVfRUyjnOv8+l7PAJHbp7wfa7m6k=;
 b=p0XLIPdviWt2WKPGX9MwWXx5oe1DP5dYb3aB73ohtXiBKpU8hj1DN3x5qY7XiXxPU+1jmRGwBUWH0kOtpeNurccm31tqPnYNUUdvwM04nVH8HuyMota2ll5AQHpRlR3xq8O2baRBYxVGhVZkwsLHvLBRiCu2XxuAWgwfwY+fTAvU3JG//P/7MI2rjm1wIcjWlFiTMrAH0QCyJm9Ev2KdGdYXEpB5zho6R4LFgmTNcI76/Z2ukW40cWZkluLLyXwXpqrC7O2bQAH8TVLRPxAJ8b9YhHH3pC0QCeOOwr0AseBywRW8r6japxJhsrNWq4GaLGVmsH0L1Ud3IbZ42l2lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX5h/qjGdWNkd6QSVfRUyjnOv8+l7PAJHbp7wfa7m6k=;
 b=azW5o2g5TlcA+f/WFZRAk5imtWffoWt6GdFA2uNQ0Wo32otab6gB0W9KyLwkgMePRUlfQINYOiCzqpmn/2yBAZVl4zstoP5zg3w+7c9CT5S9FS/Q7h4VNbQMrzeaHQd9bJxzGQmbTHxmrLywFmw+lgwE4SGMntjjEd1qXQHUpK8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 11:27:20 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 11:27:20 +0000
Message-ID: <6b532bcd-c36d-4b1f-b0c5-9b6b2dc85efe@amd.com>
Date: Fri, 16 Oct 2026 16:57:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: amd: fix len==0 underflow and FIFO overflow
To: Weibin Liu <liuwb@xiaopeng.com>, linux-spi@vger.kernel.org,
 broonie@kernel.org, Raju.Rangoju@amd.com
Cc: linux-kernel@vger.kernel.org, sanju.mehta@amd.com,
 stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
References: <20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::7) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ea6f63-e0af-49dc-6120-08df2b7870df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	VyVbMDWcFJjJ8OQeau48E75/bVVcUSmxUPqMXvs4IFVybs58sTaHktNKRKHjbo99zY0PzjDOpNgPiZhbsNvA6qeduq2KL2WGIjX23eDCpJ15HVnIGg3LN49cwhCNDVWsVGxscXrKTaUsGHCpyMSnhPyXj7th8KFzyzJ/AuT/HCrUq7kq3wNE99iM9Xstct1MHGn93jvZZjc0rLeAeshe4w+mvc7hHlOe0dlcuWSPw495ShjQ0yKpKibYcBb4EWEsQMKG3TbnIpXKFizTIHTkYVKWAv1pAEEeozq4A31A+XqRwgWZQEwY02i27+DxTarpABjWzauzt64Zl7bjEDTtfVJIGa6FYuxEauGXPSGF0NisufJ58p797axGcMDUpXyvKIhGYMSCh6EBsU4tQcudYyu89viJM1a93ElgS1qjAFv5loHScuuF5JalMvZn3y4hb3qz0Fa690WCUxS8ZJE/ig48HcV+H9iG7nNf2azURFOZIdCAOhKh8xzC2t8Sl+UvMr2PGr/ORAfNAIvlrNbZ5RuK6U4XORQktL9JU97kIayHiyEaVvZovWGV/0oUR0iCp+TGiscjTBZW4mUTcclF+WpFRlZbY14C9eGBYi2yYDNrQr67p4m2919z6SzfwOlp5eSicCH5Yu2A0iaJkG+Q/wVg8B1bEsUzqZ9w2mqOv3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZNbnA3aCsvS2NpRjlrTFZFWm5pN2tPMVE5a3lYUUNFbFRMWjJmM2JSQm1I?=
 =?utf-8?B?V0VsNklrcWF4OGZCYlQyOUxib3JqK09ROSt6WUh1SXpqMXBBbkdOREprQ0RU?=
 =?utf-8?B?U0c0M0VIcWc0eU9vdUdlS0dxN0wxUkYyWklXbFNpdTh0RHIxbFdHZ0JsZmZO?=
 =?utf-8?B?SDhwNC93YWZZNTBqaHpWdlgzN3VrMXZIajVCRzErWlRWbkxQeEtpSUdhV1B3?=
 =?utf-8?B?KzNnY0hrR084R0ZpTVFTMHJ5RTd6K1dTODZ5dHBiRXRucngveERXMXB5OU01?=
 =?utf-8?B?ekFpS3hFWkhEVFhxK3UxMXQ4OHAvT3BPbXAwTFhuZzBMUkxia1BVcU0xaGpm?=
 =?utf-8?B?OGg5Zld6dThtY21lajl5R255bitGaTIwaGFiQjdFQ2ZDTjdRenVlOEMvL0Rs?=
 =?utf-8?B?SC9XRGpNRi85YzlCcGpUaDB2eUJxdnFpbUNXeng0cWg2K0RkTWw4dHFxSDFq?=
 =?utf-8?B?V2dmL1pob3R6U2J1NEo4aExCRnJlMmNHZVpuam82R08wNk9ucG9hUzhMN1Jt?=
 =?utf-8?B?Ykp6MTUxR0RPZEZhdEV0VmVUeS95aTEzUGpwOWNWYllFc2dqNUtzK3FiTHlt?=
 =?utf-8?B?TG5vbGxvZVhTcWd6elNmbUdYVnNsVmwrQW14OVJ6T2hDellXY05DTmtGQkI4?=
 =?utf-8?B?RU8wbFhRRnZlcVJjdXFseUpXV3RxaEx5OWxJMVp3SDJOOTQrQmEzbGhvMUR0?=
 =?utf-8?B?VkpLVXhTTmptb2pEY2NRMSsvUmpoRmsvRGtRTGYvMDhOU2g5UmU4UXpIWGxJ?=
 =?utf-8?B?MlVqK2U1WTQrekR0bm5lK3g0eDJ4ZUd1MzJ6WXJvemdndmd1K0t5b0xMN0V6?=
 =?utf-8?B?Nnp5SWdvMmRudmQ4MnE4SkVrSTJ2ekFsdTU2QmJuMXczSUdRQWRQQ0xJMUY5?=
 =?utf-8?B?VzNtaDZtdGhpSllTNmZDdFhKaXB3Y0dPQ0pJSlNYNERXMzZUZytkTHlDV1Yr?=
 =?utf-8?B?b0MzTDNtM3pKQmdDMVhzTFZFRGZ1elk0cis1WHdnLzRwRXpqNzNUZzVmcmFm?=
 =?utf-8?B?dVM0cXYrUkFQKzIwM0VDVGhjQ1dBZlIyZFZNUnlQWTQvQURYaU5kS29BVUN0?=
 =?utf-8?B?NHV4YWVaeXR5MDFqeUZMeDZJV05zNGplNi9yeE1DWUY3MGZxVU1kMWplRjlO?=
 =?utf-8?B?ZGpBdnNxaW1XeFc0MXNOQ0ZWUHB3OGkrT2VKL01mMHphTC9rODh5S3hFcmJl?=
 =?utf-8?B?NG9PLzJmSFdYYUx3WVd6OE9Sekhwc3pzR01ra0xvQ1llMEozcjMySkQ2bk5O?=
 =?utf-8?B?M2o3M2ErMkhoblE5Nlo2cnhvbVFlS3VaNitPM1l1OTFQY09KYndIazY2SnBT?=
 =?utf-8?B?dFpyb2dPbnpQTEVZSzBUVDc5MTVpMDdlcGJ3VTY4OGZNejhjd3VVOWYvUE1o?=
 =?utf-8?B?cHloc09URThFZlB1bCtXcnBlb0dZYjc1SWRSSWlBejRSTFVQNmVFWFFaVE5J?=
 =?utf-8?B?SW90bjRXMVl6ZTl4T0g3b3JhUmVpZExIYktDa3hCMkJURERLOHVzREw3YUVh?=
 =?utf-8?B?V3Bmd05EZWhlSHNCaWJOM2pYaXFFalFxVEcyUmxZZXdtMFRnVGJNMzFkbWdl?=
 =?utf-8?B?dkNEbDhBaDNYdkVxWEZ4NGcraTlueGNEdWppSWxDMXVqeXpteWE2VlFUdE11?=
 =?utf-8?B?NFJ2dUdNNWFjNVZhY1Z3QmhyNFgwUUJMOWtQQWhXeEZxSnNDQWwyOHpIS0Fh?=
 =?utf-8?B?c3lmQ0xieTh1elZ3c3N4RmMvZzRoY2huTHVmbGhFUkFSUy9zbEdCUXlWWFVj?=
 =?utf-8?B?ajJHdXZnV003Q1N2V2ErZ1BIQkErNVhBRS9Dbnh0TGdVMWFGeVhYYS9vMTJt?=
 =?utf-8?B?NFN0WWpDVmUxNTQ2azFpN1V1aVkzaVZ2emxZYmFaeVJMckRKT2JMQ09NOU11?=
 =?utf-8?B?LzVzSFFnQmdaUm9LQ09xcWw3dDcyalRSbVRuZkUwWU1DQTJvSnRkL0hQMTVH?=
 =?utf-8?B?NjRVUVBsQ3ZMSE5zWGxoTDdHVlZ2Qlh2aER4c05BQ2p6NDBVdndHRHNYcThj?=
 =?utf-8?B?MnVJZ3lNS2FCcWFzUGR1U2QzMkZBL0t0TTRKdWY5OHNockVDaWptVzJUUXR0?=
 =?utf-8?B?VE05b2xZbEMwSzNETEdIdUlUQXJ2TWZ4bkVxaWlkQ2U3em8xS0hMNWR1TzBE?=
 =?utf-8?B?VDc1OVlyblRDdTd0M0pwWTdTdGxoSGxROTVpVmVTK3FRdUhNdnhubGk3ZGho?=
 =?utf-8?B?M1JpVGFwL01NdXVDZUs5QldvOHFXMU41SEFiQ3FXMVpCZmM2MmNCVmhIWVcw?=
 =?utf-8?B?TThXeGZQZ3VrV20xMUZzVG5iV2t3bXVLQXhPcEFtbU9uUWMyZVYrZEFvZjl0?=
 =?utf-8?B?NXdIQkhLR21MNUdHNTcyZ1Z5WFVVOVhNSStFQ01UeXBrSERaaDVkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ea6f63-e0af-49dc-6120-08df2b7870df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 11:27:20.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQlK37v16GCkNNj6Ryxn4qBZfQUPLYpBkb6Auw9vgEZjMCSsvXhXPPNDDTv9g7RQK2flMGTzGoJE1iiCq4atDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169

Hi,


On 10/14/2026 6:09 PM, Weibin Liu wrote:
> [You don't often get email from liuwb@xiaopeng.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> amd_spi_fifo_xfer() unconditionally decrements xfer->len when a tx_buf
> is present. The SPI core does not reject zero-length transfers, so a
> transfer submitted through the SPI_IOC_MESSAGE ioctl with len == 0 and
> a tx_buf makes the u32 len wrap to 0xFFFFFFFF, and the following
> per-byte loop writes far past the FIFO window.
> 
> The driver also never checks the cumulative FIFO offset against
> AMD_SPI_FIFO_SIZE. The core splits each transfer down to the
> controller's max transfer size but does not bound the total message
> length, so a message of several transfers whose total exceeds the FIFO
> overflows it with out-of-bounds MMIO writes (tx) and reads (rx).
> 
> Skip zero-length transfers and reject any transfer that would run past
> the end of the FIFO window.
> 
> Tested with a user-space replica of the fifo_xfer length arithmetic
> (ASAN build): a zero-length transfer with tx_buf makes len-- wrap to
> 0xffffffff, and skipping zero-length transfers avoids the wrap. No AMD
> SPI hardware was available, so the FIFO bound check was verified by
> inspection against AMD_SPI_FIFO_SIZE.
> 
> Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
> Cc: stable@vger.kernel.org # 5.8+
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> ---
>   drivers/spi/spi-amd.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
> index 71a6e5c475b0..ddf89e5353c5 100644
> --- a/drivers/spi/spi-amd.c
> +++ b/drivers/spi/spi-amd.c
> @@ -322,11 +322,22 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
> 
>          list_for_each_entry(xfer, &message->transfers,
>                              transfer_list) {
> +               /* Skip zero-length transfers to avoid len underflow below */
> +               if (!xfer->len)
> +                       continue;
> +
>                  if (xfer->speed_hz)
>                          amd_set_spi_freq(amd_spi, xfer->speed_hz);
>                  else
>                          amd_set_spi_freq(amd_spi, spi->max_speed_hz);
> 
> +               /* Reject transfers that would overflow the FIFO window */
> +               if (fifo_pos + xfer->len >
> +                   AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
> +                       message->status = -EMSGSIZE;
> +                       goto fin_msg;
> +               }
> +
>                  if (xfer->tx_buf) {
>                          buf = (u8 *)xfer->tx_buf;
>                          if (!tx_len) {
> @@ -369,6 +380,12 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
> 
>                  list_for_each_entry(xfer, &message->transfers, transfer_list)
>                          if (xfer->rx_buf) {
> +                               /* Reject transfers that would overflow the FIFO window */
> +                               if (fifo_pos + xfer->len >
> +                                   AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
> +                                       message->status = -EMSGSIZE;
> +                                       goto fin_msg;
> +                               }
>                                  buf = (u8 *)xfer->rx_buf;
>                                  /* Read data from FIFO to receive buffer */
>                                  for (i = 0; i < xfer->len; i++)
> 
> ---

Thanks for the fix. The zero-length skip and the overflow bound are both 
correct, but the FIFO check can be done more simply and, more 
importantly, before the command is issued.

fifo_pos only advances in the tx branch, so this form can't track the 
cumulative rx length in the first loop. That's why you need the second 
copy in the drain loop - but by then amd_spi_execute_opcode() has 
already run, so an oversized message still drives one SPI transaction 
before being rejected.

Please use tx_len + rx_len against AMD_SPI_FIFO_SIZE and check it in the 
first loop only, so the whole message is validated before execute and 
the drain-loop check can be dropped:

if (xfer->tx_buf) {
     ...
     tx_len += xfer->len;
     if (tx_len + rx_len > AMD_SPI_FIFO_SIZE) {
         message->status = -EMSGSIZE;
         goto fin_msg;
     }
     ...
}
...
/* Store no. of bytes to be received from FIFO */
if (xfer->rx_buf) {
     rx_len += xfer->len;
     if (tx_len + rx_len > AMD_SPI_FIFO_SIZE) {
         message->status = -EMSGSIZE;
         goto fin_msg;
     }
}


Thanks,
Krishna
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20261014-spi-amd-fifo-fix-37ac4ef05bf6
> 
> Best regards,
> --
> Weibin Liu <liuwb@xiaopeng.com>
> 

