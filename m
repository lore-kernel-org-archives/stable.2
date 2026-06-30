Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDB37475B;
	Tue, 30 Jun 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846505; cv=fail; b=pDFit1t1cmI74pMHU9O8a1u7jBj3bLgtNfXvnCiQn890OOwpQSHwhj7IV9iJCIQ1K1mDLxP0gy8w/SUkmq9Dl/t1gVRbl+mbvGjMW0VGlYO44WqgqRg/Iy68rMzuTlpcULqt4nhpEWeP/8n1DN5gS8OyE6QHyGsuS2D+fH7pw5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846505; c=relaxed/simple;
	bh=UcVVYe/cQyBLQxVNA/qrDX1Gh4+v9ukpQga0oDX+rLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtWbYAa2qPx7SpEtKefEu/BU0bvv8ZMN+JKbtwlJXlxS1U3wkVyMfeGkA5y/+qcR33yYUr9GXlVpRLcd1L1mxbMZi6F6X7WnZkDpd3fPU/2W2yDJM+XGU7jDpHQY0f0STvQ2Y3SjfEoplGbBN3xopTPdQw0/qtCYtq+ofbVY+28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxKtgRdP; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxKtgRdP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKNd+zNT6z+tWYYc9ZQWvKJIppF3RKwWiGFRGb8OR7PWNH1o4x0Sg2lkKziL6mEiuGdPdNDzehO/Nt0pLCvp9P0CLiRPXX4WIO+P9QQ/ROFaRVZnSyiL7YdDdf1/KWeV6wX0Ow/jatvYbM4f3geciGJvIruAYiXSXJQmv5z5oA2Im2p9JnO+uUR1LLXck7JuZ3X7wQalCgD/zDn3J/i7nXRs6oyqBKXBGGKxHSO8Tb+7LX5K6lqBNZVP2H2FWZkARJAH5AEjA1KUUIOsjj4Sb3Os8j5kLLl3W3UGWMMWLNl4F6JFe3Nx/zzxd95nwd+2DM2DFbB5A9AyIv0dfsN4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNzNowTZmvpOzqxaLLIdSXl0tVijP8DFPyrnqLyHFlg=;
 b=LqCBtbqPAHMZeRYVIevW2+v0l4uFh0MdvoniCzeD+C55rTdi8YC2gwU3JSRqnBZtN8BOf3Sq3kVSczW55D97iPs8NK6EaV4igIiwxp5TeFe0u/tWGjOveekSRC5VpvttCg8o3qoM4pmYMhkhpBA8Hy7ILPVb2rn7cpnxj2U1B5qM8rMiFvWcBkjkOE3pXFlHqzNxgIJEKMO9ex7pHOe/ZfiJXBz2I1ECRB+pEUuTxk34IlcXXW39OUucY3oVodg/CJ1PIvUGoVBEbnS2/wc/oOiBmI8VBSkZVvo2a3cpBWSy/zzTTYDhD8nlwbfsRWESyWv3EaTSyUfvjIoyouWLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNzNowTZmvpOzqxaLLIdSXl0tVijP8DFPyrnqLyHFlg=;
 b=MxKtgRdPAaNeMu99oIOidTKm0xvBnTcXSFSwri4N+DrDdxGfIBEeRHggZOcv2F+6/26tlMjpBJl8jBUZUDF9GleJJdkcL4DdsGPXHoHQzmb/8yQDIP7Zlox6jn04xnVNtfdKEvBxYG4pMYaAHFIWDj/hN9mcW0ijJvxWMu+X1jHVXsg9v4vxh4GCm+F2T7dPI/gEgTE+WmtMoauf6OBeDmTGTfXi0kkmPOzmNxVUR3y2oJ01t1VQXLiHvjLuBehXrqeCXgwjwBQEWRvkuZF9M4J2eCXviu73MMIE7cBsUy0rwo9KPa0lKiDQr82tY4A9EjhDUBtKmX78lVKOCGNsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 19:08:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 19:08:20 +0000
Date: Tue, 30 Jun 2026 16:08:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260630190819.GG7481@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <akQLURkLA-bZ9dAk@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akQLURkLA-bZ9dAk@google.com>
X-ClientProxiedBy: YT4P288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: cf56889c-1ae8-4730-4e10-08ded6daf2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|20046099003|56012099006|22082099003|4143699003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Jx9f5eiLHLZuHjJygw+IjtSnREhqGkYgWPrhP3pSoXW21i3uCyW8JTadpu0ZpKc8DSviViuOTjVu+XHnL8koGBSHhVO+WFcS8EB6/K6MgdJPofiaVg17nomYcny1G2IPaEDYH/EXffWj51IO47eV0SMuJkiLzOz8R8Vw65MhJjQN4kbvsNJ93z/SzpBXMM0hyHhE4Fk2BScdwJoGMeqljaCfw5ziM1BYKmhpvOo7IE28CeVWOJva6Wx3XxhO0mrwP+dGTOtnZQUCC0btD4QwJOjtjhNoj44+1MOw5MTPVQ4doKfCVJKJQ9psHN9EFfvKw0r85/3OtfzBO7vq9C3ItuQ0aYT00cK0Zqw36spq3+vXbJJIe2NSuCgDqOisXeGL84awm0RuDCejjshnjmnTi59Yxq1ogtGVpwnRcAQJ9KLBuaPWgEO7z3MuAMvavxKwIxaw3UczL5eOKW5o4OzuByvw42fmJrjKj20tzyR2Tb+F6McnWtkqR23lMKkB0JPvb51TmOiNNcBY6CE7xxLD74QkeMokiXPutibnxvoOIq6phgVvUbebstI28MnGWHN4gvX4LFXQVOJi63xBA5H1EryMcuT6NgQjvoF4dK5t3tfvLnKP30An8ODVRq5fLhMEG2hDqxXGdcZuFhIPt+OVdxnUHChZ8uTmB7Bcd4wSYig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(20046099003)(56012099006)(22082099003)(4143699003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGFKT47yrHDd2x2dbVrcPzqsFPouGY0PJ5LccBvBhLtBCjXdSkv0IGACnUSS?=
 =?us-ascii?Q?3czXryv9/8CUj/FVLxrFUsqSLR9eccdcdU9z/WhZeZ97gebWAX7FSRCWi06f?=
 =?us-ascii?Q?oGRrlHLOvYJb6Y7uwKouFJ4YwCXLYvpQnkD3PO7iHQCQD7rkgwvsr1CuKPmz?=
 =?us-ascii?Q?2R9ajQ17WKTNFd2l4uhPBbHQbg4M1nM42BzayaAfgESzFH7zzI34sLFfgxHK?=
 =?us-ascii?Q?oEWZCXQvYOotGSrIxmP5Mlxdz14eVpIVzhxabOm4mfjqF8xXfzYXlHNJQKTO?=
 =?us-ascii?Q?yW1CvDZEAI325j/kfG+Lut9fqfVIVozZhTIi3/S9CJtSBtG2L4yURSh1vkaf?=
 =?us-ascii?Q?K/1sjaJ9HM7ZMSHPushI615yIudiQJBfPTaaENysy1HkpWcgelbnJzSH1dqh?=
 =?us-ascii?Q?RmAuEgxLkT157tSkj0Fc0H+LnFkjrz6A7h0j4/ZxboOfSWIfdDPCiqFtL09f?=
 =?us-ascii?Q?9XwnNkWe9oD1OChsA41bfrgcIbutjSPgY1wqWsvBhdVey8/L+MOCc6JaQMAC?=
 =?us-ascii?Q?hJVtnyhcxOGkv/R9ES47ZunKswjaMMh7QbFWvkBWhIv3a0sdqy3Z4wRRm+Sk?=
 =?us-ascii?Q?L33PiCXc6JFlqo0rKQSMmkEthl2EV1V0tTdHPl+yx+7yeAxcm7hcV5Q5UO2C?=
 =?us-ascii?Q?eTwDdi2fjooLUoAIf4laJ7tX6l0tzCyR79vPGdkiYfeMlqVV3j9jifxr4pV6?=
 =?us-ascii?Q?YFRCMguJqEb+i9w6gh3IbVUf8G3nbh97nTuj2cmR1eZp1HDZabwkGEOYYqvQ?=
 =?us-ascii?Q?2J/OA+ac+UNZTWnmTVNhMBDzr2Z4RHtwrJqyIQwvZxXbbSWv7Wg99CJik0iZ?=
 =?us-ascii?Q?hMdnqev/KUCPhrCzojynRrlrFizZF7PkuNLabyoRsqfzpHQrl5DzgTCbi95L?=
 =?us-ascii?Q?W+fLAqEbW+xMiPWsXyFuUuGPh0htxGA4KG/9p9PH1IjAokO7hgr53N6PypS1?=
 =?us-ascii?Q?e5qgf6KCeTF7Ogc/AD624v9gvXZaqZ2qgOgoJt6HM6wznFes6I8j1OTKnlgY?=
 =?us-ascii?Q?um10banbKMrBQdBnBSrfVaU6zQgfPdjX+l+9+BbhbWiTvvFzCZn64fu5EXNJ?=
 =?us-ascii?Q?5czTGN/hHriCVfKop9HzH3WwqGP9b+8HQu7jYAd7wgBNlRrINV/JBZWCUe5S?=
 =?us-ascii?Q?9ES09O5r5iKWAlew1JilinhOk5364G6RpsVaOu5NPFZf/7zOrYsJSX9exnFo?=
 =?us-ascii?Q?yQZm/U2bvh0VzfP3y6VsI3J0VWW2XAh+622Ue9SnkxJ3slnMOb6rwRxpyfJi?=
 =?us-ascii?Q?RgyoH+uFK2+PXPa0p0iS/NrfmJHRwTAA5hfeolFIHwHC8pyLzpZ3Ho1MbAdC?=
 =?us-ascii?Q?JEdOXVjS/ahqX+wsCRTJQhXakNmK5JPOnzRBjF+Oa2Gjc85vepvU02r2wzvW?=
 =?us-ascii?Q?9kPUn6lm3vuApuZsKvwYxAaTo716cZzcRGSuozOaarQT0GK6C7PbZVFZOLFs?=
 =?us-ascii?Q?HoD1ewye6HgwWAWMZZ+Yy34fb3awZINKleksWOlL8GZ2boPdDj8R9H0VI0UU?=
 =?us-ascii?Q?UiPl7KvY9QxbkcwK+Bxs0cws8x5mn+peVoNTnB27PBRwWmUaN/vw1sM37lvU?=
 =?us-ascii?Q?CteP9SxxBdcIBy+vRM2QVgeRmPgE9Sm8GAfcMnAEY+BtMVyKRZFDQ2MM2Z3j?=
 =?us-ascii?Q?LLwphdyiYR6O+nxcJ4yEAckknDgJm2ZXI+wpNoE4fL16bVzHqCjSIBR/5D8+?=
 =?us-ascii?Q?eZxcncoHE3QEM4n254l8N7z6vhXGHi8yWe9IPX5O9sv9Cv2K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf56889c-1ae8-4730-4e10-08ded6daf2fe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:08:20.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMJIjPg9dCqcIf9bM8ZY9n8RU3CZsf6zkCqtGfdnhi0PsUFf/8mb7J+ltLcVCZQ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

On Tue, Jun 30, 2026 at 06:30:41PM +0000, Pranjal Shrivastava wrote:
> > As I mentioned above in the previous
> > reply I am not sure I understand what situation leads into this, when
> > does a device trigger SError to the system vs when not which is observed
> > as an event in that case.
> 
> Ack. I see what you mean now.. How does a DMA fault raise an SError? 

As I gave an example to Robin if the unhandled failure escalates into
RAS emergency unplugging CXL memory then the system is going to
explode when kdump touches that CXL memory as part of the dumping. It
is not quite so simple that a DMA abort is triggering SError.

I don't know exactly the sequence of events that lead up to the kdump
kernel crashing (I imagine it is hard to debug that one), but it is
something related to the new kernel not participating in the RAS and
the RAS flow escalating to something fatal.

Jason
