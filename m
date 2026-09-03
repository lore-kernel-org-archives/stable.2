Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70444B1B5B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444315; cv=none; b=W21+aoo3DqNXVUwh5fO5QYylwVW2mLogZm9CpUD9Iq/39EOHXMm1T7BetO3k5Bf21+MZDlkB593uN5lf+i9oQRf2GszulWNqjfx1mJOJO7ZVPXxQEPgAsTLEmUvTGHjUCNPmqohAyC3kJR0inRnyCwroqMUHdOoNmLYBtfDm7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444315; c=relaxed/simple;
	bh=gYROgb+ZUGAMwRtkDijifjm6OtbiS2NokPfOKJbrjJM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IdTHqbsuPnRzXrGpTACtu82jh4zTPhSl9lfHghbzK5s+MIHnD8rOnaCFf7I6Yhhyk+dhkPnTXXjUtmdPQfNxTPaQilGV0KmH1Q84pAf0Tyb9JJA1Gvvqo4mdomsVTOGwMK46HBFwl29KSW96+UozSM/R7HfqvzOJGFSiMP/yhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sw3Ax90M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sw3Ax90M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAFF1F00ACF;
	Thu,  3 Sep 2026 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444306;
	bh=QXNP/U0BzuvhZmhbHPw5vFyOsCODXO0Dvl4pM3eikwY=;
	h=Subject:To:Cc:From:Date;
	b=sw3Ax90MH5kw8L4LdBi97hiyVuomzHdySOl9YxZq1WhnSTr0LesZ5aeg2LefAHKZy
	 Fj8m+/QeJPIZVISxoY6GNHl4XDsSY3fizwLBeO4eNSxqczsPBTTy6QjEpXNkq36gcL
	 ITQzOYqCWze/eKVAI08K3oPIfzlAD9qJzxPwny5I=
Subject: FAILED: patch "[PATCH] erofs: skip sufficiently large global buffers when resizing" failed to apply to 6.12-stable tree
To: nikhilgurudasani314@gmail.com,chao@kernel.org,xiang@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:40:46 +0200
Message-ID: <2026090346-situated-earthly-b396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a7d097cf01301c5da37927c8f26123d006f0fd8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090346-situated-earthly-b396@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7d097cf01301c5da37927c8f26123d006f0fd8a Mon Sep 17 00:00:00 2001
From: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Date: Sat, 22 Aug 2026 19:30:17 +0530
Subject: [PATCH] erofs: skip sufficiently large global buffers when resizing

z_erofs_gbuf_nrpages is advanced only after every global buffer has been
grown. If a resize fails after some buffers were enlarged, a retry
revisits those enlarged buffers.

Retrying the same size then returns -ENOMEM because alloc_pages_bulk()
has no pages to add and the unchanged return value is treated as a
failure. Retrying an intermediate size allocates a temporary pointer
array smaller than gbuf->nrpages and copies more existing pointers than
the array can hold.

Skip buffers that already satisfy the request. Once all remaining
buffers have caught up, advancing z_erofs_gbuf_nrpages again describes
the guaranteed minimum size across the pool.

Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index a0ce9226bc02..6b9bfa2ef3b6 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -79,6 +79,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 
 	for (i = 0; i < z_erofs_gbuf_count; ++i) {
 		gbuf = &z_erofs_gbufpool[i];
+		if (gbuf->nrpages >= nrpages)
+			continue;
 		tmp_pages = kzalloc_objs(*tmp_pages, nrpages);
 		if (!tmp_pages)
 			goto out;

