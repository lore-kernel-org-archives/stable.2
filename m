Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678950;
	b=oLGlKY+GwVfq8ezFs1gWybuGxkPI6gUIvsJMgzeK+LksnBCyAeKVkxr+TN7CSAvHqxmg
	 U0u6ItrCDkR5BqQVbMf887k4vQtgDve4vyR5FTQ4egX/99Lo0SOTsGskT8DAQPj036m2d
	 HKdOEcrgcTDSCHABFSmLUWsDEjl4HyfV9iH5xdHasHIsohMPq1L3P04FxxqstJHNY+FVE
	 JT7HyAT2yzxLrCpN+D2m3v6BDXbq/FAU2UxHUYA1YFoexLGPq5xL09TPp9rgQ+EV/jL7/
	 DkZpKxH4IxJxfQIcB54JMZ34gFUsXPRL3fFCc3zA+1F+jQ/6jOSpxIl3quRbMP9PFwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hXmY1hqwgQfpsbxcBPlpw73jeqeR42wEz16nwbcQrSw=;
	b=tYNdTQBkxBpkw/nTRyiRIv6+KWYuTE8+El3uPqkUSGMVG5Pryye02SHMkwEAq1w0/HMe
	 GseJaUogXOt0vYQ0fco9HjM9pSTV7IqVkuAhdrDg82VqiagR328rW3rDYV5E23iv7+0Dt
	 82ChRbEyNnmOI8wQAO4amdR5KefrJ15v8HoAuWSB+CNy873DjEQr866WxnjnOwu1uq7/k
	 pTSwypVeopqxdD6lLTACxrjlBj73dad2Hr2i/miMq/s1V5M616Adkeal/KDcPHtG2uLbm
	 jja3YvIxH2oi1bMne6Q0YMKoBvaL0WLzJ0AC8Zo7SDlA6yfCH/u3wpFfgG8yabUsZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr+RsW6l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA0606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr+RsW6l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876DE1F000C1;
	Thu, 22 Oct 2026 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678950;
	bh=hXmY1hqwgQfpsbxcBPlpw73jeqeR42wEz16nwbcQrSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jr+RsW6lw3PqGqad2G+JnesnNvfUyXHP7WFsWHTu6T0Mo8KCgAyW509oLa4tmtbs5
	 8XmVgsWxBRwHYpwJZBzngQSLhMvY6j/7N4nrtxSFlnaInHfjDPuT4Uk66AVK7gs/Fi
	 BUyw5Jd8Ts47BMrDBL6zt561mg4FBz9yCjE1ibOKhdBMydx3XwQwHX8PtjFm6+ur1b
	 X4q4NIpXnvrr+p8n/n76Ul3EY3YN06dU8uwoDBzVrEOYn4cdQeBipR4jA1OIJAz5oq
	 MDyykr4tS/tZ2J8+xzCEdC9Hd4jTBXEa1MSGLlK7NVUOfA1x8h2YePLPZL+j5tXmMf
	 AwYdvcm3E9raw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()
Date: Thu, 22 Oct 2026 10:22:28 -0400
Message-ID: <20261022141745.1515054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102114-skimming-various-491e@gregkh>
References: <2026102114-skimming-various-491e@gregkh>
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
[ sashal: Used a standalone failure block because the upstream success branch is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6ef0fcd9a05c2..7cd2e88a86b72 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2292,7 +2292,7 @@ smb2_duplicate_extents(const unsigned int xid,
 			       trgtfile->fid.volatile_fid, tcon->tid,
 			       tcon->ses->Suid, src_off, dest_off, len);
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2318,6 +2318,11 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	}
+
 duplicate_extents_out:
 	if (rc)
 		trace_smb3_clone_err(xid, srcfile->fid.volatile_fid,
-- 
2.53.0

