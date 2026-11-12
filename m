Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490851;
	b=ON+B6VnharxTbzu00hIptkaQjjFeZii1CXI6wlAJsf7XtnnkoHRRccdp3wfEP5MQ/aSN
	 SZfOeUa1Yup2qSd1oNhmqGtu0s3zvKveOrEgbEXf6BQ6nVPdV8P80iKjYHMoUMpPjCVU2
	 ZDfJX+5aqBfD0IN3a5wNwIw/MU0MRPDfepegPIj1D7QzM04QGrAOOcHYZbgP6piiUQiM1
	 nKwbbEFSqqmPlnuKdEQu+FLr7YQA2lHS/lJUCzk+XNj76lEKVplX5nw/SjauZNZCN+aV9
	 On7n2227BfR0U+tSwcml9xJgeaBVCvV6/ICBR5je23d36TcqDZskkhIwIEp2qAy2fAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490851;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ygzKumdFGvQaIDTCQliO69zd1wuQPgaITBrkHvNaNxM=;
	b=GQeFnptRITvk5jH0lwfe+CYm/r36jF3YV8gc8sblKjca3xUKCKvl9ng/5J8LBEkJEYLv
	 BOJU4URTu7qUIE9epvi01lR9s4+gyMi4yIsKEh5Z1Yx92EwrCpK3D4+Ys/Korb/O0+6gT
	 nL3iYIheWgWXBq+sQkR9RDGULI/CMZ8spm5NlbBQCQtmnsakt8oNXCKw5TtOjP+wCUsmu
	 +Ed3wG5DIftaZYxf+vkgfQ6954ncrP1vXZkGu3jEaYv1EqkeDNC75V6nP0loo0wd+JRLP
	 xj38WYR7iTl+PAuEsop6f8e+pj4zPRjmXAOq1gxRhz8Y4JyJMNmZwz6QJE6jsKSMiwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Ob9wTL6l;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A740D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Ob9wTL6l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794490850; x=1826026850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ygzKumdFGvQaIDTCQliO69zd1wuQPgaITBrkHvNaNxM=;
  b=Ob9wTL6lJF9w3VP8ekO6EK6dVMhhBD4EmUi7VQz51p9rjgPLg5w704gd
   YY+l4SEBzKt6r/CDO1apqwdj3qTREx91t36VPowUJYMPkoxL36BluRWx+
   q9Nzwd7HMJpwqZOhJj6Vqg7u4JH1DNgZ2uM2gtEOvsMVdwpWJ4TMI7nh/
   VdPT8DZA9xbsJZduVEy75SUyzTcbODVqnQu0QOyTmSzCduTaVVWJw8Lew
   91lxsKdzjClyRzS6faM8c7TzcF2FA3yX0XqmyQU0Sjc33aHq6jFLih8fC
   TKZAzHH6mGdTEfb/qnz9FbDrKVDdGblT2VEDT+dQjZlnAFBAKlqvbgHxs
   A==;
X-CSE-ConnectionGUID: 4bGvxSNsRM2ldG3iz8jhLQ==
X-CSE-MsgGUID: 0YQerhi/Try2CX/v3PC6gQ==
X-IronPort-AV: E=Sophos;i="6.27,209,1787011200"; 
   d="scan'208";a="33604009"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:40:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:1821]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id d2f331ea-c37a-4d0f-b2da-69c67288c1ce; Thu, 12 Nov 2026 13:40:47 +0000 (UTC)
X-Farcaster-Flow-ID: d2f331ea-c37a-4d0f-b2da-69c67288c1ce
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 13:40:47 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 13:40:46 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Chuck Lever <cel@kernel.org>, Kimi Security Team <bug-report@moonshot.ai>,
	Yilin Zhang <yilinzhang@moonshot.ai>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 5.10.y] SUNRPC: Copy the deferred RPC Call from the head buffer
Date: Thu, 12 Nov 2026 13:40:01 +0000
Message-ID: <20261112134001.952224-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026110458-walnut-distant-f403@gregkh>
References: <2026110458-walnut-distant-f403@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Chuck Lever <cel@kernel.org>

svc_defer() snapshots the RPC Call for replay once a pending cache
upcall resolves. It copies the Call starting (rq_arg.len -
head[0].iov_len) bytes before head[0].iov_base, a back-up that once
covered a transport header. No transport has had one since commit
983084b2672c ("SUNRPC: Remove svc_rqst::rq_xprt_hlen"), so the two
lengths are meant to be equal.

An RPCSEC_GSS Call breaks that assumption. Unwrapping the integrity
service truncates rq_arg.len by the length of the trailing checksum,
and unwrapping the privacy service leaves rq_arg.len short by an
amount the client sets with trailing bytes after the wrap token.
Neither adjusts head[0].iov_len. Both lengths are size_t, so the
subtraction underflows and the copy starts past head[0].iov_base.
Every deferred integrity Call replays a shifted snapshot.

A deferred replay skips GSS verification, so a shifted snapshot runs
as an authenticated Call. With the privacy service the offset is
client-chosen. A forged Call placed in that window, naming another
user's GSS context handle, runs under that identity.

Copy the Call from head[0].iov_base. Refuse to defer a Call whose
length runs past the head buffer, so the copy cannot read out of
bounds.

Fixes: 260c1d1298f6 ("svc: Add transport hdr size for defer/revisit")
Cc: stable@vger.kernel.org
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Reported-by: Yilin Zhang <yilinzhang@moonshot.ai>
Link: https://patch.msgid.link/20260902133101.48914-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[doebel: 5.10 backport drops conflicting comment-only hunk]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 net/sunrpc/svc_xprt.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 60782504ad3e7..a8bd4f7f9299d 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1181,13 +1181,8 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 }
 
 /*
- * Save the request off for later processing. The request buffer looks
- * like this:
- *
- * <xprt-header><rpc-header><rpc-pagelist><rpc-tail>
- *
- * This code can only handle requests that consist of an xprt-header
- * and rpc-header.
+ * Save the request off for later processing. Only a Call that fits
+ * entirely in rq_arg.head[0] can be deferred.
  */
 static struct cache_deferred_req *svc_defer(struct cache_req *req)
 {
@@ -1200,8 +1195,11 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr = rqstp->rq_deferred;
 		rqstp->rq_deferred = NULL;
 	} else {
-		size_t skip;
 		size_t size;
+
+		if (rqstp->rq_arg.len > rqstp->rq_arg.head[0].iov_len)
+			return NULL;
+
 		/* FIXME maybe discard if size too large */
 		size = sizeof(struct svc_deferred_req) + rqstp->rq_arg.len;
 		dr = kmalloc(size, GFP_KERNEL);
@@ -1216,9 +1214,7 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr->argslen = rqstp->rq_arg.len >> 2;
 		dr->xprt_hlen = rqstp->rq_xprt_hlen;
 
-		/* back up head to the start of the buffer and copy */
-		skip = rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
-		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
+		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base,
 		       dr->argslen << 2);
 	}
 	trace_svc_defer(rqstp);
-- 
2.50.1

