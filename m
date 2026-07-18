Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B571207A20
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784373635; cv=none; b=qlNsYFatJXJDCBEJm3/QPviWjIXPufbIHq2K2AEawOHnlt7e7nvLXtakvnXAO+eMqejHeHtvWzLK+qZOoMoXDm07uGZBRYk73+Bas4kglBH+8Br5uB3bAMXecYdM0H7WrE30XSk8C93AlO2jHcwBdbQiJd+3O8hpfGezJVY+03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784373635; c=relaxed/simple;
	bh=HFZUur50WBSOVqcBqXgQ0PtI5xiFkyxW8V9lU0X0qjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJmJmjQJumf//PvDwa/THaLN//WKDeulW+WWvgDpExFNDzX7yZbfOOp2aOrh5PlWbqS5fYXQQ7jBxN4ISS9kuVzhBs8Q12lnbT4+3Sbc8xt697Tma9TWIBSWaF0MGd6vpJ2nPdnVkOZG1cKXNhSjS2XfiwkxL7K5a3w/BQiXjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4Xo/T4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4Xo/T4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE6A1F000E9;
	Sat, 18 Jul 2026 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784373634;
	bh=NZnGuEZmx7QF/wrvATs3Vb/y4PK/Rp7Ge6gf8SdIYug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z4Xo/T4w/rVndK0YKgyHZLC09uyMJtr2aU7aAUUoBABPBC7Pv5sZXieHeb3bMi8Wx
	 fIjP1K2wAVxVTrgZ5NLRh3yWKfzJhme7Y0SrHimkpWYIooDjlWo3h/JU61f/PgWRUr
	 8hoQpC+lWmQJ4VWVH+PD+H9Ly8uDSTKAMFtF2e1SEKrImBnwcfzwcjcw3caS6GgxoX
	 EwECa/WCV5ozJSszBGH8uHtJYtNzrv3EHiFBzZS3dIFg/42vhjyvKKpI0L9Xc640zt
	 zNhHdtVYu/r4pISthmdFuA/fry208fKgK41joTsYywbC3uBVBofwsLmpZcGHfm2yCF
	 hjcVZc+7Dm3Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] xfs: initialize iomap->flags earlier in xfs_bmbt_to_iomap
Date: Sat, 18 Jul 2026 07:20:31 -0400
Message-ID: <20260718112031.2956124-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071455-siberian-quote-a146@gregkh>
References: <2026071455-siberian-quote-a146@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 327e58826eb72f8bae9419cf1a4e722b57c85694 ]

Otherwise we lose the IOMAP_IOEND_BOUNDARY assingment for writes to the
first block in a realtime group, and could cause incorrect merges for
such writes.

Fixes: b91afef72471 ("xfs: don't merge ioends across RTGs")
Cc: <stable@vger.kernel.org> # v6.13
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 490e12cb99be9c..dcea927e0d3abc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -113,6 +113,7 @@ xfs_bmbt_to_iomap(
 		return xfs_alert_fsblock_zero(ip, imap);
 	}
 
+	iomap->flags = iomap_flags;
 	if (imap->br_startblock == HOLESTARTBLOCK) {
 		iomap->addr = IOMAP_NULL_ADDR;
 		iomap->type = IOMAP_HOLE;
@@ -147,7 +148,6 @@ xfs_bmbt_to_iomap(
 		iomap->dax_dev = target->bt_daxdev;
 	else
 		iomap->bdev = target->bt_bdev;
-	iomap->flags = iomap_flags;
 
 	/*
 	 * If the inode is dirty for datasync purposes, let iomap know so it
-- 
2.53.0

