Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A560489897
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954279; cv=none; b=nsFjXzTXT9qnK3XFxecvDvyltkxMF+SNDTtY/sBusH19i7mYsF2IQRjIfXsiekFuFVo1Mf07HOcXhuZfPS6J9EA/DrAsouULY49fDyoX4P/WZkuya+C/0MC3wem61K+Jf/yAxWJDZ1XyOwKRvwUSmdfXHS3d9YN/yJnGlElQMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954279; c=relaxed/simple;
	bh=Lx/jH9Hy+gGRl1bxsy28XeskAtLil0jpmeeAUAlJr3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qC07Okacxy79MqE3I13QTj5iOzcXo7XEmbdxUAOy2ENAQPCHHUYcxMNPkDJR2bV+7k3lj6UHp5Gi805mVWLWz5QzSh35l4G68Fbm0d7JT35dw6svs99p0E1qCESfmMv9PlzZPNX8u2yzmye7fv3ielqKD/SEcVs05xMD4TfEhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=coKyG8KW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="coKyG8KW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA01F00A3D;
	Wed,  9 Sep 2026 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954278;
	bh=23T7C4BYCth1gKW/pADuT19HIbQ/oYZVjtq4nQwdTQg=;
	h=Subject:To:Cc:From:Date;
	b=coKyG8KWpAI8BCG+a8+T/XZbHc1MEj+y6jwQo2hlJMia4BUJqP2VJ0KPFI4koIaTU
	 G0+ODXLd5PkAYTOo9hSySYTSHJ6Rx9Gb0Cu9cq8bj3HY2PResr8eCpvqtrQ/SQSajY
	 mfl0hX3+vW3JwCIBZJEW8ZAudqJitpYelSnWale4=
Subject: FAILED: patch "[PATCH] f2fs: fix to clear dirty flag on folio in error path" failed to apply to 6.1-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:27:30 +0200
Message-ID: <2026090930-scallion-geometry-8ab1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-scallion-geometry-8ab1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

