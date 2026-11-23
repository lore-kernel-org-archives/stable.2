Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408811;
	b=P5sxr2t5fNxLptHX5aTAxFvelLiTndGqH+tJ0TXY27R9WAJaLaIgVVtclnnPiK2+v4JB
	 ru8lFse2Iyg97OJMLmX5AYS9Z1a5wMWI2kfITCpWyJKVDRVSlmRecoK/OaLSS0tMaJaQC
	 3Zq+EoocukjgLlq1Zn4IE5aGVAnsqdZ+CL4+7U6MWsHQEjK2fGhttwYVGVCnLknryZtEs
	 ADdZY0gsKdQ8k87Hz3KXtYZkXYHUxIC2jXfRCo4bkweaszfT2BZv4fl117lVWJJkd3n9U
	 IR5Q4tKgqELjjDAvk1J92fVsndV8IKjGKxjXLNUX4B01hyz4skou74YX/ZJclFPKPCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gdrcz7ax90Dmq2ghAsgN9C5sw5lV7csK9Wkpqn6bdEE=;
	b=Agliu40oSzSYw7ebnHOWCwwBguSJXPFfKlATcJMhr8q18EAJrbHn6UnUYfVRw2KGhi+P
	 cOfKruVS4H5+q4ExlJC39eVkxCxu23JVAsFHJw16ZgH4mLPPlx6CUADezixl1vJt11gkv
	 jvlfuMMxlXkljfnDA9HOMmf+/hoi7/rieSVTpz1rr3B5mIzZC03VBZmAwP/k8OlURQNQh
	 zIxvz8OcaIAszuHHnLEpp58UJzlirms18t+Qreb06wuaesI7j7iHNDUqNv5R0vDsv+yKF
	 4x1o4U5w/VT/CzTgj5HMVv8eQeoVRoGJ1gv1M5hsYel5/f7npMFoicLEvFMt0Xmwuvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ikotaslabs.com;
	spf=pass smtp.mailfrom=ikotaslabs.com;
	dkim=pass header.d=ikotaslabs.com header.i=@ikotaslabs.com header.a=rsa-sha256 header.s=google header.b=lfO+y+7Q;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B98606A32A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B98606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikotaslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikotaslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ikotaslabs.com header.i=@ikotaslabs.com header.a=rsa-sha256 header.s=google header.b=lfO+y+7Q
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso2065496a91.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ikotaslabs.com; s=google; t=1795408810; x=1796013610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gdrcz7ax90Dmq2ghAsgN9C5sw5lV7csK9Wkpqn6bdEE=;
        b=lfO+y+7QIdN8L3Vwj2YzzhfjLGdDRLQM4IbcJCTi74MuDaeLTjf4wm5gDBDwLJaZFi
         bJpRfqlw+6BCpliJDc+klY7xO6QokRYnRzJqi8oA2/ibEztkIfmpLfhGBfhN28ihXZOW
         7T95r8fjFyssK1dw8wxxbmg2P/MmyY5ud+ycwdniqYHpTiNXtRMRouZ9fL5ltPin5AVS
         wV6lr3OGNwGXiFgoAlTbOWqg+/wAjkoXQDLZOso3ZQi5lJ3cJuSPLD722eLFdcuVJxUu
         I+xFahsTL7LJCOYdQt//+m2XkAygf6m8Qx/jXPGUg2jA9vwNQTlgCbOfyyymCvT+H7SN
         /Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795408810; x=1796013610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gdrcz7ax90Dmq2ghAsgN9C5sw5lV7csK9Wkpqn6bdEE=;
        b=nXPPaPAo7qygvKP4nSdVzR+HxqZUwFpu1uH68vm1TvWWv86x4traJ/zfljfImp7tF+
         Ky4sE7uHGLXLMVmEThGJwRW7CaEvwW1Qfk8SmniXh0+/UDVxFt6TpwksXemjQajgQtiC
         zuvjvOyRFfISc2Dn0UO4iXofKC/g+fgUh39JC+CGGGjbEEZIow5NpBy+47EzrP8ox9Mk
         ZTBchGWn2NPHBC2q1dtzh30PESCmJQzcndeTHuGB0XgABWvL7Henq6OIvKfT68gmUpQa
         kpfAW5cHv9dykMsnjrCYjQ2OIQDvwSF3+2mavOdb7loBorMRLyBsQiGYvEv/Ttz+ILV5
         Ajwg==
X-Forwarded-Encrypted: i=1; AL+hErEfmQ2HEYa2rA1FsZMHi/wZT2gj250f6ccmDEtAchoS3RSuaTbDJxScvr/lgaMoS0d4TvYyw8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/794UYFX2fKEQYgad5V2P7gCh0eEANez0HTwLTgyDDIbNWY3Vr
	mxIe8YMVhqs1HlRtgUH+ro1m1uxkNbUKjW7OwORAAy7xLjyWnbn0Hxge2RGBmtWWQDw+
X-Gm-Gg: AZFdTZcaBbKPKtdvnb/b0kKsXQD80yn23oWhzrrjMiuAsgSa6DdOo/uUd2uxjFUOpYX
	gHoBLRdvABnx4mvPW8dSRtZDbONYXj5SkhiknEIvyE+K2msEQn24U9XTtTRxH70lAlxNNs0rSeS
	WpJRdW6lLWWNNdVc38GpV/64Ow/EvoiQZRVxCaBUiDWT+FgyrU46F3H+OsPLFQVe5KN9OJST2Tm
	hvKH8Pmkf9p+lj55zmez24P9fqit4Ak4u1EhPr6QdyUY/DRPW36DgrmOUunsfD/bO1gU5UoEO+9
	+yJnOyjcckqqmBV5Y+BURQsWyx+GIaFoLH3kShhwTIPqntrpSnMMyoIP3B1ylfzMSafSMw/AJqL
	AqW6cUqHg6eP7yNswjhl0+dnKeFv270TVLiP4uMaGQf/+escV2kq4dM8EViw3vTKPB5DtaMgGg6
	+D9N6n7Dtuy0XzyPyG5i+m1p/UWELRqnmdlB6RiUUxOnmMCQjSRmth/KQu9wG412XHvTYfn0u2F
	9tqC5mW5uztoTOfU9IukVEUumOd3oxASs8ioRgbLYKXeegWtC5WpNANOYBnn9C3/SE2wwqS65WM
	VsEnBw+6inoPSWa7vexw42EOS05MbkVpWdUSRmNU6lFdL/kDbcK4AGVTw0FhwNJnErEk4TtRMJ8
	ydZYDflpLVGHstdOOz/VbiBVkDTTU0+NqKepUuDeA2bFNJqPCmSufWqkSMzJQNA==
X-Received: by 2002:a17:90b:2f8c:b0:3b4:10c3:c1b6 with SMTP id 98e67ed59e1d1-3b41c9286acmr9856003a91.25.1795408809770;
        Sun, 22 Nov 2026 20:40:09 -0800 (PST)
Received: from gx81.tail3ecf1.ts.net ([240b:11:99c0:1c00:9e6b:ff:fe84:e26e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6c9c7dcbsm4648673a12.0.2026.11.22.20.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:40:09 -0800 (PST)
From: Ryosuke Iwahashi <ryosuke@ikotaslabs.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	stable@vger.kernel.org
Subject: [PATCH v3 nf] netfilter: nf_conntrack_reasm: fix IPv6 transport header offset
Date: Mon, 23 Nov 2026 13:40:07 +0900
Message-ID: <d648a02b8a1928708125e07b.nf-v3-ryosuke@ikotaslabs.com>
X-Mailer: git-send-email 2.56.0
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

nf_ct_frag6_reasm() resets the transport header to the bytes following
the Fragment header. If Destination Options precedes Fragment, the Next
Header field at IP6CB(skb)->nhoff still selects the options handler,
which may misread the following UDP header as options and drop a valid
packet.

On native IPv6 input, preserve the transport offset and use fhoff to
locate the Fragment header.

The UDP test datagrams dropped on the unpatched kernel are received
after the fix, and the ipv6_fragmentation and ip_defrag selftests pass.

Fixes: 6aafeef03b9d ("netfilter: push reasm skb through instead of original frag skbs")
Cc: stable@vger.kernel.org
Signed-off-by: Ryosuke Iwahashi <ryosuke@ikotaslabs.com>
---
v3:
- Preserve the receive position so v3 processes options that v2 skipped
  before Fragment.
- Retarget Fixes to the commit that first passed the reassembled skb up
  the stack.
v2: https://lore.kernel.org/netfilter-devel/20261101170633.625161-1-ryosuke@ikotaslabs.com/

Codex assisted with this patch.

 include/net/netfilter/ipv6/nf_defrag_ipv6.h |  2 ++
 net/ipv6/netfilter/nf_conntrack_reasm.c     | 30 +++++++++++++++------
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c   |  6 +++--
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/ipv6/nf_defrag_ipv6.h b/include/net/netfilter/ipv6/nf_defrag_ipv6.h
index ceadf8ba25a4..99f6a5ae73ed 100644
--- a/include/net/netfilter/ipv6/nf_defrag_ipv6.h
+++ b/include/net/netfilter/ipv6/nf_defrag_ipv6.h
@@ -11,6 +11,8 @@ void nf_defrag_ipv6_disable(struct net *net);
 int nf_ct_frag6_init(void);
 void nf_ct_frag6_cleanup(void);
 int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user);
+int nf_ct_frag6_gather_hook(struct net *net, struct sk_buff *skb, u32 user,
+			    bool preserve_transport);
 
 struct inet_frags_ctl;
 
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index be72c4346f8b..6fd8f7d064e0 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -320,8 +320,9 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 			     struct sk_buff *prev_tail, struct net_device *dev,
 			     int *refs)
 {
+	struct frag_hdr *fhdr;
 	void *reasm_data;
-	int payload_len;
+	int payload_len, unfrag_len;
 	u8 ecn;
 
 	inet_frag_kill(&fq->q, refs);
@@ -345,14 +346,16 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 
 	/* We have to remove fragment header from datagram and to relocate
 	 * header in order to calculate ICV correctly. */
-	skb_network_header(skb)[fq->nhoffset] = skb_transport_header(skb)[0];
+	fhdr = (struct frag_hdr *)skb->data - 1;
+	skb_network_header(skb)[fq->nhoffset] = fhdr->nexthdr;
 	memmove(skb->head + sizeof(struct frag_hdr), skb->head,
 		(skb->data - skb->head) - sizeof(struct frag_hdr));
 	if (skb_mac_header_was_set(skb))
 		skb->mac_header += sizeof(struct frag_hdr);
 	skb->network_header += sizeof(struct frag_hdr);
 
-	skb_reset_transport_header(skb);
+	skb->transport_header += sizeof(struct frag_hdr);
+	unfrag_len = -skb_network_offset(skb);
 
 	inet_frag_reasm_finish(&fq->q, skb, reasm_data, false);
 
@@ -365,8 +368,7 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 
 	/* Yes, and fold redundant checksum back. 8) */
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
-		skb->csum = csum_partial(skb_network_header(skb),
-					 skb_network_header_len(skb),
+		skb->csum = csum_partial(skb_network_header(skb), unfrag_len,
 					 skb->csum);
 
 	fq->q.rb_fragments = RB_ROOT;
@@ -443,7 +445,8 @@ find_prev_fhdr(struct sk_buff *skb, u8 *prevhdrp, int *prevhoff, int *fhoff)
 	return 0;
 }
 
-int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
+int nf_ct_frag6_gather_hook(struct net *net, struct sk_buff *skb, u32 user,
+			    bool preserve_transport)
 {
 	u16 savethdr = skb->transport_header;
 	u8 nexthdr = NEXTHDR_FRAGMENT;
@@ -474,9 +477,15 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	if (!pskb_may_pull(skb, fhoff + sizeof(*fhdr)))
 		return -ENOMEM;
 
-	skb_set_transport_header(skb, fhoff);
+	/* On IPv6 input this cursor and IP6CB(skb)->nhoff describe the
+	 * next header for local delivery. It can precede the fragment.
+	 */
+	if (!preserve_transport || !skb_transport_header_was_set(skb) ||
+	    skb_transport_offset(skb) < skb_network_offset(skb) + (int)sizeof(*hdr) ||
+	    skb_transport_offset(skb) > fhoff)
+		skb_set_transport_header(skb, fhoff);
 	hdr = ipv6_hdr(skb);
-	fhdr = (struct frag_hdr *)skb_transport_header(skb);
+	fhdr = (struct frag_hdr *)(skb->data + fhoff);
 
 	rcu_read_lock();
 	fq = fq_find(net, fhdr->identification, user, hdr,
@@ -500,6 +509,11 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	inet_frag_putn(&fq->q, refs);
 	return ret;
 }
+
+int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
+{
+	return nf_ct_frag6_gather_hook(net, skb, user, false);
+}
 EXPORT_SYMBOL_GPL(nf_ct_frag6_gather);
 
 static int nf_ct_net_init(struct net *net)
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index be7817fbc024..f84adba42175 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -64,8 +64,10 @@ static unsigned int ipv6_defrag(void *priv,
 		return NF_ACCEPT;
 #endif
 
-	err = nf_ct_frag6_gather(state->net, skb,
-				 nf_ct6_defrag_user(state->hook, skb));
+	err = nf_ct_frag6_gather_hook(state->net, skb,
+				      nf_ct6_defrag_user(state->hook, skb),
+				      state->hook == NF_INET_PRE_ROUTING &&
+				      !nf_bridge_in_prerouting(skb));
 	/* queued */
 	if (err == -EINPROGRESS)
 		return NF_STOLEN;

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
