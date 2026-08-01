Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8EF2D5C7A;
	Sat,  1 Aug 2026 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552118; cv=pass; b=rCNfj1EV2VnAt36LFDBPmBTte9GogpWWKFZo3TrGPwP7qjT2ywqe8zk9O0r8wSIjVrFR+IAQuXEBWbj60YAOTUDjq7033QiIy4NwqI2yk8QZ5UusHlKkHPL6Hu470uhtirjY1OjbX55WITz9+sE9yU5ipRhHt/R+0ZUWJ+hI9HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552118; c=relaxed/simple;
	bh=EapoYmWFR1Lr7ijOmRiCGMrG6LstBbrxnWHl6GPdOe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBVeTJYfK5hWPjd5Zj9RCO2r3bJv3luiLXq2rlBCa0DlQTjlVrBsnrYFmanoSMHtYh+841LqACq4Us26rTeq9dpBuhMYelqpQGof69WDfPWdo+P427GCVme2F0J6fxs1gFQaJsiuRFAr7Jc3qz2bA9ZuPLbvqbuoOMtCZSYaVEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=o+99sYGm; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="o+99sYGm"
ARC-Seal: i=1; a=rsa-sha256; t=1785552093; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QgwyDK4jrQ5DW8Nzsoa6y62w8s7CHFw+uUD4tpN8HcSCJ8A09tIvz979smCZ/7J/r4Hn6ZAQjiu6xK1P8EK0YPX9MgmTACDm8fO6e6lbA3AdQyU1No034bdOKAp9VVXpszs4C4rkImL6x1gYb4uCIjin2kqdfhGtj4tMy3JmgLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785552093; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h9sCDqMz67BbguCi/EqlH+FdXmbSceD86Pyt3Yba/Ek=; 
	b=Rpx+6glyl9Lp77HN6he8Y/0qks/KI4FkIqnPQ55N+Yf/3o2lqGgZHns6g4JItqF7pFJFC+LwkIaJJHRxqx/gLO/7F2lbYm9G9WDYgtnqFMZB5HQBKzPwvhzocSTXBb8zIVnhjVZbpCBtIq+VoRxIH0yNhbQxaWbYBR4Wxv47rME=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785552093;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h9sCDqMz67BbguCi/EqlH+FdXmbSceD86Pyt3Yba/Ek=;
	b=o+99sYGmA8VCHQFjdK20pVllfDiWe+sB++Af5UVmV2rWD93HrSUQZjAh5MXWg0jP
	PGqWHUsUbUve0HY18F40hiCH/qL/21E3Nqu3ek69iTgaqmB30btMksjp6Z+Eq2Tc+oK
	lejoE2Qqm2Ex9lRI/Psp+mXoRMVBoGFncqXoKsA0=
Received: by mx.zoho.eu with SMTPS id 17855520903491011.5105750643017;
	Sat, 1 Aug 2026 04:41:30 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Luis Henriques <luis@igalia.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ufs: free the buffer head container in ubh_bforget
Date: Sat,  1 Aug 2026 05:41:13 +0300
Message-ID: <20260801024119.12667-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ubh_bforget() forgets the buffer heads referenced by a struct
ufs_buffer_head but never frees the container itself, unlike its
sibling ubh_brelse() which calls kfree() on the way out. The only
caller, free_full_branch(), allocates the container through ubh_bread()
while releasing an indirect block during truncate, so every fully
removed indirect block leaks one ufs_buffer_head. Truncating or
unlinking a large file then leaks one allocation per indirect block,
which kmemleak reports with a free_full_branch, ufs_truncate_blocks,
ufs_evict_inode backtrace.

Free the container after forgetting its buffers, mirroring ubh_brelse().

Luis Henriques posted a fix for this leak in 2018, but it was never
applied while fs/ufs had no active maintainer, and the leak is still
present.

Link: https://lore.kernel.org/all/20180705150415.25070-1-lhenriques@suse.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/util.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index dff6f7461..3c65fbef6 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -117,8 +117,10 @@ void ubh_bforget (struct ufs_buffer_head * ubh)
 	unsigned i;
 	if (!ubh) 
 		return;
-	for ( i = 0; i < ubh->count; i++ ) if ( ubh->bh[i] ) 
-		bforget (ubh->bh[i]);
+	for (i = 0; i < ubh->count; i++)
+		if (ubh->bh[i])
+			bforget(ubh->bh[i]);
+	kfree(ubh);
 }
  
 int ubh_buffer_dirty (struct ufs_buffer_head * ubh)
-- 
2.54.0

