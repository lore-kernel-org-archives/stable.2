Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B98327BEC
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579577; cv=none; b=LR+s3zi4+zka/o93BX+c0EEhdlZ2tFq4uAdBRu9+dyH+cRqACairW8oQllE2PxI/BT62YxuHMkJ1SsePJhFDS4IniXpO3Gbe5ds6mMpAQ745CMFWiRApaKISOS5u4bFFCa9dZW2x1x490nBkOaHLKhsw0782y9rUWmka59NVRmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579577; c=relaxed/simple;
	bh=egdHdBSu5ivZCmKLyfVK6QeVh4X5GbQfAPCXfzQ8x7o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=etNAt8KjkWqJvJW9ymjh9UPkEUOlk9+CaQxozZHvNfvt6LIEQTqXZeQrDphPkdpdEY1c+jko1QOMSdkDEk567GHiM1jNRI4pYwpe/N35ht0c6QLRBANptVbdpf5+8FyqQ3jS8bhXtvTQUA9mVpGyMIDAB8nHZwMukS7OzYOPXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YH5N9ioh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YH5N9ioh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484FB1F000FF;
	Wed, 16 Sep 2026 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579575;
	bh=Rfig56QPPCt32aY+d/7vtGdHDRrP1C+NNIly34hG1FM=;
	h=Subject:To:Cc:From:Date;
	b=YH5N9iohoHTSixWmCfBs18t55Wz0yOZyHR/cfSFbN2ZVqZdttJXa6TotFLc0KdV3u
	 hV+awBZ0qVgVezGJRHjsEqo/vq/diq1tnO2Zxe1n/8WdcHRJhXdLs+hPeJ/hyewR8h
	 dRAQ6BbS/YrNkBtE0TWgU0JB2tcvwHN/1wQyQ77M=
Subject: FAILED: patch "[PATCH] xfs: make the rtsummary repair fix the file size too" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:22:20 +0100
Message-ID: <2026091620-ravioli-catfish-14c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 6b760b3232b3efc8bcc7c165e76300bc1c9140c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091620-ravioli-catfish-14c5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b760b3232b3efc8bcc7c165e76300bc1c9140c5 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Wed, 2 Sep 2026 22:52:07 -0700
Subject: [PATCH] xfs: make the rtsummary repair fix the file size too

LOLLM noticed that the rtsummary repair code will create a new rtsummary
with the correct file size, but it won't force the new file size to be
set on the existing rtsummary file, leaving the rtsummary corrupt.  Fix
this by setting up the tempfile mapping-exchange to run to the end of
both files, which is the magic offset needed to reset the file size.

Cc: stable@vger.kernel.org # v6.10
Fixes: abf039e2e4afde ("xfs: online repair of realtime summaries")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/rtsummary_repair.c b/fs/xfs/scrub/rtsummary_repair.c
index f065c3e51ce2..ed763290aec1 100644
--- a/fs/xfs/scrub/rtsummary_repair.c
+++ b/fs/xfs/scrub/rtsummary_repair.c
@@ -164,9 +164,10 @@ xrep_rtsummary(
 	/*
 	 * Now exchange the contents.  Nothing in repair uses the temporary
 	 * buffer, so we can reuse it for the tempfile exchrange information.
+	 * Use XFS_MAX_FILEOFF here so that we correct the rtsummary file size.
 	 */
 	error = xrep_tempexch_trans_reserve(sc, XFS_DATA_FORK, 0,
-			rts->rsumblocks, &rts->tempexch);
+			XFS_MAX_FILEOFF, &rts->tempexch);
 	if (error)
 		return error;
 

