Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA6379C23;
	Wed, 16 Sep 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570851; cv=fail; b=IJ9V2MxE/vH3Gixyx1P5VACNdEFwVGLEsEW76Cr8BstxhFjFu3wcSmXKwzaJle5DftFBH2jiVJWj2TnXQ+g12AOCobUEk1TmUDcUlc1rEhWxGrbYwaZGRAbv7gXuV2Rk/d7p0MZHxajmT3s19RhOjcLtknwJ0nYB8MEnMT/gde4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570851; c=relaxed/simple;
	bh=irKh1828CDRRJgIlI1UuNkMlOYommyXEuljy0hceALw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dbffdmQ0K3KPiE39DxQU0cvQxJi41Mwd/bREsZEbzxcUDh+TZGdPfUhy4xCARU7eA7szbSqHspZBMFtspevRIP1GpeiItIEAAM2xPYmxXRO1WdG8FYNnrZsvSKVBcgN+XfBtoCwbnHOzCS9uFWvc5WNmEcfjC3hbb8ysPnBdspw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KLwly7pB; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KLwly7pB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRwzTkAfysXpELiFleuZ1pAopXo6woWs7NfGiIE/iTYFnDpcE71KqyAEu4IGEiQw1YV0g1OSfsGpOd4qcAp5R6gClxxqPbfJIVq2iT96YX+V5cJgFe83cosh5zDux5Sfgt5+VlG+rgLfyVlkpVAhtn0uwiieTI0kBnGWAjnFlWHTrMlUbgzpsiCrza2+NR8EHLAmhRY8eTtjNZgi/wnKzb6sDxFKcUV+u++5Kd4KIQazmRnxSGY/r5e5aoE5cD4RsJqAUvpDNEH98NN97SBMyv1azv7GGuB8RQ8HIGr56iaSJPAbJxFNtnGae709pOVY75xLtY8Rle45OV4vFuXlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqnlhcwA/ifMvtxDgGi9Hau9pzHZyZ5/IBeNngD0ajU=;
 b=Fso5gPKVLK+sP7hB0C+mTX7pifB6S9cyPCUb1jPFhtmy6PKg30N9S5pmavmuUUUJK7HkodEGULtqaSHyRJ+zr8wTCcW19kFRIx2uVx+UTCVIbM4gP34zwnjOMNBS/SGcQ2CK+OcbZfFYITznq6C3+y6Ebt/yIcB28jLSU2TgJECGWp09bOjgNAXPzde5Tjza/+YPSy3HB//Sr4V9ro0AaLjePPMr0jaWm4dBAV4EVplDxWsErqih0C+oUnpknobEg71EpSEmpf9GeCHUGu8SOKh9biH0wwFIndbumuny/FsdjQhFQmFAJwwEqQlpv3eShJlWlZDdP9QlKlXSYaAcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqnlhcwA/ifMvtxDgGi9Hau9pzHZyZ5/IBeNngD0ajU=;
 b=KLwly7pBjOO+1SJPgPnFHeotHueIZ4rdpqck3fg6Blo1BMt4WTQ7jnVeq/BbcdHdCsvXX4GQEuEpeANj+6+UEkw+32GglR7bd5WCE8ZkeMi/BqaVc0u2MDc88vuHZ9XOpHCwEMxozWvJCxdHZLRpG3yMmTZ5dopoyC5UFhsN8mkPWPpMKCSYiDHHeV5K1Pq2E+ZjvExeE5mgfyQJ7dDt0LhKRI167wNjd+M5b87q6kHL0pLOv9Ht+1Y6xqrhYeSUmwgjtpHyZVX8d9PhcwKXKHgpdKjS2saYb6hhrtG5IrJ7KwTvPq/h1BQZTUVe1FrBG1nKtvh32CG6j8qNmEiSxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:00:45 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::736a:e1be:ec64:5740]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::736a:e1be:ec64:5740%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:00:45 +0000
Message-ID: <166a36de-56c5-47d7-b76c-37875ccacf80@nvidia.com>
Date: Wed, 16 Sep 2026 16:00:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: ucsi_ccg: Add retry mechanism in ccg_read
To: Wayne Chang <waynec@nvidia.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260916061858.1471606-1-waynec@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260916061858.1471606-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0041.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::11) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: b888a081-37df-4dae-440a-08df140348d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10070799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yCA8kkgaZFk5HDtG2dHNZXsnsnCgFd1NXXGHNSvjeVs+9u73TZGPMLDh6Yq4TKZTU/y1kQ3pECfHUfPBEq19eO9vVeJ7Y6jTFeIrFxJJ6k7rrH66pmlgxXhzk/rpOz8tpz4yqIZLGo6qvhxohzQ99rcY3oHlmAYx2EYJmWMECL57N6lSuyqWbszR/NQGy1NzFC7pfNbve5Ge9foGLBm8l3FBDmXDqjRbHPirRRlwLmF+/XkPvLRDCEBBV2oIZnYLYddsR4bD0B+l6X0gGeSFJBtRnS4yJlv/by+KlRJLQa0c3xTKtRlaql7IjdmlYbMyAdVvc6f84hSoqfq6GR7r85nR60+x62SQ5BDlQqQm7AHeb5yKto0+f3vSzWZx1Ylvn6vHqoUpb4/gdFZfXI6TpbyluZvWmRrqpUj0Qhn56I032jGagD7mQWJ2QTjQt2D2l6VpLUPM/VM/+gEc5W8eNQPnRau/bN72jQc7UsmwzomluxOI3W2YahiOXYVhNN/T+IHMd1pN4Ix9Fl/UW9iHrVMKNQtuQWcpdMh3udwtE9Q90NF5NgrzVD4PhknMBEDi2LBLOCOFyoy4DpHq/NNCeDLLzdUjI35lL3k8mg0hYLJU8pN2mQSzwtlZhhPJGD5dqPMyErgcmN4ehKKI7sy2ES5T3C7PyGkbmAEaj3a5W2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1U3Q3NYaTRya0hFREdrekNvUnM0SS9ob21JSkFuWm9laGZmNnB5MGlZUzgr?=
 =?utf-8?B?L3JkSzJCYVJpR1VyU2ZQbDluRzhNWUxZdWFsbkR6ODVEY29oQytVVmd5TkU2?=
 =?utf-8?B?WVpMeEJ1c1ZCR2hwMThkWFhnUUhCQVJDT283bTJ1RGNkdkVCL05PNzFzMU5K?=
 =?utf-8?B?RWNBK2VVUzJoNmkrR0p4T3NINUxURTF4dEVIai8yWU9Gc0NZYmE4TGR4STlh?=
 =?utf-8?B?dDNBa0FTaVRXY2xtc0MrQzlrR3I0ejBqUHRUQzh3RVJMZURPbVhLUVJUUWF1?=
 =?utf-8?B?ZWhiQ1ZZZ0pHaUFvazZUanY1bFRENVl3WmlrOWVmT3FBdVlVSFUxdUNmdjBL?=
 =?utf-8?B?eTlUcjVMK0lDTWlWS0tVOHVWS0p0NlhBdHZkaG1FSmtDU0Z3UXJ6djFLVW1x?=
 =?utf-8?B?aytGcURPT3NpazMzZUNNK29BOXlJd2lnU3IxL1JBdkhjNzBrZ1M4VXU2OCtH?=
 =?utf-8?B?cnBFcUEvWkFud2RTY1RMQlNvdXY5K3ZBQlY2UExFWjVBVGFyUEFHWGcrYVgy?=
 =?utf-8?B?VDhsWGlkQnl6amZnQjVubDh0MGUrM2poU2ExaGxtc2VyNEU4aXc3QUFDRnpW?=
 =?utf-8?B?bmxLR3ZUaWxLZThqeXVYRmZOMU5TMWVUYUZhUGcvMWY1NFFjNXJKVFNvcU5y?=
 =?utf-8?B?ZVVIRTE3cXJXMm13Nzh1RVFPeTRrZi9PUXJ5NFFQeGhOdUk2eUFjbmplYlJ0?=
 =?utf-8?B?d285TDE0aERDQ1BnM1hXa3d0RCtoN2R0Q1pQV2lTRit5Rk5jNUpCaUREQTMz?=
 =?utf-8?B?ZVV5WXNHVmQwL3p4enlzR25QWGVQTEErUHY2d1dnYXY3VE8vUkhOaCtSTTd2?=
 =?utf-8?B?MDgvZUxEODZjVmZ0Vi8rVDF1U0UzV3FQZDgxRnJmQ1ZLakQwRTU1dlpiNXVB?=
 =?utf-8?B?VEhFWmZXdVhFck9LVFhBdHg2MC9qSlhBRmo3R2RHSUJQVSt4S0IyVUYvSkFF?=
 =?utf-8?B?UUM4SjNHTTZxeENRdm02clBLMHhiMTF4TFNjdUZScmdNR3dQYTUyYW16d0R6?=
 =?utf-8?B?YU1OT1d0ZmlIekxNaHhGbjhZVHRQbTE1NEYzWkhiTGFGV3dOVzlEanZzRnVP?=
 =?utf-8?B?V0JRQm9TWE1yRkpFbnJvNjR0MndMTEs1SGZseWt3L1ZlbjVtUHhYejhxTjFo?=
 =?utf-8?B?UHJwV2UvT0F1UmVMUFExTlRKU0xHZXRoSjNkUnRZRFNtSUpHWkU5OWhweHI1?=
 =?utf-8?B?OFc3bHE4MExmU2VVTVBLSWFScnNHTWxGVE5pS1FiQ3R4MW4rSWhJelczMDVO?=
 =?utf-8?B?QURmNXJvUmdvbEc4ejhzOVVvbWkvaEM1dDRRMFc0WWNKTld3VlR6Z09WQlJ0?=
 =?utf-8?B?Q1hDQy9mUVhYcVBsZGtjN1NuQ1JaMjdXQ3QrNEM2VzgvMXB6dktYNjh5MXNB?=
 =?utf-8?B?YjNPVkJibC9YQjRCZTBNMTh0ZU1Ed3RONzBYVzlWeVd5ZlhRaVcrSGtCQVc2?=
 =?utf-8?B?cjVBb2VTcDV2SmdSYVh0RmFXV3F1V3JTMWpTS2tkT25iTUVlZExRdWppYXZy?=
 =?utf-8?B?Z3B0bTZzR0oreENaa3NhTk1TNFlhNUFYTVFhOU0vSnFpOUQzMWtCbGMrOG1t?=
 =?utf-8?B?elprNGZrNnBVUSs2UUlyalFUd1Z4bng5clU3Q20xcmhvVDRVWE9jRStUMk1y?=
 =?utf-8?B?UkV3WjVvZmZRZjhKWXJabmtweGpCRFhIWnJCblpKYlovL0kxM3ZFdTFvVEtU?=
 =?utf-8?B?Y2hvR1VRaGdFZ3BmV3JJbDBsYUF3N2QwSjNQY28rV3Z5UkREYmQ2OXFxZ0lw?=
 =?utf-8?B?allncEhsRElFZFAxMC9ENzRVcG5TQ2dZNXRDYVp2UW5aaHlDOENRMDFjSkY0?=
 =?utf-8?B?L1B2VVh6eHNiVGswQi9BRzRUODNvRFg4K1VEL0ZQKzEwMGJVaDR6SmZsOURs?=
 =?utf-8?B?aURpcFB1aVVzd0E0Q0RlaU5IdTdhbTV4U2tQemtVVmg2S09yajhOb0hjdGxD?=
 =?utf-8?B?QmFrM3VqNW00UFRFS1lZcDU0aFA5cEI5eEQ1bWlJczFuMUJGSThWQ2NQakVR?=
 =?utf-8?B?OGdpMHdUcEY4UDNxUWh1UGtuT2p6d2pCWkV0Q0lzV0RhdXp6SHdMMi9TaVJV?=
 =?utf-8?B?WU5QelY5OFNPVFdSb040cFZ0cURNUVhYb2cxTWFuZWlUYmdyeG9NKzBjajJP?=
 =?utf-8?B?V2Fia2NDWkF0cjcvOTNyZmRpRVVoRVFEOUl3ZFJ1TFkvL0VmdS9MdklvNkZm?=
 =?utf-8?B?bC9YeXNFcmZhVml2S0Jrc3JTOE1PQmthVktWWEtUTG1JSnRJeml2ZGQvT1k0?=
 =?utf-8?B?NThhc3REWXQrTDFZQW93THkxR200R0JxdGloUTdlUG1wZThpUXIyS0hkcGFK?=
 =?utf-8?B?QStKaG1yTnFsMGhLS00zMEFoeFE3TlIyTDNvYktaQVFGRnNPcjZTWEZkaTRZ?=
 =?utf-8?Q?yJFbNTntG+LP18vbyKtvLbV4f3tRter+xNYZWhxUfNv1k?=
X-MS-Exchange-AntiSpam-MessageData-1: CVN3DN7efvEqCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b888a081-37df-4dae-440a-08df140348d6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:00:45.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nH1R5unCtkXjsgxv8J+rkbCvaBN32zm+07W2MoXQERFe4jE835eRj6WjWciaRYtICqog731+v5Wqe4AjPYWoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237


On 16/09/2026 07:18, Wayne Chang wrote:
> CCG4 firmware occasionally fails to respond to I2C read requests,
> especially when reading cci and intr_reg from the ISR path. In these
> cases, i2c_transfer() returns -EREMOTEIO.
> 
> The CCG4 is EOL, and Infineon no longer supports firmware updates, so
> a software workaround is necessary.
> 
> Attempt the read up to CCG_READ_MAX_RETRIES (4) times in total when
> -EREMOTEIO is returned, sleeping ~1 ms via fsleep() between attempts.
> This allows recovery from transient I2C failures without affecting
> other error paths.
> 
> The sleep is safe because ccg_read() is called both from process
> context and from ccg_irq_handler(), which runs in threaded IRQ
> context (registered via request_threaded_irq() with a NULL hard-IRQ
> handler), so sleeping is allowed in both cases.
> 
> Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
> v1 -> v2: Per Heikki's review:
> - Fix off-by-one: CCG_READ_MAX_RETRIES was 3 but the loop ran 4 times
>    (retry_count <= CCG_READ_MAX_RETRIES). Changed the macro to 4 (the
>    actual total attempt count) and the loop condition to
>    retry_count < CCG_READ_MAX_RETRIES, so the name and the loop bound
>    now agree. Adjusted the "skip the sleep on the last attempt" check
>    to retry_count == CCG_READ_MAX_RETRIES - 1 to match.
> - Use fsleep(1000) instead of usleep_range(1000, 2000).
> - Reworded the commit message to say "up to CCG_READ_MAX_RETRIES (4)
>    times in total" instead of the ambiguous "up to three times (four
>    attempts total)" that prompted the off-by-one question.
> 
>   drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 91c2958a708c..4b6c53d2a998 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -135,6 +135,8 @@ struct version_format {
>   #define NVIDIA_FTB_DP_OFFSET	(2)
>   #define NVIDIA_FTB_DBG_OFFSET	(3)
>   
> +#define CCG_READ_MAX_RETRIES	4
> +
>   struct version_info {
>   	struct version_format base;
>   	struct version_format app;
> @@ -255,6 +257,7 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
>   	};
>   	u32 rlen, rem_len = len, max_read_len = len;
>   	int status;
> +	int retry_count;
>   
>   	/* check any max_read_len limitation on i2c adapter */
>   	if (quirks && quirks->max_read_len)
> @@ -266,7 +269,17 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
>   		rlen = min_t(u16, rem_len, max_read_len);
>   		msgs[1].len = rlen;
>   		put_unaligned_le16(rab, buf);
> -		status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +		for (retry_count = 0; retry_count < CCG_READ_MAX_RETRIES; retry_count++) {
> +			status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +			/* Only retry on -EREMOTEIO, and not after the last attempt */
> +			if (status != -EREMOTEIO || retry_count == CCG_READ_MAX_RETRIES - 1)
> +				break;
> +
> +			fsleep(1000);
> +		}
> +
>   		if (status < 0) {
>   			dev_err(uc->dev, "i2c_transfer failed %d\n", status);
>   			pm_runtime_put_sync(uc->dev);

I was wondering if we could avoid the extra check inside the loop for
'CCG_READ_MAX_RETRIES - 1' but this does avoid an addition sleep. So ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

