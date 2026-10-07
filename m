Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDB347BD4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351437; cv=none; b=eOtzuETu9WpuQt6CdAo4A07m2zRY0e0nQYf5bQ4+V9Hms/cIErZ1/omWB55J0iJf2APRNdU+8KYXkdkoqw8ZdzNIgQX1zURy4IcdCfzGQUG6S7lOq7Jt2SlW8Shs2ebJBahWTBNx+RLf6GDcPWdgM7v6JJG4/NUTrx9dJ7h0+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351437; c=relaxed/simple;
	bh=d9PCGZ0HZgzDcb2rdEIa+6kWUC3RLrei+iGP9os8Nls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8WFsxdiq70/5fKsEziOCMuTbHkJ2BOrtfuxrSNgn96vbIJZEcbD7rtaRdzFPKGHy9rrpq9KFHkGFkyac1jxohkzTWlm4epuYJFXb9cZkH4KMglOe7OIGVmheqLxAaFRHsK/gZ7siumwUyCjcwHxnN7tweFdBZVsQZh1LLXuD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJCb9DwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJCb9DwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE6B1F0089D;
	Wed,  7 Oct 2026 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351435;
	bh=n7fJM3rJUP+JT1Qa9H1s4y+DvyieCJY3Od4wMMXl8X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJCb9DwMV6mnjsaNlNZJs8GCmhGEbLX/a/0VPCFg9bR+sm1+Gb7WjdQmRMoZfDMhF
	 8BMWLyyiBaX9t7gH7w02U9I2vrpPJgO6MvCHdAonfTpc+XlYlxftXV4eLI5Xeu4Sur
	 XWjQSVUOm0ywELOiMcnfBoZrfpXcNtM2B8sRRE4XkojPCf3v6KG2oOlerioSPAD/8+
	 J2l/mxIpebCHee/gmwyQMa8RVIH8yh5CisyM8ZlGTP6jqEkliOyl/FZ4Vg+r0jADUi
	 6ZRBfnQA5rBfS3yLYtT1lddnOPsjqX0Ojrwf6xvOaIc5gr0Ug6gTuwmzJjEf9OLO1L
	 MDJAOpQ9BBkdw==
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
Subject: [PATCH 6.6.y] smb: client: discard post-EOF pagecache when extending a file via zero range
Date: Wed,  7 Oct 2026 01:37:11 -0400
Message-ID: <20261007052613.1248093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100529-sludge-wasting-0d0a@gregkh>
References: <2026100529-sludge-wasting-0d0a@gregkh>
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
[ sashal: Adjusted context due to the missing netfs_wait_for_outstanding_io() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 887ffa77aa183..a82abe2e8ce14 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3283,8 +3283,11 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
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

