Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371513;
	b=JoUSK6ffMZG0tj65JHprOl/8CsDCnK+pJirs9f+Bq9XYiq12igwewph0tQwInd03HHt5
	 EdbpBdux5v03uQhSUB031L/tXa10JLx9vMMSiuXY+gvQL3uU50XybaUpwXJe0gOkL76v4
	 H+70mNmlFD+ncaXBnCuAQ06b6pOQBnbAsEaF3/HHDzELk09U8z5tN6wqKkZZb0nRVHMcH
	 Y85qGJI4kSU9nCxLbropvl7FGv8hvyNm2wTc0NheuF0sUsbv2v6QrEeDMRJP5rzHdS/Ce
	 dop0ANohlUGitntqjgL9dmxwxKgyEbfJc/9MEzbhi1klRQUNSqiHsgDPgk+a2GmDvKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kRLdXppTyfsJ39jsYrSiFf9ByVM7QLVXohJCzVy5zAA=;
	b=x1SwQA84hYGRCXKof3OW9nMEPyjAGrGfbHdRuP3khYLo3FO8lLIHyg3DAm/VFySewgXL
	 61O/2rku7skSymIf2Nra1G8z0nCp3wlMVyCVIfxNzuEf5WxupsJyFeongOBECf32bxtnl
	 Z4OExupzXIyMvSTRutvBNvk1XvsrnEgetpiMoXVu6m8s4ytO4Tl6nXmQNAb/XIswkd1eL
	 fnCS1+eUJQk2FA9AEk1ULtcIsaBAyYo6ykoWp9fUU0Tq/gq9fOEpJr7jj7ix3BaRVv1Wm
	 pgZrhNAH0V7G2619gZlkxFTliWz31N3dtG1dRQgI+IXLAZs0UCAAgl0xQE+i0Ewlxkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GQ/oSz1o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8C606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQ/oSz1o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551F11F00A00;
	Wed, 11 Nov 2026 04:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371513;
	bh=kRLdXppTyfsJ39jsYrSiFf9ByVM7QLVXohJCzVy5zAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQ/oSz1oSGxbGjNURQX4RVPzuNdpH8dl7j775yzhNQaRSREdBchzkpl8UM9kq9rr6
	 KmIvwz967Rsm88hn9MgJdKjWMSplLKLl8hUx8O/YnojmYonzgS7+Y5mW7SBK0HUiue
	 De0DJwNDL3+IyDkLUYlMrPTiuF1Li8EQXHN8UwIh18ov/wXVmZDescfDD2L6+XZkNx
	 BcAYC+ovgKZQ88kDXleIOGrLYElQq1PwdxHAa8Y7JH4MXzjTYB3OZpBRQbrQfdk0gc
	 jHWqB5q5bFEo0F0vjSN/ygUfTufUpoZaPt4IpVOdlUVFkw+sxISuqPN0b+6paawFyY
	 RH56LKK5cWKWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/zswap: publish the initial pool with list_add_rcu()
Date: Tue, 10 Nov 2026 23:31:51 -0500
Message-ID: <20261111042849.1098670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052026-failed-6.12-c1dd5e24a82d@kernel.org>
References: <20261107052026-failed-6.12-c1dd5e24a82d@kernel.org>
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

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit c1dd5e24a82d19bff8eef50ba8205d4776584aff ]

zswap_setup() publishes the pool on the zswap_pools list with a plain
list_add(), but the list is walked by concurrent RCU readers holding
nothing but rcu_read_lock() through zswap_total_pages(), e.g.
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

If (2) becomes visible to CPU 1 before (1), CPU 1 finds the pool at (a)
but dereferences a wild pointer at (b).  Publish the node with
list_add_rcu().

Link: https://lore.kernel.org/20260908012801.1864430-1-xialonglong2025@163.com
Fixes: 91cdcd8d624b ("mm: zswap: optimize zswap pool size tracking")
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260906133601.3563324-1-xialonglong2025%40163.com
Acked-by: Yosry Ahmed <yosry@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Assisted-by: Zcode:GLM-5.3
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
[ sashal: Adjusted context to preserve existing logging of both the compressor and the zpool backend. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6c50249d5398f..61311c92bd6f6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1778,7 +1778,7 @@ static int zswap_setup(void)
 	if (pool) {
 		pr_info("loaded using pool %s/%s\n", pool->tfm_name,
 			zpool_get_type(pool->zpool));
-		list_add(&pool->list, &zswap_pools);
+		list_add_rcu(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
 	} else {
 		pr_err("pool creation failed\n");
-- 
2.53.0

