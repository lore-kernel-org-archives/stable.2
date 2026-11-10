Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327015;
	b=s4P8OlLlTIy6iIqhDo1dK6HdI9q42vmUVkCOBeZqo0qawiKOIKNnW4IQgDty22os0Hcn
	 sJDA0Bg6mxMf1AwK33o6AThpjzZmpkYSNzJFiT0zGp8PhBywjBb5W6esakBdXmrIFZqe+
	 vL9iLj8sOBjYpjtghl+JRNYb5tKTo8rZy9WC415JNVyaUy8Vo+zAD0gwjohly9bDSaM1o
	 A79V7taZjgGGvuvw7XT5iecNRPtWo1r8qae5SQnlDwZqDIvQZaCq1gmftOoY3E7LSlfc1
	 Ou6r2fg50HXhNiAS0Z6rU5uM3spnbXbvTTVm7K6/AsXqFP70DpdL8M/4bn/3TbqmXCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dlNTuczLGHrz5Am0z6YZd60IUeF4Xt5On/hEzBoyLHo=;
	b=iRgIiovDSUlAVxVIuDhsI1NgafKA/JXrF9l7HBgFkwDJoqAkscvvM+XUEUldQaLvYHbN
	 JxT0DCdj72CBdWUgQwJjkzW+ksBftCrigQ6mhaCBFCin6hs3h5q8qpg4MZqZe7Xy8vOPx
	 j31cA9DaJG43QNGN/x8aKOKO+RR9nsEqIQOyGexR8vCsxHNioOMOIPMjgEpgmsep/MC97
	 3aB9+itucNJrthDGyqDMqkeJIR6WvxXTB9RIi3tE75S7goTz0XwxZeGFtkoBU+2g8neYR
	 zUDpmVq8juFLYHk/lcNpROoCts5QM4lJGTEzi6bbtCEGPuyFvQUGIYllNpIj7j8FvVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxyqFnbv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA260A2626
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxyqFnbv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A177F1F008A6;
	Tue, 10 Nov 2026 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327014;
	bh=dlNTuczLGHrz5Am0z6YZd60IUeF4Xt5On/hEzBoyLHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxyqFnbvauLomOurnGv3KOqdrWRsfAl4ZHfmnHUrKqN6HOxh8dRr/sDtM98sFbis+
	 6pKoaO+LCCC6aMIw24G+R1tot3Xm5FwIvq1mJ3SnLzEjY4ha1azgCiyf9XoDqAhh6W
	 XEPu+yKoCqc16C7MnoZeyO7IBMJoHME+CH4EGwG6n0ELMZTwPulp7mPyTbb9rrnbpA
	 uIKe0k92Chh9DuXTmn6rIut10V3HzmKf3LhCLf89s4XpHMReUoAlRifYR4pF1iAM3E
	 WxSyKw61drosQKQxeV5H3JrjCWnVShVsqJkqbZyG1/xRUO0bG5Gd/wWccDNICg9w+2
	 5y+i77BARVZaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iommu/dma: Catch scatterlist length overflows
Date: Tue, 10 Nov 2026 11:10:12 -0500
Message-ID: <20261110160952.2374331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060343-failed-5.15-1c8f6308e557@kernel.org>
References: <20261107060343-failed-5.15-1c8f6308e557@kernel.org>
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
[ sashal: Replaced unavailable overflows_type(s_length, s->length) with s_length > UINT_MAX. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index dfef5d7f5885a..d781c290f26c8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1023,6 +1023,11 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
+		if (s_length > UINT_MAX) {
+			ret = -EOVERFLOW;
+
+			goto out_restore_sg;
+		}
 		s->length = s_length;
 
 		/*
@@ -1039,7 +1044,20 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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

