Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069627;
	b=Thmz3E8+A5GNdG1Db9y5yS6Lyh/AB9z64KsnptXDHZdBmBA9hP5x+T9rFaY/vi9710YC
	 Gtei4H8CeFuH86ux3Yz1VyHbvnP66XF8vJr5xxCJcNVfDbQFg+jC+fh/rFcYINCyPGM0P
	 n0kQdujRcJmvcl4QSoeGrAdrlK6WWXfDRuyAU0HMA6f6paqsIxV8XbariIjEwuDFs6FV5
	 V3XVGpuC5xij6Tbhzou+9cU6gVNDB2/oDEJqPXONp57S1WkcHKraGsckTbRT5EStatcL0
	 6iw+v9s3Ufc/LXSym2V8vuYyJjPu7zUKp0CUTLdQLc0zC2Waf6CzsstB+XLfT0WdVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=QEyBimWiPMZCb/NgBqLydR3KIBuNX/gfzUiZdqnqTSg=;
	b=WmB4Iopz4hWcF0aXAiIp0Qyigf/RdNrwp7JZRgDJqeaLI/ZVIvR7kgOwImy6OnATQfFl
	 M1G7/mUaqqKqOn8qVv9Tfyq2907s1Ic7j8D0nlawe3Q1AFN8h7cq+ZUrrgJhuOkOZqk3x
	 ToEaBPQ6e2JhyIcv4prU0aDf/9JuhjLapYQyso+RvcGlVGSBk9Ygvu8hU07QBILzeh+q5
	 QxTu64PVbc55DeI0f5XJih4qqkeE/jbQxw5xvY3DnZBpVdMkrJZtElKuRMF+d+ZU30uRu
	 UTeKV/80Fxa5eRcr6NsgXd4GuW7qcP1K1LiRKGLmpvbmOpmlelBCMSLm4iMrAypzCgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avJ1y1hc;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A26606A33D
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7A26606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avJ1y1hc
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1162536b3a.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069626; x=1795674426; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QEyBimWiPMZCb/NgBqLydR3KIBuNX/gfzUiZdqnqTSg=;
        b=avJ1y1hccHAVp2OQEF6HFs7rp+tJ+c6Lsg4YWpNqEUj0mcGZs5E0JoA3GL8/MoukJS
         ZRbcrvfmw6g/qp1EzYUR8C1lMuFz6/WQBCBtCuRnvddMpKX83KqWaTTKu86i37L7rBP5
         Wx99kcAZpizEB/DtpChFFjMVNyFDUPUlNS+64QbGUboCHJ5YGZTyI3VluU43hZPu1t2m
         ZMtPG5S5NZuQcb7c5PhZ7QJ4S8PIOdg7UALNzWz7VfM+GFBfTASEII/f85KdU0VAAVIp
         IMoNCmMwpwClRvRqsNEvAekNhhXB9eXE6lfoP0zbkYlScNSY7nqS1Ki0UFCG7CokDdu6
         PHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069626; x=1795674426;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEyBimWiPMZCb/NgBqLydR3KIBuNX/gfzUiZdqnqTSg=;
        b=tUmDrnXIPS0JBGjdrrjs1WQD5QCt4SUnKKJq5E1TJPdQW47ku0UB12QlxGCrmIwA4w
         MMyat634qItgcnQ9fN4zNiVjeK4y5D8mgMLXPHCeDCv74ApxSxJ8ocLibXJL/HpLv6RA
         VKWc0r3MFa0tOmVfasQoLej9ms25jHFfejTycLi5/rOjQE8p4iUMiSWIarGuPdlfkjhJ
         ViFSfEdy5gmFaNlAMUDWBlMMLQLVYIaOoCGYM2VzJxsHfBCE/7HTUeosRkYKU+4IUj5C
         gDYNZIGzxt13NhvO4j0bGtAMCUTXWvKPGM69IZDJt4OcpUKbK3HdbhWg+1qmSkvWqjmB
         6c3Q==
X-Forwarded-Encrypted: i=1; AL+hErEzey18EfZigIql+WrKeKvfy7On/2nJzHpZzE929JxXqdYoKVYQJ9HY71rLB2i2T60qMSbe1IE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8F9F8Lqj2qrYICKxZecjvLJkpkOGBiKLux4B7MeuuNcXu+8BZ
	QVlhq//Yu0LwwQ4Ulu8duQDRloQgonIKb4E8fKzyIYulrmglBEI4TEMd
X-Gm-Gg: AYBFou0LXFZYpsCj+JjZyHUZ+giM8mvOq6W4U4R/i3K55KCrnKc6Zfr7cKEgu8qjBWw
	Y/WF/xaNjWyLvqjj4yMiV38NeEzg9mqEZNMsUUZAOaOiZCYyRN0DiZOaU9pDZJxT+YuYDM3/YOc
	SXFyOtVmRfATulJoHTF07q0MiJNDTP3aSxOCKxo1FLz6/SatHB+GbpuB+9gx8d9J8frtxE99X53
	7kAk0riOiGcZEnW/vLXH8KFEvW9Tpf6uoDdKLsRYE/JxEjJfi/g+CiSMlVGjidoX1hNgrolKgm8
	A/e+pNNpW9HwR71DzwQv0d039AkGqp0yA0uaF98LvVK59fM0Dp6wFuhsLkBxg6HeWHw1oAiSqoV
	8b8InjDltdnrwWnXf4G0rYULsEMVJhxGXDGMFnmYuW4fUYrCPNUYOcG3c5lsrbKM3hbTItCyDTw
	oVpUshgI+rZ4106KK9MtQGpJXQL1FMf1vhTO+EnL3wJvzyOjBD+jYQbG8LeH4G0Ne3PK7jYkk/q
	eZ0nacvtcNjKAoKjj/pb+oV0Vi/iprrM2sESCAkNY5vR1yYIvesYoF8hUZF1BSE7UxY0SqEYLy0
	NvlMdegwgDko88OXdEM28vo+2m23TsMn5rfnmRKqOwj+LqfHjTuh7WNjmTVwBaRyHUfjTbUOCmr
	Yj0F+DOUCHSuyfP0cSBu2Pgf62z70UzPjBA==
X-Received: by 2002:a05:6a21:b8c:b0:3e1:a8fc:18f9 with SMTP id adf61e73a8af0-3fe8b5eea53mr4717482637.62.1795069625749;
        Wed, 18 Nov 2026 22:27:05 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde5336475csm1177532a12.3.2026.11.18.22.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 22:27:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 06:27:05 +0000
Message-Id: <DMYZ2PEBP5GQ.NPCWIL8HYD9H@gmail.com>
Subject: Re: [PATCH bpf] bpf, lsm: Remove bpf_lsm_release_secctx from
 sleepable_lsm_hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?=E6=A2=93=E5=B7=9D=E5=92=B2=E5=A4=AA?= <inkxiao12@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <security@kernel.org>, <kpsingh@kernel.org>, <matt@bobrowski.net>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>
In-Reply-To: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>

On Thu Nov 19, 2026 at 6:18 AM UTC, =E6=A2=93=E5=B7=9D=E5=92=B2=E5=A4=AA wr=
ote:
> security_release_secctx() invokes release_secctx LSM callbacks
> (selinux_release_secctx() and apparmor_release_secctx()), which only
> kfree(cp->context) and never sleep. Because the hook is non-blocking,
> Netfilter callers legitimately invoke security_release_secctx() under
> atomic, RCU, or softirq context:
>
>   1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
>      rcu_read_lock() and holds it across ct_seq_show() ->
>      ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_stop(=
).
>   2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
>      rcu_read_lock() in packet RX softirq and calls
>      nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
>      calls security_release_secctx(&ctx).
>   3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
>      allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
>      security_release_secctx(&ctx).
>
> Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
> lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
> blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/softir=
q
> context, causing BUG: scheduling while atomic or RCU stalls.
>
> Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
> line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
> and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
> x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch ->
> REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
> sleepable").
>
> Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: BoBppy <inkxiao12@gmail.com>

This is not a real name.
I'm dropping all of your patches.
Teach your bot basics first.

pw-bot: cr

