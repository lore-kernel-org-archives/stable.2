Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC4350298
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573611; cv=none; b=T/3iCF+Kludf7FDujpVMCND88ZftY2FhhVsoEYCeXi1y1isbvyNFBrXi4bMRHJgi0V9qYDug9rMZ/gPiOqeC8dnOauAJXSf8AbD/u6C1K+wMYYkeSR71oA38gPiPt7IHnjM5GcdMpWK6X1uT89fahpU5E3sdMySMIQJAkmaHWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573611; c=relaxed/simple;
	bh=Elfp7dnRdk4FxTactG8Wfhh5xV8qkinwI7O2zdVlZt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uf7ONE7r8QjVjML+/o+SuLDnFPGw8uroXFW6/qRPLKrZqbDW+FlelAgU14Bk0D4ldTDMlW7yxKC7T3ouNBXyCtIPzp7j0rmgMfSvabZwdb00SXDyiwgkaGOOrzT5rDQj+ty5/eNpknnmNIdppv4h+ReXIeb9DfhfzjCXG7j21z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1SNAZuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1SNAZuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5ED1F00A3D;
	Sat,  5 Sep 2026 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573609;
	bh=Sdg58D+kV+zL21U5k+kzhhRCtKKwg+gEZbunSkOBAbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1SNAZuu8wunETT0dfnc/1F3984fbUUaBfEKLYzeVPF65yS0n7iMeNILyorhnhHDM
	 6i0d9uPeUyaZo+/gVijcvIHwJMRjInHoK7oOLTjNumTnA5qY9di+zhdHSCmlRtmC5C
	 r2NMz6lJ0lbwhZbFQPhec4sFrBZnb2hQSjvL5cK6P+/hOfp7CwYMyQwnK7l6aE65fr
	 Qb/iNfIF9aUGnRZTC/K1kE7Yif4QtZ+DeBo3bFrw4mbkzeEdKT0PqUGDoL5vSTcU8y
	 nwzLKcvGvKfzV6aVS2qAmJjKPqN6IHzn+/z3FYRI4RYi3Dopsf0Yxjwu0BwFd8vGC+
	 muY+fm/RApQ5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: size fh_verify server sockaddr slot by xpt_locallen
Date: Fri,  4 Sep 2026 22:00:07 -0400
Message-ID: <20260905020007.1827087-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090324-certify-credit-45c1@gregkh>
References: <2026090324-certify-credit-45c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

[ Upstream commit 71d068490098b1d23c63b2345e40675d3a1ca763 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 447b3483f94ba..513245b3697cf 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -201,7 +201,7 @@ TRACE_EVENT(nfsd_fh_verify,
 	TP_ARGS(rqstp, fhp, type, access),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)
@@ -240,7 +240,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 	TP_CONDITION(error),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)
-- 
2.53.0

