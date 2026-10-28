Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196877;
	b=BN3BG2AnL8Ykn9VQTMO/MUn46utJT1y5XRlbTQbhdRS7ov6zbqXJM+3vzUUUX2nmS/c3
	 sAjWbIhnEa6KqfbmJ50lLC8/MGayVaniIHmtjjp4YwX6AGe1HVSBxOtTVYqSIqi1+siA7
	 Np+eW+qevmFwJWqjqcVWoljYz/6rWHaqHc6sB8BBk7YxSqDYb4LI8rqD1uV+VyMBZlv5o
	 js4mBuyHcKUkDH5FuBp352abqCDy06sAn4snF6jym/VVH6PBCxkgV+OUzbBHdlszOtrhz
	 4bn6VQ/VNsxN+zx5gU4PE/Re5oO3TkWrkvrnTV1OKRlwPQHd4UqwUV45VtKnL8GGV1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196877;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wNzoJSooKLcqaNt3q0EMahTbJnTQOLKtUmqJR0PfpxM=;
	b=bQ4ucjLTxzI/DLRUv13vuMufnpDMyHH+7uqIA2vurCb+R/iBWbQ8YDgq1azR8nO6Nlet
	 tp7gMDPIe7CWPZgIFQ58YFuJ+a+uoDQt39HfsaSRjJIk+mxZbNCYhaUqnDu+PCpVZt2Eg
	 UduW8KWKYtlRDZFBMhN+mpkFX4zJx5bWb5wXo8iMBfbcPL+da++akDeMVt0/BrTwS3sFJ
	 vXAM/ncCs0sKIkI5/mbnLrhK/f+anPTR3ANcii1ety12a8ENo+gmva1QKX92tQG5/pneo
	 o2ynjz4UgmqXJhQNE2lvANyUvFAd67lfXlITxiabtzqMKZqzlVusJ5CpQQPFkc9SIaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGa11QSg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C1606A31A;
	Wed, 28 Oct 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGa11QSg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793196877;
	b=bccWjZYLyhgppYqlR9YF+LHj9oGJ9xaHXTU+L4iBGmuQ290fBQmyGj2c8Wo/jyI2GBhX
	 /yhzzqtt2wVFSiBxWoUNZP3o2TG7SkLwWTEhQNpf3jzJUdb4xvThIf34AUgaybvb4JM0s
	 TXM3HFqTe4hUGoaFzYF3gZtdYNmhLpL+TUygsXoRzIK69oq1QNC+bmCsUFl75ItqESLhj
	 s05mwukG3x2BrV1AV/nHfhPckU5aO4eR4nW7mK3g814rUmkwzp4HhlAlcNgVckqp2m4Yx
	 CuouS4lfWcg1AJikY9MMmFgDilwivJM9OXyTmUxBQArS4CQir9UsJGAQB/CqcbDZu9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793196877;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wNzoJSooKLcqaNt3q0EMahTbJnTQOLKtUmqJR0PfpxM=;
	b=ox663J4uB4aN7C9RGVhdb85VJxgpdhKSRUzJuY3DwLJJ3lcivtLi9IthoSM9Ndc6DnDj
	 g+v1Tr+SnrSCBQPj4Tbx67CCQZtyRxOiEeynOwxI9j4RStBO60iesn2EX+tTRKRgu1Gmi
	 438mq3dJGaojo/qWQNXx/9VNUoDdBzIGm7Vf8WK+oTBrBWiM+w5/bMbB90EXuHWR0zRdH
	 EoJhLRwOOt2fvrqrNHrzCzqFxkpOatCNnb6YdZb3MP9dHLJRZVwCEgEk94429Ck49iI18
	 QGcoZxXyVd5qmhRsgpCbNl+khhjXo8Sga78PvP6loQGB+TSBrTq5cXdOZXq/mTp71NA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 467C61F01825;
	Wed, 28 Oct 2026 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196877;
	bh=wNzoJSooKLcqaNt3q0EMahTbJnTQOLKtUmqJR0PfpxM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aGa11QSg0hd6hMwqPgNyQxOjLCJ0gGoW8MY2Eel8NrdyQPjN0OYA6pfI3wpXj3WXt
	 hMLg7mPttoFdhBMZ30P+I77obei97tjPaFXUlhB6ST9vp1cSSOrZnEJTPrpG9n623R
	 VF9lv3/3NlNwgswgJ8Ee8GoI7YknQZ6NctUOU18hybWKhzD0KSBQHNHplnopJ/m/t9
	 HLCdJwrT9Eg0YpHDYG/YBym0/8gVRY1Qa45lN0CznmP8Id+a5DxPBwwPRzj8UAEjHC
	 vHpiFsgGDqPqf2kvgt862nDROrd3TKrkzLqZTrzDtvUdOBCE0Xe1B4gVMn5Ch9wLh2
	 pCo8zTHRgJtgQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 969C3454A4;
	Wed, 28 Oct 2026 14:14:35 +0000 (UTC)
From: Usman Malik via B4 Relay <devnull+usmanmalik.engineer.com@kernel.org>
Date: Wed, 28 Oct 2026 15:10:40 +0100
Subject: [PATCH ipsec] xfrm: use software GSO for inner tunnels without
 crypto offload
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
Message-Id: <20261028-xfrm-inner-gso-v1-1-1908f0eb7313@engineer.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWMSwqDQBAFryK9tkEH/OUqwUUc35gOZJTuJAji3
 Z3osgqqNjKowOiWbaT4ickcE5R5Rv75iBNYxsTkCleXhWt4DfpmiRHKk80c2qGrao+2GytK0aI
 Isp7DO8li8NRf2r7DC/7zn9G+H1sOCA55AAAA
X-Change-ID: 20261027-xfrm-inner-gso-f8b956ce89d5
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmin Ratiu <cratiu@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 stable@vger.kernel.org, Usman Malik <usmanmalik@engineer.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8165;
 i=usmanmalik@engineer.com; h=from:subject:message-id;
 bh=mTypX1zNQGDPGclAGpw+WOJIpIe4eb8zZnLMHI6cuAM=;
 b=owEBbQKS/ZANAwAKATUQMBv7n6GlAcsmYgBq4gNKFIjTrzQPmHyXaPovwFr2zNieUmeCZWrvv
 i7jYzwhpLWJAjMEAAEKAB0WIQTkhh6bEhkO248PEok1EDAb+5+hpQUCauIDSgAKCRA1EDAb+5+h
 pfK9EACbjA4MOdXK6k6YcsMwM2+JE0Ur2DJOHVwEa83y1wKMkT0zAgOCyRL15jOurpeejtVIqBh
 o0AwSv6FJLjeIHOfCgBaRwdmnAdscUqa0YeBHaKqr9bkObfaUNSPMVBtSuagf/TiLdFit9lnw5P
 ESMsqHzbOGu8Lyb0wytmjb7FQ0Fw8qjQJJftewhgR32BR3dOQPYtlfRALBFJZHvWuWPrOHDepTI
 Qmj2k2zNwrxc86L+k7X4X9tj/ovy3bilgs93/zb84qamt2Fm3xJybMuj23S072zHJHoN7VDbBsT
 WUpgEylLN0utsqBvwQq4TKRbb6lU7UBif1hA+8M53JJcb6DDGDuLuYMga16Kv2/0Opcj5OJ+6Vb
 MthGyzXC38fFO6EsrjXclDgAujvAbG0X88JwNPA28Q0hYYNKAegtx+FgX+TFNa27THe2q/k87OR
 4B354bvoZ4IRNuyM/Yr0FoZ6xeiEUv224kNsTfamfrfu+sfvSohIqXZ17cXOa3ImqpkAntyUCkN
 /jrL/PuA8RgAm+5c6FoGMjK4Oxa0l2xal00+tx4HhRu8S4Eo4HvD1OG/z39QZHeJ3z9pns3Wcw2
 xV3dE9wAgOWqHBOCYfCqgpXAOxTkKSZCiY9NvAXn3Q1ljvJ1kZ5E0/j3hn9MMOyLrVbnKtKGeuh
 mGY+PWJah3AOtNg==
X-Developer-Key: i=usmanmalik@engineer.com; a=openpgp;
 fpr=E4861E9B12190EDB8F0F12893510301BFB9FA1A5
X-Endpoint-Received: by B4 Relay for usmanmalik@engineer.com/default with
 auth_id=1336
X-Original-From: Usman Malik <usmanmalik@engineer.com>
Reply-To: usmanmalik@engineer.com
Content-Transfer-Encoding: 7bit

From: Usman Malik <usmanmalik@engineer.com>

Commit 0aae2867aa60 ("xfrm_output: Force software GSO only in tunnel
mode") limits the software GSO of packets with skb->inner_protocol set
to tunnel mode. Its message says that packets with the crypto in
software still get software GSO in the else branch. That holds only
while no ESP GSO handler is registered. With esp4_offload or
esp6_offload loaded when the SA is created, x->type_offload is set and
xfrm_dev_offload_ok() returns true for an SA without an offload device.
A transport-mode SA with software crypto then sends such a packet down
the SKB_GSO_ESP path.

That path does not handle an inner IP tunnel. For an ipip or ip6tnl
packet, xfrm{4,6}_transport_gso_segment() pass the packet to
inet_gso_segment(), which leaves the transport header of each segment at
the inner TCP header. __xfrm_transport_prep() expects it right after the
ESP header and IV, so esp_xmit() and esp6_xmit() write the ESP header at
offset 4 of the inner IPv4 header and encrypt from the TCP header. The
first 4 bytes of the inner IPv4 header go out in clear, the receiver
drops the segment with XfrmInStateProtoError, and bulk TCP through the
tunnel falls to tens of Mbit/s. The v6.13 release does not show this,
v6.14 does, and so do the stable kernels that carry 0aae2867aa60
(measured on 5.4.293, 5.15.223 and 6.1.190).

Use software GSO for packets with skb->inner_protocol set when the SA
has no offload device, as before 0aae2867aa60. An SA with crypto offload
on a device keeps the SKB_GSO_ESP path in transport mode, which is what
that commit is for.

The transport GSO handlers themselves still do not handle an inner IP
tunnel. An SA with crypto offload that falls back to software
segmentation in validate_xmit_xfrm() takes the same path. That is a
separate change in xfrm{4,6}_transport_gso_segment() and is not part of
this patch, which restores the behaviour before 0aae2867aa60 for SAs
without an offload device.

Tested on v7.3 in a VM with two network namespaces on a veth, a
rfc4106(gcm(aes)) SA between the outer addresses, esp4_offload and
esp6_offload loaded, TSO on and 3 MB of bulk TCP per run, plus a 4 s
iperf3 run. Both test kernels also carried a local esp6_xmit() change
that builds the IV from the sequence number read before the increment,
as esp_xmit() does, so that the capture analysis could check nonces as
well. That change does not touch the path changed here. The sender
capture was decrypted with the SA keys. Without this patch, two ip6tnl
runs had 22 and 24 malformed packets at 36 Mbit/s, two ipip runs 18 and
36 at about 50 Mbit/s, and iperf3 over ip6tnl gave 195 Mbit/s with
XfrmInStateProtoError +358. With it, every ESP packet decrypts at offset
0, no inner header byte is in clear, XfrmInStateProtoError stays at +0,
the same runs reach 1.0 to 2.4 Gbit/s and iperf3 gives 2.62 Gbit/s. A
function profile shows these packets now go through xfrm_output_gso(),
while plain TCP over the same SA still goes through esp6_gso_segment().
vxlan and geneve over a transport-mode and a tunnel-mode SA were clean
before and after. In transport mode they now take the software GSO path
as well. Hardware ESP offload was not tested, as no such NIC was
available, and neither were BEET and IP-TFS mode, nor GRE over a
transport-mode SA, which this change also moves to software GSO.

The bug was found while measuring bulk TCP throughput through an ip6tnl
tunnel over a transport-mode ESP SA.

Fixes: 0aae2867aa60 ("xfrm_output: Force software GSO only in tunnel mode")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Usman Malik <usmanmalik@engineer.com>
---
The malformed layout is visible without keys. On the sender,

  tcpdump -ni va 'ip6 proto 50 and ip6[56:2] = 0x4500 and ip6[60:4] = 0x1001'

lists exactly the malformed packets (22 of 22 in one v7.3 run, 0 with
this patch). For ipip the offsets are ip[36:2] and ip[40:4].

Reproducer for the ip6tnl case. It prints the sender rate and the
receiver's XfrmInStateProtoError delta with TSO on and off. Run as root
with iproute2, ethtool and iperf3. Rerun after "ip netns del a" and "ip
netns del b" if it stops early. On a plain v7.3 it printed 107 Mbit/s
and +366 with TSO on, 2.72 Gbit/s and +0 with TSO off. With this patch
it printed 2.62 Gbit/s and +0 with TSO on.

  #!/bin/sh
  set -e
  modprobe -a esp4_offload esp6_offload
  A="ip netns exec a"; B="ip netns exec b"
  ip netns add a; ip netns add b
  ip link add va type veth peer name vb
  ip link set va netns a; ip link set vb netns b
  $A ip link set lo up; $B ip link set lo up
  $A ip link set dev va mtu 9000 up; $B ip link set dev vb mtu 9000 up
  $A ip -6 addr add fd00:a::1/64 dev va nodad
  $B ip -6 addr add fd00:a::2/64 dev vb nodad
  $A ip -6 tunnel add t mode any local fd00:a::1 remote fd00:a::2 \
     encaplimit none hoplimit 64
  $B ip -6 tunnel add t mode any local fd00:a::2 remote fd00:a::1 \
     encaplimit none hoplimit 64
  $A ip link set dev t mtu 8926 up; $B ip link set dev t mtu 8926 up
  $A ip addr add 10.9.0.1/30 dev t; $B ip addr add 10.9.0.2/30 dev t
  key() { head -c 36 /dev/urandom | od -An -tx1 | tr -d ' \n'; }
  K1=0x$(key); K2=0x$(key)
  for n in a b; do
    ip netns exec $n ip xfrm state add src fd00:a::1 dst fd00:a::2 \
      proto esp spi 0x1001 reqid 1 mode transport replay-window 128 \
      aead 'rfc4106(gcm(aes))' $K1 128
    ip netns exec $n ip xfrm state add src fd00:a::2 dst fd00:a::1 \
      proto esp spi 0x1002 reqid 2 mode transport replay-window 128 \
      aead 'rfc4106(gcm(aes))' $K2 128
  done
  $A ip xfrm policy add src fd00:a::1/128 dst fd00:a::2/128 dir out \
     tmpl proto esp reqid 1 mode transport
  $A ip xfrm policy add src fd00:a::2/128 dst fd00:a::1/128 dir in \
     tmpl proto esp reqid 2 mode transport
  $B ip xfrm policy add src fd00:a::2/128 dst fd00:a::1/128 dir out \
     tmpl proto esp reqid 2 mode transport
  $B ip xfrm policy add src fd00:a::1/128 dst fd00:a::2/128 dir in \
     tmpl proto esp reqid 1 mode transport
  $B iperf3 -s -D
  err() { $B awk '$1=="XfrmInStateProtoError"{print $2}' \
          /proc/net/xfrm_stat; }
  run() { e0=$(err)
    $A iperf3 -c 10.9.0.2 -t 4 | awk '/sender/{print $7,$8,"retr",$9}'
    echo "XfrmInStateProtoError +$(( $(err) - e0 ))"; }
  echo "tso on";  run
  $A ethtool -K t tso off
  echo "tso off"; run
  pkill iperf3; ip netns del a; ip netns del b

The esp6_xmit() change in the test kernels does what Jeremy Jean's
"[PATCH ipsec 1/7] xfrm: esp6: use the current sequence number for the
IV" does, except that esp.seqno is built after the seq.hi update, as in
esp_xmit(). The two differ only at a seq.low wrap. This patch was not
run on a v7.3 without that change.
https://lore.kernel.org/netdev/20260930144523.435271-3-Jeremy.Jean@oss.cyber.gouv.fr/

Jeremy Jean's "[PATCH ipsec 6/7] xfrm: segment untrusted GSO packets
before sequence allocation", not applied yet, changes the same condition
in xfrm_output() and moves the skb->encapsulation line above it, so
whichever lands second needs a rebase. 6/7 adds SKB_GSO_DODGY packets to
the software GSO case. The packets here come from a local TCP socket and
are not DODGY, so 6/7 does not cover this case.
https://lore.kernel.org/netdev/20260930144523.435271-8-Jeremy.Jean@oss.cyber.gouv.fr/
---
 net/xfrm/xfrm_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e305ba32e..c370d28a8 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -808,7 +808,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		skb->encapsulation = 1;
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
+			if (skb->inner_protocol &&
+			    (x->props.mode == XFRM_MODE_TUNNEL || !x->xso.dev))
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;

---
base-commit: 835912998ca54a76b5c57f8c8459a86b1b45de40
change-id: 20261027-xfrm-inner-gso-f8b956ce89d5

Best regards,
--  
Usman Malik <usmanmalik@engineer.com>


