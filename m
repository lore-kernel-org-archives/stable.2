Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C54AD7DE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441516; cv=none; b=ppQxQxaStNCqkZsyYPgenI3FCrI6fiRQj1OWTiHkB1AKhys4AU5oP8YijGUtvIQFIPGEEe2jMAUpe8IDd3lBK3nrjbhDZ0AyriD/1g+fLYr86wFJ6ieEHtlcdasJk/5/vgfNYR9iGmwKW/ClQwPolfjQbgOhikq5RA3mQrgwfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441516; c=relaxed/simple;
	bh=fgg15Yg27JB08mBA0GtDWZEmUaLNPMKmwZgSrT6qtDU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E7Iyj+Epdg1MsW3N36pG6Kh4IgLLfSf8SHZQKW9CwTkNNNFjiy968qr1De60LEviLXbtJlfT/nM0ZVcKK8ZdEI4wv5eoS8+ZG51COWIYINV5iNeVHdfdfCdjLmJTYg3yZDUbMSR+tmsNh7v3//hKLL2fFA/NjzBx0eWkOYcPDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yyx9fJHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yyx9fJHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B5A1F00A3D;
	Thu,  3 Sep 2026 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788441509;
	bh=mrrXRP5WGedhvTJkTLeCaK4SnHCZSxURf6dCtjEb8Es=;
	h=Subject:To:Cc:From:Date;
	b=yyx9fJHoOBgNaWG15cx7YnEzLc7cW7maPLVe2RoAAMABY5jtJQdi9ZBWK32wwCnwJ
	 POTC0AXgvkbaVt4M35fzmE3fUTOzpOQAFOaku12U/YEbTUi07ZjM99zftOdLCLF/7b
	 63ygXGQTvy3l/hl5zGUba6TI4GONdoxeTxLOU9uA=
Subject: FAILED: patch "[PATCH] nfsd: size fh_verify server sockaddr slot by xpt_locallen" failed to apply to 5.15-stable tree
To: clm@meta.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:08:25 +0200
Message-ID: <2026090325-sushi-playback-eb16@gregkh>
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
git cherry-pick -x 71d068490098b1d23c63b2345e40675d3a1ca763
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090325-sushi-playback-eb16@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71d068490098b1d23c63b2345e40675d3a1ca763 Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Sun, 31 May 2026 08:06:58 -0400
Subject: [PATCH] nfsd: size fh_verify server sockaddr slot by xpt_locallen

The nfsd_fh_verify and nfsd_fh_verify_err tracepoints declare the
server sockaddr slot sized by xpt_remotelen but fill it from
xpt_local using xpt_locallen:

    TP_STRUCT__entry(
            ...
            __sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
            ...
    )
    TP_fast_assign(
            ...
            __assign_sockaddr(server, &rqstp->rq_xprt->xpt_local,
                              rqstp->rq_xprt->xpt_locallen);
            ...
    )

When xpt_locallen exceeds xpt_remotelen, __assign_sockaddr's memcpy
writes past the reserved ring-buffer slot. In the reverse direction
(xpt_locallen < xpt_remotelen) the slot is oversized and the
unwritten tail leaks prior ring-buffer contents to trace consumers.

The write-past-end case is reachable on NFS/UDP. svc_xprt_set_remote()
is only called from svc_tcp_accept() (net/sunrpc/svcsock.c) and from
the RDMA connect path; svc_create_socket() for UDP calls only
svc_xprt_set_local(), so xpt_remotelen stays 0 for the xprt's
lifetime. Every fh_verify trace for an NFSv2/v3-over-UDP request
then copies 16 or 28 bytes from xpt_local into a zero-byte slot.

The other NFSD tracepoints that record the server address
(NFSD_TRACE_PROC_CALL_FIELDS, NFSD_TRACE_PROC_RES_FIELDS,
SVC_RQST_ENDPOINT_FIELDS) already size the server slot by
xpt_locallen; nfsd_fh_verify and nfsd_fh_verify_err were the only
exceptions.

Fix by sizing the server slot with xpt_locallen so the declared slot
matches the copy length. The client slot and its assignment already
agree on xpt_remotelen and are left untouched.

Fixes: 051382885552 ("NFSD: Instrument fh_verify()")
Fixes: 948755efc951 ("NFSD: Replace dprintk() call site in fh_verify()")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20260531-nfsd-testing-v1-1-7bfa481b0540@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 830d9ceb4fe3..33953d38314e 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -271,7 +271,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify,
 	TP_CONDITION(rqstp != NULL),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)
@@ -310,7 +310,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 	TP_CONDITION(rqstp != NULL && error),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)

