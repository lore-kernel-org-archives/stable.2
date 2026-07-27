Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD03911AB
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166858; cv=none; b=RUt/QAw2oFPdxYbZhGLnvgf8/yXlgVyTb7QiqFMrW3mjGmqGLM1T/EhDBid4SQHBohyxvxHlZ/PBI4dJ7uLH9LjDi9QxgPMUiKEfh05C1rZ5MAVG2gk6G9hQqUklbXs4eur4c1u/VOBhmMNVUBdjLUjYnBXqBHhQGDdf/1rUq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166858; c=relaxed/simple;
	bh=ADYFu3mePC2IJ+wzIaxfra+wjMSIjZnJX4hGBb6t+iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyvxyweB15mt1iOrq/PTsYHJwD2yF0tQfKhvQde3Lj2d4un9lxeZ72xcSPmtpd1IGBv8kYXeBzTgZnlfHvkO0faKgul761sCR/YXAO3bArwXC1/3ThkYGbN60GU3zIfmFJV64VzlsokkmBZOEUPczu5vu5s5GLjxJQRL9/0NIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lkmf5SRg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkmf5SRg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0481F000E9;
	Mon, 27 Jul 2026 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166856;
	bh=b2aXAgcn5K2Uiq51ddFRq/d1jIzTRlng+pDSQf5awsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lkmf5SRgoT9qbtgjq45CnqDChxCB2y+9/tgoopC+GK/u6t9UAEtF4qj/9rKZBR4f8
	 oIfWNFKQuihy69NQzBs0hMNdSFjB9Do2SrwJW9U/6/uN8ts2lxqbzr118mw1wNv5CB
	 PMH4y/CIRlQqupVh+DCpx+ma2gk2u+fahuwQyvALzXgJyrFuQ09fbkiLwyBoav/soG
	 bOjrmiUyv2ih5ZOaE6kKIZSbQlSv3WsBG+R1tCVy/PI1mjnfXQsB2UWBO4PZOHYRRb
	 mLcBZg91O/oC2AwOk+7y+S/8jhFl71TTEH2GbSEcihDOmCe3bZZA+o9JDDYWGQlRca
	 1XB5gFSDjtpog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfs: remove dead code for the old swap over NFS implementation
Date: Mon, 27 Jul 2026 11:40:53 -0400
Message-ID: <20260727154054.1513904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072039-unheard-expand-767d@gregkh>
References: <2026072039-unheard-expand-767d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7e8e78a0ba00c88f0ded86de64bdddc82e06b196 ]

Remove the code testing folio_test_swapcache either explicitly or
implicitly in pagemap.h headers, as is now handled using the direct I/O
path and not the buffered I/O path that these helpers are located in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: 27934d02cbeb ("NFS: Charge unstable writes by request size, not folio size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 3d5ae22ed3a816..a76daeaa4a567b 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -791,7 +791,7 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 					   struct nfs_commit_info *cinfo)
 {
 	if (folio && !cinfo->dreq) {
-		struct inode *inode = folio_file_mapping(folio)->host;
+		struct inode *inode = folio->mapping->host;
 		long nr = folio_nr_pages(folio);
 
 		/* This page is really still in write-back - just that the
-- 
2.53.0

