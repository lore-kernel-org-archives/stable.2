Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E24AA401
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441500; cv=none; b=b8m9r+aISJKFHJhIYuPR21KA+cFOvg6WgzdRgN4P1ADYcr4+vv4GZq5xLEAAMfPcFrsPDDdq7w4roT0p0eKbuM0vF2TZjmFF7iDolU+BRTgI75XFN5I1Pce6nlGdZ3WMrR2HAN6PDB578941e5BwBSGCFQ5Ivs2uggQ7JQn/cIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441500; c=relaxed/simple;
	bh=zgKR1OMUk/omF3oV2IErJKN7olu5+bsjtcryQ5lvpVM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jjy9VaTIP6vGgtCPK3dHJWezwcI6aZ178q7vlqIAxKdUXa6dutTKLHCE48RkJUHcZmE3UVKJnARY7bgsnSdTMcKGH3YxE04AqBWUao282KyXkgfVk2MyUN4eCgazDAouFVr3iH7wn649hHwooAfQbCBjUrY161S1fjVFgopD1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlLlhLUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlLlhLUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52121F00A3A;
	Thu,  3 Sep 2026 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788441489;
	bh=b11nXBiQjY6mvCh3n/dUfZTSAY//JjSqQA/qW6SwTgU=;
	h=Subject:To:Cc:From:Date;
	b=ZlLlhLUwZTC8YIXP60GTD9EbXeoQzp9A0UuqRUdBtZBKVoADiQcuFMeqDIsj2sRHb
	 Jfs908j6IhbS7Y9WJJ0l8kypECaGXwY+QdFHNx4IIx5UKr0uxVDn2zqFXkVM3J1/R7
	 cRglFTH6Yq70JGN837LvXDAa6KHXDJGvFZZ2gIO0=
Subject: FAILED: patch "[PATCH] nfsd: release path refs on follow_down() error" failed to apply to 5.15-stable tree
To: clm@meta.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:07:24 +0200
Message-ID: <2026090324-reprogram-throwaway-926d@gregkh>
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
git cherry-pick -x 6cba08dc1922140d260cfeb30bbda4ee1bf869d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090324-reprogram-throwaway-926d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6cba08dc1922140d260cfeb30bbda4ee1bf869d8 Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Sun, 31 May 2026 08:06:59 -0400
Subject: [PATCH] nfsd: release path refs on follow_down() error

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

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0dcfaab95021..f73012bc742f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -137,8 +137,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		follow_flags = LOOKUP_AUTOMOUNT;
 
 	err = follow_down(&path, follow_flags);
-	if (err < 0)
+	if (err < 0) {
+		path_put(&path);
 		goto out;
+	}
 	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
 	    nfsd_mountpoint(dentry, exp) == 2) {
 		/* This is only a mountpoint in some other namespace */

