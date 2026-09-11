Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA8357CE0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164011; cv=none; b=VafDnitk3FYrRZri1s2rqdpJAgATA9L8+EnpJg2VPhFkwTclnQ/6F2+tecif5xovxOIbSjwOVBeQFpERKoG8mg59VbTsGupTFR3JXiBwlCuH9Ri6SGYUVhWvHqc/2sa31E3CKlIvTyJbbFI52hTguQLEK4IfaCAscZol8jug0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164011; c=relaxed/simple;
	bh=2/DxFPG086wPCglVr8zvZ/DCwFlRno4AAKilzEGNfLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN8bWiT2u2FunwAOs179GQQgMv037mY2afHpuI4WEwVVw+W0nhPyaXQeSi+oqi2f5lo+6Hhr6pNU/uqIGO6YkRlrGiZysWTSdJLEJOpXKpa2sGOq/LynLa+bfWyvvbf9ayUMY0rJyyJyaVjtZ8lh+gDwQsoNIwLrSGTXkNylrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4SM7xE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4SM7xE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4395F1F000FF;
	Fri, 11 Sep 2026 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164009;
	bh=kdicS7rkKekcuRcouAGF67Qczg23ezb+JUvc8Elrh00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4SM7xE8xzzG6/ymohR/RmDDyobGxIJBQva32SN5mRKitJGCgKZCbLzqc8H/UkEdw
	 kE28xRLSq9V+6GkHl5D/Eu/wp6NTwpGeoGs9h+yNeg4p/8wrGmTFdi9fgnbzvuhA98
	 SuvcgOfmul/guRsLs5Mg9cMyIYn+/MqXltODtjdIzOAOVXuo+spbOlEU2r6eF3AJIS
	 jCt/7VGP8KrBXoJSc9ZEwCxFWTBsb3n0d5eVSPP+ibg6y3eGnxhzmLlDxJHXlVqYCe
	 +NBZ0XUCM8000GnHl+iT5+iYBenjvvWPzRsf6mcSMgxGrCNmAHCqn897NB5omlM8HX
	 /RMpY2d8jvmvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix dentry folio leak in find_in_level
Date: Fri, 11 Sep 2026 18:00:07 -0400
Message-ID: <20260911220007.1622045-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090914-turret-docile-791e@gregkh>
References: <2026090914-turret-docile-791e@gregkh>
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
index 54dd52de7269d..9bf33debd4229 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -298,6 +298,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_put_page(dentry_page, 0);
 			*res_page = ERR_CAST(de);
 			de = NULL;
 			break;
-- 
2.53.0

