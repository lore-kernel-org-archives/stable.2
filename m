Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795238354;
	b=0Rz0xDt0BuFJuYzo7c3eOs3E+kYR3P8SXqOro8BJUE737u837HkbVnXonQrqmSimnUNp
	 saU/ojbsTeW/lr2UVFaXWQ/MglyRQTWWnnDXTgsG5PawiIVVZvs3g7j2sQCvwKnuHXOCA
	 Vy4eBUWSwpQEM+Kh5w4i1TSiJJ6en9CoYpPZfGnCJaWPNey7lDOGr1yvnvXfnwXl+8khK
	 f9gcLQgjvOJLVazrjlEPxfRsZvyrkEoCd6cnvNVUTEzv3Oe8QkhZzBo2JVrq8pQgF5Os9
	 U7ID5edWHxbqa8olF1u0jJdQfzNGV5J0miul9nPyuyBsqNV3LKRDSsTf4Jjv04eJOEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795238354;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GUBPwEi7oMaEgzwb1Hi2j1ZA2DRZCp7QdZDE9yZgJVs=;
	b=tYb5j5gqXN2g/Jt6sTyfHhAOq3Wi5PhFRHKh80l5WhwhAYhGy3s/nXA8kXFJ0ufBt+9T
	 T0PHZhNkjYHio0Co359oABQJhg8niRGSYh2JkdcckME3IZn/JP1jtN2caMFvcPV7+Asil
	 4BqhLnkXRW23nUymTzcv9KvnNCFeZiZLCFZtg217gDPEWJNy+qn2SnnniGif00ACDlEMI
	 9iPdSLGmK4lk4CBEr93Rxi7kBLGV/anBRojXp3LXolGqBzLwk4laQDQjXHp75JGGGoPSj
	 clsLbq9avcXfNPJz/jZA3BWV8wC3Ce5F0Bf7AlJt8onBEB/d0W6NH7IKILedui22Zxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mWBZxaZy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.39
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8D606A693;
	Sat, 21 Nov 2026 05:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D8D606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mWBZxaZy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpCjm2gBBJx5YogTe8DsaghiGKC7vGC8KlRNCNQAEzHfMrhi4MCsiMYLMOyWVLHDmFnwTumDTwcd694Oh3k1F05koR6dQwjhyt5J7JbQf49TBnGUChGBsXDm2RThI64yFdu5/f8sQVBUIGjM+31wyUzdFBq6BHEMSD3TG4cprQsdgaBZ6TbF+LEAqxVX7iHInZAWC5C597McIW2RPJLwTloXB4pzj/KIfPoG84NitmzSHoFVrcv/hGPLHs0lUINXU72Eu042tCmsr3X4Ue2pLyE+woU8okOww9O21isPhFohyA6fv0I7Bk6g2V1CF9gUmx/I102PMlyWzjqfmOcM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUBPwEi7oMaEgzwb1Hi2j1ZA2DRZCp7QdZDE9yZgJVs=;
 b=ImbuzGddYbryr6mw0synHCsAUbetlxiMyYXqtVJtwN4rb48+CaGb/uWf+Xiq8KlDY2nJNqT8ahIb1wXmw/Wd5XsiIKg7w4+wNznq1oqFbocNBzuds1OH8NHtuG7Mq01uuy8KQXZKm9GoTtPk06mzAE/+2ZZBHqfrrjp6Fr+arrVZK5YwETlZIBHGjESgJ90HSSHrl9MTLhtqbgAuHMM10CbFqWNTWtesOwq1uyhRI1t7X0vOPfgRvqILeQ+SXSj6iysMgFXC1RraFoWD96j/4WWN2gCE43uj7URSglVR5b8zxu/QbjBc7XjTIvMO3C/ZujnDAb62kyvVP6ncbPUCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUBPwEi7oMaEgzwb1Hi2j1ZA2DRZCp7QdZDE9yZgJVs=;
 b=mWBZxaZy0Gm0jhT4UNgxQwr0BFkikXLdqpvK3+MOBWI7O7UFUEnwCjoHy2MSusfIvtKJlXreK/DZAcn92+jpH6OjSzt4AqFIh2gluOVaZSH7lRqBj+DM5orU7rUZqL2beRa/Q37VuwJZUz6/5IqTmLoZMHQpdA9ZAWaYyv0KzB9nW/NCQgGNdu4F/3Jzno/WUXkU736R8wdsutwEp2bF6RrEV7OqBhG2BSe+4NJm3oE97A4/CUnN5Qbjn4YL/Y4vfBTrHAMasFvDvxg1QQnbG+9xXZK4+DenUAU40yKkZTaabRGg0lFu2fdusyqYIEtoIRxbQdlzGsyO/LeUhkHBBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 05:19:05 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 05:19:05 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 7/8] gpiolib: let the character device free its IRQs first on chip removal
Date: Sat, 21 Nov 2026 07:19:01 +0200
Message-ID: <20261121051900.4118973-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121044657.GA17013@rigel>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com> <20261120-gpiolib-chip-removal-v7-7-aambrozewicz@nvidia.com> <20261121044657.GA17013@rigel>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 067d1c6a-6c28-49d7-5cf8-08df478ef60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261026140227099003|261022105027099003|261022075727099003|261028144727099003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wT32pMd5iW0279BTBKlTPnybw8xvojDyfCY7+WxHmyPd0FJz3u0j+9evqDqXLFacphH1y1RRAg78poXTjeieYikmcXV/42WBP37VfJtwEU5SQkDHuJTBsHGCD4b40cJxEawdbVcPYS33PtN0RQZWasA8/Ujk/a3mTZuomw102MK8KryalMiBSgQKkB3dx19KS9yzxOpkXhBe4985uR0H3lVPa+kuQf/JheVGt8Ps44q6pfjdtAzmbCfpBNaR2GAb5X4rnYGE0ysf6TPIGe5Y1XdT58GHnOaJW/HUkwPTEA5JnkLk8t9UFNqxeYkiWRtSL53nkJJagoQuXu3yJmJCl97UyfkZaQTSxSsHCp0pTemBn6d7GpaLb9LLD62FM3IEnDmVn2vVELeFFpAjz7LtTOSgB2JsI770BX2zQ5nOC40og+8c7kCfwrpNCOZDd8pHVK/wupBE780+GDls+LDnHxT2f57XAmlpWEcqdqbTGpkV3PlH4hQltqwu2pjK/3ZtYXglDJbhdYcCa9/I1FS3DJ7csKa7Ch/ngZFafRvmDZywz82kk2WphGuqz3cYAZ7bXk7PeBsBIzihPnw/+hAL7PeaLXn4iJe+noGrzx5vvylxln3deyWXkKUZ6EVZ3K5vYqySSGLHsUZ/1thqv8rHXd7NmHw+IX3t+VO1345C/MM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiK9eqhI1z2yMjr3pQg8raajs17YbIpotIncLPEqNns+Bk/rLDYTCxJfr8F0?=
 =?us-ascii?Q?qv/KDKdvbmGRrcAeS1UgoiidkfL1gb4iNau0S6J7WfajMxrYncV3Ak7HlskT?=
 =?us-ascii?Q?aoxP1nxhdbk+7wXv3ugyNQNaccwi1YStBs+AsHJaU4+mDHva1Pj8lHyJ9cmq?=
 =?us-ascii?Q?eXeUZR1QO0uNrxEWYOwQhz/jWoyjzWp6g/HqztDtNOxsXumsL5VZw8pshiAa?=
 =?us-ascii?Q?zlMOk8C2H+fG2EBexAd1N5B/J57hoCiwGnxYpS67xdz9+pkL9Mrik1bQkcMG?=
 =?us-ascii?Q?Mf/VlQ1oRo09MRuAEzDsWf5eDjU87gkCGkTKevcHFPeJE4Iu5vZFncYsDb5n?=
 =?us-ascii?Q?oRCB+zC9QB3HEvf0Zf65v/gu3LNSScetCLyfU/Uh2ryrMKMzFgx4SZkTGiYP?=
 =?us-ascii?Q?yaVt0MTL4s9sgILiEKW6fc8wbeMagZIVwcgMio8WXlVIqyWAv4XvhRyOuTvU?=
 =?us-ascii?Q?vG6ABE0H2N26BY86IdEvtY9trUiHIwMZJe79K9/Z1I6nu/tDDp+CbxD7kmay?=
 =?us-ascii?Q?gMORgXU3V1WjIUvHFyXHAZdyBnsM8o7ODzyXDwQC3hSQ8Pd6OsADYI3Bzv05?=
 =?us-ascii?Q?K+FgcfmTlMhgQX95lmofKg3eTNzG5x5UaLBCHH49FXsEtmNKlAsyqKpxc9qj?=
 =?us-ascii?Q?6jRO7XOuFAgOqOLG9Puy8J6mZxyr/LFK01ETkpxDdISxsQA/qNsAz8JuChbW?=
 =?us-ascii?Q?h48Dr4ueEG/9OgGN0n2CLbMzKM3Wwkti412pAJkNRxA9dRDJIHPrPQ1vIHhY?=
 =?us-ascii?Q?+4ps0ZE3IqLmubLmew10fa3Aso6s/7gV4oycMHHlIhlT7sc6uYb8F38cmJwj?=
 =?us-ascii?Q?Pzh/FaB7fTWw6F7SkqkTKwYMbHqJ4oTD6Ml4sgg1KfLInsDGDCuAyeIhUQ2W?=
 =?us-ascii?Q?3BEtJphr1CmJLWC9iYUs5ljvaSZI8/4/SP+iBmJDy1DxPGRebZe66wbAT9Te?=
 =?us-ascii?Q?c2eawSn+JXcA7ty0eLeHaLJHYjS5yv83nRoIfNDtpGERZfkPvrJ0kNZVGT4T?=
 =?us-ascii?Q?hUpwQFgTMRZD2Hcd1arrGr3aSQYl2n45edO6fCsuHW68lJGA3FFDbf765mLj?=
 =?us-ascii?Q?umM07aJKb6iCjEey+NSPbp/ZzZNMxj8bOk4CqFFwiIhCi4kqR4U5P4mNqnuq?=
 =?us-ascii?Q?kYPWz8S2ilMCy46x/m3XVnnLaux9OuJ4ldXGXXFUh35kuz2s2p7wvgdfGK82?=
 =?us-ascii?Q?S3z0uOu6/4w/KZFJPI58UrPrISmIkHgGCxm8a4qEkzFpPVY9NV9GsOJZcWLt?=
 =?us-ascii?Q?mgVIJmtCQAmbrd3z3qRceF9PK4gjKcPDU8FPNszLehPwXj0K/EDyMQm7n5+B?=
 =?us-ascii?Q?eyPzaD2GbaRKXt/RJbB5XYnUxjGEQXchKOArRyh3MkfAkNr9dXPFoyrc620U?=
 =?us-ascii?Q?F0VT86bv9us5QbAs4HhzgNIJ/RgtDVVH6sobwsoaZqMK6qCbHM8G3VvU3D89?=
 =?us-ascii?Q?YBuFxllpfbcqwMsIXlXF/DtFaJKeMO9G+3I9svLEwEU9mjH5a6ima1KkMQ/L?=
 =?us-ascii?Q?ZoMy6CHzgU5w92uPxFrzeIh2kuE2Yhil3rhp9vBZlOf/fAVlN8iKXKhn0C9a?=
 =?us-ascii?Q?6peVJJjePj0TvK/SCdp15ivqQkaXWNvgARyraogTUyhkNEf4OBSoaMUvZn0r?=
 =?us-ascii?Q?hD8GKzl+BfCY4Xi99DnL/ruMEy36mmdCRxk0XUTxgE97QQZpPHwbZIjCY1Fm?=
 =?us-ascii?Q?TTxdD9cfimikqMgJJUGypnFvJKctsuum5AjV2fxUiWD7GfDrlaGhnY3j2aWg?=
 =?us-ascii?Q?3E/86/R4jw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067d1c6a-6c28-49d7-5cf8-08df478ef60c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 05:19:05.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJP8UKgaElRUXnSakO5cg6adyGPSRG4aVs1MqBiuuUDWbHKHyXP671G3WhQz3Lr2TOo3A0j2jGrMZAkXFKjUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017

On Sat, Nov 21, 2026 at 12:46:57PM +0800, Kent Gibson wrote:
> > @@ -1690,7 +1697,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
> >  			return -ENOMEM;
> >  	}
> >  
> > -	mutex_init(&lr->config_mutex);
>
> What is the rationale for relocating the mutex_init()?
> Looks like a gratuitous change, and if this patch is going to be
> backported then it should be kept minimal.

It is needed: linereq_free() now takes config_mutex, and __free() also
calls it when linereq_create() fails after allocating lr. The first such
failure, kstrndup(), returned before the old mutex_init(), so it would
have locked an uninitialised mutex. I plan to say so in the commit
message in v8.

> The lines removed/guarded were added in patch 3, so note that this patch is
> dependent on patch 3 in the description[1].
[...]
> The line removed/guarded was added in patch 5, so note that this patch is
> dependent on patch 5 in the description[1].

Agreed, I plan to note both dependencies in the v8 description.

Thanks for the review.

Adrian
