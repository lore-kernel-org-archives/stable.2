Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8FE38F934
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558956; cv=none; b=WZ3ofXoQZfoWPBDEi8c/NIfKLGwqUAecGKr0P7wlOcY9Jady8GeF4iSCFDigFgM3GJGa+iPpfXtVNdH9HY9ohFtxPMnToElt8kdeebJsen4U7EQepNEV1jexs3r+5fBTrOQsM1ScUcKPHlRioP1LpI5xZ5sgi08VNLSwMJu2Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558956; c=relaxed/simple;
	bh=GQgDQjeMqGktfgabm9OuFspR/Pr9NAWjjTMib8oO4R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyVV+5Kxk2bvcURkqd4lj8NZrYUwgKYBUHxufED3UREVMvVUlIsBX4l89tcIt1ZsiBZ8Ry05biOOfXYdf6VrxggYZQA1xsLHmeRNl6wK572bDvNxsOxERp/QpPtn7Ok1MOYBocDNqf/kaCMR1CRJ10w00r55/tr48dHe3PUl+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifRiO8Vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifRiO8Vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745FA1F00A3D;
	Mon, 15 Jun 2026 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558954;
	bh=UDMdWBJWfTkb0WUQd8EtN0ZzYxkK3Joxthv5Dlo7sU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifRiO8Vq1KeFYL+cNa3nLFjViDU0qZQyf2ix2kaQKiqByhI2L6b06z+x1s8IPOPZK
	 XW8Gazx9RxNg9TDgicyTI3uamy5Bt/DQRNn+//K2FCVyWY0SoT/GYaS28Pd92Ih2hr
	 CvPJklvQf8oUgrwsAikr2HOOSR6WPNjWwm9KWYz+Wd+Z15F9JPgaZsxAfBSg4doCUx
	 j0KbzlJrftPWp5p4ajY1Ws5++/y4jrvK03Ez/jcdFKIG1mp04QnHv3Di5zr0CHANBT
	 Ukj5BbOvM5EqjJmDsGjDukHDiNG/O+5DPFMkuwfh6tHXHCX0JDajGinnv6LNzHGKkF
	 37BhARgnofXbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Philip Tsukerman <philiptsukerman@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] RDMA: During rereg_mr ensure that REREG_ACCESS is compatible
Date: Mon, 15 Jun 2026 17:29:10 -0400
Message-ID: <20260615212910.2473729-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615212910.2473729-1-sashal@kernel.org>
References: <2026061551-manor-verbalize-74cb@gregkh>
 <20260615212910.2473729-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit badad6fad60def1b9805559dd81dbab3d97b82aa ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index c5b68639476058..fd3a774904f8d2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -326,3 +326,19 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
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
index 55b9283bfc6f03..f86859ffb413ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -292,6 +292,10 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
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
index 0b9cf175ed73b4..04015eb3663d6f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3245,6 +3245,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
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
index a40bf58bcdd3ae..04c370fbdba095 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -466,6 +466,10 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
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
index 726b81b6330c65..c8238db895bf16 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1829,6 +1829,10 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
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
index 589ac0d8489dbd..9466fed6726b42 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1312,6 +1312,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_pd *old_pd = to_rpd(ibmr->pd);
 	struct rxe_pd *pd = to_rpd(ibpd);
+	int err;
 
 	/* for now only support the two easy cases:
 	 * rereg_pd and rereg_access
@@ -1321,6 +1322,10 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
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
index 75f5acad646b43..7060ab90267c07 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -163,6 +163,8 @@ void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
+int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags);
+
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
 #include <linux/err.h>
@@ -225,5 +227,11 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
 static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
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
2.53.0

