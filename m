Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457233;
	b=AZeFXeBI0CB7dIAjXsL1nk76+VM3xuDv6W2ESKRmf/VghFeIq+m+eomR2Q4SpHzcv4yW
	 fc3KSxJ+aKs2L6UcRnG/iEp3vTp6aCLMoUFx6uYhn1s+nZHJHW3f6eMuKFkdtQQQLCWeh
	 XimMNHF2Bp97mLZm0mkuknwAnLMHxLqxjFCX4tBIiAYPHmU21h0TY2u2KSC1A+AQSf7hd
	 E71bFGVE+TRr85B5lDltu28P7tlLSbgbdtEVPCCx0c+eJATRpQy+KHhwcstWDtFT5hyXR
	 dP8ntJ/4+d3hgdA8HoG2qUl7fDdcQ+ECv5cJD1Bm71R0TwL5bN8bWfSLdYuzPdFrLKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457233;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:X-Mailer;
	bh=AHY2CyTjetiwXuBqBJRqvDGqniqWKKNoLB5jad2781s=;
	b=go9mNIHqCqt4nqW4FSzbR2pq5fv1I+Ve3Y3YkZS/criv2V59RoG3HymBsTRC8Y6DmM/w
	 sUrFweEh9GBlKC1mlDOnEX0hFZhyeqIq58DPhVlV4N/WIAUpHhspRJ8vt+qMK1WRuZgIs
	 4JO4NYgu8YXOYz2n4j1DyiPwe93GABZmH5eoqww7xRiQXhQQNYsvO6Ib0AKUa6DbkLw+x
	 bDRwIE9sPklMWkIY4l/WfR5g4otPlJUDL8HJ9O2bBeXxkgRcnuVXLxZwceavMua22zMX3
	 VJLzcqVyHJUvkElaxuhmoo1/6W1dZumOP/iCllRDChHDWhn4jdJ0Gh1gupjsUZNYikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=kJR+HTxg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="A/TQESft";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC220606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC220606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=kJR+HTxg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A/TQESft
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0C3814003BE
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:07:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 13:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1795457231; x=1795543631; bh=AH
	Y2CyTjetiwXuBqBJRqvDGqniqWKKNoLB5jad2781s=; b=kJR+HTxgyz8gt8q0Zi
	JRnha0ApeWRE1kVuzXfwZgI8qRc5r2YyUyGHtJXZkIsh9PyL4j95MQCE+M2D+5Yj
	xxMvm+sKQLJAvG7gDi/MqIXu96yA1PS3Jj3i+n0K2bGAdCkcf7h5+z3xVmPewZOI
	A/ZCIs81bawRRWGUjX80yUjh+Pr2GpeMTKklugQ3nTzmHqiXdWkq1xkBS5axWG+V
	uTdM2QvycW2mzX4usVFp70VY8DLii6dOwF3XTdTXIq8WIsE8JtA24C1jOqWGMY7C
	XTqiGbHQhV4QlR4zzTkJd4Xfu/xPIlPGguadoTAHonaKsXvtTYdAPSLUA02W1n0v
	QSng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795457231; x=1795543631; bh=AHY2CyTjetiwXuBqBJRqvDGqniqW
	KKNoLB5jad2781s=; b=A/TQESft7QVicSQGzCZsqi44RKSvzsrYVhgZDsVbeE8i
	9ivgaixYAOEHi+7Iv1rzUtOnfMHne0IcqGbeqemhlermq1x4R68uyV2OPms8JJGN
	X2rU9oZm2nWrjtKFThkc/Va8UNWyw16xBnU1pjhgxq1vTFCfYaFlB0LxapqudKUZ
	IgwWnCcCGImzzC8eVCURkvMd5PSmnXuf9l295Q5uPxhSfQCCseLOq3SmeaPsS6NP
	egkCa2oV4bEM6zeuMZWnj9VmOYlY9p6B6iQS+5M0L0jr/oXnljXLrQSbR3PFKG0j
	VP9GLbnEf1PaZ+fRwv+yQaSv8jq3qxatoQe0EbFqXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795457231; d=fastmail.com;
	mf=PGp1YW5sdUBmYXN0bWFpbC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:QbnRCugQQ49Ky5pFRuEV9WT9qXkfBnGmg9acmcnnZjXAl7S
	1IjdmK45C1cJg1xPtsqA78OVKtkSskRbOXX3tshUIxbw1pqM8ADOtKFueeVs/avp
	L2bgatkGo2R4hZjlM00FMH0m+pcB5eM133h4wzu8FeFctwqT0K8ou7Px9o28TR47
	N+gkaEAxOJsH3LVmeqFmMzJo70V7uLbpPjXism3OgOAeF74jgpc6Fky1pSuNipgW
	TsAu7CQ08z1kXRsUrEP24WP+SnX6JbfO7512sbw4DxC/WFIYxi72KliFSThXe/dl
	DvIiELQ4RDCYK6KIJP0S+8IG+UPNxIcTyt/uvlw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:+C0Mtdbintxe3lZ6HWQv1XqYb0wddfadChqENpcqW2A=:qD5yWnn0xRm8TAS3IVG8/X5c0X434qdiHrYyPK37fJ0=;
X-ME-Sender: <xms:z4AEa1OwmNiYzs5FtOXOg6Q-_G-RH4W3vqoUOqgGXtzQOX6HDQZHtw>
    <xme:z4AEa6iFpSDmatE8-jr-3ly1S0iQ4prtFTnKQVyiCrUnOijqocs_xd1Bx8Kjy4Rrh
    mI90cMWOjLwSaWekXc18IziM_PxyBNGqUWckpuMJHJ-zzoZ4J5BrvU3>
X-ME-Received: <xmr:z4AEa36tjAo81jLM85yeD5zBjgdwr3NWIA6BzuRuFZ96-4GCsgvWBaBlcA76D7obH7kAbJxOv3o716UaLKk>
X-ME-Proxy-Cause: dmFkZTF7VGQKM0+qSjc8kIewacMH9fMEl7EB9jTNzVhZqEsbjakCK/N+s6KJNLiJibXSY+
    wr7v0Jg0tVv6ZQIesDyQPRLOCQQbk19fMgLCWSXTlZexPsV3HuaicMaA2w/lwlEeGsZWZs
    2SA8adnltI+KObFIK6hSwtyTyhCSQUhZZ2GetPUMzS0eonrc6QXbYlLAoxDG3xk8Z4N7+b
    sW1oqo4msvcKHFEiB9UR5a8hXsl86v4LjjiYj9C2D6ksWfn72M8QfrHDq1jecn6OZtMeHD
    LmdzGNxeU8JOG3kBoMifCwfqH6GqaCAlsxdQoJL5DVp2ThP3b5c+a+7C9WioSCWAUi9Tlf
    BqyPWysC4uiQMU5jILCJmXD9qS1gDT9bkO46qQjm4Y0ed3m17NQBWmS/J2cSfrbhDm+IOd
    UuPUfsfLT/ZsrVRSZFlyZPjdUDglBdO3pYu6b7w3m+lFVff6KpOE00lNk1bJAE2nbvYCGX
    SQlEONWYWi/Qc+8a7RgwlAoQlVnFQxCIgfUBd1+RHBhp/fjlqydvtITlITUXIpqx/b/V6+
    cz2LJNkWwrxPIDCOOOA2NA3NXzf0c/xMAtQsudLZhvR29PPCudVhyCyxhK2a1BPUb297Cs
    /rSGXTSrCj/8DZqWGf2tgB36z/z/AJuwFYdQl3LsA3heTxqkjO4n7JtEmmfQ
X-ME-Proxy: <xmx:z4AEax3IeSMdkx8Nnf4wwD1XBiGEL6_hy_qmUxvuvHfiQYC5aTCiOw>
    <xmx:z4AEayty4KYcEW0PN9A_ckuc24mIi-O7i3JPGOwziNwosLaCDefyQw>
    <xmx:z4AEa370aE_uRXY8rM5Q4OlaxBQcxI2aTHQsbeyreQHDJZSM7xfgIA>
    <xmx:z4AEa-dJiIwzMe1DNiyLnGD2QbNdhz8DaE88esfLFu-Zj-aDOWVtFQ>
    <xmx:z4AEa2xxi2dJlKgrrY5VUkdvMGFLN_icdNIe4nRcRC8U9pAvfUWEjrI6>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 13:07:11 -0500 (EST)
From: Juanlu Herrero <juanlu@fastmail.com>
Date: Mon, 23 Nov 2026 10:07:04 -0800
Subject: [PATCH] io_uring/zcrx: reclaim returned fallback buffers before
 ENOMEM
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-b4-zcrx-fallback-reclaim-v1-1-17e9202cbc77@fastmail.com>
X-B4-Tracking: v=1; b=H4sIAMeABGsC/x3MQQqEMAxA0atI1hOwVZTOVYZZxDbVYHWGFEQU7
 25x+Rb/n5BZhTO8qxOUN8nyWwvMqwI/0ToySigGW9vOGFvj0OLhdcdIKQ3kZ1T2iWTBxoWenIu
 9CQFK/leOsj/rz/e6blzFLzZqAAAA
To: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yedidya Feldblum <yfeldblum@meta.com>, Juanlu Herrero <juanlu@fastmail.com>
X-Mailer: b4 0.13.0

Copy fallback can return `-ENOMEM` with an empty freelist even when
reusable buffers are queued in the refill ring.

Drain pending returns on an allocation miss and retry once. Drop
`alloc_lock` before draining so buffer returns can acquire it.

Link: https://github.com/jlhe97/liburing/commit/0509277390db1e25a340b7b5bf5dedb158c702f3
Fixes: bc57c7d36c4c ("io_uring/zcrx: add copy fallback")
Cc: stable@vger.kernel.org
Suggested-by: Yedidya Feldblum <yfeldblum@meta.com>
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
Drain queued returns when copy fallback runs out of free buffers.

Testing: premature `-ENOMEM` after reusable returns, 20 liburing trials
per arm:
  7.4-rc1:         20 before, 0 after.
  7.1.3 backport:  20 before, 0 after.
The existing ZCRX suite and regression use loopback `ZCRX_REG_NODEV`.

Regression test:
https://github.com/jlhe97/liburing/commit/0509277390db1e25a340b7b5bf5dedb158c702f3
---
 io_uring/zcrx.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6d7abb1636e7f..35ad924970064 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1517,17 +1517,12 @@ static void zcrx_return_buffers(netmem_ref *netmems, unsigned nr)
 	}
 }
 
-static int zcrx_flush_rq(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
-			 struct zcrx_ctrl *ctrl)
+static void io_zcrx_flush_rq(struct io_zcrx_ifq *zcrx)
 {
-	struct zcrx_ctrl_flush_rq *frq = &ctrl->zc_flush;
 	netmem_ref netmems[ZCRX_FLUSH_BATCH];
 	unsigned total = 0;
 	unsigned nr;
 
-	if (!mem_is_zero(&frq->__resv, sizeof(frq->__resv)))
-		return -EINVAL;
-
 	do {
 		struct zcrx_rq *rq = &zcrx->rq;
 
@@ -1542,7 +1537,17 @@ static int zcrx_flush_rq(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
 			break;
 		cond_resched();
 	} while (nr == ZCRX_FLUSH_BATCH && total < zcrx->rq.nr_entries);
+}
+
+static int zcrx_flush_rq(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
+			 struct zcrx_ctrl *ctrl)
+{
+	struct zcrx_ctrl_flush_rq *frq = &ctrl->zc_flush;
+
+	if (!mem_is_zero(&frq->__resv, sizeof(frq->__resv)))
+		return -EINVAL;
 
+	io_zcrx_flush_rq(zcrx);
 	return 0;
 }
 
@@ -1656,20 +1661,28 @@ static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 {
 	struct net_iov *niov = NULL;
 	unsigned area_idx;
+	bool reclaimed = false;
 
 	if (!ifq->kern_readable)
 		return NULL;
 
-	guard(spinlock_bh)(&ifq->alloc_lock);
-
-	for (area_idx = 0; area_idx < ifq->nr_areas; area_idx++) {
-		niov = zcrx_get_free_niov(ifq->areas[area_idx]);
-		if (niov) {
-			page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
-			return niov;
+retry:
+	scoped_guard(spinlock_bh, &ifq->alloc_lock) {
+		for (area_idx = 0; area_idx < ifq->nr_areas; area_idx++) {
+			niov = zcrx_get_free_niov(ifq->areas[area_idx]);
+			if (niov) {
+				page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
+				return niov;
+			}
 		}
 	}
 
+	if (!reclaimed) {
+		io_zcrx_flush_rq(ifq);
+		reclaimed = true;
+		goto retry;
+	}
+
 	return NULL;
 }
 

---
base-commit: 0659e44ce739ecd856164c75a5325b7959a2921d
change-id: 20261120-b4-zcrx-fallback-reclaim-39d7a99f71dd

Best regards,
-- 
Juanlu Herrero

