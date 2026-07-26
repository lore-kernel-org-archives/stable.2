Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE134EF0D;
	Sun, 26 Jul 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091163; cv=none; b=ZUp+vWwZHcCFBjq3TXLgStV+mrBIBHBS3tJSceDf3uSlNhGlUzYVgsiC8EBdWrtGEoi2Ch9YkIYOdrI4jUrUglWY3eZUhfk0AV3uohKbuJp2luhrvj/SiJqdPnBT3PWAqPe66P5u0g03TB+Wzzeog1oEZErAIBBm2/YnOFhiGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091163; c=relaxed/simple;
	bh=rkAs+vxc5zkurPkS0xvNVIkcjwtWTeHIyGJnYfnUwuA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MtU8Pi5/MYdsBfV8wo6/dHrsd998ip8Z0RiAC563nCFcXAr5sl0gP4PZp7sAAIIVPdmdVX5rh4e88hiKUjZSFN3FUdRGKJ+KwyGVYHq9GgMT/jgi+3mrjjCo4N5WlYfLqlAXFqsC6bCRhHEOL28iAMlYu3e6sYLFzh/zkl5rFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=J0IPjGka; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=J0IPjGka; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=P3AxJJVT; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="J0IPjGka";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="J0IPjGka";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="P3AxJJVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1785091152;
	bh=rkAs+vxc5zkurPkS0xvNVIkcjwtWTeHIyGJnYfnUwuA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=J0IPjGka3wFC2j7/WWSM9exvHJ3+NqNGKsytbHRNRsTHpDDebMbGMWdfdPd85EK0U
	 a++zrbfGYxT222yQTRe3lszmxhDXiGtexC5rk17nwYO01r2sajSxXgYwsrxLAEqt0m
	 a4R1cyK/MHq7MdeGw2zqvCOcCnJKzpLq+XiNLJ/GsvA81dQIdi+/qeBccOjTz2FCYB
	 E1JedOsB/RNFfTNPi8sbGhxpOTRHhvfhTIrqlaeO5PAYvvClcC4iNlPEX8hobsVRgU
	 ZmoZqkvJhzk/IF0sh3CfdoeghJy8zea/XhW7kq3BJda5J02HtkkDrDJ1mHKvX2Ac+3
	 1gwzlwSeJmNwA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6E623BCA;
	Sun, 26 Jul 2026 20:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1785091152;
	bh=rkAs+vxc5zkurPkS0xvNVIkcjwtWTeHIyGJnYfnUwuA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=J0IPjGka3wFC2j7/WWSM9exvHJ3+NqNGKsytbHRNRsTHpDDebMbGMWdfdPd85EK0U
	 a++zrbfGYxT222yQTRe3lszmxhDXiGtexC5rk17nwYO01r2sajSxXgYwsrxLAEqt0m
	 a4R1cyK/MHq7MdeGw2zqvCOcCnJKzpLq+XiNLJ/GsvA81dQIdi+/qeBccOjTz2FCYB
	 E1JedOsB/RNFfTNPi8sbGhxpOTRHhvfhTIrqlaeO5PAYvvClcC4iNlPEX8hobsVRgU
	 ZmoZqkvJhzk/IF0sh3CfdoeghJy8zea/XhW7kq3BJda5J02HtkkDrDJ1mHKvX2Ac+3
	 1gwzlwSeJmNwA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 54272B7E; Sun, 26 Jul 2026 20:39:12 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1785091147;
	bh=rkAs+vxc5zkurPkS0xvNVIkcjwtWTeHIyGJnYfnUwuA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=P3AxJJVTebjb1vObmHNPan4wohLsJCg84HKIvrIqw/ldldUuO75gM5v2TWCCMptIj
	 HpDb8KPhcCxjazMUniyMu0VZoIDhRPgiTAZYP+JVkmN643QfyMOXGUVwm4gY1Zf6Pt
	 AUQR68JeV2AFHyi+2YTLuLasMfIey6+5YMiSner6eGoc8u3oBxWtvAU212GA5DpStZ
	 d/zbiCjEArAIJur6XaVf0rF5aWXvDQJTxEdmXajpC9VRPfuq5zW5Qt1LVre3r/r1LX
	 aOhWjXaMDVKLDYIKBxBGsiSpLQ3qtsH57tPDss/EX1WuSBNQI0eODKEMWWvRHZy3Y2
	 xjzSPoYTNFPaw==
Received: from sara (unknown [IPv6:2001:9b1:efc:9600:e20d:7ad8:ae65:24eb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 739C0C9B;
	Sun, 26 Jul 2026 20:39:07 +0200 (CEST)
Date: Sun, 26 Jul 2026 20:39:06 +0200 (CEST)
From: Peter Astrand <astrand@lysator.liu.se>
To: Thorsten Leemhuis <regressions@leemhuis.info>
cc: linux-wireless@vger.kernel.org, 
    "stable@vger.kernel.org" <stable@vger.kernel.org>, 
    Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: iw scan hangs in netlink ENOBUFS loop with kernel 6.6.99+
In-Reply-To: <e12fc0b9-dfd2-ecfc-de54-d5f7d4532044@lysator.liu.se>
Message-ID: <0ccdd2d2-2325-6ead-bd19-2a4f7916df02@lysator.liu.se>
References: <19b022d0-76ff-23cc-ba63-f00fedc65ed1@lysator.liu.se> <e2555ce7-0313-4fec-8bc4-739b51a009f3@leemhuis.info> <e12fc0b9-dfd2-ecfc-de54-d5f7d4532044@lysator.liu.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: ClamAV using ClamSMTP


On Wed, 22 Jul 2026, Peter Astrand wrote:
> 
> On Tue, 21 Jul 2026, Thorsten Leemhuis wrote:
> 
> > On 7/14/26 00:37, Peter Astrand wrote:
> > > 
> > > kernel 6.6.y
> > > iw 6.7
> > > libnl-genl-3-200 3.9.0
> > > mac80211_hwsim
> > > 
> > > With kernel 6.6.99 and later, "iw dev <device> scan" sometimes hangs in 
> > > busy loop:
> > 
> > Thanks for the report. We need to rule out if this is a 6.6.y specific
> > problem (like a broken or incomplete backport) or something general.
> > Could you please check if 7.2-rc is affected as well? Testing 6.18.y
> > might help, too, if it's easy for you to try. Maybe switching to that
> > might be the easies way to resolve the problem and a good idea in
> > general, as explained here:
> > http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/
> 
> Platform is NXP imx6ull. Forgot to mention that we are actually running 
> https://github.com/Freescale/linux-fslc/tree/6.6-2.2.x-imx rather than 
> upstream kernel. No changes to net/netlink though.
> 
> We cannot easily test with 7.X, but I have tested 
> https://github.com/Freescale/linux-fslc/tree/6.18-2.0.x-imx and can 
> reproduce the same problem; this is 6.18.20. strace output is similar:
> 
> recvmsg(3, {msg_namelen=12}, 0)         = -1 ENOBUFS (No buffer space available)
> recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=48, nlmsg_type=NLMSG_ERROR, nlmsg_flags=0, nlmsg_seq=2510255223, nlmsg_pid=1468011032}, {error=-ENOBUFS, msg=[{nlmsg_len=28, nlmsg_type=0x1b /* NLMSG_??? */, nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK|0x300, nlmsg_seq=2510255223, nlmsg_pid=1468011032}, "\x20\x00\x00\x00\x08\x00\x03\x00\x0d\x00\x00\x00"]}], iov_len=16384}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_PEEK|MSG_TRUNC) = 48

Claude created a patch (against 6.6.y, but applies to master as well):

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1219,7 +1219,7 @@ int netlink_attachskb(struct sock *sk, struct 
sk_buff *skb,
        nlk = nlk_sk(sk);
        rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-       if ((rmem == skb->truesize || rmem <= READ_ONCE(sk->sk_rcvbuf)) &&
+       if (rmem - skb->truesize <= READ_ONCE(sk->sk_rcvbuf) &&
            !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
                netlink_skb_set_owner_r(skb, sk);
                return 0;
@@ -1395,7 +1395,7 @@ static int netlink_broadcast_deliver(struct sock 
*sk, struct sk_buff *skb)
        rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
        rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 
-       if ((rmem == skb->truesize || rmem <= rcvbuf) &&
+       if (rmem - skb->truesize <= rcvbuf &&
            !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
                netlink_skb_set_owner_r(skb, sk);
                __netlink_sendskb(sk, skb);
@@ -2232,7 +2232,7 @@ static int netlink_dump(struct sock *sk, bool 
lock_taken)
 
        rcvbuf = READ_ONCE(sk->sk_rcvbuf);
        rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
-       if (rmem != skb->truesize && rmem >= rcvbuf) {
+       if (rmem - skb->truesize >= rcvbuf) {
                atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
                goto errout_skb;
        }


It also created this commit message:

    netlink: restore pre-add admission-control boundary
    
    Commit 55baecb9eb90 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
    moved the sk_rmem_alloc admission check in netlink_attachskb(),
    netlink_broadcast_deliver() and netlink_dump() from "queue was already
    under budget before this skb" (checked BEFORE adding truesize) to
    "queue is still under budget after this skb" (checked AFTER adding
    truesize). That's a strictly stricter boundary: a message that would
    push the queue from just-under to just-over sk_rcvbuf is now rejected
    outright, where before it was admitted.
    
    For slow-draining or MSG_PEEK-based readers (e.g. iw/libnl doing
    netlink dumps), a message can hit this new, stricter ceiling every
    time it's retried, turning what used to be a transient ENOBUFS into
    a permanent one for that message size -- causing indefinite retry
    loops in userspace (iw scan hanging).
    
    Fix by keeping atomic_add_return()-based accounting (needed for the
    actual wraparound fix), but comparing against the pre-add value:
    rmem is guaranteed >= skb->truesize since it's the value just
    returned by adding truesize, so `rmem - skb->truesize` can't
    underflow and stays unsigned throughout, preserving the wraparound
    fix while restoring the original admission boundary.


The patch seems to solve my issues. However, since I don't understand this 
code well, I cannot really say if the patch is correct. 

Br,
Peter

