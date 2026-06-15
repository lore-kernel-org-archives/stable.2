Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349583A59A3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563932; cv=none; b=KDp+6a/JrJEOJRLNyL7d0ehBp5FH19n3m7B2GhFTUbaZ+ymeOuE8rm/pio9AB4CM+T35zgMTiDpW6y1GH0V1O4QWWASPOCHQRV3mXRM9uQVCBRXYLmZxNFF3K0wqtVRoyYbwoED/6UfrS7l/Atmv0VlMQajZ1vCZ/kHL2tdVSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563932; c=relaxed/simple;
	bh=YGqJ/JMAgzG5+JMO9EDUZRXgVDCVDl1KOt5TmUehV50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOTLrCOOKVDHgGIvA+ljCdKX2sSA4bkAcMUpL935fJYLXesvuTRPRwWvElC862fv1g2d6xLuXMDhzvX+8rIF2XP+68AmnVs25vXTJ7yqoFAwe8OpZ1v6CmTwLD9SMNAlFqYKqxYUWwTBFK1HFylV0UPh0lLIuS1JcYKzsLrwUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCsq6UqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCsq6UqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD831F000E9;
	Mon, 15 Jun 2026 22:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563930;
	bh=PBTLfHh8MkPH4XLg6HWSKTMHTItBCTDs8EEK4U/Mqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iCsq6UqZezkmZNJXC7N+R/ZKZiHeJUDEHmsrWMSAP4vMgsFlBZFvELmYZdbcD0OVU
	 pGiTd7dUNFASC1hDlb7Ib1tuxtLd5jWyeHBH4u61YuGW+7X3GECsYT4qWzuRIzP5Fz
	 AUFb/iSOlWykiTXYSnchLpzLkewKUvaK+9b0ADbuCnPQlshLCtgsT5Ys+z1/iiXyZ7
	 tN03ROk56EG+qsFNeUqftHwK9SyghoK+HCcjl6+cNZiVWcuYYqNsK6f+ydewgcJ5C7
	 EHV3xOV4GWchP3vcIP906I/csg29Zrmjgls1LW3oB1WZNZONiWnKHkLHvnI4xXG61l
	 jGAILBEWHgebg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Philip Tsukerman <philiptsukerman@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] RDMA: During rereg_mr ensure that REREG_ACCESS is compatible
Date: Mon, 15 Jun 2026 18:52:07 -0400
Message-ID: <20260615225207.2520056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061553-octane-pegboard-7dac@gregkh>
References: <2026061553-octane-pegboard-7dac@gregkh>
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
index 408ef2a9614927..aca079c120fbc7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -277,6 +277,10 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	if (!mr->enabled)
 		return ERR_PTR(-EINVAL);
 
+	ret = ib_umem_check_rereg(mr->pbl_mtr.umem, flags, mr_access_flags);
+	if (ret)
+		return ERR_PTR(ret);
+
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mailbox))
 		return ERR_CAST(mailbox);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index a18b249fe550e1..2358fab95784b0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3244,6 +3244,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
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
index 9e465cf99733ee..6968092b6a413e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1698,6 +1698,10 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
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
index 102fc5f56ca7e2..5a9826de59d4c0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1316,6 +1316,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_pd *old_pd = to_rpd(ibmr->pd);
 	struct rxe_pd *pd = to_rpd(ibpd);
+	int err;
 
 	/* for now only support the two easy cases:
 	 * rereg_pd and rereg_access
@@ -1325,6 +1326,10 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
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
index 565a850445414d..4f9ed0c79e16d2 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -154,6 +154,8 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
 
+int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags);
+
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
 #include <linux/err.h>
@@ -203,5 +205,11 @@ static inline int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf) { }
 static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) { }
 
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

