Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62E5476D9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953464; cv=none; b=icg9Zf+ggurQVzFPj6gmy5Rd7zCo7V+sWYjj326K6fIQ/f1LPgUuZ91OYbeyI2TtH3n/Mx8jQiQUSWejYVkMSWp3CZd9I+jW3giGH/QEHYlvjgphbn3Ins77F6Jciai/P5aEg4+yHRQIsOiVKBO3KrGpVBHoYl2DwBP7mRQasHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953464; c=relaxed/simple;
	bh=3lL6PtbTI6e+Yn9k1Nv5F5iJXhVGmBCcUMFBnuSKYNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc7OonTsM0+XUV7TD10RlzqrEAhKSzauWvCLxyUkv6k6Lbl++xsGZ1VcJGR2g/Sj6pAvulSWuuirxFUbZDX8EgPkzrjKMCjD/NgOg4NjqtcvZvtHQmgH8APBs3AU0sPn6RNuuCZN6OGcS/xF3s67C7HTO2cuPE7lyYkGHnPC3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXl6oGYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXl6oGYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8C11F00A3E;
	Wed,  9 Sep 2026 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953463;
	bh=psk+RY2uFzA9kj3TLXwA5d7nT/Eknu2nVDDf2XEwAoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXl6oGYyPSP8qQgGWQIm2GSPn5lg7AMOgvv0LMqPBBJlCKow/+cqG462z97w8U2QC
	 6JFcxPR6acm/1atXitKxq+RWEUIKKnsdK3CLeoM2YB4Mf8hURvfcQ1cpV0e0KG6mWC
	 ZRNmEFSkCg0tj1qFkNvKrvrVh03iaG6pmuGnfgcJxoLdVdAaiWwyGnivsQ56nedwIH
	 Q+Xkhrp9nEUIO6ZApwTR3QgZ809hfNlxyyp/rXZUi1ogalaWO67KLcCYP+PAMQhICo
	 c98q00Vyl9fWrVsmw4yn8eKrgeRfgAdUW++uMXVI+pAA1HaynO0pA/XnCl/XQAlrBB
	 Qm+zgHxTqMzCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] lockd: fix NULL dereference on lockowner allocation failure
Date: Wed,  9 Sep 2026 07:31:00 -0400
Message-ID: <20260909113100.1863001-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909113100.1863001-1-sashal@kernel.org>
References: <2026090351-duplex-next-aca8@gregkh>
 <20260909113100.1863001-1-sashal@kernel.org>
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

