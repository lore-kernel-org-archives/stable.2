Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805300;
	b=wAmLWm5ZaUlYsaREHmS0Mt254GIvqQznUwIDqZaKQFDn2xJk5+x+O3fvJ3r6I4du5wWa
	 jsnUWRv6ud+jD7oBlGSGrrKgV2dEK/NCqxGHcwA+GSD2AUyua+251/Kc1wQYhFgn+tRtK
	 gB8LJ41NKb3fMSiV1V2R6fwUu5AG5UdZ2awpTZpxKjgt+T6FYagItYfwDj55ljZGZZMOy
	 Oe9q4sgc6KsUKIVt7Fm2EPAtU0LL/MnrLCDVFAcouMIirpD9exFcQcfquk+r4AWWyeSxn
	 5o6Bc2AqyaW2dLKvQs36N2SoE/5jT3qdzOWTtQ2T/j1mmljWFx9wubTtzTOOBJVfSyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805300;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gLxpnyM0SnEh3UIGban/eeydY8HiaYDGEkOdDjoNAw8=;
	b=xWYKzl6Uqd0yBN4IycnjgS0VZ9uh7W3fB4GxG7GbJ8inpC1w9HlU3wHOMqSLlY5XpIse
	 Gyaeo/XyTW0d6T0CIfHPm42jhC7/loWN6hQD9SxQmLiuXzof3D//WOZk67lvRTmaxsvoo
	 GMDR+vSbCxwO2fyZa5qdxJ9O5B7s94X7jLMw9pgG+5SJq9fLleoyv0ci6Wy9MVUsbtePA
	 tRV2ByEMcGrdardDwygbu3n+5CbdYhF6BRKVVDei8zj5jTR3EPmi+WLWdzgJvCfmwag4U
	 JcL5FSykX/gmq2EgRSC65eueU0git/Pc8dnY3lCxc0mBhrWmm1Y4/L6PxPD1+reWMEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cjQhCkhy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0305606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cjQhCkhy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F5F1F000C1;
	Wed,  4 Nov 2026 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805300;
	bh=gLxpnyM0SnEh3UIGban/eeydY8HiaYDGEkOdDjoNAw8=;
	h=Subject:To:Cc:From:Date;
	b=cjQhCkhy6k0nlYRVS4JW4eK+ql57VkTe6x0SaCGn61m33dIcpCAKX7UHPYtIewr2D
	 fXpDSPle1s9zb+lVgBZa8OmwoNOAP/f2qZ0aBjJmz7sWvVaA1d4C0kdfD6QAe4lM21
	 DOtgxQZQFPo3YdfNQZGnkGZPLtweyM/HYa2/8WQM=
Subject: FAILED: patch "[PATCH] xfs: flag excessive delalloc rt extents as corruption" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:14:58 +0100
Message-ID: <2026110458-culprit-afar-aadb@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2b47be015a5e54f4a3d62afa636ba593de9b67f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-culprit-afar-aadb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b47be015a5e54f4a3d62afa636ba593de9b67f6 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Sun, 4 Oct 2026 22:55:33 -0700
Subject: [PATCH] xfs: flag excessive delalloc rt extents as corruption

LOLLM observed that we should not allow repairs to proceed if the count
of delayed-allocation realtime extents exceeds the number of free rt
extents because we can't install negative numbers into the superblock.
It's unclear how we could end up in that state in real life, but let's
at least complain loudly about it if we ever encounter it.

Cc: stable@vger.kernel.org # v6.2
Fixes: e74331d6fa2c21 ("xfs: online checking of the free rt extent count")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index b3fb1b422765..eb1a095a0fa9 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -609,6 +609,13 @@ xchk_fscounters(
 			try_again = true;
 	}
 
+	if (!xfs_has_zoned(mp) && fsc->frextents < fsc->frextents_delayed) {
+		if (fsc->frozen)
+			xchk_set_incomplete(sc);
+		else
+			try_again = true;
+	}
+
 	if (!xfs_has_zoned(mp) &&
 	    !xchk_fscount_within_range(sc, frextents,
 			&mp->m_free[XC_FREE_RTEXTENTS].count,

