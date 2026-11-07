Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046314;
	b=FMrxyvRM0gpaCdb6sAk3YATBOhBdyHzbDBV3pdKLTUaa+AaA5VSCYPFKHc2BbEEfMYMj
	 zl02SXF34cwXsp97F2lyw4sPpQVukbOblnxDJjtNcVqvjbL48mvjNGMuIaE4UdFK5Ti1n
	 Fz/y2JmmzVbM5ERrJ1/ynJr6HpJjf+mDcPQYi4+Da4wW2csdtVC2vrB7ExP86qNJUYXSK
	 LXvyYXmhra4yiT+MFllrStSsTR6WGk1wqLA7dOqhfaYd+0j4yWEL19r7K4R6rQZRCj5d9
	 bfgREcwXQFMH6vT/RR3aDQL+OSWTtQP+by/TA1gJ6ZjJM92nHW/JpF4baNfOYJt06Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=La8I1VnveRPdaxG6HRvcZwPG5OnO2GCnCPLo5A2RV6Y=;
	b=tYLIE5oKg+elfQOJmuTSOLI6A5+F/2mngi2R4j41gc3H6S3nuMPHyKWuwyq+H+vivS41
	 cpgzQnBgK5vda3xdhoiVIL/u8oKErpK+0GXzueM3+QDUpzd2v31H3LZmiMplO8I1Ajed8
	 NUJvi+LGHuhidzDzdOKDEUOnd9wjTnQwO78cS7xRXWR6VK3rtvkR+6ViF9nEeaeCH98NA
	 er9DLFNIKCd/5hVEMtn27M4uUBJCx1ihkIhYiYdOX18XsIX0KcT5odM64U6NU3MJ+iBti
	 Zxm9OLmC009XyREC6fAdogrxGqjVb9kDBVxXIiehjvrr/lDvq/79M7uLVvDcmkeZdbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGWA6bKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD78606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGWA6bKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353AD1F0089F;
	Sat,  7 Nov 2026 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046313;
	bh=La8I1VnveRPdaxG6HRvcZwPG5OnO2GCnCPLo5A2RV6Y=;
	h=From:To:Cc:Subject:Date;
	b=cGWA6bKItJFOIFO04sXlWFG/WCLt7jqQlfj4aYS78Zc3n1uMfi9zNZmX+AQ3kRnkK
	 PiM50f3DNX/Ysdbh7CIyLXBUPzMHamvAEeESnyWwVwUnJLmybG9AuF0KryVGALV0Dm
	 cmbizOR48KBFcRd3c319WxOdSgX6XCHjBzO5edCaSr1wPeL6IowT9o1YmYu33cpbIo
	 2rcyspw/pezdVZGbqd6Hsn9KfBH6hdSOQtv4903U7QRJCGUDjYZFVo2qNfTYalSDC0
	 waUxcrTJxN4fOPqxzJ0TmcDhQkKrMctxFqjOnotJUsqAHSq3IHEpMRDJEIsAhLR04D
	 tBt+dfRK0hopQ==
From: Sasha Levin <sashal@kernel.org>
To: parri.andrea@gmail.com,
	jgg@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:52 -0500
Message-ID: <20261107051152-failed-6.18-e21952d72b47@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e21952d72b4740f08a272d694cca223b6b0099ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051152-failed-6.18-e21952d72b47@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




