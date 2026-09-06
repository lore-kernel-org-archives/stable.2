Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB32E1EE0;
	Sun,  6 Sep 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701912; cv=none; b=HVWN2phU1Dp5Et2AIpbA5vqiu0NA6A7tqUL5R6ZeXpcG/KbSt23l6gWNH+SK+tvlcNKr7jK8H7VjCMl4lKu8m0Sk7zlmrhTdRYk7Qx1jhV/yRahsrjwuR0YKlIlI75CAWUuZ1pxKVi6LHtjusqD6OPpcehFI8GFNGN51slFs16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701912; c=relaxed/simple;
	bh=Rzpsh38LSRT9PgClakhpTVYyd98c/GlpWFM3afWN8ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KApFL5PRfBLV5nt30Lb4GamAqnpMkATPabNge7RP2t6a4b/CPWINRZ18KtSUFeT0VxOT3Pk3Uc2poc7CalQyRkN7GH9EhhKipxwwBEtVgfcBFOmjDRMrpMAEvnD8oXWfZV/odSI44UG1kkZsMl16aXeTsevnI2u9ITgsCLKP5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D7WLmSTp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D7WLmSTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4w
	H2Hl6u4i2ZJUFiprb5sPHmqLHW9cEhxm4g3fOPW5Y=; b=D7WLmSTp80ueoSt5Jm
	2coHQ3w/50geMEGOu+XzElrCX4TxPf5EDatK6hWGEsRjIEK2xwWQqLvJYTWESMRp
	an+06PaUyybq08gGJZ3y0DDxRIwQnVG78veERPORgdNsOn/Jst2d/h2xCVWMpoJ3
	HNM2rqPxZr2GlEDV9TC1VATdE=
Received: from XLL-9950X.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3xv2UbJ1q9P8GRQ--.42576S2;
	Sun, 06 Sep 2026 21:37:26 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: yosry@kernel.org
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	stable@vger.kernel.org,
	xialonglong2025@163.com,
	xialonglong@kylinos.cn
Subject: [PATCH v2 1/1] mm/zswap: enable zswap_ever_enabled in zswap_pool_create()
Date: Sun,  6 Sep 2026 21:36:01 +0800
Message-ID: <20260906133601.3563324-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAO9r8zPC4v_S80Gn5M7iiAujebP9QHdRur9fL1ECh8ZDxOov7Q@mail.gmail.com>
References: <CAO9r8zPC4v_S80Gn5M7iiAujebP9QHdRur9fL1ECh8ZDxOov7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3xv2UbJ1q9P8GRQ--.42576S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4rXFy5uF47JrWkuryUKFg_yoW8KrWkpr
	W8Was3Kr48Xr1xG3yUAF40kFy5t397Gr43KryUGw48Z3Z8Cr1FyFWxKr98ta1qvayvkayY
	vFs7ArnrJr1Yk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUhL8UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3BdCO2qdbJepfQAA3q

From: Longlong Xia <xialonglong@kylinos.cn>

If zswap is enabled by default at boot and pool creation fails, then a
pool is later created by updating the compressor, data written to
zswap is corrupted on swapin.

Enable the static key in zswap_pool_create(), covering boot-time and
runtime pool creation with a single site.

Verified with fault injection on a stock kernel (compressor builtin,
CONFIG_ZSWAP_DEFAULT_ON=n):

  1. Boot with zswap.enabled=1; pool creation fails, init completes
     pool-less (static key off).
  2. Echo an available compressor name to zswap.compressor.
  3. Enable zswap.
  4. madvise(MADV_PAGEOUT) a pattern-verified 512 MiB region, then
     fault it back in and verify.

Step 4 reads back 131072/131072 zeroed pages (zswpin=0, zswpout=131072)
without this patch; all pages intact (zswpin=131072) with it.

Fixes: 2d4d2b1cfb85 ("mm: zswap: add zswap_never_enabled()")
Suggested-by: Yosry Ahmed <yosry@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Zcode:GLM-5.3
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
Changes in v2:
- Enable the static key in zswap_pool_create() instead of adding a
  second site next to the compressor parameter update, as suggested
  by Yosry; boot-time and runtime pool creation are now covered by a
  single site, and the zswap_setup() site is gone.
- Use the high-level description from Yosry's reply to Andrew for the
  corruption scenario, and rename the subject accordingly.

Link: https://lore.kernel.org/r/20260905125101.2970456-1-xialonglong2025@163.com

 mm/zswap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37f34e406c8e3..6dfb6ae709e97 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -324,6 +324,9 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 
 	zswap_pool_debug("created", pool);
 
+	/* Enable the key here so every pool creation path is covered. */
+	static_branch_enable(&zswap_ever_enabled);
+
 	return pool;
 
 ref_fail:
@@ -1805,7 +1808,6 @@ static int zswap_setup(void)
 		pr_info("loaded using pool %s\n", pool->tfm_name);
 		list_add(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
-		static_branch_enable(&zswap_ever_enabled);
 	} else {
 		pr_err("pool creation failed\n");
 		zswap_enabled = false;
-- 
2.43.0

