Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457465;
	b=Ok4LpEIgV13Nn65XDH7l27FG3eH9vDMQaN1ZfubGhlvzvfuA29SiFqAHXAdbKvvg6g/O
	 EtKnoEWOjhgSrC++vQPOyzOTT1QnchrlKHwWnXoNu7GCABSj8mYO5vLgzFSh97FQl1X+C
	 PgOV6mEOfLYJsvG2TWvmz1zAo/QHHVFCYcWnUAml5NeJZ/ikqchXlRwjkHxdxdk9y9y58
	 i+j7E3ia7w0MzDk/DHnrcIkJkjTspSjq1C+tyIy6w9OxStZZNGkyC3lAyZ2wCHX1K+w5j
	 eCEkCW/dumVT5+7KX7+k+WTBjMLFRtd/Lvv/4Mkqd63gl/qbNf2zQOjMub0SiaUn7Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lpp4FX5gZJokt1GnwgH1j6FAHpdM7kiuFK8F/Wda8qU=;
	b=DfoLIxLB2ToJFDBx98eaMcFnqFKlY4FuHcw4ZJ4SLFpXP4wGIgcLH+gb8cDYENS6TdYK
	 Lq57zq7XjMZ+U8n0Tm3F3BaCT46J/rNtpaFdiEN7uUyx7dLNvDPKqni7NSipqu/BZ6Tkh
	 GTbBUEFjDOPAl7JxPZrlHtIuQkavcXusn2r3fHyDutUgW8qD8uKvshnT7mwvukotzJe4P
	 HL5ehUJo3iiWReWx0/9AkPYiBnWtGVDLg8YK0wQjHdg+p1w4kPEnYSOevjVFAiQe5qt47
	 x74dZ1rXuijRMXYOBGzdmhKNdKLlh7pL/Nsn+8rGMzKFx4Hm6847poLhncebTueE9jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dZp+0eOc;
	arc=none smtp.remote-ip=74.125.231.197
Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40507606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40507606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dZp+0eOc
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-567e79972f6so155571b6e.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794457464; x=1795062264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpp4FX5gZJokt1GnwgH1j6FAHpdM7kiuFK8F/Wda8qU=;
        b=dZp+0eOc7wf67+aV9XcOB9yjsrNEhiEJuWZRMp4y85VlJLW8OlwqJMn7CEYTRAzwg3
         W8VJKgm/oGP9cCmLAHuHiJ9izkrdETd/R/a4uRiAditF26dNTa9ZRgeHOb8MaI49JokK
         Zya0oeg80Id2CG9kYrNJAP/W/O/+NQy7mg0mQuQPdaFLRwmkRd7+mpIou1v82/6lJjM1
         MfhuQk4m69Ia9zNaQS/Sqsoovgy2nt9aMRJxgddK91Ax456Qqft6YjtAOfqEpM4/HuIx
         cfAj4tPrB13Xdt5Afph7W/8pPWseLrqRPszMQitrPgVtUeuW76plj+LOoDYA+cDWyex1
         pktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794457464; x=1795062264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpp4FX5gZJokt1GnwgH1j6FAHpdM7kiuFK8F/Wda8qU=;
        b=qpSSSiE2D3n3AwMxiWI6oUfy8kZ5fHit0vgU+RHIg5GBGmnmFVBqGLjwB9Vdgv25Qh
         NC6WFfeHU7SZV+i1cbLVAdTzwACIrSPBZVUXOVS46Zlpi1cXSlD6BkoFN8QpP4xnAd17
         RrY9LMte/Eg4BHFYbBM7odKp1hAOqhxB0oo4kLLwJd6zuCLH19srTuvz+g9/2jKMAn8j
         GEAqOTZ17qSYXQiLCTzt8SuyDm1ixL0FCcPHUMrWYYc60nvnfiyR/dAW2UMDaiC2f/I8
         Vmh0TnlXjHY6KsMTHgMfFYUpTaW+xbuhmBoxn4nk3Fd4tkHzTSojFi6XVdMThc/nMl+Z
         UJog==
X-Forwarded-Encrypted: i=1; AL+hErHWAK9H5a1jSimlSUJOVNMvk44ZCQpL1PwnGc4TbIsU1ZS4FKINfUTGup+kpVn5gqtricHT5lA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4CK5Oiz6WFxIzKYR3Tmp8V1RBJXT1s/8AQrdtpR1Iik59k/7w
	jxE6wcBhVxHewZ9MugR34mdGm1Xxfg7cxPINl2UIIJNjl9Hk74hDAS0Y
X-Gm-Gg: AYBFou0/mi0VdrW1ttFDNz8HD8Ug/kf+j3phROzSsZ4p1dJ4oqAgJs1JgjFgosysBNd
	5mTdrfmQtqWBIJqC/9eHrpGEB75asEfS93jVHxAnTpSNMY/H4FYD0JOmls1roGqniVi0gtkb+bH
	nQNfx120YUh0uKZWYTIp+iUDLRaNO2YxKQB9bsK//rOiix6jX2sWb1KvlJ1OUHwqX3RCxGuP9PQ
	93EvT7WMxd/04mM+F7K+2PntyxFVvpLSS3NvrKP0dtXkFWSyrByh3m/r7rFj664dEXoVu8B3xD7
	SvdNJrgXxP8p6IcPCja3q0N206YzVG7rJ5Epkda5xDNykJUN4ub9ZKQkY4fcjQE4UlBW5qFfXs5
	nccUQMWKlSwrxLWiNprKy5KqFZcejJeR3c+RKuCwSyA8NlL4OqLUAEW0kvfzhVjAroHEpEv8LV7
	I7u4WP13klqkViPQcljI+RAXCRlKKUiN8I1Kvfxghelh7cUQILSiU2bHLHhM6nr+uZ+PnM7MlYr
	giwVJKi3aod8OXQ9+BWSfb4ngx0duKVwQZtNNmdq6EOZcB4CbrOk/L7TwVA+lXJ1DlFYAtpUyIO
	dIQhochFtnKjTytwaihUY1xEjWnY+W0OCgFzejE9c+IlJGO/ua3lut9/AheRNjQ+8jU=
X-Received: by 2002:a05:6808:1246:b0:532:6c52:9778 with SMTP id 5614622812f47-56cd65417d6mr1113652b6e.20.1794457464100;
        Wed, 11 Nov 2026 20:24:24 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905146a03sm6947187b6e.6.2026.11.11.20.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:24:23 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] ip6mr: prevent info-leak in ip6mr_cache_report()
Date: Thu, 12 Nov 2026 12:24:15 +0800
Message-ID: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

The non-WHOLEPKT branch copies the IPv6 header at offset 0 and then
appends 40 bytes with skb_put(), but the mrt6msg is written at offset 0
after skb_reset_transport_header(), so the appended 40 bytes are never
initialized.  They hold stale heap contents.

The report is queued to the mroute6 socket and copied into the
IP6MRA_CREPORT_PKT netlink attribute, disclosing the stale bytes to
user space.  The stale bytes can contain kernel heap and image
pointers, and the report is reachable from an unprivileged user
namespace (MRT6_INIT in a new netns, plus the non-root
RTNLGRP_IPV6_MROUTE_R group).

Use skb_put_zero() instead, as the IPv4 code does since
commit 4f34002e2e376 ("ipmr: prevent info-leak in pmr_cache_report()").

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 7bc570c8b4f75 ("[IPV6] MROUTE: Support multicast forwarding.")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index dd0638d3c3f95..b7ae220d6b21d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1154,7 +1154,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 	/*
 	 *	Add our header
 	 */
-	skb_put(skb, sizeof(*msg));
+	skb_put_zero(skb, sizeof(*msg));
 	skb_reset_transport_header(skb);
 	msg = (struct mrt6msg *)skb_transport_header(skb);
 
-- 
2.43.7

