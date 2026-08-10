Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DB424D65;
	Mon, 10 Aug 2026 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384669; cv=fail; b=YpSaVWTk1LJYHUDFy6AeciHkV7U0ViZ5MrpCKgW1H5M3YDKVkuwt2O7AAuVKtrgOvhyG+W1s71+7YKHl1vVh/mgLOI4DtjALTcO+YslJ3kJ+Wn13KXDVShUIKg0MVGQhSXTLm1jB2x6LUhCDmZGJYHbbHqxVOpLCmr9vHkEXEHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384669; c=relaxed/simple;
	bh=c/G+q385OihNTKJ3bnT4x/+93lcfZxZbw9KiA9qM8pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DggxDSEMWSaobWR07o03KvDSo5FwMccK4D7t9cQ/cHAVtyHdMNz4sZFYpOth8eUqCicfX3/b22M0N596GbPVyvVtwT/XruXoXgXlyLbggvGaaPuitFQwa7iZnUzuzD2Gpk8dzehP5BUgPOXA0TU3HPKCnk9li+cUA/gzhbhXz6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P786aoyr; arc=fail smtp.client-ip=52.101.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P786aoyr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9ufiosEMkxGaU/N4+j4GS4aRM1UBHA20uo38KBbAdyLYckyROwNIItqw/jzugxw6s0ApWxd0tDGF7eekSiW9EYmqwt1oukoaefvJVh7gyC36riYKVZOX921MWmjhQ5m1OX22bEqajVJOHpH+XLsKmmtkBSlOtAjUoSre5m7FpK78pnioFHC40ANjfO1L9lmA8KUxC/6H36W0CpseyLEOQBQOrXbfryZoXppNENM0+HttOwfS1fSsa6wBTFFd9yVrsS1Y6mxfSi+oKaLMCrhXGsjGb3aimiS60Yni3epqSc+2teHRIyLnKD4cVbecZsU6+HeBNfkpx6u8DNGtwTfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/afb+A2CtRjf+Ws9HWmqYtGf9M28gh7tqPMJRjtszRI=;
 b=yxwAMhq0vgWm3GnO+D8ZGjtIxwWelC7lurxm9C5MBZJc0M0hRdB94tDiHI6RWmjc8Q4t8EafLh/ZOOxLcAPXfm/Vm3EV1UwMK9AZZ8V3dq35whMSmnvKY6xaNIaeAxnvqmfJrjtGbJ6ttJjMb3eQNCPW5nRUCZvz/+yRF6VNQH/Vy32uJZ30F3uQvWz0irEm22TIi9xj8wmX30oNUJ6V6Ivu4gkkT9CHKXCmxoDRlSUKHYC2zT+sD8a/XCexrekOQUxRb12aCjy6Z8f8g3xKeFeicnzXU428yepJxcevPNVVOhUFpq9RlKzpMDdi3N13tEDPMxAx8dognHP8Efa1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/afb+A2CtRjf+Ws9HWmqYtGf9M28gh7tqPMJRjtszRI=;
 b=P786aoyrEC3py8bmgg+YL3DbImpmeRWrX1hORPcvCtElfAoBE9DXeJez7nENvmot41ZXTF0I4gRaSt8ucT4lIcVE7Jqp60LQYCM0xmn23tjd19DLIvFeNn8mB6J+ftSJGKCuHCRuxAsRxAmYnXa7Bf58ey67CHX0VIJLhm97D7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) by
 DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 17:57:44 +0000
Received: from DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f]) by DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 17:57:44 +0000
Message-ID: <c87bd58e-2c23-467e-8ae2-8398052ee8d5@amd.com>
Date: Mon, 10 Aug 2026 23:27:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: free IRQ before cancelling the
 unmask worker on unbind
To: Fan Wu <fanwu01@zju.edu.cn>, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, michal.simek@amd.com,
 conall.ogriofa@amd.com, bgolaszewski@baylibre.com,
 DileepKumar.Nagavarapu@amd.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260803080343.467906-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <20260803080343.467906-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::8) To DS0PR12MB9060.namprd12.prod.outlook.com
 (2603:10b6:8:c4::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9060:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c53c685-17e4-4b0c-8a49-08def708e131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fsu1b/jmXi99ZrkU9tb7Lc5UARRxY5LxaTgf6USLwjMDgzLgntWCfoceljtNzgAMY96Jxdqc3JxMfM3KozrdiCgWe2qN6ZiETdnd9/cBzz1QJAga1fbZifTzFxa1IRKX03/avC4M7nybAFkt+VcUGqTYW17kL0bLILRjI/OCaoqB2vAl+0IESLGL6IVQ6/Et0dxt4xEG/E21wRgPAWKWQc3cC9Q7gjH+rMh5gvrpx7j2Z9Utr0Gb6Zid3zU1fJly9ut4lsIAx7salmAKhA2/8fztxV8/BeWbScohHA0WtzuXlUtuIZH3h8SsEp8rNOooLr5UWihY2RCG81o4YfbPUVybBJ4V4+6wWoSyH7qiH0JgBnKcuEUKhHq6VyqxfQp7WOGE6fC/tx5bVar1UI5buqbcveSOI38hKk/gFcARpL1lROxgxnFpUiLdt3Ot/zrNICdV06MkAjWM9l7eVBZgMjeiQCRUYMtsHg0QMVhVdZM74OBrOM6hlv8Bv6PBaaESccVdh1Nit7DTQCSK2McJ8I+GP+kG3ohohRJRTpqR0B5cMAjtdh/MaMhleZ0H6EmM/kSjZ9+DyJCsKBaH/wa044517IWWXgFMq+DQGp0Sca5H7PoH6qDk619NuwmfBXv5LLWqaRQo3cRM6vVwAfSNgYmC34cwB1ZB0Yzr3KPn0JY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9060.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWhhNlNwUmlnS1ZBSnBPZEo4R0ZhL0dJeVg2SVpwalVFZW1vRUZxYWU1bjBv?=
 =?utf-8?B?ak9ITTIvY1R2NGNEZ1JKZjJOOGQzdXZicGFxRWdFNkM1YXRqbWhOTFRNc3dN?=
 =?utf-8?B?TlNKZ1d5dktQMDNXS3NoTkRRTnFlREZ1WEhhMkJidWFiQkt4Yk55MnNPS3cz?=
 =?utf-8?B?ZGVqRTN4SHNmMkhKR1ZhNjVXcVdoMWJGdWJJSkptdUU2NWtiTkR2UzMvZ2x2?=
 =?utf-8?B?RWxKMkMwUUFTNHQvVlcybXBuWDlGZ2ZvRGFmNk9ITURYaWxqdGdWMFdSTkht?=
 =?utf-8?B?OTVLT0ticktZblNXZ1dqa0p1Q3gwT1IzcU84MjQ5NXltQmQvZUwydHl6SnVL?=
 =?utf-8?B?RmI2eHFtc04vcHNHWG43dnRQM29ZQ1o2dUtjNzh3QTdjci9hQ1EvNEJzN2o3?=
 =?utf-8?B?VE1BZDUzMjE5T3ZHUTV6ZFczOWlKWWhlbm04MnJYYVRmVzNMQStxdWk0Vng4?=
 =?utf-8?B?T3F4VTZBUHZEazFkWFA1RDBnbkpQNzM4RC9UK2V2cjI2cVF5RHpIMktKL1ll?=
 =?utf-8?B?aC8rRUgvdTQvRlpaeTJmN2ZNUC9PZE9ZZkxqcHdIWHN6d25rTDdNbFRHNTlR?=
 =?utf-8?B?dmVXamNNNm5KZFZ2RVRGdWl5bjVmQ1V3Y3RrMHUveXJjZTlTWHBZb01pZnJV?=
 =?utf-8?B?dFRRNUdML3YwN2dxVjhEUC93ajBUZW1BcERSRW9zc3ludHQxTUpvZ2p6NGgv?=
 =?utf-8?B?QjlFdDM0cnBYekxpcUNhdEVvV0tudE5oU0IrRjliR1gwZm12MlFrYmxkdWcx?=
 =?utf-8?B?RUdjcndWaExTNm9CM2tHb0FjS09CbHc0NWRaSXJ2aGVhR1RHdWpzb05vR0p3?=
 =?utf-8?B?N0hTcEJDR0grcGNrTUIwZG0rY1ppZnNMbjF3K0dUTVlHd1Y0UG9LNWlaNGJE?=
 =?utf-8?B?Rm9hSHlYWWZVbkU0Nk9GM0tkWGpMOStOaFY4dFBHd3N6VDdyUVdGMFRXUERa?=
 =?utf-8?B?ckE1WUxrMXZXWDVTT09SNDE4R1ZnaEdkNzcwcFExM21xMkttb01wM2NvNDFH?=
 =?utf-8?B?dmdZVEZrZ05BVFJQZU9aa01jY05hcHZnTFBrZDQ2ZUtLWXo2UUZoWHg3dFY4?=
 =?utf-8?B?dkRFTG9qaVJUeE5CUkNmRytFbTdPdEQ3WlV1NXpZdDhpcFZmUUVJZ0FwZ1N1?=
 =?utf-8?B?ZEwwMUhJcTJKUkxBbGZXOFE4dlowOG10bGVRQzFhZHJEOW9iZzBwL3lLS0lZ?=
 =?utf-8?B?TmtkYlg0OTFNWC9YVHdOMXZqdDhPdER1REtVTkJoM0xOTFJiaDVlci85YjFZ?=
 =?utf-8?B?TFFMNmY5Y1pzT2dBQ1krQU5seldGSDQrR29seUJWRWk0RkFwTk5oQkRycmh2?=
 =?utf-8?B?TFVhMURua1lIV3lMNENxcHlkWTFoWjhDVVFhN0IzcVplL2I1bVcxQi80TUJp?=
 =?utf-8?B?bmd3Y0hWMVpDTk9sY1I5K2FyaURKQWFJTHhXcitrT1NWYWNkMEhsSzN0WCtM?=
 =?utf-8?B?blI2b3VmNFlZRVMyR1pEWUZ2aFRuUzRHWVBudTJKK2tMNzJkSzJjR0ppVE50?=
 =?utf-8?B?MFZYTURWUXQrWUw0LzVaMXF3bXZ1U1g0NTF3RDRMS2hkQW5MNGlleE9aSXh4?=
 =?utf-8?B?dlJFb0hJdE5EV0FxNVlCalU5d1M1U1hmTFVrUmgwS3dnejB6U2VNUDQ0MXlS?=
 =?utf-8?B?aHdMSlN4aVcxUG1qK1FsUCtVblJsL3dYZWxHdVAydUwyMWVHclR6NUExMzBP?=
 =?utf-8?B?dW9WWFU5Zi9rRTZaaGtVNVltSVF5akFXQVhGekwyREQ5L0Z3WEtGY3lYN3pi?=
 =?utf-8?B?VnlXTTBzdDA3WmJtN2pjcGlGWlFGajV1emRGL2xrWnF1R2RpRGJXSjhIQmFn?=
 =?utf-8?B?bE9XWElHZmtzUXhaU2crR2pnL09PSFQxSjlMUkZSeWFRbk1RL2Y0UDJ1enZQ?=
 =?utf-8?B?eUpia014ekNQVTV3OXJLb2lCdUxWVUd5emNyaFpLMithNDVIM3dWUzFiZW1a?=
 =?utf-8?B?eVNjUVozUGdRcFgrRkphNFd2Q3lGVWFrdFpNMlFLaHA4UzIwRlptS3J2Y0wx?=
 =?utf-8?B?d0wrSFpxd21EMWV2REV5ZnNFbmgxVDlTZGJlWW9SNTFsekcrS3BVRHlpdUhp?=
 =?utf-8?B?TGpWM240QUYvNndGRXE5S3pCZjRlUThGclppb2J6cnUwRGdtMFVGN2RZcE05?=
 =?utf-8?B?Rms3SzBjdW5FZ2tQbWpwZUtEZ21GbE0zWkpsN0VGUkdvelZUSjRoN1AvUkJi?=
 =?utf-8?B?aitCNGVaUFhuVngrVDA4SlBqWThvc213UWdSUmxhcU40aFZSK01qZmQ4d1Vj?=
 =?utf-8?B?MHF2dGt2NFoybGxmYWp4cFZaa1BEOExVeGkxTlNzVG4zQ0RUdGpxYjJnblND?=
 =?utf-8?B?bEVDckxQTGl2YXlFK1dQUUNyZGZuZHg1M2NnbFVhOHpudUNQWWlrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c53c685-17e4-4b0c-8a49-08def708e131
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9060.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 17:57:44.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8Sv3NUxKX8scO+cK92MS7pkh3Iprd+I2N2X5l0ekNIhVl9R/+iwRCyClu+3qP4opTyZuIRxTyUzBREmuqLEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234



On 8/3/2026 1:33 PM, Fan Wu wrote:
> The ZYNQ XADC alarm IRQ handler queues zynq_unmask_work via
> schedule_delayed_work(); that work is cleared by a devm callback.
> Register the devm callback before devm_request_irq() so the devres LIFO
> teardown frees the IRQ first, ensuring the handler can no longer queue
> work by the time the workqueue is cleared. Otherwise the handler could
> re-arm the work and run it after the xadc structure has been freed.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Regards
Sai Krishna


> ---
> 
> Changes in v2: shorten the commit message and replace the multi-line code
> comment with a one-line note, per review feedback from Jonathan Cameron.
> The devm registration reorder (the fix) is unchanged; David Lechner's
> Reviewed-by was obtained on v1.
> 
>   drivers/iio/adc/xilinx-xadc-core.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1395,13 +1395,14 @@ static int xadc_probe(struct platform_device *pdev)
>   	}
> 
>   	if (irq > 0) {
> -		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> -				       0, dev_name(dev), indio_dev);
> +		/* Clear out any work queued by the interrupt */
> +		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> +					       &xadc->zynq_unmask_work);
>   		if (ret)
>   			return ret;
> 
> -		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> -					       &xadc->zynq_unmask_work);
> +		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> +				       0, dev_name(dev), indio_dev);
>   		if (ret)
>   			return ret;
>   	}
> --
> 2.43.0

