Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810964;
	b=mfzVC7wISuOOg+y1YTrMSoN9k91/fP67TpXrDMPS7AZP1L8zdNpTQeqWDaCS4FyDz9YY
	 KMku26XT5AaJlgx+tDNY2WLe7CGGTUOm9mWP/abneATRRSgv3ndnkN2Ydt9mEUh84JIie
	 o9R6L/OnBGwdkVYNnyFf4XlwLsYg3zmvkDObJ4SVmj8oeID9c8nyvnAbmNC57+SOfzLfR
	 NGu+fT1xZIlGbS2qZwbN3Y7K/JrZGKAl/ZH2MeKBXzw/A5qbo1RHsA8eW4B1GkQPlEqFW
	 3h9yXUkKkVYWUuI97a13kWTlBslq2ogspWXJ+eyboU303Pcli8tLqrR3rHeyBp+jYkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810964;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zTGl/HctCAgsZure2E/W3caD+nhGcPLa1FgfTzQKhuA=;
	b=zTmEzLblT4gy3KKImGO8x+k7tn9tmvqx8GZkUbuTU0FskQIvpePFXYpLCvdp6SB6h4IP
	 9nZSgIA8+AN/N4+1JB4S9PyfiHSetG2B4OxDL5mLm8HY14dx6YjEuzjw8ATIQ3qRutAZz
	 DAv2JjPnKzKD9MqFLRBWlwhhb4RAooXLnpm9Yaakvgh7Cxs2Rbur1Wr2/DyoaG0kjsNj2
	 pLrXirAZN+gGrvF6DjXx/g0LpLZsqygYCSTx2RwvdcQl9tr/ZJQzYeuVNmyVAcc31ELDq
	 +jfTPfvLfmF7Slk8VckvYpDzZuDIPf2+KvJZiUA0SABxrJ3dbP69NoetQ0Suu8nMB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eFlGPvJx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F060A261B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eFlGPvJx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D611F00919;
	Wed,  4 Nov 2026 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793810962;
	bh=zTGl/HctCAgsZure2E/W3caD+nhGcPLa1FgfTzQKhuA=;
	h=Subject:To:Cc:From:Date;
	b=eFlGPvJxF8lwIVWlcncDh1KtGyTFO+bSLCaazDd8RoqSxiLNZAT/XlCQzV9xUgZrO
	 B/KejJCSyW2x8BIL5q+u2SI73fAkAqg17rMAC67C4XduuTjVEN12yrDCFLv9rhgVjE
	 AW/C67m538R5HaUrzHQwbpTM8ZbcDfWrh+arfUHc=
Subject: FAILED: patch "[PATCH] xfs: reduce new btree slack factor if free space is negative" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:49:20 -0500
Message-ID: <2026110420-rocklike-immovable-51bc@gregkh>
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
git cherry-pick -x 80f13dc7225eec318da7499c7a562d7a34d25e6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110420-rocklike-immovable-51bc@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80f13dc7225eec318da7499c7a562d7a34d25e6a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:06:14 -0700
Subject: [PATCH] xfs: reduce new btree slack factor if free space is negative

LOLLM points out that if the incore fdblocks counter is negative, the
assignment to uint64_t will mask this possibly low space situation and
we don't pack the btree blocks as tightly as we probably ought to.  If
it's the case that there's some free space and fdblocks is too low due
to an error in the superblock field, then we can end up failing btree
rebuilds due to ENOSPC unnecessarily.  This is a corner case, but let's
fix it anyway.

Cc: stable@vger.kernel.org # v6.8
Fixes: be408417630427 ("xfs: implement block reservation accounting for btrees we're staging")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index 1f28ca1647f8..9baf08bc54cd 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -71,7 +71,7 @@ xrep_newbt_estimate_slack(
 		free = sc->sa.pag->pagf_freeblks;
 		sz = xfs_ag_block_count(sc->mp, pag_agno(sc->sa.pag));
 	} else {
-		free = xfs_sum_freecounter_raw(sc->mp, XC_FREE_BLOCKS);
+		free = xfs_sum_freecounter(sc->mp, XC_FREE_BLOCKS);
 		sz = sc->mp->m_sb.sb_dblocks;
 	}
 

