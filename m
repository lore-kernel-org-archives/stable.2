Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8832358D00;
	Thu, 27 Aug 2026 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800634; cv=none; b=gzdPF76uKWb8VhgGO5tGMgKoSD+Cmt2U+L7X8jyAEQ+H5tRpdcbKGHfsUhMnDI726oCdKOxETWq4qZTUdbyhsqBtgK1NUuMAEHbNHaCPIA0gwvwhHW5VYFxknjgRIn1/5FuXs1ewFlpQDbQAYlTHC8cWhyj0OgpXQL9KV3FJxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800634; c=relaxed/simple;
	bh=/BqU4gqnbllGraN6xWN4gnHOwtv3qx3JJRuH7hIO2Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjxZjs5UzOMDrjjPRBKPLiVd4KDMyJUtzW/5rjRq0hqT6VWzvytWRm20ohNktD1lx5Jzkx3yENfuedhzk2FY1Pd520qa1+1TQxLL81P9BPIH+wpBXfz0d6EpwITLCkK60b9ZlyXl6APkK4zcVE9ImNfB7tKSbzPwJLzhT1QJ3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jdZO5i8u; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jdZO5i8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G/
	azvph0ekJ66d5r9jq16rVUNFSaJMnwwRSIRYMXYXw=; b=jdZO5i8uo32UZVYF5w
	kEbc+EOir/sWwQcDEyD8kdhLLPCeH6HIDTqTSAwJHXnGah/SOntI8jYJAU1TZuG+
	mVcnwEb0GhInaBU7RjNUO6zJcN7kS7QLtsoPETh1SKSGXLvjjW94HNo/5Gj2P+pm
	ffpLPTZ8AoOuShXFmJdsy1RVg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnSSUgrI9q0i_LOQ--.48736S2;
	Thu, 27 Aug 2026 11:16:49 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH 1/2] md/raid5: fix pool_size leak in resize_stripes error path
Date: Thu, 27 Aug 2026 11:16:45 +0800
Message-Id: <20260827031646.49080-1-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnSSUgrI9q0i_LOQ--.48736S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr45Ar1fCFyrAr4UJF4UCFg_yoW8Xry5pr
	W7WFWFvw1UW39xAw1UX3y8uFW5Kw1vgrWrAFW3Ga1vvFnIqr92vF4xtFW5WFWUtryfGa4f
	tFWDtrs5JryfArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joBT5UUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC+wGxRGqPrCED2AAA38

From: Cao Guanghui <caoguanghui@kylinos.cn>

In resize_stripes(), conf->disks is replaced with a new array (ndisks)
in Step 3, but pool_size is only updated at the end with
"if (!err) conf->pool_size = newsize".  If Step 4 (allocating pages for
new stripes) fails, err is set but pool_size is not updated, even though
conf->disks already has newsize entries.

When the array is later torn down, free_conf() iterates only pool_size
(= old value) entries, leaking (newsize - pool_size) extra_page
allocations.

Set pool_size immediately after replacing conf->disks, so it always
matches the actual array size regardless of subsequent failures.

Fixes: ad01c9e3752f ("[PATCH] md: Allow stripes to be expanded in preparation for expanding an array")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/raid5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2641,6 +2641,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 		} else {
 			kfree(conf->disks);
 			conf->disks = ndisks;
+			conf->pool_size = newsize;
 		}
 	} else
 		err = -ENOMEM;
@@ -2687,5 +2688,3 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 	/* critical section pass, GFP_NOIO no longer needed */
 
-	if (!err)
-		conf->pool_size = newsize;
 	mutex_unlock(&conf->cache_size_mutex);
-- 
2.34.1

