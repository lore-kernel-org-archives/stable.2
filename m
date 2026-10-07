Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B472602
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354312; cv=none; b=IXBrfaE7xKNhaMRbC4Mae0ZzaAVOg4ZImLllmIzyQrlbDvueegSzhiWahls7LTVA8FV1wzq7mrCy0eaFI3WW2aXEkGRVfLWjaE0TtqgCQ33icLoMdXMW7sQix0To36rjH2NYXcVhDDSlLT23QdfZLmvQPoXIUili6ISGShb+fkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354312; c=relaxed/simple;
	bh=/h8HWGREyjOGQQpB+VDq8NFE5vDcjzccgjjTxjAmA8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFUYGeZy6mrhZvb9bNYhSY3o5s8HaaPi05Pyyq9aNrtOo13EpH4MkrJGGkwvRyCxw41OoM2ZmkaNiaG5YPVMakdC13lzUHqAb6c+jkwmkl0aHkCaD1Ft3CEeMHQNGuB2FawrGyAmmkxinsPJ0Mq76sP9+8VkH5BhxAci12V2VPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSEvoqvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSEvoqvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A69C1F0089B;
	Wed,  7 Oct 2026 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791354311;
	bh=V8uwDU+mvAxXgpBF8vbNu1lMVx/UauJlzpbVUZNxim0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TSEvoqvFHsTP5+UemJ6S+nBb3BcOYfVN2ES+9MDwh0sYcpxF+Tq33u3DKn2WOjU/9
	 87kbvn9FtUR/J+2TbDZnU38iLA42bdST1eYFM7gGNQLNzhJ/qyzwbVHa+DeDwp8INN
	 XHhb8plFrmXmG+0Opu1wsbs3It0tLmhoUd6lhX/4/qWqgiAQEkic9NY1KTH6+d+1Dg
	 /1OCgwDCnbLT69XtDYNKedEjQbtAfMJsR9R12bvnD4R0YRFuV0rvSEoJsq2BebzXtI
	 Kd3Kv0DH1nu50z86QEbibN7ndPulMNTyjpQ+sRBzpGwOZWC+ZsWhayvAVRVQ1bcc+i
	 PWJeZiOmZPyoA==
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
Subject: [PATCH 6.1.y] smb: client: discard post-EOF pagecache when extending a file via zero range
Date: Wed,  7 Oct 2026 02:25:06 -0400
Message-ID: <20261007062438.1498433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100530-arousal-gigahertz-46ff@gregkh>
References: <2026100530-arousal-gigahertz-46ff@gregkh>
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
[ sashal: Adjusted context because smb3_zero_range() lacks netfs_wait_for_outstanding_io(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 973a46daa37b3..3278591b3647b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3542,8 +3542,11 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.
+	 *
+	 * Start at the old EOF when extending so the folio straddling it, which
+	 * may hold data written past EOF through an mmap, is dropped too.
 	 */
-	truncate_pagecache_range(inode, offset, offset + len - 1);
+	truncate_pagecache_range(inode, min(offset, i_size), offset + len - 1);
 
 	/* if file not oplocked can't be sure whether asking to extend size */
 	rc = -EOPNOTSUPP;
-- 
2.53.0

