Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605740;
	b=pyWEt500zWlFOxtpyoELju1GpXDwlPXnMiD66nFEXWm48RlT6FoUK+zGgKkLOGlWWnSj
	 H5fbh2ZIWPC2n8VCQyZHglch079sycHNC7+IVO+aBwtRSC6dOvpRn1PcLBXwBynTb5C8h
	 s2aeec8RBwNyfOl2YhscCshHeIHf3AFOC6qB66OmiBPyE3uaAd+eIHmfABaxxL6A7WRpv
	 fGuEYBSgx3KP17uVuKdfMVne0bwNfbAIknz4/eVtLXsZ9kIpV+vLr1drXLhekVDgCKQdP
	 zycpALb1iIu5K3Bi3rV8QZF6QuXYmPvZ1fP8OxoiwJjxEWxH+mVcwd0oPiwf5vGVtiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605740;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CZ0RpRrq2nSW3sSSZyakC7djhxcPcGFzQemPF8KWlx4=;
	b=Pbq8ngpEvTOZjkTpbxUheF4H+gcS3gAyqrRRI0uwIpd24WhE7ga2gO1e3zajcO3IGfmx
	 sBO9BH1xJ1zI63XY5uMgL7Xd6+khdtXEYSzFDFh9iEfWuNuaKJEKiJMLVji77rdyH5WI+
	 rLL90LJZFfjzg/mnb/m4kuNel7Keftlo50kKTEBOHrjN0aZP47MakMzgWrQyj90Y7e8rA
	 8/bPPJcQyWt/wNULpoE2XlYcr21hlkvqn+MmRa6Qeo7oUSty5L6iujhUwXqUF0zxedSZC
	 faDbkB4Xk55VxOzYrF2zRPbS0dh0qSDVtbAiCI5deGcUrdEeGYLnF0gQoA//Nh2pq9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Nn9AdWok;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA3606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Nn9AdWok
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953FF1F000C1;
	Wed, 21 Oct 2026 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792605739;
	bh=CZ0RpRrq2nSW3sSSZyakC7djhxcPcGFzQemPF8KWlx4=;
	h=Subject:To:Cc:From:Date;
	b=Nn9AdWoktOeJOCuDCPcbleh1AufCoUC33VdPCviPYv1uGseV0qSUFpNbc6iUWRxWG
	 Xa7EdgHjCL2B2syxJMsQwhUwSPyXVO2VtCJeQqnLgMbLCIZVsi9V0AUlSlsfTBQBtV
	 AW2GXM9VWadi9V9iUoeFmXkFOkZeUHPzeISw0gR0=
Subject: FAILED: patch "[PATCH] ipv4: udp: Create exceptions before socket matching" failed to apply to 7.2-stable tree
To: idosch@nvidia.com,aksecurity@gmail.com,dsahern@kernel.org,kuba@kernel.org,noam.caspi@mail.huji.ac.il
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 19:54:54 +0200
Message-ID: <2026102154-unfiled-decorator-3b61@gregkh>
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


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 4c3499f79f8c7e8561266bcc220a18538cec0458
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102154-unfiled-decorator-3b61@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

