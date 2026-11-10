Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299560;
	b=477fLHU3GieLwU3Ni6UimLd4UQawXdXDOORNoxn3r2NdfEf5PmR/P6rjZh67DpzVHcua
	 wpv1FdRl6q9xtw3J8BqbefArx3XWGvA1UdJ8kMkp3LZ/Zu99aDKZpkReFDYlB0gKL50D1
	 NbkWvtutztXOAJl/oT+6R6vcMLWbPNDdkK+nsYcgjFylWLk53Qg2ILJrHuUYWSnhtzeCy
	 GNsmFTVT5XP7us2drM+yJRH8mS3RHdRw4U0QmxWRgDxYXrz190CTEOf85kVbrDVXnv5PU
	 F/DpNO+vCEZXnwJB1/yw3HUApH5a0XyNZtFYVInmuwK+P/PsDLlo4AQG9i/hR0b/HWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299560;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yWoENu3vdPAXkVmF04rFciz3oscKPZMb928MIrltCNQ=;
	b=X+JMkO6FdiChqY8NyaKIlf+5VH0f9fxF3Z087WPT+wpKcvG8oEyaeQZrjcplES1QR6RY
	 sUIaV8T571kf+zQZqxWyxdXQypIzM+MEQv3gi79l6ZMC58CboyB9sv1WwD+NKi/KnuZHi
	 dv7yHwWZTZ/yeIUe8UrEEfAEhsvLxHcDi/Ehtu3TvLdabI+bNecHXqG4Ia+P1QthfZGDJ
	 +bsnM9vV3gxG1XSUc+9nPwhfKXDa8Hlpn5x/7Rst4AfFP0+MSTEa+gvmP0MACaj0dM9aO
	 PdtMtJRSfvSaVUlP59yXeoK+BoCFEBGw8Fn3UxqYu/RNSS9otYYS7jhzq0YqPdQyptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUjDp199;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02786606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUjDp199
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893D31F008A7
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794299559;
	bh=yWoENu3vdPAXkVmF04rFciz3oscKPZMb928MIrltCNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NUjDp199rgoMf15I6BwY1khUUUkpxVvOx5cV7Tlg2V55/WlmlIZzomXent7fnmJWl
	 C3FjpDwoQL1E92bh0dWZi0G6mI53pnvVirZnaOLnFdRCDhlzNlEgHERh/enCZracdv
	 A/dyYrMr20ra7QC+cK46BhdyifM5IjXoav0KyJbZpqzcuWAjntHatrQCpvM8fjtSBc
	 IM2/7PRYSl9RHs3GykS2lN6cab13dhAWY5+cF3ZKPqKCEB2gKRDhnN+TYBRZ8Hg1JA
	 pbxOScD/MlL9lj4AUYWTQdrkljrYpbnRYVisbbodiqiF2YWCVr3wECpRJcn8jhfyUi
	 Hn3w+Kv23NviA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6dde81a6820so1100906eaf.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF3c5AAHkYK/ByhcBu4PAcJU4Un3e4+zg9lTD6+Q+V2EF7+ynXARk1x23szl3k+Fr/0ejLgk4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EQhfge/aWikTbxSFMI1CP06XcqUq3y/1gh793ayM8ogy3+jW8
	vK6QrdjKuqpf9UDFKt8EPc9FZEfrYz6lkrXmo2KhCSWN5AaHm5ZfGZjBFWxIBVTH2AZA2Cb+SmA
	6kME9J2A4JJp2QYQ+cnQBDbIX1fQ8DVA=
X-Received: by 2002:a05:6820:a703:10b0:70b:af3d:2b6d with SMTP id
 006d021491bc7-718a2a44c83mr565319eaf.3.1794299558721; Tue, 10 Nov 2026
 00:32:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110080008.26112-1-juanagusnicco@gmail.com>
In-Reply-To: <20261110080008.26112-1-juanagusnicco@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 09:32:27 +0100
X-Gmail-Original-Message-ID: <CAL4WiipniV9TJh8S+Ab220eZ5MYRP464j8DuHcU_t5z8FLRmLA@mail.gmail.com>
X-Gm-Features: AclHuK99lUFen8SFcVLfifXn3KKnfmNdlM5jzxBpYposVoovQ4A5o0h_6Bk2Qxs
Message-ID: <CAL4WiipniV9TJh8S+Ab220eZ5MYRP464j8DuHcU_t5z8FLRmLA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix the SO_REUSEPORT bind cache admitting a
 conflicting socket
To: Juan Agustin Niccolini <juanagusnicco@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, josef@toxicpanda.com, jbacik@fb.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 09:00, Juan Agustin Niccolini
<juanagusnicco@gmail.com> a =C3=A9crit :
>
> Since commit 637bc8bbe6c0 ("inet: reset tb->fastreuseport when adding a
> reuseport sk"), inet_csk_get_port() skips the full bind conflict check
> for an SO_REUSEPORT socket when sk_reuseport_match() finds its address
> covered by the port's SO_REUSEPORT bind cache (tb->fastreuseport and
> tb->fast*).
>
> In the FASTREUSEPORT_STRICT state that cache holds the owner, family,
> IPV6_V6ONLY and address of one socket on the port. The assumption is
> that if the cached socket conflicts with nothing on the port, neither
> does a new socket whose address it covers. That assumption is wrong and
> it lets an unprivileged process bind to ports already in use by other
> users and hijack their traffic.
>
> The assumption would only hold if the two sockets agreed on everything
> else the conflict check reads, and the cache falls short of that in two
> ways.
>
> First, it does not record, and hence does not compare, either the bound
> device or the cached socket's SO_REUSEADDR. A socket bound to one device
> passes the full check against another user's listener bound to a
> different device, and becomes the cached socket; a later socket on the
> same address with no device is covered by it, skips the check, and binds
> and listens on that listener's address and port. This lets an
> unprivileged process take over all the traffic of a service bound to a
> device. The missing SO_REUSEADDR fails in the same way: two sockets with
> SO_REUSEADDR do not conflict while the existing one is not listening, so
> a socket with SO_REUSEADDR can pass the full check against another
> user's bound, non-listening socket that also has SO_REUSEADDR, and
> become the cached socket; a later socket without SO_REUSEADDR is then
> covered by it and skips the check that would have refused it.
>
> Second, it records the family and IPV6_V6ONLY but does not require the
> new socket to match them. The address comparison in sk_reuseport_match()
> lets a dual-stack wildcard socket match a cached IPv4 or IPv6-only
> wildcard socket, although the dual-stack socket also accepts the other
> family. A socket on the IPv6-only wildcard passes the full check against
> another user's listener on the IPv4 wildcard, 0.0.0.0, and becomes the
> cached socket; a later dual-stack wildcard socket is covered by it,
> skips the check, and binds and listens on that listener's address and
> port. This mistake lets unprivileged processes hijack traffic from
> services that listen only on 0.0.0.0, which is very common.
>
> Fix this by only using the cache for a socket that matches the cached
> one in everything else the conflict check reads: family, IPV6_V6ONLY,
> bound device and SO_REUSEADDR, besides the owner and SO_REUSEPORT, which
> sk_reuseport_match() already checks. A cached wildcard still covers a
> new socket on a specific address of the same family: once those
> properties match, the conflict check treats the two sockets alike except
> for the address, and every socket the specific address overlaps, the
> wildcard overlaps too.
>
> Note that, as this patch intends, bind() and listen() now fail with
> EADDRINUSE in cases where the cache used to admit them, including for
> sockets of a single user. For example, a user who binds an IPv6-only
> wildcard socket without SO_REUSEPORT and then an IPv4 wildcard socket
> with SO_REUSEPORT to a port previously could add a dual-stack wildcard
> SO_REUSEPORT socket; that bind now fails, matching what the full check
> would do.
>
> The FASTREUSEPORT_STRICT state was added to speed up one workload: a
> service binding many identical SO_REUSEPORT listeners to a port that
> holds, or has held, a socket without SO_REUSEPORT, such as an earlier
> instance of the same service that did not set the option. Without it
> each of those binds compares the new socket with every socket on the
> port, under the port's lock; it was added after a load balancer
> restarted this way on a port holding about 100k TIME_WAIT sockets and
> hit soft lockups. This patch keeps that workload on the fast path:
>
>              N     current   full check  this patch
>            256     0.13 ms      0.58 ms     0.15 ms
>           1024     0.63 ms      8.07 ms     0.69 ms
>           4096     2.63 ms    154.32 ms     2.83 ms
>          16384     9.80 ms   5874.11 ms     9.86 ms
>
> N is the number of identical SO_REUSEPORT sockets, bound after one
> socket without SO_REUSEPORT so that the port is in the
> FASTREUSEPORT_STRICT state; the times are of their bind() and listen()
> calls from a single thread, median of 5 runs on a build without KASAN.
> "Full check" is the simplest alternative to this patch: never skipping
> the checks. As N grows the full check slows down sharply, while this
> patch stays as fast as the current kernel, so it keeps the benefit of
> FASTREUSEPORT_STRICT.
>
> Sockets that differ from the cached one in device, SO_REUSEADDR, family
> or IPV6_V6ONLY now take the full check, so binding many such sockets in
> alternation on one port is slower; the common mix of wildcard and
> specific addresses stays on the fast path.
>
> The two new fields, fast_bound_dev_if and fast_sk_reuse, fit in existing
> padding: struct inet_bind_bucket stays 88 bytes on x86_64 and arm64.
>
> Fixes: 637bc8bbe6c0 ("inet: reset tb->fastreuseport when adding a reusepo=
rt sk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>
> ---
> Here is a minimal reproducer for the issue addressed by this patch. Line
> 10 should have failed with "OSError: [Errno 98] Address already in use"
> but it succeeds. It works independently of what process or user created
> the victim socket. An unprivileged process can exploit it to hijack
> traffic on ports that are already in use by other processes.
>
> import socket
> P =3D 29341
> v =3D socket.socket(); v.bind(("0.0.0.0", P)); v.listen(1)
> s =3D socket.socket(socket.AF_INET6)
> s.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_V6ONLY, 1)
> s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
> s.bind(("::", P))
> h =3D socket.socket(socket.AF_INET6)
> h.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
> h.bind(("::", P))
> h.listen(1)
>
> Skipping line 3 and setting P to the port of another process that
> listens only on IPv4 (P >=3D 1024) works as well. With one such socket
> the attacker answers the service's IPv6 clients; one copy per CPU
> with SO_INCOMING_CPU also takes its IPv4 clients.
>
> I conducted several tests on the patch to assess that it fixes the
> vulnerability, that it keeps the workload the cache was added for fast,
> and that it only changes the behaviour it intended to change. The tests
> and results are available here:
> https://github.com/AgusNicco/tcp-hijack-patch-testing
>
> '1-attack' is the attack scenario where an unprivileged process exploits
> the bug to hijack TCP traffic from other processes and users. It also
> tests that the patch successfully stops the attack.
>
> '2-reachability' tests how often the code modified by this patch runs,
> to assess how much it could matter for performance. It runs during
> startup and not during traffic.
>
> '3-bind-behaviour' tests that the patch only changes the behaviour it
> intended to change. It compares behaviour across 29.8 million tests
> among 3 kernels: unpatched, patched, and one with an alternative patch
> that always performs a full scan. The full scan kernel and the patched
> kernel behaved identically in all 29.8 million tests. The unpatched one
> behaved differently in 697,367 tests.
>
> '4-performance' tests and confirms that the patch does not regress the
> performance benefits of the commit that introduced the bug. That's where
> the results shown on my commit message come from.
>
> inet_csk_update_fastreuse() has filled the tb->fast_* fields in two
> places since 637bc8bbe6c0, and this patch adds the two new fields to
> both. A helper would remove the duplication, but I left it out to keep
> this fix small for stable; the duplicated code is minimal and predates
> this patch.
>
> This bug was found by an LLM-based bug discovery pipeline.
>
>  include/net/inet_hashtables.h   |  2 ++
>  net/ipv4/inet_connection_sock.c | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 6e2fe186d0dc..44b7e39a1245 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -87,6 +87,8 @@ struct inet_bind_bucket {
>         __be32                  fast_rcv_saddr;
>         unsigned short          fast_sk_family;
>         bool                    fast_ipv6_only;
> +       unsigned char           fast_sk_reuse;
> +       int                     fast_bound_dev_if;
>         struct hlist_node       node;
>         struct hlist_head       bhash2;
>         struct rcu_head         rcu;
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index e56beec43877..70b8662b3004 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -420,13 +420,18 @@ static inline int sk_reuseport_match(struct inet_bi=
nd_bucket *tb,
>                 return 0;
>         if (!uid_eq(tb->fastuid, sk_uid(sk)))
>                 return 0;
> -       /* We only need to check the rcv_saddr if this tb was once marked
> +       /* We only need to check the fast_* fields if this tb was once ma=
rked
>          * without fastreuseport and then was reset, as we can only know =
that
> -        * the fast_*rcv_saddr doesn't have any conflicts with the socks =
on the
> -        * owners list.
> +        * the socket they describe doesn't have any conflicts with the s=
ocks
> +        * on the owners list.
>          */
>         if (tb->fastreuseport =3D=3D FASTREUSEPORT_ANY)
>                 return 1;
> +       if (tb->fast_sk_family !=3D sk->sk_family ||
> +           tb->fast_ipv6_only !=3D ipv6_only_sock(sk) ||
> +           tb->fast_bound_dev_if !=3D sk->sk_bound_dev_if ||
> +           tb->fast_sk_reuse !=3D sk->sk_reuse)
> +               return 0;
>  #if IS_ENABLED(CONFIG_IPV6)
>         if (tb->fast_sk_family =3D=3D AF_INET6)
>                 return ipv6_rcv_saddr_equal(&tb->fast_v6_rcv_saddr,
> @@ -455,6 +460,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
>                         tb->fast_rcv_saddr =3D sk->sk_rcv_saddr;
>                         tb->fast_ipv6_only =3D ipv6_only_sock(sk);
>                         tb->fast_sk_family =3D sk->sk_family;
> +                       tb->fast_sk_reuse =3D sk->sk_reuse;
> +                       tb->fast_bound_dev_if =3D sk->sk_bound_dev_if;
>  #if IS_ENABLED(CONFIG_IPV6)
>                         tb->fast_v6_rcv_saddr =3D sk->sk_v6_rcv_saddr;
>  #endif
> @@ -482,6 +489,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
>                                 tb->fast_rcv_saddr =3D sk->sk_rcv_saddr;
>                                 tb->fast_ipv6_only =3D ipv6_only_sock(sk)=
;
>                                 tb->fast_sk_family =3D sk->sk_family;
> +                               tb->fast_sk_reuse =3D sk->sk_reuse;
> +                               tb->fast_bound_dev_if =3D sk->sk_bound_de=
v_if;
>  #if IS_ENABLED(CONFIG_IPV6)
>                                 tb->fast_v6_rcv_saddr =3D sk->sk_v6_rcv_s=
addr;
>  #endif
>
> base-commit: 19a227903e65c7a9c179156485660a4e017575fe
> --
> 2.43.0

OK, but

1) The changelog is way too long for human use. I would suggest :

When the port is in the FASTREUSEPORT_STRICT state, inet_csk_get_port()
skips the bind conflict check if sk_reuseport_match() finds the new
socket's address covered by the socket cached in tb->fast_*.

This is only safe if both sockets match on everything
inet_bind_conflict() reads. The cache misses some of it:

- It does not record sk_bound_dev_if or sk_reuse.
- It records the family and IPV6_V6ONLY but never compares them with
  the new socket, so a cached v6only [::] (or 0.0.0.0) socket covers
  a dual-stack [::] socket.

As a result, an unprivileged user can bind and listen on a port that
another user is listening on, for example a dual-stack [::] socket on
top of a 0.0.0.0 listener:

  victim:   bind(0.0.0.0:P), listen()
  attacker: SO_REUSEPORT + IPV6_V6ONLY, bind([::]:P)   /* fills cache */
  attacker: SO_REUSEPORT, bind([::]:P), listen()       /* should fail */

Only take the fast path when the new socket matches the cached one in
family, IPV6_V6ONLY, bound device and SO_REUSEADDR. Identical
SO_REUSEPORT listeners, the workload this cache was added for, still
skip the scan (binding 16384 of them: 9.80 ms before, 9.86 ms after,
5874 ms with the full check every time).


2)  The reproducer is about 10 lines and would fit in
tools/testing/selftests/net/bind_wildcard.c
     or next to reuseport_dualstack.c.

3) We do not need details and LLM generated GitHub, any LLM
  can build this instantly just looking at the commit.

Thanks.

pw-bot: cr
