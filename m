Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014422;
	b=iOY2FBcVMpbFbA5TWnuFZrVI7C2OuFoqwGh/hK6hdX0nOBjkLGNVPtBEJ7CGRMUXORRl
	 4KUUaougbdL/JwjhxwJmUSERPNDJx6cNC4GAnAGA+X0zdbjrAFyayUt9men+owlybAarF
	 yOTv8zaS58EbilGvEmYO94a4+mB4LeY54orwEnFMGvbiW80mLH1ac3TLQEfOkCy0PnUee
	 JC86kYTy6A1Ha+9ewMuYQtJqRY0fyIXASrsh+8HrsWTWrKbQ6LEPnzCDy9NmxWJnXj5bU
	 JeraEtFig+xPfuwA8KiQVQfKX+QQ6MjX3L+fuUdwmz3KBLLxDH0/cwjruHJ5OJ7s0wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014422;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FLLgoY4vzpl3VeoTzJ1Eki0KKKvfGT0/D/rtdudkmNU=;
	b=bVzwNBrFe0o/+c+9zWl1+HRuSwCdq6Mdtfb8rheoNMv3Do7D5UcJrmkScpuExLDmHtta
	 kMBu2Xruqu3pTqLdkqx2WcXt2GAZwO4+Jsa9ghKwRWMRh4O/PCOyY+JIsT2WUEiC47SUr
	 +oalkYmL4Jko/FSTaGfnQYyslnITAUYwNGderpgn57F3sbZfM06CxjQV1zlyUkm1QgSYx
	 ze03+KUDU30oACjJBcU2FtJCMX0wJKPr1aziET62lRcIlZVOMmVHnIVGldpXLHFZo+oOm
	 OIlnEBD7wxurHsQxb1B6gxDZoB3BsNIW8RiRaOkmj6RsF6/hHuZzyBKhQmmxG30tBUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiyeB1Fu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAC606A338
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiyeB1Fu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1451F000C7
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014421;
	bh=FLLgoY4vzpl3VeoTzJ1Eki0KKKvfGT0/D/rtdudkmNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KiyeB1FuKANKheiwNKWWrLntCZ1zpria8hiMsmm6kDNS1SSSoDwX8H7ZHpxspvan8
	 7tcL9t3gHcQ2p/hrpQ+hcKKFPT2WUTZH/R6clrP2VI4RALEBLzPNRDXVfM/ioqTbe9
	 hEhRZRLOmSqhCO4neP4vqxMuiEvv0h9lWsFlp8fMJmgyK8+9M2DL6JAJ/p3AIM16r9
	 f1ypW/wBmu8svD0Uhd2ZXj9gaMSqZUuzTYsvFQ4T4139tVjq35t9lUocitpHogmrLp
	 7JyLLQ19e8Lvx7d2unhqZi7zrFIYYV6z5VvE8uU5deD3J624LQbFsP7teaeDnVZYen
	 bUuWX8uVFCu4w==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-702dedeb70dso697101eaf.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:07:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF81gsfOmq1D2C1q7m4QNaA8aGh44V0GWIDFh6AQ5I9Pe/wv/pEAiKN2oKBSpSLUUgZZRQKQzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tFl/7Xydkovy68bt8Df8lkLa3asUChCKvHa4qAsnrMWcw9wS+
	agwB7/iYrcN41cYwDkY2ZA8tFG5feZDjCku0DTgOdrDp0m+qGSad4cIYuV8YP3p9w/bcW3XDt+b
	mXM9lMkPtdlif3AXr/0cKRHRPHSJmhx0=
X-Received: by 2002:a05:6820:7095:10b0:6f8:fcce:a410 with SMTP id
 006d021491bc7-71b18552c41mr1594981eaf.55.1795014421167; Wed, 18 Nov 2026
 07:07:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118144249.358481-1-jiayuan.chen@linux.dev> <20261118144249.358481-2-jiayuan.chen@linux.dev>
In-Reply-To: <20261118144249.358481-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 18 Nov 2026 16:06:50 +0100
X-Gmail-Original-Message-ID: <CAL4WiipSzUmvGxRM5PMBugXJ0qjAnobT6+pNuEJhUqTVrVR1Uw@mail.gmail.com>
X-Gm-Features: AclHuK915aJOXi82aBAcq1O_eeNA6-6Devxm-s0eHQNf5wtCOhOKeEZz0_kjdHc
Message-ID: <CAL4WiipSzUmvGxRM5PMBugXJ0qjAnobT6+pNuEJhUqTVrVR1Uw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Kyuwon Cho <kyuwoncho18@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 18 nov. 2026 =C3=A0 15:43, Jiayuan Chen <jiayuan.chen@linux.dev> a =
=C3=A9crit :
>
> icsk_backoff is used as a shift amount in inet_csk_rto_backoff():
>
>         u64 when =3D (u64)icsk->icsk_rto << icsk->icsk_backoff;
>
> It can go past 63 on the paths of both callers:
>
>  - RTO: tcp_retransmit_timer() increments it on every backed-off RTO
>    with no cap of its own, then an ICMP unreachable goes through
>    tcp_ld_RTO_revert().
>  - zero window probe: tcp_send_probe0() increments it up to
>    tcp_retries2, and tcp_probe_timer() calls the helper in its orphan
>    check. commit 6d4634d1b091 ("net: Limit logical shift left of TCP
>    probe0 timeout") clamped tcp_probe0_when() but not this one.
>
> Seen on the RTO path with tcp_retries2=3D255 and a silent peer:
>

Nit: tcp_retries2 does not need to be changed for the RTO path.
TCP_USER_TIMEOUT and TCP_RTO_MAX_MS on the socket are enough, since
retransmits_timed_out() then only looks at the elapsed time.

No need to respin only for this.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
