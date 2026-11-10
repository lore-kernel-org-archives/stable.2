Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327995;
	b=A3/1R07FsLNJF0Vg3fhVCO+Rj7pmZ8xo/2bAdTGRW8K8FO3YcIL0BiBYq1Q85OfL5Xdr
	 DmaSAInQOcnq/vERDVOYZFghZvx+cc4q8Hgaq3xzp0QcN9cYdwm5PBNWG6esXTCWVJLyq
	 YK+Cn1g5k7oGVG4Q/rYQ2B7An9H47G78L84yni6PZ4V+Id8/qC1N7KM/L+ZW3XKa+bdHA
	 3oIzKMCfwC6kIn93HkGKmES0tiUciqFgctd+z4ZoII/zxMCeKW0BM6zrjNzPssFp9ZY31
	 wxbIv53rH9LEAmwLRONlSFgJmDsQesFgAFft+mZjmvCvVqcx7Z3+SOHzpdytXew7knA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lI1fjWdnZj7GJO4o3WwU9IdBvoMbfrGdNk/WBV4xtLA=;
	b=XyVLKX8S0/43y84sqdONakgl+yC5CdZFDOHz+5gD/M16BRLfnV7uTRZfpD7/0s31X6pl
	 tXRfrEpCEQruoPfe4zXxFHVXyXrQEw06gmw1E4T1c9Kxp0tn3wgxPLTpDCuYnG8J+WrUN
	 BRFJ4miPqvysd5N3gWznl/dY5zbaoybqYlhyC4Salbsz8LXlE9cvCczM6ROy4gXVdFVVg
	 jgFZFvWsXqRJOYdqVy++oaNzK+pfUoA12rlpZJ03USIIixYdnCO8mwha5u7oI4fcxLiAH
	 pn5atAC2u+rlwqXv4YVYgdNu4/0pWjJc4IaqssZCbMui1Wyo94dG+E8E8N7TMKQpDOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmQONUgQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268C606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmQONUgQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66971F0089F;
	Tue, 10 Nov 2026 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327994;
	bh=lI1fjWdnZj7GJO4o3WwU9IdBvoMbfrGdNk/WBV4xtLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmQONUgQSLebWBnc+grzh8uL4PRkSK6mFh2zwLOIxdBe3LRiNmZHXv9CUPU+ZKdNn
	 6DnYHQw/iNlJqZU4zLJUJR1jnejCFky97jsFKN7WQncD/U9SZsGrU7VHJZKfoKbcAX
	 qkfNHFDz8smPcB4VokQAxmKMt7u7a0/km9A7aYG7BEs1hufvhJzmoWtDExcBdkgJTw
	 ci00blV67RiS6BV0LFLSzaoIETCMfW6EMXv9KepMYTDirS3U8gqRkXQkm1zvteY676
	 ACnSoBu+/8Uum7l+hLqsIb1hR7GHijtHPpDTc0t8tcfMEmYJhGY3jDAR6nO4K72XuA
	 WuvrEJtFeaS/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iommu/dma: Catch scatterlist length overflows
Date: Tue, 10 Nov 2026 11:26:32 -0500
Message-ID: <20261110162514.2440239-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062022-failed-5.10-1c8f6308e557@kernel.org>
References: <20261107062022-failed-5.10-1c8f6308e557@kernel.org>
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

From: Krzysztof Karas <krzysztof.karas@intel.com>

[ Upstream commit 1c8f6308e557f32412e9d4678b3f029f47f6d9aa ]

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
[ sashal: adapted overflow handling to use an unsigned int cast comparison while preserving zero-on-failure returns ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dma-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 62dd195d88062..321c2f34de4dc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -864,6 +864,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
+		if (s_length != (unsigned int)s_length)
+			goto out_restore_sg;
 		s->length = s_length;
 
 		/*
@@ -880,7 +882,17 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
+			if (check_add_overflow(prev->length, pad_len, &new_prev_len))
+				goto out_restore_sg;
+
+			prev->length = new_prev_len;
 			iova_len += pad_len;
 		}
 
-- 
2.53.0

