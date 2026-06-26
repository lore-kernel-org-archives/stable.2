Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668F37F000;
	Fri, 26 Jun 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488499; cv=none; b=UdWmvMT5BgZX5g+rKeIvjteyml9VW/YO573E93X3H7X1Nh2TmnUVniLVjYNUFD8BtBkHJrPOqCcxRSHZS5M7wZWF195aJMqtSlCYCUMsEXjg4q4Y926od3reYPRdXGqb9vAw9/cLG7/EmrI3sJbXg6UDQe97tvDiPIlKo/4MJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488499; c=relaxed/simple;
	bh=pnDKqP7FaEkPhzICqbALrBKKgom7ronRJAiEP38UyXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fT7oS284tK5p0+p4wJOY9MDLxnZbJXtvQBH+Mf+YIVZzN4U4g3nQ3PL37dvA1u1u4inWBXbaRStzacDU9NbZqZPDW2KK9iinw+Z+Wo4hfvvynC2gtsPP15pel/yt3jeuG4NW8fatXmaDqoF6KEvIAo3DsIq1/Hksw5IEg7wX6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACXMcqtnT5q_apsAw--.16893S2;
	Fri, 26 Jun 2026 23:41:34 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: nvmem: onie_tlv_add_cells: fix device_node reference leak on   nvmem_add_one_cell failure
Date: Fri, 26 Jun 2026 23:41:33 +0800
Message-Id: <20260626154133.53346-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXMcqtnT5q_apsAw--.16893S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1kZr1rAr4fGFWUtr4DCFg_yoWkJFg_W3
	Wvgr9rXF18Crs7trsxCF4fZr1ktr43WFZxAFWvqFZ3W3y7uF1UC3s5Zw1kXw1UurWrKFsY
	yrnrJF4rXryUGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
	67AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUbX_-DUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcKA2o+h0E96wAAsM

of_get_child_by_name acquires a child device_node reference stored in
  cell.np. When nvmem_add_one_cell fails, the error path calls
  of_node_put(layout) but fails to call of_node_put(cell.np) on the child
  node, causing a device_node reference leak.

Add of_node_put(cell.np) in the error path to properly release the child
  node reference when cell registration fails.

Cc: stable@vger.kernel.org
Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/nvmem/layouts/onie-tlv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 0967a32319a2..3d77680f089b 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -128,6 +128,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 
 		ret = nvmem_add_one_cell(nvmem, &cell);
 		if (ret) {
+			of_node_put(cell.np);
 			of_node_put(layout);
 			return ret;
 		}
-- 
2.39.5 (Apple Git-154)

