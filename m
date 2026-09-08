Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8C3A9605;
	Tue,  8 Sep 2026 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892965; cv=fail; b=DWLWUVfKLwcgWP6ruJvnXxKNiF6i63JlCBQwWut02VYkcFwk37I+uqvbcDHD9OdxPn087cO0owBmGaOkLtnP3gIyidi8Qa8QuALv28g9LDGg8vcL/tEATzE7VTQJi3m0yYz5uarogH234+4XZNHTtNfuJxkn0e2DQKXMpSo22ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892965; c=relaxed/simple;
	bh=K5L4uwORh9mDSTOZuLPlqm5+XJGxzdAST2bW6gcZKzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RRIv6vdG3AuOMzkOEfSpoq6o089wOUHxZMwH8wnK7vLFZbHUjyf7wwO4P/mte6Ztq8fbUryU0gG6Z/oXZjf45tAsDSrmMGTyRinqE4Fw7L62HL3djdFfxp56/05vwxAYepmFBWeAEPJW6XWp+/rNdUG+RGLPRpX1SYp8Fb67/Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LMTUBV1S; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMTUBV1S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyLq1H84IoU+gk0PJRPYxzPvxEiJaLwYHVl+7iUMmxae/rCNKpWHoc9LycXOPt4FhwNWf3kHAgXp6PvgQARwFycfbnVKTTcHPtnX8mAyotgrDa7ltSvi0ylSSR5e2Gqg6rk6nce0bUHLGSeRdai4b/SMS87LRoBX2JjPBueYOvgZbcYgUKfcNbQUPK28dHywd11XDfj5XOITAbU54SpjvLO3RLblHp/ibuYD0i4PPRqY7/W827u9ltAhyrUDitbLz2+zI8lpZPIpYdDFG3Vm3M7EKdLOF/Mf5Ey7vwSM27Tj0AdHPivWmVDToMpWf9xIfgLFm76LwWTeGnjnFPS4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DO+xCnLIl+S6XPQxNzpXwcqKXavnmf0PgkLXJmSOm0=;
 b=T9E8ftixDTwXjyHBh+9Q75gXSdaB5ZBWC4yrvZ5nN+sDWkaNio5e37JNjQkDLhArc3vgMry+b0EqsAGutubgNyjsp77B0XpbwXud+zpSqvm0aBkKvJL/wjmwYu4sPan5RWZNzBreO8fDF2rrOrht7nLn0W+3DkHkB0c6gWtB3zk4NhePDMaGGbtIgKe9YifFfeaV5QQCL1euuUNEtr0De1blKaFA0CQGYAh5pVnY15ZuRnZo9H9S1FO9grOjnn8OX0U8+PBfz1gLFMGfMC7yFTfUMdRs1MJgO0B3Dsgc3bANGNu7gGgWB+/kB8zNVgP9AjJvqLzlQhNCa5oJzD+bVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DO+xCnLIl+S6XPQxNzpXwcqKXavnmf0PgkLXJmSOm0=;
 b=LMTUBV1SczMfRN1ewLncGed44TNXnTdlcNAc2l97bq+VDzNC6VxTfGU+2bukVB0+NWj7aN97SlrLXg3p7Tt7uIgoZJDY07of0Cevd5JnXukkcBjLmCtwEY2zESuoOmnbw5ZxSDAd79g5/uuGmg6Bjor2xCDXWmrPxtldE5zKCBQkQMeOOGCOd53T9kMqyzIGSUXvxShlTMNYADhxXKedLHhgAsNVOdyi2xy5OB67t3nTMAb7MBQ8vZohGwS8gvtw8h5+3f0mmWXuYlU3Q/LxvpgOYhyEhey8wbqE/x0P7WT0wCXK67rHrpsi8/VUeeKUqufQnfYyoAmUdp/HQf98yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 18:42:36 +0000
Received: from IA1PR12MB6329.namprd12.prod.outlook.com
 ([fe80::eadc:c846:73e9:8ccc]) by IA1PR12MB6329.namprd12.prod.outlook.com
 ([fe80::eadc:c846:73e9:8ccc%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 18:42:35 +0000
Message-ID: <fe711e37-2ebe-4c34-946f-2ebe8eb8c17f@nvidia.com>
Date: Tue, 8 Sep 2026 11:42:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hte: tegra194-test: shut down timer before GPIO release
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, timestamp@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260904061137.4037269-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
X-Nvconfidentiality: public
From: Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20260904061137.4037269-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To IA1PR12MB6329.namprd12.prod.outlook.com
 (2603:10b6:208:3e5::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6329:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 050687bc-a7e1-4173-96fd-08df0dd8f342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7vuKGXAd9z+HIwkaBre9RfNBlsnlUq2Op/SlU1JgACEXinRTT3ie6ZGzvCHTbBWmgrCPgq9BUL1sF9LxABIe3dXQGrDKaJl8CkShJXPU1c5BBD8u+2TpJ0sTLNpIaqPUQcyfBQhijZUJgNByP4XjSsTkUgOh+ELvR39GxltJqIrt+7vX/seir6G4lRCgF0Mj7KIgEF23kP7SQ1Z+IJLBygZjdbhkfVBCsF8Yo3ziBBeawvnuGPKJgiLJ6gcv/RqxbKHDtCVAvKUa4J7XiuVI3k/sDHK+NDxG1JxyoID8Knl3Jx/z3T33VTwbWsD+mRdwu7n3vN4L6EUPXFvuXop5NS2UAm6HVQtkxVwpvme5wUraAOqq1zSfQEROt7nbP84W0eLtXwtcROT9fuX3zDpVVDY5iDSRu3V4K4mcboSnOzAMs2GiWJhzWU6ttmFzMC3R/f9tyx6YxeeXvPwwqu0jeBZVNNvyA/+nZX87CVQ8P4WSCnaOqMvfdY3NnRyKRZBN0JVyyNNKZOJJJoBESWZgc+CMy8fo85Bgj6vndmqD7gilQlG0rV++jrQYw2ysslGtEvV1hqEkeE/kEUQEUdBUnqzbSe3HaGx1e7yCT/RMNq/AwevXer4Rke22BglMtXwRwnPu9Ot21SY/V9Hma7ZYcXDJt5zVSvXaWDOX45Odeic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6329.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djJEWEFKTW1JUTFBdUEvdkI5a21sbTBIcWxBVHVpenFUeUdFSlpYZTZnQlRz?=
 =?utf-8?B?aWE0TG1GeFArd0Q5SS9PanliWU1pZTQ4K3F6VTY3QmNKcVJyZ0dnNVlCbEM2?=
 =?utf-8?B?RkZsTWtCWWtOUEFUYko3ZHRIVE8vTDM5REVnY0dwdHJHSEdpNXhkZytRK25C?=
 =?utf-8?B?bE1KNkIzY2tzeUM1M2lRbHk1SXBLRDRJRnU0SDQyVzdGQmFLY2VFeVZ0ZnV6?=
 =?utf-8?B?UEY2RjRZOG9RVEVGT3pvdlEwQWRjdko5KzVaWDNxWCtybUlYUC84KzFPSVJ0?=
 =?utf-8?B?NnQ2ellDTm1haEVFdnhlaDV4b09Ebk1DSUF5UGY3UmNmdm55dGNqZEZQRDVl?=
 =?utf-8?B?b0xESkVCcjNzUDNiQ2tGVXBjTWJCVTI4bHdUdXVHV0F4TUhIVkppc1VNQkdV?=
 =?utf-8?B?YXR5eEFDNmJHTXR2MWdpMENEZXVJYlJtZ1pYdDhGMW52Z1JieUhtd2dFazZ2?=
 =?utf-8?B?WGIvZi9tcGcrVVdOdVZMM2lIek9Gc2hmOFRhdHJac29lY014RXUvelBXVWgz?=
 =?utf-8?B?S252dElxMEtZbWE1TUdveGZrU3hmV2Vta2FRbDIwdDJack1XbXZhMnorMDhp?=
 =?utf-8?B?NEFIaE9pNEtXMTMrd3RNbjZJRWVYc0NhRTZDdzBGalI3Zm5tTVJ5UGJKdGYw?=
 =?utf-8?B?Ky9wR0V5dGxiaFdkV240bTZkYlE3WjR0ZVJySDYxQWxKUER0NFhoUHdPM0RZ?=
 =?utf-8?B?OEN5WUZZdDVJQ0k5dk5JZThWTFR2OVVtVzNMSDhpRWRaMW4rV3JYWGhBTXk3?=
 =?utf-8?B?dXRSMCs4S1R0MzJIYi9VVnhEdURBVUxUZ2pLV2REMmRNUEhEZVFCZDJWMUhr?=
 =?utf-8?B?c05QcC96WS9peDBTVXFLM1FRZWJYUWxLVlJqY1lqdmN1VVI3NDBFSW9wQndp?=
 =?utf-8?B?Z1BQTUJLdTJEc2tWS0NYQnNrSTB2WGVTbXVUek10cGhHOUFhajREL1E2Q3NP?=
 =?utf-8?B?UHR1RlVXdGp1UDRIeW1lYjcxTzhQQ003SWhHUnpzZGw0eVRLazNlWTV1VG5N?=
 =?utf-8?B?NGE5bFd0dWlwV2kxdzlEbTBXVlFDdThxVTRobm9MeEtZVWJqNW9wWDlwRGVL?=
 =?utf-8?B?QkFDQkNZZ3VHc2gwdG4xdTljYm9KUHhmcE1RQ1h1REVEek5lUU9sVndTZmtT?=
 =?utf-8?B?ak9XUDNjM1pjeVNtYlZWRmJxTnowMW03SFd4dnZOVDd5VmU1OW8xQWl1ZkFi?=
 =?utf-8?B?QUJPNVJMTXhhb0F2NVQvUEJsb29zMzNqWEdleU8rMlRRdDVzNnd0WDN1OG5z?=
 =?utf-8?B?WU0wUjkzOEVxbEhPV1BLRkw3QXRhUVlTd3hJZm1sYlB6dTdpV1ptcXpDSC9S?=
 =?utf-8?B?OEJuUEVRNmxlUStUelFXSm9UeEtCOWJlcWhTM2s5YlMrN3lSTEJuWmQ4MWxt?=
 =?utf-8?B?Y2pKdnRJeThxQklGb25Ha0hrakxlMDdkNkhVUTlmeWJiNDZxbW4wYkdHWERq?=
 =?utf-8?B?ZzdobTdSU3NKaWc5YkNZMWFXY21NZGwyL2ZwRG43d2k0ZlBMbCtkaEZTbjV4?=
 =?utf-8?B?eGNTR1pHOGxERllNa3ZNdVBtZHQ2Q0IyT1Fab3FPQlNLRFlnQ3IyM01TK2dD?=
 =?utf-8?B?bmZqc2Z1aEJ3UGZaSVo4RVljS2N0cVYrNU93VVRCYkx1WVZHSk9jdUhuZDJ1?=
 =?utf-8?B?N0lZelEwWk1BeEtnZXZoSjJNNzgvTjhnVE9mTGJVV1A2aWRtSmxWNk94ODRQ?=
 =?utf-8?B?UTl5OTIwWTBSamNIcmliQUpsclRTNWZnVTVUdjRHbjdWRmg0K0dDT1QrcVdi?=
 =?utf-8?B?OVF1R0V4MDRWcHJYKzZZdVdmRGdET3M0ZlFSR1lYeTlFS1phSFhIV1E5aC93?=
 =?utf-8?B?WVp4ZGkrdUNnam1COUg0dVhNOFB5Z21vLzJnWEFZbmRpRngxUlZyOWRGZTcv?=
 =?utf-8?B?eldXcDlocWIrK0RmV2JLZ2RXcVp5TlhUNjV0aUgvcm9sSEhTOCs3aVBhTk5N?=
 =?utf-8?B?em10dEdLQkFJbkFjS3ZHSWFIc3NVUjdqMERoVWp3ampLUnNsaDE5TjBiazNU?=
 =?utf-8?B?RWVOSDE5NTBncE9CRk1EMU9jZWtySE0wUVFHSU5TQXNCdG5DeGZyblo3WXRQ?=
 =?utf-8?B?Wi84S0ErRHRFREdUaGF6anloelE1YlpWZFBUYlJkWjlPMmJmM2dvdmtaZE9W?=
 =?utf-8?B?R1RUWHg0T1RaM1pCbDIxckNvangxY2hwTTdSVXJ2aERpYnd6YnFxWFdvTU5w?=
 =?utf-8?B?RWl5RFA3VmpxY0k1T3g3OTFrYlpQZno2QU5nNTB0NWVsaFNoRlRlTFNWcVE4?=
 =?utf-8?B?QTgrNzZCMXJzODJlRXJHL2lEb255VGNjQjMrYmJXOHc0Q01lRy9HY1RhcHJE?=
 =?utf-8?B?YkFzVndjVDlINmZhbTVDL0RUWm5XendhOU4vc2kreGNXRXJZTnhSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050687bc-a7e1-4173-96fd-08df0dd8f342
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6329.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 18:42:35.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbd0iRyrgys8fzAQwg/xZj6bbDbXOxPc+aNK3QWSBLICyXFko+qLfTYCJ1KWoqyHDqrFQ00/pL5qZLd704jwtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

On 9/3/26 11:11 PM, Runyu Xiao wrote:
> tegra_hte_test_remove() releases GPIO descriptors before stopping
> hte.timer. gpio_timer_cb() accesses hte.gpio_out and rearms the timer, so
> a callback concurrent with remove can use a released descriptor and rearm
> after teardown.
> 
> Shut down the timer before releasing the GPIO descriptors.
> timer_shutdown_sync() waits for a running callback and prevents it from
> being rearmed.
> 
> Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/hte/hte-tegra194-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
> index 32907d951..cca33868f 100644
> --- a/drivers/hte/hte-tegra194-test.c
> +++ b/drivers/hte/hte-tegra194-test.c
> @@ -217,10 +217,10 @@ static void tegra_hte_test_remove(struct platform_device *pdev)
>  {
>  	(void)pdev;
>  
> +	timer_shutdown_sync(&hte.timer);
>  	free_irq(hte.gpio_in_irq, &hte);
>  	gpiod_put(hte.gpio_in);
>  	gpiod_put(hte.gpio_out);
> -	timer_delete_sync(&hte.timer);
>  }
>  
>  static struct platform_driver tegra_hte_test_driver = {
Acked-by: Dipen Patel <dipenp@nvidia.com>
