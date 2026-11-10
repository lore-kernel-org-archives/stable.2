Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338951;
	b=hB0ZytaVikosMSlDYyKjX4uOlEZ6B4K237+I9oQGJ7jiaDV4M3ha78f4bAP6FcaedDi5
	 qjjSeaJY0nYxoesUrAHuwJb/TiTLFLh8byOCXndc5uV88eHzKmCJLBimZNBJQ/juH/ju+
	 oogHLdW0bu7Dm1UB6dguf7mvodvY/zKxRBT0lES4IXo5G+2ainiYBtzlsOniaDUGhYtc3
	 7Poy0fDA7I75vpILbqCQuYnCCOfD3Ehnx8fwVhRX5EHZs4sx7huEgVWiCxH1ULzk9Gvly
	 EjbIU8SBoJyKVF94e4/SPiMrO5ZugR8b566pIuHQx8a04Xdhy5L5L3pllZlNlGnChjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DzDxKwKCoEhL3mHEQXZ/S4Nk/fmc3g1YbS2wlfHFNMQ=;
	b=Vg3ROhkFizBrS2/CN3ZyNDyBK2rpJOBQ1rkkqQnv/DFOwKT4BIZd+LElrFCr/avhr3Ae
	 EC9wcWaPw55Pmx1MrbuW9Nkfm9IoASYrHC5r1MAuTG4saeaLPMX/2BeQTHU1KWP9hLmEN
	 3OCMceuzH+BU+Q8o94oCj4h1nvrK2jH1zARWT90cNcThloPKx4cV1Z3rrWoSuSqus7Mp9
	 /EDa30n77gqqqPfKp4FcBdMEvxY139zRtIFaz3JXYbpphBWbVWGmkW56y/RbpUdvPoL+e
	 Zpxm0fM7WSF1MNZrlFDRH2apWpgwuoGnMakoqjZ5w2/NZ8+nRwFSvnduYbEACeMDuxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVAMVwrI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DF606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVAMVwrI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3DE1F008A1;
	Tue, 10 Nov 2026 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338950;
	bh=DzDxKwKCoEhL3mHEQXZ/S4Nk/fmc3g1YbS2wlfHFNMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVAMVwrIaT2e9fMWwZzcal8dNtrVWwEAOZyvGcR6uadlehG1lHDjlG/AEN7CZ5itX
	 7xWTvQ54P2BDFDR6Eh3G+UUrA1ebyAxjh3mYScGnUXhhIngR1HI7MSAoTpYyXNCPZ8
	 6GHynZPzDVAcD7cKT4JB06I+73P1D9jHggjO5Pd7n43ZL5MNf2u8WMkzer+owP4kl+
	 CGM8AqcEIq215fu1duq+8ePTFUy9ufsPaLpEJMT7J1ORbIHeEhyu79e4x0e14lStiW
	 AEX4DXpT85zF/04IcOvKxZOcsnG9IVKL8eRtfREBeGfTh7wVQP+vDh1nN31XwFI+cB
	 ++wKPBBGHoBDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] nilfs2: remove nilfs_writepage
Date: Tue, 10 Nov 2026 14:29:05 -0500
Message-ID: <20261110192816.3526676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051714-failed-6.12-cb6702e63e0a@kernel.org>
References: <20261107051714-failed-6.12-cb6702e63e0a@kernel.org>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 310293201ed242e466b0e9f10f53b4a4abccffec ]

Since nilfs2 has a ->writepages operation already, ->writepage is only
called by the migration code.  If we add a ->migrate_folio operation, it
won't even be used for that and so it can be deleted.

[konishi.ryusuke@gmail.com: fixed panic by using buffer_migrate_folio_norefs]
Link: https://lkml.kernel.org/r/20241002150036.1339475-2-willy@infradead.org
Link: https://lkml.kernel.org/r/20241024092602.13395-10-konishi.ryusuke@gmail.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: cb6702e63e0a ("nilfs2: force clear dirty state when restoring from the shadow map")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/inode.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6932f8daf7d93..040b93f027306 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -170,37 +170,6 @@ static int nilfs_writepages(struct address_space *mapping,
 	return err;
 }
 
-static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	struct inode *inode = folio->mapping->host;
-	int err;
-
-	if (sb_rdonly(inode->i_sb)) {
-		/*
-		 * It means that filesystem was remounted in read-only
-		 * mode because of error or metadata corruption. But we
-		 * have dirty pages that try to be flushed in background.
-		 * So, here we simply discard this dirty page.
-		 */
-		nilfs_clear_folio_dirty(folio);
-		folio_unlock(folio);
-		return -EROFS;
-	}
-
-	folio_redirty_for_writepage(wbc, folio);
-	folio_unlock(folio);
-
-	if (wbc->sync_mode == WB_SYNC_ALL) {
-		err = nilfs_construct_segment(inode->i_sb);
-		if (unlikely(err))
-			return err;
-	} else if (wbc->for_reclaim)
-		nilfs_flush_segment(inode->i_sb, inode->i_ino);
-
-	return 0;
-}
-
 static bool nilfs_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
@@ -295,7 +264,6 @@ nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 const struct address_space_operations nilfs_aops = {
-	.writepage		= nilfs_writepage,
 	.read_folio		= nilfs_read_folio,
 	.writepages		= nilfs_writepages,
 	.dirty_folio		= nilfs_dirty_folio,
@@ -304,6 +272,7 @@ const struct address_space_operations nilfs_aops = {
 	.write_end		= nilfs_write_end,
 	.invalidate_folio	= block_invalidate_folio,
 	.direct_IO		= nilfs_direct_IO,
+	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 };
 
-- 
2.53.0

