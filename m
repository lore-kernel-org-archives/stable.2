Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552798;
	b=EZOXCz/MNO6mvjRp5szFRpAPjvRv271UjAXjx8iuM2wj1dNnpA9cX+I9lsUjCEjRZFQd
	 QD9G0sx9144es4TQcI7s4bGp5XCQ8Yj6/W5Kj5om9qHaR8aPYOgzFbP3Ye0f63y9NRvEP
	 /zcifaEi3lA46EUTHJ92KhEiqC7AK9gbNBb4hfFxHZVEeCSk8+sQgJjDmW7zto9E/iDoy
	 u8YC1imjIbfYAXraAcJ11s9dQ5CT8lmUiS+PDIFs7J0pr2f7F+kMPiEwiW9rLgNGqIWRG
	 C12OOmMAqkpF9JJMcfrv4zGS7bBgfoWWNkE4WNR8kumpEQvhJlonmtZBG6rv41ixcqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aw39Qev1JSGYdGzVPWR/rCHqkJas2jqRHE7hOubbX28=;
	b=y57vCaKPT5yeVO+R6AjRaK0OMHciNwNBlH7J02zyEMIg1YeoDw+MmMVnw0brbBbtuX/T
	 XzR4NxSImMh/ZwhSmFYjWVH+HhZ7tIyarRpaxczbxzoVeY2iqfXglZDuextgRjsZzFywX
	 WpO+5ieHGnN/PAfxxZvBXtAnywk3Rfkl6uqoD0Ylio/moIdwB6HRiKtQgRY8S1pLSar6X
	 nEed2fEs4BHYIsZbdtRLgay3bPW1jAdOxDOCSYshReg7oAfWlVyyqqBYAKZsQ6pngpqq+
	 ycPIcOpVL1QPrG9S3hPT7voKSb1ww+tXkjhEO455St6xJq+XPpsX4LSYE0k386fh9jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ikotaslabs.com;
	spf=pass smtp.mailfrom=ikotaslabs.com;
	dkim=pass header.d=ikotaslabs.com header.i=@ikotaslabs.com header.a=rsa-sha256 header.s=google header.b="fNI/QkZN";
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8019606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 17:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8019606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikotaslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikotaslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ikotaslabs.com header.i=@ikotaslabs.com header.a=rsa-sha256 header.s=google header.b=fNI/QkZN
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so2412784eec.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ikotaslabs.com; s=google; t=1793552797; x=1794157597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aw39Qev1JSGYdGzVPWR/rCHqkJas2jqRHE7hOubbX28=;
        b=fNI/QkZN74Xkc5wdAuCJsKzax9U6M5pX64S35hE8/de2Ts2gsv4GQv18s9qszbQX+1
         NUTpG8veJFNxhEMyWRt/RQ11dGCkBRMkQDllDK5KsjLFOJ26ye/21KeDfGZgP69yZAKC
         D9jWiu/aL+owAZAkMG5w95ZDtBWp0tihZb1xaE/uaWZc8TwlxPbrDH5jx/UuEApO83d9
         eiuy4ER+b/AzZWb/RwhPNf1ggP6bXJ+2wnlyF9a/WuoFkRL8Je9vhpDdu/9w5ukvYOgN
         qAvv7St3AFf7jfqovHFM9fHrUtYQtL/eOwiiYbo7Mpl3zanoROy4TMNd5sA+JSYxKfpl
         ACEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552797; x=1794157597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aw39Qev1JSGYdGzVPWR/rCHqkJas2jqRHE7hOubbX28=;
        b=fnc60TOoeHTwjfMgG3/nqqeTdmuPP3Po1+K+6e75mKXupdrSy9fcpS5SlUurYv97pq
         7mnbOlcSU4bd6xd1yhU+ghJkUx/D47Xoh+2m51wl1pjLGbXD0jzggKNZx5zEfE7mt3MC
         /RScjjJNgUuNUm1V3ToJFWNEynDqoa58EvHi8o+gQV6ik8R/zGrXeBcnbljmf7NZqgB8
         sEsW2kFlx0+VdEFQDbafLD0L5PamzaV5JF+3WLp/zyIfUYMhRJPsVkvWdBc/j0zcoMnX
         eWyoMeJbZmR5KBfWdJeoH6B8GebB5S05XfKn7GVLsMDW7oMBe+08RpNESSfzjt4woUHk
         l/Pw==
X-Forwarded-Encrypted: i=1; AKwUvBw4gFTnBps+3xJ/xoSSIkxbBNmFyUp0IvowUT1EwGI8yKCkO9nveF2coIm/4EuiRNb8Cpi8HkE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L2Fb2H5chz4okBoMxMO1YitSJI4xncbqGoCFhXdolHELO/q+F
	2YXsAERnfulzAdciwrbDvrR77IdEuBAMHlfaR8SPAWPhWsqpeZQHVpMz5M1frcw8i029
X-Gm-Gg: AYBFou04JCfkRhHochqrZGOTfHwqbfzmifNAAfWnTaCUP17I9qXb7b3BTbI1VS9Fm8J
	qQv9FDWuwlV6zwGBWJxIYeKiR58g3UX/tSqZopJPRMyo1fe+a9Gpe2rvS5QZB0rmr6qJe4m6FCE
	9hGlSjcqqWLLK5lclf49yiquWlQZm00bLcgrt3wO58ppbd7fS8bW3vkysI/o+37Ef0GnF3ry4g5
	NIiKFPL9n3icw0qHdFlsLeO4zabOYFoM0TG7NqInH+0f4U8YtlZw+7eX48xUGqs2q2gBf7vmZyw
	DdqGpa6QatYfEGGfUcfC9tOeLFnZJhf9QC343YWFQQfGMy5XEEYMv1gTCgQEI4uMa4Vr/NT+b2p
	Jbkr8+dLRSQirf8fHVA+uc2gbCbJrc/doz3EsObJxk8seh+5Jyzhj2kfEbejSP1OKcXhOnKMqGN
	oXK/kNXb88DGrqZYgMy/Afl7XjRE/wcWfHWClcMYXUjzWuv9NR0+spvuPUSrbuUNZE+EQiS3vT0
	6nklnMEOO3x0+tXuYTP1JS4eoP1IzAfqZ3W1suutkamfPxBk75nFAFkYcGg+wJ6u7ByqiDfQjlR
	cuRUEpo9NKsXk0qnnADpeQFyxtn6ilNRdMRMuTfRN7R9GFTG8x8USb+URE0s/VCS6brpWaVmSZc
	2inPqjs4qk3nFTBuOpkJRfvWF7spDTe6ovmTDbc1NaZETk3W0QlsCgZcI8SaiqA==
X-Received: by 2002:a05:7300:a9f:b0:369:fb01:2eb7 with SMTP id 5a478bee46e88-36a4235f45emr11482457eec.13.1793552796603;
        Sun, 01 Nov 2026 09:06:36 -0800 (PST)
Received: from gx81.tail3ecf1.ts.net ([240b:11:99c0:1c00:9e6b:ff:fe84:e26e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm33105165eec.11.2026.11.01.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:06:36 -0800 (PST)
From: Ryosuke Iwahashi <ryosuke@ikotaslabs.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	security@kernel.org,
	gregkh@linuxfoundation.org,
	yudai@ikotaslabs.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	stable@vger.kernel.org
Subject: [PATCH v2 nf] netfilter: nf_conntrack_reasm: restore IPv6 nhoff after reassembly
Date: Mon,  2 Nov 2026 02:06:33 +0900
Message-ID: <20261101170633.625161-1-ryosuke@ikotaslabs.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026110155-twisting-autism-009a@gregkh>
References: <2026110155-twisting-autism-009a@gregkh>
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

nf_ct_frag6_reasm() removes the fragment header and resets the
transport header, but unlike ip6_frag_reasm() it leaves
IP6CB(skb)->nhoff set to its pre-reassembly value.

Subsequent IPv6 local delivery consumes this stale next-header offset
alongside the updated transport header. As a result, the two cursors
can point to different protocol boundaries after conntrack
defragmentation, causing later processing stages to interpret a
different transport protocol than the one evaluated by conntrack and
nftables.

Restore IP6CB(skb)->nhoff from the saved pre-fragment next-header
offset after reassembly, matching ip6_frag_reasm().

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Cc: stable@vger.kernel.org
Signed-off-by: Ryosuke Iwahashi <ryosuke@ikotaslabs.com>
---
v2:
- resend with git send-email formatting
- use full real name in the author and sign-off
- no code change
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index be72c4346..634122055 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -321,6 +321,7 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 			     int *refs)
 {
 	void *reasm_data;
+	unsigned int nhoff;
 	int payload_len;
 	u8 ecn;
 
@@ -345,7 +346,8 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 
 	/* We have to remove fragment header from datagram and to relocate
 	 * header in order to calculate ICV correctly. */
-	skb_network_header(skb)[fq->nhoffset] = skb_transport_header(skb)[0];
+	nhoff = fq->nhoffset;
+	skb_network_header(skb)[nhoff] = skb_transport_header(skb)[0];
 	memmove(skb->head + sizeof(struct frag_hdr), skb->head,
 		(skb->data - skb->head) - sizeof(struct frag_hdr));
 	if (skb_mac_header_was_set(skb))
@@ -360,6 +362,7 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	skb->dev = dev;
 	ipv6_hdr(skb)->payload_len = htons(payload_len);
 	ipv6_change_dsfield(ipv6_hdr(skb), 0xff, ecn);
+	IP6CB(skb)->nhoff = nhoff;
 	IP6CB(skb)->frag_max_size = sizeof(struct ipv6hdr) + fq->q.max_size;
 	IP6CB(skb)->flags |= IP6SKB_FRAGMENTED;
 
-- 
2.56.0

