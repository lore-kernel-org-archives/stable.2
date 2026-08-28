Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022091.outbound.protection.outlook.com [52.101.126.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40630C171;
	Fri, 28 Aug 2026 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882159; cv=fail; b=uW7aRFZCNe0veatl4SoT7HB/Z0ZYqkZGU9EIbKYn9ni+cqkLWHepODiqD2QyC/ogQmiklLl3va6UdKFafC1g8JQOSBm81Stt6xDxIz30qLTXl862wnWatdzpNTkAvyTsOCINAL/knZZWfNfG7vlG/63WcGZBbbiUUQtHWUEXhwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882159; c=relaxed/simple;
	bh=ITAG0RYsFKddkqHkAcuM3UNrBqwRXoZL0j0iHuNCDIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6oUCsBjAjIxonhUY70HINRDo5EJlUWD0HXJa0NzmzJFZ74h8dpBs3bKIocEG7BLVlNyMZ41L2WM2rnb0/W9qitd1lqfEXe+3ea54ktgp3StEcCc2CGozXktx6lS9PKqvJggF2rgeW7KNId8Xz7XFXpGF8Bbo4EcrmMpW6TOee8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=w02ggGlO; arc=fail smtp.client-ip=52.101.126.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="w02ggGlO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3E8TnBkV8s7AuTpcdVViawEDfAWQvlo6j6reDdYmzcVIHpXNfm69SBlkSeS0QVhEr2JDuQJ+f39kWngpsCaQBtNxQYgMMEhDgd4wKPqR4IG1Jq504ejh+ZmtCTFZHPZ4UUfCZ7SsCvqT7YqLM1bjSfux5NsLytNOXNQGJV2iPCUiPM+0FKgO17Mg/blx52AJQ2Bk+8ErB8YcPmvY3PrsYsJ1rIXkY8Jy8dN6IlOY7bdNEw9Kg7TchpG5TZ2Q5oOSsIe9tsZEiA1dK45PPRV4ZBzqxLo4JkU/K2fAhv3mgp37BLV+vA4phd4JdP5cNCI75yO/hv6hN4Df8gD16NHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbJaN4GfvxIQhKkGsdEkzy9ong0Rhy9pA7Pf8fHz0NM=;
 b=d3UgG/svoUBmhj9tGwjfgcyCIVLFcDdd0tYfvf381HIOt4nTYxTfJ0LJdGzNztWzGtdtViLWHZkwit7d6+gyGDnY5mQw9E+KREWSqkoC1FdeLTCafJb+cC285Wz6Xv8bN9irdgZeSMJHX/O6KQXDesd3hj8kCwI/9BTAh+IAADwky1XZv9ZgAXFyxOoWfwKbRW9pmXTcOXOjyeVtryPFuySL4+gcQ+oBBJUOl2dgR4bxJSDJ3k+alc15wSuabMnaX9+fwjzhKwpJVHGkFfOxFHRNt6j738boO5Pb1ngUUe6kIYJDij2Ebk53lh+udr3lgh6wAmJoZctxBEGSlZ8dOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbJaN4GfvxIQhKkGsdEkzy9ong0Rhy9pA7Pf8fHz0NM=;
 b=w02ggGlOyApocO60sFF/xzJO9C0BqxTlw9b+jFUwifL/kedpSed95lDRTckslAjeoq+BChkH5swRo3su0MSRYL5Xut+8j8fu5DDVu5+HKej20v7AP23YJCze8cbl5oQMXT/t/V0GY0dupKty5T/dNu3HE5xu4cDakBxwpF7xl9Kn8bQYMGDx0XpFZbEmxf4SXO7jvIPznaQhxHYWksQIaZ8eGGMZ8Fq5wujCZqho1QfynKDQV+EnStrMkTxI3RvjaZKKPUM0bF381J08sKw0BY90WDl0RXsnUDRBRTJGgIRPw1MBtiEiN+65FZL1krlM9jrWCgglgQH8J5qYyH6L1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9)
 by KL1PR03MB7528.apcprd03.prod.outlook.com (2603:1096:820:ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 01:55:52 +0000
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::bc0e:21e7:ef9e:e77b]) by TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::bc0e:21e7:ef9e:e77b%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 01:55:51 +0000
Message-ID: <ff2d8e54-3169-49c8-9f9c-dd4632bf85d2@amlogic.com>
Date: Fri, 28 Aug 2026 09:55:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: amlogic-c3: Fix out-of-bounds read of metering
 zone coordinates
To: David Carlier <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260821212848.214982-1-devnexen@gmail.com>
Content-Language: en-US
From: Keke Li <keke.li@amlogic.com>
In-Reply-To: <20260821212848.214982-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To TYSPR03MB8627.apcprd03.prod.outlook.com
 (2603:1096:405:8a::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR03MB8627:EE_|KL1PR03MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f92d14f-f774-4251-109c-08df04a77d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	QP77EGJLZWyyoL61NrXbYDLQSAG81wrtxdr5pZPy2ly0v4s53PjhBAxNp94Nr6Ur2hm6pBWH0t0JYfz1VhkvC6iOS1iyS1ddMDjASut37s/KK1M4isFCuwRy8S4gJgD+czFf87cB90n1+Vhl7U1YBY4i84LCg6uBYkDzGFfA//sF9DZt4s81pvId4d6PVb0CyRjZk/CXoTUvx5VUM5N7DpI3EdnSFiLJZqyMCvJv3splf720iEBrt0fYqLTHKK8zGqrJgEQD6brsGkbH7o/mrMRQBX88mWY3QMwgXAPxBTtfVOsolnh5C7AASQ+RgvrnV5uOqJ1KvkoAYzoHBN+G0jE+ITDIrGtndUH2JKerChabAez3nf4DYW847Awij3tGbOcz3r6OVQ6cYtlKfLg8hEk6vEHoXOcFBkMnJ53iDLS4Dl0Q0+inA87P0CJfZ+iRJ0uukYTxE5U9vEjabZHnAFTPafcIXkHOvoASJ7X3NkHcZwtw7Kkh0JGX8rcBRAGwuZ0itOiL8JpDz8TjlBznrkGCwhR9q92q0ZYPSCLpC23mTPdUc3D6+9Dow+BL10zlHS4YJ26JMG5ljui425lhkM22xLySyPTm1zMegpaAoyOs7iJepZ6ps2204FqUEoz0VPBeXj1pqai6GNl214hHRW97Z0e259+0A7zHPzYMG40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8627.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEFtVW9zZlhpSjZUVXNkRm5sNGlVNkV3eTZCZ1BJR0plNllXanJIQW9SU2lx?=
 =?utf-8?B?Wk9pcm85K2NVWFRxNVNaZG0vbUl3aGFLZVZLbXJWWHExcDRwdmtoOWF5Wnh2?=
 =?utf-8?B?STBsZlNZamFmZzBnS3g4SFdTem1VY29BeXVHak80K0ZDZW95dWZyR0lyZFo1?=
 =?utf-8?B?dEVhbllnMGdETE8xQXBqdFlGYW41ZmJEUXArUFRadHpGYTR2L3VsMzNOampa?=
 =?utf-8?B?Z2JnckNZM1BOV1ZIVitVV3JQYVFOQ2xzcCtRSk1TSEJDS1hvMThzWVdzOFhD?=
 =?utf-8?B?ZlFmS1ZoVTRBOGdxN0dWbU5YSzBocHdUc1FvVEdCc09PS2ozL0JTS1BNcy9m?=
 =?utf-8?B?MmFINjJiOG56OUpCMEt6K2V1VklsZVNySmVWZG9HM2pKVFhXQUxhdVFnUGZW?=
 =?utf-8?B?OWtuSnpWTGgvQjNlcm01Q1JPV2hjMEhvYkRIU0xoZTJsOHJURW9WbVptRG8r?=
 =?utf-8?B?bytvTkFrVGZOc1N2Q0g4amFPT09HQ3FzaU9aY1c0cVAzcHZJRUZOTEp4L3lh?=
 =?utf-8?B?cjh4QmMwNVRyK3Z2cW9abGFnb3pmZWVLa05XcFNVMEJkSWp3MzV0d3lQOXlB?=
 =?utf-8?B?Q0tTTVFWcTg1UVVCalQwejFTZXhXNmFMVjgrL1g2MVM1VU9HUzExZkVVM0dG?=
 =?utf-8?B?Y0xZUE4rUHFHdW9DblRrbTMzc3BxbmQwbm9xcEVqQytxS3crTDFLOHpqaHcy?=
 =?utf-8?B?TW1naTJic3JMS2ZqZjE1TWFxRlRrU0k5UDVuNnZKZlhjVmVEeTlKaXpaTkdK?=
 =?utf-8?B?U2svYVVkZUhmRjZhcWxhR3RoOXhjd2ZOcVlLakd5NGpCSHhJcW1qQSt3cm9a?=
 =?utf-8?B?cytJTmlKQXA0Y2NrMFdvL1BDSUc4T3QwcGF6QmR5N3pYU2pSS09oSTJTaE82?=
 =?utf-8?B?YXlaVzBpRG9ZTGs1OWtxK3NIOUMzVm5KZ0k4aXdUbXU0ejAvbDUwQ3gwY3ph?=
 =?utf-8?B?KzRDK1hiN1F2OE4xYUc3a3pYTTM0TWhZWU9pbFNhUVpHNDhBZ3Q3Vm9OSXVB?=
 =?utf-8?B?Nmh5c2l2dzFLV2s3TFAzMkI3T2kzL1V5bFdod0V1Skg4Y0kzbXJSRThqVWh1?=
 =?utf-8?B?VFZNV3ZhVTk0ZEM0Zk1HVzZpZHByaFhZcXBKWjlQN3NkNWlVT2pKU1Q5Z3l3?=
 =?utf-8?B?bGtuMWN3SUN0bnFNVnZhdEwxdEdDdFFqYzZ1eU4wLzRWV01ieThpdG10djdi?=
 =?utf-8?B?eHBocVVsZE1jVTNnbmlNRVVZYk4zSjFzRG1zMEpSWGIzYk5EUExVNWtBOWZC?=
 =?utf-8?B?dnlCWVU3bXRQd1MyMWVyd2ZOQ3lqUUNhTHp6QlpFQUlNaU5Oa3N2TTVTQUQ4?=
 =?utf-8?B?UVFRN3QreDhhT2NaenFySG5iU3VrdWZnSlJJODVZVXJtaDVQbkM0UXp6TnhC?=
 =?utf-8?B?bHI0SnBrNklwSkI1b1JZa044YU1WQ2U3M3lGdjZFd1NnMFRab2VGd0RuMDNR?=
 =?utf-8?B?UzIySkJaQUJzSEFDcFQrZWhCMzV4dWJ2ak8vT05HTXJINk5LODV6MjNndFF1?=
 =?utf-8?B?L2xvalpVNnpkR01kRSsvUlpOaTZRbmFmVEtEdzA4czZ5Qk1BMmJBbXQ5b2ps?=
 =?utf-8?B?c3FuQVV4YWFqN2VXaGZXd3FVY0dFeUJqVUk2TWxhNjdPbFhWSnMxN1d3SG9n?=
 =?utf-8?B?SCtHTkdlZllVeHVUeXJJZENINGV4d2sxRk0xZTNmcXhkSnVZbVQ0NVhYV2VE?=
 =?utf-8?B?SGhtK1REUmJ6NktMVlZXRGtwL08vaGhDK1hCT3UxaWIzZVQ2UFh5c0piVXJO?=
 =?utf-8?B?WE5OcW1kSml4anVMNXZxWFpoeWt0SVZrcFlYaS9CWUxSRkt2Wkx2TU1mTzVn?=
 =?utf-8?B?UVg1VHRLZzJBTDFQd1ZjdmVHaWlpS2MxWS8wak5qMS9zOWNyNUtLVklnNTJS?=
 =?utf-8?B?eTAyU3plRUdCUUw5RStDNzVvTXZiY0phWkhJY2EyZ2FzTURuNkNDaVRUS016?=
 =?utf-8?B?Tm1BNzIra0l4UXBuZUtQZlM5UFpFQWVRa2x1YnBSTVBNd29zYUNNejd3Y1NT?=
 =?utf-8?B?OXk5Zm5paE5tbjdMTytmMGZydDlBSHRiNEFjQy9nYTlvdFZhb0twZlNBSG01?=
 =?utf-8?B?RFRNbGFqaWk3dEtXTFBnNVJNdmJlVVpxc04wYUxxRVBCMDRUZ3N6MDZnTlE1?=
 =?utf-8?B?MWQ1QVIwU0NySzFkWmxUQUgvSi9RamlWb2NOdzY3cEdLcTV1VXNZSllNRlBX?=
 =?utf-8?B?dEcvT2ZFbk1iMjZWUjZXOTJRUElyNTd3bG5NYTIwSGpmRitvTkdWSThVZURD?=
 =?utf-8?B?eUwyLzl2V3NDVGtQWmxQb3RMMzlnV1ZiQzQxWE9CbWNVYTdxOWVUVTJidkpY?=
 =?utf-8?B?RWFGb1ZPaWt3Z1JsalJiUWVCOEJGOWdBc1VKRVRISUpNRU5RcWFWUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92d14f-f774-4251-109c-08df04a77d30
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8627.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:55:51.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4LqJxUNobRp4X304W0GSkwS4VtpNRW1T+1YsXoxBvx19Bnkxpb2XKMtCf8weeUQmOAW/r2aw+8T+BCM0PV6Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7528

Hi David

Thanks for your patch.

On 8/22/26 05:28, David Carlier wrote:
> [You don't often get email from devnexen@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> [ EXTERNAL EMAIL ]
>
> The AWB, AE and AF coordinate loops bound themselves by
> max(horiz_zones_num, vert_zones_num) + 1. Both counts are u8 values
> taken verbatim from userspace, so the bound reaches 256 while the
> coordinate arrays hold 18 entries (AE, AF) or 33 (AWB). An AF block
> placed last in a full payload reads 474 bytes past the parameters
> buffer.
>
> Clamp the point count to the array size, as the zone weight loops
> already do.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>


Reviewed-by: Keke Li <keke.li@amlogic.com>

> ---
>   drivers/media/platform/amlogic/c3/isp/c3-isp-params.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
> index ae0777a20bda..f2396e2c6640 100644
> --- a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
> +++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
> @@ -139,7 +139,8 @@ static void c3_isp_params_awb_cood(struct c3_isp_device *isp,
>          unsigned int max_point_num;
>
>          /* The number of points is one more than the number of edges */
> -       max_point_num = max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1;
> +       max_point_num = min(max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1,
> +                           C3_ISP_AWB_MAX_PT_NUM);
>
>          /* Set the index address to 0 position */
>          c3_isp_write(isp, ISP_AWB_IDX_ADDR, 0);
> @@ -258,7 +259,8 @@ static void c3_isp_params_ae_cood(struct c3_isp_device *isp,
>          unsigned int max_point_num;
>
>          /* The number of points is one more than the number of edges */
> -       max_point_num = max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1;
> +       max_point_num = min(max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1,
> +                           C3_ISP_AE_MAX_PT_NUM);
>
>          /* Set the index address to 0 position */
>          c3_isp_write(isp, ISP_AE_IDX_ADDR, 0);
> @@ -316,7 +318,8 @@ static void c3_isp_params_af_cood(struct c3_isp_device *isp,
>          unsigned int max_point_num;
>
>          /* The number of points is one more than the number of edges */
> -       max_point_num = max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1;
> +       max_point_num = min(max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1,
> +                           C3_ISP_AF_MAX_PT_NUM);
>
>          /* Set the index address to 0 position */
>          c3_isp_write(isp, ISP_AF_IDX_ADDR, 0);
> --
> 2.55.0
>
