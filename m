Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EC34041C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003576; cv=none; b=SwKkA2gCj5/ksGYJDg+o+y03JOYnjJqBK2iA1EsgEMKBc/yLpsjTeecYsqREB4m1BdjcfMvEoraXIPefdnq8ONam3k0Ddh90eie0zJ+hJeHGv1xhPkc18rk1r/jvM/rNWxM1EaB39P2XaytWgCfNTwV+7+cFecJOq0xdNoJXZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003576; c=relaxed/simple;
	bh=qXJYBYOOE0aUyiGhgPn1MiwmBpFXunIlQJnxMVPUiaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv7wKWWnYUn/fUloC0TP0zvPAfSgSRIyz1il6GxF1KAp0iOwcZHQjNkB34FBSAlwawz65QcVLGqO9ewuoNMzAQpecWRXS0VvWiJ/5s+vELykgUWcVYqawVqakEPqhR1fhldyOB6H3cDoPosGeSsC3mpgxa3VkyihCGTQGx86jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY9N8om7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY9N8om7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B01F00899;
	Thu, 10 Sep 2026 01:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003574;
	bh=8uI0Sw49eiXeoQcPCbxLRRAyCB4+KnAZpG9ALNWb4GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UY9N8om7rN3Ga6izfSUO1VXHoNR2G1WdNladmZJXp5FXZ1R6yt0KmLq3k86TIEDjm
	 vu+aqs0xDcqjhjVot8QlQPjc3YXdQEQJiUzUN7g9WJmD+DTg0oXAx6k0v3pv1rYkUO
	 d6acoeW622iXgSZK3eS+Uw2Ilk5Jeyxo3HUcz5gj9tIFIuQc11nNUKqRCpN6v5yEix
	 Zy/LBf6QW1Hl51lzzV/WBQPAhZTdaBUvgs4cNPqLSXY2DcgxFnVdcjdZVrWapGLbU+
	 jVEIGmfc+18pspTqZln1IZMWkITRCKWlQUZbNfVx8lg8oey2Qj3CliPstHTX44PTGf
	 htigcEKphO3QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
Date: Wed,  9 Sep 2026 21:26:09 -0400
Message-ID: <20260910012610.3866859-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910012610.3866859-1-sashal@kernel.org>
References: <2026090803-refract-segment-1a96@gregkh>
 <20260910012610.3866859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirbhay Sharma <nirbhay.lkd@gmail.com>

[ Upstream commit 5f33da04e6ceee849e76e6592cc283c72fef7af9 ]

The call to kmalloc() to allocate the attribute list buffer is given a
size of al_aligned(rs). This size can be larger than the data
subsequently copied into the buffer, leaving trailing bytes uninitialized.

This can trigger a KMSAN "uninit-value" warning if that memory is
later accessed.

Fix this by using kzalloc() instead, which ensures the entire
allocated buffer is zero-initialized, preventing the warning.

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b2791327af22f..162a6c038000e 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -826,7 +826,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;
 
-- 
2.53.0

