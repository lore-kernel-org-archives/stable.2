Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A177481674
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781641; cv=none; b=kHEUPFOtozqeHuyjfN4F95t9FMguxcTYk/Iv9NOr8QGzssb4rsXXmeWJ74y2/F5jNp+Kvf6LibX/G43gaPVrQnSlU5MPas1sEz0MWx6mCuYomumzF4JBjl1q6RCMdEsnJyV7gGUspj/DVkodNUfbUPIRa1aZLZWbj+321CMN47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781641; c=relaxed/simple;
	bh=GwqV2agzajyLvsW6Wnm8T8zP0G5DZsu81KAqDFXqJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayadm5Koc0ourhT3+RWgTkvksrdCxSxZcJ8XqubSNJh/AWhBXYq9z7qbxNiH8UnOFCRavzc6Dru+ljGWwCJak5E7jtnWX4GTC9Rrz07OpPManS1B7Y5JTQs/BhwqO9TFF2PrQ+RmcUuMrZU0IcqaJgfh78vTBiPu4j4xsq3JOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8bl18d5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8bl18d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5381F00A3A;
	Mon,  7 Sep 2026 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781640;
	bh=1hMg8NDQx8ylSQp4C6xJYADeCqCCEDx3LVhU9PuGLS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8bl18d58kEqr1RqmlyiIrCRzlqwCWAlEGKJlnL95vpZS9qL2Xn5p33qULl8DTldJ
	 8Vvmx3Od1Eg/UivJq9uyEAxg3y32GV1Mv5xHZ0PoeHj6Z9yyGgWkRRkEQsW9BdcowS
	 YlgTNvIP9Rk+FeXSTvs/XvhYK2F4gANvkCXrwHSpSaqFVDBgaHwsSidf0TQftBnVjg
	 y8nbl5aJF4BTrFlCRQ4ETEVgXYC/sBJa+QkU0/A+A3aICh8cnM3xot7B9m6NqvpKkw
	 r30UOoAKUam/q2sqhk5EvjOvq4prUV3Z9R2+z1Z3ikRHdxes98nb93rP5Gk2Lee+Iw
	 PLzPbyNGXJhTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: clear ce->tgthint in free_tgts()
Date: Mon,  7 Sep 2026 07:47:17 -0400
Message-ID: <20260907114717.2870299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-driven-showgirl-ba4f@gregkh>
References: <2026090318-driven-showgirl-ba4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fredric Cover <fredric.cover.lkernel@gmail.com>

[ Upstream commit b1b741cf8e7ce1b91d937e23decd3d3358748700 ]

When free_tgts() frees all structures in ce->tlist, ce->tgthint
is left pointing to one of the freed cache_dfs_tgt structures.

If ce->tgthint is not reset before it is used later, it results
in a use-after-free.

Set ce->tgthint to NULL in free_tgts() after the elements are
freed to reflect that no elements remain.

Fixes: 54be1f6c1c37 ("cifs: Add DFS cache routines")
Cc: stable@vger.kernel.org # depends on: smb: client: harden DFS cache against invalid target hints
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/dfs_cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 7b6db272fd0b8..115d7e276ed58 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -118,6 +118,8 @@ static inline void free_tgts(struct cache_entry *ce)
 		kfree(t->name);
 		kfree(t);
 	}
+
+	WRITE_ONCE(ce->tgthint, NULL);
 }
 
 static inline void flush_cache_ent(struct cache_entry *ce)
-- 
2.53.0

