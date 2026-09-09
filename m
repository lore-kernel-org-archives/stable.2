Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6B55C1AC;
	Wed,  9 Sep 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958761; cv=none; b=pnWsgDsrCHNFObZVdko++We5aPawor0kKnwbjh6yFWhOaSaO8SUNeWmhlQxczNS8CxptsdwfUc/qzP2+1r25Be8ws1/zVQSYot5uDJ+oddpNihd04NBx1Yz2FkYTAchm4YoAAvT6sqlYBrauwPlk4um0gtRYMysQYcdzsWn1Kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958761; c=relaxed/simple;
	bh=1FjpME9nqPv2jh1pfO7XrUbw2ySnLrpuNV6qg4RbEAM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m9OR/fWfbEji76c1DUnC6B+43JGKS2KVH4dFSOufrXsTC8hZSr24KMNEkFzxXagSYKoijvgEQePp7736RAHWl/V6FAKgbEgPwqStOFnQA8tfOnEPsGCQmnGcI5EAZ1nEfGYMOhKEdF2r5kpoVEbalWBHNlPD+MBv4QU77mAbM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvSpfOyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvSpfOyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A41F00A3A;
	Wed,  9 Sep 2026 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788958758;
	bh=mVIT4/S/hBxlRSbceZNZx3VhxRueTx3pYksgzqtiV3M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mvSpfOykZqsotkHI27EIOnByR7ggnAgICrGw1X/nTuPsWw1sxr5yJaBrdLrIxOMdU
	 pK/UmFPKk0pt/EgV/wy+MYYt0/yxrWIqWjSALfABDnvV9UKN/WexVyhBL7rR3nkcsl
	 s69bXtG7iqiDZqwfSXnANQFn/ACH6O6fDiRhyhmLbl+Fp6fe6AIKHmxxkihq7HC9CR
	 ss9fSYXUY06rimGc61cuC/6M4V8kt+80EHQCG+WnWYwb7/d5HxH/AFx8AYhapC7kIV
	 CFJO2DSLU8WC77NGbDShRNyia9tw8+XB78TcbnfDrA9bGrIsIGg19gG07xiaNg2/15
	 aVHZs51W/tT7w==
Subject:
 Re: [PATCH net] net/tcp-ao: transfer tcp_ao_info to the TIME_WAIT socket
From: netdev-bot+sashiko@kernel.org
To: xmei5@asu.edu
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
 noureddine@arista.com, fruggeri@arista.com, dsahern@kernel.org,
 co+2c72469dbbec34af@bugs.sh, stable@vger.kernel.org
Date: Wed, 09 Sep 2026 12:59:17 +0000
Message-ID: <178895875743.219967.5657866655676380504@kernel.org>
In-Reply-To: <20260904005851.149071-1-xmei5@asu.edu>
References: <20260904005851.149071-1-xmei5@asu.edu>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] tcp_ao_time_wait() (net/ipv4/tcp_ao.c:431) now unconditionally
  clears tp->ao_info, but two of the three callers of tcp_time_wait()…

--

net/tcp-ao: transfer tcp_ao_info to the TIME_WAIT socket

tcp_ao_time_wait() used to hand the TIME_WAIT socket a second reference to
the full socket's tcp_ao_info while leaving tp->ao_info pointing at the same
object. This patch turns that into a handover by clearing tp->ao_info so the
TIME_WAIT socket becomes the sole owner.

Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA57%40bugs.sh/

> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bb7bbc20ba3fa..27525f90398b3 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -428,7 +428,7 @@ void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
>  			omem += tcp_ao_sizeof_key(key);
>  		}
>  
> -		refcount_inc(&ao_info->refcnt);
> +		rcu_assign_pointer(tp->ao_info, NULL);

[Severity: High]

Is the clear here safe on the paths where the full socket survives?  The
commit message says this transition happens when "the full socket is going
away", but tcp_ao_time_wait() is reached from tcp_time_wait() which ends in
tcp_done(), and tcp_done() only destroys the socket when SOCK_DEAD is set:

net/ipv4/tcp.c:tcp_done() {
	...
	if (!sock_flag(sk, SOCK_DEAD))
		sk->sk_state_change(sk);
	else
		inet_csk_destroy_sock(sk);
}

The same FIN_WAIT2 path the changelog describes is one such caller:

net/ipv4/tcp_input.c:tcp_fin() {
	...
	case TCP_FIN_WAIT2:
		/* Received a FIN -- send ACK and enter TIME_WAIT. */
		tcp_send_ack(sk);
		tcp_time_wait(sk, TCP_TIME_WAIT, 0);
}

So after shutdown(fd, SHUT_WR) with the fd still open, the peer's FIN drives
tcp_fin() -> tcp_time_wait() -> tcp_ao_time_wait(), and the full socket is
left alive in TCP_CLOSE with tp->ao_info NULL.

Does that drop the whole AO association from a socket the application can
still use?  ao_info holds all the MKTs plus current_key, rnext_key and
ao_required, and nothing appears to rebuild it: tcp_disconnect() never
touches ao_info, and tcp_ao_connect_init() bails out immediately:

net/ipv4/tcp_ao.c:tcp_ao_connect_init() {
	ao_info = rcu_dereference_protected(tp->ao_info,
					    lockdep_sock_is_held(sk));
	if (!ao_info)
		return;
	...
}

Can a subsequent connect() on that fd then establish an unauthenticated
connection with no error?  The guard in tcp_connect() is keyed off
tp->ao_info, so it becomes a no-op once ao_info is NULL:

net/ipv4/tcp_output.c:tcp_connect() {
	...
	if (unlikely(rcu_dereference_protected(tp->ao_info, ...))) {
		/* Don't allow connecting if ao is configured but no
		 * matching key is found.
		 */
		if (!tp->af_specific->ao_lookup(sk, sk, -1, -1))
			return -EKEYREJECTED;
	...
}

The md5/ao arbitration and ao_required enforcement just above it in
tcp_connect() are keyed off the same pointer.

Similarly, if the application calls listen() on the surviving fd, does
tcp_ao_required() now report that no authentication is needed?

include/net/tcp.h:tcp_ao_required() {
	ao_info = rcu_dereference_check(tcp_sk(sk)->ao_info, ...);
	if (!ao_info)
		return false;
	...
}

Since the transition is driven by the peer's FIN, the remote side chooses
when the local socket's AO configuration is discarded, and no privilege is
needed on the local side.

Would copying the state into the twsk work better here, matching what the
MD5 sibling does in the same transition?

net/ipv4/tcp_minisocks.c:tcp_time_wait_init() {
	...
		tcptw->tw_md5_key = kmemdup(key, sizeof(*key), GFP_ATOMIC);
	...
}

That keeps the surviving full socket authenticated.  Alternatively, clearing
tp->ao_info only when the socket is really being destroyed, or adding
explicit AO teardown in tcp_disconnect(), would avoid the AO-less-but-usable
socket.

One more note on the changelog: it states that such a socket "no longer
exposes TCP-AO state (TCP_AO_INFO and TCP_AO_DEL_KEY return -ENOENT)".
TCP_AO_GET_KEYS and TCP_AO_REPAIR also start returning -ENOENT, and the loss
of the key material and ao_required on a still-usable socket isn't mentioned
at all.  Could the changelog spell out that consequence?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904005851.149071-1-xmei5%40asu.edu
