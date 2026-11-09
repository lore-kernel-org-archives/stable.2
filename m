Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221591;
	b=bBkr8ZKaDK2a7FBNC00krLFs5daGAYLrl1CpeuMhnNJ7kFj9gipTBAahTLxLFh5d3H/F
	 LRMOZVb/wkWjj2zZxPGkP5XrbRnPkpIeVfMcGVU/aSd64jH4v/axFMhuvkyixbMym5ErP
	 +nDDHZU/f5pkE9EkUNtupas4/Fj5AQPKQTPugEWRKMfGx0hDVrm/Uh/qp/u2uxp1xp4lG
	 QPp1PUP1QaHt6LemIweKTZQwCmVE0GqbqC/y7ARkA5MPs3QKDViQxza8KO4ORVAnIPkCM
	 YiRHvh0s2mEZs4F66EwPHEUc/286h18bRFQd9BWTPQ1e+mXRfqDW2XAis1hrqSjkoAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
	b=AmPRq4pEF6DHT6NUcsK84FyzY2qgV6Xm3pmLJ/B9oejQXq9/rEGXBdA1BWYPg5m2XcTo
	 9tfXGnsMorcZt3vTDjxyWPG/oUP761QO3vyPLmvG5aw4Z9j0Xc64W8PIpMamvIGrbD15B
	 /fk/6zqmvpy6ZQzwDp56tLI5pJJWTCkO8xzhfYouERw6mthAqM1RYsyl0mVWIJrTIEBy+
	 TZb4gNhSWaGur+k7UGQncBGsQ2MpYn+sidMihPK0eQlGl7ixbJ9zVg4fku9B1sAXZHcl/
	 t/+Z5rFmtvJggmxAYr+L6dK2L9194YttYOO6V82Gro8y4/IVBedkIl9ZqKe/6Ixkb1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=ag8s8wnN;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5A606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CF5A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=ag8s8wnN
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so1347289c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221589; x=1794826389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
        b=ag8s8wnNbir+9Lof0homx1DDFO7cebbc0V5YP8kmlt9OiSkDrztC71N+5LloWADaSB
         MIREdddFLzjBCDaU0rAYi4jtosvgp8pMYdFoMEU1ZNPxC2goflR2DxIb3I9Cx+gb8a9n
         JVE5kUuWlyy1Pf24t6JML2CRYGzkC77vA3Q0zTWoy4dHb8TELmrSXj0P6SBBTQ8CqBx2
         dmAWpkESG9SEXIpJJYKsap5/hJgXdaMdE7I69eWpbbm3+ww6WEfftwIVKPOxXSJ3eRSe
         WDQDkcbTey3ZsEiVlEaOdKz3mo7VVHjP51GUND/XC0H0BWt1eztty6c0/ddDZCK6DL0n
         VXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221589; x=1794826389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
        b=SH4VUUUM22xZzKBS1BwR/gNtgeC6udCGyK+X7wGtFs74tVyCSa/iXWEpKOJmI4DSUk
         6DTCwHyjvMIZTQVazh2Kn8S0CM2vXPcET9Sg5dRo2MNHCSZd9Oqwuy+nE1ZP5gWtMBlL
         Ov45INJUk8rzwJnjv/T+cirmRv8+/qwigCLW71++5D0o35m3l9WJO6HNwMjNN5tc5E8J
         2HZH1m3oOLeqdiUDA/r6jlpRLJ7/yuJKHXh5s+5ktmZyZAMpnU1FMMeksYD14CsRMj1p
         DewWCksVjZfSBLav1yZ7uXpVkTl73mzcZzlb4ki1K8bsuUDalXhtMfgpBXxzhc5Cq/Gt
         d/Bg==
X-Forwarded-Encrypted: i=1; AL+hErEKvcieM0V7pnbHjybb0G1gvp1lcz5EQo2gliRGgbQ0x7OVxhT7u2z0Z91556RYbAr0fkhfgIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lMiDbUtwRDXakYeFVyH4yuAKLdkM2i+BpLzlbIRFQrXTzVGHH
	tQTXttxGgmK6UzuKuos9B+eaFW18Pdh2TG7ejimJaeT/e/2zlt5tRBb2IekHf9R7BQ==
X-Gm-Gg: AYBFou3/Fj0zsOZt/6NTu3ocDiUQJ67EP9GIz4WF6g/4GnI37960r9QhmIghesKzbOU
	E70nr6BpFdX4ODamIfhKUw9JTjjG9g2kP27s4SHGUgd2DKn0JiaRxHbjmVPBoNQowFAVrbDE6Fg
	Vz3DTFZ2q0Hk5i96IddeWf1qO9WPhpXPM69A6Fyc5Doj4Y0+aQraIKwvmdNRwt9wuKExiKayHSa
	ZzuVgydKR7Ju/xaBTi3+Q0C9bWj+ll2mMGe3pBCGGhzRrjIJZ6meWWv/ZEUWd/6oFrA2EGO7jxw
	uARDBwkXU/Jv1Rdzfg+cbC3YmDgPvR0q5jTu8CqFJXwCDBsBjAfausv1TMt/jppWOYS/9bDDFle
	jXYdWFlWChOi4zl3ppB7eLY9MGNnmNFp+icA+85oMKsvWwYX1ZJjLNQm0xhmtMD7vaMwOT9hGzu
	ksTcrHKNmoJV+QQ4iQsihpyopT98wyRgRyX/7CgX5bXy1tPTcLORWdH7P08/EtBWUpo1Afx+69k
	39NgPGLXMHo6M8ZjsR51+YwaLaDExnGxlTteVfuyEibN2ydkM5Iwzi6WRPNW7aM4Wix/SynvZ5f
	dy+Up9QnxYxAI79Dvi7Dep6NdoIG5HIoztp4Ew==
X-Received: by 2002:a05:7022:150e:b0:151:6e80:baa9 with SMTP id a92af1059eb24-1b39fe7f403mr6653083c88.12.1794221589238;
        Mon, 09 Nov 2026 02:53:09 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:08 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] 9p: take the tag of a flushed request from the request
Date: Mon,  9 Nov 2026 19:52:50 +0900
Message-ID: <20261109105251.2545764-5-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

p9_client_flush() finds the tag of the request to cancel by parsing the
header of oldreq->tc. For a zero-copy TWRITE, however,
p9_virtio_zc_request() adds the payload length to the size in the header
after marshalling, so p9_parse_header() fails on the mismatch with
tc.size and no TFLUSH is sent. As a result, a zero-copy write
interrupted by a fatal signal returns without waiting for the RFLUSH,
and the server can still write the data after the writer is killed,
overwriting a later write to the same file.

Use the tag in oldreq->tc.tag and drop the parse, so a TFLUSH is sent.

This patch is assisted by Claude Opus 5.5.

Fixes: d28c756caee6 ("9p/net: Fix zero-copy path in the 9p virtio transport")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/client.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 66980ad52bca8..15bb939087165 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -477,12 +477,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
 {
 	struct p9_req_t *req;
-	s16 oldtag;
-	int err;
-
-	err = p9_parse_header(&oldreq->tc, NULL, NULL, &oldtag, 1);
-	if (err)
-		return err;
+	s16 oldtag = oldreq->tc.tag;
 
 	p9_debug(P9_DEBUG_9P, ">>> TFLUSH tag %d\n", oldtag);
 
-- 
2.56.0

