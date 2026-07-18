Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300862882B7
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375467; cv=none; b=RCxUa81/Tks3IFCmitW6hbbVcLmWpOd7SW37mAIzXr+nbPsdyevO1hrkkdnWjFlwr/qkeOgb3YRAhGizQB1qGWiXaxaDAYzEHjWT/yXTldIah0damNTH3o2ObrhAO4eWri3vuMGBqabYo2jBaEmkxCvOaXZILF9zKmzXIUuyzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375467; c=relaxed/simple;
	bh=Sqm7qnLyasL5WjEIb67NTyTKDSSEjrt1oZp1zDUQsao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/dEMKVuQ/Da34eA3BZMKZkRjIawdj6DJDT1eBt8ID3Mo4CTw0/TIs7lkCEftB5v6YZmb6FUN4Nc2n4OiePmHOUjNqYp4PJtRZCmiqkzPk98qS7+sfBlOykKHHIEVXqblXUWQU94I6eSXEylgNNc3E6oSFoDRlijvNCW5Es2m6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKO9RO0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKO9RO0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097451F00A3A;
	Sat, 18 Jul 2026 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784375465;
	bh=l9zRuWY75myhNKw4dkHKpjEDXReklVbyI6yQp+4s1tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKO9RO0bVh1Hlc1m7glixOfvyxA3Oyvr3lPsgkiP4Y5lfHaBHf1ntBhxQ3TeJHDP9
	 StAie+yBBu7tWNLK7nDs5HvM9igJQWFbkEWTBSuoblAwdpEDKyMcZ+US3Z9v2Mieyz
	 5cZnw56cVjKajJJPKXj/DkWje3s6p543U8kNrpN9pPC4pBfn1ZuO4h2eWmZ0CLVBzj
	 OpG4IIlkAosqHT+Pjro7QHS+vl98wVV3zbC3ccOCUe6v9FFOVip3lXjZfXdcFinE96
	 Xz7AebkQ9nzer3flQx1pTpCk7CbvfDBFRQg4peBYe2wZYbKmv4LxnMivM3OwaD+zgW
	 FN/YjI4/8Lsug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] xfs: factor out a xfs_zone_mark_free helper
Date: Sat, 18 Jul 2026 07:51:02 -0400
Message-ID: <20260718115103.3085836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071416-friend-sanctuary-1a9b@gregkh>
References: <2026071416-friend-sanctuary-1a9b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 16fc9d358d12e6e9cc553162b4064ad58e7fa869 ]

Add a helper for adding a zone to the free pool in preparation of adding
another caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: ae3692c7f440 ("xfs: add newly added RTGs to the free pool in growfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_zone_alloc.c | 11 +++++++++--
 fs/xfs/xfs_zone_alloc.h |  1 +
 fs/xfs/xfs_zone_gc.c    |  4 +---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 5e297b75a85f63..08d8b34f467e72 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -944,6 +944,14 @@ xfs_zone_rgbno_is_valid(
 			rtg_rgno(rtg), XFS_RTG_FREE);
 }
 
+void
+xfs_zone_mark_free(
+	struct xfs_rtgroup	*rtg)
+{
+	xfs_group_set_mark(rtg_group(rtg), XFS_RTG_FREE);
+	atomic_inc(&rtg_mount(rtg)->m_zone_info->zi_nr_free_zones);
+}
+
 static void
 xfs_free_open_zones(
 	struct xfs_zone_info	*zi)
@@ -1082,8 +1090,7 @@ xfs_init_zone(
 
 	if (write_pointer == 0) {
 		/* zone is empty */
-		atomic_inc(&zi->zi_nr_free_zones);
-		xfs_group_set_mark(rtg_group(rtg), XFS_RTG_FREE);
+		xfs_zone_mark_free(rtg);
 		iz->available += rtg_blocks(rtg);
 	} else if (write_pointer < rtg_blocks(rtg)) {
 		/* zone is open */
diff --git a/fs/xfs/xfs_zone_alloc.h b/fs/xfs/xfs_zone_alloc.h
index 8b2ef98c81eff8..abf8358bb2662e 100644
--- a/fs/xfs/xfs_zone_alloc.h
+++ b/fs/xfs/xfs_zone_alloc.h
@@ -42,6 +42,7 @@ void xfs_zoned_wake_all(struct xfs_mount *mp);
 bool xfs_zone_rgbno_is_valid(struct xfs_rtgroup *rtg, xfs_rgnumber_t rgbno);
 void xfs_mark_rtg_boundary(struct iomap_ioend *ioend);
 
+void xfs_zone_mark_free(struct xfs_rtgroup *rtg);
 uint64_t xfs_zoned_default_resblks(struct xfs_mount *mp,
 		enum xfs_free_counter ctr);
 void xfs_zoned_show_stats(struct seq_file *m, struct xfs_mount *mp);
diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index f03211e4354adc..f76a091308528b 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -924,9 +924,7 @@ xfs_zone_gc_finish_reset(
 		goto out;
 	}
 
-	xfs_group_set_mark(rtg_group(rtg), XFS_RTG_FREE);
-	atomic_inc(&zi->zi_nr_free_zones);
-
+	xfs_zone_mark_free(rtg);
 	xfs_zoned_add_available(mp, rtg_blocks(rtg));
 
 	wake_up_all(&zi->zi_zone_wait);
-- 
2.53.0

