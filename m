Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCC3793AC;
	Tue,  1 Sep 2026 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238614; cv=fail; b=fmEuGdyrfkr6Vi07lMn4jJdO2TCnzH11OBVAHmr30dW7I3mb5zrniEKL5YnOm4rhjMRB6yMy3ewV8NOpXr7pvusiJkrJyI24J5I2puf9JIT6HAinbJQdSxM9gOyhpB+WZbbPdc/ht11s/jAr07w5oZw3DK0idmnQvZ+NOLQAov4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238614; c=relaxed/simple;
	bh=u6RaPr68N1y6lEClNrDT95sYkw/5pCZXckqyLYWwWbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SKKE/Nu4J9REDMylXHOQQag6PVQO7EyhNYT+ehQZKDCBXdYnUPV/1yzEsz3Onsjub4Y2iDsPqCIGf8n/42dlKR+d1tUn9NWZkR7HWY02POpyiSXgJDKbaaIP0Ttjn8Xq19C1dQjNlkUsiF/2yu8xgHM0mAp0xc4yur6960I3kqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jrScqjWc; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jrScqjWc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNqA21iV7TvTFPCjmSt8YadMBbFTDLwlExAHNqDXhEJNfMrHAQmeRdzxwqVMpr18OLVoEOI9wnrOKcPRtxrjo6fZUJYhNgcU1LOxoiRyle2hZIEG5rDqNVmEpaxX6Z3/pxHXMCiujfcpakzkti2mXwDBGx2gpzI1z9mkNNVhsQ8H4aJEw952svFj9+aQr+mlmWxJH/eXrTF2RiSiZFYjqJ/ExIVuag9HjFxrmh4EM+RnbJ1ahGdpJe5ahmQbALrl0PWS1laFGeFyBAunLeImYLUrYjShS0X63aYEUelVJVtHgSXGhD6lrCiBXRPgS/Je5gbBAMMyC/oHU/oBSTfutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjZ5E3iGuqjlwV7REuq7ngdwnUViQ/Ke2cV/a3wdol4=;
 b=hhA7qyyyT6Jqwun6Tl22njXSUuIhum/sLpaiD6B2d694YQdh1e9l9zLVzZUMiJ37UaJQ/nMWmMbib4rcAzyB9SYYy+X6/lUv7B+sKSdn9fwJ1wqDtpQCeuNsfPCxetLUpHdSZclHzTQJBcI2kxpJFfMfSZx6ZNCQyaCHri30UbI5086PmwKrUgkpjGr7qumdonw/ss4tuizDoxROTzL8Axu4W+6JMsHPr40CHBG0R7IFtMtIkk5j8eQCK+MDWc0T4OX6mgMscv6SXKuFg7iEP4LItjuyBkTRPQrHPM0Gn8x0Emw8+n/sxmuHVOAbYMxWzw5KJZ++j5xAtaYl0fq3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjZ5E3iGuqjlwV7REuq7ngdwnUViQ/Ke2cV/a3wdol4=;
 b=jrScqjWc7UNa/NamVZo+9IJfSsBuz67le2TAYYyLAWBibIXVvdlbnIYH0g+PBPivM5RJAcjJOTFuaTH+ib6o4/37pXqn4FH5lPBQwgAgm+XVooP/WBRphb1ExptJ2wUdhEW7M9SBjowjhbHKkngO81gRFbSrVoKsF0/h4jevuVIkrDsNRxWm19ec1G6YJYGiejk18RH+6C/juxpiHe7RL5f2Kuk8A7Dqvr2fs+8pA7GUVdJsQSiRk19MQ+7mo9NDCG645EqrjdI1UuZSUt2L0Q+P4ym1hoW+bx4susOdKj7COaySATeAf+/+2Mgyha0La1ypi6v1p3arc8MMoMM5JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 04:56:50 +0000
Received: from IA1PR12MB6329.namprd12.prod.outlook.com
 ([fe80::eadc:c846:73e9:8ccc]) by IA1PR12MB6329.namprd12.prod.outlook.com
 ([fe80::eadc:c846:73e9:8ccc%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 04:56:49 +0000
Message-ID: <fca1cd76-c6e7-4137-bc16-a5046d2c9d9d@nvidia.com>
Date: Mon, 31 Aug 2026 21:56:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hte: tegra194: Initialize slice locks before registering
 chip
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260830161747.2719220-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
X-Nvconfidentiality: public
From: Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20260830161747.2719220-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To IA1PR12MB6329.namprd12.prod.outlook.com
 (2603:10b6:208:3e5::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6329:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: ed52c3ac-2d9b-475b-2fc2-08df07e56ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VGuyOnu5LXTYn+qepbVUSvAwwvArOSs0oSS3q1DjQdKzGJzVapm9ByEBeGDsIBF14WSbrFN0yHoR+Eq7nGPic8jPy+0dwWOxnvKmbygcmbDGjnIDnAvm3GHsSSK63VfsUU/GBvwcoqRpb3cy4xFvVsMejaZHf7oQDJXwTdPjXhaaRZ8rIZKsFyDyJwp4uBjXGhT7VP9lHTuF9n8pJ43TWt9uW+Gt/MGrDmwlv2F0Jm5wdxN93OPIwYuO6wckaqD8ETgJJmyJOXnl/uaQAZ1R93v2upeYTbMriOcCO871uFJTpvgqhf5ouNZgrn3Hh+/IMnRgsUmC2pCJz0hKIuc+YVV/k5n/czfdGQjsXvm3vQPo2IeHmxY+82FuAkP/OOwNwuSmSleLmO2KxcybCZVMt3GK0EbDMS+IaTIXAFKpx9eogLJThziHXhR3Piq1Upi9e/yP4WDqI7zqP90drl7ak8pcd+QICJCzuKOj1B/i/K6iLEpfyylMyeFdCxTUtik9+yWK0JnH470cYpkrQMPELdMeZnmGn4ekoRdfx4pu+qcgv+Cxocev22dyRFlc6Z5E1qToUEPjzuyy32TOfdR5rBUaow7Tu9z2W3KafUK6I2fiFp62zo9Cg8NMDxjRGuff429dh7inKeFJsLD4vtsQx0DodhVwWs1WgeEz1y1kTTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6329.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVF6VFFtS1Q0Q3Zva1ZPWlhJd01pMkZhQ2ZGd1RNQm5PUHFoenNlZE5uTzZZ?=
 =?utf-8?B?Q1JWNDFzdFF1T0ZiVTY1aEhUSi9xeVNWOGRVd29tMit3NlVOeHFWS25INjVJ?=
 =?utf-8?B?ZDR5N2M0dDV4T05GR2xDaW9hMHBrZElaamF2NnAwdTVLaFhMclB1NWRSWnQ0?=
 =?utf-8?B?TVdWUWE3TG9HVE85NHFhMkt3V0habUJlc0VsYXNjeU95SGxJUFBONVRDOTZn?=
 =?utf-8?B?bVBYVHpROHI2c1Vsa1JLVUFMQ2Z6L0J1b0ZKQjJCeHBlU0pLaGUxbnFZQ1N5?=
 =?utf-8?B?amlqWFFoMVlDeXlOaWcyNGF4WE4zMHBZYnRsZUtndmxvamJvYXN5K1lSQzFt?=
 =?utf-8?B?VHhtMXl0YjRNNnJ1QWlxblRpT2loUGFiY20wQTFpdldxS201MHNqbTVwVXB5?=
 =?utf-8?B?Q0h3b2I3V2R0bVFVMmIrTWRJeHA4Vm9odnZxZm9taS85NC94Q0k3SkU3c3Fn?=
 =?utf-8?B?VVExalZyWkRnQnAxdlJPbklhelhGWU51dWFGK2ZGWHpBNXNMRzZVSEJLbVFG?=
 =?utf-8?B?NnlPU2JtdWdwYXdyRWlvdFJkeEk0WnhBR2ZLTkdqVDBXUGo4MlhDOVJmV0lI?=
 =?utf-8?B?dlI1bzRLejJEY1kzTGw3UW1PT1NSVnNnZzFGRzlpQjcxbk9XNExEY1lyaHNj?=
 =?utf-8?B?V0JvTVJGMGZOVXkvd3ljczNxUktYRnZ0N0VJQkE1aU9wYmhYZkgyU1R4YjM5?=
 =?utf-8?B?K1VHTzBTdzZNdzVsdGc3bVVtaDVialhOOVE3cW5BeVJxWWdqYlEvN0plSlB4?=
 =?utf-8?B?Q05TdXNUd0xWV3ZDWGFMVE1yaDlqN3BhQndYZzJ2YXJldENYRU1ONVNaWWZ0?=
 =?utf-8?B?T0llSXBIaTc4MFFxMW5CeFNmcW1NazEyS1RlQ2hDM3JVc1lwTlFsUlhraTAw?=
 =?utf-8?B?S1lrVUZtRUg2ZGRWd05Ma2hnQW1lekE5TTVwOU1LUnpNRkxYcHVjMzV2WkVz?=
 =?utf-8?B?VlpZYTY1SVpKeEtnN3JJdGRrNjR3c09sZUhhSFZCa2dvNFpBQ3pwcm56UWdI?=
 =?utf-8?B?aTkzS0ZwTStkenp3UWNvVUs4T05pWC80SDdLd095UjZFOWRDRFZNYmxVRDhu?=
 =?utf-8?B?ZVFzNzQxampXMmZzdTI4MXFmZEdEUHVjYkhPMm1hSTdrUVlHaUoxaTdXajFW?=
 =?utf-8?B?MWJGWHh5aGo4bWhxYnc3U05Wb3ZCQ0lGaEd2M3VLS2JrNXliNW0vYWp0Zi9I?=
 =?utf-8?B?STYvTEM5c2VkOVNCQ0cvbzVab3JqSE5WWThzMVplbklYbDFxS0htbzNCQ0to?=
 =?utf-8?B?NDdXZ2Z2ZVJoaDk0bnBlVExoL0g0ZnJtczFIdXYvdW5WeFNSZjhzT3FsWTZT?=
 =?utf-8?B?WkVZT1VGVlpFMjV1Z1cxVXZjdWlpMEtIMUZqR3J1YWFrd042RDBXa1ZSYU9E?=
 =?utf-8?B?T21lNWNnRFh2WHpHWlVqb0ZveTJVUEd0aXY5WXpHLzhrOWdzTWFJZ25FUUFt?=
 =?utf-8?B?SU03SHlta2k3MFVvYmdtNGhTQlc4WU93TG5yMU43OVBpbDBGdGVFRjZpQ2lG?=
 =?utf-8?B?M3NlVVpKOXY3ZVNCSFZyckR0VElEUlF4aU9UbDdRZUdSbzdZLytoZVRpOHdI?=
 =?utf-8?B?NS9uU3JhaEtxeWs1dU9HUWx1NGRXT3Y5QVo0K3dtby9BQXhUVjdaajNpQWRa?=
 =?utf-8?B?YWZwRlhjZE94Ui82MDl3amZnMXg2NTIwOEUvQkh3R3B2Um9vZ0xwY3FUcW5M?=
 =?utf-8?B?SEp3TndCV2xiUEJ6SWdoWHlJeFNucGRCeTNTODJhY1lZTGZRc1cwQ0JEdzND?=
 =?utf-8?B?VE5PdGlVYy92MndLZnNwWnVZWGppNFVWSE1mTDBVaEovUjBPYVJHWHRoNWZF?=
 =?utf-8?B?TERXamExUkVvdXY3ak5Pcy9QekEvNUp4NlhEei9hZXpVVXBkWEFrSk9rTnVW?=
 =?utf-8?B?TDQ1TGdOWDJxV2VVbXJZZ09udHFVUXVmeW8vNFVoRFJZamZ5MU1PckZySDBF?=
 =?utf-8?B?TUowQlMrTWZRclhNSnlTVzNramtua3czVG1kL0Q5OXA5eDZGL2dVbWN1eW9Z?=
 =?utf-8?B?cEJuSWNiNzJheVVnY1pnSStKZEUxZmJIanJRU2RqWExsTlc4Qzc4R3ROUUND?=
 =?utf-8?B?a1dJZXNiTHRFd0V5M0gzbU80QW0yWjU0bHpybGJaU284WEVTUm1jeFhhNTFz?=
 =?utf-8?B?SHdCRDVTeTRRYXNKeGVZZ091SEFITVdra1BXUGJ5Um9xSHRJQTZiUUNxS1lF?=
 =?utf-8?B?eG5oTzF4RUtwKzM2SVp0eldvb3o3RWF0aEpwd3pyNWNac2djMk1OdkZBMzlp?=
 =?utf-8?B?Zms4aHJPY0d1dkR3QTRGNmh5SURvWkVDMll4akpOaGI4blVvNFdaNlNvVGxw?=
 =?utf-8?B?SkhoYi9TblVtNUJTQUpiRUtpTjZBcjJ1YUh3WjZhMkcwVHNCdjFVQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed52c3ac-2d9b-475b-2fc2-08df07e56ec2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6329.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:56:49.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kpWRHViKriJn1aUNT0Km3hHSjx/y4KcIu3r5ikYUX2dDkxn2ldOF+SlZUE6n1vFhFc8k4cIJUy7WWHD/WLUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080

On 8/30/26 9:17 AM, Runyu Xiao wrote:
> Registering the HTE chip publishes its request callbacks to consumers.
> Initialize every slice lock before registration so a concurrent HTE
> request cannot use an uninitialized lock.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Fixes: 09574cca6ad6 ("hte: Add Tegra194 HTE kernel provider")
> Cc: stable@vger.kernel.org
> ---
>  drivers/hte/hte-tegra194.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 4a7702b32..1612812ab 100644
> --- a/drivers/hte/hte-tegra194.c
> +++ b/drivers/hte/hte-tegra194.c
> @@ -910,17 +910,17 @@ static int tegra_hte_probe(struct platform_device *pdev)
>  
>  	hte_dev->chip = gc;
>  
> +	for (i = 0; i < slices; i++) {
> +		hte_dev->sl[i].flags = 0;
> +		spin_lock_init(&hte_dev->sl[i].s_lock);
> +	}
> +
>  	ret = devm_hte_register_chip(hte_dev->chip);
>  	if (ret) {
>  		dev_err(gc->dev, "hte chip register failed");
>  		return ret;
>  	}
>  
> -	for (i = 0; i < slices; i++) {
> -		hte_dev->sl[i].flags = 0;
> -		spin_lock_init(&hte_dev->sl[i].s_lock);
> -	}
> -
>  	val = HTE_TECTRL_ENABLE_ENABLE |
>  	      (HTE_TECTRL_INTR_ENABLE << HTE_TECTRL_INTR_SHIFT) |
>  	      (hte_dev->itr_thrshld << HTE_TECTRL_OCCU_SHIFT);
Acked-by: Dipen Patel <dipenp@nvidia.com>
