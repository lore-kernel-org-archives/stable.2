Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597314;
	b=jalUv9svYYG+XORW1/0erFUZDMDAWfhV2c3WbvkN/ZQYF+w73gySkSJ2FC7SQEtZTeti
	 7OxQztZ17HhnSG+I7XRZgC0KD8rCZW63M99EAH4G2arMo32rmW12qlpbPd0c/XbC7PqMv
	 o2n+rbEYS08ksxzCUXbPeJeR164YpK5BCxMYWOotTSBFSjbYHT7pdsFil/PEIFMF+UUJ2
	 jEuJ2e7rxgKiSTAHcrz/+3YcbwpypV+wLNuTgKOHI0rAsDx0KW9pc+0ChfXa9AhX5rNfe
	 r0jnHmPumSoYC8YpeE4Vx7JSfuL8qWHc942/M9EiaEaKy5gPai+XoRyalnVWQSWjmWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597314;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DjlpRVPXdBCfW1X5kMgPbu+bGPuUsFmTLS8YY/LVb94=;
	b=oEcIam+OdlA47PAi9PNATrS/+0F+kPPxikky24No2ZpFpA+vag8uuDHslP64hJRPhN1z
	 l3Qh7l17BiGmc+ggIC1e1WR7rHVHwJ+LOwob+HHJsX2uANpREa/njI4KyIBD5G1tNM3zE
	 kYF/d3Qd84zR8zeF7NZnLNn6QzP9ZZtAl4Dj8xcRkRXhG9pwpA3TIu/j8iwJ7aiR9KZtZ
	 uh2+4EOyRvjXNiIZpamzIdyBU6S+RQndNubxXmally6y2M3Vb7monbzju9FsLOFUPh+pG
	 jx7ww+HN7LEpOzBAf6jMAe9gxmeONAUwoO9TujCDfZXvMcmQSysG1SHkqWbhJamkAkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hBu0PIh7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD0606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hBu0PIh7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03051F000C1;
	Wed, 21 Oct 2026 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792597314;
	bh=DjlpRVPXdBCfW1X5kMgPbu+bGPuUsFmTLS8YY/LVb94=;
	h=Subject:To:Cc:From:Date;
	b=hBu0PIh7ew/PovMvLS0pCKNHjZhrHabKYiibkTlZcpfW5Y8fsQ55OED4SgHV9aw82
	 /4ZDRoezdjrlptOS8TV/vM2rDC/TWZ55n47FEos7Ba/jvIwNXwRQhpg+7rq8GP1lGo
	 9/FdDi3fmbhoQiDbHLgY1CJNYZZKHC6Eqz5rbjIw=
Subject: FAILED: patch "[PATCH] ipv4: udp: Create exceptions before socket matching" failed to apply to 6.6-stable tree
To: idosch@nvidia.com,aksecurity@gmail.com,dsahern@kernel.org,kuba@kernel.org,noam.caspi@mail.huji.ac.il
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:39:20 +0200
Message-ID: <2026102120-delete-matching-aff8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4c3499f79f8c7e8561266bcc220a18538cec0458
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102120-delete-matching-aff8@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c3499f79f8c7e8561266bcc220a18538cec0458 Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Fri, 28 Aug 2026 22:23:42 +0300
Subject: [PATCH] ipv4: udp: Create exceptions before socket matching

Currently, when ICMP Fragmentation Needed and Redirect Message packets
are locally delivered and quote a UDP packet, a FIB nexthop exception
(FNHE) is only created if the kernel can match the UDP packet to an
existing socket.

This behavior allows off-path attackers to conduct a side-channel attack
on the FNHE cache in order to discover the ephemeral port used by a
connected UDP socket.

Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
less predictible") tried to mitigate such attacks by making it harder
for attackers to discover hash collisions in the FNHE cache and by
randomizing the number of exceptions a hash bucket can hold,
respectively. Unfortunately, both of the mitigations can be bypassed.

Instead, mitigate such attacks by always creating a FNHE, even before
trying to find a matching socket. Do that by calling ipv4_update_pmtu()
and ipv4_redirect(), the helpers used when the quoted packet did not
originate from a socket.

This means that guesses (right or wrong) from an off-path attacker will
always result in a FNHE being created or updated in the cache that the
attacker can observe.

Pass an oif of 0, in a similar fashion to icmp_err(). This is also the
oif used by the socket path for sockets that are not bound to a device.

Note that this does not allow attackers to create FNHEs that they could
not create before, as both helpers can already be reached with little to
no validation. For example, by sending an ICMP error that quotes an ICMP
Echo Reply or one that quotes a UDP source port that matches a wildcard
socket.

Also note that in the good case (matched socket) the above scheme comes
at the cost of an extra route lookup, as the no socket helpers perform
their own lookup before the one performed by ipv4_sk_update_pmtu() /
ipv4_sk_redirect(). When the two resolve to different nexthops, it also
results in two exceptions being created for the same destination IP. One
in the FNHE cache of the nexthop resolved by the no socket helpers and
another in the FNHE cache of the nexthop used by the socket.

Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
Cc: stable@vger.kernel.org
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260828192344.2596928-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6ff5670bf6ed..bb8cfc62cb00 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -900,6 +900,15 @@ static struct sock *__udp4_lib_err_encap(struct net *net,
 	return sk;
 }
 
+static void udp_err_update_exception(struct net *net, struct sk_buff *skb,
+				     int type, int code, u32 info)
+{
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_UDP);
+	else if (type == ICMP_REDIRECT)
+		ipv4_redirect(skb, net, 0, IPPROTO_UDP);
+}
+
 /*
  * This routine is called by the ICMP module when it gets some
  * sort of error condition.  If err < 0 then the socket should
@@ -923,6 +932,8 @@ int udp_err(struct sk_buff *skb, u32 info)
 	int harderr;
 	int err;
 
+	udp_err_update_exception(net, skb, type, code, info);
+
 	uh = (struct udphdr *)(skb->data + (iph->ihl << 2));
 	sk = __udp4_lib_lookup(net, iph->daddr, uh->dest,
 			       iph->saddr, uh->source, skb->dev->ifindex,

