Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F64499B5
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362261; cv=none; b=Lylqr5TRIDswwqKW19eJStRGMfA7CyJAlvE4PwFbkOPm+LDdox0lB0N8V2/Dzm8XeEW7mmYgj33NiB/9cY1pUKP3DQVfG1o1L42bkXubp08qaxAjh8jSM1j1k1CPUbXPlbHHzGjuac3fruHNoi3zlovblA8dsRrIJowFxGAw0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362261; c=relaxed/simple;
	bh=GlAdPoJUsskYf+qU5IqCHgB2nMPpUQWO8aJaZmQqqL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxJ699njeL5GSo2XIKIB2xrqJL0cx8SAet8Ayp51EqEqQONlSOy68SpBuIjxsNVVckWyJ+/UJeixIir8C6rE5wSZ55u+fWlPakOLjBf88eLYGvi/2jf1D97V/U1TLsnoEdqwOHyF6XWQysr5WVWjPun2zoTPGxyZlc7o+zRTi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKC2IwiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKC2IwiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB001F0089B;
	Wed,  7 Oct 2026 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362258;
	bh=2B5CvdFnSmcSL8fcmS5vCLIU01Heo4VGlA34Ax8Akhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KKC2IwiIFvUpmem22lrC5gP7q9SZK8/DPGKvU09kKvaUewybrFemfGYhjLR9Bw7bS
	 q2qdbfrdorhMOuC7KUL4iYIQU7utiD0Nqsx5p4sIYjTL+ZPA402vJ9xYQBlTc9AxXB
	 MQIL4gEz2loMrNtmIn2nmjCx8OgWlyC6QU7S8YctS5WvHMRoyGgadjGMKRSWG7MpZg
	 QKVdJEnzy0NNCZVZaetKrlfXGXl0+ERWsDMCgaS103TLnIAuPTj3ys7PzP0g+tgF97
	 d0LSPVOpbsnaOPgMfmFLJCLAMgMmv7+D8Ax4cgyZ5ko3wowP1S1iUwLBYzCxj/Ljik
	 QLOfkfJuEE1rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: discard post-EOF pagecache when extending a file via zero range
Date: Wed,  7 Oct 2026 04:37:33 -0400
Message-ID: <20261007074419.1640908-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100530-bankroll-devouring-733e@gregkh>
References: <2026100530-bankroll-devouring-733e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit da4fe97fb6c730d9c94a115c7bfa6f98e0d578d0 ]

smb3_zero_range() removed the pagecache only for the range being zeroed,
so when it extends the file the folio straddling the old EOF - which may
hold data dirtied past EOF through an mmap - was never dropped and became
visible as file content once the file was extended.

Lower the discard boundary to the smaller of the zero-range offset and the
old EOF.

Fixes: 72c419d9b073 ("cifs: fix smb3_zero_range so it can expand the file-size when required")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ sashal: Replaced the unavailable local i_size variable with i_size_read(inode). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index deed3b5e78065..2f5c446de223c 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3601,8 +3601,12 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.
+	 *
+	 * Start at the old EOF when extending so the folio straddling it, which
+	 * may hold data written past EOF through an mmap, is dropped too.
 	 */
-	truncate_pagecache_range(inode, offset, offset + len - 1);
+	truncate_pagecache_range(inode, min(offset, i_size_read(inode)),
+				 offset + len - 1);
 
 	/* if file not oplocked can't be sure whether asking to extend size */
 	if (!CIFS_CACHE_READ(cifsi))
-- 
2.53.0

