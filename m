Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F142CCB9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747473; cv=none; b=IY/2t6L9aBvDWY2BK/e2o8xy+PbPD0T6Wmc3GtCej0CSjVRqeGgUZXZdVzRAt67w16WMMn47K3nKp4B4VJ7urvRBvTQUFAN1poxJjEG5ID96feok0Wff+dLvhzKSc1u+upeLC/BwCrlsdEfXWsnljvzAl42qBT+vs/3fzzYK8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747473; c=relaxed/simple;
	bh=UiNWRWj0MlbJBiXlMv2DY/o5uGGkTXw/06m1OlowJ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi9Y+kYW3pErsp8IT1qZIJL25C6CnnotEfO4QnTY9OzJBdfwbhZZpgj6KFkb6/5s58tZeoqOOGjM3k7kaY1Yt0igN9XFb4ml89zm+vrF965r38KI0IfwUiHLsN9ppwe8hC7xO2LrXniaRdxfIk9k7O0VHk1S0wEoYLKoXWAFM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQgpFoSr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQgpFoSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349601F00A3A;
	Mon,  7 Sep 2026 02:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747471;
	bh=i/RE6uYqUDzxiv3Hg/QL8WthodSgsLDyAzpLZNXLsIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQgpFoSrqrHWLYfiWX6s7fofFFlTU/VYW/bQdQY9cnZGP1GeQ++0yuIJZwVfsa+8i
	 iLcFMoXZO6xe8O9NlKyB7lwWviXTO26hVyxIaSzTiiP+sKnHHdYr82wukO/ur4CBPH
	 KsszH6wN3ycuYC2uPcWG2qHzIKSl+2l2H31segC2mlXWmTogU6+oT0neZJyl9iC8ES
	 aRdYjsmUL1pw6SfjAfxucVrYvzW2xcSj9sqPbgYxuRUDAipesJrzBfKl6fLLaS9xOU
	 npdtPUW+mk+Cux5KuKPxuNq3JM6tFsHh6vMMD3VBLMa8luwpLKhxZKc51hCyJ6730/
	 hU+xKM5vFKqZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: clear ce->tgthint in free_tgts()
Date: Sun,  6 Sep 2026 22:17:48 -0400
Message-ID: <20260907021748.2691877-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090317-frostily-collide-4c2d@gregkh>
References: <2026090317-frostily-collide-4c2d@gregkh>
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
index c78accc623ec9..bda123ba5d5fb 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -234,6 +234,8 @@ static inline void free_tgts(struct cache_entry *ce)
 		kfree(t->name);
 		kfree(t);
 	}
+
+	WRITE_ONCE(ce->tgthint, NULL);
 }
 
 static inline void flush_cache_ent(struct cache_entry *ce)
-- 
2.53.0

