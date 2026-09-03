Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10894BB805
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445878; cv=none; b=uk8i3Yj5mtWQyR9LwKLk5nI7/p4ALJpuU1IVONJKRPoF/Xxuwk9qY+Qdx5cPgHysG65tOi0orDVT5fOBYtNED2maIOk0KPchQDs3Ln6UHebyCd94Nw8efZvezYtwZnnJ4EHD9/iAWQhSU3ZQJ1AHYR476OEBUw5oGmt0N0naF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445878; c=relaxed/simple;
	bh=naJ8TahLzOpoVuH2d0ZzIAiVcBQhCdh0AUePJlgBHDA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IPM2jpmSPcXd8IViC6Q8iv/5m0+KJy7VHksn6iNdUR9JFtAS2CWxNUIKyc8qJIuzSB1GhMrJq7NhKl8R/BknnLr2dALVz1jNT7XD/A9ggE3VKobTGIJZwEmkWiSI/v7H9dm6AH5xozQkV14K3R4YtcpuxlbmuxY9N3NkKG23EFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aoqMb6ML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aoqMb6ML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F651F00A3A;
	Thu,  3 Sep 2026 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445866;
	bh=x3N+sLrxBlYMP+fyeY6Wb3oYw/Js8MC3jvzwkOXzgDI=;
	h=Subject:To:Cc:From:Date;
	b=aoqMb6MLdYYIAar0kc0eG/KmFOyRwvf2KWscWBX8ztSlS1sID9Pwzx/SDLhEo5Rhy
	 LpLry9kH5B8VX0HrsDFeBcdOsxdXQaD6uc4Kroh4B6V8Z2OyKjiXPzOWG+bibIO0FY
	 ikN//ASF87E8i/Fm6Dzaotc0eOEz+Jq/HHfbeDoE=
Subject: FAILED: patch "[PATCH] svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails" failed to apply to 6.12-stable tree
To: cel@kernel.org,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:09:26 +0200
Message-ID: <2026090326-unclamped-ecosphere-df9a@gregkh>
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
git cherry-pick -x 01500306e1d50de7ca7a2cdcdfa28ac0523eb747
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090326-unclamped-ecosphere-df9a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01500306e1d50de7ca7a2cdcdfa28ac0523eb747 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:15 -0400
Subject: [PATCH] svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails

When svc_rdma_listen_handler() handles RDMA_CM_EVENT_ADDR_CHANGE,
it creates a replacement listener cm_id and returns 1, telling
the CM core to destroy the old one. If the replacement allocation
fails, sc_cm_id still points at the old cm_id that the CM core is
about to destroy. Any subsequent dereference of sc_cm_id --
such as svc_rdma_detach()'s rdma_disconnect() call -- is a
use-after-free.

NULL sc_cm_id on the failure path and guard svc_rdma_detach()'s
rdma_disconnect() call against NULL so that the listener can
be torn down safely when the server shuts down.

Fixes: d1b586e75ec6 ("svcrdma: Handle ADDR_CHANGE CM event properly")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-5-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 656b2bd258a9..093371f9d245 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -330,6 +330,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 		if (IS_ERR(listen_id)) {
 			pr_err("Listener dead, address change failed for device %s\n",
 				cma_id->device->name);
+			cma_xprt->sc_cm_id = NULL;
 		} else
 			cma_xprt->sc_cm_id = listen_id;
 		return 1;
@@ -638,7 +639,8 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
-	rdma_disconnect(rdma->sc_cm_id);
+	if (rdma->sc_cm_id)
+		rdma_disconnect(rdma->sc_cm_id);
 
 	/*
 	 * Most close paths go through svc_rdma_xprt_deferred_close(),

