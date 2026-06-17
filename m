Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D8481FDC
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710138; cv=none; b=XwE/JLWV1H5CW1dEOXwRBmjtcAy4ro6sRhTw6bMmCJvVNBuvA1TccmOrTcRrvtiU2+brgW++QDEElhn4LTlbIFfpVPbfkmK0j8pOfESByOg45zslFCfwL5YJcjh5djyYSEU3lyIPZlHUsSVTc8n4DjJVPkRkzP770af+EGQ1sJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710138; c=relaxed/simple;
	bh=kY5uBKzy92M0xQRk15jQVGGEogzuIklmFX1woZmaJ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFu7hU1WZuQXeAzNhsFe5lNt4mmvb86ABkGoymB1Z0d1xm3zoqHAKEy5PFmw1dw7HSN7eLYEKPyv0gKSp/kNlDoAvgNtyY+pXMAX09TAqsssp85Gg9jAQjE/uHNlEMdgYz3bdjhZ/tGrHpnSJnbr474tF+Mwq/O2tCmwPRbVaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9h4dzMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9h4dzMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F23C1F000E9;
	Wed, 17 Jun 2026 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781710132;
	bh=TAI5W7rWKVdQn2SHzcXgDvkQdVH0V4r3TdxSk7wmnxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9h4dzMyzkDTt+SxlLLEiUoS7SL0w1Y1dhwEBPxFkT070FMhVYd2yoHwg3uvISDS2
	 juC4GJpbHEY+G0s0sY0BCr/a/7eDfBKZbWrXWpxmkKOq+LmZ+9nOMPjfF/PUqFl86Q
	 eLfX/picV6sQS8/+2IiYJVO2F9WxgG9dGOduK181KDNoBgbZCZ41dx1SMhTVP0isNt
	 H6DqL3ILghUfu+wi/bwth8YHzA8q3tgXdM/o25Zec3hUgZ2YDYTO5IsfFcwkFRzING
	 tH9qTjZnlS/TiB9SKBSzVQhNABUlN+Z9o+7UBkpvuD06X78qTdzye9OaSsrXQDfgfC
	 lHzeHogOhZ99w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	stable@kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
Date: Wed, 17 Jun 2026 11:28:49 -0400
Message-ID: <20260617152849.216990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061527-overjoyed-wool-2466@gregkh>
References: <2026061527-overjoyed-wool-2466@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c ]

FUSE_NOTIFY_RETRIEVE must be limited to uptodate folios; !uptodate folios
can contain uninitialized data.
Since FUSE_NOTIFY_RETRIEVE is intended to only return data that is already
in the page cache and not wait for data from the FUSE daemon, treat
!uptodate folios as if they weren't present.

This only has security impact on systems that don't enable automatic
zero-initialization of all page allocations via
CONFIG_INIT_ON_ALLOC_DEFAULT_ON or init_on_alloc=1.

Cc: stable@kernel.org
Fixes: 2d45ba381a74 ("fuse: add retrieve request")
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260519-fuse-retrieve-uptodate-v1-1-a7a1912a37f9@google.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ translated `folio_test_uptodate(folio)`/`folio_put(folio)` to `PageUptodate(page)`/`put_page(page)` for the pre-folio page-based 6.6 fuse ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7e0d4f08a0cf5d..d7b155f9473d0f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1714,6 +1714,10 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 		page = find_get_page(mapping, index);
 		if (!page)
 			break;
+		if (!PageUptodate(page)) {
+			put_page(page);
+			break;
+		}
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		ap->pages[ap->num_pages] = page;
-- 
2.53.0

