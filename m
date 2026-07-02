Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668083B895D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031303; cv=none; b=tlp346QA7/OZlcLDMIXlV46jrEdAA5sr1uFFcRZ2ln4Mdd/bb/e00ckcI7BpWSgpnXi9e4yOJIUMb5W7fpAoUjfPRIJB5nlJ+R8GDRYgmDeRwnMcNT8TdghIcP4OXKc5lD2GXKXgm2qVNFuNpqOrv4QAUnXAkBMs4dbqPTY1wRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031303; c=relaxed/simple;
	bh=NhPOBFymM4iytlpbMVnpsIX4tj32JcuO5EuJy37qJ20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uwtJDptccUDCf2IGFC14eu55/8gsk+1ICXlTYJAq6JVyYgb0PrL1vZVoFJkU6njWn9z1tTxynV2Adlmizb2Ar+sDdt1hz9u0eujtSpBoSPflbBInhAK2DdLvOqljIPppyRMHVGMt7HKvnnkuk7BjYuK9xzTj42NfgHC7oBrAq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FX/+iBZN; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FX/+iBZN"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662IrZ9q3942411
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 15:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=AiFEfhNTIOViBQyl8B
	wIWC6v3Ib53cvu8YduqIAlzko=; b=FX/+iBZNK+r6qx7+qRW3bQa6AcfQ0ATQ2+
	uOfqtMejWKeI2jeyzLerMoEsU/8wWbSSpfj6NGQatlEYVopopUbTbXhO0XGIAHRV
	2hNfRKhnwojDceMCKow8v9WW/sbHy1jH7mUR2O91pDYNmvsADPEuMROfKcEdLFHP
	4WMEejfkNKR++JJ6e3ugQsRgo0452K6W1WslcqwheHcDSXHCi6CY7qnNg4zHYokt
	kMY5BQQ9xPIv0Choba8IzVHBDrC/GJIHrSB1mDaXpq7dE1ZSXlP9PJgQUyk0kqGm
	RkujvzQJtLgcbNmHIpDw2Vqqerr7qTt1afIklNEsxf/dpv3phVEw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f5c0srq43-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 15:28:21 -0700 (PDT)
Received: from twshared6916.34.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 2 Jul 2026 22:28:18 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id B6F3B40F35B7D; Thu,  2 Jul 2026 15:25:09 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed
 Mahameed Michael <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>
CC: Michael Guralnik <michaelgur@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhiping Zhang
	<zhipingz@meta.com>, <stable@vger.kernel.org>
Subject: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
Date: Thu, 2 Jul 2026 15:24:58 -0700
Message-ID: <20260702222507.1234467-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIzNCBTYWx0ZWRfX0LNo4qc1TTOu
 2tZeUbeTB/xgPTBpj62H1T/KemBXPkLTNyMTfcIjkgXFgKXyejZcEA0d6Qog9pbM+amX3TqseQX
 JdW/qglUZncoxYeBJq2upzIdw3vluMOf4QX7r2Nsscg44gU476AG/femnv2Kph4xI+q1zrRFC/O
 6cGrNSDe16dsPMbFqceglIbluQVltyzl/i+yB/fMx//MmK90Ir3N3MxB7smNtoft1nJ+i7v9Al/
 yDOywabCTQO9Svv594J/eDhczvhPOdj24bRz4D6EbhTeM1jbmvIdYPkE2tupD6Pdy8kMiCUyZSH
 +q3AlydaKHC+Zbpg8VgRroXRkKufG2Uc2Je2Sx6URU5JvWU236OGuBkurf8mjr6GwHHe5Y73B4l
 /Nh/Cf/PlfFI17mjVC4gWVzBK+fNLt/te+za3uCJaFpDnjfFLTUU93MirrcwY32ece5aQn6l3U8
 563J3EKaNdoSBBA5q9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIzNCBTYWx0ZWRfXwfvir9JlK4n0
 plnBToFFzKnJfMfOSWiSukk6JQ7FEgFWrkSjAXxWP4WUhGifPUVVOnIdijP8rdBWA72t3a30JEx
 rLxdLARUL/S/nEkUjItm0j/ls2XRziM=
X-Authority-Analysis: v=2.4 cv=H7rrBeYi c=1 sm=1 tr=0 ts=6a46e605 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8
 a=vNmdTtWwCD1Yl-TW2gAA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Vg8m6RNTOB5yi5FKFb82Vy9ubfGKjZzx
X-Proofpoint-ORIG-GUID: Vg8m6RNTOB5yi5FKFb82Vy9ubfGKjZzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01

Workloads that repeatedly allocate and release mkeys carrying TPH
steering-tag hints (e.g. churning RDMA MRs) leak one
struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
and the kmalloc slab grows over time.

When the last reference to an ST table entry is dropped,
mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
mlx5_st_idx_data allocation was never freed.

Free idx_data after the xa_erase() so the lifetime of the bookkeeping
struct matches the lifetime of the ST entry it tracks.

Cc: stable@vger.kernel.org
Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
Reviewed-by: Michael Gur <michaelgur@nvidia.com>
Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
v2: respin per maintainer-netdev.rst; no code change.
v1: https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@=
meta.com/

 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..7cedc348790d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, =
u16 st_index)
=20
 	if (refcount_dec_and_test(&idx_data->usecount)) {
 		xa_erase(&st->idx_xa, st_index);
+		kfree(idx_data);
 		/* We leave PCI config space as was before, no mkey will refer to it *=
/
 	}
=20
--=20
2.53.0-Meta

