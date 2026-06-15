Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC840629B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537625; cv=none; b=l0SVos+UADcQW/CeumvAZBqWCfygnM1a3SdLVvDHpGa0hPOuldiXAss2CtxXC5HbtmB3x6+Js/Ae//d9tuC1HpmfBXfkhwgtDl1ms7MOFmTQG1+4kS/NvShQNmhiuzGi0nawNLshq/6k9hAtukGOk0wmVToYceP1sF1uOoNi2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537625; c=relaxed/simple;
	bh=2H8F6aNCaZGWW2sAb/Jl8vm22pnw6mGkhLlzLaWBhBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fx/tTcK81gHUnoMmQN7b0yF2eC9oXx+1fSGRtFEblvunjapLAJZEQL9qb0c94RJ/+QpAq/ymUyPS3dzZKPfnIPLCDgkFCa1r9HN9enEfgKRQpc0V4sSKdKFAkQPtUFmiZDX2M3lcnRAR/a/+MhqbIa/t+WX1NhIlbZ40UR9OyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cPiqNbxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cPiqNbxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4CD1F00A3A;
	Mon, 15 Jun 2026 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781537623;
	bh=wrx9rt3ts8A5gDDak5Qlp2vwjBkryLaU1rFbhxpd4do=;
	h=Subject:To:Cc:From:Date;
	b=cPiqNbxx01/F132hTxLmJPXaV+Q1GCYWqvMXFYOAUFzTfxamMuOgVfwYe+FPsYQLm
	 Ri1/6HRiwToFTa7aPhWhpFu5xm7K/AvM03U63/Pcr1BxqRUvHVRTXEIjDa5yHB5qoA
	 IxOzgY82/WomU34ELCG9Myd5gwio/wk8QT3uTFUk=
Subject: FAILED: patch "[PATCH] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios" failed to apply to 6.12-stable tree
To: jannh@google.com,brauner@kernel.org,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:55:23 +0200
Message-ID: <2026061523-blurt-traffic-e169@gregkh>
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
git cherry-pick -x 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061523-blurt-traffic-e169@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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

