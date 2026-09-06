Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8D2F28EA;
	Sun,  6 Sep 2026 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703356; cv=none; b=Oqxz0PgEShpWOgi1kwz8vdHpWEIRPVKwPMgDO+ObYEoV90SvHaCRJgRcMKqJEbcPM7zd9d3BIF9XjAFC4DrqXQe45zw0v0eOun64CkgudR4CThOfX7iiVOqlTiSqFGQJfLYA3uXzpDf7w8ff0JZHLndT6GISYgM91mqy/7zHM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703356; c=relaxed/simple;
	bh=5eQPIWfRylSIGQ0vy+Rt0lqHyveHI+MoR9IZvZrp57w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgxBpPJlXy6K58HHCZJRef4GgUPnaDk92cuhr7b58RdyC75AjGFEUGWxntM8UBdbCRmBO3/Ylq+Ow3BTtFSP0sLrK+gm+5Dh2gJEwzr43RSpQ+X6rF2p7EvRon0HngCmLzQY3yH7YBvRkXTs49qr6s40IUuXXGBzKJxhxvKmS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SHutc/6z; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SHutc/6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=su
	uN1kWSuEppLRDqgEECSEVpoIC/3+Amdt3xt38Doxk=; b=SHutc/6zXLc1cVD5Vl
	CLdT7CGEoOSXrsMCrvo70k2VDA9aBZw5Wf3pvzZR+ObbzwrR9AnYAthncIym5Pql
	Eji+jAGCVSTTN70bNLrpsqjThiEPqbBEEfUurHPSg6E47DOQoNGufjJquqEht6NX
	A/XNNELwwi60pqnZIUecw3lQM=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA3DJJAcp1qKIkSBA--.45087S2;
	Sun, 06 Sep 2026 22:01:38 +0800 (CST)
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
Subject: [PATCH v3 1/1] mm/zswap: enable zswap_ever_enabled in zswap_pool_create()
Date: Sun,  6 Sep 2026 21:59:38 +0800
Message-ID: <20260906135938.3568108-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAO9r8zNPckJzpC2ecOew1B=MNbFSMsUpmHgVu=_D_+osFFVFSQ@mail.gmail.com>
References: <CAO9r8zNPckJzpC2ecOew1B=MNbFSMsUpmHgVu=_D_+osFFVFSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3DJJAcp1qKIkSBA--.45087S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4rXFy5uF47JrWkuryUKFg_yoW8KFWkpF
	W8WF93Kr18Xr1xG3y8AF4IkFy5K39rJr47KryUGw48Z3Z8Cr1FvF1xKr98ta1qvayvk390
	vFs7ArnrJr15K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREoGPUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3AOup2qdckP3RAAA3j

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
Acked-by: Yosry Ahmed <yosry@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Zcode:GLM-5.3
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
Changes in v3:
- Drop the code comment per Yosry, and add his Acked-by.

Changes in v2:
- Enable the static key in zswap_pool_create() instead of adding a
  second site next to the compressor parameter update, as suggested
  by Yosry; boot-time and runtime pool creation are now covered by a
  single site, and the zswap_setup() site is gone.
- Use the high-level description from Yosry's reply to Andrew for the
  corruption scenario, and rename the subject accordingly.

Link: https://lore.kernel.org/r/20260905125101.2970456-1-xialonglong2025@163.com

 mm/zswap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37f34e406c8e3..3abcd8433425b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -324,6 +324,8 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 
 	zswap_pool_debug("created", pool);
 
+	static_branch_enable(&zswap_ever_enabled);
+
 	return pool;
 
 ref_fail:
@@ -1805,7 +1807,6 @@ static int zswap_setup(void)
 		pr_info("loaded using pool %s\n", pool->tfm_name);
 		list_add(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
-		static_branch_enable(&zswap_ever_enabled);
 	} else {
 		pr_err("pool creation failed\n");
 		zswap_enabled = false;
-- 
2.43.0

