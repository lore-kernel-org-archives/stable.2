Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A24E56D7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449886; cv=none; b=ftdZ9Fq2QDonNnOUyob7vDFolmBuMSpKcG67GigSGMrT/8vvbOZnM9BZM4K2RNLbfRxDRk3/xs6qPZL8HE85peQ50PN6Si5JoRNBheq5AXI7CSGj8z84dsCm/IYTqe4O+iNHhhgmfW/Mi+3T8hJoHNz+H9pImZGSc0dPH9u1q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449886; c=relaxed/simple;
	bh=SZvU44MiBU+TlW6610antrCzY477MhVGMgnL1SOWsDY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nLTdvwdYfGQrJWzILzVI8ddR+yFEx1IMgQYOmGEjpLf7XmhLBX/e3D2bkpQwI/W7lVZpi94kU3TYqQeBKUG598nvSqloqrjEF4vTA8kj+H36fXcVLIupMAwPpVE66kG22eb7GxhjtE4k+5pbTVPPiXgpYHNtnRAy5BtMJX7E06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kwc+S2ZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kwc+S2ZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677DA1F000E9;
	Thu,  3 Sep 2026 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449884;
	bh=z3gDwqjdt7kBhZl/uy+q/nJ3cpsM+TPM+TsrMq+2gQU=;
	h=Subject:To:Cc:From:Date;
	b=kwc+S2ZVGH2CGp2Cil1/tSMrvXh+k1Xd/ETr8Ph8m2kuGe5VbxViq1Ddi6NaVHs90
	 0HEu16tsOKHRYLBdAf0LQxJvC45MbSswLQJRF2N4XJUCZWJKPiFk1wSngE+CjJ6ncW
	 3ZT8Q5CAP1WEOoC9ARgWRQ3EjIjKBvoZUUqyzlaw=
Subject: FAILED: patch "[PATCH] net: thunderbolt: Release the Rx HopID that was handed out on" failed to apply to 6.1-stable tree
To: fy15309206903@gmail.com,horms@kernel.org,kuba@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:07:49 +0200
Message-ID: <2026090349-steering-carbon-b5d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 2f1463554d0561a2fead81e3888604e5c1125e29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090349-steering-carbon-b5d7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f1463554d0561a2fead81e3888604e5c1125e29 Mon Sep 17 00:00:00 2001
From: Fan Ye <fy15309206903@gmail.com>
Date: Tue, 11 Aug 2026 13:20:49 +0000
Subject: [PATCH] net: thunderbolt: Release the Rx HopID that was handed out on
 mismatch

tb_xdomain_alloc_in_hopid() passes the wanted HopID to ida_alloc_range()
as the lower bound, so a taken id is not an error there: the allocator
returns the next free one above it. tbnet_connected_work() asks for the
peer's transmit path, treats any other id as a failure and returns
without releasing what it got, so that allocation stays live for the rest
of the XDomain connection with nothing left holding a reference to it.

Release the id when it is not the one we asked for, the same way the
error unwind at the end of the function releases the expected one.

Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260811-b4-tbnet-hopid-v3-1-9e75d1b51331@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 98893732bc6e..e5199a87ea7a 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -647,6 +647,8 @@ static void tbnet_connected_work(struct work_struct *work)
 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
 	if (ret != net->remote_transmit_path) {
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
+		if (ret >= 0)
+			tb_xdomain_release_in_hopid(net->xd, ret);
 		return;
 	}
 

