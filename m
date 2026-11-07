Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045898;
	b=evSM2+2WOSQnC+hqu4eRH2txfA6fXXBfXm8+Np4+ocUSXAb44SpSCbktjYXt+5T/u4eg
	 zObn9ZGlMuAegQGKZFT8eqG2JxB/6Ss6UPf28jOt5FC0BnXLQyMD8Da0bItl/ZY8BZ/qM
	 iJ1MdeIjLOJ7+WLi7D905NRQhQ7UI4mkvVG/jOWzDA8DDNX4jwWBGHM3JrsXIif8N/A4d
	 KHI4KMzmffqwY9P36MkxjlZpcpcuZMt67plHIpEG9bEqQqO+lkoLsYSvLIfMQvBRyk2Vq
	 E6lnHiPDNGyXryc+JcF6MqemVIbu5SRaf48gvmYovifb6E3CMbs4XApYx2QkXDDDTlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045898;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JD/Zr3Me4ndj15qc7QaMhuYbPKeC4bjylL0vHA9TCVI=;
	b=D5CIdChALKOnjZOLnCkfZ5oGaoOgbywO0ZXu8gZQKDvDRPgehocpcQu8VW1fRO/AluTa
	 aGbk0u6gv6jmw+iGtW6OYz9xbiLJfFAQ83evsr298PeVhq0sfSYV2Pd0rsETckqa0AawI
	 MuNMGff3Hz7BZ3C2lC1ANLVhX7ZsHsz0xJhidzaqCm1qX0CjQfsg6e04wbqHkthsx3Fmg
	 V+K9+fvCTrfRhOC9GkF3FX3YQEtjjVXUBxUgkM6tW954dUzn+ZOFgQ0zrnIppVVcqEwhQ
	 2sz3seG48w5TmG4/nM0Ku8JYb4VZkmIn4YLIzL2B/dKvA+z6ybm7CgZo807bTZ765cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxGvb1Z4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B353606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxGvb1Z4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0001F0089F;
	Sat,  7 Nov 2026 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045897;
	bh=JD/Zr3Me4ndj15qc7QaMhuYbPKeC4bjylL0vHA9TCVI=;
	h=From:To:Cc:Subject:Date;
	b=jxGvb1Z4o5BaIh1Enl7Xu7oMsMv6UhDbfiqyBUFAq9kcbvM3axNIeWvcNrDllzdrd
	 hTqGqd43wE3M1sRXK1LV9adigOCwLv1WzcDCltrg+AwOZnNg1CFvA16nmUtCqLwo4x
	 PhIGlq57XbxraTjZgAOpUsoOWTuo2OCb/hgkZsYYJXDCZj1Y2RELf5aToshen78gQL
	 nXDbbJ8w0wmpohhhpmOpCf1MHUnXXn1WunGrMiqQyqtof23dXCdIFJD6B6m2Gic5nO
	 3yDO7hfjnYH1981vfC3v+KQGiSAZb0Lz1oWlVbxVLSeWUmjGN5WzEs/UOeXf8D4/YU
	 URNJQF63thnDQ==
From: Sasha Levin <sashal@kernel.org>
To: parri.andrea@gmail.com,
	jgg@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:56 -0500
Message-ID: <20261107050456-failed-7.3-e21952d72b47@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x e21952d72b4740f08a272d694cca223b6b0099ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050456-failed-7.3-e21952d72b47@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




