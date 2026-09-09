Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B1530E05
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951263; cv=none; b=K+Zu8eP83uor0byh4xRURGPwAAq8v+ou8gDIOpVU8nA75zn5XlCGsRvj7EwFY1rsLomQjyonIwzHCjImD0ihikf6yPAxuQPyeNHJ9ZUz7UujttwvdVapySF9CNk/9kWC6z7irunCupw4ir+q2lyz1K49Um3QfbuRUfpEvDKuShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951263; c=relaxed/simple;
	bh=fsTTfnHQRtUYSvBRiiyTU/7kWFRmh7vaiicU9QQjtX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNIQRgQCUavAy0YRbCKDK0YZ06rUzqCNyPr0IualRz05KREv8hSl79OUjDmA58m9PpTfkWtspHLvdiB27+jmeAtywibl6211xPt5jEdDhA3x+6EF96B8b3KAdWw1QVi2ssL9a3DoUEB/uDc3CHQ+Omn8EbcgoJZ2La6irtTgC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8vbn6jX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8vbn6jX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C861F00AC4;
	Wed,  9 Sep 2026 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951261;
	bh=A9kxVVbuKbX4mfdY/DegnZSB7mF1OVpMqtIFpqh8pkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S8vbn6jXbmDXWVQNw3fJWlh1VP8cK51EYTyU18Ub3rPd/QnTb7fFvD0XR+DfTfy0I
	 y2ONTqiJ3dHpcMGCPB33MwD+AP5mbAkXUjjw3Gy1ch2vPgt2eBhUGp8JSesgNtNEMk
	 T+LUc9OOylYEiejv4KCj2U9wj6SOyYUT3TBUjpEaemdaQv5oLq+u7ZQmLTiEfkhcXi
	 msPuo7Hc6NO8DYxmBXXzKqJwtW92nR3G2+a2zUWRHndIgerpw/dmA1ZIPFT1ikdrgh
	 +oB2cGMnPFO8NbHatlTsfKBex0vnot/J4fYtit328dztfYYCE4LE/HaJkHFxCRGmEQ
	 vGud7GDQws7Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] lockd: fix NULL dereference on lockowner allocation failure
Date: Wed,  9 Sep 2026 06:54:18 -0400
Message-ID: <20260909105418.1620378-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105418.1620378-1-sashal@kernel.org>
References: <2026090350-anatomy-sublevel-d97c@gregkh>
 <20260909105418.1620378-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[ Upstream commit 4c7fc129db061c7daab841c4f3c342d894832362 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/clntproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index d67af20386007..9f4fb49ba7704 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -486,9 +486,12 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
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
 
-- 
2.53.0

