Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940555;
	b=eEU01UJXonn0Lrq5Buh/tqRNVSiHAUEg8XrUViKUYpsm4DcJtzu5MbeKSLtEyt2sO1PK
	 WZFB3FxMrM0kliN51WTcGU969GY9BezA+SIsBgbxfUe7yO45f1ywUHg11zfTGCagNkWSZ
	 k2RafnHLWdUpVrRXW6skcnUvAz13W80p3gZa7gQ4hZTUUdvr/s3ye7gXp4bHcPD41EA7W
	 9JYzwdhYf2Wle8gTOK+LTbhxg5wiwDop708H5N4cL5rl+st+cR/M/tbIFXeUPPuGjnfDA
	 p6QM+8ml/+u3EQroV9kyOOT4QIXfY97mSAHW5DAkmQEuYVQCijyOQKpOY++NEbbhPgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940555;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GbbujWN9CgXlIh0OW4AityLz5uAnjAzqZYn7Skh9A08=;
	b=fItakkcn9Jg7adq4jX+u+9SJHOvSffKP7+uH8OS2itsfLrufG8/dMaNOWS6b1NqVTzbv
	 KMXYp3JEQgMWBh0s2HZH6vShC4mA8y9o8uwynJmOGR1NRTZ61GyPdtgEi1f/0Yp+5Nm+Y
	 lDcDzcXbN95jDyAXHey5SbRp1xk5AyFmEr83eFZZxuDcHC7s5XhNLi1UMcuHJIL2HfEa5
	 cQA/9iPs9S/WWqfzayuSbHSAag3t+R9elIJ9woOhntCLc6GkQ8sknZVXmx4mLFDQdaYBJ
	 g2O9BGLVZN7c1KfU7MG2Ff0Kt8IynG4Q9K86mrRBgLGtKCGcoApv70E2fmbPXQ+lJng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dB8BFSmI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E90606A31A;
	Sun, 25 Oct 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dB8BFSmI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C501F01825;
	Sun, 25 Oct 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792940554;
	bh=GbbujWN9CgXlIh0OW4AityLz5uAnjAzqZYn7Skh9A08=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dB8BFSmIqZFoIJvvcTzrwfGFB/Kcmfjwo42raWbl1Sw1fgJkiMPZllORd9Zfs5cGP
	 IyMmhP6OwvLFS39rfdjFkyh64QkFqAZdDL5nplKR6ctb3g5WbDpK+glIXbcmMLFFY0
	 tXOlVnhHHFgcdAHEQq5a7qzyvVlZORHThoP0wKnp/hWxDpqvdc7OHTFI4CggRchovG
	 9RSpfhAO9e5F6A/oWKUUGrArmOkJOhHseJ22EVIMDfiXmW920lJtzDyM+kO53dbQ5z
	 QrUGgC/jvswT/x4Su8DT0xyHPj+z1G9O5pDxcdCektMtzvTuNauQfc6chL92zAxaS2
	 AjjcIFbF34yHA==
Subject: Re: [PATCH net] tcp: limit tcp_tso_rtt_log to a valid shift count
From: netdev-bot+sashiko@kernel.org
To: 1075151112@qq.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 25 Oct 2026 15:02:33 +0000
Message-ID: <179294055394.3134.18315932925125315352@kernel.org>
In-Reply-To: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com>
References: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch puts the new bound on the wrong sysctl, so it does not
  fix the bug it claims to fix.

--

tcp: limit tcp_tso_rtt_log to a valid shift count

This patch tries to cap the net.ipv4.tcp_tso_rtt_log sysctl at 31. The
reason is that tcp_tso_autosize() right-shifts a u32 by that value. The
patch also documents the accepted range [0, 31] in ip-sysctl.rst.

> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index e3760daa34706..e954311405b41 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c

[ ... ]

> @@ -778,6 +779,7 @@ static const struct ctl_table ipv4_net_table[] = {
>  		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dou8vec_minmax,
> +		.extra2		= &tcp_tso_rtt_log_max,
>  	},
>  	{
>  		.procname	= "ip_early_demux",

[Severity: High]
Was this hunk applied to the wrong ctl_table entry?

The entry just before "ip_early_demux" is "ip_dynaddr". With this patch
applied, ipv4_net_table reads:

	{
		.procname	= "ip_dynaddr",
		.data		= &init_net.ipv4.sysctl_ip_dynaddr,
		.maxlen		= sizeof(u8),
		.mode		= 0644,
		.proc_handler	= proc_dou8vec_minmax,
		.extra2		= &tcp_tso_rtt_log_max,
	},

The "tcp_tso_rtt_log" entry further down is unchanged and still has no
extra2:

	{
		.procname	= "tcp_tso_rtt_log",
		.data		= &init_net.ipv4.sysctl_tcp_tso_rtt_log,
		.maxlen		= sizeof(u8),
		.mode		= 0644,
		.proc_handler	= proc_dou8vec_minmax,
	},

When extra2 is NULL, proc_dou8vec_minmax() falls back to its default
maximum:

	unsigned int min = 0, max = 255U, val;
	...
	if (!tmp.extra2)
		tmp.extra2 = (unsigned int *) &max;

So writes of 32..255 to net.ipv4.tcp_tso_rtt_log are still accepted, and
tcp_tso_autosize() still does:

	r = tcp_min_rtt(tcp_sk(sk)) >> READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tso_rtt_log);

Is the UBSAN shift-out-of-bounds from the commit message still reachable
through tcp_sendmsg_locked()->tcp_push()->tcp_write_xmit()->tcp_tso_segs()
->tcp_tso_autosize()? The r < BITS_PER_TYPE(sk->sk_gso_max_size) check
after it guards a different shift.

This also means the kernel does not enforce the new "Possible values are
[0, 31], inclusive." line in ip-sysctl.rst. This statement in the commit
message doesn't seem to match the diff:

    values 32 and 255 returned -EINVAL

Separately, net.ipv4.ip_dynaddr now rejects writes of 32..255 with
-EINVAL. Before this patch it accepted any u8 value.
inet_sk_rebuild_header() checks !sysctl_ip_dynaddr, and
inet_sk_reselect_saddr() checks sysctl_ip_dynaddr > 1, so both accept
larger values. With the Cc: stable tag, this change in what the sysctl
accepts would also reach stable kernels.

Should the extra2 line go in the tcp_tso_rtt_log entry instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07%40qq.com
