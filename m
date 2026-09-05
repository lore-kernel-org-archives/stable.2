Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2E2E7387
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569491; cv=none; b=FiBA05yviZSHqbL+dCP4bTCOfTKbxYmAc5zGi+GX1d7mfsdJu9NGB7j2xLeCFtBWWQwcVq7jg80fsUK3wE0W8x1Xsz3AJZGZihfZtu6qTZi5eR7QdPF4vyRPobSw3j0N9+M+mVUu0BFFPUdDF3ylWwlZZkLHAz6U4FNxxq3c/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569491; c=relaxed/simple;
	bh=B9s117peaLpLDjKhmYADReBwl3MYrrMyCJl3bG2zlRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpPiEzm/WlUu35hXUpmbAQd4dlhIFLsCTx1WVXO9jIFgcCHsY8BOnutdd67WL8jmzwbQgZjhPmLy7YkfeKJcsadUy2XusyXp1zH9kuXbhR4zugyYemSiFo0ZQR66z9/L11JDbqWCOegnlzGymD00JpH2XAJq1WYX3hYv8otop3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akwonQgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akwonQgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249581F00A3D;
	Sat,  5 Sep 2026 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569489;
	bh=3P29lL3P3kr7xVztbmgeN+ASOFbJhamfcM0iungC10s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akwonQgYtkRGEie8uyWiQyS9DaR5L6QGNoU8D/93SHqRZCnDLw+TYD33OSShCnLiM
	 Hbtmh3Ao//UqZcyjE9Dl0cinXlgxYVoYKUft+uP/cVAojAmMAf/2M/BHqqQJ56sVBD
	 jQaGsDLe3wyQR/NAGo5TOpCYXVwxcsbjxsfohSFlUU+gQPuVavUCTgzINbkXuR2R7l
	 wEzVM2hPOGJD7qXwSrWs8GvdQ7sZYFEDO5GrBZ8qsmCY5F3XQTQ5plePtzO9ivE+6s
	 dYHbh1O/3a6pkSR9d1K7AMeMKXtGqSBhbKpj5EJivRUZxWQWmMLM6m+tOxE/bBql/O
	 jQaBefze3s84A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: release path refs on follow_down() error
Date: Fri,  4 Sep 2026 20:51:27 -0400
Message-ID: <20260905005127.1756016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090324-mannish-stuffy-9754@gregkh>
References: <2026090324-mannish-stuffy-9754@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

[ Upstream commit 6cba08dc1922140d260cfeb30bbda4ee1bf869d8 ]

nfsd_cross_mnt() initializes a local struct path with mntget() and
dget() before calling follow_down(). On a negative return the error
arm jumps to out without releasing those references:

    err = follow_down(&path, follow_flags);
    if (err < 0)
            goto out;

follow_down() never drops the caller's entry-time refs on any error
sub-case; for example a pre-cross d_manage() failure leaves path
untouched, so the mntget()/dget() taken on entry survive the call.

Every other early-exit arm in nfsd_cross_mnt() (other-namespace
return, IS_ERR(exp2), and the success tail after the swap) already
calls path_put(&path); the err < 0 arm is the lone omission. The
leak inflates mnt_count and d_count on each failed cross-mount,
blocking umount and pinning dentries against the shrinker, and is
reachable by any authenticated NFS client through nfsd_lookup_dentry
or the NFSv4 READDIR encode path.

Fix by calling path_put(&path) before the goto out in the err < 0
arm so the entry-time refs are released on all follow_down() error
returns.

Fixes: cc53ce53c869 ("Add a dentry op to allow processes to be held during pathwalk transit")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20260531-nfsd-testing-v1-2-7bfa481b0540@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ retained the older single-argument follow_down(&path) API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a69287613479b..ec28429c29462 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -130,8 +130,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 	int err = 0;
 
 	err = follow_down(&path);
-	if (err < 0)
+	if (err < 0) {
+		path_put(&path);
 		goto out;
+	}
 	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
 	    nfsd_mountpoint(dentry, exp) == 2) {
 		/* This is only a mountpoint in some other namespace */
-- 
2.53.0

