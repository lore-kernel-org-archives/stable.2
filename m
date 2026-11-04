Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805311;
	b=DgI8NE6TcEqNHuCFB9yf0hl+0w32hEMlaieT7oXvMQ6F8V2Jnbi3W5U3ZvPjzZNOqglo
	 psgzieoq29Xoe8FvxqsgGbrstns9jRckdxFU2RV25aSpUrSVI0gEbEZBCnr5OX27tQI5D
	 6mvpaA/sDhQYSMsUHwLfOKYm8DFmBD+QnLHiPyiyCS4rQDtBv/8rPqK+QRS6ojyRO9lb7
	 zTCjB98DKqZCw6gNNsi0CtY4xXwPe50FrrzcnM19GmUyHD4zS/TTCGwla2C2dav3X/0gr
	 ZCtE1Q82pQmQy06jMTLrpoVTeuoTELykpKgDjD28NX+88lb29JoAoEZv6zvCtEjcD4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805311;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6hnf7Irfe5FG1GMoLJAVAdswZuXc599T2vEKIiaj9MY=;
	b=gv1TD3k/W1HKwwDcoF3j04wgE6Jjn4jgXz2X1uLfXct3NEmHsnlRTaeRkuN2cdBkOtCj
	 QBLQ5mIa7kFp3JyNbn3eC8I5H+uIOon7/VlV+kZ/UDhS9ucNYR7ETF6GJns6kAcxqbZHI
	 mwsjCLfFvn+TL87I/u6dKwKy5kn+tIbR3cj3Ug7RxO33lJb1kPTSK0H5wyhJce/1cHoGE
	 4u09RK6LgDJGjI0pF3v4CjyNHsmD9uwEWChk+9EpzwqWNeeEwXG/B26pNE5coYeURZvZt
	 zIhvpmU1goK75XVs2qopOwo8PGUkth5E4M3CDrKbEILKDYqjPK5rXrKhv3ff0xeW9EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NX3+APwZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2394606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NX3+APwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CA61F000C1;
	Wed,  4 Nov 2026 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805310;
	bh=6hnf7Irfe5FG1GMoLJAVAdswZuXc599T2vEKIiaj9MY=;
	h=Subject:To:Cc:From:Date;
	b=NX3+APwZMTLNkAus4UdO8Pug4xz/uybm3Cscc51K+Ve8arNVWCom45aHHoMMKzQ6k
	 ZuykPZ+jzkoF3uAm3OjgeFbkJ+4V1mwjFfJ2kNLivh0EnwsHxW/JdoMcF4pCUB1WoZ
	 Bb4h8PoL7bGBCbHhDVlnsn9HznUy2pwfwvRPLYhk=
Subject: FAILED: patch "[PATCH] xfs: flag excessive delalloc rt extents as corruption" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:14:59 +0100
Message-ID: <2026110459-usual-unlit-cb9f@gregkh>
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
git cherry-pick -x 2b47be015a5e54f4a3d62afa636ba593de9b67f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110459-usual-unlit-cb9f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

