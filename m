Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630314AD7E4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441520; cv=none; b=bCcBu6/D1xbtDLSfMM8r7PRA+5tp2aJiyTWFG0GQx1ydU1lk9mAFSIGXTf6yJgjnT4jSIQOiqbU0fgcMTM/bKKokwy/fnbHL+j8ijFto42rJvmClTejbGSVm0xtvkCEmqK3ARWTJ0oGNAXCJC0Yn5pqw2istxcMrO+IMYphFhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441520; c=relaxed/simple;
	bh=+b4p6dlsf5z7TSXFUDESQBV1NZk1cDYjDirJ+hIAEfo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gVPLvrOmx9YPPN01eb4lKHWH8TifbC4ev+ZMEoeQdS82ssFG+nViG0LQLtSrhHdjBp74H7/Jsx9N3i8eATYO1CZRwAHkDGuSop4VlpXE0NM84TOsGiY2Hcsxi7RMRwwXPjEZa9wK/93q5EV4o42Mam+TCjCokpx0AmvwnIwgqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ETAKSRBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ETAKSRBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D5E1F000E9;
	Thu,  3 Sep 2026 13:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788441503;
	bh=wQugEauPjf/tcqw9AbicB55w/HifRbpi3douO6c4J6w=;
	h=Subject:To:Cc:From:Date;
	b=ETAKSRBHet3I+dHcIZtPdkKVtnjCobgLbhAzF/dtXkaXNur6afi7qs2cpq5sHmW/i
	 gB+8aQ4iwh/eZ+vrL+iwPJh4iVsa9zI4HNFcryepe8Q8M/8+tQOup7Rb5UmqHovkNS
	 i4WEDhUac1L8WfeL3GZPrw4/D54lR6lXBj4jt+W8=
Subject: FAILED: patch "[PATCH] nfsd: size fh_verify server sockaddr slot by xpt_locallen" failed to apply to 6.1-stable tree
To: clm@meta.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:08:24 +0200
Message-ID: <2026090324-certify-credit-45c1@gregkh>
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
git cherry-pick -x 71d068490098b1d23c63b2345e40675d3a1ca763
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090324-certify-credit-45c1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

