Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564238;
	b=OI0JQ4TFb+JuUHNVHL2eu3L9qV6i2YauicE/X8pJnvSIwOFdMRWyJy4XhW17MqiMJfun
	 5PFd3sPncRU6/jB7uDzIA4elXrApxnbMUPNPF3vMWaUdmcDWnkPucXngR5ixHg1++00BM
	 x3EjRtKIEtvRVZY6NvAPF8qRVVstbFnlIdL8QtdXfI1MVPuheLKLz1s9ZZvGK+j4N/gmp
	 +iF8MESaNI9sVez1D31sjQogdqIQYS3Mfnej6p0pfasQDvFhQ5Nqhr1piVGF6POJyo7Zu
	 49cHoqIIng2X9WmPc2ETTmO6sa51Syvx658GAT3s8wmquGMXtH1GdZWPh+qRFlY1k4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hY2fJ+o6G3x6o1sL4E6iqcgKGFVJ/TNgjOS9YdLGu+8=;
	b=TZbPZK+P3x/lp0eL49rCABRtT1cy44dO+1EI2CP1p0nN+j9qBQUQP2symg3saGO9Db+W
	 YTOdaU3XP/LyBbGUOGVR0PkrvjnDP4bN+b9rNuZyig1mmzkiKx4SZ1+hyUJTV/P7q78sj
	 gOt21KXAQc2tMmTbkR6sCXHz6kHXTOuazhkPRsXY63kY/vhyyxDrp66uXBXbRIHQG8rni
	 KgbKdikwhI/VkRrxiPUqJBMbbnMeO+pKUlqTmA5QkiVU2eR1iPvcYvyay6y3WAcnyaRsP
	 IBldqYNlIKbP4uEdylNYMpaCeo4wpw+13PhE7shfVvsn08aaTLpmLuO5VhDBDZLjEow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP2aZTrI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D62606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP2aZTrI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDCE1F000C6;
	Tue, 24 Nov 2026 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564238;
	bh=hY2fJ+o6G3x6o1sL4E6iqcgKGFVJ/TNgjOS9YdLGu+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MP2aZTrIyKV7mXCplaydKm66DSrmGy1kJg+IctVl19FycaPIyp0WkSQAPaPXr/ZDw
	 DTmShU1kVznIXN2cgLbFdmjM2+GOx9E4VDGyx3+x74rdt2VDCzrXaWH4EesaDK0Twe
	 +QnSPPT6hQozlErZ9DjfsDOAS9Oad8TrDseWOc8XRJt0y5o1SExTdp194ZE3ghin1Z
	 1R0q0DaaWMzhbVBKs40C/MDqnwmwLb/I7gg9GKcHXzH1wTaORGjRb2B9BuSNn3JQ3Y
	 +6YqmCPs0DdC+DQ0JjbqBUEOe0dnenvmtB0TT4Sm3Ii/vm3KFcDb/bk5e9R80HlwBM
	 m/uKULqnWq+vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Avihai Horon <avihaih@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] RDMA/mlx5: Remove pcie_relaxed_ordering_enabled() check for RO write
Date: Tue, 24 Nov 2026 18:50:34 -0500
Message-ID: <20261124235024.3360098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112417-overrule-demeaning-63ab@gregkh>
References: <2026112417-overrule-demeaning-63ab@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avihai Horon <avihaih@nvidia.com>

[ Upstream commit ed4b0661cce119870edb1994fd06c9cbc1dc05c3 ]

pcie_relaxed_ordering_enabled() check was added to avoid a syndrome when
creating a MKey with relaxed ordering (RO) enabled when the driver's
relaxed_ordering_{read,write} HCA capabilities are out of sync with FW.

While this can happen with relaxed_ordering_read, it can't happen with
relaxed_ordering_write as it's set if the device supports RO write,
regardless of RO in PCI config space, and thus can't change during
runtime.

Therefore, drop the pcie_relaxed_ordering_enabled() check for
relaxed_ordering_write while keeping it for relaxed_ordering_read.
Doing so will also allow the usage of RO write in VFs and VMs (where RO
in PCI config space is not reported/emulated properly).

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Link: https://lore.kernel.org/r/7e8f55e31572c1702d69cae015a395d3a824a38a.1681131553.git.leon@kernel.org
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 68c183619f24 ("net/mlx5e: SHAMPO, Disable end padding when relaxed ordering is supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mr.c                     | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index dacda8d63c5a6..f235028376381 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -67,11 +67,11 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
 	MLX5_SET(mkc, mkc, lr, 1);
 
-	if ((acc & IB_ACCESS_RELAXED_ORDERING) &&
-	    pcie_relaxed_ordering_enabled(dev->mdev->pdev)) {
+	if (acc & IB_ACCESS_RELAXED_ORDERING) {
 		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
 			MLX5_SET(mkc, mkc, relaxed_ordering_write, 1);
-		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
+		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+		    pcie_relaxed_ordering_enabled(dev->mdev->pdev))
 			MLX5_SET(mkc, mkc, relaxed_ordering_read, 1);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 542cc017e64cd..1b109a8499f2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -868,8 +868,7 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
 	bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
-	bool ro = pcie_relaxed_ordering_enabled(mdev->pdev) &&
-		MLX5_CAP_GEN(mdev, relaxed_ordering_write);
+	bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
 
 	return ro && lro_en ?
 		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 03a99918a8942..35eda9e8ba437 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -43,7 +43,7 @@ void mlx5e_mkey_set_relaxed_ordering(struct mlx5_core_dev *mdev, void *mkc)
 	bool ro_read = MLX5_CAP_GEN(mdev, relaxed_ordering_read);
 
 	MLX5_SET(mkc, mkc, relaxed_ordering_read, ro_pci_enable && ro_read);
-	MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_pci_enable && ro_write);
+	MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_write);
 }
 
 int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey)
-- 
2.53.0

