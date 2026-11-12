Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453863;
	b=2Y538miFepQDu8+F31ZfPrUoZxuF9VJ1BIKdnSQR65fatJm87p3cZCIoy1SQFO4XnFHp
	 PzKBv7R71qWQ3M0J1UPgBe7edA/b3FL5pc2UakehLu5A6bHss+Lk15pLtXU1VDjUFcHcW
	 x1jiOloyuFIhb4pEVl3DhDcsXJwgMIAuI50uTKhG8sUVMgce+hvcu7eXq6D4IMSjKl/Q8
	 E/CLHyqhN5Th21vSb+SZQUDsdiFAPwzOB8Z7hzAsh38IhGE2X9Cd//qrzATxjK0bV8iV6
	 XOTE8/qaEN+UBl1UelwAmNRdyikDVddCsQOIWZksXaIK+Omt0anld6zajWLq+AzLRDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qvxqS9EgAcvEJhVFWFFlWpYrYwHVreIn70VbEL2mOVc=;
	b=ce9wpZhjv22CJ16S9zDoos5DdLPeNmKd/bOcx1vyzQwydvn7h21l0Ya5YPUKyqc8UwS+
	 Jys5g60svN8km1DwBoM/ndZmJNZD53OjQ9q+NVrxEv2+YhnaovO1Qh8Aa7+7dxaLQPpOC
	 QWk7vwi/lhEr4BgFF47tJj0XCSggLjG7jWfcnPfrANUNYrn8NwmEIWhtjRgvH6te2gwRp
	 b4ChlUbucedq14hpbiKAg0I3W5jAD55CY7tf0mf+zQwociMIpp99PEfySwX4TtcN82eCB
	 uFydM7m5AHpObZKV4QyINg9sDAJvUL7OtuIlnvjUKDWbCaUXZSXw9BqY1WnplJbgfkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+03UKnE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E81D606A32D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+03UKnE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B5E1F00A07;
	Thu, 12 Nov 2026 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453862;
	bh=qvxqS9EgAcvEJhVFWFFlWpYrYwHVreIn70VbEL2mOVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+03UKnEPxtqdj85Ivs31AgWfi56E97IvdxO+SPAXsr5j3gIFHmMGwgz1QIz+v/w6
	 9Q/FvIm+KxecH5CsVwP5KAnJ1NXetFQiizk7BRAOVJGgj1Rogxu1VXF/kkR0ZaoVRY
	 OHPd+gO7d6yTrTfnKt35FwwmFi+whyWr8g8q2UoZR5TifuhDkgPy1LjlyWPbA1Q+lI
	 jUhZvrRoWVnAxqsXMO6pvFtsA5FIYv+8K9Rqmv7zbwKTYWMjvgrCnsAE6Z3y0AT5wf
	 tYxrhow+yMLr2uvZ0yB2VWLv9mLRqcln7Y/e9E6RlI75WcrI0q/JHdPUlTIG+Wqlt6
	 FkI4ncnNpEClA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to fetch ino via ino_of_node() under cache lock
Date: Wed, 11 Nov 2026 22:24:20 -0500
Message-ID: <20261112032322.1544334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061223-failed-5.15-cd6d8b189139@kernel.org>
References: <20261107061223-failed-5.15-cd6d8b189139@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit cd6d8b1891395b681f2060916a4b83880b765698 ]

In f2fs_writeback_node_caches(), it's better to fetch ino via ino_of_node()
under cache lock, otherwise, node cache content may become stale after cache
is unlocked due to racing w/ truncation.

Commit 493b9dc8b52c ("f2fs: cache: use node cache") fixes similar issue in
f2fs_flush_inline_data() introduced in commit 34c061ad85a2 ("f2fs: Avoid double
lock for cp_rwsem during checkpoint").

Cc: stable@kernel.org
Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: adapted cache-entry handling in f2fs_writeback_node_caches() to page-based handling in f2fs_sync_node_pages() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e5a06a65a5398..1234320249ca3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2013,9 +2013,11 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			/* flush inline_data */
 			if (page_private_inline(page)) {
+				nid_t ino = ino_of_node(page);
+
 				clear_page_private_inline(page);
 				unlock_page(page);
-				flush_inline_data(sbi, ino_of_node(page));
+				flush_inline_data(sbi, ino);
 				goto lock_node;
 			}
 
-- 
2.53.0

