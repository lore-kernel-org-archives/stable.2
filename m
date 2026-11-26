Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651925;
	b=Wylz5yn7ue6Az8oiC59vHiX53L9lOUd+eR0dcYeBdI6dA4mxAusuxP8jFadv8iNtNRY6
	 UHgAlfpNCxSFkPJbuf8aIC5oymHY6oiVoc4LHlzP3hFjg9FYJNWMNUH+vRZx5EjhCsPZD
	 pA2OZgQ6/8R2N1ltnpUYw6RGpkPi9+CVSVUtyH+kt0FxAsG50eYAOG0A+Yw/7xJUrl8T5
	 2JK5kvIAFu6xY3bWFVV+caBQwtNgOKUqfrst8LcDQUJEJwsP0eTlXUu8CO4rmzDVBXUKZ
	 77//1NVcNXvV6nDDs2Ch1aUqPnTPPz0v6VRVoYU0qtElczjQTLakUKbqbXQYDhEb0Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eh53HWlWeYqc22pkcThqRd+K0CvliST0uP4BTE7Y98w=;
	b=2rT9dmnc7JDNvdE8qYmnJRtTJmsVQ1K/QUJ67vqEMFEw+uqrwYPmLAia9417WDKYQgiX
	 ROGrFm26DNIH3a7q/6ZzWNcdCYSJGOT74vAy66/KbtCdYpz0Rg4CSHhLicc35xeX3h0ep
	 xj4kiHbKOeUSGNx0aVZnlxw+iI5VyrdQlW/pbT7coTZ1uXhOcjy+mGjXbdqDv1fpsLVK9
	 f9i4fLs3LfQrbqJBpfdZpnpFO29UqVCiCdSxMT+bxyzCyu+LXZsviFz0U6PXQWqTf0FOA
	 +fvfYgxtcT69RTQx8KKLc1UAcqcMqZPJr0blbEQ/u1fEkBpKL2xxgsHZdkduRjwCanQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=iTExogPz;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BC606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 851BC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=iTExogPz
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso13596907eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795651924; x=1796256724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eh53HWlWeYqc22pkcThqRd+K0CvliST0uP4BTE7Y98w=;
        b=iTExogPzYoZ7KsoxJgwtQ2u6BEwE1zh7gf2BklH+Y6vYmJ6Cv3tVt8olnC9ccSXNv+
         IWLK/+A6tNWMmQJYnu+pg7evH+jWsBjzqJDx3lCRd2/3d9vrNRi7rFu/iMpvkqVmPwqi
         4a8cRe7XlCIxVkruoMUoSoy0SznIgvLBfphNLBYxj5yEATfp2D+zLsUe3QWD1IUtT/65
         5Q8kyLGEDcMZPcYh3mm6GgWgVb+/E2m0ZTv6833pqMrEN0RFzUIoOAuafEbfiV1jswDA
         FoJ4AF01ye2h8hQNqAb2xfL9Pk0zVhW2AMEDKV3iD3f2kyQMPLxGykMB9hGyqlnr5zob
         A+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795651924; x=1796256724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eh53HWlWeYqc22pkcThqRd+K0CvliST0uP4BTE7Y98w=;
        b=fl+l49L/fkQrhIQ7HelxrWJcTgP2ZPbJBZWfuNy4O4lb4DfhA3xdXvAe+67wopnjYr
         zEhBLCurqpx3BhdAA6ANrl4yXTy6uPjNutWeMA2myKiSn+91/h6dEjjxfFhg22aEKZfP
         pk3giKhlARVknpSRf2qEr0KqpKXzyTK47ibV2KDlKpOzcfWVAot7rqYBHrQ0pmb14oW2
         t2cgSw5MslGcX9Xsp5SJ8Pf5Y3fBUBdDla5Ye4192idpwxKLM64RWsh/oO0xPNfcF1SR
         XPHcSYMUKPKBxoQ3vDcsYjpoQhJjXFpYHkY6KNHQbw2yoeTugs85ehZwBelqyV2cr37j
         AWZg==
X-Forwarded-Encrypted: i=1; AL+hErFBgGScjpSIkG5ZBhuL/I67i57ofmCbWcfMuDC9q6HOF0/kEuAHzp4I9fLgrDrKAfu3uYS6X3o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hAT8tH5xPQ8fE35cZMPQnLx7lM09ihXx/vfG98hvyRjQuGt1/
	iQrSoMszQuDWWun+5jjUTJfGsWpYp/8RFsuoSuOpi1DwXXXhYHRUXTQSQ5f5eE8kEQ==
X-Gm-Gg: AZFdTZdr9pOo0fYYyo1AT5Zp0qOGRJkBovga+RTizau9YzHIkaMVWDJW22B1m2HDzhg
	thsDOrUZ4pjuIfNmIWy4Hr6kOW0T3Cb+PTmHM/JiNFrAoxN3xVYDqfbgFFfn/QVF0g47qyA5Ap6
	TIHK9A8Xl0sm8DZ3P89NTST17RHIFp4ReRzZ0W8D5oOXmucNHnSa9yrGGx+56PZyLvleHSbYvnS
	YVS+sUl36POoNIWSQC9yXs5OrwCFldEir4KJFsZShJ2blRGk07E28I8aD+5C/wBbeJGTboB8Mkc
	jxECD7BtY+TdeKZICl8SURdS4SHeDs0VVsJMuW7ioEXfz2x0OZZ93OdewLpBjpztko2R0n4MDZx
	w2fC87fK3dL024Y0bhFzcmHev+zPIIisCfyc1QCsJJad5rSucTeyGktax/8DifZRvkCT1czeNIt
	m07hIOJ7PY/hRYrSmwAyD22nmPcD/3bIlypqhMTtr2QQ32UkOzb/jo8+L/yZlBCdFQlSdmoI2yY
	HIfUCC0jMXWmh+/PYegzky/8GDyBfp68NAVMssKWWNmBtrlQP1JdqvhRx+Agv5DvENj40+nMYM9
	AsJ4ybvCJHvpGZkcTEEbdyDQy7vEVrQfgK36Aj6Po8fN7N+5sNKtotyxq5T0SJ/+dyHP
X-Received: by 2002:a05:7300:f789:b0:386:abe8:32b0 with SMTP id 5a478bee46e88-386abe835b7mr12918966eec.8.1795651923427;
        Wed, 25 Nov 2026 16:12:03 -0800 (PST)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26216299eec.27.2026.11.25.16.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 16:12:02 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+85229ab197510ca7@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH nf] netfilter: nft_exthdr: pull the IPv6 header before ipv6_find_hdr()
Date: Wed, 25 Nov 2026 17:11:51 -0700
Message-ID: <20261126001151.13793-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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

nft_exthdr_ipv6_eval() checks only skb->protocol before calling
ipv6_find_hdr(), whose prologue reads ipv6_hdr(skb)->nexthdr from the
linear area without a pull. The expression is usable from every family,
and the netdev ingress hook does not normalise the skb: an 18-byte
802.1Q frame with an ETH_P_IPV6 inner type has no IPv6 header, so the
read lands past skb_tail_pointer(), and an AF_PACKET frame larger than a
page leaves the header in frags, so it lands past skb_headlen(). With
NFT_EXTHDR_F_PRESENT, it decides the result, and 256 "exthdr ipv6 type=T
exists counter" rules hand it to an unprivileged user running in its own
user and network namespace.

Raising the device headroom puts the skb head in kmalloc-1k. With freed
struct net_bridge_port objects sprayed under it, a uid 1000 run on
current mainline read back kernel-written data, byte 2 of
WORK_STRUCT_NO_POOL in query_queue_work.data, and bits 16..23 of the
query_queue.prev self-pointer, i.e. of direct-map heap addresses:

  read offset 570 = byte 2 of the 8-byte slot at 568
    freed net_bridge_port (32 probes):
      byte 0xe0 (224): 15/32
  read offset 554 = byte 2 of the 8-byte slot at 552
    freed net_bridge_port (32 probes):
      byte 0x15 ( 21): 2/32
      byte 0x21 ( 33): 2/32
      byte 0x59 ( 89): 1/32
      byte 0xb2 (178): 2/32
      byte 0xc3 (195): 1/32
      byte 0xd8 (216): 2/32
      ...

Pull the header before the call, as act_ct, virtio_net_hdr_to_skb() and
nft_set_pktinfo_ipv6_ingress() already do. For the ipv6 and inet
families ipv6_rcv() has already pulled it, so this is a length check.

Cc: stable@vger.kernel.org
Fixes: 96518518cc41 ("netfilter: add nftables")
Reported-by: co+85229ab197510ca7@bugs.sh
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/netfilter/nft_exthdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 861bab93f435..a7c2f7553af8 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -52,7 +52,8 @@ static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 	unsigned int offset = 0;
 	int err;
 
-	if (pkt->skb->protocol != htons(ETH_P_IPV6))
+	if (pkt->skb->protocol != htons(ETH_P_IPV6) ||
+	    !pskb_network_may_pull(pkt->skb, sizeof(struct ipv6hdr)))
 		goto err;
 
 	err = ipv6_find_hdr(pkt->skb, &offset, priv->type, NULL, NULL);
-- 
2.43.0

