Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D315328DE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954276; cv=none; b=SDI7/QTd57E10WJ2hsw6eZ/vYY65Kvtv6rAfFUmMzoQ/4sSIG0eYRkQ7uEjQrBIV/rdU4E72FXQ8uc8QN6fQR/no4KW630ASkxEGvL3cKhZqXfOYSptu66caQ+whDDoj0yv5BevBfhEEdZgdgEb69AIxiwSGl3awRJYG5c0Oh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954276; c=relaxed/simple;
	bh=yxwxlYzd95WczP+NvA92EFxtjlXDY855nrCuJZKjFZg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=auDOpav6uem3iLIqYMjCEo9tklHODgoBmsPTmRFMlANPH8X8LZZcnWF/Mq0AALUQBHUCB/9oO/lttKz+3pJN2JUlopHLF76VNm42k4KAfA2WkSxv2eK81f3124xXpsHtc9NtzvCEl4o2EWsqOTqZEzVQOnaT2fan51DbMn4iIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kcwi8wmr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kcwi8wmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1560A1F00A3A;
	Wed,  9 Sep 2026 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954275;
	bh=WDAFrzGl7Y8Pp92cNI+Ja/BMkRFzGA0Gj/pmM8mls/4=;
	h=Subject:To:Cc:From:Date;
	b=Kcwi8wmrBqT5KQKs0bC9UMZGzxRW36+sJIdHfCg+bsas1lKafqldu8d2uEm1119Rl
	 rloBE3N8iWwbRE87l9K/9SmvMS1zn++7NnlzoZBHTNkzDM0gnLPzsPelZ6QCQTK/iF
	 XEy1uGS2VQSBklTTDU5Z7b2RRIeBsFQUFrlIOeMU=
Subject: FAILED: patch "[PATCH] f2fs: fix to clear dirty flag on folio in error path" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:27:30 +0200
Message-ID: <2026090930-constable-bacon-8c5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-constable-bacon-8c5d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Wed, 5 Aug 2026 12:29:20 +0000
Subject: [PATCH] f2fs: fix to clear dirty flag on folio in error path

If node block is corrupted due to chksum mismatch or inconsistent
footer info, it needs to drop clear flag of node folio, in order
to persist inconsistent node data to storage.

Cc: stable@kernel.org
Fixes: b42b179bda9f ("f2fs: fix to do checksum even if inode page is uptodate")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9775fa90636a..a98855b8cc5e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1618,7 +1618,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!err)
 		return folio;
 out_err:
-	folio_clear_uptodate(folio);
+	clear_node_folio_dirty(folio);
 out_put_err:
 	/* ENOENT comes from read_node_folio which is not an error. */
 	if (err != -ENOENT)

