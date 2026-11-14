Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674833;
	b=IEQKBZ+D39yt387DNWDL9e8CwhTs1+Onxk690/i8ypdNXB8P+gHEC66oyoARhw9GTer4
	 5RAB25UIcmspLGoSkrYDsoU+DlCPdfsnPVr+0a2HAaH+7uJI+ew3ESWMgkPdKLKjFVeWi
	 ZB8IDe4HvSXI7bj1cU34RIzgGriFRM9BcfeLCIdW5aHhf70cigtozDR/ovP7kvOpryQT3
	 axEN1XxSFYEDmnUJUwfrOwEIiuYphih7IYntwNUT8Gg9GE28LUZJ+q3CmwIxbiy6UhmRW
	 pbNGyKXBgEiCnMEuVdObDQChh+AbIU8hIOU/rtibI/Gxd9JY1Ksxn1/Vja9R7xchfDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674833;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=3hUxEq/IvGMPH4orR2xxUUl7Ver4vX91WAzWKMjwqzw=;
	b=e9q82GvSx7gr1owHjTsKfvIbAmyZVIP2MymhHNASFCChnVKErgUcudiqnytH2k6yY2DP
	 DeNhjXzyHLLDP3ZSltwLsO46E0yaZgpjG3C62tbsGMDHoH8mtADKXGh5y7TiDbM+KGwby
	 Dtr2iAnNvcItmyEcyeKcR0NdAm3lObGQc5lm8fLClPNXvw43jpB/b7uk+m7EeL3fghxu+
	 rNNh/oH2NXLrWSC+xRz8AaYio2hxzBKj5ww136xU85s4EZQWZzdZR477LtwV9RQBXPNgH
	 yzEb9zXqeH3Bf9otKUFYJYTFEiPUDE0Pjfu2D+9RnhjmgnC9fb6EqnJbO3nFgGh9Kvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=d5WctLGt;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E00606A8A5;
	Sat, 14 Nov 2026 16:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E00606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=d5WctLGt
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRg5W5ZLNz8Xrrc;
	Sun, 15 Nov 2026 00:47:11 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674831;
	bh=82Oq4yUJw3E3mVI/PSeEhm5HUr49865y/wRCd0KxSDI=;
	h=Date:From:To:Cc:Subject;
	b=d5WctLGt3lfVyY2zfccMFvPVnqtmqo4kItpOGdIogRfz9VkueqVgET673ZqNuUin4
	 3O/dJyi2/9jmPzW2KBg6C5PJA5Boaz3HRT2reYfhw025graaUrTCEb+qrUjFMJyowm
	 V/yTGU4Y8OGL9jDDdzlGwG3R3lviCgH/gEFy9bpxn6nZdsakCJ14dA06XZkuRWSo6z
	 QkeVDZkY4H2Gcq2qiqiRxtX2Pm5jYw0JvV/9u6gN/2RcSrSRn2ytlMHob/h9QPNRhv
	 K8yGOGZsYwgHkyjvOMwGRxQywepDsBZ2a7whX74Vmmla29AEtI1ccHYVrBvBSNDXX/
	 p8p3vohkDXozw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AEGl28e094567;
	Sun, 15 Nov 2026 00:47:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:47:04 +0800 (CST)
X-Zmail-TransId: 2afa6af89088e94-30e64
X-Mailer: Zmail v1.0
Message-ID: <20261115004704544fuMEkcx0F4A1sNBAzz46-@zte.com.cn>
Date: Sun, 15 Nov 2026 00:47:04 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <akpm@linux-foundation.org>, <rppt@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbS9leGVjbWVtOiBjaGVjayBleGVjbWVtX3Jlc3RvcmVfcm94KCkgZmFpbHVyZSBpbiBleGVjbWVtX2NhY2hlX2ZyZWUoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEGl28e094567
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 00:47:11 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF8908F.001/4jRg5W5ZLNz8Xrrc

From: Shao Mingyin <shao.mingyin@zte.com.cn>

mm/execmem: check execmem_restore_rox() failure in execmem_cache_free()

__execmem_cache_free() checks execmem_force_rw(), but ignores the
matching execmem_restore_rox() result before adding the block to the
free ROX cache. A failed restore can leave permissions only partially
updated, so a later cache allocation can return memory that is not ROX.
The cache allocation path does not reapply permissions.

Check the restore result and return the error. The existing callers keep
failed frees pending and retry them through delayed work. This prevents
a block whose ROX restoration failed from entering the free cache, and
matches the error handling in execmem_vmalloc_rox().

Fixes: 187fd8521dd8 ("execmem: rework execmem_cache_free()")
Cc: stable@vger.kernel.org # 6.17
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Build-tested mm/execmem.o with W=1 and CONFIG_ARCH_HAS_EXECMEM_ROX=y
on x86_64. The pending-free error path was reviewed statically.
No natural CPA restore failure or BPF execution fault was reproduced.


 mm/execmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 349cadd874863a8b82052470e3b0e7b0df2e0ba7..4a48e9f445a02f783ca4dd501559cded54892dd8 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -351,7 +351,9 @@ static int __execmem_cache_free(struct ma_state *mas, void *ptr, gfp_t gfp_mask)
 		return err;
 
 	execmem_fill_trapping_insns(ptr, size);
-	execmem_restore_rox(ptr, size);
+	err = execmem_restore_rox(ptr, size);
+	if (err)
+		return err;
 
 	err = execmem_cache_add_locked(ptr, size, gfp_mask);
 	if (err)

base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
-- 
2.43.0
