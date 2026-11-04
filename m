Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805259;
	b=Y/ocgDj2p7HBsTAmfUTSIfpql9DKIvcneUn93c11zWv3M6Y93itIo3cVgyFyo8XaLRd+
	 c3F9S5FXYbH9cgiue3NMJ30+AVLUT49vrQBujc/S9Dw4jrGgq8ZT/3nfFPKHtND+yfqlp
	 WITfPp82D4yId69momgi1cibd/1a6ePdflf1fugldji6H/ho6RF+D864HHukg/LqIgIhG
	 ndXL+7Akn03NRq1FWgyI4lXSNIw2aCb3VVf6DB+CLzFs5ctxHLRispSJz741jhrSzinGP
	 hCI7CLkQzsUagkuTyPAYUc1wU4mc/9r6+84ev5xoXKNWj8S+hLlKb0HEIren6BTPJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805259;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=se8s3Tc9eo1CJENnJrSsOe8hXSnKGw8Gm2VfumSIrzM=;
	b=BNv9FZMrgPSwNZ2NKqeeKPcfHPApV1wsht/fEnrXIZB6NJ7KcZmn50pY39oEdK06ln3/
	 n4sepWCr7ND4dibt21dzR+ojV2YGTJ/XxsCvYCIp61KQBTh1V+Vnoi1yksXFcjKozSaqU
	 y0IEncRA89pTsLZsoQP0ZxXSMFY5xLG+lXlK0ajYUUjtkduZRHpfXXmWWeA0sRROYgrQ+
	 qUdZDyV6vVPdsEp62KIfPMqdkQ61ib433PmqSoXsnBWNnTsRM/7jspmuUGDZmm0e4gfh+
	 suW9UYu2pwAlW6y2CCKUoQmYl2mRxg/qjzQeVebVGOLEefBFEWNgU4qAk43jDJmfO5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bG3sOV6g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557D606A339
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bG3sOV6g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA61F00A1D;
	Wed,  4 Nov 2026 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805258;
	bh=se8s3Tc9eo1CJENnJrSsOe8hXSnKGw8Gm2VfumSIrzM=;
	h=Subject:To:Cc:From:Date;
	b=bG3sOV6ggZY7Dlj/7AtzAPg5CZg3P847S8trkxdZkHEXYBJjLap+KTC5nZ1bBnxFZ
	 kCCleGOG1nqVOsAdDPPRl4gvhznI6K/XcfCNw4yEArR8YJpkU9p8yRMLQNFT/U69Wo
	 mIUUDvuhdlsQeFlkfplbqUq8nXbHaEqU5Dcaryac=
Subject: FAILED: patch "[PATCH] xfs: fix buffer overflow in corrupt inline attr structure" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:14:17 +0100
Message-ID: <2026110417-filth-stumbling-5b3b@gregkh>
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
git cherry-pick -x 017dd7a84ff4cd2275eb62f4ee6d63c705bac107
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110417-filth-stumbling-5b3b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 017dd7a84ff4cd2275eb62f4ee6d63c705bac107 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 22 Sep 2026 23:02:34 -0700
Subject: [PATCH] xfs: fix buffer overflow in corrupt inline attr structure

LOLLM noticed a buffer overrun if the xattr scrubber encounters a file
with a shortform attr fork with sf->count > 0 but if_bytes ==
sizeof(struct xfs_attr_sf_hdr).  Basically, we have enough data to have
a header with a nonzero count, but no space for any of those shortform
entries.  In this case, the xfs_attr_sf_nextentry() call will run off
the end of if_data and blow up.

Cc: stable@vger.kernel.org # v6.4
Fixes: ae0506eba78fd1 ("xfs: check used space of shortform xattr structures")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index d5226939c810..7600c7113625 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -590,12 +590,17 @@ xchk_xattr_check_sf(
 	}
 
 	for (i = 0; i < sf->count; i++) {
-		unsigned char		*name = sfe->nameval;
-		unsigned char		*value = &sfe->nameval[sfe->namelen];
+		unsigned char		*name;
+		unsigned char		*value;
 
 		if (xchk_should_terminate(sc, &error))
 			return error;
 
+		if ((unsigned char *)(sfe + 1) >= end) {
+			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, 0);
+			break;
+		}
+
 		next = xfs_attr_sf_nextentry(sfe);
 		if ((unsigned char *)next > end) {
 			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, 0);
@@ -618,6 +623,7 @@ xchk_xattr_check_sf(
 			break;
 		}
 
+		name = sfe->nameval;
 		if (!xchk_xattr_set_map(sc, ab->usedmap,
 				(char *)name - (char *)sf,
 				sfe->namelen)) {
@@ -625,6 +631,7 @@ xchk_xattr_check_sf(
 			break;
 		}
 
+		value = &sfe->nameval[sfe->namelen];
 		if (!xchk_xattr_set_map(sc, ab->usedmap,
 				(char *)value - (char *)sf,
 				sfe->valuelen)) {
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index 28f92e9ba72b..ac433a546751 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -477,6 +477,9 @@ xrep_xattr_recover_sf(
 		if (xchk_should_terminate(sc, &error))
 			return error;
 
+		if ((unsigned char *)(sfe + 1) >= end)
+			break;
+
 		next = xfs_attr_sf_nextentry(sfe);
 		if ((unsigned char *)next > end)
 			break;

