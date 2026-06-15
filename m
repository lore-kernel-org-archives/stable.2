Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BCB3ACA52
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537656; cv=none; b=XQFxeQFXZaiVHWwYCX8rinZ2ftWsy9gI8ZI25LIyOSAZ9XLgAwMe6ehKcd5zZSs+qXdxGRBgw8HJiuhHlAMlXHZXvoxVTvecQOKLFpL8HN26tRPZvdDSa2HsRLD/6qtDFIPqAlFaNeoCC7G/czWIyES47DipH4sdBgpDGnb7KKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537656; c=relaxed/simple;
	bh=+K3lWJszTbNI52o4L/hC7wog5/Bc71btM3vuw3r9dws=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NfGV24sDixJDTwlGabMXok68uZcokyVyjCXpy0uIodcctrW4j+zYqnWISjk05c3DSfboou5t9l6G+3hSav8/SDwa6mWp6jpdDt+t/gzsz8DzPOggC6QwD7I6SWcD2+5wG+4czaZzoQbT+YmUccmT9f0fZ9uJEXB8Q/PfS2LeEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2hm8vNww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2hm8vNww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8E31F000E9;
	Mon, 15 Jun 2026 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781537655;
	bh=FDmKe+92WhVOwL3PGEppCYFoucgnDOKjxtHubkp+dnU=;
	h=Subject:To:Cc:From:Date;
	b=2hm8vNww4mAyY8MidZRRU3/NeudevAFmc4UZSS7CKqN8jMQXw5hQh+1jeHCJrZf3G
	 exjB/4a8jvWBoBk3Jfa03zObNT8ebMW3SQJ3fqEAO8EHAtz3+lhnLAaav+bAkNk4L0
	 LFPP1P3mVp0eEUBUnpOrdsLnihDCGyjU0QFQCiJE=
Subject: FAILED: patch "[PATCH] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios" failed to apply to 5.10-stable tree
To: jannh@google.com,brauner@kernel.org,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:55:31 +0200
Message-ID: <2026061531-salvage-winnings-04e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061531-salvage-winnings-04e9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:40:34 +0200
Subject: [PATCH] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

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

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..08d364ed7d6c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1912,6 +1912,10 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 		folio = filemap_get_folio(mapping, index);
 		if (IS_ERR(folio))
 			break;
+		if (!folio_test_uptodate(folio)) {
+			folio_put(folio);
+			break;
+		}
 
 		folio_offset = offset_in_folio(folio, pos);
 		nr_bytes = min(folio_size(folio) - folio_offset, num);

