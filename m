Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86B4D0CFD
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577340; cv=none; b=oP1bPg95ra8GAgN4S1a/hqZOphT6hko22ypGdhNAWsmORW3pT5hikkzSjaPP4g+tJc+2afJL1vbC9kxMKFdmcjIiruql2fOHyELuqEGYSxbHob9kJzFw+U2Ls/ECCTAKceIqeKXuHpP7tYoemdvYyTTOtbWMBBpCvtrAdeQ+2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577340; c=relaxed/simple;
	bh=NgXlNSygRekOq70AmjMQrvyrstf7mRKQ7S9NyxU0YFg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YpJHtnyGswgWD7tUAuTw7u2mswR1M+u4hQdjge7oPoLUiI3DqOABG36XP7/nyR1SoKCKdWMuHIzg0XX8HWEt5T2zMoFF50jQAAVDz2VrXyqGhMmIwy6sx4AxVub1ch6BU6P4G6TVoVY1PcFIv8Vc8icZ7y6juIt1OBs2R4uoKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxHiGHwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxHiGHwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E327C1F0089E;
	Wed, 16 Sep 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577330;
	bh=Ybq8IMmAtti39bb0N14NN2x8yn+4kbBmln1WBDMmerQ=;
	h=Subject:To:Cc:From:Date;
	b=UxHiGHwMgpZzixlQ6GbXMGw++z7YKAsQTLsCr+ZzWFzEa3Ps7ujeboaKDqXf7KHXR
	 z+4nAGdLv1oUKxGCTAUg7CHBkrbaqPKPfrMkXWhMScnHTWXI3Onz4VAuTijZauPk/C
	 EZdBasTAcJM4D4ns4ve0hcnhG5K46vTXrULGEmCM=
Subject: FAILED: patch "[PATCH] smb: client: fix cifsFileInfo reference leak in deferred" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,pc@manguebit.org,songl@zju.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:17 +0100
Message-ID: <2026091617-seventy-tutu-b0ac@gregkh>
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
git cherry-pick -x 5520e89a5a4f834bced64cf2ac927001cc513a40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091617-seventy-tutu-b0ac@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5520e89a5a4f834bced64cf2ac927001cc513a40 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Fri, 4 Sep 2026 13:48:11 +0000
Subject: [PATCH] smb: client: fix cifsFileInfo reference leak in deferred
 close

When cifs_close() defers a close, it hands the cifsFileInfo reference
of the closing struct file to the queued work. Each execution of
smb2_deferred_work_close() drops one such reference.

deferred_close_scheduled can be false while the work is pending: the
workqueue clears PENDING when the callback starts to run, before the
callback clears the flag under deferred_lock. A close in that
interval requeues the running work, and the callback then clears the
flag, leaving the requeued work pending with the flag down. A later
cifs_open() can reuse the handle and its cifs_close() reaches the
same branch: queue_delayed_work() fails because the work is still
pending, but cifs_close() returns without dropping the closing file's
reference. The cifsFileInfo count stays pinned and its tlink, dentry
and server handle are leaked.

Check the return value and hand off the reference only when work was
actually queued. Otherwise, use the shared _cifsFileInfo_put(), like
the mod_delayed_work() branch above: the pending execution already
owns its reference.

This issue was found by an in-house static analysis tool.

Fixes: c3f207ab29f7 ("cifs: Deferred close for files")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 27b58d907203..1aa4844f8b8a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1515,11 +1515,18 @@ int cifs_close(struct inode *inode, struct file *file)
 				trace_smb3_close_cached(tcon->tid, tcon->ses->Suid,
 						cfile->fid.persistent_fid,
 						cifs_sb->ctx->closetimeo);
-				queue_delayed_work(deferredclose_wq,
-						&cfile->deferred, cifs_sb->ctx->closetimeo);
-				cfile->deferred_close_scheduled = true;
-				spin_unlock(&cinode->deferred_lock);
-				return 0;
+				/*
+				 * Each queued execution owns one reference.
+				 * If nothing was queued, the reference of
+				 * the closing file is dropped below.
+				 */
+				if (queue_delayed_work(deferredclose_wq,
+						       &cfile->deferred,
+						       cifs_sb->ctx->closetimeo)) {
+					cfile->deferred_close_scheduled = true;
+					spin_unlock(&cinode->deferred_lock);
+					return 0;
+				}
 			}
 			spin_unlock(&cinode->deferred_lock);
 			_cifsFileInfo_put(cfile, true, false);

