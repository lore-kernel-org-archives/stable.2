Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050425;
	b=KTiE+QibRL8m+22XwrNaHVtNrUfnqWfCcSMCx+Z7wefD9y/OYpGKcj4R2rpVXvyQQBRi
	 sbKgW5rbG19GUt/vpcMdVCIzfPIkOGnZlhRf6tBQEj6zel/0An+norVBQLkfxlOnjsOK1
	 MkitN0PZqC/InyGqIphLgpfIeRmfOmQAnmfkOzm0ToGOj+Uu54RfwIF0XNuWnr/wDaASX
	 gR5J5oqLOUb2aTKAM/TA/ib53CtxnwquLM9o3wG9nPRTfp54DyyjgQVcaw7DETIE36GWW
	 /RSN27zeRB7y3H8HJfyy5+s0l7oOZZVrEk53akRwP3oFknVfKdR9ZbISrNW+I7KAPqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cBaGLgqWfmwYoDpkOcYasGCNnjMU6LCmUincl6XuGUk=;
	b=g2TaGTKkDrIqTJI9kwc4EOY5uUB3mmvw9LykDuCBuE/cpPQMSmjKnZfdzI6r4Dj7V+Lz
	 fZBJUL/p0OF2mzwVcf9jXG8MqAIY6DysTSpYR3nRWDpIMi0sSv23yrQGgzyAUKv6sH5cN
	 yphQ/NEbkHhwH7zoFKs6Gw0Tvwjp9EhrhD8jnuFHzbxuYCcLHaXF5NYGQzYcmGm9V0+94
	 F6ALbtQuFFBKLniS/Lz+xuU7PhPr+qmWA9fxGDDE7smZXZCCpqHNcJzbiCXK/m/EnIqeF
	 p7DrZlyqmcFuBYaAKCbutSPZEUKh6UtLKzRiil5uyLNCnT8jUzmIdjxcHUCPt2A4hdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpmPpeEr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpmPpeEr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3461F0089F;
	Sat,  7 Nov 2026 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050424;
	bh=cBaGLgqWfmwYoDpkOcYasGCNnjMU6LCmUincl6XuGUk=;
	h=From:To:Cc:Subject:Date;
	b=NpmPpeErjfUJ9Dq6w7y81iCrsnaPZLlcMlB0DTH2+72ae4MTlYarzEaj/9KHFam5Z
	 drltYUleZ4TieQ67xHVN7dM+uz8J0sGbgR5EB49xTmEs2yNxHMUh8s6E1n9HB1tl/o
	 sDUiLnaYtly4lR9+sTV8PhOO2L3oZuWbFGW4WxlI81uPFJg9TwFNdAwVYKSW8lKarb
	 S/qC058IdsroTHkWFrECLkS2Cu4hehy3QhcnvHjRq6vnv5ebJ/kxso2aCfoZYPYBho
	 wYk1ecGbyURdZOw0GpvkHIH/u6+hZznJSjdFSDN1qbAsP7jJlFZ9KyomGXMmvtGs8O
	 Od1bO6MAPBVYw==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.karas@intel.com,
	robin.murphy@arm.com,
	sebastian.brzezinka@intel.com,
	joerg.roedel@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommu/dma: Catch scatterlist length overflows" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:22 -0500
Message-ID: <20261107062022-failed-5.10-1c8f6308e557@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8f6308e557f32412e9d4678b3f029f47f6d9aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062022-failed-5.10-1c8f6308e557@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




