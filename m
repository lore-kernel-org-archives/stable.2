Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491766;
	b=FwKHwJYjwRWU63Aoe7WISOf374oRSefrQ6mUofrVsU/1XCJpISpUQ02ogN39KxzDdXGX
	 aJibCsR9gEY+7bXNb0sfPMEthvHx3NTdKqfrSAhXOjcvoMAo+UhVuPuA/4LWWWSjYhx6a
	 mHFo0bQ7ajZ2I5ZhVKN4RvUVb9jpRctyBz9Q01RpOVQPhb33bLGwhC3Ujc2NotDHVqaGa
	 BzZCdhK9fnGSnZVK3dIV6y5TQEmPI+QjuHnyJh4WnVi32RApie5vUWf6lNfGN+wu5kHsc
	 lx/TszZ7xELxfjIqv23p25zgqQyruBrhM/ChCR5e8qLgfJrkYq28OLruIOq2sQRy65w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491766;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=eWnA9J1ky/G6CgXvOtU5iw1/5fnClz5aMTlWKYAXQSE=;
	b=D+ttXpbVhvkuXt/mT+/xxgh7boE4TX+Gkm2/0A2i8z6OPmqSrxpCgcWOHI9+KLQqDCh/
	 6gM3peg+AHgacH9yabv//aGJ09eYx95cqu2ncX+goTH8jloekZN6UfB6cMJmX9HNgFfrL
	 7S6wmz8uxE24w8FbBdsbvgTxJxyEYSD5cK+CYWpS7L/TzjP1MLkHGpZeHRx86i1dpGih4
	 6QEvAAeCzeRDAbi5og0evFpRFxhIop13hfCrXy5AgIRRPJAVpvx6Wyi7EMlB/ScXXV1Dz
	 zpvm2RCd8wUUiBNQJ/YjKncjAcquIN2pbK/nqf7LfCyzq1Qq66yp6qMxGHrsD33kX8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=dlBFsB8h;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C7606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B55C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=dlBFsB8h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794491762; x=1826027762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWnA9J1ky/G6CgXvOtU5iw1/5fnClz5aMTlWKYAXQSE=;
  b=dlBFsB8h80f/XAFwdkYbOV5/yI+yMMMvfJx/WsZHsWZPH+1aqjkmOauE
   cea3/yFImq2ybbGbrVX4EacIa3WxQVpl+NVjVKKd+FRAnheyACs05RRQd
   A+ORTcWY+FrgiWsjqvcovK77iqB3Oi+DErdnzDYkFVn6kzqHGM9Ax/HjP
   Vp9XI4cqkmd+Z4DkIdEYFXJdyTho4ddk25z6u3C228NnUDh90lMX+M6H7
   YebSSpn41Q4twx9DPmQfuFqyBmoKEBrgDSXWXCSlFumctp5wwdIjW3tbi
   hj1WnZRYR4cxiIzZb5APDFjB+Jbd52w/KK5pFpfz1n6dNRe5yFdVXyG4m
   A==;
X-CSE-ConnectionGUID: Ue4WbfGyRayT7kzAa/6V0A==
X-CSE-MsgGUID: pSoRAG/yR9Giax4WrrB8qQ==
X-IronPort-AV: E=Sophos;i="6.27,209,1787011200"; 
   d="scan'208";a="33816383"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:56:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:13511]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.127:2525] with esmtp (Farcaster)
 id 21c9a8af-a2b3-443f-8fd7-9cdde0783d17; Thu, 12 Nov 2026 13:56:00 +0000 (UTC)
X-Farcaster-Flow-ID: 21c9a8af-a2b3-443f-8fd7-9cdde0783d17
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 13:55:59 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 13:55:59 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Chuck Lever <cel@kernel.org>, Kimi Security Team <bug-report@moonshot.ai>,
	Yilin Zhang <yilinzhang@moonshot.ai>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 5.10.y v2] SUNRPC: Copy the deferred RPC Call from the head buffer
Date: Thu, 12 Nov 2026 13:55:43 +0000
Message-ID: <20261112135550.982415-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261112134001.952224-1-doebel@amazon.de>
References: <20261112134001.952224-1-doebel@amazon.de>
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

commit 2192a56b0686599358909c3e12e9a366f5b5d452 upstream.

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
[doebel: 5.10 lacks 983084b2672c; keep xprt_hlen and its comments in
 svc_deferred_recv(). The removed skip is zero for all 5.10 transports.]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
v2:
- Add the "commit <sha1> upstream." line.
- Document why the backport differs from upstream.

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

