Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326006;
	b=G/XbkM8StnslPit3OqHhmA9M544fAypEpksdl21BRbRnCoFyOnemYCnDrQ2PZNpxwE4w
	 cb/Z5FfNR18httY5Qc57R0gLKgImfGX9cEmSCimRCwok6D0a77MwOANml1jfgeKGvHAMg
	 R9VsbPtSU2vrTNKk8braFpBovYxVJxsg63ba1R0n/osyU1eShLFbE6vY7TcVCzc6Fbahk
	 +Hts5nhgKgi6vqjLebuCwR7DzJ+4Xz7KiUhIXbMEWt54VHhJn97KCSA1+rbhByYvaCagl
	 t32IIjgeLicqeV0FXysUXED2ldScbFhbkLqlwPpFtzddQPNvSPEF+DLKqODqQHh3H9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sJhOzefKyOEL9GGEHxAz3IoMEZaq1foMkZC7vE5/6v4=;
	b=WxF+ELLC/aXpFyrlhciKwJVgciNJTTlM6B4ji1e1Itcj/jE/cPlfq+zJc1tZ1Yj4wnDE
	 SSSHwDIVAv+26jNaVvzmKtSIbOfHXVHMcsIP5RrVHSbecvQSuiSZVdOjOWMjyYVyTZ4fO
	 5j61dOswZGE4lrEsF/xIrHJeLhhFFnzqSWiFABUvkiLnmLkbBnQxnVp77Lr3LybocfBvv
	 Jo7X6dE/g22AbXz/QWIC5mQ+esKpiECize1uedwDk+OxojyCOzb8cW18QYpZZ1dxCo3Eu
	 7TCPU8QN9uOmV21Wh34tvVDIBIhT5gB1AHHjvW2CP+hEqMBP0YRmWbOAQi3IJVv3Eww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWwKYa8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB62606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWwKYa8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EBF1F008A1;
	Tue, 10 Nov 2026 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326006;
	bh=sJhOzefKyOEL9GGEHxAz3IoMEZaq1foMkZC7vE5/6v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWwKYa8sUmVs1XHmhY0WrDeha6V9Obj3qUK1n8DkB5m5Mqk5xBLQve98177VPmvG+
	 WD3M9KLebAHULP2pRpdmbpp0EL2LDHenWCPYa7E8+5PQbN9QlLexSwiemGSCxWuc1J
	 txaBy6qzM+1LhxSkhAxbWQoq4cYuRTOkT+kZqAv0PiWjtDh5J+xqnQE7bvNVJfJ+0d
	 3PxWXkGEZGqmpPuQXgpAxpkrmHrKfOZOrjF5i5OAafgLzD2tc3SYNHnymxW14JBSKH
	 CHQIzLqSYhwio5huC0mNJryzms7cusHjmVMKFZUlhI87tPujgKgwL7E7AyfQmurKId
	 /AiKHSWKekXAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iommu/dma: Catch scatterlist length overflows
Date: Tue, 10 Nov 2026 10:53:22 -0500
Message-ID: <20261110155252.2304363-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110155252.2304363-1-sashal@kernel.org>
References: <20261107054614-failed-6.1-1c8f6308e557@kernel.org>
 <20261110155252.2304363-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c3e5f9a435ffb..3ac8faeef67ba 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1250,6 +1250,11 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
@@ -1266,7 +1271,20 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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

