Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021087.outbound.protection.outlook.com [52.101.70.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7128386552;
	Wed,  3 Jun 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498650; cv=fail; b=ETRD4aIganP32UoV1KCDbOjKNQGagh4vsTqWeKxXAiajcsEWopoEQu+elvhi8t0dnERm/uaUD583BOZd/HennSWrxsARNzbjIPguJ5som0IzHxlnvgYoC0U4Qe8t71V9T7oU4CwJcMdrHXEt0ScnF91nMqDf79r1JuhTM18zcDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498650; c=relaxed/simple;
	bh=I82769B7x7fzuvm87oWOppc6HIdteTppUDVegIxxLVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zb/VxhsWa8nL8gc+pkl46ay9+qqzEtY7MRUa/Z1MplQ650W/313sxt1/U9rEmvee3hU9ONb04ThJdzGlUfuZTTjH/iRzbCsL16jAv3i+8y2kHMgwH3T4p1pNJQLHqZV290zjw7BDtzJrOW8Eb/uoPclQaSVyXT/oCkSzis6K9yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=zBmB00Uc; arc=fail smtp.client-ip=52.101.70.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="zBmB00Uc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZ2wpBZu6HysJLehwyMnzBqsElG80rIV2P86VCX7uzcNMjEN29wfrF8U/FNb1LhKCdpY4ncc6tx7pCIyPVkzhAJXyUZ0gLw0LtANW5p/ArxuKKZIXsz8YPWLsoWC1sTwjKNxKKKbDLaBCD8yoTUzQWSkN4PJExfdOhSEDSNDPXfQYlyrsaBbYompn9qjAdeG/2Mbs5iivQuuRdUJMeMTziLaGPYKYRCsu/jcCcUIG9GPKCelmkve0fBe1xP0axbixX5vtA5IS2weT0UUfGad1V40Bw2UzzQogGeNC1fi8RPY/F+vl0xvJt+31Ep4g/bAlEpz7Nl3LxxHE2wu/G1tTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I82769B7x7fzuvm87oWOppc6HIdteTppUDVegIxxLVA=;
 b=Q4k0jI3nw3vk+IBo47bGsvhJ3+p2dZvemCx7LFfmVfAqrisUUpjUOhg3XCjUlzJH7lbQYb/pMPECUmxa0//itzxNsWHZsX8Ah0L2FN8wPZWrDjrb7bdo6t2+pdlE2ZDRV3hZZi8dpfTkn+GS523EP+ZorGwHsTI5eTUe+0P0iE3emuS/7TtSKN9ocjByL8kHnBaJIgLlyMqnILI+oXZYyHMLe0foEKkUD6sLos8Vu1fPb9UT7l28A7TUuNKdHUwISwVuCy2CP1q29NnjXhy1Ni7i4m5djhBCKi8YeJYlwBm+UGtFDpg3Aac9mkJABi6RoFncBgE3fYMskPRz+CRdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I82769B7x7fzuvm87oWOppc6HIdteTppUDVegIxxLVA=;
 b=zBmB00UcfRnGAmwb5KqT1lb2xjcVmDjpxSieaeGswvLIMh3/CA1u1wvJJnX6Wmm4/9CS2ypxqj6iFLHVz3hHjIS0gjTXjhqLOJrXqNDcMrCBjL8yzo/9zM1OL0uSxdZsQwuVcs++gH92ZhrL5d+TJReoQ6dCmrGBd5yRUVY3MzTyumG+e2OGlzbE+We5cwBKQdkav/GcXSbSANda+ySmGTiZxy0Zvvq8O+/W9zIoK0+hAULuH0QT0pQPwf2MlNOztp9NONRPbt1+5pRogfe6kcNZUg9RNqCqGvLG1OmKE0fxOHc843Z2xvZWrG5C14QeujvrE/O6jr5SXcbV3zWDmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM7P192MB0787.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:17c::14)
 by GV1P192MB1665.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:57:18 +0000
Received: from AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 ([fe80::c1d1:f20d:9fb5:72d3]) by AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 ([fe80::c1d1:f20d:9fb5:72d3%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 14:57:18 +0000
From: Chris Gellermann <christian.gellermann@codasip.com>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	christian.gellermann@codasip.com,
	david@kernel.org,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: Re: [PATCH v2 1/2] selftests/clone3: Fix wild pointer access of getline due to missing init
Date: Wed,  3 Jun 2026 16:57:15 +0200
Message-ID: <20260603145715.1376288-1-christian.gellermann@codasip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aiAYQVaVGRLfmpAK@lucifer>
References: <aiAYQVaVGRLfmpAK@lucifer>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI6PEPF000001F9.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::907) To AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:17c::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P192MB0787:EE_|GV1P192MB1665:EE_
X-MS-Office365-Filtering-Correlation-Id: 8879eaf1-c719-4a9a-152b-08dec180684a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WTCtaWJ1e4pLJ9xMAo7J1cknQ+L53J4BnYZkOVcWBPrP61RmJSzwNOxi00A9USyeCW7Er2Exl8xPzPTaIxbWZNgR8jxNrxkE1RchkMbcKhxvGjTKCm/xetG/I4KzXHNPSWpLdPepORNu1VR53gTKdzi3PBnWpPWlcq8FUCWYPZXvAWj65kKORO4PMaKmU5c7Lc+UApCP5FfA2aBqcekPpgm7XZGjPnHuGt7SixjW7HVwPQ2PgurK1CkarRlgBUNZaH5jzpYAITjKDti1sbBtv5skQjnSJF56AOjlQN8p+/z3XNxQSeoXBiHdIcIuVy1b9UDN4JH6r72n+vRjNm1ud92sZwzEm+KGhE69VMLTRYxbXePinRL8AHcAFM/vbpBBbz24ZQYm4Ed1jMuB6mAGPsP196O/ZYREMYYG5solmsmG20Iv1nz34WvvbL9z2tVylfHnaxf8PHqTbZ2VrCqta5KKPl9zNq8cEKX+nlfm46gxE/JSmG/+rnct5hDuYbrpXkWnpaJzwtjtkXIeRBqcNIsAPeuTZARlLv/bs2X3pFbUdyqSaao1dCh7hApi2Ym8i9LqKPCkM1S/TYuTPu+Nq8/8cGsAHHnMmq/YRNa6WJlVUc9ZufGvv3p5ZionH7t1GCbqjEOm8vQFwSLgKkIe6kk10aGQgHF/hWJRG1X4+J5VpFu946XlTmwoDWnBogI6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P192MB0787.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N2nh7nZRPUb80eV/n80a3NMdjMJ6fnqVeV9gc2RbcQ2jyT9LwMCFrpKPS8Gx?=
 =?us-ascii?Q?WcaWYo9LfodctFvKjj7LlF17hc1WSTbDAAK2ySv0/CG8ruH+4Zbzs1ySPTHK?=
 =?us-ascii?Q?Twa/4UkRgj11sDyoBLBGvR68CRxRcGARb4Hnr2kARucGR+whousoc4wo+iFN?=
 =?us-ascii?Q?6DFS289nO1QD+4saOcF1KgjHsawmAQx4U8rZ/uwjf3k/EMbvRPwyu12klu//?=
 =?us-ascii?Q?LbN/5T2oGVKygq6rP7fi5+Xwi6s7hdupZvGQ9jKUuLZMBmYtwAEZktgoQrfu?=
 =?us-ascii?Q?JIN2fySvZxJ1Fcn7IppI3rCiTxQAW7k21Rk6CBcOdfRXDm6QFu7UJXzzJs8O?=
 =?us-ascii?Q?Rn7L/d4Dop9q1JBrbcRCZyCr7fc16pO0fgXfX4BIpAdqEP6keC/kNzspeaRF?=
 =?us-ascii?Q?+nrIzB2c2i2JVQkmDS4ecmlo5z1vdKMOb6rRARt2CR9tpcU933A/jXt/YaMk?=
 =?us-ascii?Q?90xippkCNao1/+1JklsU90NIo3hTZOhKl0bedpJuNrIc2Ml1tb/cgbmY2dhk?=
 =?us-ascii?Q?ZaSLZM/tYdLp/DIc06nNfYUfNB8JSYdNpY8U/a6FMAcmLku8G+4ytKytjMxk?=
 =?us-ascii?Q?ETB3RrFVX5UKDJvM15tufdAOmv5cnmWgLo91VD5e83Xxmy2AwW6d5R7JG0i9?=
 =?us-ascii?Q?JD4mH0MTwjeXLZ/1ck2wMur+JeMBc5jMVL5Sus6n1FfI5/WzcbvZRpzhwoxy?=
 =?us-ascii?Q?MLs9XUB4+UKOduA7KPpX8YjO+FSVirQPJ/VfgQGOSHm/Cj3ueU5lctV3h4dV?=
 =?us-ascii?Q?ro3LbIgcmOqdcas4VS+FL5DMRxHHznqGh7zF6utMfe56Nt34KCp0TFbVCUFc?=
 =?us-ascii?Q?xoW6D0+q8HUe1L31/d8N703P0ph+jblaP4ZnPdX5ncqwkIa3ND950NaW9ZRg?=
 =?us-ascii?Q?toWmuTNalRA6vgURK4P/KRpsBWNKKNOiNQpnuERFuHHSgfLi1H2hkVJO8ro5?=
 =?us-ascii?Q?b4SmMi3I55hnrZptCSUdqdKiGm5XpkmGUQ910Z+kNs2lKMe1Z5t0SzJwBHOA?=
 =?us-ascii?Q?ClGkg9ubsYuOxf1SE1pPsUQDEjUqGU36Xa+uFFO/+a01V/6weCTBAO8lAohn?=
 =?us-ascii?Q?1IyWsz0DVzSNA8GF1oyx0lduD7FS+vwPzCw0KXBaoCCFj+JB+0lzv+NFYx34?=
 =?us-ascii?Q?nx4WTBK4P2+s6Zd1SkjBMFBdfnb6W4uDuX9sVLNwn4NVpK4JAb5AE0Y3BwzT?=
 =?us-ascii?Q?FgyI5/hOjQ7sZKuxCjEs5PUrsOypOm8KA56i4YHs70GYbk2L+kSqGaeCMwze?=
 =?us-ascii?Q?HUfh/uT5poXjpgblMiyhtawrW0D1qcpxB+aDwm82klWm1Iq87P+TnclAMcZs?=
 =?us-ascii?Q?UZ913Qd+uflv9p1UfJcPLCZ0y6+2PEcOheLVqOVKfD7e5dINrbdrD3Bd9dRd?=
 =?us-ascii?Q?+xfN/AdsCeiP4mnYWjtY54PkA6J+VQfqk5MT6zVfRTPg55hO3YXETUQ/2RTw?=
 =?us-ascii?Q?qURvSPJuSXsNTZIdK2MJqrXTl/m/Jz+Xp0AS7Vp88IK6G/fODY22ARjcDgJa?=
 =?us-ascii?Q?R2XmLo4RaPoAxPzAMvK4xggxUvT4LhKzL/+4Vy+zzY/BskLWkxMsZtMpwahV?=
 =?us-ascii?Q?xbBN5INy8SlDEoS8qSfAYLKQBwcdTDNyHwBwuH0zyiw8rIvhFSmXugdq4ejv?=
 =?us-ascii?Q?/Cth9u5TPGHKDkzuo7ppw60R3EEY3w0A9EIcBaRhrnK4rBPwRaJyDF5PXS22?=
 =?us-ascii?Q?/cFVaKwCYwqocPjNA9zbsv5qK/E0bwEmgMEdvo2niVDQloonVIqWMyNY3MgT?=
 =?us-ascii?Q?5rB5czBZqQmYgAxVdYHlryTvJstP4HM1FYNl0F131Z2aa+Pd1HsN?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879eaf1-c719-4a9a-152b-08dec180684a
X-MS-Exchange-CrossTenant-AuthSource: AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:57:18.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx4Zt+wNnAYcxMBd/9prEUijl/MC7IiRBS+r0AzGegEbRvrGWuQHIg2rZGYc3lsrn6i4VRHH8HiYr0J5MtTZDUDHMgajkGfTsYkRfKrXwzUEJFtnkwQvKsHD7iT66nz+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1665

Sorry about the mess. It's my first time upstreaming something.

> Just for future, please send series independent of each other not in reply to
> other series, and if there's more than 1 patch, send a cover letter and have all
> the patches reply to that!

Sure, will do that.

Best,
Chris
