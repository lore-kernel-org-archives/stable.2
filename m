Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810984;
	b=ZF/izEYFXBWLlRviLl/LUI7hdeu3wb80HaPknU1RI6pJFOIer6wGAW7JDlskR9lHOU63
	 QBrCOW4kr3YLvt526yF6SjloFftFvhJ+CMXumaUswd39lPwC6SUUuwI//VEt2Be/UXoxe
	 s64i7rEa7YUjXEfkq70yO7f8bvL/aocmgHwWA22mrF+d0f1fUTY1JyvI7qePJsP9MyUSw
	 KHAXGEjn3YYgAz9dSN+Ge6tokS40WRCXc8kaWuP2tRwyoGJtlXh+gSvHzPY1y9GRs4WO2
	 Mryp2GZYxyQSpIcibSzny1ONCIABSLBZFReTGMs3VGhwaND3j0LV9pIjWloDxAy32xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810984;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d+nuOasvOw5wIZP6LvJDhCjLyeQZF9QCGPw2TiFcohw=;
	b=Y1GW2jdsKtsxoXYbaa6UrfmZG81f/l4fagSlzPbTKBrFb+0pEqaURx9UygnGvGmL+RYA
	 mQESlaTHpNEwbdUk69/j34EXF9MP9JNDg8JhAN6dH2+Ii0pPzGPY17PsWCCeSHyH8kSnK
	 zjHNVr7+fqimburcPgnGylH03reFG0llEzJJ5FfWXu+HwfE7CJnLD1HlUpIdu55YDxrR2
	 BBP6ctWFWwxNjwjSPT7A1NUv/0svOB9angSfVM4a705Fzl5pWVJQvWy8BnfoATpFwH5xq
	 KKwMys2aI6CqgiuiMNJWGE4qruCWp5uHMJ8fQxN9P+2Yn/4xXZ6gFbByQD9Syv5lhnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=snxFoWSk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE604606D829
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=snxFoWSk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DC1F00A1E;
	Wed,  4 Nov 2026 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793810983;
	bh=d+nuOasvOw5wIZP6LvJDhCjLyeQZF9QCGPw2TiFcohw=;
	h=Subject:To:Cc:From:Date;
	b=snxFoWSkgs2V6vj+NejupEWWvXBNLPhm5NqEVQZD2oxejFQZUaydhF6BVjZnwwpiu
	 lXQM2IbItKcV+BLCsHbb+29T3H24sY6bWvJ4Tbs2mPcB4ooDz704yroLP3fBMliFp7
	 0VtfkG3xegGRgfmfirkAuvvLDrfGjnCXv7Yk5Eno=
Subject: FAILED: patch "[PATCH] xfs: reject absurdly large xattr value lengths in" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:49:33 -0500
Message-ID: <2026110433-circling-donator-d93c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x fd012955641881169a9f01a00f656f6ca73842ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110433-circling-donator-d93c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd012955641881169a9f01a00f656f6ca73842ec Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 08:22:41 -0700
Subject: [PATCH] xfs: reject absurdly large xattr value lengths in
 xchk_xattr_actor

LOLLM suggests that we shouldn't try to allocate absurdly large buffers
for xattr value checks because that will push reclaim very hard, never
succeed, and is pointless because nobody can create xattrs that large.
Since the xattr repair code ignores values larger than XATTR_SIZE_MAX,
we can flag the corruption and return early.

Cc: stable@vger.kernel.org # v5.3
Fixes: 6d6ccedd76823c ("xfs: only allocate memory for scrubbing attributes when we need it")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 7600c7113625..842d65834afb 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -216,6 +216,12 @@ xchk_xattr_actor(
 		return -ECANCELED;
 	}
 
+	/* Don't even try to handle a bizarrely large xattr. */
+	if (valuelen > XATTR_SIZE_MAX) {
+		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, args.blkno);
+		return -ECANCELED;
+	}
+
 	/*
 	 * Try to allocate enough memory to extract the attr value.  If that
 	 * doesn't work, return -EDEADLOCK as a signal to try again with a
diff --git a/fs/xfs/scrub/parent_repair.c b/fs/xfs/scrub/parent_repair.c
index f643724910f9..6a3c0a190ff9 100644
--- a/fs/xfs/scrub/parent_repair.c
+++ b/fs/xfs/scrub/parent_repair.c
@@ -910,6 +910,10 @@ xrep_parent_fetch_xattr_remote(
 	};
 	int			error;
 
+	/* Don't even try to handle a bizarrely large xattr. */
+	if (valuelen > XATTR_SIZE_MAX)
+		return -EFSCORRUPTED;
+
 	/*
 	 * If we need a larger value buffer, try to allocate one.  If that
 	 * fails, return with -EDEADLOCK to try harder.

