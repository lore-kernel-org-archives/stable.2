Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4994CCDFD
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788574425; cv=none; b=F4UIYvyo7pMXlTJZxq0KxBP69p1G3y9WkSxhwxEsdbomSa9okmxLUumIJYIAzmNZHipKkqS+I1jCSHg0l0sSIlKKUm0uEjEY0+foF0JZaAfXPzaWmnvdqmhJGQWF+fdVgox3EPaT0P1kzmeNsBDcS8TtEh5hkQAub50g+J3vPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788574425; c=relaxed/simple;
	bh=zABklw45QzdGFuubtIaw4uqRRh20qY9DBfFxSTKhJpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6T0OGtUhxuHTacNGlPtF5T0fGsNP3ZqS8czuXUCFMWqNSeJKpmkjoec5ensLTR73mpWVFIU3mWAQDDqDLfwvLG120nYOrXAOSxjkWzBOcBxaFyd/oz0RSfeF/qv/KtG895Wa/35f+pZRbABv2B7v872gLOl42e4FcT1/VUt2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOVYQfhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOVYQfhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493201F00A3E;
	Sat,  5 Sep 2026 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788574423;
	bh=k9G0add4aYc6uS69AU1uY+DzOT16E8QtFViO1KrSZ0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOVYQfhVdlNNIOzI/5dl6onTN53/rCrZIVs/t1iZB7FC1+vSq+WVo+HSRxYklBJ7N
	 Yj7lRyV6mi3KfqkFTsy2ApBAAsaWoj1K1Xvejlew02gB10HWYUZv0GTzDQO2rBwGxO
	 gDpRR/+drIyYNL2i8mS4uQeuNWp7ut1U320IAbMDRhrFMKcuMGIlk3LCXYqKeHM2dK
	 5GPlPrj/fAxzbaKu4rsE9vpdbDjtcSEXRX7vOH6A4BKHfVFmuS8R00DbW37kd/HT06
	 YSyg42o5LnZXc4sn8mYlHA6Sa0bB7Ma3y/O3AXQgINRbmjabS2WP+x8c5ByZMMuZ8P
	 wEJpXhPDmyFgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: size fh_verify server sockaddr slot by xpt_locallen
Date: Fri,  4 Sep 2026 22:13:42 -0400
Message-ID: <20260905021342.1845867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090325-sushi-playback-eb16@gregkh>
References: <2026090325-sushi-playback-eb16@gregkh>
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
index 91e9921db725e..bc8abf74a4cd3 100644
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

