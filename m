Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70472353A79;
	Tue, 14 Jul 2026 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007830; cv=fail; b=MhmbEOfmBCR771GYOXuJ9joCx+AkxT0/zRveGxuTSFLnQJlwpuX0hrFaPIe5DnVv9eJe+9o+5Q1DB5DeydkRl4VbLlccFyc8IjVI8u357OC3Qm2QbcTXvWjfYAQupUUPOoJaQ1Vw9BJ4F41+CIOU8ZO2j7vmeOoFa6HSSM63Zl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007830; c=relaxed/simple;
	bh=gYiDoG9O7gwq5bqL4xPE9rlYfB8oip/EsokFyVw3atk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krzS7SLzmS01KS1M3kq43+g9/7ODqRaRu0Bkn3bhSMJONmPtGG6b489xmUB7zIgvYbwDp61xTrhVNvIXkGBPPCNdKCyenkdaloA2auRRuchrbHid6pDtcdN7IsRN1WNbG566D7ZBOD2edlhl6t0o5xyKK5Aa84MRJ3cvE36amvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nrYCDyZk; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="nrYCDyZk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze4bpKK4rZWwmTJV8wz+xQaC0BRMku6ZbPt17V9dLhS+5KiMic7ouI5nEqb9NuNIO/vJHwJsdcmdeW3Uca78+pikFMNr32+WCdxbe/FIBYhMEE4SUEk+4STurwMWIHXbjhItywjccWfrFbyl7XWekILOTfkiSonWT3gVje4VYn65N/OHCwLxq8WlutG6hoZyS3ipUUc9Ck0nTgxZO0mvFfQAfACMPquCkisM2/OxbMWwvoPmUPxzaHNGX2BsOj2ucQGlgxU0FeNXqQj0iFqcZ0aARgqmJr2iulQ5JB9Dt07VYm6Ol3YAOKifNhJzwJynF2t/1yAZyONeVy6iyxmMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Wu40TA90aZ8dzL0eXsy3VtQ/41ewzzQ7rUtXw3XrLI=;
 b=M57HDCmp+Jm+VKBr0KgvIkoLgEUMQBZx+pvas+1tsVm0pBqSw6nbO4cyH27fnQ8D4D2xdYjRsfgPgC41wzhrUWXwqK44sGmqw7qZ6stvi0GNN7LxPUk+Xjhp1p8TzctRJ1PUY0TpmbBD8f8wZF2ihlCJMA4igNu7DSf/gqYAH7Vu9/P+RfJJG9l9yDzeREsalwdsv63o45ERfAjLMmzE2/oCPvJn2VWsHcEytHo4kA6Fqj/S7LAwkMF1SvZZdyHqN9/Qy0sryjg0c2wbNpION1WAkLtDP5aoQG/7qY8pS0scSzEKCA6URH03sMk1ld3kAx2YDxq2khTDW497J7x6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Wu40TA90aZ8dzL0eXsy3VtQ/41ewzzQ7rUtXw3XrLI=;
 b=nrYCDyZkIJU7L9UGAdI7zcG8YijoirfhXW9k0h6lpHM6qJpfmSdtFXzGqFuj8BhAGK9fZdQ0O9laN9lmYwndZzAgpAkg4e4L/pH9Dszh7WcWmHa+EwTm8pInO2iE4OXSSFHVdu2PGLYvptmDjD/YHbzX3bcgHk/VuDmZglxx56Y8nUtgSdy99JwC7fFWinnJXLzVe3/eXeGstr+Bvv9xkOmE1RSdzLdaONhDf5nnrN9IMuu2soCCw6OnzIL5o5tO16m5K5SutX4v6010LLUIGX8ytgsltAXLWYz2PXL/j3rjdWN4MI6yXI9E3I1y7uAf5zN08AUwj/LIMzdR8f1doQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 LV4PR03MB8234.namprd03.prod.outlook.com (2603:10b6:408:2e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.19; Tue, 14 Jul 2026 05:43:48 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 05:43:48 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: tze.yee.ng@altera.com,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] firmware: stratix10-svc: fix teardown order in remove to prevent race
Date: Tue, 14 Jul 2026 13:37:47 +0800
Message-ID: <6630a1568f162d9455e0580f7ccadc262db4718e.1784007275.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1784007275.git.adrian.ho.yin.ng@altera.com>
References: <cover.1784007275.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|LV4PR03MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f30f924-7cb2-475b-6118-08dee16ae01a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	shmVjS0RTZogO6jV8A1JB4tQOgaIuxzk7Z8VrBmfQ3qgTwzYVoIB2TKDWJKmGVwyaWHRZxBuUWRwg+W597gcR9hI+uvDEwl9DeeEybyTOelZIEfboISWHMuQGQT3UHN7rPwSC5Blte06SOmZaYLKFmlTrylRqe/3btOUXkrfbtmQu04nmqDL1HVyXzBrVO9Ppepjv1SojxFBNKIT4TMH+nRShwzTq6+OPL6WUOWxinXlTql1lGp9jM5SOIl7IEhdGPhRcwGpqvMPVqDSvy4yh8lzc0uUorpsNu0ZreGnjOVBFCq/yi69X7rK7vZ/wVgjH/eqpcLjziZ0TPzvIMEoowyexQaq1sOeOpmvF5l2hb7eib8Kr//wVOTkohNWgastB/RF+k4ljss3gsCNx3exDzMsj22PGxq7OlHyE8KXoiqJ0Xge3MNxL6NoTcR+cOyzW3vQgKRYB1EA3xNxgCCYq6jC6nREyg+SE4BOFwlepl3p93NQYHW0aU/CfQyvbAi2/lWSvaSUDvU8RgKXfyzaOfSsqmLMXxh95N8UVqniB0L2gmrQe2GcpaXx0LqX+MkL1BbVivgxR3JXzcxK4TQLc0Q3PXpX0vTqQaiOuxwluPfo1DIxR/ALHRrtbuJPwQ/AxtlLxjCrXJ0TZVQhujS72LRL+1Vvf9GWXrcSJXjpPwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8tgBSMcLjvq0fsF+dbSPixCz9c16s2ESQUfZDZfggZR8+5wvHlwlotGHT99?=
 =?us-ascii?Q?y3VH3PMJnvvsKMuEZ/M3EzVtINwhgmnt3pa6Mz6Kil2rJbXMqlOd/H08M9iY?=
 =?us-ascii?Q?sNtt7Xahu2bfxhevIESXqIwBSKh7jdrE76s0xdvIlBRaN0BlurbD/VtWHQoL?=
 =?us-ascii?Q?nsfmAM8oMQTNpLckY1jLBhwXU4KDsJM1CLSd2Qav9mugmSOgworX+oUllzhX?=
 =?us-ascii?Q?L4q6r8VK4UOUca5TpaOcu2N0dKLxyelumQHFZEqGBX9rS1RzQjUdbz/2OsOX?=
 =?us-ascii?Q?vRTK4bh6I0OxNKgC22zGJGbIWRsvs8wrmPDyVdxaltCEXFcMvKPjtdIAhX91?=
 =?us-ascii?Q?cP9Zt55V5xlzbi0cgFEte+GiMWLYZJn8zMsnUM+dZEC0UQDs/XOOOfAgYFkm?=
 =?us-ascii?Q?cS40t5V6nOjWfMXXq1l32U0LMggeYYrTHurZmS1iumBQY8DLwCt0KgGIL9f2?=
 =?us-ascii?Q?ReMvoXt4sSEJkDuMEqGiZtUkFbjELrBdoflLQBfMHNJbzzdwy9FEH3PEZZEc?=
 =?us-ascii?Q?THN/z32IqCSJJgEQjj61jzuGpqekSMehGfuip8t2Vcg+JazwOdVSCZgYWB7Q?=
 =?us-ascii?Q?bGm++0V50V4IIJ3QaBTBlwoiCQHVCwZ7VzmxFbKuu0nWSjsYKSbgneMFukWw?=
 =?us-ascii?Q?5+wmbjHUDIW6Heyrdai5uQ/5tvegSXghjmDMJjLpU87J+iDY2uTmd/5ZIYxf?=
 =?us-ascii?Q?t6M+HLW7IB+yx9RQRK5Tq9yFtIUzfzmpjuQpv8r5Em2VgdxhD3TVxgSKlbhg?=
 =?us-ascii?Q?QdB2+oC3hOhGXa1DxRj2AvN0GE3RLdkee0dLZgZQwsNfWqrC51bHXPScp/w2?=
 =?us-ascii?Q?2oapZh7Y5chm13WuOuouPtX24ZavtXnypO/fYk6sFPHFasfR5qwQ6JtGz24B?=
 =?us-ascii?Q?6gKj31+A1924N0w+3bThwQDAUYCiaLDI4hzYg4+lmS7qiLFOcZlTvIQSttFe?=
 =?us-ascii?Q?4E2YRv+MOCz2wsiuTymh3NdF4qDjUmYv4/mCEUaCBYWDmTUjmikCWeq/8PdT?=
 =?us-ascii?Q?zUT5Kg1sNTQDh6hLbVYhKHmW8kzX3c6enFIcLUJacE1dk7YB5U1/2zk/KXBP?=
 =?us-ascii?Q?z7fTelUMZ0Iy9mpilnTEeWXgQdgQyARTbOM2nAuRaJl5HGFXgA7RHWvGW75R?=
 =?us-ascii?Q?1Dq3dMbbBwMKGSkjBPd2qp5V4xLsUBCmflINDfy5XdT3t++led7PfoFVJHe2?=
 =?us-ascii?Q?RLctR1QL7xk91VBCx03djYL/bJRl4E20W/fxbxwlrAxqFghae66DMpLnPAtA?=
 =?us-ascii?Q?cm4KqDze3X+nItYpXFM6mfYQRXRVfkOqcQJwdZEbNKgx1n0hy91YKLioqbZW?=
 =?us-ascii?Q?j0CBIHB26d+3x1gDnSvilky/pJbwLK5NoJtk8tlZ+XhoQ3gBZJJPQ7pquYLH?=
 =?us-ascii?Q?y09yJn0CeKytcyw/3kiWHTHFPAowJEQeTEQdEslaigClxg8jp/fcCBb9GEFJ?=
 =?us-ascii?Q?wK6iP76l3frg7atuN7ZnjWJRinqd2gIDgbFZlZvDO5bVm8+Zh34ngcesiiKd?=
 =?us-ascii?Q?wcPCZjYxy2Qr6I6lr8aM58YmYpM/pOQRiVT3SVHC2U8rLYRicHqFrmyynYju?=
 =?us-ascii?Q?abGbjuMHEGNxGPBstcEjSKIiLRSjp0TwkD5ezjJYdQu4xKGQ5iRP68C/FvZX?=
 =?us-ascii?Q?cC7fHEUCaccBqNYLO3n9pPL2OFk3h7TS2h2rotUizQpRz9ZFlx3sdSuDde37?=
 =?us-ascii?Q?SBlAZOsUgEbZfw8b9OQYlkjpDh/bKXACqdEl6SKZBj8C1JGwUvYZ9SlwJnDP?=
 =?us-ascii?Q?ysxjxaPzahuhw8HNRajFcKc/DzJWaoQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f30f924-7cb2-475b-6118-08dee16ae01a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 05:43:48.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hPS5fCSwYHtIclhOc7zMpMkLBypuV545uxsEkVfp7mMQzbjM7aZX842+wKL+bOghp7QxJCu+6c+UMv3CHjnt2Iq5KLlDvk/Uk/71qBiBVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8234

In stratix10_svc_drv_remove(), stratix10_svc_async_exit() was called
before client devices were unregistered. This created a race window
where child devices could still be issuing service requests through
the async channels after the async infrastructure had already been
torn down.

Unregister client devices before tearing down the async threads and
channels to ensure all in-flight service calls drain before the
underlying infrastructure is destroyed.

Fixes: bcb9f4f07061 ("firmware: stratix10-svc: Add support for async communication")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e89fa198688f..bfc9aceb681b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -2204,12 +2204,12 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 	struct stratix10_svc *svc = ctrl->svc;
 
+	platform_device_unregister(svc->stratix10_svc_rsu);
+
 	stratix10_svc_async_exit(ctrl);
 
 	of_platform_depopulate(ctrl->dev);
 
-	platform_device_unregister(svc->stratix10_svc_rsu);
-
 	for (i = 0; i < SVC_NUM_CHANNEL; i++) {
 		if (ctrl->chans[i].task) {
 			kthread_stop(ctrl->chans[i].task);
-- 
2.49.GIT

