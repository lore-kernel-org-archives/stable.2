Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794794004;
	b=Fhyy9RaVk0U5Kj1wuFXpg9zExZOLqNv6TFu0bQzfLGQ1Am7EQPSOQxiD6Y3Nh2qtUG9b
	 +YJAKMXBWdZvZzYtW0msZ+HQpE8f5DiJBLJ8b+TYpAPhcDfCLw9upGSP1uM4nFzPxlyUP
	 B6YrShPFNc6iY5KDL1TfpiWIMHLXOFtYMpI9HYIRoFK+nfLD9m6z9hIMNBJAjfMr90TU/
	 kKEu9VwjZ/LAjbrJH4eJb+oAruHyrXrUddWBB21knA/fwMWuCdVNsUxKTQXWeD1kz3pm8
	 SvhvJ4lSbJILi/kg8Hm8/U86eH2O+6pcdLJiskZ8BIXIaZZpPYzZBjOSmQlQXigMFlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794794004;
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
	bh=a8H3m3yWaEGF3JkwOlbMG7d0QM4c1Yx65Q3QKHkV8vk=;
	b=BqFFvhL3NzyKyGalpGS8rYLAi8YvT9NONxKkxQb0Z39c1Da52kx4lEKc5s8ARLu8k62R
	 abG18Qf3zF09Xynvzek3TvgdiLw/OFtyuGuscopdBg51GHNNo70hay7ebw/Mtt1TmMl3x
	 HNiWpuHaGolwW0HSAwlJEO/RvNDVNZdgok+08aSdxatBKpDDbt/UVJYMRoJx7TsVVvAAK
	 jjF2nNswX0pmWsHY9380UD2SRrMA6DZAa+WWDkhAWC7vmoygVZR8Jv+Cc8Km3QQZqRaew
	 TX5urm3nk1nE7k8Mn4uRQHKrH6sshouUjFn5kilDnOMWaki/o9wBa3qgykBuQsVYDng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FKIL3XaP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.68
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED671606A31C;
	Mon, 16 Nov 2026 01:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED671606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FKIL3XaP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP8x7gPjBCn+620tQIB+hw8Z8015O4Vq4AtHYRmsxLdA6t+H8kyYM/PkhsNw0XAQc0mnJHNwem52mA2VfehfM8D50S/rC6WhOVawmiQF47mD+7vaHEaPypZLlaMwzKfHIA1BsmF4vDMdD8BoK96kewzyOADSLA6j9dSs8qMRU278M0iwf1zaI3JvuuaPnDESHd3RkiwSmb+UtddtIC9/XymMbS/I2iWUJGjDroDM++iGC9iyDioAVhZghsxnlKc8EM0aYT7UV/jOZRHP538tnmP5Rkc8MZlXfOF/cCRjKsZN9neoHu9UShz0q/StHDjl9nzCGUAbeUNQRNwuVZkcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8H3m3yWaEGF3JkwOlbMG7d0QM4c1Yx65Q3QKHkV8vk=;
 b=S9zM+diuypjhYi0sZrEa87wFn4EuqpXFZ6hPVEu1F6KrmqP07GxhjAIZpO0auKBTzA1AutVOBZ3/Au3TTto+k5ObiZohWmeR7lRLD085X9cjsPrp1egfxt1f86pCWabbMy+ETKbn4129RQRKKK26q8vMrKcMTMPq9rr4jfeN8C60oIHrE3Kgv6eDjZ0m4Thz6uLCcXG5Y52O6AnSM+WBjyNKmxuyHloDqDLk7eliPEHCSy06mYa2V+Q7rT1+nvcWWYnEpsVHR4ujB9KEZUXsAEJ3/GkFZw018bAkqYOaFLycfPc9vyB8CNWsd8PeooVZkpkt1XH2kA9bNV85lOYX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8H3m3yWaEGF3JkwOlbMG7d0QM4c1Yx65Q3QKHkV8vk=;
 b=FKIL3XaPHfrTIG/zzNJgHhDN0UEHffa3EY+xj3RBlThocH7nwGMmp2/pycK5WFmvc5DXBhoaHH+o4uh86lApqHs6SZ5LQ0FfUauj8r7OH2IaODyaBzi7U/TVUHP/sHT6kzIyF+C2PUD+Phm1vr8EuiBIy3VhGFU/fhLPUbGumEzy8aOVrd3qfGr0jGHO8PX4yXU2dEn7MPkH9JcWKoMaNlnbGOKYn5woQ5upOoAkJf5OB4v1mxcMCceF5auT/D585ReHkTz5ANSyaNGjYYWtFl73iGizE1cOiODbWJK26apT8PMy9/TwxLfKlZHMq6L6nOCiwD48xQQGpgtSP/+JBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 16 Nov
 2026 01:53:19 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 01:53:19 +0000
Date: Mon, 16 Nov 2026 12:53:13 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avpbxk6pzvh4hoLG@parvat>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-1-50a2ed382b61@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-1-50a2ed382b61@kernel.org>
X-ClientProxiedBy: MEWPR01CA0133.ausprd01.prod.outlook.com
 (2603:10c6:220:1d3::6) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f6afa2-fd97-48bd-e0f3-08df4384633a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wfk02XWPyNsbgYnSIPycK1MaVCo2P4iLpQvBBA7RaZleDWjp/oQkAOMdOyKYtBCJ1YyfUTnEH4C+qXl1SoMLjQ8m7xd03WkuXDxEHlj1aJr0VV16SRpITW1dx9zdEydDtVJ7mAZt3v/nYaxA2s/gRGX1pkSrXsSREUm5q0G/yWnVswQmxzlwmUOxBqPa6Dwts+Yh7YrvVCUCvglr+zHckmGNuLpkxULWOrHQNExf+fq18hN0IJpyOqvpVl8eqySyJT0BdnsLZKDxxE1QENe676FUzqqyoPKxd7cgNZUzObCCTjDlA2svx0oDKPsyc7lXV2jRRMOw+N33paDrFXEC44q81QGBYYZzj0XxwRSfrILBNfXHo8GRIXQNQPX6lnfMTaXdWrt5KZifl7cPgFIGFEkBJTL5wmXreurLDtPV243Pnp1Hc6K/aCJ9Cbpmmhbp9NNGkFhchDQuCtRM4UT+xEYyxiyvIRC5cXKPnmIHu1mcWtpsEg8OJw2MjjD8rrIpPiS6ussPQnGzxHXXte/YqdeIjbzrmillVhaa+uZgvvYOJsnf7ULR8DL4Jx/Vqda/dGn06LqEYpR/+XarKyZhUBcCO/eldJSGfuzDSU9yelLsh0pGigknymK6i5h1ZZ0zcRJBGqtqXdp1WYd7kOi430ZMyvYqX/da9Gka3eRv6S0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUtqQTN4NWFJaWhlOVlVYXVYdE5YZmpJanNzVjhnTUFJWkxEVTd2V09ka081?=
 =?utf-8?B?WHlKdktMTUttVlFaMExxRGNlOHE2cWlseFNDTEh1VjJPUGZsOHQrMlBidERP?=
 =?utf-8?B?RmRzaEp4MmxBK2NUaHBhU3FaWmE1RVNLUFgrMXZXdmd5cWtoSGRoWjAvb2JY?=
 =?utf-8?B?VHh5Mi8vRjNuS1NCRTRoRHRhWkRFVHpBMytUcldIam5ib04rQktQUk9SelBK?=
 =?utf-8?B?UjBNdUJjaFdQVGF3eWphL1d4TTVxQkVpbjhIRG9KMWpFUnZUQTU4M3I1ZzNN?=
 =?utf-8?B?dGFCdDJiNXJJTUlCc21VN21NcTBOM3VqUlBCRWZqcFJmM3ZCNjZNb3MyRW01?=
 =?utf-8?B?Qytrek5TVXhiTkczQS92bW5HOWg0YVBMN2txNncydlVWVU9SSWc2NlFMT3lB?=
 =?utf-8?B?aXNXdy9xVjlBM3ZtMS9CMlhpUnlzekFwb01QbTJXakJEb29XYWZNbDhBRk95?=
 =?utf-8?B?K1dKM1Q3SXJ2bVAxdVBuUDkyb0Rkc2lOL3RTU1p0V2JCbVJQR0V0b1Z1ZTBD?=
 =?utf-8?B?T0U3UWhKTHNWY2dXcE5lVmkwTFpMc1hWWDhwaFIvYXM4L1ZZUTlvaTVLNWpi?=
 =?utf-8?B?NVlKU3g4OGNGRjFTUmRkK3hzTVRsbG10ZjBJQmxTMVNLS2ZFODZDbmNCOWNr?=
 =?utf-8?B?cnRxWEd2OGpwYlY0VEswb0NaREVtT1puMHk3aDVlN0lIbForT3I1bFk0OFlJ?=
 =?utf-8?B?NjcvS0dlNktMMGZtaUJMNVhoTTJyNDRhWVNHaHVXSGwyejVydlhibTJyZTdE?=
 =?utf-8?B?U0praXdsUkpIdW9ySlJ6R1g4TVFkM3hoQWtOWXJwN2FEQm9yYlRqK20zek55?=
 =?utf-8?B?NGNnb0xKampUYVNwa2lFRHpwWDNoVmQ2N0sydWV3a0hYNHlDamRoalpFa2xy?=
 =?utf-8?B?UkVtdmNFQWNkU0VST3RQd0prRTZmSVZqTXhZVnkyNzM2TjB1RXNLS09qVmEz?=
 =?utf-8?B?RDAwR1JITmJLUzlMYmw5ZTNMckJFRWJlQTRnN0RGS0N4cHpTWU16dXA5OW9X?=
 =?utf-8?B?TS85WUFwcGJDTXQxZ0k1RE9YdFB1aUFyU09sZ1d3QWZBM1Y3OW1UM1lncDB5?=
 =?utf-8?B?WDRmSEVMTHhBQ2hMbStDOExNV29ldlg0MHhlS0lONmRBbEpjeHV2Q3FQSnNj?=
 =?utf-8?B?alpXMk0xMHNWRU5IRzk1aEs2NTBzMmJHN205SHNGMUpSNzhxMnhobzFaS2xS?=
 =?utf-8?B?OGd6U3BjTVZMWFZrNjRvZnh3bENrUXZpVVpEQ0lLT1E1Q3F1SmNpQUVZckJR?=
 =?utf-8?B?dkxPcHl1a2IwZ0J6NnpuMG9HY3h2T3dWc3M5eE1KbHZkcmhzVTloT3BDVFdK?=
 =?utf-8?B?ZVhaczRLL2QwMmtVZCs0Y0NybzNNbldZdkwrYTBZc3hVbjYzWFAzSXBWZnMz?=
 =?utf-8?B?UThlNUVDcE9SS21aKzExa3pUR3pRWFVRNk11Uk9ieGpLU085UW82K21sd1BE?=
 =?utf-8?B?RHNUVW03UC9kczNNWUViRk9yY3QzSlVWeUpCRlRBZVdOM1Bsbkc1dmZDSU8w?=
 =?utf-8?B?Z3ZrOThGaVdvTlZDY0xVS1NqRm52azBONWJGWXJGemZXWmtySDUxZVhGWnp6?=
 =?utf-8?B?VWc0cWZ3UCt1dmNlSnhlZzl3L1Yyald6VE1xeEhVN1JyNUQ0RGxnM09FZUMr?=
 =?utf-8?B?MHpmY1NnWXMrNGU3ZCtSdzcwLzFrMmF1MW91K3NwbEVLYnhFajg3Z2NOdE5y?=
 =?utf-8?B?NzFLNEphN1g3a094V2tjY2VlbUZaYzBiT3hOZHZzMTVKVG1LQzgyeVpvTEJs?=
 =?utf-8?B?eWF0dzhWak43NzFueHNIdzhjRHk3MmZja0I2UUhuYmRBbkxwdEVNYWtwVldq?=
 =?utf-8?B?M0hWUGNHZmo5ZnBuejNRREl5VkNBQTU2ZERWWnB2MGpwSHZaRVh3K1hJWHB3?=
 =?utf-8?B?OFJVbjdlYzR4Y1gxR2lkWHFCZ01lbjhzNWxqNjJWVUFzTXR4UmM0Yyt1OTlP?=
 =?utf-8?B?NUx3dVFBSVNmbStXZTNBTUlGMkp2QWxHdmU5cTV2alBPeERiV2JpbFR0OU5K?=
 =?utf-8?B?MHNTemk4ZzFudmRlN3pnMWdpTFoyQk1nVlR6VGswNnc0M1V6d2t2TGRHNllL?=
 =?utf-8?B?MXNZVWY4eDBENExmc1RHVUREak82VzdCd2dIeEtYZkxGZFpWS1hmWWJJanh3?=
 =?utf-8?B?L1Z6VjI2VDBDRHlMQ3RWT3FUZWQ4dldUOUs1UWpkUVIyK210VFdzZXo1di8r?=
 =?utf-8?B?UXFzcW5pK0RNYWZiL2ZJK1lIMmNxTzl6blhpUkpONlYxWTc1c2ZhZEk0WkpL?=
 =?utf-8?B?UlEyZnZXT3BFRFAxSUNQQmxMZzAwd2xBeGJHRmNMTWhQL3U3S2VJbDdvNEVj?=
 =?utf-8?B?V1JUa3hTeHJsRlhkeFRtL0FxS1NYdWtHaE5UeE0rSWdld3o1QXoxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f6afa2-fd97-48bd-e0f3-08df4384633a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 01:53:19.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72VXu7G5GZDjm7ABoH4uMFw4qqnxYrUtiB8b25XgXllM8tFUU7D0bsIgFj/FKa+8rm7C0BZSTRUkQI40vS33vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512

On Fri, Nov 13, 2026 at 09:45:19PM +0000, Lorenzo Stoakes (ARM) wrote:
> The OOM killer can quickly trigger again after having selected a
> victim. That victim might not have freed its memory yet, but its mm will
> be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> 
> This can cause the OOM killer to kill an innocent process when the first
> might have freed enough memory to relieve the memory pressure.
> 
> exit_mmap() marks the mm MMF_OOM_SKIP once unmap_vmas() returns.
> However unmap_vmas() does not free the last batch of pages it
> gathered. That is left to tlb_finish_mmu(), which runs after
> MMF_OOM_SKIP is set, and the batch can be large.
> 
> Fix the issue by freeing the gathered pages of an OOM victim before
> marking the mm MMF_OOM_SKIP.
> 
> Note that the task which calls mmput() might not be the victim - if it
> took a reference on the mm (e.g. ptrace), it may hold the last reference
> and release it when it calls mmput().
> 
> Therefore we cannot rely on current to tell whether the mm belongs to an
> OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
> unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
> mark_oom_victim() sets on the victim's mm, and check that.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
> Cc: stable@vger.kernel.org
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm_types.h | 2 ++
>  include/linux/oom.h      | 9 +++++++++
>  mm/mmap.c                | 9 ++++++++-
>  mm/oom_kill.c            | 4 +++-
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ed35d258d2e..09e63ff12b04 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2030,6 +2030,8 @@ enum {
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
>  
> +#define MMF_OOM_VICTIM		32	/* mm is the oom victim */
> +
>  #define MMF_INIT_LEGACY_MASK	(MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>  				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 00da05d227e6..a9390cb70541 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -76,6 +76,15 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
>  	return tsk->signal->oom_mm;
>  }
>  
> +/*
> + * Use this helper if tsk->mm != mm and the victim mm needs a special
> + * handling. This is guaranteed to stay true after once set.
> + */
> +static inline bool mm_is_oom_victim(struct mm_struct *mm)
> +{
> +	return mm_flags_test(MMF_OOM_VICTIM, mm);
> +}
> +
>  /*
>   * Checks whether a page fault on the given mm is still reliable.
>   * This is no longer true if the oom reaper started to reap the
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7618e72766a5..4cb18b217048 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, &unmap);
> +
> +	/*
> +	 * Free the memory before marking MMF_OOM_SKIP so a re-triggered OOM
> +	 * killer will only skip this mm if it's already freed all it can.
> +	 */
> +	if (mm_is_oom_victim(mm))
> +		tlb_flush_mmu(&tlb);
>  	mmap_read_unlock(mm);
>  
>  	/*
>  	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> -	 * because the memory has been already freed.
> +	 * because the memory has been already unmapped.
>  	 */
>  	mm_flags_set(MMF_OOM_SKIP, mm);
>  	mmap_write_lock(mm);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5d48bd862c27..9de57a23893c 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -752,8 +752,10 @@ static void mark_oom_victim(struct task_struct *tsk)
>  		return;
>  
>  	/* oom_mm is bound to the signal struct life time. */
> -	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
> +	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
>  		mmgrab(tsk->signal->oom_mm);
> +		mm_flags_set(MMF_OOM_VICTIM, mm);
> +	}
>  
>  	/*
>  	 * Make sure that the process is woken up from uninterruptible sleep
> 


Acked-by: Balbir Singh <balbirs@nvidia.com>
