Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562452B1F5
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553956; cv=none; b=gbl68xcaTOZPMA9PE9rBBVhmb4rdFyTRCUb5lVbe/Ymh92rbULj0iSlDuEtHpw5b9k9GXW9r31DIuy+HLlaE5q7zxZrPqRQv4uuMpWex/RgBbh277b2XTon/vkWb8H4X/jnPFyVp9Ef1Mb5Y+6eM8mXXkB/smjSajM4w5zOyc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553956; c=relaxed/simple;
	bh=dA8cUd0olNDHGSZqpSFD1cPn3uPDAEEn2HAUD7D3FRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1VvLGyvZYXw0Nyr76MziAopsGor6Y/hsWFfzJTllGPXdLqdUL6qMde6s5AZ6rWSV97ckfJoFjJqOlFWq+XStZhONcIgRZnRm+RKwZ5x66VM8zgdCBwzh63wJJjAE6nBHpxGPDZHsjNYfGhIU2tz0/zvHplmBKFVcwfdKsCNEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNhrdyfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNhrdyfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988541F00ADE;
	Fri,  4 Sep 2026 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553948;
	bh=QotO6t/gxJhNnDfEflEG6Jb0HyKrtuKlqDATWL/nzKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MNhrdyfXMDByrnpFmX6hfpiEVaxttNS3ZZj6YhEbQ6o9ZYZeU1y05IlZCoSnxtWg3
	 vWxZ197TvOT5F0J6MMSUJm1QWeYsPWn4dO+bmdgBQA6RuO4oEnFay4/I0WaltBb6zG
	 N5j1SOaRRejBB+h+PuGxQJ+COByQ61cewRbVqAyTcdsSyQKbsTN1NPQsrDgLvvL0oz
	 Uu0npF9iieL3UYVzIBn93HgBvVsW4Lguyx17T64m3kRwYM8rOjwcnZ7MFdAybXTGIG
	 Rk+Z4iT1JRaYDJGrkAxiC7Fxmj/jDH2ju8I1atOkP1V/jso8mykRz82vfyTTNOd7eT
	 MLuEa49JfI69A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 8/9] zsmalloc: rename class stat mutators
Date: Fri,  4 Sep 2026 16:32:16 -0400
Message-ID: <20260904203217.1548415-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203217.1548415-1-sashal@kernel.org>
References: <2026090349-deniable-copilot-d36a@gregkh>
 <20260904203217.1548415-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 791abe1e420c3dad6ddbd0a6c40467e9e24059b7 ]

A cosmetic change.

o Rename class_stat_inc() and class_stat_dec() to class_stat_add()
  and class_stat_sub() correspondingly. inc/dec are usually associated
  with +1/-1 modifications, while zsmlloc can modify stats by up
  to ->objs_per_zspage. Use add/sub (follow atomics naming).

o Rename zs_stat_get() to class_stat_read()
  get() is usually associated with ref-counting and is paired with put().
  zs_stat_get() simply reads class stat so rename to reflect it.
  (This also follows atomics naming).

Link: https://lkml.kernel.org/r/20240701031140.3756345-1-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7bf5cd5b5f2 ("zsmalloc: account for handle size in class lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1249cfa2b67f2..b63864f5fa398 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1873,7 +1873,7 @@ static void async_free_zspage(struct work_struct *work)
 
 		class = zspage_class(pool, zspage);
 		spin_lock(&class->lock);
-		class_stat_dec(class, ZS_INUSE_RATIO_0, 1);
+		class_stat_sub(class, ZS_INUSE_RATIO_0, 1);
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&class->lock);
 	}
-- 
2.53.0

