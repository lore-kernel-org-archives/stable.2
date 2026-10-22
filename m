Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706730;
	b=I367us2V4ymhB7cv+BE7cJVc8zT5bKNoitoM9L0mD6hVXoOVopaldc7PYF/WXlAzze/i
	 ZFcjOXwurffSgn5Imix+Gg+G+/Vrd9b2jWBzT13Qmnw8Kai9THwNiV3P1vi+Jg8Xu0qVz
	 pXSW9UT0/1psB+lPiW5fUSVTrr9FPuO8a7Sr19aFqL8+pn7LjwEFK+5w7+s3F5QyQ1kI8
	 jbazx949gmXcMaxFKofC1zHRqAW31bfUvVfTTGpG0V2DMpZtyTRx3PKaBRrGVLO1UQS19
	 uOKp11dWXR2pwAsgpuWZLNvR8TgD4rGoGBFxfmv16sDtJQg+ZG+YNjbA4xNkDorBNUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H5BU/gxfUxlopJpUFZRDjTLRFBZl79P8s9RRDE1yxPM=;
	b=Vwez8vcGNiGvm13bx/DgNKLOaZR03QoGwtdfPHes0gIwHQnBZbr4xJ1JtEQ4QBNx/T6n
	 42cyMfki+tDTZKcqXulDAVgBsBYMu18s0G4Cje7gQGEBnjFtqm5DF/XtNOIhfPbaMNar/
	 CStlwzxNxocvvoGnwo/+bwlP6zQwGOmrFuAqyCzkfnNVIzqNLQFyhinp/EyQix5jrofBf
	 FPYn/3/MVsHzlcStnHM4kczmFG7jCz/yyTDN++Cwz+4+96LQ2F2UIN3KrPeRDf1twfSXQ
	 eF0S8MrD8xtmGE5tjyzZsR6RTub+09MC53OuM69wj1y67e7uRnPnnXhiOYlLa1dvKHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKIUMOWN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCF606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKIUMOWN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579951F01825;
	Thu, 22 Oct 2026 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706729;
	bh=H5BU/gxfUxlopJpUFZRDjTLRFBZl79P8s9RRDE1yxPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DKIUMOWNQtbjqpjDLrGUn3dwBPuTy5d5toJyDPyyNWM013viQWAxQaAOsGULCzsBd
	 YPW16pTFZnd03dPQclcGLL/kWraOlqpIC09EFxoRmGa92nBz5YzbE5EJDtU3Iy0/+P
	 r3kVPrVY/K65sktv55sbQfLkkasuRIZVBeesrENJdDqYsCYon4UHqJKdc2hUReyeOh
	 witL4Zq4s/y1ZL3bHFIfCi2GTUDC416mxXVgXdg+2DZ7/HIXzIhmkk6CtR7QKnSAOG
	 I0BSmaBqlucwlSK+9H2dmmRU84r7sKzOlQAC47FbovJZl386jOUKJWcK6gGTlndrMz
	 E4pu9ZOi2UdzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()
Date: Thu, 22 Oct 2026 18:05:27 -0400
Message-ID: <20261022220238.1944141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102116-grove-undercut-9b92@gregkh>
References: <2026102116-grove-undercut-9b92@gregkh>
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

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 53676a5e28231186c9f56d87b7998b640699bc15 ]

smb2_duplicate_extents() has no handling for
FSCTL_DUPLICATE_EXTENTS_TO_FILE failure: when the FSCTL fails, local
inode metadata may be stale from the pre-extension or from concurrent
remote writes, but is never refreshed.

Force revalidation on FSCTL failure and use i_size_read() for the
pre-extension check.

Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: replaced cifs_invalidate_cache() with fscache_invalidate() guarded by CONFIG_CIFS_FSCACHE ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 5d07e1400015b..0e95065ae0767 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
 #include <linux/falloc.h>
+#include <linux/fscache.h>
 #include <linux/scatterlist.h>
 #include <linux/uuid.h>
 #include <linux/sort.h>
@@ -2045,7 +2046,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		src_off, dest_off, len);
 
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2070,6 +2071,13 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+#ifdef CONFIG_CIFS_FSCACHE
+		fscache_invalidate(CIFS_I(inode)->fscache);
+#endif
+	}
+
 duplicate_extents_out:
 	return rc;
 }
-- 
2.53.0

