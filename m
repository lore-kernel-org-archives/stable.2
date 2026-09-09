Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE225476DF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954042; cv=none; b=I0vaX+MnlKLR0itHKXRtByu0Mtcc0C5pmlSxbuX52U2gqxofsO52mDj+A7zEVeRSNmcvASo0azoAVZPB0g7bdSF/GNCMAvTNrNlaYxi74KYhYLw4xnbOZiu5hj+ug7Rglt0F8brw5ZWZmObjFbwVmw8SAnrjDpw+c9r+uCrDSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954042; c=relaxed/simple;
	bh=iMWgsiNhNtAy3CsjVgxRhkN5xtlJDMlDR99fEcKUTJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/xwn2DWW4pE7ZTVw61ErTbQDHPhynDRCKc4EZNd+p5ntgeHr9oh5irol+ahtTtgsOQVVqSx9YCWnsz0uwTHyLH3BH8Gu83EBso2lKzLqjtA43JBXLo1DzO9Z8gRrVChc3M36lXcDQegohf4RwHwNdYLWKn4grbDPUI3EvbGqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8aiT3EQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8aiT3EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55431F00ADB;
	Wed,  9 Sep 2026 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954041;
	bh=0wIdoZMcYE7tkpkzR1hyuCD7vjuKYe+UV4njeSanUo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8aiT3EQvm9FyeMTqiao6wN0B3KVV3aF9g07IFQoq+JnzJvAxAKRh07IeKIMbuEAo
	 30WGpKWBPt9mQEKuatbdJCIdqrCKmMPUuouBqx7letCmOyaq0iqLd2tsqmD07nfvY2
	 G/KmRaxFo1AC+i9PKhZMjCCv2+dQdnv0Cx/dmcIk+N/mtlhRD2wRcRrmrE62rnoIur
	 gpFj5LBzCQoL7nJ1yK6NSSn4bwCpKGm5TV0KIX5kfQV35fcknEsDQu1MeT+cDkX0gm
	 OjrhI/F4NiaTi9H+TjWRUpZPoQyjkkMRByu84gUXSfaCLqV2MvarORImCx8QggceLH
	 r97KrOvdy7McQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] lockd: fix NULL dereference on lockowner allocation failure
Date: Wed,  9 Sep 2026 07:40:38 -0400
Message-ID: <20260909114038.1915471-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909114038.1915471-1-sashal@kernel.org>
References: <2026090351-huskiness-ecosphere-5753@gregkh>
 <20260909114038.1915471-1-sashal@kernel.org>
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
index a00729a9acd58..0e2494f9ed018 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -479,9 +479,12 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
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

