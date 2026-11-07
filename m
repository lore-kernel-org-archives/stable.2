Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046987;
	b=b6Epf2wmcpJ5WqKZycBqUNpmMvFZPkwnQHqfNXeXunRYNFQXPzxYbe9V+HbLZO1tykFV
	 txtVaJKAm4uscH2ULYH1uIFMaz4mMpxU4YFKfKIOYqsMkcKJBmjvmgWV3Vj1o4Pzj5D1j
	 m1SfT2TY3nsyDuuvE4y1x+sGKXLjOzj9OgdUJMlqlToJvFaRMPmGhmCDKc0k5IaFz/3w5
	 5iXDQsKY67qNJnYPVVf9/YrKaDBmOHSaRG+1xmLMgExHLgZ3fxBe7DfPaMdpFlVrKahZv
	 MeT6n3m+d+nLiHtRA1Tiv8OFeYAE8CMOYGhLdmRC7MRzsAjSFq0kEMc3kwnFeji6TZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nc3MIr5ob3eKW4Ckf5UzXcgOmUzj/TdiavDjOD+JuTY=;
	b=jZ1CHEmTQv4yTJrhaikjwYsagCj6oBSnJaSPSzsUUNHmKYH5u0Ow3rk37YA6GS+GJ1c5
	 o63m3Ola8juZIW/SfArr0+/HNu9sBZ69qCZmNCwVu5i9Lk9yvc/O0boXjCs3zt1tfQvIU
	 Fs7aw+5LJWS0zeTuDmrPubcYlwPJUMlCtcHTPGXbnOR2HX76CJdELIFesVAUmvwDYRdLp
	 jMRKpMMujPZr95TR/yOkbCtCGy3u9D7rMACcCAfJhNxLB7PJV0fGGt9rpI0t0C7tVgxks
	 f3j3XZQhwwk0ej9OT1Wava31GQ0qlllimLoLMc4+C/tReDYkedSyw5EyiCvuktLwVOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FS1mNioh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3C606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FS1mNioh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991361F0089F;
	Sat,  7 Nov 2026 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046987;
	bh=nc3MIr5ob3eKW4Ckf5UzXcgOmUzj/TdiavDjOD+JuTY=;
	h=From:To:Cc:Subject:Date;
	b=FS1mNiohC1GmeyH7vWBQWqKFT/HRGXNQwGbr0UqMi2i/zCEXAoGiLIEEWLbOYYsEh
	 SrB4SUhtpcgT2wCPnTTLB1xte8+VXhel5OwFan35Na3fnh0mmRrLvGOrVewOgxV7QX
	 svffJsIazu6x8FJADeDJvOjz2qqKdALTncDSk9Mt6PcKx9WAaCtrTI0+m4bweCTXG+
	 F61N1+r4BkvyKllVdT+dyABqfGCYFhnrcjXUzj+0ci6JRrrHIFNLgJoQ/7gNGA1513
	 yzu+w9HWZH2PWvUa+Kemzguhn1rkjwehuILHp9tCxJR7Ceqvnjnh+ivZzDSAoKHKCH
	 g50yAtxvT/1pA==
From: Sasha Levin <sashal@kernel.org>
To: parri.andrea@gmail.com,
	jgg@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:05 -0500
Message-ID: <20261107052305-failed-6.12-e21952d72b47@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e21952d72b4740f08a272d694cca223b6b0099ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052305-failed-6.12-e21952d72b47@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




