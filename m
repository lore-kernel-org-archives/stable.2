Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047745;
	b=CTcJPyTAFrI5V5QtDsPKQFN3HJBis7zCpj1DlQq0C2qxuRKpZBOtKB3ftErPJpABYc9S
	 DH9JmB1GydCYprz8/P+sj54cHpocVUf+Y2g7eE2u/jsoIWmp9WfWDtViJ8n89WzvbY8ox
	 SieaAiANUmnS3/jfbQiGKCMwcOt5bHBdK2Av8F46bwnIYabRIJ5qaO1eT9y7SeCWjG41u
	 2AP1IwfgO58tBYypwsQRDLVq2RO1ug55yUELkY7UALbP4nsZp+YHWsIcZXtq4fMNW4g5u
	 IoLS/Swwe3G4Z1PbGGWfL1ouSaonw4U0GXp0ceITq3cTh4BdX2Hs6nEf+FpXtbBy1Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047745;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UXqYFvYNT45rmA2W8Yfn50eEJx6E/quMOb2NpzyEAZI=;
	b=4gk+duWhzS2LzCRFdSv4/HKHEv4bE4hz8lU7tEIrR7xMDtkXSgcPVL00JXHlV/81szNy
	 tWcLGqWlNVCYlc/G30fMbWzvj81ErYQUNtJeIxlrEDgNT3XoBQ3uC97rsGO35PgFZUqAP
	 eLQJp4ys2fFa0Linq0zKGPLj+1l0trdbkTJ7h7lSnLIBZ48NSa+PsEEaDayMHeoF9CI+W
	 wFE290OkH/wwiTGfX9oybpb1Pajr/Jo4nrQBpklvM+SERIJUjgcBVUsimu19zxnxW0POS
	 HE+cJkCfcUbjne9/IFqg2gpRE4kxwyvbcjAg0LGUadoiC4T2L/hPkMhLGQ5RoD7kyDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLtYD+SV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7678606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLtYD+SV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A11F0089F;
	Sat,  7 Nov 2026 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047744;
	bh=UXqYFvYNT45rmA2W8Yfn50eEJx6E/quMOb2NpzyEAZI=;
	h=From:To:Cc:Subject:Date;
	b=eLtYD+SV/b6jomEMTZGm2iRCOCBdmpSHee0N/y/N3iQLOIoGLw5iVNbtZeHcob4qA
	 z1a94ihX+6nLL4nnUXDOtdn+1JENdxCckwOx4BWmBiRfXdToN7yZ4cG+8KQf44SXxT
	 g4rrF6ub87OrlOhmCZgMOzhtwE4yQYRT5Y/osnx8CfvFTdbhf1rVKNRMODBDVDtm/v
	 8ag9GrOzqoAcelsM6+PLnJu6D3UaPsr3yQcQkgaJgczdOppI9jk/7U10JBv7kt/6Er
	 55e8NeAxqvdkzXY8itRRmrmCzDeYk2Mblmj4PNq46TiX07LjuloAhpd69bgEpgkytv
	 30qLDIvcg/bPg==
From: Sasha Levin <sashal@kernel.org>
To: parri.andrea@gmail.com,
	jgg@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:43 -0500
Message-ID: <20261107053543-failed-6.6-e21952d72b47@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e21952d72b4740f08a272d694cca223b6b0099ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053543-failed-6.6-e21952d72b47@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e21952d72b4740f08a272d694cca223b6b0099ca Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Fri, 25 Sep 2026 18:11:37 +0200
Subject: [PATCH] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles
 the full IOVA

Generally userspace is going to step the dirty bitmap through the IOVA
space. However if the bitmap ends in the middle of a large PTE this is
problematic. The first step will clear the dirty bit and report dirty to
the end of its bitmap while the second step will see the clear'd dirty and
report clean for the start of the bitmap. If it happens this ends up
losing dirties.

Further this function is missing bounds checking so if this does happen
ther is a good chance it will write memory beyond what the userspace was
expecting.

Return an error code if this illegal condition happens.

Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Link: https://patch.msgid.link/20260925161142.189813-2-parri.andrea@gmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 12 ++++++++++++
 include/uapi/linux/iommufd.h        |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 483f0cc846466..953f6a57d0ca7 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -409,6 +409,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 	struct iova_bitmap_map *mapped = &bitmap->mapped;
 	unsigned long cur_bit, last_bit, last_page_idx;
 
+	/*
+	 * If the range cannot be recorded then the system call returns failure.
+	 * This is to prevent loosing dirties if userspace is expecting to step
+	 * the bitmap through the IOVA space.
+	 */
+	if (!length || length > bitmap->length || iova < bitmap->iova ||
+	    iova - bitmap->iova > bitmap->length - length) {
+		if (!bitmap->err)
+			bitmap->err = -EPROTO;
+		return;
+	}
+
 update_indexes:
 	if (unlikely(!iova_bitmap_mapped_range(mapped, iova, length))) {
 		/*
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b4c7194cb08d2..010f47f7d3d23 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -871,6 +871,12 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
  * Walk the IOMMU pagetables for a given IOVA range to return a bitmap
  * with the dirty IOVAs. In doing so it will also by default clear any
  * dirty bit metadata set in the IOPTE.
+ *
+ * The IOVA range given must fully enclose any IOPTE. If the range starts or
+ * ends inside a dirty IOPTE then the ioctl will fail. This avoids partially
+ * reporting a dirty range.
+ *
+ * On failure the dirty state becomes unknown and the userspace must restart.
  */
 struct iommu_hwpt_get_dirty_bitmap {
 	__u32 size;
-- 
2.53.0




