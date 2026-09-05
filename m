Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DE2475E3
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570384; cv=none; b=hu1hCNhVuUSTbOYfUr9RTtph+hswyZd66dMzcbcRVY0qzBYEFicszen5pex4bQZpAzCzAWLii2v2YaSk4Bk8fuJ8eOxfUwyTgbqFPsG4heTjCDT0PTKBm1h3vaHqNVYMzBzZdf5OCgMyKMdrKCiFtL+HUvRZ64LbE7NLMVyBkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570384; c=relaxed/simple;
	bh=rGNJFmONYnP4evgnIKDRp4GgOWG8KdxYHCOcagaQpeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw4+fmOmtJqtc16Wh3sawREa3fM9bkprXm0tBFbvgR9dImFJqziIh5EYwza9XFn2xLNDsDLrELr0uGZZcfah/Mop5M+DwQZO8UdYvOIZKj2YFO0ZCIaxiT3MttKZuz9dCdyiV2KY8Ksnc0lONEpJfPZVMYt+Aym+Z6q0MZguAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APTjrmKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APTjrmKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21461F00A3D;
	Sat,  5 Sep 2026 01:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570383;
	bh=SjmxzkMGvMmy6BZGNCW9GN1tsiA9Pq5zPb2HQNxJ1XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APTjrmKvQ+9MkK35OgtUxUab1FFSYYkS6Ypi1+5fZFWCsynj8fCzgBBYFQ8d9VUwG
	 G2giECD3erNuIsDZGSv+is1X31fN5wRFyw+ONFVBxovS/e9yB0x2Q74yRFjXnefxV4
	 D4k/qSXAyYgVN+1dkzWLQBErB8x38GxLf2OQrIv5e/YftTHYeMXyyWuGPBSgdM5cQm
	 Lc9cbnNzAaCrrTtpxZ0Z6FTcErS7GawupR9ymNv1TsS3Db/gBLMf6EGe/0luEKt8ml
	 97dRUfAmR29xu/Dzxw9I1gc44erjBQyhWENdC6FV7E80Cd+sr5POu9huDbvo9mfcjK
	 c8TgzuJx9F4zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: release path refs on follow_down() error
Date: Fri,  4 Sep 2026 21:06:20 -0400
Message-ID: <20260905010620.1765626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090324-reprogram-throwaway-926d@gregkh>
References: <2026090324-reprogram-throwaway-926d@gregkh>
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
index 7b0bc4507ad04..225916fc0c8d3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -129,8 +129,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
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

