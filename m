Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795800393;
	b=p2+F8QC0VmV7RdGZkQVjGaAlsPZWHqWjsjtBwQzOLyuLZbEJAt5jTyJVXpTw7+jfW3pi
	 Fe2h4IUxDxKrpbPdMzVNubWZkSeRsfgjY7SU6eLI/8Y2yyY5SdCOaBth1goHikwQND59v
	 ZNDmGOnzkq59Tn8lv+RPzT0xMyf1z5WtO9sGJXaqAdGaAhmGMWmIQ9BQynNVYQ7HxSrHt
	 fGItljgUekxDASkB+m7lnly57NAaPvqQojlM5teN6ryZqGcI5wNdfyS5LVMTErNaRg1XQ
	 fpAwsRqawM4ckt5P/hRjohxgiAM6bOQg5JUUx8L40UqfUxIdrtyWuVg5OnXv28xKTUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800393;
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
	bh=gnytq53uEZOsNxelO5CL/IM1UaRZgDtTKviuNah2VDs=;
	b=UlQJCO4mOhxxalmHWjeQJTYh12wMG1e9cQxMK3Hr/WvOdC6T6YpJR+GasImqrBLiLoC2
	 vy9FVI5Tn4oJnX3OPzu+lPdTyebXo9cxaNk9r/xkHbX/Jpk7Eh+LDHr3ExT/ZKbl8B7au
	 RFotJ1A65yO4wn/Tmo66wfgO//y9TOFB5/Odot01Iqr2Y7ukAgSeNlG7zK04P3OYj8RpO
	 hjizBCA+Q72Ks1aO9GImMNKJCA5RykPxC7iAogWcr72mkBnsMDsdLLEtRy0xbeC26Sg/c
	 Zhgxo1vhcyIwM5iJans4cEA7IIMOU6K/qMndCPbhK5deJp4XPcIrS9NLzlC6yqG6rnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RYReudYV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.46
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA22606A31C;
	Fri, 27 Nov 2026 17:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EA22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RYReudYV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ue4Ybh+a/NetfTYijsDB4GfhY69CaEX7xSFXdOVkFLNAqsV+V7CqnIJ7ESQudFZTSLBXcwEA9qq17q6L96pcaIbY9Oc6Bt92nCsGxkYK2G+RQPE4S3cKGxG/x7MXDIBshg6RlMRFvBVJ1yA/2+0S92piwJHnWh/6JAdZF75Zqa7hx8EztreaFcaGDYVQTqhBJqt+aH/toJGD5QaqQ+MaX2GV/yVJFrhuDLAL5COAfob0b2D35cfPvqDYaqs28KOZEuEjfU3nDcFV0tbXLTKEkxeofzeeBxNUXaNr8phVtLTuZRY5vH5J7O+m4BX9tadykJmY5gbk7g9diMfPRt3sJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnytq53uEZOsNxelO5CL/IM1UaRZgDtTKviuNah2VDs=;
 b=iFz+ircg56I7G84Dc5YYt8ZRLZmGcB2U0e7gUT49E3q0+nJ55hsp7UbidC7Tf035fks6PKlwD1/7p1Dly1cvNMRrxKYeux+aFLNhBLERC2DvWoeDLUM1fMaxM0jZ4Cq7EwqiHvUkMT4WKJiW2NqtzSCWpg6vl5UOGRvk733FVkMm8nQzyPlR0V0z4uhEvT2mix5rKggtfpjVoMRgCYDns5plAotCjI+x897gkFCfMYcMYv6ZdYzn13Co6pdo1CB+pVLaDQKXlO79SDZObzDPO9qnRla9scX6+eB+gzuQ5jR/IdgsD/Uggl7bVasznaVuRXlGyIejAsd+1yFs6FIwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnytq53uEZOsNxelO5CL/IM1UaRZgDtTKviuNah2VDs=;
 b=RYReudYVO5AVH0i7Dvc70+F7nQTrMYGw3kRXORCc2mkshe30s3gTx6AUFGTGn2RiE0STQdBjbNfgpgy0HRe3ABBFV7utfV8sYE31dqIwAOL+F3FX2o4FQiezuZAMC1lFqI0cQd+bJrAHLuZq7VuEL5KoyxbqnqmHdruqcLe/wWMcpF7CQakmrVxImvwQphvd2zgpCPv044fFt5Elncf2RavnquoEsx8NRzOEfum4xJgzBFWOggRUO+r1ZKf0uEq3Pi8C6uBNTKBXcPiFVvN2s3tYABjaNoyOp2iaQeu8jZr7C0EcYu/VH7s+GpOx3Y6hbodG706uCcMiY1vil3p2Tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV8PR12MB9230.namprd12.prod.outlook.com
 (2603:10b6:408:186::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 17:26:28 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 17:26:27 +0000
Date: Fri, 27 Nov 2026 13:26:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
	Alex Williamson <alex@shazbot.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
Message-ID: <20261127172626.GQ114472@nvidia.com>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
 <nohVXMHveO5nQuD8sOn0QoENkIUC-GQzMCh8HTX6v2eezbtW6OM5gX5JwJ7_MSwfWj3bC4Zmfz1CrxTDKJeFGg==@protonmail.internalid>
 <20261127142912.GK114472@nvidia.com>
 <dcc8689e-41bc-4a18-87fc-2fa76e11eab1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc8689e-41bc-4a18-87fc-2fa76e11eab1@kernel.org>
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: c9934a91-bce5-426b-a35d-08df4cab91b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|261022115727099003|261022105027099003|261026121527099003|261022113327099003|261102123227099003|261022075727099003|261026140227099003|261026130827099003|261028144727099003|261021121427099003|261021123027099003|261021130227099003|10067099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	TQjVdIGEgmptAO5XLhFdw5iiqQlnwi4AMJZXhiaktSq3YI9KxHDVz6/6aVLrqVTk/+6c881dLQqDyOtiiGWFjDMDsjH3+6lz3wrU0O5/uts4KKi3DixgyeBeBOmWhdFuD5SaXiB1XfdIpWRuJUEF+Jbvwqyu9BhJX6JnkoGbJJgtI0ruUk2NjqotqflDjbiMwLBmzpnhCnfv/6A5bCFIli3sYefpQHGih0PL+Y8cXavHUPb3CW/Ye4igdv2nMqtzJPY+T1cvYs1lWezmG7FlV9MQbUw3THO2+TQ31NWX9pFn+PLzyCKG8FFqtcb7VJ/LyHjYdB0pv84izOL+U4+aRaaqPXvGWPk1dplHaVGW4YUbzvPkQmWTYXBhXBytG/Xj7QVZ3uCnppwY5OI41tn5LT3UZQ72xV1SPdZfi5RSUoHXhUrdnH8KWJCRQEaZ890rjGl7WQu8DfZkFssougvYhzDtWWutNdmAMTZuhMEjFk+g09r519lIY3b7SjwQ2w2G17Y2kkpGbMOiz20RwtRalSmdQ+yumICgGEbf3TCU+zh5PUCCehoopWTvYi/3PdzqCTxiJxnSCQJ3TOqKIoc9ztxfJynoJPHhRLExPu6WmrDoMzYVXcaSdEh3ol62WJIoOs4qaaalWsr/zCtSBQdxJ8pBJWLQgmxkWboIC9jeshw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022115727099003)(261022105027099003)(261026121527099003)(261022113327099003)(261102123227099003)(261022075727099003)(261026140227099003)(261026130827099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021130227099003)(10067099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gfA0zpd5iUjimVxT2SKaNDPqB8dZU0715ejLvavD5UNhnjHqBUJy/CHvwHh+?=
 =?us-ascii?Q?5C8XUXy7mAM5ezS+ceBda5Lt6LpiC29pPfRvn7IPgnmeUK1CbWtsBGjOTCIr?=
 =?us-ascii?Q?7ULLQQ1sLhUTP1f02Tgy8wFomsK7GdnYTv250pm/PWzPXSK7T8Maid0vKBtv?=
 =?us-ascii?Q?wHux7Aa9XJ4qUaodIxkCx7xIoHpbs81QemoAUPslaCfeL42ROJj8SKa1yrW/?=
 =?us-ascii?Q?Clt2ZRW9JJ2HlrAnpj9pshGEMGK/J0q0S7kmoFmieTCo/8LqXdgs3w5DIlDZ?=
 =?us-ascii?Q?j84tMXC43PWVcyRxQTgj4mHHAneiPoVsdumFksDa3T1VPJIz9tSvWJgEghaP?=
 =?us-ascii?Q?HeQBK0Z2udmpvTQ3JpgYXxrf5MzetwvjLtojLQTwiEhLEmjskDeAy1lUZlV8?=
 =?us-ascii?Q?UrDOpray+ZlZiKa9yIQAwetTv0ZLnJO4FNUEu5L5gw7MnLaTyEgdL+Ra8O12?=
 =?us-ascii?Q?QG8OYhUCzVeWHHPKxfqzwr3c7yum+PbG4/kForbfO3Wm2ZBMx1fnE3y2KoqO?=
 =?us-ascii?Q?Yrd6kbiBrSy3usAgc46JHcqyRVHiVsbud6C9otavvXzK9XLIFo376tSYSilc?=
 =?us-ascii?Q?VBfUsrLA66PeUeak/KHqriarMmQ5VTyPeo6CaIk0QWHrG4OJRiGHjddyS40Z?=
 =?us-ascii?Q?nySEUMRNNxmAIiBoPK/J8qZyqGb8gJFDA+YaNoGchgRi3tsatrlFo2djLzCO?=
 =?us-ascii?Q?xC3ju2RH2t2F94GxZ+wt9BIN32sySGdNrXZRF2VJxhfkcX02zqfl9C3PyEuO?=
 =?us-ascii?Q?SXlO9J9pgwEUUICs4us1fhxBtqBjDrX7txjl4fCfYzZCrISr6amsUxaba0/m?=
 =?us-ascii?Q?JQckcIZ9k12xP+tbRweI4DtpcGpzS3HeKa9kuWuF7Zcg0gXM8R/47IDpWieh?=
 =?us-ascii?Q?rqDLbRjMt6JMBAO/bS8pl2PfXfJCoNaahxXck6ebLl+TRhUgE/rY4+BEQ8XS?=
 =?us-ascii?Q?knyaMeQwYRQaYfrn3Kto/9nyfIDiL/tdJoEKKUngiBO506F/XtshdrwSNH4q?=
 =?us-ascii?Q?5Q+pVCGsWEiSupNUDqad5EyGqrIl3LnUP6ZCE/rjBHGoglnfDSBw/80qpAm5?=
 =?us-ascii?Q?u62urB3cfSWuZ52EBEfNBW4hyuVDCM4S9T63V9TL5o/MGf672ic/r2Le8OpF?=
 =?us-ascii?Q?eHKVRB5uGagPELhyfZzjFF1LTw6J1CP+I5IRM9KuVlDppKyK3V+dhioASLeN?=
 =?us-ascii?Q?8TzkJcssZOlzZ58beI3iuuBqImR+bLzLrFCYORQ7YJGqtgNKRt75K413u6t2?=
 =?us-ascii?Q?V/RJ3/+xV089csJROo/oDalcdPN5qNgp/LxtbewNZAc1wT6a9gRWzGLo1Ynw?=
 =?us-ascii?Q?V/Z6TXZkdV+phNyjz0y84rG9GPNPbweV28Z6t4ykksLuEhOYPSVCDlUgJkVb?=
 =?us-ascii?Q?QZoZ0EjuLX8ozeTGwYWe98et25f1IGpC02NxiZPO7v9CehaysHvzTAQtKg1d?=
 =?us-ascii?Q?4sLj6JigeMYFk9DX5x8lQ7pGSi46HkCZ5Net4VTaHJ0tkz7BwGKP1iXHeBBJ?=
 =?us-ascii?Q?r3Hb1oknIlr+d1L+JMvvtGR4uxgbespoqGaKf683Zwb7FqK5NciC/JooYuPY?=
 =?us-ascii?Q?Mnp2WaruLwFeMJLKLje0a2o1ImeMR8Jq/RhII7mLYKldRYmGQf0GgWo4Nc4F?=
 =?us-ascii?Q?HfYjiZrOFeDozn2sXDchSpd55L9ucq1IjzVVxkQzQ4XpYEmcgEa35/KKRz1r?=
 =?us-ascii?Q?PxfeCWEixx6sDMiSimY9LDiipDNGbRR+7gJzaIYWSvz1Vpj1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9934a91-bce5-426b-a35d-08df4cab91b2
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:26:27.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM4D+aT6u2LHdOKEfLNKfVl7rDR5FjNRUSU9XW/sfDkzYsTyIVrMfGZghNzV/wpy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

On Fri, Nov 27, 2026 at 05:21:35PM +0000, Bryan O'Donoghue wrote:
> On 27/11/2026 14:29, Jason Gunthorpe wrote:
> > On Fri, Nov 27, 2026 at 12:58:45PM +0100, Marek Szyprowski wrote:
> > > The IOVA reservation code compares dma_iova_state::__size directly with
> > > the requested chunk size. __size is internal to the DMA IOVA API and may
> > > carry flags in its upper bits, so use the dma_iova_size() accessor
> > > instead.
> > 
> > WTF is this even doing?
> > 
> >      Fix this by reserving the 0-600MB range, below the boundary the
> >      non-pixel stream cannot address, using dma_iova_try_alloc() so the
> >      IOMMU-DMA core never hands that range out to a real DMA mapping. This
> >      reserves only IOVA space, it does not allocate any physical memory.
> > 
> > That isn't what this API is for, and it isn't how it even works! It is
> > pure luck that the first call to it happens to take out the lower
> > address space.
> > 
> > We even had a long discussion about this driver and this need in
> > another thread and this is the hack job you guys merged?
> 
> Have to say I wasn't aware of an objection from you, I don't think I was on
> that thread.

Nobody ever shared this insane thing with us. Seriously, this isn't
even remotely using these APIs for what they are for. Nobody thought
"hey this seems like a creative use of APIs, lets ask someone" ?

> It would be possible to reserve this IOVA range in DT so given what you've
> highlighted I think this and the Iris commit should be reverted and the DT
> constraint implemented.

That was the other thread, obviously using DT to describe a hardware
issue is the correct choice. But there was some problem where they
also wanted to split the SID space using DT and then the DT mechansim
doesn't work because the whole thing becomes too hacky :\

Jason
