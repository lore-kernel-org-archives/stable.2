Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA147A887
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198693; cv=none; b=gW59whd9Q3J4znOVGMZmXWvxBFqAu8gF5MkhlfiWVTOIGd5krwJdxGA6uFMwBCLCb/t0POH+R5wmToFtG2E/tR7iVwOBOlqIb50KX/eZZCQHOln7vdhJZz3CBUb4e/lU0X3DuLMHpzrV29+TtpVYgME2Q+CZZFSsWJl706e8TLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198693; c=relaxed/simple;
	bh=acy4YY8icqRpYM8WEcjVm8frb5ecV8yR7yaJrUuvVi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VucFB9v91v1FkFCNrkYSRDpb0cbUsyC5p2m36FOmqlbItihU/IvLfU2fJEenoEbA2uCUteJip6t6eJU8r4ifr4imnGLfIttevSr9UHm9E4FyU9Qm4TO8nV0BturOJxLs6LlXwl89qtW3+XwF2OwVsicwHDO5Fge7gL4rCBJ48C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqNiFLsz; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqNiFLsz"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35120d43ecaso2125241eec.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 04:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791198690; x=1791803490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0E1H3YRUGu5NQw+dGCGvtMy789cF+yQ8PDHb0PAjkg=;
        b=nqNiFLszhEpBH3vZB4kfzWW6+ZucRa/NTQ6VnjYEhSgQv+ss2VT3U2lqpI1C/DlrO3
         XbIdJenZ73N0CjuLD3JHGY+2jUftdU21qCKe94OqGFMlmCDIxazJ6gt1eBdpf3gGmHZJ
         DySKN4ioZRz7GMRQSJEbEw9Y0eEyFIJhglDJOQNfA/kC3yhPByg9W0KQt7/q3ow0wJPk
         fL0U7AdJOb08xbE9slIIo11FpqrCGm3Ajq4CToe/ub4JF1L3O7aGJlFPieu4sP6QYDIg
         zbqWqPwAi8IMGv/Dmeg2p2EUkFBQxU5KAqX/3NUJbe0gVdDKwlVyCdifaoMsBkKCx5Wl
         rFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791198690; x=1791803490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N0E1H3YRUGu5NQw+dGCGvtMy789cF+yQ8PDHb0PAjkg=;
        b=qHVauM5zPwEiE2EDPbX1ynlONbMA3QNXy8J8u3SgAwms/1bdECytoiVL3MiF35yYOt
         Ik3f6iaIZDck9iODxAwKWVZ01Fh1tq8O9422FeN1XDLfQ8ga4lDEwVzGTklJPt2L8XYc
         XGYHZdVNU9PG19FbiatB9kxoHz1m5Xcfu5RxdFueQ9cesDx428xHkQ0YCqZuqYmZMrH5
         LRxNKDphQO3LceFMVbY/yhFEkbJW1cPYSLD8H57lEa3RIjwbylbZt2jfkWwPr+zS6B/f
         Ds8viM3YHe71kDJLUnvYLEgZSCU8wNcc7eMh0Eeqp4XEOqlJ4/TL82igqUKC43Tybzie
         6/Fw==
X-Gm-Message-State: AFq9FYK9Q4Hdnmy/zXqqK7kZKh3Q9JIU8vIQhlbKMUFe5KdLREcHIxQf
	S0FnHsQuvjhHbHOPvfiA5OXK8V4BIjzV/0lv0EmoaiWIOAJFREvhnPmOB8TzgA==
X-Gm-Gg: AYBFou1Vk2AcVJ2Lt9QAJu5jeXnqqotrMFmpcsbjilhMBIrPFdOnr8SdFm/CSu7nbpT
	9Jdzmx6SuBpX67AeV7P2BljHdXvGr9OW5QXnKykyWS1tQ3EUtZerx7ccSy9U4eoNHpxZsjE7s8e
	ufnfFdA0Ps8pUMKiIrLLqjtxYans8BK+kX7qYe0vWoHKHiNfDqbYX9waR/J++Us0k0sawE6jQ58
	FA8/r1DubvrKGGZwE15jLHAybGF2Ye7AG1xbH06q/QC8ShrInR1NcSKJuESpwArwFVOmU3gK19J
	OddLaK9VQzrIQYXdobjjjvCs4RVOhlVFvY48LE/I01IjaB4gW4EAOhW5B9NHHa+P36pQoohZJwB
	hAPH13UVMKAAJpJYIU0ykpXQrTuRX06rcnbY+NN8Q14OV2Pe3LhzuHher4ljo7DbfZrHu1Y7F6Y
	P4jYMW2igfMr9ZPwk3TpwExcdzHRV/Hq36bXVNICdalvhWevPSSY47dUMSTKFyFFKw/7j+kjQoR
	86JRw0=
X-Received: by 2002:a05:7301:706:b0:34c:7e54:65e6 with SMTP id 5a478bee46e88-351111bf177mr8634653eec.5.1791198689491;
        Mon, 05 Oct 2026 04:11:29 -0700 (PDT)
Received: from JMD.localdomain ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127021d1esm14169686eec.4.2026.10.05.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:11:29 -0700 (PDT)
From: Atul Akella <atul.akella@gmail.com>
To: atul.akella@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] remoteproc: mtk_scp: Fix bounds check in mt8192_scp_da_to_va()
Date: Mon,  5 Oct 2026 11:10:55 +0000
Message-ID: <bc3f565d08f6948aed9172c01c7c38b4cafa2ec1.1791198233.git.atul.akella@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791198233.git.atul.akella@gmail.com>
References: <cover.1791198233.git.atul.akella@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt8192_scp_da_to_va() translates a device address to a pointer into
SCP SRAM, L1TCM or DRAM. Its bounds checks have two problems:

- (da + len) is computed in u64 and wraps for a large da or len.
  With da = 0xfffffffffffffff0 and len = 0x20, the sum is 0x10 and
  passes "<= base + size" while da >= base also holds.

- offset is an int but is assigned from a u64 difference, so it is
  truncated before being added to the region's base pointer.

da and len come from the firmware's ELF program headers
(p_paddr/p_memsz) via rproc_da_to_va(), and the returned pointer is
then written to by the ELF loader, so a malformed firmware image can
make the loader write outside the intended region.

Use a u64 offset and compare len against the remaining region size
instead of adding it to da. Apply this to the SRAM, L1TCM and DRAM
regions.

Fixes: ca23ecfdbd44 ("remoteproc/mediatek: support L1TCM")
Cc: stable@vger.kernel.org
Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/mtk_scp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d18ae676260a..b1d83265fc26 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -775,30 +775,30 @@ static void *mt8183_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 
 static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 {
-	int offset;
+	u64 offset;
 	const struct mtk_scp_sizes_data *scp_sizes;
 
 	scp_sizes = scp->data->scp_sizes;
-	if (da >= scp->sram_phys &&
-	    (da + len) <= scp->sram_phys + scp->sram_size) {
+	if (da >= scp->sram_phys) {
 		offset = da - scp->sram_phys;
-		return (void __force *)scp->sram_base + offset;
+		if (offset <= scp->sram_size && len <= scp->sram_size - offset)
+			return (void __force *)scp->sram_base + offset;
 	}
 
 	/* optional memory region */
-	if (scp->cluster->l1tcm_size &&
-	    da >= scp->cluster->l1tcm_phys &&
-	    (da + len) <= scp->cluster->l1tcm_phys + scp->cluster->l1tcm_size) {
+	if (scp->cluster->l1tcm_size && da >= scp->cluster->l1tcm_phys) {
 		offset = da - scp->cluster->l1tcm_phys;
-		return (void __force *)scp->cluster->l1tcm_base + offset;
+		if (offset <= scp->cluster->l1tcm_size &&
+		    len <= scp->cluster->l1tcm_size - offset)
+			return (void __force *)scp->cluster->l1tcm_base + offset;
 	}
 
 	/* optional memory region */
-	if (scp_sizes->max_dram_size &&
-	    da >= scp->dma_addr &&
-	    (da + len) <= scp->dma_addr + scp_sizes->max_dram_size) {
+	if (scp_sizes->max_dram_size && da >= scp->dma_addr) {
 		offset = da - scp->dma_addr;
-		return scp->cpu_addr + offset;
+		if (offset <= scp_sizes->max_dram_size &&
+		    len <= scp_sizes->max_dram_size - offset)
+			return scp->cpu_addr + offset;
 	}
 
 	return NULL;
-- 
2.43.0

