Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132213;
	b=h/pMiyg5XmZfBcpAOIyvCZAwTzfALihKT8WiwSY/MCqveJo5jIHaFF2EmOXK15bq6ZHS
	 eSag5DyJprxqLLFsWDdjR27G21fwxkGMOJLuHVorAESyv5SdHhbpQ5Ry/fQdiCw0tomsS
	 bxziqV9nUrzG9426dyfWGfj6zdlz5wniE4seX7cBd94RsCYRWtkklmWyrTJkwOhVkS9jc
	 o5Rj/mwB8ugtPT33wwUNEIgoj4Kl9w9ZAQSnTW4504r2kietJy7pkc6hTXD0uvCjnl1Nj
	 mZikeLdFQfS8txGPbXNhRbTWVwgucSZGGOdesWXZtPS+J6U69bgzxJoqinSthbJ76fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132213;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=o1b6XXG9QMuEtUFsFeAjrs4YtDdCD4bIxlLFk9Mv7hU=;
	b=F/MtRu12yDYrgEOd8cAQIMxRayx27tXsSgpL280vi+wI4HC8v7wNuAjpcUO71i60bTze
	 rJBjyx3cWMcmWMxMdXJRNsxhnyEbiOyKtT5VS0KOI3+YoVpVVLRLnNkwVa9mAI6qPUpTn
	 tJE7l3rfrlkErLToaprCUYebY3Q0fPxOd03P7j/7umehqKE0rlgdKLgNmZiyU2l+vGLbm
	 PWFEQABcqaN+Zftq44kXKtyoLc/G+SUoyluabUfF+otBPbi1fZlVjscJzmS7qr90IDda6
	 P5aPMna1uAyxIvYsqP9O/Owm5+SaaFH011vX4slP+mcYpWSKGHAe3LHb5JPZstRs8vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcjiQ0uk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C61606A326;
	Thu, 19 Nov 2026 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcjiQ0uk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFFD1F000CF;
	Thu, 19 Nov 2026 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795132213;
	bh=o1b6XXG9QMuEtUFsFeAjrs4YtDdCD4bIxlLFk9Mv7hU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jcjiQ0ukTo1DYmaKQHSBSGnwTZ0hRS2j5A2ym1lb/o9vwEphuvyHEvlwEOOqvTSH2
	 ucUVDjZsW5wp2dqcPDkg8Ll9E8mbYMv15HgGz5Ecpb+v53wBCXEPOIGdsfAPFrDv8n
	 YrcRIYeN+WpRa0oKeb++Albg89p5plCZdX6q42h/CpIbfENsEP5ZjN6sNbWfhGJ4L9
	 okiBJC296xaxkZVkbYPTgyIwZG5dpkIQfszV1/TXX/JWMtt3ySeqOojb/HuU0CIiJV
	 MnMu5k6EPxz/XniqWVHN95pClOE6JjYqy3Lt5WBkr/wtAeJMj4NLvDNjMypeLIg3tb
	 XXwuqqod+rCxw==
Subject: Re: [PATCH] net: initialize sk_peer_lock in cloned sockets
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: edumazet@kernel.org, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 19 Nov 2026 23:50:12 +0000
Message-ID: <179513221226.3136.10545319024086149359@kernel.org>
In-Reply-To: <20261118084927.1756747-1-bsdhenrymartin@gmail.com>
References: <20261118084927.1756747-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: on 32-bit kernels, sk_clone() still
  inherits sk->sk_stamp_seq in a held state.
- [Low] The commit message says sock_copy() clones a struct sock 'with
  two memcpys that both include sk_peer_lock'.

--

Here is the LKML reply:

net: initialize sk_peer_lock in cloned sockets

This commit adds a spin_lock_init() of sk_peer_lock in sk_clone(). Without
it, a clone made while the parent's sk_peer_lock is held starts with the
lock already locked, and the first getsockopt(SO_PEERCRED) on the child
hangs.

> sock_copy() clones a struct sock with two memcpys that both include
> sk_peer_lock.  sk_clone() re-initializes sk_lock, but nothing resets

[Severity: Low]
Is the "two memcpys that both include sk_peer_lock" part accurate? The
first copy in sock_copy() stops at sk_dontcopy_begin, which sits inside
__sk_common:

net/core/sock.c:sock_copy() {
    ...
	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));

	unsafe_memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
		      prot->obj_size - offsetof(struct sock, sk_dontcopy_end),
		      /* alloc is larger than struct, see sk_prot_alloc() */);
    ...
}

sk_peer_lock is a field in the struct sock body, well after __sk_common.
So only the second unsafe_memcpy() copies it.

The conclusion that the lock is copied verbatim still holds. Could the
commit message describe the mechanism more precisely?

> diff --git a/net/core/sock.c b/net/core/sock.c
> index ad414878dc5ba..b5e2a2a7741cd 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2545,6 +2545,10 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
>  
>  	sk_node_init(&newsk->sk_node);
>  	sock_lock_init(newsk);
> +	/* sock_copy() copies the parent's sk_peer_lock verbatim, including a
> +	 * held state, so the clone must start with a fresh lock.
> +	 */
> +	spin_lock_init(&newsk->sk_peer_lock);

[Severity: High]
Does the same problem remain for sk_stamp_seq on 32-bit kernels?

sk_stamp_seq is a seqlock_t (a spinlock plus a seqcount) declared under
BITS_PER_LONG==32 in struct sock:

include/net/sock.h:
#if BITS_PER_LONG==32
	seqlock_t		sk_stamp_seq;
#endif

It lies outside the sk_dontcopy range, so sock_copy() copies it along with
sk_peer_lock. It is only initialized by seqlock_init() in
sock_init_data_uid(), which the clone path never runs. Neither sk_clone()
nor sk_init_common() resets it.

The writer takes the spinlock and leaves the sequence count odd:

include/net/sock.h:sock_write_timestamp() {
	write_seqlock(&sk->sk_stamp_seq);
	sk->sk_stamp = kt;
	write_sequnlock(&sk->sk_stamp_seq);
}

sock_gettstamp() (ioctl SIOCGSTAMP) calls that writer without lock_sock
whenever sk_stamp is 0:

net/core/sock.c:sock_gettstamp() {
    ...
	if (ts.tv_sec == 0) {
		ktime_t kt = ktime_get_real();
		sock_write_timestamp(sk, kt);
    ...
}

On an SCTP one-to-many socket, sk_stamp becomes 0 after the first
sctp_recvmsg()->sock_recv_cmsgs(). With that state, can the following
happen?

CPU0
ioctl(SIOCGSTAMP)
  sock_gettstamp()
    sock_write_timestamp()
      write_seqlock(&parent->sk_stamp_seq)

CPU1
getsockopt(SCTP_SOCKOPT_PEELOFF)
  sctp_getsockopt()            /* lock_sock() held */
    sctp_do_peeloff()
      sctp_clone_sock()
        sk_clone()
          sock_copy()

The lock_sock() taken on CPU1 does not exclude CPU0's lockless write. The
child would then get a locked spinlock and an odd seqcount.

After that, sock_read_timestamp() on the child would spin forever in
read_seqbegin(). That covers SIOCGSTAMP, and recvmsg via
sock_recv_cmsgs(). On PREEMPT_RT it would block on the copied held lock
instead.

Any sock_write_timestamp() on the child would spin forever in spin_lock()
with preemption disabled. That is the same RCU-stall hang the commit
message describes for sk_peer_lock.

Two threads of an unprivileged user could trigger this. Would it make
sense to also add a seqlock_init(&newsk->sk_stamp_seq) under
BITS_PER_LONG==32 next to the new spin_lock_init()? Another option is to
move all lock re-initialization for clones into one helper.

>  
>  	if (lock)
>  		bh_lock_sock(newsk);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118084927.1756747-1-bsdhenrymartin%40gmail.com
