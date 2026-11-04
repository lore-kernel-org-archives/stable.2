Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810983;
	b=ctbJm7YnBAg/DkiLqR6JdMso8OogcyWCUUPju0dTBvHTCMrzmupY5KpqXU/DMQUHNobw
	 fmjyVShsQjugIlZTA/uj9FdZCDb1aYggebo0NYBcG40xJmrty8WPiqfBv7+NyPRFPJIb3
	 SNV47rzoMQErK7hNCPunq6MONM2cUj+juTHIUtX8lx4WBlz/JdkWuGk1HeM4OkHTlRApl
	 kMu4HIA4NyJyoTIePZedoK2UU3N3Jr41Fn89/B+2EjlaoYcRI/wUQCkWEYaIkBjECbZuK
	 F+/ohLvqohkEQ2ow7OScEG6QiVUt+RVOFaNVyxWIuMvG0hqNYiKmSfucg97EzSK/ZyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810983;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nGr7YaxV8u7mwB5eTToHKnoDmX9qYBYcfqNS4CmpPpg=;
	b=1k9uPiYKbSZ9rP/sHm3T+aEdncNCfbySBQZyNcOm3wOKdDIsxMdo8C5D+bV1CBOOmFng
	 ZzbVY4ivpFFQk/GMkL6UOW+rz+dvTu9Jit0nCdkGN8aWM6/puyGOcxMDSpJ5k3dQxNWhT
	 oDrRExhYUtc3qrKFkdu1MQ24BqJwFGx5iozjCPMuM5xBXnLpRP+GcJ4aWTIlzuhriwpx0
	 qWsUm2B0pT9pqvQOHtoZrrtYdZlOLXXR2Ofdo+z0jG8D4vBMq4eT/PE+zKCnLha+zfiGP
	 kalofFmdKDyoRcnCEl0hJAkfXRH8yvzuUcoc8jbcyWNI3FlbUfOWpfAOiZumilIrQJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bGFDI4gr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6820606D829
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bGFDI4gr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328BC1F0093A;
	Wed,  4 Nov 2026 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793810982;
	bh=nGr7YaxV8u7mwB5eTToHKnoDmX9qYBYcfqNS4CmpPpg=;
	h=Subject:To:Cc:From:Date;
	b=bGFDI4gr38Uqh5JnCn5HLCyh/WpYzNeopjPXtzcF5b+3g64lXv/WkFZ2HoHlPjVgW
	 bn1CQBJtnFIJ1v/YPvF3koKz5CdyQWN/WJsAyOQd5sgKCJIKM4XDracu3MsMn95Sx1
	 /QC+L6JCIN9rP/HRHdZOz+Ph7DawaZyyxqwYFsDo=
Subject: FAILED: patch "[PATCH] xfs: reject absurdly large xattr value lengths in" failed to apply to 5.15-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:49:33 -0500
Message-ID: <2026110433-lubricate-ovary-6900@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fd012955641881169a9f01a00f656f6ca73842ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110433-lubricate-ovary-6900@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

