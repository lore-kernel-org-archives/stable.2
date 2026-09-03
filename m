Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370834E235E
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449883; cv=none; b=u92uXi8+Z1s5+TSb4TOYliXc5SQ1DgnlNH98qtMaI/85OJNWV85eYEfnFtp/GTHMeuqb2Mx8mIi6UeYrPkWip/edyv2TezYAi+bLP2VFVTJZpPD7ubPLq7ci/o6lhZQQI5CsdOur/tl0pvCqR8oH/gDjwNgYwfT9lZWcgLYlqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449883; c=relaxed/simple;
	bh=lC7eeLyAN8+LID7jOoI1HRXsatjapGNAsPIU0IsE0DM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=isiM++5uu7R5VRfDPGgYw69o7EGNDs8DWoK3nAOev9Sg/2qdAxq9VTbltBzOYUNu/y0LormtY2EfTc/7Oci7wu0A4X7o1a31hCOoetJSpwA+L6/J0RJU0FK4R8wVIlPaPjRHtLYeT/FaKSp0IJTU1+OyPOJOpg9rUi3esSPjABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1MlGFaQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1MlGFaQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DDA1F000E9;
	Thu,  3 Sep 2026 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449882;
	bh=U1OEwNeAZCWin60V5r6wPlhnUy0EuGzZEalGgNVAL3Q=;
	h=Subject:To:Cc:From:Date;
	b=1MlGFaQAdrYOtWl8Go0QXKQdrSiYKJSDn0PYcUSvkzIRfPuPfO32q+2OT50u3WffY
	 e6PdaVq/MR7fNgAcCUBoijnCX/8T87GA3IGqhOU0X8h8g9aD6TRo8Rwa+wH1culd/k
	 sq+OFaeB+OIeoGPrI+NZNaEpA8t0Hw/AhFRWaKRI=
Subject: FAILED: patch "[PATCH] net: thunderbolt: Release the Rx HopID that was handed out on" failed to apply to 5.15-stable tree
To: fy15309206903@gmail.com,horms@kernel.org,kuba@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:07:49 +0200
Message-ID: <2026090349-egomaniac-herald-cc74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2f1463554d0561a2fead81e3888604e5c1125e29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090349-egomaniac-herald-cc74@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

