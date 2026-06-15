Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B893FF1A3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533346; cv=none; b=EDH9nXRgX8WEaek9ozWStpU5roYToQPGprgn6i4jpk+4nsF9ihpCVSol6KO9Ip4/U1svbrI6ny0gQhng047Bwb833EskEonPKrJNCk+c4sdFGzmoRPGyfH4ZYhNMM6X00AwNdkYH//XyZGwUx1nqYjXOaoMsRd1K5feFz4UdQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533346; c=relaxed/simple;
	bh=4Nvwp6ic2RgLFsFf1uSsfEJvCDsRlZ05S5tst0ReRxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NloY1CWm6P05BoST0LXCejszB5nVAX0IwVIE/4rVEl505DFOvS+8tETAbd6TEjXO49K94XKdEaPsuNjAVWmbww3O/PzS5/977zO7Oh7nJkybpdGzyF1wwmxhtuhl5dWaPu+816vekL17LqUfRFTrawhTFzfJcoFxxDIBcK6MKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jt+m3fnm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jt+m3fnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15CC1F000E9;
	Mon, 15 Jun 2026 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533344;
	bh=dJBZSIwaq/Fqd+Jw8j4tIdwYeFGpKJNln2wieGIG1r8=;
	h=Subject:To:Cc:From:Date;
	b=Jt+m3fnmw5a7jFzKDC3vC87nJOIoF5Z9TYoYIyWgqZyAzKS/upRoyNP9qVM1L9ORX
	 PwDqoOoSQD4Y12TdFU5qukXcFPIhBbNYZJSZtZpkxZpNKeg+rk16owzBbAefj4JcIP
	 LpYeRd+Vahp/QEVUTwSV2MSB+IXv+PpjdZOP+tDE=
Subject: FAILED: patch "[PATCH] RDMA: During rereg_mr ensure that REREG_ACCESS is compatible" failed to apply to 6.6-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com,philiptsukerman@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:20:53 +0200
Message-ID: <2026061553-octane-pegboard-7dac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x badad6fad60def1b9805559dd81dbab3d97b82aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061553-octane-pegboard-7dac@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From badad6fad60def1b9805559dd81dbab3d97b82aa Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Thu, 4 Jun 2026 15:03:13 -0300
Subject: [PATCH] RDMA: During rereg_mr ensure that REREG_ACCESS is compatible

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

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 786fa1aa8e55..4b055712b0d0 100644
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
index 896af1828a38..25bfd3970f5b 100644
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
index 17086048d2d7..8cd427532805 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3803,6 +3803,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	ret = ib_umem_check_rereg(iwmr->region, flags, new_access);
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (dmabuf_revocable) {
 		umem_dmabuf = to_ib_umem_dmabuf(iwmr->region);
 
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 650b4a9121ff..6747bca30677 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -209,6 +209,10 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
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
index 3b6da45061a5..fb40b44496f4 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1179,6 +1179,10 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
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
index 4d4891dc2884..4cf04a44189c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1319,6 +1319,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_pd *old_pd = to_rpd(ibmr->pd);
 	struct rxe_pd *pd = to_rpd(ibpd);
+	int err;
 
 	/* for now only support the two easy cases:
 	 * rereg_pd and rereg_access
@@ -1328,6 +1329,10 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
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
index 2ad52cc1d52b..49172098a8de 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -156,6 +156,8 @@ void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
+int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags);
+
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
 #include <linux/err.h>
@@ -230,5 +232,11 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
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

