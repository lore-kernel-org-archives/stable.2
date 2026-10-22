Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640819;
	b=Q8oRsDON9x+kvei7Ln8h2+EA8frsw5jw+qXYcJ+94aJBR0StUtbjxVjHtZ7EPsIwNya3
	 QiLLb2hJwaQ4p0gXxmNi1hykCye/njFbUIPugN0uDX3wDDHyfIlGdKTMTEfFgh39orVbD
	 0fhk+aDiZ7HyM5xIbIBG2LSgyRbP41e0SxaUmgzxDdhwshG/UV6HbYDyOZqCXhysgMmQC
	 cRZzkiZ7yxr+1QoWtEnpid/JMG7C9wd/FEiFNzxVlHoOp0QbFyHIo5yRHKI2ca5hGL41g
	 fd0YMUA0kyU52pMHgiGL3BnR+y5b3EbDX1Xl+OXqRu4PG77MRCvkmE48dRWG35hRKNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0jQLJmqmIBQ6in7lf/1E2WWXreaHdLkXv/DSKBgYzko=;
	b=pqWwtBvseAnXI6xov6dzHycYTg/JQ+NeTA3s3rMy+IekcnuPTjtNqUWQppSrnK6p3VwH
	 45/Feasy+HbvXlzc1SUGtISJzVNMByiiJI4RI6cohmtfbOTjEv4gL4QGiYbNbkIWEQMGM
	 61cC8hOu/SsPKOxru7HO8ECGSlBzPI5iYZsGbWoQzM+1s2D6PzJsjX60C0KAhmfXlTkBB
	 5e/rzajKiMoApN8Mnhzf0cvX7vYy+woG7lp8F0bA9MZMHMKZJaKriucAXqf0gkR74OOC4
	 A1bNOvGzDu7b8vuq9h1ZHZrWO2yx7ywAXtBdXG8DkvOhF4X3t7zYVM2rm9JTXvbIc4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oCZSKDMk;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C0606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A69C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oCZSKDMk
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3550c917fd3so1920303eec.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792640818; x=1793245618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jQLJmqmIBQ6in7lf/1E2WWXreaHdLkXv/DSKBgYzko=;
        b=oCZSKDMkAZ03uxaC8hvG1XavyDMo/wWix60dsDlKdquTHLMNvr+57YAiOjkqq2iipQ
         +WLXM7KMF7I2+V6RoR/JYgTdFEr/NE8Qp/mZYNF711+zs9FyjnOIPfrm+OQDrI2lX29n
         +gZzgGcvjiKHu7cd9g8+VXCPhlhFt+F8mTdxOY6rcdJ7dAOtu4mLoGJOsFpPJioGci1t
         lWMjMZZ7rVXpUjFfnpq4rhgorkdlZW5wow0MIVHERPyniaPaPrA3GkURSjwVpB0wCDfV
         Tnq33121Ht638fCuYE5o2Y5uxqY2OWpVSND/oh7oKa7KF+QrzNC26pwfJn7DUNNvlmdU
         hWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640818; x=1793245618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jQLJmqmIBQ6in7lf/1E2WWXreaHdLkXv/DSKBgYzko=;
        b=PbncNCnxUmxzlM0B1MPk5KIUyhz0FC6CGRWhHR9x3+8PxV+X2Ca2+d9FSd6AVPuffj
         w9brQJtbPIRU9+LDeMO8OkSkq6X59SSQYU0kLosOZItcDeGto6snWtIFxPOrba5xL8jO
         XLIrvRlitRAUsNZXsZTXZsQcdQZNnsNQxhaMsmIc3/r5xEsaQAmd+mcQhRt6yZra+4jf
         kbQmuN1qpgUE5i0i83ffeNFVqbo315fR5G5vFt0y7LDrldhRPDx07PhTbFP+b+Q/Rk1P
         4p8uCEmM9msZ9GFjHub+ObNO+Af5IOimMilHqo+txKLLsB5C09H2DuPTHFX6fXNmgRaJ
         hdkw==
X-Forwarded-Encrypted: i=1; AKwUvBw1xOX07qqqrFMUh/waP7yBFZ4LoQHkqNcvaIfo4Cw13AbD1q46R1lsUohv3zvlLAOc+PtMtp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbsWoB0oT1fk9jjo27a4UvdhEVkqwrUriswhfa/UvNURnwYCBJ
	gAA22/7Q55r92baWRwYAYMv7D8DRSg7mbndio/TUt8vVaegl4hSuLDMQ
X-Gm-Gg: AYBFou3Tl5Yg6jTOnt/RPSOE/6KW1USXzMJum2fgeMGDHEJUY+1ddSiZTVT3i71Rjy1
	X2T4kdojlJP4m6xwGh49k/x6SbL25raAvJTxTCgQBEIiBzwT9hVkpLojNpc+URvj/dnOq6UKTzM
	nIX+XBo7AmNYUSOKK4in0ayt96ZSLVqlz7tUGuGEVAX+SEtCIxkf0mLbK/80E3q3wsMUAvWjrFe
	WFjj2m8hjo4fh9jA0f9cBDqbdsPy+eEpE0W3vT+9pN6bqyzXRUmyXqHT/D0/gAIlngVJWtFdQz0
	RWGjK68KCXB7tXimPHpRbidl3mMZVDkPm24pOMO72WACYUFBvzKCaUF8mqvKA9+ElTvvPFSHVLg
	6Iha3km0t8775JVEGp5x3ZC3yP/ZzdNBp9z3VVD+cKIIknisshsjXZuQJZ6gGj/Lm9OWua7bjeg
	WxFsHv7TYWk4eKyDEOnd3DJZK+xWycaWNR06dB4NQUNBPaYOYv8Yt6W/0n1GhITzaPDTIg15GEj
	RZ/r1/HEjxlUOtbWKdi9v73Qg3HEBe8pUW614N42jQxkX0sGzQ/xPUjPAd9RpaOyJNi/A1oIjjp
	K3E0KVwGEwBUPzSkAFtWEHaDF6l3i1cqiAX8F7tCPG0=
X-Received: by 2002:a05:7300:c001:10b0:367:41d7:9deb with SMTP id 5a478bee46e88-3674d757a7bmr5710810eec.33.1792640817604;
        Wed, 21 Oct 2026 20:46:57 -0700 (PDT)
Received: from muumthf.localdomain ([123.215.20.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm12055038eec.13.2026.10.21.20.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 20:46:57 -0700 (PDT)
From: Hyunsol Mun <muumthf@gmail.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bobtobabz@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] svcrdma: silently discard undersized messages
Date: Thu, 22 Oct 2026 12:46:29 +0900
Message-ID: <20261022034629.430954-1-muumthf@gmail.com>
X-Mailer: git-send-email 2.53.0
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

RFC 8166 requires an RPC-over-RDMA message shorter than the 28-byte
minimum header to be silently discarded because its XID cannot be
trusted.

svc_rdma_xdr_decode_req() instead returns -EINVAL when the fixed header
cannot be decoded. svc_rdma_recvfrom() turns that into an RDMA_ERROR,
whose encoder copies the first two words from rc_recv_buf without
checking rc_byte_len. A zero- to seven-byte SEND can therefore return
up to eight bytes that were not supplied by the peer.

Check the complete minimum header length before parsing and use the
decoder's existing silent-drop return for undersized input. This keeps
the error encoder from reading beyond the received message and follows
the protocol requirement.

On an unpatched nfsd-testing kernel at 764ffa45f3f2, a two-VM Soft-iWARP
test sent 128 complete 28-byte bad-version headers over connection A.
After closing that connection, it sent 128 zero-byte SENDs over
connection B. All 128 zero-byte requests received replies, and 56 of
those replies contained the exact XID and version markers left by
connection A. The test process ran as uid/gid 65534 with no effective
capabilities and NoNewPrivs set.

With this patch applied, all eight complete 28-byte bad-version headers
elicited replies. A zero-byte SEND and a 27-byte SEND each elicited no
reply during a five-second observation interval. A normal NFSv4.1/RDMA
mount, write, readback, and unmount completed successfully. The server
remained running without an oops or panic. Both x86-64 kernels built
with GCC 12.2 and CONFIG_WERROR=y without warnings.

The vulnerability research and validation were conducted by members of
the Tobabz team as part of the Best of the Best 15th program.

Fixes: f3ea53fb3bc3 ("svcrdma: Use correct XID in error replies")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunsol Mun <muumthf@gmail.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index ed5a83e9edd2..f2fbba4b30d4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -714,6 +714,9 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 	__be32 *p, *rdma_argp;
 	unsigned int hdr_len;
 
+	if (unlikely(rq_arg->len < RPCRDMA_HDRLEN_MIN))
+		goto out_short;
+
 	rdma_argp = rq_arg->head[0].iov_base;
 	xdr_init_decode(&rctxt->rc_stream, rq_arg, rdma_argp, NULL);
 
@@ -758,7 +761,7 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 
 out_short:
 	trace_svcrdma_decode_short_err(rctxt, rq_arg->len);
-	return -EINVAL;
+	return 0;
 
 out_version:
 	trace_svcrdma_decode_badvers_err(rctxt, rdma_argp);

base-commit: 764ffa45f3f2189cd86ec6d46d248fc0440507b6
-- 
2.50.1 (Apple Git-155)

