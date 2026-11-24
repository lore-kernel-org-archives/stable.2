Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484310;
	b=FxZy7niKnGcZSwU8eI7jbuYkid62RSX78E39JVHDM28bn4pI68DsIlp6LcY7lYcMso7c
	 Z53hDQLvxBehqbut7u6wiSdoN6OjfOWZcV01yxp+YkG9Wcfr7pEwqbNpV/kx+HE+vMEN1
	 K756gK/LPegkl+FnkxJTqlqrEuQW87AvyEVYRifDSIuwfaYJmUGVm/YbM/esX28RXMKwd
	 MAc+lCA3lAxluhZVlnFlMqshmwb7ys9cVBlkleTGVIEYDnOddlsOYqLcUHHFlHwXR5qfX
	 bhNeS59Sleuu6qt07aqCLZtn93teCF6O6gdsEGutxA77Lyo4lvxz1gO848Qalku+nxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zPEkjCEVqbn6YbsK/3IOudjnU9MkfzVsn/g6qbuTA7w=;
	b=xfFwi3d5EX10/7JCAKfiEGnLYT2mZb7igcmEJ6DbRjhFqAitnlBK7a1EN85BGA//T8SK
	 fNxFD9FxPNpjreaeiA9wSZb6vHk7RbdhrkG7PPqJjEvTuEUr8nzwePKD+zKSuNfAkTntR
	 oS3FDIDitMaalYc6UfRpl6Uj9X/JdW0xtkCnV2UFtD44o3EFW3D6DfKBf8PoSOapZc0UQ
	 3g9/28aTmjD57UzCVJwVtAxkyZQIuf+/4g9cT2geUqiXMVr63unKWQTWaMi3i7ukZf0pe
	 nNXA0nD0hm0SUPihlE1KasJjh7eYrTSSpgUnz6NtEcNcsdgcJdQxTPZWqidWn5s1ECw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tis7Ks6Y;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26238606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 01:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26238606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tis7Ks6Y
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67db89857abso4095425d50.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795484309; x=1796089109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPEkjCEVqbn6YbsK/3IOudjnU9MkfzVsn/g6qbuTA7w=;
        b=Tis7Ks6YH3lIFYhtif3vvVyETTXpbJHyX8WoZh7J60hvENiYqzcvsnVH4Q/df67uGT
         vfpdue3Xzbl7nDk0myzXBlXaxsB4MsIL8BwzD/bQemrz70xqpJA1tNSrpWoyXCQW7Fjo
         sCvjn9DXt241tTDV8VUGDXq/Du6JCtFWkMdBP3u3RapBy7CxMAKK9W9mjSYw7j4LpsY/
         nttToLwinv0jVXq7uDMiVlnxJd92W1SaEiyU1yzpdUUlOR4fxQ20VUM7Z2sW+UiCdv7K
         YXuKRnm+vB2+Ex6QlGOyqhuMV7Z/qnp5bew4recieYpL2EVRC//cuA9SjTwoITtcDcRm
         a0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795484309; x=1796089109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPEkjCEVqbn6YbsK/3IOudjnU9MkfzVsn/g6qbuTA7w=;
        b=0wQWlTG8C8xrelvzYO6kb/9Lc6m8EJFwIaMws+FEtOPvh59qvOfS3R8U7+z9hbBZmb
         /REaFTInivV7vdqGywSjnRl2sKgpkCcwLTmkEQSd+r5sLA3blnQRCcBMM8XcbW1P+nAX
         s4hh8/IX36wV6M0aXKb3uOl/rhuwxAOudognLKG4Bn9g7Wb+KFSf4MeugfDR5Uo8Ol3Q
         xZzo0KoNvlwIW8XwPhDbWw3TYa5xMG+SP98QX7MLz3WdcUY3zjCZO2Oxv9GkVeqXq1It
         zH/OIFOFwtMedrgGN8CfpmUe7GCrO56K9RS6vCIIqHZsrfER/np1AtpX5D6MC2vVGrHt
         bmPw==
X-Forwarded-Encrypted: i=1; AL+hErEA3qN+ao5EQ/X3YL8rfOg262DuyHeqAJe39iU/uZpyr0+38O2CGq0E9LqYAZMu8Q0zQ76hXjg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MWc0BRVdaDKXLELkSYtjyLHHAcqvftGS09TgfXkhP2WUo5GTs
	LY3nwXuOPrrahvzV1p3YHfcHRn38mwBNgfzP9mGo7RgqiezJAUDfcxUS
X-Gm-Gg: AZFdTZdOkOYXEuaq+lnJN/p2Pn58eYzT6Er13px8GE1f/+m4JMgY0S0fW/x/sC6uu26
	tLhcnsfzy6ZdmKdKO90d/GXjb3f4TGkSAMDTcZGUyiPlnbJK7bn2GzbB8W/IkIOhmjrggRbTQfA
	JKvmvdESMm6kmDwX13NXwjDcxCASItSr/unswl07pEMcGYFptPHnPY85WCeJO8SUIL6OxiKGfob
	e6uF9qo8SNWneWOA0oSHoFHXacz3HuUyUoz1KkE1Mz5uEWCj8CZFQLgvDsBItx0c910LJwAeRGi
	Qk1XaBUbjm4Q3VwoMgkWtqcuR07TLhGV5MNOt321KpT4XhEddSDxUuNdrFi4kVmPl5rh4f1yL3u
	QB5I66CL8Op8+1X0cOS0pz/w6ZbqlxCCNfhlMPiabytPc2G3jPb+mDzIEJpdfEojsrkfJMXSL/y
	CRWLTTMnc8VPm2MSP5A1zgPqM8ib96dVEFcbqucQ+MbhU6EYhh8y2upSwkx2yn/LJSJxl2L+Uos
	yz1RgXqSLoj8/gpMusR++sRlFblsRKGEq5llj+zdabpbVQxEk7bAuf3msa+Uw5VXYkZ7meOCuu4
	A/gcZgmfEJ1xJxrGPB9ZE5BwOwn/3S0KS62QY0PlAkqIOfaGy0P4dzE6UWzQ5TGCDmaRP77dI4w
	UwlCzsxOm7Imd8o5KgrJXXFHhnbMpph2PhEEviDBfqBcQ3+eWeZJmyquifJHENp7poOL0uV8QMv
	a8j/MKD7GJGPDqmVMfbdYKlEUK
X-Received: by 2002:a05:690e:12cc:b0:679:a943:7da7 with SMTP id 956f58d0204a3-67df447de99mr5037121d50.81.1795484309083;
        Mon, 23 Nov 2026 17:38:29 -0800 (PST)
Received: from localhost.localdomain ([2600:1702:7bd1:1ca0:6d54:522c:b8ac:678d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52036d72csm52271787b3.45.2026.11.23.17.38.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 17:38:28 -0800 (PST)
From: Aviral Srivastava <aviralyash27@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	Aviral Srivastava <aviralyash27@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] udp: gro: do not match tunnel-processed and plain packets
Date: Mon, 23 Nov 2026 17:38:23 -0800
Message-ID: <20261124013823.96835-1-aviralyash27@gmail.com>
X-Mailer: git-send-email 2.55.0
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

udp_gro_receive_segment() matches an incoming UDP packet against the
held packets using udp_hdr(p), while every other GRO layer compares at
p->data + off. When an inner network header was parsed for p (vxlan,
geneve, or IPIP/SIT/GRE carried over FOU/GUE), the transport header of
p points at the inner L4 header. The port check then compares the ports
of an incoming plain UDP datagram with the inner TCP/UDP ports of the
tunnelled flow, and on a match the datagram is handled as the next
segment of that flow.

This needs both packets in the same GRO bucket with the same outer
addresses (no RX hash, or an equal one), a UDP tunnel GRO socket on the
receiver, and a UDP_GRO socket on the port, rx-udp-gro-forwarding or
rx-gro-list. Plain and tunnelled TCP cannot meet this way, their outer
IP protocols differ.

Since commit e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
the datagram can be merged into the tunnelled aggregate. On v6.6.162 a
plain datagram with ordinary outer header values (same TTL, TOS and DF
as the vxlan packet) is appended to the inner TCP segment and never
reaches the UDP socket.

Since commit 4b0ebbca3e16 ("net: gro: move L3 flush checks to
tcp_gro_receive and udp_gro_receive_segment")
gro_receive_network_flush() also derives the network header of the
incoming skb from p's offsets (outer network header to inner transport
header: 70 bytes for vxlan over IPv4, more with larger inner headers)
and reads before the incoming skb's network header, out of bounds on
skbs with small headroom:

  BUG: KASAN: slab-out-of-bounds in __gro_receive_network_flush
  Read of size 1 ...
   udp_gro_receive <- udp4_gro_receive <- inet_gro_receive <- dev_gro_receive

The merge then depends on the bytes read there. When it happens with
rx-gro-list and forwarding, the datagram is forwarded as part of the
inner flow's aggregate, so netfilter rules matching the datagram itself
are not applied to it. Without a merge, the wrong comparison still
flushes the tunnelled flow on every such datagram.

When udp_gro_receive_segment() runs, NAPI_GRO_CB()->encap_mark is set
only if an inner network header was parsed for the packet, which is
also the only case where the transport header is past the first UDP
header. FOU and GUE clear encap_mark, but when they carry an L4
protocol directly the transport header and network offsets still
describe the outer headers, the same layer as for plain UDP; when they
carry IPIP, SIT or GRE the inner handler sets it again. Skip held
packets whose encap_mark differs from the incoming packet: both are 0
or both are 1 within one flow, so legitimate aggregation is unchanged.

Found by an AI code review agent (Claude) reviewing the UDP GRO code.
Confirmed with reproducers on unmodified kernels (arm64 QEMU with
KASAN, network namespaces over veth), and the fix was tested there:
- torvalds/master 4843f6873f7c, vxlan, geneve, and FOU/GUE carrying
  IPIP, SIT, GRE and vxlan: KASAN reports on every run before, none
  after; forced merge of 98% of the datagrams before, none after.
- v6.6.162 with this change backported, vxlan and geneve: 2000 of 2000
  datagrams merged before, none after; no KASAN report either way.
- Plain UDP GRO, UDP and TCP in vxlan, UDP in geneve and UDP in
  FOU/GUE + IPIP/GRE still aggregate.
Not tested: x86_64, real NICs, vxlan-gpe.

Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
Cc: stable@vger.kernel.org
Signed-off-by: Aviral Srivastava <aviralyash27@gmail.com>
---

Notes:
    v2:
    - Add Fixes: e20cf8d3f1f7 and Cc: stable. The merge without the
      out-of-bounds read is reproduced on v6.6.162 (Sashiko).
    - Reword the comment and changelog on what encap_mark means with
      FOU/GUE. No functional change: FOU/GUE carrying L4 directly keep the
      transport header at the outer UDP header (Sashiko).
    - Changelog: state the preconditions, correct the netfilter sentence
      (the hooks see the aggregate, not the datagram), move discovery and
      testing into the changelog, add geneve, FOU/GUE and v6.6 results.
    - v1 reported "28 and 29" KASAN reports; that was the dmesg ring
      limit. The console logs of those runs hold 1023 and 308 reports.
    v1: https://lore.kernel.org/netdev/20261122183951.73210-1-aviralyash27@gmail.com/
    
    The analysis, reproducers, fix and changelog were drafted with an LLM
    coding assistant (Claude). I reviewed them before sending. Reproducers
    and logs are available on request.

 net/ipv4/udp_offload.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b77ae2f00c62..a9368a6abde2 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -723,6 +723,19 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
 
+		/* encap_mark is set here only if an inner network header
+		 * was parsed (UDP tunnels, IPIP, SIT, GRE, also when carried
+		 * over FOU/GUE). udp_hdr() then points at the inner L4
+		 * header and the network offsets describe the inner packet.
+		 * FOU/GUE carrying an L4 protocol directly clear it and
+		 * leave udp_hdr() at the outer UDP header, as for plain UDP.
+		 * Never match packets across the two cases.
+		 */
+		if (NAPI_GRO_CB(p)->encap_mark != NAPI_GRO_CB(skb)->encap_mark) {
+			NAPI_GRO_CB(p)->same_flow = 0;
+			continue;
+		}
+
 		uh2 = udp_hdr(p);
 
 		/* Match ports only, as csum is always non zero */
-- 
2.55.0

