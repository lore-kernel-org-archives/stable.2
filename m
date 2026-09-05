Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC74A013E;
	Sat,  5 Sep 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612728; cv=none; b=VVm3TquuztpgeOxUEe5S+ySnGj1eJFvLyiFHT5hygDqzUH0S4/BNvGGMFFYK0zJcAu6+8pshQQVvQqVlvyVEAg7sYjrK0HgY6FjbJEEgB0ZF1rki9/vt5Ym5ELC+QRNjCcGyiWRkxRvHy5lLS4tG1KbNbplms1IvDp3BS/bOVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612728; c=relaxed/simple;
	bh=n0R2aJzqLcBbmTYizFvG2tOIH1Xcds1HOiks3LLGmDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqfN9nzhDdWoqDxe87RYulBfSEmOdQcCwKJMKXRXSUoViav+q/2lgVjbyL+U/+UpFdfmd+Vy1j1oLxZUTEPaxj6iVH2FV++jMPCgoyZSAo0toSXjUBT1aMbNvij74kO4l1TPCyZ5fZuhzXQ3WM4QwkDlXEAcD3sEnCk6kQoKAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cg9UTZdQ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cg9UTZdQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=k2
	Jon0zzAG3GmxIwfb1s6njp3H0RiBpGPLuVr+GERyo=; b=Cg9UTZdQQuAC6W8SSm
	aL1wFXACcpWS++QiyLDXQeChhGYDedLPh+0GdMV9R3WQBg+x4zvZmm3ZiWkGgpbx
	oS2iEABiWppIUKS4E4e51oIXPYtCMdwVebLK8UiHdQOt2lS3C4Xv7nIuFJQHynbI
	pIeBAKx/gOms2J6yuH/pxEknE=
Received: from XLL-9950X.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3mfg2EJxqFP0ROw--.17076S2;
	Sat, 05 Sep 2026 20:51:04 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: hannes@cmpxchg.org,
	yosry@kernel.org,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] mm/zswap: enable static key after runtime pool recovery
Date: Sat,  5 Sep 2026 20:50:28 +0800
Message-ID: <20260905125101.2970456-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3mfg2EJxqFP0ROw--.17076S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyrAw45Cr1rXw4fCrWDCFg_yoW8Cry8pr
	y0gasagr1UXF1Syw47AF48ZFyYkay3Kr4rKF1UKw4xZwn8Ar9YyFWIyFy5tayYvrZYya9x
	ZFsrA34UJr1YkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1PfQUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC+BjTzGqcEDg-rQAA3z

From: Longlong Xia <xialonglong@kylinos.cn>

When CONFIG_ZSWAP_DEFAULT_ON is disabled, zswap_setup() can complete
without a pool after a failed initial pool creation. A later compressor
parameter update can create and publish a pool, but does not enable
zswap_ever_enabled.

If users then enable zswap, zswap_store() intercepts swapout while
zswap_load() still returns -ENOENT without consulting the xarray. The
swapin path therefore reads a stale backing swap slot because the store
skipped writing it.

Enable the static key after a successful compressor and pool update. Do
this outside zswap_pools_lock because static key updates may sleep.

Verified with fault injection on a stock kernel (compressor builtin,
CONFIG_ZSWAP_DEFAULT_ON=n):

  1. Boot with zswap.enabled=1; pool creation fails, init completes
     pool-less (static key off).
  2. Echo an available compressor name to zswap.compressor; a pool is
     recovered but the key stays off.
  3. Enable zswap.
  4. madvise(MADV_PAGEOUT) a pattern-verified 512 MiB region, then
     fault it back in and verify.

Step 4 reads back 131072/131072 zeroed pages (zswpin=0, zswpout=131072)
without this patch; all pages intact (zswpin=131072) with it.

Fixes: 2d4d2b1cfb85 ("mm: zswap: add zswap_never_enabled()")
Cc: stable@vger.kernel.org
Assisted-by: Zcode:GLM-5.3
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 mm/zswap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37f34e406c8e3..c48c4df63f188 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -586,6 +586,9 @@ static int zswap_compressor_param_set(const char *val, const struct kernel_param
 	else
 		ret = -EINVAL;
 
+	if (!ret)
+		static_branch_enable(&zswap_ever_enabled);
+
 	spin_lock_bh(&zswap_pools_lock);
 
 	if (!ret) {
-- 
2.43.0

