Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220071;
	b=5XoAPzT6DYrEr+/axImJhmFPbJlrruaK/Lk9WuOFKjVXqCVJa0DaIzBcup9rbWrsRF09
	 p8+ujAp4EC+CUk1fYV9/2qU7O4VeG2ABpkVvS4bWCoaQqIif9236T7P4zCiWdIGbuCVLp
	 FJOw33JqFWWLamRz8Nr/1E0DFdKKnjzZyJ2lKJIGJsMukuqfQzOZvDVVBrbIQTB1CbM5k
	 OBCv9Rhe7Kzr0AAmKDh5/VPYm+2xs/4Ov5m9PCws2j3x6IXz4U6vTmRz0h3PR5kx+M2tT
	 5MJNmam0zIl9DnZUnnuv/7kUy+A77zh/Lk6DhAJoy2lBgoVVJoYj6Jm1LH1on00aCtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QQbnberAPvhpqCGxCiSNoM/4Q0uvQCUHKyLHQU+7Pq4=;
	b=NlDcOIw/+frG92SXey6fviek8yKaVyWIG/ty+ICv7+YsP7X8Y0ZbLdp23sTz1APyjWDc
	 HaLYjQFngQixCxRAgCFBYUa9EOf+VyXGc065NxZi/pYuGl+eN6DNud6dfiwsxoZxBdLvb
	 Gx+jZwh1mseMFR29H54ZsmGpGkeSTw46nBbWPLVP2lY3Clii4hfWx/rD8RAK6WyxkBZjl
	 0lhc5fjpHpjybRuViOVpAMD1CSrqiCAFHfmXtM6bPgWSxJYlsfNwenAH9cRwzh+5J85hL
	 VUaz+Sp/bVk1CUoe9ZLipkUpLVs+m/I2vsWB4Uoxqwiu0l5Pdthrpl2b06PV+TjNTLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k71fndNz;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D3606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76D3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k71fndNz
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea381ce04fso951315ad.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793220070; x=1793824870; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQbnberAPvhpqCGxCiSNoM/4Q0uvQCUHKyLHQU+7Pq4=;
        b=k71fndNzImv15347i3hHJi/2OkPcsYc9oFYlTg8lZAZCJQ8BWnwbVFniv68Ajk2r/4
         kRZp6dst/PKTGzkkq+gbUk+5FzcJUrT0VB/Zo3b5AD/dpbHWRk/5IxJnyOMG176l59sD
         4IPHHmH5kR/F2LyCWEG9tDLDsHfgzQKGQa9ITHZWtGketwh9th8ECLwisaDFyv75FwgD
         1QU1zgiSgh+XAScIlIe8CdX9DVJN1B2pGB0z76rGazNYa22h4hJExYluhurhcypBWiu0
         uxYpZ7bOGUF12z0bEJ0I/6nxXQtMkLDIZ5L4tcrQ+z6Hzgsc5qkX/6fVflzs1v+/ucEe
         yH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220070; x=1793824870;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQbnberAPvhpqCGxCiSNoM/4Q0uvQCUHKyLHQU+7Pq4=;
        b=0Mp+caOk1ycu1OnikUwU8ohax2xcHNOWu0c1bu3mjOt51XPjP2NZaF/HsHsYF03ovW
         q0LAuHyBTJFq1Chr46L9AyO1LX0wfAvahXV9hd9QiUg0QcP6ANeUsKNYDjHKkXpw9CUd
         klH0+pW5Mg+xfNfBX5NZFEylCAXRRQrpbu70ZgmfRn7s4kzqd9SmFQgS7NojoO7EYC37
         O9ktK4MK9ARGTtFDy7Dd9erylNM7/szqEh7hYlexEWoWF9jzmV1ksWSEhqGHIB+qEXZk
         Rj5y3FayF3zHM+FKoGZ/BVzpeZAPRshTb83qSg7fUQ2ZJiO3wupYW10/1x8YdASuMXtL
         fNUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlVnREAQp4KhD4hPFYjWE6eJ8gdZAN07V7eWoOTMxtsRA+LUJb2WKBwo4vghYpIYW9sVn3hR0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJC1+RoW/lCx/9bHhkY66ty9OGJaPq1/CRZiLSdUYzspb32cC1u
	590RWicm3DnARCyIra2UxFovDQ5Pk984bcmONbkF1Rd7j04OUZGrI+30bf64RiDiVHUvWHvHV4r
	yjIIKbw==
X-Received: from plri15.prod.google.com ([2002:a17:903:32cf:b0:2e8:44b9:5c18])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4e:b0:2ea:1b5d:9efc
 with SMTP id d9443c01a7336-2eb1ac94a4cmr3362155ad.34.1793220069849; Wed, 28
 Oct 2026 13:41:09 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:41:09 +0000
In-Reply-To: <20261028173533.2658096-2-rjethwani@purestorage.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028173533.2658096-1-rjethwani@purestorage.com> <20261028173533.2658096-2-rjethwani@purestorage.com>
Message-ID: <auJcgy0IIfavE37T@google.com>
Subject: Re: [PATCH net v3 1/2] kcm: reject attaching sockets with a ULP, and
 TLS on KCM sockets
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Shuah Khan <shuah@kernel.org>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 11:35:32 -0600, Rishikesh Jethwani wrote:
> KCM and kTLS RX do not work together, in either order.
> 
> KCM's psock_data_ready() is the lower socket's data_ready callback. It
> can run in softirq context under read_lock_bh(&sk->sk_callback_lock),
> and calls strp_data_ready(), which invokes sock->ops->read_sock()
> inline. With kTLS RX, that is tls_sw_read_sock(), which can sleep: it
> allocates with sk->sk_allocation, waits for async crypto, flushes the
> socket backlog, and may wait in tls_rx_reader_acquire().
> 
> Found by code review. On an unmodified kernel with
> CONFIG_DEBUG_ATOMIC_SLEEP, sending TLS records over loopback to a socket
> with software kTLS RX attached to a KCM mux reports:
> 
>   BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 189, name: ksoftirqd/34
>   Call Trace:
>    __might_resched
>    kmem_cache_alloc_node_noprof
>    __alloc_skb
>    alloc_skb_with_frags
>    tls_rx_one_record
>    tls_sw_read_sock
>    strp_read_sock
>    strp_data_ready
>    psock_data_ready [kcm]
> 
> Before commit 662fbcec32f4 ("net/tls: implement ->read_sock()"), TLS
> inherited tcp_read_sock(), so KCM parsed the ciphertext in the TCP
> receive queue as messages. HW TLS RX uses the same proto_ops as SW
> RX, so it is affected the same way.
> 
> The two also stack socket callbacks and neither restores the other's:
> with TLS RX configured after the attach, kcm_unattach() overwrites
> tls_data_ready(), and releasing TLS RX later reinstalls
> psock_data_ready() on a socket no longer attached to KCM. On TX,
> kcm_unattach() restores its saved sk_write_space, dropping
> tls_write_space().
> 
> There is no known user of this combination, so reject it, as was done
> for sockmap in commit 460e6486617c ("tls: reject the combination of TLS
> and sockmap"):
> 
>  - kcm_attach() refuses sockets that already have any ULP, not only
>    TLS, as sk_psock_init() does for sockmap, with -EOPNOTSUPP like its
>    other refusals;
>  - tls_init() refuses sockets attached to KCM with -EINVAL, like
>    __tcp_set_ulp() and the sockmap check, tracked by a new SOCK_KCM
>    flag set on attach and cleared on unattach.
> 
> sk_user_data cannot serve as the marker: sunrpc and nvme-tcp set it on
> sockets that tlshd later upgrades to TLS, so it is already set when
> tls_init() runs. Unlike sockmap, both sides run under the lower
> socket's lock (tcp_set_ulp() asserts this), so the check is made at ULP
> install rather than at key configuration.
> 
> This is a user-visible change that will also reach stable kernels:
> attaching a socket with a ULP now fails with -EOPNOTSUPP, and installing
> TLS on an attached socket fails with -EINVAL. Every refused setup was
> already broken as described above, except one where only kTLS TX is
> configured. Such a socket still passes data, because read_sock() stays
> tcp_read_sock() until kTLS RX is configured, and KCM transmits with
> sock_sendmsg(), so records reach tls_sw_sendmsg(). It is still wrong: if
> TLS was armed before the attach, psock_write_space() shadows
> tls_write_space() and does not chain to it, so a record deferred on a
> full send buffer waits for the next send; if TLS was armed after the
> attach, the chain works until kcm_unattach() drops tls_write_space(), as
> above. The direction is not known at ULP install, so refusing it keeps
> one rule for both orders and matches sk_psock_init().
> 
> Tested with CONFIG_DEBUG_ATOMIC_SLEEP: both orders are now rejected,
> plain KCM still delivers messages, and the TLS ULP can be installed
> after SIOCKCMUNATTACH.
> 
> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
> Cc: stable@vger.kernel.org
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  include/net/sock.h |  1 +
>  net/kcm/kcmsock.c  | 12 ++++++++++++
>  net/tls/tls_main.c |  6 ++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 173b37b2b8bb..e579a4a96c8e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1024,6 +1024,7 @@ enum sock_flags {
>  	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>  	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
>  	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
> +	SOCK_KCM, /* Attached to a KCM mux as a lower socket */

I guess this does not compile for 32-bit ?


>  };
>  
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index a7f94d42036f..546d5b563382 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/uio.h>
>  
> +#include <net/inet_connection_sock.h>
>  #include <net/kcm.h>
>  #include <net/netns/generic.h>
>  #include <net/sock.h>
> @@ -1272,6 +1273,15 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
>  		goto out;
>  	}
>  
> +	/* KCM and ULPs are mutually exclusive. A ULP such as kTLS replaces
> +	 * read_sock() and stacks its own socket callbacks with ours. tls_init()
> +	 * rejects sockets already attached to KCM, see SOCK_KCM.
> +	 */
> +	if (inet_csk_has_ulp(csk)) {
> +		err = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
>  	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
>  	if (!psock) {
>  		err = -ENOMEM;
> @@ -1305,6 +1315,7 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
>  	psock->save_write_space = csk->sk_write_space;
>  	psock->save_state_change = csk->sk_state_change;
>  	csk->sk_user_data = psock;
> +	sock_set_flag(csk, SOCK_KCM);
>  	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
>  	WRITE_ONCE(csk->sk_write_space, psock_write_space);
>  	csk->sk_state_change = psock_state_change;
> @@ -1382,6 +1393,7 @@ static void kcm_unattach(struct kcm_psock *psock)
>  	 */
>  	write_lock_bh(&csk->sk_callback_lock);
>  	csk->sk_user_data = NULL;
> +	sock_reset_flag(csk, SOCK_KCM);
>  	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
>  	WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
>  	csk->sk_state_change = psock->save_state_change;
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index b8d5a843f761..e45062841950 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -1067,6 +1067,12 @@ static int tls_init(struct sock *sk)
>  	if (sk->sk_state != TCP_ESTABLISHED)
>  		return -ENOTCONN;
>  
> +	/* TLS and KCM are mutually exclusive. kcm_attach() rejects sockets
> +	 * with a ULP; both run under the socket lock, so this cannot race.
> +	 */
> +	if (sock_flag(sk, SOCK_KCM))
> +		return -EINVAL;
> +
>  	/* allocate tls context */
>  	write_lock_bh(&sk->sk_callback_lock);

Perhaps move sk_psock() check in do_tls_setsockopt_conf() here.



>  	ctx = tls_ctx_create(sk);
> -- 
> 2.50.1
> 
