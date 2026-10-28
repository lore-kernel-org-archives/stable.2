Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155843;
	b=eVjEbGwdPUbkWBwwGbo0ZN9vpiEtY3uPwAIf1JrTNSq0DHS7Y/7tqZEyzl7lVwIy53Yk
	 DWCjmPvoI+fPFi3zk18qLm6knxtUFO8kOPr0qaGYD0a4Y3rQ2RjDKgSLHqGi44e31w1Gd
	 Y12PrxdhRTdSJyFLMFuQeeFIKuQcApVKbhizcnK9fgM1FlQM6DClWSM3BDhZWDdo+2uG2
	 Z6p69kv2UvXQyG41sWtfB2PzqJwkoKVvfMDPUkk6AcLfXUq5JED6QaA9Smc5/1+c+tGP6
	 wHhxOhx3HmHpa/Oqdx7pRrE+RjAkZ1lzS/CrtPi6JgfqnRbIpu7WADGz1OZOKCOnm3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
	b=uOB/h06KvhjbFUKfaWs3h3BM0Q8MZnWNx1wJDuvsjgrE05p5P+Hp5681VqOV9u5TEN5f
	 EqMa+i70onXBQ9Rr1Gh4LyJMLkdsUwPRazk0xceX6pfZ6aYSAdlf4BjPL8fzbPnUD9tFK
	 Ivs0pGKf6Mb1hHrvI/epQzRO5Z4KZ4dlDGFRuj9GaPpcFg6A/TCNkYlXfgaVIKx/Gq1hW
	 qSEakBO6JDCOmYwS9RmeEbFssbXgiwqsaY+SSwevNrQo/z80MDU5zbvqKtMZ6yJ04PtkG
	 wYbRY/TotPSHZ0mHpPnFpKv1bNQvYzYZF2rtmjY3lIQhgHOzbMbRDeij85jxJDZIUtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIxGQVuC;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C6606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC9C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIxGQVuC
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac5f801d7cso113292a91.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155842; x=1793760642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=sIxGQVuCcRBJM4Y9dM+uPj1MqVYGHELdrlvbHCe9zroN36ORPXLLIpUOw1Y6USdWW6
         7ef1iCd9EeBB9i4GBNCqUBO7kig/5+eAom4R2U2fo1nCFMDbzDqNlVamlytn9yhKL1GU
         RuSCEC78ZTuhxP0oIx1itKjzAX43wQXc4JJ2uFJUXQBy/kNfGdzUPitJ3+XEamRRz39h
         VElrB6cmCShWH9Ye/+8+MSZ1V5L/dOAjvzwjyMmk0TUqbDEsTAEobny4s4FEoWzyZZc/
         RLFqY/AlU62Pu+5gGGZv0DS5CwCRjKulSHKlzlLuts/4LH0iMOUeyGZ8+8jAxm2hsAbC
         ExLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155842; x=1793760642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=S3Mg7u4xm035AkJiZIGFo+H8KketU54xI/T35Nle7luqMJAmfGhYu0NHEaLO60N+9y
         pj/NV4MeWUlTtpeek3bd8sHSpxIk/DCdUXETvnl7O8+cVaP+NizC2UgHFNUwq3JZoIHz
         GJjyGo0c29jbJYtyWXNHysD1rhRDD69RXRBR/MSUzVC8PQxkA9kz1mnOhG8/6oCYYJzk
         RvsdVvdEcK7Tg/xmWjNT8f4IYQPrGc3RKZ+5jJs5PKw4tprwSEeM7uMR+4jxDu1jXBAW
         /aGgGa0iMFl4BN0T1RLVPz0ihr8KPRxtgjd1e39TbOVT6ps2y6EpJ8LJIdwySSFNv9Ou
         q1DA==
X-Forwarded-Encrypted: i=1; AKwUvBwzU80vFDGLCn+glzG5HOjL6v4OJITK4VbI+PArv6ietoPF05irGuakmGcRmyBc9cB+H9z+u54=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL2Kwv8zyDicRJ0+jLvEZSY2ez2BXt2qiMwY2T8wGjG5jndnqL
	NG6XqLtS5xQBMr+XFbV+PsjFilit/wsYD18WKQ/JleUm/p4BuqM1Xs6K
X-Gm-Gg: AYBFou283tji6ousKae++sUcbRHkgAmVTQ/+lbY701e8Ylqzy0j1qtc/QSm3IcC8m0F
	dVfOSInjdjaqcXtR7xH8iYs+2jvrJeY2kPOLRSyxbKKMRNjPeGElH9LQqhcxckDhXslcGkIukdO
	0dXFc7t4yy40d/bzomz5ncgL4U1PxIBmmjhHSjvf6z0mg/FqemfLY4tbRVoDEQ2y3BBroO1QeG7
	MCCnwPQhs7BNhQ9ZE9JMOwlOjyO3MXnPAL3e7hnNZirkDvrX+BQuPs7k9/JFqTPxW59XMoOLSK0
	29LQnobo9H6QA1tERZL3LXJf8Z5QHYCWdmN3M87fs1FlU67r4TpdC4Oy4JArJyc8QdGQZgNS42o
	NkcraeaY3bznNPwcoL4fUAGNroQGazWbgMDr5gnmLKe2pb+P5u0M6b4J3xOd+OWw1RjnEGUT1ae
	k2hLghTQfT61H/Csbfqcu+j/zyEf9vnsqAMxehTKEcdyAdZZzL3Touiq0h9fJulkJyBwKygeNI6
	PQ3nvL/J+CuNyJmppYLcQwYLvkr4vKPIYdPiecp/ipGY0oD64R8yrXavWWOFnBnuCWvUP0N2i+m
	jWd8HU+rSL/Ah3ZdolMyNeDIo9Zz6TfWxlDH2uH5ota3nodFDMx5QS3ky+ZEotk=
X-Received: by 2002:a17:90b:280b:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ae580df868mr793396a91.41.1793155842143;
        Tue, 27 Oct 2026 19:50:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2b84:48c6:402f:d1c5:644a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm812447a91.1.2026.10.27.19.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:50:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v3 1/2] xsk: defer software checksum until the skb is complete
Date: Wed, 28 Oct 2026 10:50:25 +0800
Message-Id: <20261028025026.11401-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028025026.11401-1-testwrzwrz@gmail.com>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
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

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..aa6b010192ad 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (unlikely(pool->tx_sw_csum &&
+		     skb->ip_summed == CHECKSUM_PARTIAL))
+		return skb_checksum_help(skb);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xp_mb_desc(&desc)) {
 			xs->skb = skb;
 			continue;
+		} else {
+			err = xsk_skb_sw_csum(skb, xs->pool);
+			if (unlikely(err)) {
+				xsk_drop_skb(skb);
+				goto out;
+			}
 		}
 
 		err = __dev_direct_xmit(skb, xs->queue_id);
-- 
2.39.5 (Apple Git-154)

