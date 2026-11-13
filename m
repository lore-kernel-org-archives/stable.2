Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565614;
	b=jViK5M/vb98PX3Pm4HO7UdhlJBPSCFCINqqitjTaO2O7yM7syeJEHgIel1W84S94pt14
	 F/BsC49r5Ey+VQJftI5w5ihknNwfpnmhUaH737kqAq2U0wpIIfc51qFFTgmPzXNEvkT3Q
	 wiwCGL/0jytko16ebCPGEWLcKc6ZF2As6QPUjplJsCOvA75Hvav21v+Vxia6XFC7HZ9Z5
	 oqnZmxu59FMqaglFEDMJmtmgGgNCnALutQFH6tuEA5DpfrhloVN/dNfbrF4hYvPr0Ebql
	 myvQlwOV1GIZDNPl0GcQSvSZbi3kA6MD7w1slCnHU1jmPpsnSOWbXGrF5thHL5UCTJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565614;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=wn/jw9iu4lSTigZEKz9jEcTglHusaDZG1QQsdSk9ODc=;
	b=5RAVaEVOm2XIZctk4U1xoVuxfYW96LqoESF7aiUPAYnreEllbwBEQHdFWlHrt6CzwmEU
	 2mmc+Ll4ODr+hTnLlzoRJP1qouFVCTmbmtjSAv6ZCVw16AUiFRMnyIwB60i+PGPWhwcMq
	 5lG3HkD23W5d63fRN84D3wjVViktCUseg079DmdrIGZmScOcqtFFqRf5+WJDAgJvvIu1x
	 lj7qC7sme43caqKqEvqxGlSEo3LmbdS4PKUedI/U6SYt3XdPvRYwg5Qja1YC3hLq1KQl8
	 tmwLfzB2PfQBfMAkfABWCgNWWGeI+Sa3DKBxtr04vxlA/pmyfQpSYf721FW6Zho9tKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=BotOhErs;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E94606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=BotOhErs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794565614; x=1826101614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wn/jw9iu4lSTigZEKz9jEcTglHusaDZG1QQsdSk9ODc=;
  b=BotOhErsCiHGJkzz9ZDzDbZf/98Si3zBFycMlfhMGLTrL9tx+pQYE+Ac
   PnhEODPCHmHPzpQaXuGYrY0ykVHpTpNOdvXZ2CB5C8Ukt8uzg4VKGamVx
   daTV0avG3vIJMaZykbId/+C/istXAGaE9QW3p4lLYcBl3iYrU8ukIPrNq
   hHUlETMNnImLwoYYiVtE2L0SEO2xgfLa/tkzGO5cFb3VaBOGS7DAcGSSt
   VY37TE0u1L1J3Qb4xkIi1j1N0vLwPY++lLMGcr9J0JoNMeEHpAYjwt9jW
   bjHPAwRlxno3fpRSYsjb+Zm6nr5/xRlIymWjCOxDgjhyYb+msaABwrx4F
   w==;
X-CSE-ConnectionGUID: WUyFswDwQYOhIPR7DlW5rw==
X-CSE-MsgGUID: go7bJnjCT5eHrSDaAahrMQ==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33779541"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:26:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:5128]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 2ca17aaa-cbfc-4247-baec-f42d3fe65b15; Fri, 13 Nov 2026 10:26:51 +0000 (UTC)
X-Farcaster-Flow-ID: 2ca17aaa-cbfc-4247-baec-f42d3fe65b15
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 10:26:51 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 10:26:50 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <cel@kernel.org>, <bug-report@moonshot.ai>,
	<yilinzhang@moonshot.ai>, <doebel@amazon.de>
Subject: [PATCH 5.10.y v3] SUNRPC: Copy the deferred RPC Call from the head buffer
Date: Fri, 13 Nov 2026 10:24:27 +0000
Message-ID: <20261113102638.2399947-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <daily-reply-2026-11-12-5417451315@kernel.org>
References: <daily-reply-2026-11-12-5417451315@kernel.org>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
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
[doebel: 5.10 backport. Here rq_arg.len > head[0].iov_len for every
 Call at svc_defer() time, so the upstream guard and copy-from-iov_base
 cannot apply; keep the skip-based snapshot that svc_deferred_recv()
 expects (5.10 still has rq_xprt_hlen). Only gss_unwrap_kerberos_v2()
 breaks the len - iov_len invariant, by resetting buf->len; refuse to
 defer after a GSS integrity/privacy unwrap (rq_auth_slack != 0) or
 when len < head[0].iov_len.]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
v3:
- Rework for 5.10's accounting per Sasha's feedback: keep the
  skip-based snapshot (5.10 still has rq_xprt_hlen and
  svc_deferred_recv() depends on it); refuse deferral only after a
  GSS integrity/privacy unwrap (rq_auth_slack != 0) or when
  len < head[0].iov_len, since gss_unwrap_kerberos_v2() resets
  buf->len and breaks the len - iov_len invariant.
v2:
- Add the "commit <sha1> upstream." line.
- Document why the backport differs from upstream.

 net/sunrpc/svc_xprt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 60782504ad3e7..8970abdfaab46 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1202,6 +1202,20 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 	} else {
 		size_t skip;
 		size_t size;
+
+		/*
+		 * A GSS integrity/privacy unwrap can reset rq_arg.len so
+		 * it no longer measures from the start of the receive
+		 * buffer (see gss_unwrap_kerberos_v2()). In that state
+		 * len - iov_len does not locate the buffer start, and a
+		 * snapshot taken here would be replayed without GSS
+		 * verification. Refuse to defer; the caller fails the
+		 * request and the client retries.
+		 */
+		if (rqstp->rq_auth_slack ||
+		    rqstp->rq_arg.len < rqstp->rq_arg.head[0].iov_len)
+			return NULL;
+
 		/* FIXME maybe discard if size too large */
 		size = sizeof(struct svc_deferred_req) + rqstp->rq_arg.len;
 		dr = kmalloc(size, GFP_KERNEL);
-- 
2.50.1

