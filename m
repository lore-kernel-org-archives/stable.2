Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048377;
	b=RgfdRdR2DPTBxNRG4z9dPUoFNd2XrgfWtzHdL3NxHegg4JmZTFqWoZV0rIbV2wR/3vFs
	 9/Vk/sBzTi5COj9xYk8shDOT0JcEHX/sfJVwlV5X+9Y6DApjS3ur4wwwOoG8kf5DAJ29q
	 3ntdo3JNJDb/yu1xbA0PqQiOXIjcX4vuQzqeTdSjz2i+E+1zVulQK8ISjHi50XN5/DW5m
	 7WnZ4phXrJm7ik6wlVCjNxHw5xs1vE0hlMKk5Hg6/nAr74MoqvU/hsiSb5BdISPbVLsQQ
	 DCfhFgJS5hUe0wIeLm65IVLPMoLnHv0L9NPLNvPE7go/6HFo+i5VahxeJmg9ovnQlGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SzZHqVbybIB5CEXs+00sU+pkM3Dtbr4nnDDqjgyu8Sc=;
	b=TMUe20GgKRn47VNiyUCfmEIwD28uDBaebYObgM/6VaIJ5oex1agGW9XaDerxQWOeX8MH
	 IWbmH3lQoRYMN2/YSBlaCBiNUUaI3pFLP5osOsINcVZBDGu8uNjhtvvB8IsQsWPtoq3Sb
	 nkc7HySjR+t6EFl4Tzjxg1MxmlSnHeYQ2vNXnBQvl1HhuNy3fuLbqyRa74wdVZ1//AhDT
	 D4d6Y5IZbpcGcCh1whhHPv5duaL42iIMrlY2tcbVDI3jQJtQl6D0aJpqqzTWVVvQk2Xfr
	 2WQ+xvtnl4jJ+3oaDIGWKi70EDsVp0bNAXlyRgociqskRK89lEvcFRHtKHyw0XtAXrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzIywKnn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzIywKnn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEBE1F0089F;
	Sat,  7 Nov 2026 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048376;
	bh=SzZHqVbybIB5CEXs+00sU+pkM3Dtbr4nnDDqjgyu8Sc=;
	h=From:To:Cc:Subject:Date;
	b=fzIywKnnIrhOz3PsWnUT7PnU1eMX3rOxxQ6xjwAD1Y4bpx0es+NHnc+HxfR6tm9Uw
	 ZfYEwxTeGPFXoXRpN+lSK6zwjMtiT244nLH14ORh2oGe0DSRAr5O/j8HElhjT3bIs6
	 qGwPdQbhlh6Q4auvcARzC6pEX/G5Sq66hGudDQNf55H7kUu+WdNCdMOErLkpK3OBGC
	 LuGnAwYtNRlIa0DGziBaaXndRNEzL5RJvlqZw2t1650BIkDO5vJdl8W1yzk7iFZjn2
	 0mONKlzUaktggsSDQo8+bQ0Q6YCKk0IE4tuB+koBfmQqaaT1Fnv+dX+nOu/rjYJ87K
	 F6gMKj8telbpw==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.karas@intel.com,
	robin.murphy@arm.com,
	sebastian.brzezinka@intel.com,
	joerg.roedel@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommu/dma: Catch scatterlist length overflows" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:14 -0500
Message-ID: <20261107054614-failed-6.1-1c8f6308e557@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8f6308e557f32412e9d4678b3f029f47f6d9aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054614-failed-6.1-1c8f6308e557@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1c8f6308e557f32412e9d4678b3f029f47f6d9aa Mon Sep 17 00:00:00 2001
From: Krzysztof Karas <krzysztof.karas@intel.com>
Date: Fri, 2 Oct 2026 05:33:20 +0000
Subject: [PATCH] iommu/dma: Catch scatterlist length overflows

It is possible, when a very large mapping uses only one
scatterlist, that padding overflows scatterlist's length field.
This results in:
 1) silently wrapping the value
 2) smaller than desired mappings produced by iommu_map_sg
 3) leaving mapped bytes in memory (no iommu_unmap)

Address this issue by adding overflow detection for scatterlist
length field.

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1b80121232322..c19f668a7be9b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1478,6 +1478,11 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
+		if (overflows_type(s_length, s->length)) {
+			ret = -EOVERFLOW;
+
+			goto out_restore_sg;
+		}
 		s->length = s_length;
 
 		/*
@@ -1494,7 +1499,20 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 *   time through here (i.e. before it has a meaningful value).
 		 */
 		if (pad_len && pad_len < s_length - 1) {
-			prev->length += pad_len;
+			unsigned int new_prev_len;
+
+			/*
+			 * For large mappings spanning multiple GBs we
+			 * may not be able to fit all needed padding into
+			 * sg->length.
+			 */
+			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
+				ret = -EOVERFLOW;
+
+				goto out_restore_sg;
+			}
+
+			prev->length = new_prev_len;
 			iova_len += pad_len;
 		}
 
-- 
2.53.0




