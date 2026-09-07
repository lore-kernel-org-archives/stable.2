Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8504854FE;
	Mon,  7 Sep 2026 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786582; cv=none; b=P4VwVE+ynGh9s9O7p/apghHkd5ckb+WAHI3i7Lod6LjGu9HlSc0njHic+g5Djg2bmUmIAR7EHU7S7S1rb9ERjrqDH3Z2OOKGpsH6NpkE5pJIEPzBdRGlJzTKCEtHsjneZ9OJTO9yKm90Rw/ONxq6221mGAZK5O9zzSjQw6IzLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786582; c=relaxed/simple;
	bh=/3SH0WO8o7Y3yVbm8wMlCNCv4EcMwq2TBhXGPRX+060=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itvJRKY6jUwYlN/lfydxF0cFPBKFmF/dL2U1d5fXtEIVE9dsP8+ff5T+MIr9jTaThM+QyaM44SM7COGkmJN/djjh4xn/Net+Wm1QR7zhlTL90+xzDQ8oyGJZNmptGECP8DEBGXqpd18Q0oBcL7YEZMy0LWWjLhaC1xTJDkul5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mWE4FaVh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mWE4FaVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9a
	IgFDMgD3gep474UQZVVvhqGHf5S2g87xXTFr6YcCs=; b=mWE4FaVhya/+AfIoIg
	8AjO1f5kmpedNSnEw2E+YBPTLVmjEP+a+8x3OJM1pkRvAyPUxKk2XlrKKYORLoRZ
	14GWXiGkc8n+nqSlePJvnZ+XaSYAoqXin4OOny8BCpzDvqaBc1yyVNglBjf8F89+
	2qtzh336QXn4h+/4TnxPjfO90=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD310Zdt55qUKzsBA--.63999S2;
	Mon, 07 Sep 2026 21:08:46 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: hannes@cmpxchg.org,
	yosry@kernel.org,
	nphamcs@gmail.com
Cc: chengming.zhou@linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] mm/zswap: publish the initial pool with list_add_rcu()
Date: Mon,  7 Sep 2026 21:08:21 +0800
Message-ID: <20260907130821.1726595-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD310Zdt55qUKzsBA--.63999S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFykuFWUCFy7JFWDtryfCrg_yoW8WrykpF
	WSgr9xKFWUXrn7trW7Ja48urn8J34UtF4rKr1UWF4xZwn5Ar1ay34xtr95tasav3ykC3y7
	WrW8A347Jr1Ykr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbNVgUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC9x9HQGqet1-L0wAA3r

From: Longlong Xia <xialonglong@kylinos.cn>

zswap_setup() publishes the pool on the zswap_pools list with a
plain list_add(), but the list is walked by concurrent RCU readers
holding nothing but rcu_read_lock() through zswap_total_pages(), e.g.
/proc/meminfo and the shrinker count path.

    CPU 0 (writer)                          CPU 1 (reader)
    --------------                          --------------
    zswap_pool_create():
      pool->zs_pool = zs_create_pool(); (1)
    list_add() -> __list_add():
      WRITE_ONCE(zswap_pools.next,
          &pool->list);                (2)   zswap_total_pages():
                                                pool = READ_ONCE(     (a)
                                                    zswap_pools.next);
                                                zs_get_total_pages(   (b)
                                                    pool->zs_pool);

If (2) becomes visible to CPU 1 before (1), CPU 1 finds the pool at
(a) but dereferences a wild pointer at (b). Publish the node with
list_add_rcu().

Fixes: 91cdcd8d624bf ("mm: zswap: optimize zswap pool size tracking")
Cc: stable@vger.kernel.org
Assisted-by: Zcode:GLM-5.3
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
Link: https://sashiko.dev/#/patchset/20260906133601.3563324-1-xialonglong2025%40163.com

 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37f34e406c8e..cb5a0855fd2a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1803,7 +1803,7 @@ static int zswap_setup(void)
 	pool = __zswap_pool_create_fallback();
 	if (pool) {
 		pr_info("loaded using pool %s\n", pool->tfm_name);
-		list_add(&pool->list, &zswap_pools);
+		list_add_rcu(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
 		static_branch_enable(&zswap_ever_enabled);
 	} else {
-- 
2.43.0

