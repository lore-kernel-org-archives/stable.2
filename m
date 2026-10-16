Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308A4C9E01;
	Fri, 16 Oct 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166683; cv=fail; b=bebIGLhtzNwZYVck983/a1lPGccRtvH/z56kFSQsabvXSkS73zEPUawVpNTrSpGnEXclx/rW0wlbLm/3cTxBcr9MCF/H9fxkzs8RsrRYhBDRWTnpcV5ba6FZ4BJTd0uuG4BgzwWpSY8O49ppQCPbt02nBdQ/1bcOD5/dIf/dDr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166683; c=relaxed/simple;
	bh=GzPHT9Q7o+HmObk7oEKhA3Nnu+HQcqV5cnX2ANhIlc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kgLAfcO7yKic6aFEWh88saxULxnDDNbql7frdR1ztryZvpC0J8jeA0zI+Bqb9aPZdq0sWqHb7luZkGyWomW14zjr+UAFyLLGkjkrYC5hU2Rk414VSKkwxRs+niGfupGLQFFr+1vAyFvQCQT9Wvmgljxm7kaa5xLc9klGFtPzEt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=c2tSKSpH; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c2tSKSpH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rkgt1FQJP5zIoLlw63NkOW5vlViCN8MXMoF41g8ecqBrqpk144dwc4erl9KtjZTnIHefgHNkmyrwTnecgrybo2xK1K+9q+mYr6VPFH8M0/Xe/6GTpW1rZ1A+6KwvZeU4gX3hiZ/EeTswD5Yz3dK212RGtx9TYD1z0FAk2veSteqcwOQZHK9M6Y67gG2/R94zbKBFiSI0KSAVFK2cF36HUrXE7Lb68XeOTONpuD7Y6qatmxOj+Mnz+IH4i9mw9/YpplZs0pjhKTGETNZSu5DPVWTagph0xVsjtO3f+nHeUSJCL5tQX8F8U3Qaid/cNhZ2Jw/8K6luk9l3Motqa23LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1eyCFXols6Jomq+8A8uDl2xy683p+ht7E/iZywsbgc=;
 b=FvTCuvSC9qTXtqmC7TXpbUkz1ILTolxdPSbClrhUGEHlKJm5eBXHfV901lSQXZ0ClnrgRP/GUpgNf6PeCw7A6zHiU8/QP5UQPL9ERZYpk5jrsRZrV+LP1TBq4/vkeAMY8iETGg8/W4392tAEeKBxW/kMwzROMRuOK9hYux6luSQZf5X5YJeOSf0BLcIOoCkytzMs1m8ZePfBaPAUeEH7c5Q7hB59gXWz6iVcwWyI5ixkwoodegCv+T/bof2M8ZhPSKuJ80txn+4Mx8kYdaKhT0ZGKxTEcsqpzl07V9teduNZQLIjqgW2tY4Anx6F/VkqyVKOHnIU5IhiYzcDqKga4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1eyCFXols6Jomq+8A8uDl2xy683p+ht7E/iZywsbgc=;
 b=c2tSKSpH4pWXHni1EraZkBKtCNI1ClwUbasAtutyrgSjH5t91SrGv4PrTLeLW+OWzOiRtsBb0QGUMCEzV0C7KL+MLsdgURtH5Nc8j6djDNaF6UeCNMHA+aP2aZutGQ+CwBgSTDNwGHKLk3VVB4xzHzZd9AZ702+S45Xula9+GT7NmYqEGz5U10Yu4hgMNMtnoUc3sTght7yxxNh/K+RPczHl9vmFB3S4PHotAlqV3fz8gmkKWhMWd49PYlcDt+hsffb+Yvq15g9aLCaFbCunHimkfb5YeWUrE7HhI967eO9JzNGieYq4Nx8qqcb6YRmVXlLRnnRCBzpoldV0kqqI/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11795.eurprd04.prod.outlook.com (2603:10a6:150:2df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 16:04:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:04:36 +0000
Date: Fri, 16 Oct 2026 12:04:27 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, arnd@arndb.de,
	jonas.jensen@gmail.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: moxart: Fix use-after-free by proper
 tasklet cleanup
Message-ID: <atJLCxizjBLSSjPV@lizhi-Precision-Tower-5810>
References: <20260714033046.673677-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714033046.673677-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11795:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dbac85-ae45-4051-8d42-08df2b9f2cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YNwMhHvyHTW306ZZGQfMafR4+bVAXN+QLWkaDo2MXtnNFZe5VLvAfWu+HAjpBIn0mAsKbZRa5Mw1KfAGPghhlQ+9bXJBwDQBuq8BGmda6dkklkTC9lk5oYTc9nGXiARbgTp8njRf1KJ8eCqsuQ2DM+jW2qU7eMH7tcmgMQoGBWKliQeNau9I57XVrCX3ce2OS1Cc5lFSGzUlfbsJiy0elkXtWv00HvEjBx1ncRo7vlYBpRJaNOXngBcvyihWc8XxxgiJn1WujnPm5BE28yZldyqkVRHQbMFK0oKs09YQGigZrRgtBcvW9blvSkvrdNtfwZV17JY9VfacIcrM5r8OoNTjK+wA1n/oW9vlO1p4q9P4IkgQkp1zv90lpVhhFrwfQFv2jwhXCSeHaOq7l0bODOJXiDdnSl2cgUySD/zLlTzPGFF8M8P/Is+TJLi1ABziEtJVAcUU3wuWXH4R3V/7KfHKkA628/8kq1cirORqLsVqLf/1VplDMPwWJi7rFAHe5N+lMMBmaQeHW/yefoz2TM4fQfGmrqcuPYRjrLh3nNr/3hsYf4BLJvNGLGZQuTvSk8jlrws+90X6zVFJDlNKL2eseDYWGo9G9CSWNNJgTQbOfSm4nZQX8aSE1Qaj6apbIWrrIw+3c62k6wCFj09RfeywtOckD24AW9jaOQ8oBQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REEvMjNyem5lWk01ZnIxMmM0TW1aYVp6YS84VE9mMzdaQVhBVXpkYjVzbVBa?=
 =?utf-8?B?dG5lZC9uTXFyWHFEaC9nVjExU3gwM3dpZHNHM3ArN295YkJyMU9HZE55UG9I?=
 =?utf-8?B?TmVHZGQzZXlyTjNnVFNic3YwYW16WnNXYkViZXdJaFdsNnhRNnNjczN2UmpL?=
 =?utf-8?B?QU9aTG05WTdXaTZzZk0zdmNKUGlJYUR5YjUzNzdFYUYwaS9lN0RxZ0txWGNs?=
 =?utf-8?B?cnBqRnNlQWt5YlR6R2N6YWJYL3Q2a1FVcGRod1JhVVVweUNFYjNSMCtXRGlB?=
 =?utf-8?B?ZFFGeXd0MGwrQkZxUzlML1VVdk5Bd1pqcFRNVjJhcGdxVHlGa25FaFhXOEhE?=
 =?utf-8?B?d091U0lCdm40bHdLRUNDQy9EbFBsN1dkdHVtMUxWdGNRVHhKSVZiczlwOHlJ?=
 =?utf-8?B?b1N3Rk41cStrNWNPTyt4S0laVDZRZWh1aEhRYzdCSk02TDFIYnNsaklESzRs?=
 =?utf-8?B?UW16Zkt3Vmt2NGJoWE50bURja0lOb1RTRWNLOC9WU2RkaHZpWTZBT2o2RXpK?=
 =?utf-8?B?S1UxN05wUGtIUUxqeGZLRVBSMjBIWlJUMlpnK0lFMmVzTEVnOEIyL0JORXp3?=
 =?utf-8?B?aTJTVWxuQ0dldGdXbE51d2F6TTdSd2Yva3BWVmdrc2x2TnR4cUlwQjd2eUs1?=
 =?utf-8?B?NmpxS0VuMVNpZjg3WWQ1RjlvL0hHMnZFeTUzaGlQem8yZ1N6UGZPZE1KQnA0?=
 =?utf-8?B?TWRZQ3pjcjRSQ3lYOUZnTVZiOVBmYzN6S2ZTbnBDUWpUbUgrMU1BN3gxMU1v?=
 =?utf-8?B?MVd1a1ZGV0JseXlWVFpiMmoyaCtIV21uSW5UMmlJV0VBcHVhNms1WXJ6cXdC?=
 =?utf-8?B?aDMvTDZrUVBwdmsyVmNHWUZMRmNuMmEvS1ZsQ2t5OTQ2N1l0V2F1YWlsTk1S?=
 =?utf-8?B?RjIzUEJmYTQyRHI1cU9DQWdUUElnVEs3V1ZWQ0lDM3l1NW1WQ1dKenpDSUZ5?=
 =?utf-8?B?dTFNRkMxa241MkFrVHVWSTRxRG1TMVBXOHFhUW1NVC9peXUybEk5MUhQR21S?=
 =?utf-8?B?MU9tR1FHcGRITFpGVFYrbUUybDZ0a3B3dVo5KytnWVhQWERwbzF0YjBJMUFU?=
 =?utf-8?B?YitJZG91Q05kOENGM0IzQmxvNFQxR0dIOGMzS0J5Zm1xVG5OMlNMamU5Qzl6?=
 =?utf-8?B?R0gyMWxBSitEbVNZc1QwamJ0RERhK2JCSlBXL1hFVFZGVnllUE5QcDN6eFNW?=
 =?utf-8?B?YTlITS9LbnVqc2k5K0NHVWdTZU40Skwyc2VZTVIvVVllOERKdzlRQ3NMdkFv?=
 =?utf-8?B?cWZWSXQ5ZXlIWktJTFJJc1UxZ1hkZFNXQ0dTN3gvR1U5RGxkN09pQ0kzR2lG?=
 =?utf-8?B?VEhERzBpSDN2V2Q4cmt0ajlpWmJsQmJvVHpmTHc4MGZzeE9pZlhTTURwMlV1?=
 =?utf-8?B?MytIQnBxQlYwUTUyaEZnaWxHKy83MjJKempqZDQvUlJkVE1CSzlQTTRBRHQ1?=
 =?utf-8?B?eXBqSStvblRxbFpvcW1wcnltQUJKdkMwSTFhSnlacHN0TnNQcFNzaFRBWUVm?=
 =?utf-8?B?SzdveDNNd1NIa1ZMNlRVTGZTdVdKZkFienBYQWFxckh6Zk05SXVvcnVNWDl2?=
 =?utf-8?B?WEVIMzAyNEhuL2hTUENIeDNJcUErSUxKQTY3cFVnREJhK3d4NTlUcERxdm90?=
 =?utf-8?B?SFI1ZlRlTWdtVHJlYzQ2NzhQYWYrdEplYWowbmR3WGRxZmhSbnlmc25zc2VY?=
 =?utf-8?B?ZFpZVDR3RGZJK1NRMEMwd3MzNEovYThQT3M1SGtMTXRlc3dNK1NhMGlBbEZJ?=
 =?utf-8?B?bHNSdjJiN3NWN0pvemxodWNtdjc2QjRmUWNBajk5dDdaUHRTeTlLLzlSLzRC?=
 =?utf-8?B?S1pxTmV0dFhUeFpaamUzYWRtaUxpRXNMUWt4TG1xRDZ6aFFHSU1RZkR1N2Zz?=
 =?utf-8?B?UUZmNitBaHZ1NnFOanJpTTdkK0xMSU1veG9RM3l6QXBQcE9rQ0NIOTZBc251?=
 =?utf-8?B?aW9jemRGNElCbzJVWk41ZGUxMlBYTWtWVDh4YzBURmthUE1teWFWZElwU0Z3?=
 =?utf-8?B?RXN4ZHUrdUtkbGJYVkUvUDU4S2ZPcjNlZm1VM3pET2wwQ1h5TTBpV1grcm1w?=
 =?utf-8?B?elFhTUZGTWR6aGJ4S3ZiaUQrZTRwSHFnVUp2TFpZbnJidVB5R1hDcjFObTRr?=
 =?utf-8?B?dXBoZitKZ2JIUG5yQnFiMTEzMlNaRUo1SkhrTnBrMWVpVjBSaWNiMStvUjMr?=
 =?utf-8?B?Y3FNOEsxZmpyTUlVSjFlR3JmSWZKenJsZHphZGc3S3pTQnFNV0dBbTRSdUpP?=
 =?utf-8?B?ZTY1VFN1WWt4ajBLY3BLNENQQVg0S1d0YXF4aTNYNSttdTB6ck5ON2Y4YzVp?=
 =?utf-8?B?RXBnUnZ1RE9wMExSWkErbml3N1RSaTIyV05xMlNYRy9pVnJFYm1RYWtIcGhz?=
 =?utf-8?Q?N3gBuMg1QfR8PxJRCUPUUbJ660rYntprPGybp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dbac85-ae45-4051-8d42-08df2b9f2cc9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:04:36.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68HRM0XrfywsKSf0CegYrLYJNOlJa/MGrZXcm6AItkDhTSeEFrwr37N1QXTdPx8wPH3eTnknEFl7a/I8WKcWG2cDkCrgCS/ta+8HJMnk3Y2OlTvY02AeTd4djvuyAyLB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11795

On Tue, Jul 14, 2026 at 11:30:46AM +0800, Hongling Zeng wrote:
> The moxart DMA driver has a use-after-free vulnerability:
> - vchan_init() creates tasklets that access moxart_chan memory
> - Neither probe error paths nor remove() call tasklet_kill()
> - devm_free_irq() only waits for IRQ handler, NOT tasklets
> - mdc is devm-managed and freed after probe/remove
> - Running tasklets accessing freed memory → Use-After-Free!
>
> Fix by adding moxart_dma_free_channels() helper that calls
> tasklet_kill() for each channel, and ensuring proper teardown order:
>
> In remove():
> - devm_free_irq() FIRST to stop the IRQ handler (implies
>   synchronize_irq(), preventing new tasklets from being scheduled)
> - moxart_dma_free_channels() to kill already-scheduled tasklets
> - Then of_dma_controller_free() and dma_async_device_unregister()
>   to safely unregister the device
>
> In probe error path:
> - moxart_dma_free_channels() to kill tasklets created by vchan_init()
> - devm_request_irq() is automatically released by devres, so no
>   explicit devm_free_irq() is needed
>
> Fixes: 5f9e685a0d46 ("dmaengine: Add MOXA ART DMA engine driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>
> ---
>  Change in v2:
>  - The DMA core's dma_async_device_unregister() handles all channel
>    cleanup including sysfs entries, IDA tags, and per-cpu memory, so
>    we don't call list_del() on the channel nodes.
> ---
>  drivers/dma/moxart-dma.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> index 442f5aa16031..a2481960e870 100644
> --- a/drivers/dma/moxart-dma.c
> +++ b/drivers/dma/moxart-dma.c
> @@ -553,6 +553,21 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>
> +static void moxart_dma_free_channels(struct moxart_dmadev *mdc)
> +{
> +	struct moxart_chan *ch;
> +	int i;
> +
> +	for (i = 0; i < APB_DMA_MAX_CHANNEL; i++) {
> +		ch = &mdc->slave_chans[i];
> +		/*
> +		 * Wait for any scheduled tasklet to complete before channel
> +		 * memory is freed by devres.
> +		 */
> +		tasklet_kill(&ch->vc.task);
> +	}
> +}
> +
>  static int moxart_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -609,19 +624,23 @@ static int moxart_probe(struct platform_device *pdev)
>  	ret = dma_async_device_register(&mdc->dma_slave);
>  	if (ret) {
>  		dev_err(dev, "dma_async_device_register failed\n");
> -		return ret;
> +		goto err_dma_register;
>  	}
>
>  	ret = of_dma_controller_register(node, moxart_of_xlate, mdc);
>  	if (ret) {
>  		dev_err(dev, "of_dma_controller_register failed\n");
>  		dma_async_device_unregister(&mdc->dma_slave);
> -		return ret;
> +		goto err_dma_register;
>  	}
>
>  	dev_dbg(dev, "%s: IRQ=%u\n", __func__, irq);
>
>  	return 0;
> +
> +err_dma_register:
> +	moxart_dma_free_channels(mdc);
> +	return ret;
>  }
>
>  static void moxart_remove(struct platform_device *pdev)
> @@ -630,10 +649,12 @@ static void moxart_remove(struct platform_device *pdev)
>
>  	devm_free_irq(&pdev->dev, m->irq, m);
>
> -	dma_async_device_unregister(&m->dma_slave);
> +	moxart_dma_free_channels(m);
>
>  	if (pdev->dev.of_node)
>  		of_dma_controller_free(pdev->dev.of_node);
> +
> +	dma_async_device_unregister(&m->dma_slave);

Please use  dmaenginem_async_device_register() to fix this problem

Frank

>  }
>
>  static const struct of_device_id moxart_dma_match[] = {
> --
> 2.25.1
>
