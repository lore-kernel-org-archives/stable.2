Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C22E7F38
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708443; cv=none; b=V5hsR4ZWUw/eg33Te0992mSzLsJW6e2xi9JANZ8sK7XvmhFGFZNjD52xjmpq9E2Q5e4SmAwW70effdDhJ8cbYPUGpfledCzPHOyJiYfhaQHHlcRJ/7Zb4dKfO9PpFdBTqFBuoiP4OLr2PK6MtKFunk1FUADLgnSx9dg2PE9AcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708443; c=relaxed/simple;
	bh=op71p3I+zyvqW0SMNbKNQ5LSDX+X++0u7+WxMaAJnnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qH2Igwmv+emakKn/WQp8beqNiRf0mW5ZCSUG9YhkIJVvZxCJE0emTRbepUJeGUPL1n++cQmUyespXada/hJwJXzGdDS6mHL7zIqfnpChug423Qn69bxV6XHCVdWBsLRanB9cJu6rqdsI0G3yUnB7Rq/nEr0Gxr4+FlKfmvwutL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhipSx7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhipSx7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F59F1F000E9;
	Wed, 17 Jun 2026 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708436;
	bh=A8oq8IYYmsqDMsuy8wa0En+W7vaPCZkNLRnuI+Z9CoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IhipSx7YLHZrlJdDr9L+QjW8Y3NrkbtrQd0xt/07cB6hYCBJja3p4KjmC4X5ofNVV
	 cCldMLnmuALBvqDp+TRfO2uf1IF4PXAF9T3C0F4EE+pWIpcm/2WkZTYgVMnvKaCQnr
	 mybt06L/EISu8fYqLAjgbKXUrCCO/4Tn5nTuI8Fw2yHEkLZbXrcxEP1rLWBw+AL30X
	 EpP8gY5E+FwpsmzRp7N5BAi7NeX/t16atsR31dZsBqSH0TjkRHe1AP/c5wAUOQ34EG
	 QQnz0Fu1n51/Fs0DfgD4fGXOYLIOVzWNoxa/ZS0dSATSH7hiUiOkDXBMtORwS8ksiS
	 Lo1Ypl7cel3pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	stable@kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
Date: Wed, 17 Jun 2026 11:00:34 -0400
Message-ID: <20260617150034.208494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061525-banshee-overlay-7405@gregkh>
References: <2026061525-banshee-overlay-7405@gregkh>
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
index 7573dcd8f5d442..b9d6e03f8f7f45 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1718,6 +1718,10 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
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

