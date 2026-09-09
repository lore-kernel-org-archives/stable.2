Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD25335B7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954288; cv=none; b=pXdbGSjyfWeSCX95L6kD/9vA9MsPuhoL3xP3hlxTzSiFTEPP0X1XVmuGMUQ4ycFdOcyeIEwJ3wA2gh6dNJ67fO61uTasafwmUzh4D2xqwr/L3AXiNK8vtnIQVw5y7IM2FZLeUhRIYTq0mXM9hZqiZkHMyWQEA0iT8nIQsoaEE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954288; c=relaxed/simple;
	bh=0aePYre/hZSyDrjvY2JTyeTEaT0Ytiu6SIT3sf1ipdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BezJjCOpHlI/z067rzNMG4gSzwQ6UjVdopTTeY72CzTXCpbdXC10PdxbzZtJ0I5J8LPuySbXRjO30JH2LRaoL7/9wdHAF/mJrlqQiZ1Hkgw3wjphGPnYA59N5wGv9k/84BKeDVK6Ve++DTqI4aRqQSyc7hyC0JXRWxCzgE3QlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0yH181+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0yH181+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AF81F00A3A;
	Wed,  9 Sep 2026 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954287;
	bh=z7aDWbFwf3DX7TUqAlskfdEySOofBAZk4SDKdeM/lCk=;
	h=Subject:To:Cc:From:Date;
	b=p0yH181++vDB3x8iPWQebGTzsvWNfvE1yOqT42rnzYOyzuJAd/lMLifBdfnGzQvvG
	 eSe5x06ZY6BcPOi2MMeLRf9ug/SGAhrIDitwYcfeCbMPNdG1Bjy5LE1M5pA4FbeMga
	 X/zAz90aNF10um1lm6FyYJ8ov/MIZxKV14EBcHsg=
Subject: FAILED: patch "[PATCH] f2fs: fix to clear dirty flag on folio in error path" failed to apply to 5.15-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:27:31 +0200
Message-ID: <2026090931-unpack-bankroll-095f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090931-unpack-bankroll-095f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

