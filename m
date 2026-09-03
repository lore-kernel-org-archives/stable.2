Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E994BD114
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447359; cv=none; b=IXQWoBvra430G+GRISPTbsxqY6O/MVRO/N+Qvbua+uuaXYDCTymLfOPEg9C7MgErphCUpH4WcIA6pVYWNTTYX2ecvdqQ16DKTImt3T0X3wRyz8S2GQHJtN3s4BI3yS+XG4UEwVKyuUg46LPvdNOcTc0D3TJp+TVOW0Z84WKink0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447359; c=relaxed/simple;
	bh=6g3UV730RHDAWaqbuJec83DENBQlwdmUhVv8e3XilUA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=divVTmbYaV6F9athykmdUYhx4hN1bxzbdTq5C2p8FopBuvSZ8cQMqiJQyoOnzgti9X0RbK/BvW0XuQ4At+Z+I1XNnBZBBTCKIfmoHr0AL6vGQqmBFhuAT9r2/skxvoEC1a3T+esx8NwDPDGO+Z55Yl3cZXo26xfnSGGEo4GTmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKZL+p5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKZL+p5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6211F000E9;
	Thu,  3 Sep 2026 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447358;
	bh=noXJBqjNHJ3WOGZJd8QO5gcPgJrM/W/iyIT90t3bsNg=;
	h=Subject:To:Cc:From:Date;
	b=SKZL+p5RtbL8z7tubx4HCxn10HQNRyvr6QANfswAEvH/2R9pCushC+ZMsQegbSsoX
	 toaoO0O+uE01xgIJysBjEVix2WdFGIgdf3LBt4QQNaFO0a7RW/cCSxRVSCMvFitDz/
	 BOwcG+KLlNyesoDcdxuZ45Bfk/tUn9/eDy3MrU3U=
Subject: FAILED: patch "[PATCH] lockd: fix NULL dereference on lockowner allocation failure" failed to apply to 5.10-stable tree
To: shuangpeng.kernel@gmail.com,trond.myklebust@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:32:51 +0200
Message-ID: <2026090351-sprung-ongoing-f2c7@gregkh>
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
git cherry-pick -x 4c7fc129db061c7daab841c4f3c342d894832362
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090351-sprung-ongoing-f2c7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c7fc129db061c7daab841c4f3c342d894832362 Mon Sep 17 00:00:00 2001
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Date: Fri, 17 Jul 2026 13:28:09 -0400
Subject: [PATCH] lockd: fix NULL dereference on lockowner allocation failure

nlmclnt_locks_init_private() installs NLM file lock operations even when
nlmclnt_find_lockowner() fails to allocate a lockowner. nlmclnt_proc()
then returns -ENOMEM, but the VFS still tears down the partially
initialized file_lock and calls locks_release_private().

That invokes nlmclnt_locks_release_private(), which dereferences
fl->fl_u.nfs_fl.owner and crashes because the owner was never installed.

Clear fl_ops before attempting to initialize the NLM private state, and
install the NLM lock operations only after a lockowner has been allocated
successfully.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index f06faf577cea..f8018bfe9c64 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -487,9 +487,12 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
 static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
 {
 	fl->fl_u.nfs_fl.state = 0;
+	fl->fl_ops = NULL;
 	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host,
 						       fl->c.flc_owner);
 	INIT_LIST_HEAD(&fl->fl_u.nfs_fl.list);
+	if (!fl->fl_u.nfs_fl.owner)
+		return;
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
 

