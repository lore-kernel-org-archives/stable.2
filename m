Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE642F6FD;
	Thu, 27 Aug 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857648; cv=none; b=jV3+RuCF2R56ikeriJ+cSQE7IXipG24xvD9uCvkWi5CDFAEmK/p1WmhF09ill8Q4wS0QqsMAcKXEJHzHLkbgfEObTOnPkzFsHWEBi7Hc5wZE16GOKQtUa0dDr2b+tNWUKi87b+66lOkaVjrb/7qoG4C501ZWW+6oQlmkglUL9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857648; c=relaxed/simple;
	bh=4zQC3RCsVkik0nrzHZowL/Y2NRiyYBRvx/bXuzpHwO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQdrJ4JIGkWAETILXx7pf++iE5uZf9edf1ceb0drYzKF9UKlnkJDLlE8NfkW+28KWx2alAHycXtVdU3r9dxlamaqKEwoDppgB5qB9ca8Dz1SJgkLYqAL2Vcnj66uJFiQVnT4uLR8id6xY79D1S6sCXzwC02rT1JB2R+v+z6v7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObP2yu0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObP2yu0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1571F000E9;
	Thu, 27 Aug 2026 19:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857644;
	bh=YenKyROYLA1WRyeqWJrJ6lISlFqtwdtQeUWmXd0rWQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ObP2yu0Jzx8Xtz6WDCyETkDPf4gMyb6FUNpbR51L6xZFkdLSNd+/TtJ5it9Z8s4+a
	 YQZ0udh6BiiemGK54r4PP4eWv/o82KGsnc1EIN5w4Slvwjnop0qlh7hCDvoNcen4mT
	 cY8kslreywIbixlhfa+IKYCqPPDllEv39p5sl/vfDF5/hwwFnMWBfcKoCInZ5XDALp
	 QfiM7mA7Qq4qL+oNn9xIjey7NMNjbENOj2YkunUELgxx92ufcV3YeYCKuQAN9eyynL
	 jfJKsWtus1XrRmh1WZMQ7yVLNDQBSz3CL3r8SSfGEVNCjt6GBj61pQRwmU4tPCd/z4
	 KwBnJXTTgt4Vw==
From: Jakub Kicinski <kuba@kernel.org>
To: matttbe@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 01/14] mptcp: do not reschedule the RTX timer for fallback sockets
Date: Thu, 27 Aug 2026 12:07:23 -0700
Message-ID: <20260827190723.3998185-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-1-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-1-a92309d121ca@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
mptcp: do not reschedule the RTX timer for fallback sockets

This replaces the TCP_CLOSE state test in mptcp_reset_rtx_timer() with a
new MPTCP_RTX_DISABLED bit in msk->flags, set both on fallback in
__mptcp_try_fallback() and on the transition to TCP_CLOSE in
mptcp_set_state().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b474d03620a75..23dde0b7144bb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1084,13 +1085,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
>  
>  static void mptcp_reset_rtx_timer(struct sock *sk)
>  {
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  	unsigned long tout;
>  
> -	/* prevent rescheduling on close */
> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
> +	/* Prevent rescheduling on close and in case of fallback. */
> +	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
>  		return;

[Severity: Medium]
The new test depends on a flag that mptcp_disconnect() clears while the
socket is still in TCP_CLOSE, and after mptcp_stop_rtx_timer() already ran.
The order inside mptcp_disconnect() is:

	mptcp_set_state(sk, TCP_CLOSE);    /* sets MPTCP_RTX_DISABLED */
	...
	mptcp_stop_rtx_timer(sk);          /* non-sync, timer_ival = 0 */
	...
	WRITE_ONCE(msk->flags, 0);         /* clears MPTCP_RTX_DISABLED */
	msk->cb_flags = 0;

Can the rtx timer be armed again after that point?

mptcp_stop_rtx_timer() uses sk_stop_timer() and therefore the non-sync
timer_delete(), so an already-expired mptcp_retransmit_timer() can still be
running on another CPU. It only takes bh_lock_sock(), and its
__set_bit(MPTCP_RETRANSMIT, &msk->cb_flags) can land after the plain
msk->cb_flags = 0 store above.

On the release_sock() that follows, mptcp_release_cb() calls
__mptcp_retrans(sk) with no sk_state check, and that reaches
__mptcp_clean_una():

out:
	if (snd_una == msk->snd_nxt && snd_una == msk->write_seq) {
		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
			mptcp_stop_rtx_timer(sk);
	} else {
		mptcp_reset_rtx_timer(sk);
	}

mptcp_disconnect() does not reset snd_una/snd_nxt/write_seq, so for a socket
disconnected with unacked data the else branch runs and arms the timer with
timer_ival == 0 on a TCP_CLOSE socket whose timers were deliberately
stopped. The previous inet_sk_state_load(sk) == TCP_CLOSE test returned
early here.

When that immediately-expiring timer fires, mptcp_retransmit_timer() does
test_and_set_bit(MPTCP_WORK_RTX, &msk->flags) and then calls
mptcp_schedule_work(), which refuses to queue the worker for a closed
socket without clearing the bit:

	if (inet_sk_state_load(sk) == TCP_CLOSE)
		return false;

If the application then reuses the socket with a new connect(), does that
leftover MPTCP_WORK_RTX bit keep mptcp_worker() from being scheduled on
subsequent rtx expiries, until some other mptcp_schedule_work() caller lets
the worker clear it?

>  
> -	tout = mptcp_sk(sk)->timer_ival;
> +	tout = msk->timer_ival;
>  	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
>  }
>  
> @@ -3324,6 +3326,9 @@ void mptcp_set_state(struct sock *sk, int state)
>  		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>  		 */
>  		break;
> +	case TCP_CLOSE:
> +		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
> +		fallthrough;

[Severity: High]
This latches the bit on every transition to TCP_CLOSE, and there is no
clear_bit(MPTCP_RTX_DISABLED) anywhere in the tree. The only site that
resets the word is mptcp_disconnect():

	WRITE_ONCE(msk->flags, 0);

Can this leave the bit set on a socket that afterwards carries a normal,
non-fallback MPTCP connection?

First path, a failed connect() followed by a retry on the same fd. The
error path of mptcp_connect() does:

	if (unlikely(err)) {
		/* avoid leaving a dangling token in an unconnected socket */
		mptcp_token_destroy(msk);
		mptcp_set_state(sk, TCP_CLOSE);
		return err;
	}

For a negative return from sk->sk_prot->connect(), __inet_stream_connect()
takes:

		err = sk->sk_prot->connect(sk, uaddr, addr_len);
		if (err < 0)
			goto out;

so it never reaches the sock_error: label that calls ->disconnect(), and
mptcp_disconnect() does not run. The socket stays SS_UNCONNECTED with
sk_state TCP_CLOSE, which is exactly what __inet_stream_connect() requires
to accept a second connect(), and __mptcp_nmpc_sk() also permits
TCPF_CLOSE. The later mptcp_set_state(sk, TCP_SYN_SENT) and
mptcp_set_state(sk, TCP_ESTABLISHED) do not clear the bit.

Second path, a failed listen() and inheritance by accepted sockets.
mptcp_listen() unconditionally does:

	err = __inet_listen_sk(ssk, backlog);
	release_sock(ssk);
	mptcp_set_state(sk, inet_sk_state_load(ssk));

which is TCP_CLOSE on failure, so the bit is latched on the listener; a
later successful listen() only sets TCP_LISTEN. mptcp_sk_clone_init() then
creates accepted sockets with sk_clone_lock(), which copies the whole
struct mptcp_sock, msk->flags included, and __mptcp_init_sock() re-inits
the lists, timers and allow_* fields but not msk->flags.

With the bit stuck, mptcp_reset_rtx_timer() is a permanent no-op.
MPTCP_WORK_RTX and MPTCP_RETRANSMIT are set only by
mptcp_retransmit_timer(), so does that mean __mptcp_retrans() can never run
for such a socket, leaving data reinjected into msk->rtx_queue when a
subflow stalls or dies unretransmitted, and DATA_FIN retransmission
disabled, while the write side keeps its sndbuf pinned?

The previous guard read the live socket state, so it stopped applying on the
next state transition. Would clearing the bit in __mptcp_init_sock(), and on
the connect()/listen() retry paths, restore that property?

>  	default:
>  		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
>  			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);

[ ... ]
