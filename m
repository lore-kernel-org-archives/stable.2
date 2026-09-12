Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072425B098
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177424; cv=none; b=QIG712hXzmqV5WhIUxnTPBx+kjSiR9/LbAGkq+g3yR4PY3/2sn4Oub3BBvhL11wX4olfQ7/QH3vt2JegUyhopZTjzsf9J9qL3ygYjEBzgjbSJRRZhe68FciL+vf+v0uEbOn5s8dGgEiseoTH27QHwG0y7K1jCk3wyPu2rRxtmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177424; c=relaxed/simple;
	bh=2IhgwsEqWpb/AwBPnEv0tAa91V9Cx2nJX3ixktP5cQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuE/H9//+UzVMPAKeBMxYlurNm/bRG6smgttxEXc1WpnalYiahs6+CKAjEDjz9lDh4JbBwKhFnSIF15SNpoIEfDaV10gBYkR94/OmBb78ywqtyG7afYFfTq7RZes2S4RzOrIgM3ObzFLJJiNBjElM4VHKKs/OHH626jvjjKNIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9BFG3Ej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9BFG3Ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99511F00893;
	Sat, 12 Sep 2026 01:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177423;
	bh=i31CoRgO2ELmKj/8ySedfROtlX1num44DEz7Pp+9jY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9BFG3EjPb40mNfTB2n2mOG2QcumfW2w4X5VfehqrzqJx21nioN7Q2Pg1DHBBAOF5
	 CncZqaZ0UG1ClsAnVzV+aRLwA4oEcZ/HOAWs3dJdEB10bnblg9l+PYmAX0K7+Tb0SN
	 bss9SKojnHB5k/scw2GOvzFD/kCKi9yX8rVZs7RDESg1VgattvQOdTv7ZBU3y0i6w1
	 MbgsiNa/6hwKBnCKP3KcWx5x5jrJHaGlNiBAvLo8v5YYzLzlDHNG7aY3gxMWmxi7qv
	 goTEoUhJ5yOdRf0VXWDToMygNxVNDCgzSPwF3uJptzNnxJVy2K06tkKElcyH7sm2Jd
	 iT/fWLnb9aqMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix dentry folio leak in find_in_level
Date: Fri, 11 Sep 2026 21:43:41 -0400
Message-ID: <20260912014341.1817739-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090915-unstuck-shrill-bdea@gregkh>
References: <2026090915-unstuck-shrill-bdea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Yang <3497809730@qq.com>

[ Upstream commit cca7d3e30bf30333314e31bc70b9a739f1342167 ]

find_in_level() gets a dentry folio with f2fs_find_data_folio() before
calling find_in_block().  If find_in_block() returns an error, the
function stores the error in res_folio and breaks out of the loop without
dropping the dentry folio.

This leaks the folio reference on the find_in_block() error path.  Drop
the dentry folio before returning the error to the caller.

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Guanghui Yang <3497809730@qq.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Replaced f2fs_folio_put(dentry_folio, false) with f2fs_put_page(dentry_page, 0) for the page-based API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index da717e4d6aee7..8ec23b8af64e1 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -372,6 +372,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_put_page(dentry_page, 0);
 			*res_page = ERR_CAST(de);
 			de = NULL;
 			break;
-- 
2.53.0

