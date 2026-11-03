Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743549;
	b=BajOmZgSJOcA8rYL4+i2WWAMAuHa+CFfcXKT5i0U6lkPi6TarlptoDf/LzEHXnXkc1GL
	 gvM+e7gZEVVtPbWynwugfHVhkHZpqU758EFL3U7AdYHU9We3PPzPDBoNSXUBWoa18DoKK
	 vmGEwCupndInSTfj+03XZeXYlUV6xvjwgH2Z0FC4q8k0V04RoRBbuTICXSb7p9urcG2tg
	 Ks+at2nCKU0a/9VB7Y4X3o7Di8yxBRGP4uM5Rb7LPBiZxffoj1emn2QeXu3MPXhru1TuJ
	 qaNJpbolxEiEH1fszfcBkIYaCTHN66BhSBxkjc1JVmLoaQBc8IY7MeLQegYhpdIYzag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743549;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kD181ElKWpcdU35r/LJfIJf0G4FkLwTtt1uh9ho8BmM=;
	b=uiQFm1G2EOuim5K6c9LkTeshTZPaVFRoC3Jx2RM5JT+YiRaB01qjTkDmPj7IQo9Cnwnh
	 cS6lz5DoVmmRCi6yzmjpcldsCNZ/PgCSUXLgSGZ8R7Wze0FbOm9tVNZmYi+VmseIyGDvT
	 mkANyiIWMjShcx2pcTMhj2/3C5ApO9/UO7W5t70oV1K2vZwiPKg+4LwWwARo4aTNBxvs7
	 zU0Tw2oYHziA13YrlGWaHq6C1wgC45O1bbHpHj3NPWUtNqeKs3ldtu1azATqeTKssT4Tj
	 zNE+RvW++jldpzGe2adhfB+7o334TAQDB5KyqdiyYvXS5u6T6rQ5gEEWN9yI6k6x+QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/Ou7MxR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECF606A31B;
	Tue,  3 Nov 2026 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/Ou7MxR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD901F000C1;
	Tue,  3 Nov 2026 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743548;
	bh=kD181ElKWpcdU35r/LJfIJf0G4FkLwTtt1uh9ho8BmM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M/Ou7MxRMlQVBTGDEwSPWED4BOUWxne7Ys4JzaXe+OGEBUUV/NSy/JCzBZZsNCiyy
	 NGzTtLNeJgYGfhE/wV7s+L9EfaCL3JWtySYEiksBgOBsyk/ka2WTyeB/LpZIdb3WFi
	 0fkOt3S5fggi1Y9u+K6Staj9eyAIgqznSvp99XEuUF4chLZEjSMDt4siZoszQhKxn7
	 tZrOyzGErYkqdKvPUXBJF9dvapa0xLlgAF2Y7cUs4KrUu8rM3FGTqf28oAC8i/1xIW
	 uDJDnsHc5ggYVvHFxO9zUWLtIT5wmjYyzLLRL+Vy1bqebZbaCeS2jKqgLXaXk1wSz3
	 W16Xm1cnBlxdg==
Subject: Re: [PATCH net v5] kcm: reject attaching sockets with a ULP, and TLS
 on KCM sockets
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiayuan.chen@linux.dev,
 syzbot@syzkaller.appspotmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hare@suse.de,
 sagi@grimberg.me, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 22:05:47 +0000
Message-ID: <179374354756.488856.17787079121679404910@kernel.org>
In-Reply-To: <20261102220310.12649-1-rjethwani@purestorage.com>
References: <20261102220310.12649-1-rjethwani@purestorage.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message understates one user-visible regression.
- [Low] The commit message says 'rmmod kcm waits until such sockets are
  destroyed'.
- [Low] Documentation/networking/kcm.rst ('Attach transport sockets' /
  'Unattach transport sockets', lines 144-190) is not updated for the…

--

kcm: reject attaching sockets with a ULP, and TLS on KCM sockets

With this commit, kcm_attach() refuses TCP sockets that already have a
ULP, and it now refuses raw IPPROTO_TCP sockets too. Attached sockets get
an unregistered dummy kcm_ulp_ops, so tcp_set_ulp() refuses kTLS on them
afterwards. The marker stays until the socket is destroyed, and it pins
the kcm module.

Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/

> Holding a ULP also has visible side effects: getsockopt(TCP_ULP) and
> inet_diag report "kcm" on a socket that was ever attached,
> sk_has_decrypt_user() is true so PSP RX association is refused after the
> attach, and adding an attached socket to a sockmap fails with -EINVAL
> rather than -EBUSY.

[Severity: Medium]

Is the sockmap effect really limited to attached sockets?
SIOCKCMUNATTACH does not remove the kcm_ulp_ops marker, because
kcm_unattach() only clears sk_user_data:

net/kcm/kcmsock.c:kcm_unattach() {
    ...
	write_lock_bh(&csk->sk_callback_lock);
	csk->sk_user_data = NULL;
	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
    ...
}

sk_psock_init() checks for a ULP before it looks at sk_user_data:

net/core/skmsg.c:sk_psock_init() {
    ...
	if (sk_is_inet(sk) && inet_csk_has_ulp(sk)) {
		psock = ERR_PTR(-EINVAL);
		goto out;
	}
    ...
}

Before this patch, this sequence succeeded:

  SIOCKCMATTACH -> SIOCKCMUNATTACH -> BPF_MAP_UPDATE_ELEM on a sockmap

With this patch, the map update fails with -EINVAL for the rest of the
socket's life.

Could the stable-facing paragraph that lists the user-visible changes also
say that a socket that was ever attached can no longer be added to a
sockmap or sockhash?

> listen() after a disconnect fails with -EINVAL, as
> the dummy has no .clone, and rmmod kcm waits until such sockets are
> destroyed.

[Severity: Low]

Is "waits" accurate here? Unloading does not block on a non-zero module
refcount:

kernel/module/main.c:try_stop_module() {
	/* If it's not unused, quit unless we're forcing. */
	if (try_release_module_ref(mod) != 0) {
		*forced = try_force_unload(flags);
		if (!(*forced))
			return -EWOULDBLOCK;
	}
    ...
}

The reference taken by __module_get() in kcm_attach() is only dropped by
tcp_cleanup_ulp() when the TCP socket is destroyed. As long as any TCP
socket that was once attached still exists, rmmod kcm fails at once with
"Module kcm is in use". This holds even after every KCM socket is closed
and every socket has been unattached.

> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index a7f94d42036fb..1f8bcbb8b9c3b 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -30,11 +30,26 @@

[ ... ]

> +/* Not registered, so TCP_ULP can't select it. It only holds
> + * icsk_ulp_ops so tcp_set_ulp() refuses other ULPs like kTLS. Like any
> + * ULP it stays until the socket is destroyed, pinning this module, and
> + * tcp_cleanup_ulp() releases it. Clearing it on a live socket would race
> + * with lockless readers such as do_tcp_getsockopt() and tcp_diag.
> + *
> + * No .clone: children copy icsk_ulp_ops without a module reference, so
> + * a socket that was once attached must not listen().
> + */
> +static const struct tcp_ulp_ops kcm_ulp_ops = {
> +	.name = "kcm",
> +	.owner = THIS_MODULE,
> +};

[Severity: Low]

This isn't a bug, but should Documentation/networking/kcm.rst be updated
as well? The "Attach transport sockets" section only says:

  - fd: file descriptor for TCP socket being attached

The "Unattach transport sockets" section says unattaching "is
straightforward".

After this patch, SIOCKCMATTACH refuses raw IPPROTO_TCP sockets and
sockets that already have a ULP, both with -EOPNOTSUPP.

The kcm marker also stays after SIOCKCMUNATTACH. For the rest of the
socket's life:

  - setting TCP_ULP fails with -EEXIST
  - getsockopt(TCP_ULP) and inet_diag report "kcm"
  - listen() fails with -EINVAL
  - sockmap insertion fails with -EINVAL
  - PSP RX association is refused

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102220310.12649-1-rjethwani%40purestorage.com
