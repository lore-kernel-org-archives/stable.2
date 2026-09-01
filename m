Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D04582C8;
	Tue,  1 Sep 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247287; cv=fail; b=MlgHLm4SBZCb8SCS1qxPzUSC+pAS5ROe4KO1obbJcc02/ky7ALhdNYxiyey9tYU5xhfWit0ldW1n9dvvqEpQ6aJTJn6Z87moQhRCZdjL9HZfSdNcgVvb2U+9XoX72BjzzbD1AHo0YB6xtvF4Fpv63CVncmzRNXAdHSdMLRCAqYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247287; c=relaxed/simple;
	bh=tzd9rg4wLKF2OSfW2DTbuHPPejKkJ5j7Qu/3AijKG6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OCOk5MVhajK5KDP8kmhSnyyckFCGvQ34HsYJZQOBPdc9e+3yC2WJq3WtaY/9Z4aniff212/cGVKPqxhg8883zo1PnUfReyDi9JMaEFObNvij+4qUHP5yTLypLKT82mFHWkvzgo7ipeBBSA9Wbav64i/w7QoHJegVG6nGYisO3/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LMi0VZ2X; arc=fail smtp.client-ip=52.101.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LMi0VZ2X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNdBsZ3vkAvcsvlwJDJ0bYpsNCQE8HPti2TNa2wAY1G+McTwzY5Y0wJz8+a8zcLBUkyhztCfjlgLDmaqiT+FB3lRJ0RFtVpxIh6gQUHsyIsLHy50euhcizmL8iIw5z5faGxhA9t0qrp7BpSZkdrnYfFRJbsXQO3NFBpkU7tbTy76uACoSwbDN0uuN9yxglvE1n6M9DXh9z87BUu2tZTDDV5fcAn5mH5mD3fRb2/1GdTCWiTufIPB8VQkIwjkh/2N7l0ISR6IcsLeVQUzntlPLveTDYDyhRWJC9Ewk4dHCNHfbO5aBJ/okohloTBaYZ7yPaO3xIg9JVRl11zqhU7q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HszavBPx+8Qacl651ZDK5kfzAuI8Djhxucem0DVUcM=;
 b=p1MY4Z2vhoCOR7LM8wumKdS9sRKx5sDVEw1HdRd+bFq+7ZHtKK7fml5YvUXrTpIcnrQr0WF4A/zyV+F8yTMfqqCN7ruGAS1qJ5HrYTqI4PTQiBiAvc6DpfPw0uajwwu7rvQjz2GqLN987qdT9TvjM9iX/60AdYiHWXvZgdnlVRmFIi/JaXVdsPfNlxEnl1veWzeR1BZZsnEdt6A6xd310KEy3dLWm6+Cmk49YDO12ekqJNJACPXjr5UUrT9sRi+7JlsdWZIwJnRWuZcSfiswxbpyYy9TNZKE6Y9gFSiqrvt+mKvCl3Sa7W6QfB+97IZhX8DESwxNggte0a8I5pHSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HszavBPx+8Qacl651ZDK5kfzAuI8Djhxucem0DVUcM=;
 b=LMi0VZ2Xwr9zSI+A9JYm08I9WpR2GTeYW1Url20z2xENMKsa3c/3oc55HFuwaU7O1mrv1MmvSIRaj2DV1SWIIGTZeuUffpKBQ5iysGcncGMKvanIiRzR5X/jJWVtE6iw9Ty4fRABqfgcPKnpSpvKADMfj2QQ6qg6WsHEDJAXO62GZ9RG9aME+RMSfiV5orP4jFERJXbnoDLXaCHr5K9w09qUfuR4a6xJuZFRMAAoAYfNKS2iEolNTdlmHVCBEsA3ahFYAelwxCTmHvya80qonlt7iBcAz5Ymo56JcLbYu8JpCptRaLsykMmORnnDPaYS5aZT+b1lc1c2VJvWq6Flag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SA3PR03MB7302.namprd03.prod.outlook.com (2603:10b6:806:2f1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 07:21:22 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:21:22 +0000
Message-ID: <cb9d5481-ae1d-4c32-8178-39aff24bc371@altera.com>
Date: Tue, 1 Sep 2026 15:21:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: altera-msgdma: initialize state before
 requesting IRQ
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: sr@denx.de, vkoul@kernel.org, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260830053308.2190597-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@altera.com>
In-Reply-To: <20260830053308.2190597-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SA3PR03MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 2568d43c-dfe3-4942-27f4-08df07f9a01c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|55112099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	bacUICXUcnm9V8OhbkRb5VN53WWSGfWMyxRcg72QPTN6OLCBlA+4+rcC65vYApPJeRq5mQDIAVRQvCyoxuq5nh9TDzW9H4I8SwKm4mmaYHz/IjtaO/siMzkU+7Kz2ZTgW8H9J+DoT6s0DukyCPrXHjw/qKotGhuCZq5Q5lo4CfGTD43Ak8tEkCT1/EofkkFhgqm8JFjRrKKwrwzHV23lu1Ubm8wvLnV/mY6CtXhfhUYyTG7eCwWBqyN0AsZFC4qPS69wtGtGQvhBYlnqbfh2Q9FHYBrCgzEBecl1zzHHApItwvUYHPBt3dkkejwoTXxV+vtyYxjFfz4v+NFHxWOrj1gsh6pg8xxhHv3hG6clsezY+YZravlYMc24pBl+TM//Fk7b9ClPMM7D+MPRBD414lMTq1rQxbarCObsPsv0dmVfV5f7V+lyEOGXdnXtdqMFsMe17icwKgjaNfNnteJoLrVASJ3nv0ie4tyS9Unao+jvKF0GuYzsKul7rCoYdnKjBSQ6ULUDMkZi50wX5mteuhL9AGqMtcZ+VljOTPTZNupk2byog9C4HB2lBYOHt8Cp/UKjtnjHhBBHux4ilc0EpdvbhOP5X6Sp36eg2jAiay9csUJcgflBNuhpYfK7Cc4BDQVkjue5LWVU7BsTxr57cU9JOx8MEz/szGmp8s1gzok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(55112099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnFSVEZxMTlaQWI4ZHBydHlsSk9Vd0JCVEI5U2RObDd2bk56QnZsc0xwSFZ1?=
 =?utf-8?B?b3V5RGFscUtiN295a0dtK004ZVdvd0NmaCt4K2Fvd2hlbXBjM3ZWei9KZVEy?=
 =?utf-8?B?L1pvNlVlZ2FhNEs0MmFKYVF0aThydEVYT25QalVKR1B5Y0p1UFVENklLSldL?=
 =?utf-8?B?RWtGcU1WbVFkbWR4cHdLOE8zOW5JcnZzaVVoY0NPQmlzS3kvTEp3cWVIZnB1?=
 =?utf-8?B?ZTRYTGNjUForc0FadlNEZ0NVN3VORzVtdVRSS21GNEJmKzBXQk0rcGUzdHZZ?=
 =?utf-8?B?dzFWSGxBZjVJbWo2REdxdnRSa2RxUi8rR3Y1RHc1L0xlZm9TVTVhMGliK2pK?=
 =?utf-8?B?d0IyWjdXNys1VE56S2pUZFE3d1N3OE5Bck0rbDQzeDdRS05MVHVqK3VZRlY0?=
 =?utf-8?B?aWtEVkpuL0ZIVTBzNFRYWXhVTVRCQkc3WHFseFRFbjZzRmhEZ1Z0K1BOakRJ?=
 =?utf-8?B?eEVMVXN6ekVLQmZ3UGw3WGw1VlBvdElIeDZPVFVlME5oYktQS0hjUUpGeU1O?=
 =?utf-8?B?bG5rWFdmZjJKa2VYdWs4blFGM3FkbFM2YlBYUHZpMGIxTG16bUN1ZGVtdU1F?=
 =?utf-8?B?WXVjR2l4N2FNL1BPZ0t6SHY2QS9ULzQ5LzNjakg5a0V5aUV3SzZCOVBPcmY0?=
 =?utf-8?B?Z3hQeE9zMkd3VldRM0ZmZXl4Z0ZTbUZwMjlpM3p3TmF0SDFPVDRHNHhkeVZz?=
 =?utf-8?B?RkYyYU4vaVRNT2Y4bkNaaStJWEh4K1ZoVXJ2eXQrcHZiazRmL21scnUzZWZS?=
 =?utf-8?B?UE1LMUxLbE12MmpKQzJZbnZTSGhyU1I5bVJ4NVNIajF6UmxySHJjUmsvVVNq?=
 =?utf-8?B?RXhGclVEcUc0ekJUOWJBYyszRGhiRnlKc21xUmk5SnRDQkptWlVmWlNZeEU2?=
 =?utf-8?B?SEpvQUR3Z3d0cDEvMisxL3lXejdpNDdsbzNXVUhTV0g0ZVR5MVB3cmphNGxZ?=
 =?utf-8?B?T1hQaFJLbENNWjRIc1ZzY1N4UlRkNmNBOGpaU1BmTnk0cEEzWUhQeSsrY3p1?=
 =?utf-8?B?YmdsL1IvbS9ERkV3QXVUOXJYcmJjd05TaFA5SHdpaVZTWlRmbGFYalRKN2Mr?=
 =?utf-8?B?bmxobjFHcHh0c3l5VkM4UHN5VDkvaFVUaXdQTWxSaEovSk43eUVLV2liKzBi?=
 =?utf-8?B?QUIyRUVWUDE2bnN2V091MEM3Y3pxbkp2K29WbThaRlNtMVRuU3BQRFRwRHJn?=
 =?utf-8?B?ZG5xb1dRaTVFekVOT05XNXR4T05VVXVhRXBuK1hJZ1pOa1RyaXkwMVl4UDZN?=
 =?utf-8?B?QzVCSndvekkweDZmbE41OStFRjlzQndkNTB6K2pwVmhVbksrWkVsdTF2TjdT?=
 =?utf-8?B?OWxvNzRhOFRBTG50S1RkNmlhQU4xZHZ5c0tWdS9GTWFuNytDMXpPMnR0Q0V1?=
 =?utf-8?B?K2N2bzd4R0lNck1HeGZJd0RodTRNUnFMUDNWc3kyNThTdEY2T3NHTm16c1ZZ?=
 =?utf-8?B?d2dHbmxWb09wL3FTelJwN2VSL2hCTjJNTWNjclVwbzV6bHRxTi9MejBJRGRZ?=
 =?utf-8?B?cUZyTkZJT1FCV0ZKZ09oSWs2S2NIR1ZId2NwK3RLbDBvS0VJdWVXUlhBb1Aw?=
 =?utf-8?B?YWg0NmRxZDlNYnRCMEo3TVNwTVlNMDZLdUlUcWVNbU1LMUI2YUx5T0hzQTA2?=
 =?utf-8?B?VllpNGJUUGpHQ3F5blBPRUJZREt3c09mc1hQa0NMaUk0eDVUZUtQTE1hZWNK?=
 =?utf-8?B?MW5kbU1YY1pPMXlXR2pYaEV0MFVMeFpqdEFadHY4KzU5L0pTTWVYYUd2Nkxa?=
 =?utf-8?B?NzloM0RvdGVkMkdlVGpRVWMwdmVkckxzOFVqRVVlU3JqdTZFeGYyR2tyU2dW?=
 =?utf-8?B?aklzNi9qODVaK09KRW5tdFFXaTVzRm9IS3NhejV0UVRENUdJUnJ1dmtDVlc4?=
 =?utf-8?B?aG9uZUF0cUVNc0dDc2VDMDJFMkVEVm9ZTUhwa0VFOVQ5bjYzWTNRTmN5TElV?=
 =?utf-8?B?UGE3aHZNbk8zaE9tS2JoUWRVQnhpbGlFSVl5YncwY3hwRGo5aXlVUGNnMkFm?=
 =?utf-8?B?QkF4aUdzekRjcDRSZm9KUU5Ea0E3UHAybmh2bXN0cmVySVlCVUxDcmg2d0ti?=
 =?utf-8?B?RTBZUy81YnVCdmFpd3JjVTZBQlJpMW16OVFCRHhYNGxEaDJaaGlhTmVLbkw2?=
 =?utf-8?B?SlROZnZFL2tod3plVWs0ZzBPbW1HUjZadmlrcSs5Qk1iRzEwTUZXWHhTUUtW?=
 =?utf-8?B?czRUOTRFU0lLVy9pY3FpbkN1YStzdkM3QnppdUdJM0gxRGEvdTU3cDdMbUNw?=
 =?utf-8?B?alF3RnBQZjhPY25vVWZvQnRXaVA5MFRIcVNPOW00VWdQbVlXOXo3c0hvQVdL?=
 =?utf-8?B?YkVEWWdvUWlXUnB4NDkyYjU4MmZCekNyVjhQdHRuZkp5UitXVjRsL1pyeVVC?=
 =?utf-8?Q?y/FfHrFRNeb9xsrw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2568d43c-dfe3-4942-27f4-08df07f9a01c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:21:22.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UENGqL8471Yy1+1Wib+lOLzAvFD6acTLuDoxj83GBhLxelIf5j8xYpgPejqtrrp4VM4BSWjbTLwW1B27plL+UrrvFHohAFq1xG9Owp0Cfbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7302

On 8/30/2026 1:33 PM, Runyu Xiao wrote:
> msgdma_probe() registers the IRQ before initializing the tasklet, lock,
> and descriptor lists used by the interrupt handler. A pending interrupt
> can access incomplete state during probe.
> 
> Initialize the handler state before requesting the IRQ so the interrupt
> path observes ready software state.
> 
> Fixes: a85c6f1b2921 ("dmaengine: Add driver for Altera / Intel mSGDMA IP core")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---

Acked-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>

>   drivers/dma/altera-msgdma.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index e23e5b441..412f4bce1 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -847,11 +847,6 @@ static int msgdma_probe(struct platform_device *pdev)
>   	if (mdev->irq < 0)
>   		return -ENXIO;
>   
> -	ret = devm_request_irq(&pdev->dev, mdev->irq, msgdma_irq_handler,
> -			       0, dev_name(&pdev->dev), mdev);
> -	if (ret)
> -		return ret;
> -
>   	tasklet_setup(&mdev->irq_tasklet, msgdma_tasklet);
>   
>   	dma_cookie_init(&mdev->dmachan);
> @@ -863,6 +858,11 @@ static int msgdma_probe(struct platform_device *pdev)
>   	INIT_LIST_HEAD(&mdev->done_list);
>   	INIT_LIST_HEAD(&mdev->free_list);
>   
> +	ret = devm_request_irq(&pdev->dev, mdev->irq, msgdma_irq_handler,
> +			       0, dev_name(&pdev->dev), mdev);
> +	if (ret)
> +		return ret;
> +
>   	dma_dev = &mdev->dmadev;
>   
>   	/* Set DMA capabilities */

