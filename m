Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046829;
	b=Hj04Y+yAmd8iWhdI+bh0NhvziT0NP1OWK4dtHjGk50RKEtjElII2nCiqrC4084uI15Et
	 ZAXhxJNnQSqhue2NRgKGgrxohnPESxdGfmwGBacm/IUFr3bOjoRqPMlTMolKPVE8Rq+kF
	 ON/0ie1YomIsdZffxnCbN9cQQAkg9UGXEEfemhM6TylQCNi5nwWJkcTiZ/AQP4PvWm/Pt
	 oX0T38DajYfCYGtl7ufubCklCvbWhwx5mUR53Hl0IhnwNR3Jmj/Q8KKCbP4xu49HcBkCF
	 h7LLteBO9XzKMdpiQBkEr+N8dgRaDwe43R1vAtWauKGjb2ABFtX+vz1zV0gx13GzzPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2a7dc86GCpB/nJVmUq+uUgWyp1HsVQJ/EqGTdLOW1IQ=;
	b=SojAt+5pbDmgDz49l/YhzVdaYJV7NoScQSQ4c7oWb4FWgZqUbFc/Dx37fDleZoYxHLzC
	 4OkScpP7X3AdL8zGoPolf1sM2ju8n+f1mxoGrMzycrgZ/SeVatU/wD2hTRt9eBW9opnrJ
	 jYsKdxoQGAJGDoTt3oqqzHdHKlfnsvvywsVUudmh6sPl8H5O1iDV+pog58Lqzx1c+2N8L
	 qedDRr1SVM9aZ/guA+7UYheGrRtwhsJW8vwWnRJjZO/vKCciZl487UNMkBRgCJfsBCRsu
	 Uug0zomIXkACscm9sdE1tt1CvN3eK9+C7VrfRSlZPsjJ5XfWg9ZlTifp0Nk2N9xv0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOIP2IgJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5B606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOIP2IgJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4971F0089F;
	Sat,  7 Nov 2026 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046828;
	bh=2a7dc86GCpB/nJVmUq+uUgWyp1HsVQJ/EqGTdLOW1IQ=;
	h=From:To:Cc:Subject:Date;
	b=VOIP2IgJBC57wdUcExdE81XvSdAzZ7mSgy4rDGToJXLNhjp35jXIA6BkECRbRnmxX
	 yQeKZ1gyr24xdFh5MudXgtRa/OeGIo0okQHue293rsM77u5FWQn35bSX4ftbWjN9mr
	 qjz0qgWxHqG73W1pZ+Dn8LgPyNa1ZLx5MT3zfu1udTNnZsa1BpCPl4VadMlNfO0Mao
	 4Tg5tbENfPoppaIwAFxPDqez8trNSLEbLu9lV63wCbxOFckDFDPpd8DPcIAHKCCGe6
	 1EDNdE6wgXfp2Jb4jrEVZTk+U6/GkEb86oFGFbEdSO+ItfykmFULw07sPa+2w0e3da
	 O4Mwvzyv20OWA==
From: Sasha Levin <sashal@kernel.org>
To: xialonglong@kylinos.cn,
	akpm@linux-foundation.org,
	sashiko-bot@kernel.org,
	yosry@kernel.org,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/zswap: publish the initial pool with list_add_rcu()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:26 -0500
Message-ID: <20261107052026-failed-6.12-c1dd5e24a82d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c1dd5e24a82d19bff8eef50ba8205d4776584aff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052026-failed-6.12-c1dd5e24a82d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c1dd5e24a82d19bff8eef50ba8205d4776584aff Mon Sep 17 00:00:00 2001
From: Longlong Xia <xialonglong@kylinos.cn>
Date: Tue, 8 Sep 2026 09:28:01 +0800
Subject: [PATCH] mm/zswap: publish the initial pool with list_add_rcu()

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
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b5411ab164809..2a95aedc08fcc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1815,7 +1815,7 @@ static int zswap_setup(void)
 	pool = __zswap_pool_create_fallback();
 	if (pool) {
 		pr_info("loaded using pool %s\n", pool->tfm_name);
-		list_add(&pool->list, &zswap_pools);
+		list_add_rcu(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
 		static_branch_enable(&zswap_ever_enabled);
 	} else {
-- 
2.53.0




