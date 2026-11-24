Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508984;
	b=MXUwo0mCXm26UDce5AyX/FQNmg9SPoTL3oFyNm0omAtcW6ljvd95VcLAw7HGe/ew+ql3
	 KhjdZMsmlHk8Tjlnd4Pcgrw3lVqDz5Mx3r1uUUy6qXyuAYzIQ8fC43Pidg/8ajag557N/
	 Gtl1gCJHBwizzJVgpgOZytZS5QmkTLZaW6YWvigoHLBsdiNi8vjnHICq/El9krxnl5ryA
	 lj04Cr7dyL/gTbSTQm7paTcx/hnbXwCqwnIMjBZNSx/IV3gYRsM2waoRgyimcw1joTCpW
	 /bkbRvGXV604HfoW4pTwmiZiiGVtnk9kstl7rXWrcmzU2icvzJ7XgMTIpzff61wNN8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508984;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7CedIZqW8uK1+Z6TUaHzLF+svnPdCe1eL2kyZtyrFhM=;
	b=r5VOyLPHYULUtcwyAlOgjoXWzNr9DPoxeWK9drrNQN+md4NDKqAHf3CiyGoRmoFwhJz0
	 K7AlZV34epYPr1qEKpwO2Tuyxc6CbSpiw7CRSvHf7XnV+w0y0Sd4+unKY4zB/0gM54wIL
	 j6+3zY82ZQ5kEzlUC67Hh/chjq2Hbl6Jc0I7kRbkN/0NmpF+8ociN32277j9S1z4sc821
	 KHiGs9Dez4LzBV76knKHI0FcDQnUqaHj3BSIo5EaPkJ/gkKpZjf/mzrM+ILdwINqQe/1E
	 pp1FzXqr6uaRB3+aVzO+W86MRZfmMCUMS1D+9PF7ZIdyVjG1H/JpGmllLQW2RpCIMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yv4B1IO8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84288606A31E;
	Tue, 24 Nov 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yv4B1IO8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580EF1F000C4;
	Tue, 24 Nov 2026 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508983;
	bh=7CedIZqW8uK1+Z6TUaHzLF+svnPdCe1eL2kyZtyrFhM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yv4B1IO8X+uV5oGuT//cJjpUkkEKqNgiRFkdPjU2IsqEtGzTBaGCcRdA9YlB4d0sZ
	 MJeFwEBxqS11LLlV7G80+VQKaZbmwy1JZ5vlh7q+MyeLrVZK8/xZd6G/wRlthn7a0Z
	 fbU+dRRdGQKxLa6hyBMmvanLXLRis9ECu8nXK8vhH+WEyZCHOQF1NATBNqtNKOuo+F
	 QN33vB0rDcYqzrH6H6N7O3Y2uCO5r6dU40oM2ISFaHMsS9m5nLOun0/biCFN2It3KQ
	 /YG10f3+TylA3V9xy57eH+f09QLWK8EwhXMBT13acd26oSdE3Io+nI782Bsn86SgIF
	 zulAcPUEHyJUw==
Subject:
 Re: [PATCH net] nfc: llcp: fix double put of nfc_dev on interrupted connect
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 08:29:42 +0000
Message-ID: <179550898290.3135.6710394263567960134@kernel.org>
In-Reply-To: <20261120081354.4098856-1-bsdhenrymartin@gmail.com>
References: <20261120081354.4098856-1-bsdhenrymartin@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] The patch adds an nfc_dev refcount leak.
- [High] The new early return in llcp_sock_connect() (socket on
  local->sockets, state not CONNECTED, ret = -ERESTARTSYS/-EINTR/-ENXIO)…
- [Medium] The commit message gets the failure mechanism wrong and makes
  false claims about ownership.
- [Medium] The ownership heuristic is also fooled by bind() followed by
  connect().
- [Low] The comment added in llcp_sock_connect() says the 'dev/local
  references now belong to the socket.

--

nfc: llcp: fix double put of nfc_dev on interrupted connect

This patch changes the interrupted-wait error path in llcp_sock_connect().
When the socket is found linked on local->sockets, the nfc_dev and local
references taken by connect() are no longer unwound. A new helper,
llcp_sock_on_local_sockets(), treats list membership as meaning that the
CC handler has claimed the socket.

> While the socket waits for the peer, nfc_llcp_recv_cc() can already
> have claimed it: the CC handler moves the socket from
> connecting_sockets to local->sockets and the reference now belongs to
> the socket. It is dropped exactly once, by nfc_llcp_recv_disc() or by
> llcp_sock_destruct().

[Severity: Medium]
Is this description of the failure complete? A CC frame on its own does
not seem able to make sock_wait_state() return an error.
nfc_llcp_recv_cc() sets LLCP_CONNECTED under lock_sock(). After
schedule_timeout(), the loop takes the lock again and checks the state
before it reaches signal_pending():

net/nfc/llcp_sock.c:sock_wait_state() {
	while (sk->sk_state != state) {
		...
		if (signal_pending(current)) {
			err = sock_intr_errno(timeo);
			break;
		}

		release_sock(sk);
		timeo = schedule_timeout(timeo);
		lock_sock(sk);
		...
	}
}

So the double put seems to need a CC followed by something that drops
the CONNECTED-state dev reference and takes the socket out of
LLCP_CONNECTED, such as nfc_llcp_recv_disc() or nfc_llcp_socket_release().

The "dropped exactly once" list also leaves out two functions:

nfc_llcp_socket_release() calls nfc_put_device() for CONNECTED sockets.

nfc_llcp_recv_dm() closes a claimed socket without dropping the
reference.

> Check whether the CC handler already claimed the socket - it is the
> only path that links a connecting socket into local->sockets - and
> leave the references with the socket in that case.

Is "the only path" accurate? llcp_sock_bind() also links sk into
local->sockets and sets LLCP_BOUND, and llcp_sock_connect() does not
reject LLCP_BOUND.

The commit message also doesn't explain the new "if (sk->sk_state ==
LLCP_CONNECTED) ret = 0;" branch. sock_wait_state() only returns an
error while CONNECTED if sk_err was already set. Which case is that
branch meant to handle?

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index 1e5ee4bcde684..22b2f65e984a4 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -683,6 +683,36 @@ static int llcp_sock_release(struct socket *sock)
>  	return err;
>  }
>  
> +/**
> + * llcp_sock_on_local_sockets() - check if a socket was claimed by a CC
> + * @local: the LLCP local the socket connected on
> + * @sk: the socket to look up
> + *
> + * nfc_llcp_recv_cc() moves a connecting socket to local->sockets when the
> + * peer answers with a CC frame.  Only that path links a connecting socket
> + * into local->sockets, so membership doubles as "the peer claimed the
> + * socket".  The caller must hold lock_sock().

[Severity: Medium]
Can bind() followed by connect() make this helper return true when no
CC has arrived?

llcp_sock_bind():
	nfc_llcp_sock_link(&local->sockets, sk);
	...
	sk->sk_state = LLCP_BOUND;

llcp_sock_connect() only rejects LLCP_CONNECTED and LLCP_CONNECTING, so
a bound socket goes on to:

	nfc_llcp_sock_link(&local->connecting_sockets, sk);

This links the same sk_node a second time. That hlist double link is
older than this patch. But because local->sockets still reaches sk_node,
llcp_sock_on_local_sockets() finds sk.

If a signal interrupts sock_wait_state() before any CC arrives, the new
code takes goto out. It returns -ERESTARTSYS or -EINTR with the socket
still in LLCP_CONNECTING.

The nfc_dev reference taken by connect() is then never dropped, because
llcp_sock_destruct() only puts it for LLCP_CONNECTED. connect() also
overwrote llcp_sock->local, so the local reference taken by bind() leaks.
Before this patch, the error path unwound both references taken by
connect().

> + *
> + * Return: true if @sk is linked in local->sockets.
> + */

[ ... ]

> @@ -781,9 +811,27 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
>  
>  	ret = sock_wait_state(sk, LLCP_CONNECTED,
>  			      sock_sndtimeo(sk, flags & O_NONBLOCK));
> -	if (ret && ret != -EINPROGRESS)
> +	if (ret) {
> +		if (ret == -EINPROGRESS)
> +			goto out;
> +
> +		/* If the CC frame was processed while we slept, recv_cc()
> +		 * moved the socket to local->sockets and the dev/local
> +		 * references now belong to the socket.  They are dropped by
> +		 * nfc_llcp_recv_disc() or llcp_sock_destruct(); unwinding
> +		 * them on this error path would put the nfc_dev reference
> +		 * obtained above a second time.
> +		 */

[Severity: Low]
Does this comment correctly say who releases these references?
nfc_llcp_recv_disc() only drops the dev reference, and never the local
kref:

	if (sk->sk_state == LLCP_CONNECTED) {
		nfc_put_device(local->dev);
		...

The local reference is only released through
llcp_sock_destruct()->nfc_llcp_sock_free()->nfc_llcp_local_put().
llcp_sock_destruct() drops the dev reference only when sk_state is
LLCP_CONNECTED.

nfc_llcp_socket_release() also drops the dev reference for CONNECTED
sockets, and the comment doesn't mention it.

> +		if (llcp_sock_on_local_sockets(local, sk)) {
> +			if (sk->sk_state == LLCP_CONNECTED)
> +				ret = 0;
> +			goto out;
> +		}

[Severity: High]
Does this leak the nfc_dev reference if the peer sends a CC and then a
DM?

Say rx_work handles a CC and then a DM whose reason is not
LLCP_DM_NOBOUND or LLCP_DM_REJ, before the connecting thread gets
lock_sock() back. nfc_llcp_recv_dm() takes the default branch and finds
the socket on local->sockets with nfc_llcp_sock_get(). It then does:

	sk->sk_err = ENXIO;
	sk->sk_state = LLCP_CLOSED;
	sk->sk_state_change(sk);

It doesn't call nfc_put_device(), and it leaves sk on local->sockets.

sock_wait_state() then returns -ENXIO from sock_error().
llcp_sock_on_local_sockets() returns true and the state isn't
CONNECTED, so we goto out and skip put_dev. Later, llcp_sock_destruct()
skips the put as well:

	if (sk->sk_state == LLCP_CONNECTED)
		nfc_put_device(llcp_sock->dev);

Before this patch, this sequence went to sock_unlink and the reference
was dropped once. Does the nfc_dev now stay pinned for good?

[Severity: High]
What state is the socket in when this path returns an error with
sk_state not CONNECTED?

The socket stays linked on local->sockets in LLCP_CLOSED. It still holds
llcp_sock->local, the reserved ssap and the kmemdup'd service_name.

For example, take a CC followed by a DISC with non-zero SAPs.
nfc_llcp_recv_disc() puts dev and sets LLCP_CLOSED, but leaves sk on
local->sockets. A signal then makes sock_wait_state() return
sock_intr_errno(timeo). With the default sk_sndtimeo of
MAX_SCHEDULE_TIMEOUT, that is -ERESTARTSYS.

Now suppose the syscall is restarted or userspace retries. The entry
checks in llcp_sock_connect() only reject LLCP_CONNECTED and
LLCP_CONNECTING, so the second call goes ahead. It overwrites
llcp_sock->local, dev, ssap, reserved_ssap and service_name, which leaks
the old local reference, the ssap reservation and the service_name
buffer. It then does:

	nfc_llcp_sock_link(&local->connecting_sockets, sk);

sk_add_node() calls hlist_add_head() on sk_node without any check, and
sk_node is still linked in local->sockets. Can this corrupt both
local->sockets and connecting_sockets, and lead to a use-after-free on
later list walks?

Before this patch, this error path went through sock_unlink, so a
restarted connect() started from a clean socket. A similar double link
already exists if userspace reconnects after a normal connect plus
DISC. Here, though, a remote peer and an ordinary signal create the
state, and the kernel's own syscall restart triggers the corruption.

> +
>  		goto sock_unlink;
> +	}

[Severity: High]
Can the double put still happen through nfc_llcp_socket_release()?

That function takes sockets off local->sockets with
nfc_llcp_sock_list_pop(), which only holds the list write lock, not
lock_sock():

nfc_llcp_sock_list_pop()
	write_lock(&l->lock);
	sk = sk_head(&l->head);
	if (sk) {
		sock_hold(sk);
		sk_del_node_init(sk);
	}

Then, for each socket it pops:

	if (sk->sk_state == LLCP_CONNECTED)
		nfc_put_device(llcp_sock->dev);
	...
	if (err)
		sk->sk_err = err;
	sk->sk_state = LLCP_CLOSED;

So holding lock_sock() in llcp_sock_connect() doesn't keep list
membership stable. That also contradicts "The caller must hold
lock_sock()" in the new kernel-doc.

There are two ways to get here while connect() sleeps after the CC was
handled:

rx_work: nfc_llcp_recv_disc() with dsap == 0 and ssap == 0
  nfc_dep_link_down()
    nfc_llcp_mac_is_down()
      nfc_llcp_socket_release(local, true, 0)

nfc_llcp_unregister_device()
  local_cleanup()
    nfc_llcp_socket_release(local, false, ENXIO)

Either way, the socket's dev reference is dropped and sk is no longer on
any list. In the unregister case, sock_error() returns -ENXIO and no
signal is needed. In the DISC(0,0) case, the state is CLOSED, so the
wait continues until a signal returns -ERESTARTSYS or -EINTR.

llcp_sock_on_local_sockets() then returns false, we goto sock_unlink,
and put_dev calls nfc_put_device(dev) a second time. Isn't that the same
kref underflow and nfc_dev use-after-free that the commit message
describes?

Would tracking ownership of the references explicitly work better here
than inferring it from list membership?

>  
> +out:
>  	release_sock(sk);
>  
>  	return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120081354.4098856-1-bsdhenrymartin%40gmail.com
