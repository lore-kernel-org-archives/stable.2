Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685895335B7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954282; cv=none; b=pX4bGvd7hfrlto9eYmilemI+QQzimiJjwVKH5EQ3kuFwlxMGYAmzklUnrhGJmr8ym9lojk5lMcIzCQLrXVGZkYgSIWaBY/lNjbMFzM2sM+ofFh6juQzAGZYUB/qf+CFaQB5fVxjjSB3N2+X92RtQbzFoysSlrbPLacyr1w9T4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954282; c=relaxed/simple;
	bh=SclQ3fW+O+gSfcG2a4YWgPO0NxlJy+o6bFfkSrIX+gg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L9N/5dVSP0a/oHO7nUYdE3A0OR7PQXmqqGISMZ98p37EZzIqBciNj7tYn+jrkrlNSQ2EiuOL3CtYTXV7E5ON5ALs1qL73AS2ObwQFbYP2cJ4hx838UGdbOv7GzeltCY5zXedFq/qit7jOo7hsFTgVAVU1Ggv4jMJC7Q+lxk+szI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zKoFtu18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zKoFtu18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49C31F00A3D;
	Wed,  9 Sep 2026 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954281;
	bh=7B0LxEquNUVVDTd+KADbr41B79/IulxyyDILCWsbCKA=;
	h=Subject:To:Cc:From:Date;
	b=zKoFtu18KuT7PS1uo7YKd8NdmNgmHeDuNiST88Gj4VnMGQN/q05D7SzvoSfSUAGPy
	 i5nG2EXIOJO75aUFTccCrR20dvuKpMKrTLr5AzxELWo6TQpg4WgROUKbRzQJw8g3IV
	 y/+ZJzxyY/VFaoCdyJ8HNOmHSD8M72dqjQvO8Gwk=
Subject: FAILED: patch "[PATCH] f2fs: fix to clear dirty flag on folio in error path" failed to apply to 6.12-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:27:30 +0200
Message-ID: <2026090930-yummy-brim-dc39@gregkh>
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
git cherry-pick -x 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-yummy-brim-dc39@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

