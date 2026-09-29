Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D9349CD8
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664563; cv=none; b=PUOP5OfMNIw3vRSfMJWfJjSCTeRyDcI8jUWgcxxgvo/fzsRFfp+TWZreUEWnfWv+ifo/uayYHPGJKGGalke2XAe66DuaiXpSY2SHeUHTlS+WcuFEk8mn/RpKLAPWO2EurloIC4nNrLx6QHtW2I+OP9z0ZONRLm0vcJ2PV1ufXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664563; c=relaxed/simple;
	bh=Zsown7g98dyNfvCo8IXK2kTDMs7iBcTOwWLL/LupEDA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HrK1pCMHmJV+C9sqzNLY52s2iqyn7XpBg4p4ViBW67CsuAJ7MrGVBBJwe2hcDK9eSMT8lIVWDjsfo8oV7p7QWe4mZar59g3D1MamzpFFCFawG3UGp2RGgftTHIlTLbKMy630PuQ9p9wBTZ7KrGzH/UxQrNCCrIF1zyFTZbiuvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G5dQGBkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G5dQGBkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE251F000FF;
	Tue, 29 Sep 2026 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664562;
	bh=0GqiA2brZ/kYRKsAuK/m6xTW50R+NhXTIh+KyyjSCUg=;
	h=Subject:To:Cc:From:Date;
	b=G5dQGBkPVzvjeMSVMB/LCuWSlaWCvlYJdY5s32XkiqITmLA4V114SMb8XsDRmdATB
	 XheQo//kxouOZapz8d1bGZWnhYhSmL5GoA3Os0gCX32+v5xRi1lrd23Ca/o42NB2dh
	 lU+YkrCvkfcxtty8/+PqB79JKOepbCLzUKMpn/Zg=
Subject: FAILED: patch "[PATCH] mctp: route: iterate socket tag list in" failed to apply to 6.6-stable tree
To: benquike@gmail.com,jk@codeconstruct.com.au,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:49:19 +0200
Message-ID: <2026092919-dawdler-dodge-debe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 26cc0e69cce062cd3aa6fae33074684669c35a71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092919-dawdler-dodge-debe@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26cc0e69cce062cd3aa6fae33074684669c35a71 Mon Sep 17 00:00:00 2001
From: Hui Peng <benquike@gmail.com>
Date: Mon, 21 Sep 2026 05:10:01 +0000
Subject: [PATCH] mctp: route: iterate socket tag list in
 mctp_lookup_prealloc_tag()

When a socket transmits a packet with MCTP_TAG_PREALLOC set,
mctp_lookup_prealloc_tag() iterates over the per-netns &mns->keys list
and matches netid, req_tag, peer_addr, and manual_alloc, without
checking whether tmp->sk == &msk->sk. This allows any MCTP socket in the
same network namespace to use and consume another socket's preallocated
tag.

Iterate the socket's own tag list (&msk->keys via sklist) instead of the
namespace-wide &mns->keys list in mctp_lookup_prealloc_tag(), ensuring
that only tags allocated by msk are matched.

Tested in QEMU against Linux 7.3.0-rc3 by allocating a manual tag
(0x18) on socket A via SIOCMCTPALLOCTAG for peer EID 9 and sending a
4-byte message with MCTP_TAG_PREALLOC from socket B in the same network
namespace. On the unfixed kernel, sendto(sock_b) using socket A's
preallocated tag succeeds (ret = 4); with this patch applied,
sendto(sock_b) fails with -ENOENT (errno = 2) while sendto(sock_a)
succeeds (ret = 4).

Fixes: 63ed1aab3d40 ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG ioctls for tag control")
Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Peng <benquike@gmail.com>
Link: https://patch.msgid.link/20260921051002.1656692-1-benquike@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mctp/route.c b/net/mctp/route.c
index b19c63a5691a..e7c95eeacb48 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -825,7 +825,7 @@ static struct mctp_sk_key *mctp_lookup_prealloc_tag(struct mctp_sock *msk,
 
 	spin_lock_irqsave(&mns->keys_lock, flags);
 
-	hlist_for_each_entry(tmp, &mns->keys, hlist) {
+	hlist_for_each_entry(tmp, &msk->keys, sklist) {
 		if (tmp->net != netid)
 			continue;
 

