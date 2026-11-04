Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810985;
	b=rsG4uqkTD64riMqX1M2MxntPZK8R0iQ9crV4RAnJznXFAoZu2jmy9b3c/kI3dywo+Lol
	 /tejLV5ZEjNQRlhltNLiEV5JwAixxpvjmOYZJkHuM2koFuzKO44rHAMTnCJMxfBLeqlmL
	 Pyy/ic4K1QruziDWthmrjImWKZKeZ093oYYwBT08zNescgIU1Z4OD/fMh6ITCw0e5EqiY
	 qxgiIjHDy7/MZq3IXWGR2KNpqQdb1HPgX3zRI/rlbylkk2oToD74lM1876swQOMo31Aaq
	 tcrvaxgFBQI4es34kkWCw9x9atKn1xSMLYfriUBg+xcVMVjlIxZlukqt0WxbuxSbMzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810985;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8GwM68krthilW0muDK9rnvDgwd+88m9Hhei5W+eq9v4=;
	b=OFgevsKVRNbL50sFywaZfi19elNPyZft8ZaD9F13MIOUPTz4L67dZ29Y3/Mh1lvuDCs3
	 0zd7j+aV11YfAWObssYflc00stDjDQDlKvtKr+Qy8TD5lLjekFC7WDzyC/kJsuVNf5Hrr
	 YqepczmksNetpCsxf4MFhZNKfHrEuusQArQPSPsjANBbND5+jXNe2K5FVFh2PpXj1ZzdR
	 rors3qvcnl04nKkQ/WgwFur+veHLvfiIv8v1FvD6FcApBabhY0muioOotkkCS73P8C7yu
	 V0p7ljkw65SKNY4PChDGtwky/SnNQ1P2gmwoz85GxEXDTKzo0oj2VHSX7EeV+cjnIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iKxRqgGK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A2606D831
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iKxRqgGK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC911F00A15;
	Wed,  4 Nov 2026 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793810984;
	bh=8GwM68krthilW0muDK9rnvDgwd+88m9Hhei5W+eq9v4=;
	h=Subject:To:Cc:From:Date;
	b=iKxRqgGK+wnDQBmoRYGfHb1ENG0Qeush+1VMko/eldnjFzZrPVHRO4IhqZ4mWa8by
	 BafVrMBo9DGhVyvElM8wNvEyv6y/u1oxET8IUC0C9Or+w+mSv9Eno61fBNs80sE9Sk
	 /N9TxaGmqZzhHfrEi1wEs2r1h38E5c/zRCQMfScE=
Subject: FAILED: patch "[PATCH] xfs: reject absurdly large xattr value lengths in" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:49:33 -0500
Message-ID: <2026110432-cortex-papyrus-00b5@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fd012955641881169a9f01a00f656f6ca73842ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-cortex-papyrus-00b5@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

