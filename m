Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41531A6838
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177088; cv=none; b=jZ58Fv3kpOgCebUJWI+hfJtK/Dm9nssu8ZaRUuM4usvwerVe+hF2RF2Kba8pcpvBunCaSjg5qbTOMQh2Y0X/N0AyaMD3pnmvgJKBIbvgSmc4m7zeRuAICxSS+zYaVSeG8DfgepJxjR8+BVeCDNTXOX7ULv2iVAOZzluguu3Q594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177088; c=relaxed/simple;
	bh=47aIRuqMGIeCi8qfFeykEK8mT+Dh5PHDOThqryLv10Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT5IPhJcr/24Xtre2utQn7GEaf9HAFOSbi0VMvceTLaXC2In5ZG10MESZ206PqTzXpeT77z4yJdu3qeCWUWBQBY4sm6c9Ck19yHF1rkzliTWxTAVYgiD/pfzp1D+mmtlVucGPaIqhylPb48AjGBLZL2NKyroH+UmZtKoiwguNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDwDelG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDwDelG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824CF1F000FF;
	Sat, 12 Sep 2026 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177087;
	bh=JNQcd29pkw4ZPikR4pK0v+CRgCY+OlNQBWhNGmz1F6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jDwDelG+WSBnBkzcsaPNVuM+Tmo2jED+JQ+ZbP42ICoV9jiX9/y6klNWtDyHcVXe9
	 CtFYRlWtI+ZQHgNbDENLr7P88ByNP3uZy2pGE0XLOQKZ+2XcnJYyy26idEo8b7vPwz
	 KuU9M3nP2tL/fSus3Spj/Ulk+jpI8nyWsAxmXT37xY8GibzQJ59XWnD/e9/z0oIEs2
	 YOijEyvaQQV8gT5bU1YltBYWw6bv0BIn1vLgg/DZqKTmbdt27bE+ZOvRekMihcmygL
	 z0+jVhPmlMXGa3MFZpVYXWSEPOYxIB8u+Akme3VtZ4XMd5cS9Ibt8EyK2IC7R4YU5n
	 u0MhQq967jmvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix dentry folio leak in find_in_level
Date: Fri, 11 Sep 2026 21:38:04 -0400
Message-ID: <20260912013804.1793900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090915-cargo-unclothed-b04d@gregkh>
References: <2026090915-cargo-unclothed-b04d@gregkh>
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
index 29ac1e77b5d7a..cadc32959a23f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -374,6 +374,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_put_page(dentry_page, 0);
 			*res_page = ERR_CAST(de);
 			de = NULL;
 			break;
-- 
2.53.0

