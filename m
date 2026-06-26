Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429943E5585;
	Fri, 26 Jun 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488186; cv=none; b=MVHMmKZzWF01Me7AGyBFXacr/O6WQodQ+fU6SkpntSZV/A36iHUCZrJs6+yrGNWC2dLYr2dZeyJPcnVmkHGge2KwkWDbiqN+x/lJJdCc1IIAnd8WsyH78G9LjN9FLWUWcIUu0oHIP0h5BEGCi1Kl6Fv7Xo4N1Xi9fV/aiJIjfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488186; c=relaxed/simple;
	bh=/lHn2yo7qKCSiurYaJfJnlNQ96+XtgR0fCTpfvQfz3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyIXKGhHbjDBv4CcT9lBRIBIhE/JTUbU9BeKhkcMtL1GP2sshjU0CD+8iNJXTtCsPXH9iiQ7EWRsxJQ5S1EnMNCEk/p+CGaFlcTu2cXYWcaThqnkhD1s5uOQ0cakg0BFjGZxRyCASiu9u4gE1JEB8CAMArgXu7rUXyJYfYXHo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAnwcl0nD5qZHdsAw--.4527S2;
	Fri, 26 Jun 2026 23:36:20 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: ath11k: ath11k_ahb_fw_resources_init: fix device_node reference leak   on setup failure
Date: Fri, 26 Jun 2026 23:36:19 +0800
Message-Id: <20260626153619.52954-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnwcl0nD5qZHdsAw--.4527S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur4rCF4kXF43Jw1ftw4fZrb_yoWDurg_GF
	4Sg3Z7Zry2kF4jgrW3GF43ZwsayF9rWF97G3y2qayfGay7CFyDAry5Zr13JrZFkr48Zr15
	GFnrXry8Zw1q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPrcD
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQKA2o+iCg4GwAAsD

of_get_child_by_name acquires a device_node reference. When the
  subsequent ath11k_ahb_setup_msa_resources call fails, the function
  returns immediately without calling of_node_put, leaking the node
  reference.

Add of_node_put before returning on the setup failure error path.

Cc: stable@vger.kernel.org
Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 08d3a0c8f105..8a08275db40a 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -996,6 +996,7 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
 	ret = ath11k_ahb_setup_msa_resources(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to setup msa resources\n");
+		of_node_put(node);
 		return ret;
 	}
 
-- 
2.39.5 (Apple Git-154)

