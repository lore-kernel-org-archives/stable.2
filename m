Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D585293EF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954464; cv=none; b=Oe2El+/+odN8ee8JRIvN6Jx5i+Ft13RcBmzw2q8kZbRFlLfus6VjiGuB6PRphYUB6swFuEZzCpx88Gw0H5Pvd2qjwAT88ZsRKi4LuZ+L/KNUY83uz+98APqTIBFQOh8kQjvwPYp99uV5JRx2vX/2las3d9VIy8UU5ft/jVXqO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954464; c=relaxed/simple;
	bh=3lL6PtbTI6e+Yn9k1Nv5F5iJXhVGmBCcUMFBnuSKYNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaIv2m/b+KggTI2ny/YaXgvLTGFotQBNu/p2QlVKHARu19MYVdnZGS9cBCAsV8EES7HTWPGhfZTYngO4ImTNoalyaRAWHAamUbtNK7A/rrPQ5Pu/cCTizAfhzf7o27fvKvNrJ7DcEs5EqboE9MXlUkHx7kB7jpB9Zo6C2HCIEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyNDwu0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyNDwu0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867611F00AC4;
	Wed,  9 Sep 2026 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954463;
	bh=psk+RY2uFzA9kj3TLXwA5d7nT/Eknu2nVDDf2XEwAoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyNDwu0mtgbFOrU5cwPol2fYel0VReppRtZls04mlZtwROxaLQdsdxtrpGbSZv/+q
	 CnL5eLP6g2eYig5MIKzbLxZ86uZWYvqHKkWcqPJYWifcOhxr9EkIjWNQfab3PzCMqL
	 qmK5lcNWOiqoCHCKEngXWm5eIVZSgG+36z+dyKIwjN6Hzpf9klh8AJ4VAZ/nUVFVhj
	 JDXUiHjwvEBgryF940+MV8nWUg+BWsYTxu1SnXvhzRnEM/6C163zWsd2JUAZitjmxb
	 uH/deTovUoyFc8QVhI/HBEBLkNwXkjWy0F6x09/41n+oriFoOZItTyBgP0W/HoD+l1
	 +i7oAWFldMgCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] lockd: fix NULL dereference on lockowner allocation failure
Date: Wed,  9 Sep 2026 07:47:39 -0400
Message-ID: <20260909114739.2012290-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909114739.2012290-1-sashal@kernel.org>
References: <2026090351-sprung-ongoing-f2c7@gregkh>
 <20260909114739.2012290-1-sashal@kernel.org>
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
index 32790a57351a5..bae25519771d1 100644
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

