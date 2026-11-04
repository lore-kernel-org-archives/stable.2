Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814542;
	b=rom7Wx12WKaNnUJ4q8nry7eGZm6HPMb4Xx9q9pvmNQ+MziJniyT6DkzItiYGYHu77W2T
	 pmoSrQnF55iSwo5kJFtlwtZZ+vt7hEaly43PcFWEZsihOaPHvqOgUHmWu/ii3OxL/LNfi
	 oONVhih0bKuDeIjpnEuhc+tLpLNUx+oV3a5WG7eC5ISJDxsm8klXF9UATnFGNWMjE0Bo1
	 PJBVgpAGQ3yvfxNXRCZGylgPBQLOrk7CPV5GQid1RsHRVN4C+ia5pxIpMJzAeS3Socc0q
	 BFf01yhestcaROj9u8kzsESCbrqoiRc0EqAypzq+B4uRJTLqureu34zFpoRNF2knwCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814542;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yK/jOQueXDOAtkKlqT4t4kAjkVnT0u/J4DuQFmkUISU=;
	b=wVQKf+twFOIUogMtR9wU8WHNHuOPTl5Yx0jgjsKRejCUnDt1si91P5a7zmxZXUolRwBm
	 W00FANr57tWV3pocdVm4LDwufGVn3vYqm1R8qo2h4D6SmSWca+ggv6li7TQTuHLxAIEnJ
	 qkwSDsYbW+TWqO/xPLPXPVa/hp228AF4zFuHWUSJrIs36ZiKvMeEv+zjxBJsBabp4w0ok
	 +puf58iO9cqdso5FN6HICcj24OmMM4Apnh26IZZhMXO2P7+TSDIWIijWSOwL6LOjK6//M
	 MEEbTWNKvMvIHnPDBclHpkGMmjO8wdfZCKSPOVpE5a6zpCR2qPABLHFcMwBXTAo+EQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cnP8MeuO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5360A5BC4
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cnP8MeuO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0C91F0093A;
	Wed,  4 Nov 2026 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814541;
	bh=yK/jOQueXDOAtkKlqT4t4kAjkVnT0u/J4DuQFmkUISU=;
	h=Subject:To:Cc:From:Date;
	b=cnP8MeuOP0CL4XJujLR5RF2MprEvSzNz7sH/RoI7RsXlPbuL8vt4zUV1u8r+61IDG
	 488lJECiANfQfcPptdM50TB+1kRz7b311CGrBwM1kFXX2Yo1xpkknqSZb/TWaMPYTN
	 L9pzgqfaUa1xKaVHXF58SL0D9JzOOT5+a0YTtJd4=
Subject: FAILED: patch "[PATCH] xfs: don't queue rmap update twice when reaping a fork" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:48:57 -0500
Message-ID: <2026110457-depravity-unflawed-a6ca@gregkh>
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
git cherry-pick -x 219ff8a734d8438e24eb346a847c9b1ad9b7ab5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110457-depravity-unflawed-a6ca@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 219ff8a734d8438e24eb346a847c9b1ad9b7ab5d Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:06:30 -0700
Subject: [PATCH] xfs: don't queue rmap update twice when reaping a fork

LOLLM noticed that xrep_reap_bmapi_iter calls xfs_bmap_unmap_extent and
xfs_rmap_unmap_extent to remove a mapping from a file fork and its
reverse mapping.  However, xfs_bmap_del_extent_real also queues a
deferred rmap removal log item, which means that we incorrectly queue
two rmap removal operations.  Fix that by removing the extra call and
updating the comment to mention this subtlety that I forgot, having
written the code. :P

Cc: stable@vger.kernel.org # v6.10
Fixes: 5befb047b9f4de ("xfs: add the ability to reap entire inode forks")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 235e5e7e16c4..a0bee8c7abc0 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -1480,12 +1480,12 @@ xrep_reap_bmapi_iter(
 		/*
 		 * t0: Schedule removal of the mapping from the fork.  We use
 		 * deferred log intents in this function to control the exact
-		 * sequence of metadata updates.
+		 * sequence of metadata updates.  The BUI queues a RUI to
+		 * remove the reverse mapping.
 		 */
 		xfs_bmap_unmap_extent(sc->tp, rs->ip, rs->whichfork, imap);
 		xfs_trans_mod_dquot_byino(sc->tp, rs->ip, XFS_TRANS_DQ_BCOUNT,
 				-(int64_t)imap->br_blockcount);
-		xfs_rmap_unmap_extent(sc->tp, rs->ip, rs->whichfork, imap);
 		return 0;
 	}
 

