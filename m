Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652997;
	b=wp6FOqHQKVEMKu29nzD+DrpKFCBoBFRdDi960ovw+CnFrQc3HezKd6D/d0jGVKpbRN72
	 PGZ1ws/7K8nh8vD6hWMKQmd/EdZsBrKxNSDNGJozr+gBB5uNKAP2HWgrd8rSljahrqEBG
	 AbpjvOQcsyG2wjQWgfPLG105WFm6FtZM4b5voUIV/akT5s/e8Fmarl18ir6MOYBuyr7uc
	 Mx6fh3XSpg/sufjM+zzMMA7RIWdFqhySapof4oFJagtsDbYt+WrNcpmpltv8PY5w/EwpR
	 q87/WIwgnn7l273+kRicId3VYoDJ04qYAscMYcSjvEKHEbe+qZ5Gjn0eNaV5k43rnHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652997;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=U7PL/ELynblTPSN7E0maqje4+B8IuleoH96ZSCfJFP0=;
	b=EOPUiswpnJwlci7yZw49ciR1hEpmlPk/xHL6NecT4EWTBf8CFXBCs7WT/vFvHyIXwPXJ
	 EocetB2YBQ+5AwrZ45qsBY7UjoFwySMaLmc/QijjyDydU/F/jdr4umEA7g52vPryFE/rm
	 7mcKKHPf2HttcZ9qOi9iGIyBAKOfKE9T0SCKB3fl/ltZvIQG6jrkbHZqhQt4wkdmpWMoB
	 M+z1TuixATuE3JRE/pAOWt6vC1it8cP61JfMTzmZ/MqEiAd6soxk8rjE7ZKagnjkz05qr
	 Xmzse8C2Qc5WtVZNS4QploCC3n7OYGz2A3RsRYhfRsgl1gZgEN8nR/vlTLa2xrCs8ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkTRsJcW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB072606A32E;
	Mon,  2 Nov 2026 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkTRsJcW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47051F00A16;
	Mon,  2 Nov 2026 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652996;
	bh=U7PL/ELynblTPSN7E0maqje4+B8IuleoH96ZSCfJFP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OkTRsJcWAPItMCde2Az5q5SqR8JIH+oRIbWXxJqFWjQIz1G5ymjliItl5VE3Ly+3C
	 mc+YBWallvM03rNSguO1ZrL6ZKAbyTLeAI42QWCSogJwDdMadQZ8A1sXnwzVSQSXA2
	 V3QDSg1oSuYaI8sPCYPUcotefVWaK7wICJ5CsMa2XuPNKBIgrEf6fBESr2d5iddozP
	 52BFNRr/IPDcZpN+DoZUb3EP+UiM3wyBTm+Sfch4T30IePqrnaVlMF1w1UeddoJVZz
	 dWx35D7SDv8+7ms7CEdhjTVZWSDXKcre4wV+DVpPOigh6I2mt06nBO1e4cwyn5isBy
	 UT0QcGd5LelPA==
Subject: Re: [PATCH net v4] kcm: reject attaching sockets with a ULP, and TLS
 on KCM sockets
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hare@suse.de, sagi@grimberg.me,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 20:56:35 +0000
Message-ID: <179365299523.3131.8216141407474781893@kernel.org>
In-Reply-To: <20261029203428.3057054-1-rjethwani@purestorage.com>
References: <20261029203428.3057054-1-rjethwani@purestorage.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Type confusion and slab out-of-bounds write in
  kcm_attach()/kcm_unattach() with a raw socket created by…
- [High] Check-then-use race in do_tcp_getsockopt(TCP_ULP), newly
  reachable because kcm_unattach() clears icsk_ulp_ops on a live socket…
- [Medium] Module-lifetime race on kcm_ulp_ops.

--

kcm: reject attaching sockets with a ULP, and TLS on KCM sockets

This patch makes kcm_attach() refuse lower sockets that already have a
ULP. It then installs a dummy, unregistered "kcm" tcp_ulp_ops in
icsk_ulp_ops so that tcp_set_ulp() refuses kTLS, or any other ULP, on an
attached socket. kcm_unattach() clears icsk_ulp_ops again.

Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/

> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index a7f94d42036fb..e0d6536306f42 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -30,11 +30,19 @@

[ ... ]

>  unsigned int kcm_net_id;
>  
> +/* Not registered, so TCP_ULP can't select it. It only holds
> + * icsk_ulp_ops so tcp_set_ulp() refuses other ULPs like kTLS.
> + */
> +static const struct tcp_ulp_ops kcm_ulp_ops = {
> +	.name = "kcm",
> +};

[Severity: Medium]
What keeps kcm_ulp_ops alive for readers that access icsk_ulp_ops without
a lock?

For registered ULPs, __tcp_ulp_find_autoload() pins the owning module.
That reference is held until tcp_cleanup_ulp() runs at socket destroy, so
a reader that holds only a socket reference can safely dereference the
ops.

Here the ops are static data in the kcm module. There is no .owner and no
module reference is taken. The pointer is also cleared at unattach time,
not at destroy.

Readers such as tcp_diag_get_aux() and do_tcp_getsockopt(TCP_ULP) load
the pointer without RCU or the socket lock:

net/ipv4/tcp_diag.c:tcp_diag_get_aux() {
    ...
	ulp_ops = icsk->icsk_ulp_ops;
	if (ulp_ops) {
		err = tcp_diag_put_ulp(skb, sk, ulp_ops, net_admin);
    ...
}

Could this sequence read freed module memory?

reader                                  other task
loads &kcm_ulp_ops
                                        kcm_unattach()
                                        closes all KCM sockets
                                        rmmod kcm
dereferences ulp_ops->name / ->get_info

The getsockopt path can also sleep in copy_to_sockptr() while it is
copying from ->name. The synchronize_rcu() in free_module() would not
cover that window.

> @@ -1272,6 +1280,14 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
>  		goto out;
>  	}
>  
> +	/* KCM takes over read_sock() and the socket callbacks like a ULP
> +	 * does, the two can't stack.
> +	 */
> +	if (inet_csk_has_ulp(csk)) {
> +		err = -EOPNOTSUPP;
> +		goto out;
> +	}
> +

[ ... ]

> @@ -1305,6 +1321,7 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
>  	psock->save_write_space = csk->sk_write_space;
>  	psock->save_state_change = csk->sk_state_change;
>  	csk->sk_user_data = psock;
> +	inet_csk(csk)->icsk_ulp_ops = &kcm_ulp_ops;

[Severity: Critical]
Is csk guaranteed to be an inet_connection_sock at this point?

The existing checks at the top of kcm_attach() only look at the family,
the protocol and the state:

	if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
	    csk->sk_protocol != IPPROTO_TCP) {

A socket created with socket(AF_INET, SOCK_RAW, IPPROTO_TCP) passes this
check. inet_create() keeps sk_protocol = IPPROTO_TCP but leaves IS_ICSK
clear, because the raw protosw entry lacks INET_PROTOSW_ICSK.

Calling connect() on that socket goes through __ip4_datagram_connect(),
which sets sk_state = TCP_ESTABLISHED. So the socket also passes the
LISTEN/CLOSE check.

The new inet_csk_has_ulp() check then returns false, because it tests
IS_ICSK first:

	return inet_test_bit(IS_ICSK, sk) && !!inet_csk(sk)->icsk_ulp_ops;

strp_init() does not require read_sock either. As a result, this store
runs on an object that was allocated as struct raw_sock (or raw6_sock).

Does this write past the end of the raw_sock into the next slab object?

On x86_64, icsk_ulp_ops seems to be about sizeof(struct inet_sock) + 208
bytes into the object. struct raw_sock ends no more than
sizeof(struct inet_sock) + 192 bytes in. For raw6_sock, the store would
land in drop_counters padding or in the embedded ipv6_pinfo.

kcm_unattach() later stores NULL at the same offset:

	inet_csk(csk)->icsk_ulp_ops = NULL;

The path needs CAP_NET_RAW, which an unprivileged user namespace provides.
It also needs an AF_KCM socket and a socket filter BPF program:

socket(AF_INET, SOCK_RAW, IPPROTO_TCP)
connect()
ioctl(kcmfd, SIOCKCMATTACH)
  kcm_attach_ioctl()
    kcm_attach()
      inet_csk(csk)->icsk_ulp_ops = &kcm_ulp_ops;

Before this patch, the same attach did not corrupt any memory, because
strp_read_sock() just failed when read_sock was missing.

Should kcm_attach() also check sk_type == SOCK_STREAM, or the IS_ICSK bit,
before it touches inet_csk(csk)?

>  	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
>  	WRITE_ONCE(csk->sk_write_space, psock_write_space);
>  	csk->sk_state_change = psock_state_change;

[ ... ]

> @@ -1382,6 +1399,7 @@ static void kcm_unattach(struct kcm_psock *psock)
>  	 */
>  	write_lock_bh(&csk->sk_callback_lock);
>  	csk->sk_user_data = NULL;
> +	inet_csk(csk)->icsk_ulp_ops = NULL;

[Severity: High]
Can this race with getsockopt(TCP_ULP) on the same TCP socket?

Before this patch, icsk_ulp_ops on a socket reachable from userspace only
changed from NULL to non-NULL, and it was cleared only at destroy. Now it
returns to NULL on a live socket. Userspace still holds its TCP fd after
SIOCKCMATTACH.

do_tcp_getsockopt() reads the pointer twice without the socket lock. In
between, it does a user copy that can fault and sleep:

net/ipv4/tcp.c:do_tcp_getsockopt() {
    ...
	case TCP_ULP:
		...
		if (!icsk->icsk_ulp_ops) {
			...
			return 0;
		}
		if (copy_to_sockptr(optlen, &len, sizeof(int)))
			return -EFAULT;
		if (copy_to_sockptr(optval, icsk->icsk_ulp_ops->name, len))
			return -EFAULT;
    ...
}

Suppose thread A is in getsockopt(tcpfd, SOL_TCP, TCP_ULP) while thread B
runs ioctl(kcmfd, SIOCKCMUNATTACH) or closes the mux:

thread A                                thread B
do_tcp_getsockopt()
  icsk->icsk_ulp_ops != NULL
  copy_to_sockptr(optlen, ...)
                                        kcm_unattach()
                                          icsk_ulp_ops = NULL
  copy_to_sockptr(optval,
      icsk->icsk_ulp_ops->name, len)

The second read sees NULL, and the copy reads from
offsetof(struct tcp_ulp_ops, name).

On arm64, the source-side loads in copy_to_user have no extable entry.
Would that oops? KASAN would also report a null-ptr-deref here.

Attach and unattach can be repeated on the same socket. Neither store
uses WRITE_ONCE().

>  	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
>  	WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
>  	csk->sk_state_change = psock->save_state_change;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029203428.3057054-1-rjethwani%40purestorage.com
