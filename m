Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667012;
	b=NuyIosBI2YJiu4Q5keHm+0VAYtWZv9U007TDi1az0zPXIf6kf45CK1bwBeO7iJWxRZWO
	 iEvmKOj27jOPXVPj44mjIn0pF8XtfSBJqT+ENt3/nRvtbwCQrtiqKGHssUkxRrPMM4Sw/
	 hNxzg0vi4ONbmu2rKzw4BhrWtEAgJp/yOEVZ/jSQYi8dtkO/j/No6IATjVvUuyWpoj2Qx
	 FlQjIHkTprODupnsmMDAgmUOl8mp8ZH4EVXGfNtqA6ohzq0Evom0VCfrPBSfWXwCXhIg+
	 DgmDY5l2RF8OMUmbA/Zvkka0qU25GqhUDrWbRP7oDnPFY5vD+buUpA5BIuZqJd97lNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UEBLoEVOFh0yTlrwg7u/ulSxZUJmzmvvNtWhKxXRCoc=;
	b=N6aKJT5BAXQXKV4ns4tylhQoK3vDNyJgXdNCvOtd08vOOG9+OFGxgx+YX4ahi45slCUR
	 hHzNjAmN9e0bEKPVqeNhhv9w2TN4/PpNYJ2BA0fCCRmPGGW0HVJHy1pkLVzbabmOAU1B2
	 Q1FQNuXBhykcaCstKRWoffi2IJFtSx+oKcSUNFwujmh5iHHaqpB1zPFVr8g1F/3sZ15Rb
	 oaAmWk3LFQ1lyqG0fFI7ITE8tINVO36c5rv2z/oFJiSxCC5RQ7P4UFnf6t2AxjBUsGF7g
	 4oCfPL1yYbsg6joN5sKMuGZxAXUI4WcYHdW88Xr2EEtjCDlJ+Svh03utW2MsIQKMxkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nxeq2I8J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778B606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nxeq2I8J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C941F000C6;
	Thu, 26 Nov 2026 04:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667012;
	bh=UEBLoEVOFh0yTlrwg7u/ulSxZUJmzmvvNtWhKxXRCoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nxeq2I8Jfawx091Y5wz6bZkO4VbTiXyKtBx41KKfvPWy1guD1IVKTJzXXo+vDoHl3
	 wAZdLX7PGJJyuMj2Xn0INiTuSbjrsYEcYd+R0uR4EWqx2MeWXad1XP1GBSovDh/DMA
	 /d9F36ZwL9eZxavTxYQpWTP0VGsm2qCmUyr8NjoAh2jzw2k/NPK0cPGfAlZ4wPI2KE
	 ymd1wDbZqLvDZIZVkjl1c94s47atBmIn9lBLPdHoznPUgz054Ym72WHMSTo3dNK/f9
	 g37eQPcCWRDcilDfpazgJBROKilEPX+21zCMCn2RfwhcLJ8PbJ0COvSOVAshA27f1G
	 NX88Wv5CPf5HA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: don't block dying tasks waiting for writeback on close
Date: Wed, 25 Nov 2026 23:23:30 -0500
Message-ID: <20261126042230.1914554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112534-bullfight-wanting-5e38@gregkh>
References: <2026112534-bullfight-wanting-5e38@gregkh>
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

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 15ea186abbcd04157c62e0901701870b812bb2bd ]

cifs_flush() waits uninterruptibly for the writeback it starts.  A task
that gets killed while closing a file on a hard mount with an
unresponsive server is stuck in D state until the server comes back.  It
also consumes any writeback error for a caller that is about to exit,
hiding it from everyone else.

Wait killably instead.  If the closer gets killed, stop waiting and leave
the error bits in the mapping for others to see; writeback already in
flight completes on its own.  Don't wait at all, nor check for errors,
if it is already dying.

This is also needed before letting dying tasks issue their writes from a
worker, which would otherwise make them wait for every one of them.

Fixes: d3f1322af8f8 ("cifs: wait for writeback to complete in cifs_flush")
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org
[ sashal: Replaced folio batch and folio writeback-wait calls with pagevec and wait_on_page_bit_killable equivalents, and dropped the braces around the if (rc) body to match the older code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0da9c11cae278..a2b390facd7e0 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2676,17 +2676,50 @@ int cifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return rc;
 }
 
+static int cifs_wait_writeback_killable(struct address_space *mapping)
+{
+	struct pagevec pvec;
+	pgoff_t index = 0;
+	int rc = 0;
+	unsigned int nr, i;
+
+	pagevec_init(&pvec);
+	while (!rc &&
+	       (nr = pagevec_lookup_range_tag(&pvec, mapping, &index,
+					      (pgoff_t)-1,
+					      PAGECACHE_TAG_WRITEBACK))) {
+		for (i = 0; !rc && i < nr; i++) {
+			struct page *page = pvec.pages[i];
+
+			while (PageWriteback(page) && !rc)
+				rc = wait_on_page_bit_killable(page,
+							       PG_writeback);
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+	return rc;
+}
+
 /*
  * As file closes, flush all cached write data for this inode checking
  * for write behind errors.
  */
 int cifs_flush(struct file *file, fl_owner_t id)
 {
+	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = file_inode(file);
-	int rc = 0;
+	int rc = 0, rc2;
 
-	if (file->f_mode & FMODE_WRITE)
-		rc = filemap_write_and_wait(inode->i_mapping);
+	if (file->f_mode & FMODE_WRITE) {
+		rc = filemap_fdatawrite(mapping);
+		if (fatal_signal_pending(current) ||
+		    cifs_wait_writeback_killable(mapping))
+			return 0;
+		rc2 = filemap_check_errors(mapping);
+		if (!rc)
+			rc = rc2;
+	}
 
 	cifs_dbg(FYI, "Flush inode %p file %p rc %d\n", inode, file, rc);
 	if (rc)
-- 
2.53.0

