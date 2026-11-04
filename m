Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810974;
	b=lVWva15/dOf+pw/vDJ+TqZrPBlbrECwVbqMXQvkKcsAolgfJZXLiJI9xUNGtdvOotFkH
	 VOIW2xH1OUAi1YAoQnM4HwY+EJV0unCTAWvqFmrzzribuNs6FsYGh/z+BkqWfOQmFFELq
	 fndNKYidQg0la7CTko4FmYcOreny2tsHoYqDQvUf+08Ym5OHaLM37qi/jvFW+9FfwUi8B
	 UOGMUbguF0UavLbydNqdiGNYfnz1VXTjCC3h/wO7les6YMqsgP8Lmu0w9Vkr4Wv/SkD82
	 K2TqC0bxgV5LyJ0p03WZo9M0klq/qJD3orXBKrxXviO2lypIcPZesIQP4g3wRMS+7pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810974;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kYDgqH+xuaXaI75jhn4l9/QFfdB+c8FzS2LdrgxFYzQ=;
	b=ejhwkhqrPdaMkXuhJYxxluniblnleJI0utnv0qCjVDOk9knvYgzggG91TB6jzdqe0gj0
	 J+TZAJdm5QahYp69IsvWTX9x3y9m+Ttb6rUI3fYtrx2YKdw6kv/Je/3R3HawBZwsdwyhM
	 vF6kXPnK6yQbPuInYuBTt7Gy+xCPeVcQZoHvVfEBmZZtaf73B8+0UcXxPtGM8uoPylHwc
	 zqPILpbaGpAJlA1tW0SJtfALiclrEB5hrhFK4pTK6/fhgxb00dYGeooXRnpEMJa01UQWi
	 EvVWEptECrwbStkliUk6bbEYjDHeVNKitSEhHWDY2gg7FiFSxuEmdNtr/qe9rFNyI3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XJ05eq9f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E567606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XJ05eq9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F031F00919;
	Wed,  4 Nov 2026 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793810973;
	bh=kYDgqH+xuaXaI75jhn4l9/QFfdB+c8FzS2LdrgxFYzQ=;
	h=Subject:To:Cc:From:Date;
	b=XJ05eq9fsgbpK2Dyr1il1+9YqIEKv1qgQSF3RFzzd0BZmMntZU/9ZXqRbbx69nutK
	 AJLODGLPCFC5xZluDtC689Fbh4+NWuO5OKJJ0SFNx/vvuIGeaMMxmpOG7Wyf32WF6c
	 dRutBaDDJH4D9J+KRspO0/ikI0I2izM305QY56IA=
Subject: FAILED: patch "[PATCH] xfs: reject absurdly large xattr value lengths in" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:49:32 -0500
Message-ID: <2026110432-recede-reliably-854a@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fd012955641881169a9f01a00f656f6ca73842ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-recede-reliably-854a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

