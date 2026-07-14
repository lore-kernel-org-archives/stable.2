Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621247B42F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044262; cv=none; b=bP3/Hj0YXg13HGeUEX23Jgfy0agOnMi9XlAvHe1y+7A2q7HVU2EyKIIXxp09Ca1wIp0gZ3+U1M39eRAvWkrL3TDokyTN1BOBcAuC+QfV/jWBtivBHTOzqdQuxRww+Zxm+jMo0U09GGvjSTSzjUtSTclFb3m0ee006OdA8GuFLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044262; c=relaxed/simple;
	bh=bKNh2fHZJPwHB0AyOqBzSPSOlhghxvhwhvXwxMe9STM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rDwMGDG95BwbBZrltem1Jyn2TNkH4VqcipjiClBtXBG/6bnE2aoWUWWSv2hzcGmbttXzc28rnl6ze2ywiQpDNPLPPcoZF1Bs8jwC9gJhQ06E08GcTF09UrlXrR8QpLoA1qW3A3uXoAjTc3yAkmTgLf/dB/Nwvn6Gm6WtyT707mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=On6TcWAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="On6TcWAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB8D1F000E9;
	Tue, 14 Jul 2026 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044261;
	bh=4TrCY88y2+0Ztx+34vUDNI8T15CvPXRzi9tID0V3oRc=;
	h=Subject:To:Cc:From:Date;
	b=On6TcWAVRrW3JJLR9aKfdYLEQv1m3dKiUT3Zq+szID1LpYHXtaasmjT2NANC2RyJq
	 xo46tH/+5MMsbeuwWmE/fScb8VCiOPTioobwAgS3YwaJQShpcwbi4QE+LFZqtnJ8wO
	 vjlb/yslnG/FT0oa2qbbah89BlUDUiK5ZjRGMfpE=
Subject: FAILED: patch "[PATCH] xfs: initialize iomap->flags earlier in xfs_bmbt_to_iomap" failed to apply to 6.18-stable tree
To: hch@lst.de,cem@kernel.org,djwong@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:50:55 +0200
Message-ID: <2026071455-siberian-quote-a146@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 327e58826eb72f8bae9419cf1a4e722b57c85694
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071455-siberian-quote-a146@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 327e58826eb72f8bae9419cf1a4e722b57c85694 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 9 Jun 2026 09:53:44 +0200
Subject: [PATCH] xfs: initialize iomap->flags earlier in xfs_bmbt_to_iomap

Otherwise we lose the IOMAP_IOEND_BOUNDARY assingment for writes to the
first block in a realtime group, and could cause incorrect merges for
such writes.

Fixes: b91afef72471 ("xfs: don't merge ioends across RTGs")
Cc: <stable@vger.kernel.org> # v6.13
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 6ff722f04f5d..225c3de88d03 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -113,6 +113,7 @@ xfs_bmbt_to_iomap(
 		return xfs_alert_fsblock_zero(ip, imap);
 	}
 
+	iomap->flags = iomap_flags;
 	if (imap->br_startblock == HOLESTARTBLOCK) {
 		iomap->addr = IOMAP_NULL_ADDR;
 		iomap->type = IOMAP_HOLE;
@@ -143,7 +144,6 @@ xfs_bmbt_to_iomap(
 	}
 	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
-	iomap->flags = iomap_flags;
 	if (mapping_flags & IOMAP_DAX) {
 		iomap->dax_dev = target->bt_daxdev;
 	} else {

