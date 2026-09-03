Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A64A21
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447353; cv=none; b=QRI/efph9UF7JuSPzigM/3JWvI8CFeYWwOUClug9vRpc1+Vw1sFrzOuDhxVaeyYFySgo4sqaQAjy2RNK8xyLcNmH2aygC26tDcEmH2NawZ8ckNdiavjAyQse4d2KCatsF+M4Hbfm1Fg/qtLqZj96tgs4Or1QkztadXMIdSX/bEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447353; c=relaxed/simple;
	bh=WO0WZI/1g/RmWLY9WEqRINtfp+s1NmNE/9Q8wcysCuk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k05KnwKQNAfEXaFecS+Dh7WvwXTQZgHsEh10wqwzhowbN76laxwjoqn5hZ2Xx5/3OYIAfwMDzuXESJqccDKu+RFfhMoUwBscn+dcjlzGBtqW/oUbKyHnEgwpXY0/K/cCAibiCzVX2/aFHrBv88F3wT595hVgUUQ7s7g0sKovI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3HHF7D2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3HHF7D2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0B11F000E9;
	Thu,  3 Sep 2026 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447352;
	bh=n7NJIvu935NrXuWfk6ogA6pA29OngLmJ/664NOHLhl8=;
	h=Subject:To:Cc:From:Date;
	b=D3HHF7D2HYkrle/T+/gpt64vd1F/r0o5TutSPJhmAWVdZCK5LmYho7ksY72SIBltv
	 q1XHUhpSrdyJIEONYBsLqMt2x5zYCrR2gvcBZeV6qOaEqpDax5ydV4evu5/7KrnHV8
	 ApMZN7WPsmstjg/le1rxaOmZJtdLar8Aaa+3vLOo=
Subject: FAILED: patch "[PATCH] lockd: fix NULL dereference on lockowner allocation failure" failed to apply to 6.6-stable tree
To: shuangpeng.kernel@gmail.com,trond.myklebust@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:32:50 +0200
Message-ID: <2026090350-anatomy-sublevel-d97c@gregkh>
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
git cherry-pick -x 4c7fc129db061c7daab841c4f3c342d894832362
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-anatomy-sublevel-d97c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

