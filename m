Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2F3F23A4
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534393; cv=fail; b=kotEpBTwIsW1CLhTxm1HyrTei5q8nGSuFkiAQ4+jg4Jo45VE5/2Q/744/P2rnPqAFPZJotlZ4uSmiGTFLsjBU7c71n0RJcfgIOscQrlnZw8NPXm7NnXEfhKpRth+x4FLFSlgTfJ3fg3MepWph14YiSI2LhCpDEL0Qt8VONbMuwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534393; c=relaxed/simple;
	bh=eyACq9oIeIawaL5KJzgkH8FOfg3TWELiPYhqA8jYXB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2IcrVaxTamaxfUG95EXN3Qh2n/VuOIloo58GuhJzhrVT3RVx8wjiX8c3T4uUuoU1eMe+ds6myGH0wJmDg9ZzxcndEJc5vf7pg+gaUvniOKsMFIcpOpPPNyFK0kvFa7i1H/8Uy7wtUxNDp5Kiv2vtsc03S/Sl8mRaAcZP4zwx5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cd3s1YAw; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cd3s1YAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+ZKKGg7RKjIQz/sYTYO2WFAfb7YxuK4/8rV8aIhdBj4CkQp/OR9uzoj1q64lSXy5ue4L7xm1BPM4/+yIWOjJQr8JvvVKMmyBVcCMdlgoAsD+d5xceJPNRoDLUOeIu21EcrsHBUWM8h8CDWqdIyo2gFHfCFhYGQnu0HCCCXMpa4RbmdQEuKDAPumUO+Z3MzoxlUUlylFKGyX3PZHlXv0MMRWDOlM+SP890WUHQw8tCBEBFLEKAT1U3ES/OOoHJrI0wBZ+ZkYGBUT1irJvw+mE466tYtulySkE3JhzvV2jSkt6CK9/EpvIVVY49yRzQikEsa+0NqbXcu1zTKrlPoigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEIi+ZVfPNsQqEX7xlIIy7JZvMr1shFv9tQAJaPu5O8=;
 b=VFWRVHky4odI05KFDUyC1a5cedgjsdL5gGf5kIKL8v2uOiamH/bwwrQStexjP9OSie2gjlZgTAqADJnLfIiUvZVap9r8vUs5Wg7RTJ48sY8XgNP1er/9fZoGyRPa/om+KVaruamjJza9ihg0coh7vxp/4Ks0WvMoLYQy0WajcCpPo8uhZWz+lCSmOhA5tvU380j3eMkW88FtiraawYn/XVJ5fg+pDR0muuiZVrcgXvwcRwqxWTKqHNnz56YL3EBgOwXBtFgl6wNlyFaCP7BBJtivfOJS4SJYGlwtanbVGjUA2T5FYjeVYyXYkQvWIQ+VPw2BAygSbi4UKcwbAqfa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEIi+ZVfPNsQqEX7xlIIy7JZvMr1shFv9tQAJaPu5O8=;
 b=Cd3s1YAwx7Tx1OjRTk2WFCaadXOfH8JJlZmKCW2qhV3iLVU+ffyPkT4O6f+HlTqc2bR/HzUbVvqdgMCxGzsRbSAEDKp093A2cgVC9Xk3f7tKI5Vq1XmgjY+/KLTw38qc7Y6seu90acFB39065PTcxNxNjrhSKHU5oz/XrcwnBmzCAFUOofsMmbAGGwVahMRiXGgtAkG80MdCRdu7lDhHWa2GGblrPAOplNo8+NQD1SREDCjSqOWHrkckH/2GnS9OBhxrLMzbIIWQaxzIz1F184HN5RJsKLINsILmstg3z2lYwPRocB1ydtR0aZO1LOygtsYIyx73ILNKkBZHLSjOtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:39:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:39:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: stable@vger.kernel.org
Cc: Philip Tsukerman <philiptsukerman@gmail.com>
Subject: [PATCH 7.0.y] RDMA: During rereg_mr ensure that REREG_ACCESS is compatible
Date: Mon, 15 Jun 2026 11:38:51 -0300
Message-ID: <20260615143850.3269326-2-jgg@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026061548-onshore-amendment-9a93@gregkh>
References: <2026061548-onshore-amendment-9a93@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:256::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f7dac7-1eb0-4dd7-473e-08decaebf215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	SS2XmKyKcAzk010Zpy0st/wXKblsmt2nVuiKMdiHKwAiunIcZYDC2TNWmOc6wx8b0e7diWBCmA7WVwFHUi6imGx/59GK1Ueei2TGo8Tnwb2jD4Wwqpf78K7m7i/2VZ3A+WSL2oDCbFntKpKHL2LXYYzbnineKxWjKIkon54eHt8sLbmip6Adz4KeQbsNAQH0p8Fs+i0PyU8ZflhCngA5JRUyapns6cwSKSbpBj3vlWsCcwqoyy8tdPptN3l8b7o+75+KAQVEISdiyVfPVnsJQrpMaBcrmoydWr+WxXMlItp6utRAQwV37gv1RS8XhM5wKFSl2SIs8ArhBjjbVzTI1ZNoHi4bzTTtbiwBAt9P/c9cyODyZlaPkCkoQrZ3L0Xxruek2Yl7fKwPAZzoYjj3foKDfWhtkdb3z8lfanIax6bJnFV7RmnlmhYQG2e4g1/5SjBm3QzwmQQkedDXEpjjlu+qbupLx5CVMOfWBjk6CJuq3WiGGONpTv72KRyw+puGhTwQFTr2jfRgBqbrkmDK2Gx9e3MMjQV/qtjt5wMjz6IR+hLhAV2byVV8EY4SE/BjnzPvYM8Nk9G0hiSp7Nru3tjY/XE1g4FASPvEuck00mcRgG/4ofN/UwDcY49SwOjdchzt0sjskev9O/FIqtx5t7s9eKJps5V0dKXBAqXUSyK3E7+A8w96vD85thmESlmegeRdJdCgMhiOs1PEUPbW2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPXLh5KQQ+iOSmdU3kW7RQH7gZhl/Vz8r5OqbHVxHQpjVs9+gdEeg/H5QMxp?=
 =?us-ascii?Q?xgDzXWZYvCn0os9mpak/dGa52q+GpX5a0DEdflUiFNPoF4UYQNJoIvAa9upO?=
 =?us-ascii?Q?HnVaLxoO4RBdfnUwuG8SpEJOABMKR/EMkTBTOOxzU8ab2qIPTW1aXYg2gmXs?=
 =?us-ascii?Q?x3+xzb61sB8iIjiAP2uB1pOJLf1BwqUMt8ory3bFJp7PjYVfel+K+0HSRjHf?=
 =?us-ascii?Q?a9KKVHUYK3Y2jJcYyHRFR4a5hcsbSlNvIx+rkmf2LFyiCYrszh0niRR/izLQ?=
 =?us-ascii?Q?BBaZe8K+tpU07Ab0XodiCx4DO+/F3qpo7QQDffVDHNejarlbFC/wCih3d3e7?=
 =?us-ascii?Q?cIzrkhFuflQOHs3GB5TOY8To5kSpzdhzUXdyot70WvnjxdVC+1SABN47VmHx?=
 =?us-ascii?Q?YjYoNcN+awDu1CO4mn8c8pvBkIIPZfERwp10kSyRmMWg3M/ipdPsDV743T3d?=
 =?us-ascii?Q?9DAMSyqCr1Fswh8Vr7u4+xjvxV+RIC5TtIJurWJe4BtypjRnxqrwJBdaOYFW?=
 =?us-ascii?Q?QFPeADfLQMvvOxHL0I1NzCOUWsc7ghBa34nJpHgQaY7E4NIbaXMX4P2reDCj?=
 =?us-ascii?Q?kulEQZtP7AKhnf33SLl+wRlOz+JnoyvJ9u/aceitY/9m8aWbU09e6Yf0RhiS?=
 =?us-ascii?Q?OZR5UsLz9ax5lixFaCqupbGjxUBZa0UvXJiNOP58nA7dET685aw4A51qQi94?=
 =?us-ascii?Q?TifTfio/73ylC2isykcW2Cn0Susu8UF8HAxE3czr76NMmau5Lihj8w9FoK6m?=
 =?us-ascii?Q?zdzQvTfDE8RtC1fFravQsLlBVR0Qwt7HIHraIQ91qLqcmFA85nvDZSQS3oOO?=
 =?us-ascii?Q?FgYDXlw50mHjICL0cID8JrnQ4ElERDCCj0twGcSj5zOMqLDy5eHvx2tbKfgT?=
 =?us-ascii?Q?UvqB5uzU9GQR9bF7K8iQeJ86Hq6lwOg0C2Qp6cFNyusquLRUCK9DqlPHqFTy?=
 =?us-ascii?Q?LajcA2IOAtoawBSCXbNXCRlNmBamrsPwE+OgPv2VmfQ7QpeHNLc9YAuRK69O?=
 =?us-ascii?Q?stn+UWiTOaJCragLfOuM5Bd2x3QOlzBUHAj6y9LU7XIAxDtTSvZh1mBQuv+m?=
 =?us-ascii?Q?wAoGQRTC1RuhRUil1OfBdPd+BwpLZ4d/bv9cMCQ/cEEDY4JEEVTTdUMtw5f6?=
 =?us-ascii?Q?y2U38rYz3+XNbE0rqcNGrjzSEXkh9jrVSESWVhfU3HB/LXxESHYVWQPU+pBb?=
 =?us-ascii?Q?ATmfbsqvumNEuZz7c63KrmfiyY39Q9UjqwLB0QjB9zJHGg5FM8cx4JpinYxl?=
 =?us-ascii?Q?JOFxM/jruVY1HiGXcLIve7P3qsM6xGNziXjqBOk1XWby5Aq0HpAs7zkpL1sn?=
 =?us-ascii?Q?UB4akCrJbnjDxjvXcgWxwRE2E2HIdW1biNml9e2M+ytGpPxcVG7qTKYXDoLp?=
 =?us-ascii?Q?joFX0/nNe4XmuSlvXwPnZAGrc4lDWdZgK7HG6Z9/2WW+dOu7eLwmcNi1ZIMJ?=
 =?us-ascii?Q?S+2RIpxIZEThDxXDNo9oIVAlMLkAeuwCvaJ224Fokr6GvsPoAiXz9t/h9srw?=
 =?us-ascii?Q?8nh4bilKLSIBJHiUXKTA86jIiwGEhs8H5HB/iPqoCRq7akTKsTMyNKlpAdBh?=
 =?us-ascii?Q?5JT9cFyljnFKdlV9XItVtJRzzlB1/nFHzHpUtkBJc/CigYI+NqU4hahHhjim?=
 =?us-ascii?Q?ThoDs5zy4YROQbAV5zI6Eur1mleBUiyWQdeUJsE5kzWTv3i98UAo31xq5/Bl?=
 =?us-ascii?Q?kbdeyJyrPnNLutRair34NdAOkYenuKubPOp86H/CqEAwHjvR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f7dac7-1eb0-4dd7-473e-08decaebf215
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:39:46.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbPKejmk9gXN3VsGhrPmx8yFFJjWaUE+batW2LNvwJAC6soAyLgJkPUi+MsbgVQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235

commit badad6fad60def1b9805559dd81dbab3d97b82aa upstream.

If IB_MR_REREG_ACCESS changes from RO to RW then the umem has to be
re-evaluated to ensure it is properly pinned as RW. Since the umem is
hidden inside each driver's mr struct add a ib_umem_check_rereg() function
that each driver has to call before processing IB_MR_REREG_ACCESS.

mlx4 has to retain its duplicate ib_access_writable check because it
implements IB_MR_REREG_ACCESS | IB_MR_REREG_TRANS by changing both items
in place sequentially while the MR is live, so it will continue to not
support this combination.

Cc: stable@vger.kernel.org
Fixes: b40656aa7d55 ("RDMA/umem: remove FOLL_FORCE usage")
Link: https://patch.msgid.link/r/0-v1-06fb1a2d6cf5+107-rereg_access_jgg@nvidia.com
Reported-by: Philip Tsukerman <philiptsukerman@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
(cherry picked from commit badad6fad60def1b9805559dd81dbab3d97b82aa)
---
 drivers/infiniband/core/umem.c          | 16 ++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_mr.c |  4 ++++
 drivers/infiniband/hw/irdma/verbs.c     |  4 ++++
 drivers/infiniband/hw/mlx4/mr.c         |  4 ++++
 drivers/infiniband/hw/mlx5/mr.c         |  4 ++++
 drivers/infiniband/sw/rxe/rxe_verbs.c   |  5 +++++
 include/rdma/ib_umem.h                  |  8 ++++++++
 7 files changed, 45 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index acf4ce2891b76d..ca34c13f980aff 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -332,3 +332,19 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		return 0;
 }
 EXPORT_SYMBOL(ib_umem_copy_from);
+
+/*
+ * Called during rereg mr if the driver is able to re-use a umem for
+ * IB_MR_REREG_ACCESS.
+ */
+int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags)
+{
+	if (!umem)
+		return 0;
+
+	if ((flags & IB_MR_REREG_ACCESS) && !(flags & IB_MR_REREG_TRANS))
+		if (ib_access_writable(new_access_flags) && !umem->writable)
+			return -EACCES;
+	return 0;
+}
+EXPORT_SYMBOL(ib_umem_check_rereg);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 896af1828a38de..25bfd3970f5b6e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -300,6 +300,10 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 		goto err_out;
 	}
 
+	ret = ib_umem_check_rereg(mr->pbl_mtr.umem, flags, mr_access_flags);
+	if (ret)
+		goto err_out;
+
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	ret = PTR_ERR_OR_ZERO(mailbox);
 	if (ret)
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 95f590c10c0515..cbf76d9999fb49 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3759,6 +3759,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	ret = ib_umem_check_rereg(iwmr->region, flags, new_access);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = irdma_hwdereg_mr(ib_mr);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 77a72d2b0dd23f..1a5066828b99b2 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -208,6 +208,10 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
 	struct mlx4_mpt_entry **pmpt_entry = &mpt_entry;
 	int err;
 
+	err = ib_umem_check_rereg(mmr->umem, flags, mr_access_flags);
+	if (err)
+		return ERR_PTR(err);
+
 	/* Since we synchronize this call and mlx4_ib_dereg_mr via uverbs,
 	 * we assume that the calls can't run concurrently. Otherwise, a
 	 * race exists.
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 665323b90b64f7..bb0a00a4e15c82 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1895,6 +1895,10 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	err = ib_umem_check_rereg(mr->umem, flags, new_access_flags);
+	if (err)
+		return ERR_PTR(err);
+
 	if (!(flags & IB_MR_REREG_ACCESS))
 		new_access_flags = mr->access_flags;
 	if (!(flags & IB_MR_REREG_PD))
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fe41362c51444c..ca44bcbc5c0810 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1332,6 +1332,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_pd *old_pd = to_rpd(ibmr->pd);
 	struct rxe_pd *pd = to_rpd(ibpd);
+	int err;
 
 	/* for now only support the two easy cases:
 	 * rereg_pd and rereg_access
@@ -1341,6 +1342,10 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	err = ib_umem_check_rereg(mr->umem, flags, access);
+	if (err)
+		return ERR_PTR(err);
+
 	if (flags & IB_MR_REREG_PD) {
 		rxe_put(old_pd);
 		rxe_get(pd);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index e426d451b89329..0c485a55837440 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -179,6 +179,8 @@ void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
+int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags);
+
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
 #include <linux/err.h>
@@ -239,5 +241,11 @@ static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf
 static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) { }
 static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
+static inline int ib_umem_check_rereg(struct ib_umem *umem, int flags,
+				      int new_access_flags)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_INFINIBAND_USER_MEM */
 #endif /* IB_UMEM_H */
-- 
2.43.0

