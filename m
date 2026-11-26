Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665845;
	b=5Psa8jOV2qjpxGjiRFIvXhEe7KSKzt3iHPh1VI9n0q4HnnQ8mLpbGEPC6nN5xhQz2sde
	 AtoC4J1+5P1wLh4EhZVNbW+MTSno5qJTE0lN94Vool2e8w3LuvrjfNB91no+zgyr4nPN7
	 G1gtAMCzNuTChl0Z+EynIG8RS8GQxqU49RP3HYmPinkfLO0oQ3MZ8EylI7gZAUNVkfrK7
	 7G7h3b/6zzHR0FIy7Vt9jGkKj14YRKT34kTFpCnO95F3darKMbrfuQP/2oJhqhzHszx9I
	 1rudvOqLlCblHTrNY0KdoS5bOdoY41HgLCbibTs6mLcxU86OJc6IoF3xtiHh5imE5Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UkAGJnO9JkFfJ1PaGsXuQa4uUH2dKOrX1F9vHRi7g7E=;
	b=225v0FHgAykNT9SEMUxO9lgwZs4s/2xyKkjrEPSd5A/Uyz8PLsZtp1AZvjuslm39y2az
	 23er8FmAZPtXW0lpKncJtu0PFnR/k9MZpRilbQxnX43CNiGWHchLdKTj7B3VRU0vrimbW
	 hKXOG7y2URp8ZBfzGFUBIbe3DX/TcfxNye9IvtcYXg8Y+QNWGfvnDPs/Ah+dgtVJYTO2x
	 fXTqWzWFYe0a2luWBUmZbFoqUcd30I1fsnx9bSuqLleptJpAeQCuOWW1A0rjzMrCUbvsc
	 CPeGtJxX1JyV26/oqOlSv7XdzZoMuS4k9UWixNTKl1phgyzZT1uwneFIwkRnleFnzhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFCnqvga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75433606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFCnqvga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A991F000C4;
	Thu, 26 Nov 2026 04:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665845;
	bh=UkAGJnO9JkFfJ1PaGsXuQa4uUH2dKOrX1F9vHRi7g7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFCnqvga3pxvZzBOBOOTrB/Wrxhcuhvzo9aE/pO5dCKj36MHHNbMU1aJPltMAnZdh
	 zbTz/xNEuMPZcDIdf2H8Z2CPPVUtKmFgq1JHOP1DYHnN6nYs8x0uo/vFSSj7YS8bXB
	 VtmskuPrhvSU0ltKG0gZNjEc7wz8HmtSJ0ajMOT19N3beqOJB7OBKkyE8aXlLD/BNi
	 ZlPBeb9P+LmWgaAIuwijp4JIykGrWDaaz4CqXQkgndqyVcHQ2OpOpyr3IXV4ox4cJR
	 TDVOSenzdf8IwagFwL74GqA5C/2prK9LRT9o7GtOte7UxslIbwbi7C5FkpnBG8/W0n
	 UPB1arilMV4lQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: don't block dying tasks waiting for writeback on close
Date: Wed, 25 Nov 2026 23:04:03 -0500
Message-ID: <20261126040330.1871779-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112534-exorcism-shirt-2fa2@gregkh>
References: <2026112534-exorcism-shirt-2fa2@gregkh>
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
[ sashal: adapted folio_batch and filemap_get_folios_tag() usage to struct pagevec and pagevec_lookup_range_tag(), and folio_wait_writeback_killable() to wait_on_page_writeback_killable() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index affb1ade0c15f..3014a9099daae 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2768,17 +2768,45 @@ int cifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
+		for (i = 0; !rc && i < nr; i++)
+			rc = wait_on_page_writeback_killable(pvec.pages[i]);
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

