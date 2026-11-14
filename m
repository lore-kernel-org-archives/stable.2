Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668578;
	b=H1gRlI6OCrmPJjnPptLsEQ7StyaV7MfddV/c7pcV7KNi/RkpDQtLokg6e/97M/OwXcZr
	 QbNk4Obf61NDjiP6dqH7qrwnJbY9cO/JwLAxMjGUBVvnRlYR8anaOUqVsTlR13PcHTvHG
	 6JQHcVSlRLFWIDc2v2Izq5okhSKr3YUs7KRHBqzUzYxceVneQ2vnLeqPasb3DMYtUxS0N
	 CLUqb+rWlB92/LXpqgGEo4duyCk0u92Ym03OkblRGavCayOsKRAD05trYClTp/gYHcxxx
	 Xf8CnvE9uyCkuH4T4EzXN8QEDFVFdGuGVGEEb+YDjY4npnxLr0cR7BOSM7RFCN2+bug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668578;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jyMS0DMkuv+G99LzuqSMRRxkPq3RRst5DDHRs1rjojc=;
	b=QolopB/EdFuzixs4Si+9Qgx/BrOriYe74bp6/DBB2qIbikCYMGlzfvkIbhNEeNRqS7KT
	 McpW8kHOCOTvRWQfQkL9v9FVTtkZvElqXb0yAg+lOjOwPw2xNViFpULvQYVJcicixCQj3
	 6flAwSEmog3htTnRPLNtvm3cIIneJVqH4CUH8GV+sHQ2yx+5oCD7tyD8YvasKeN7wrtnA
	 ES1bQaOuYsaWOlCE2gldGQn+CMkcQHnWAJlHHqyMVj+JoOR6+MuyRHkOt+j1BDJrix7pN
	 fqO6pyVWSD2peu8q5UtP3odCOV89JuvzVQkFcLdrV/FpV/nQ3ExyclSHZDE+zYXepMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1PYA+hd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFD606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1PYA+hd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7EC1F000CE
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794668578;
	bh=jyMS0DMkuv+G99LzuqSMRRxkPq3RRst5DDHRs1rjojc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L1PYA+hdIVhGDX7p0SvpAZn+gmsPck1Z9AP2P31qAO82jKpfBQIpPe0H34EgKukHU
	 gIyl909qUUlkM8M/3hZRfSkbYfvLtMbFLhsVZ9t7qf1MOFlqJMuZts5uXW5CrC75ri
	 idOB7N9covXz+IE/lBSpqrS6I5Za/Aoj6Cb1BRxeyQTPI3whM8d8LLnmkLpCAd4ECT
	 gQkXim5vOSrG675UVBX1Wjy/DAlmsOfUKA1AC5WIlVIN5Go0G8QrOyf0G1comRBAvm
	 HOkKmM63QEDJqmaLrz9+FAXaZTmPhPJ21az9OFuScjqdq43R/4JHwwnNx37PFt4IlB
	 V32kIeZve70+w==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-71ad099391dso202128eaf.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:02:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGEfpxvBVoG0PEMSNQMBbgQfanpBh0DwPqPLKJegbUCAMseXeKfuOioKDirO2Z5HkOvh5op36s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fMkkmV22Twyr9m7i1hf+LMxR2mkOG6KS26sfeCD1YUFjXoTWY
	/YYnWmd/cRi5Qqfes2fR/02VL5nJ0WKre2Oxqpl2mRejt2V+nKEKAAINJ+4rl+khOXUgxbqf+pr
	VGkh7Cq6jqSd33GERZzUjh8kKpgECCVk=
X-Received: by 2002:a05:6820:55c5:10b0:716:d376:1620 with SMTP id
 006d021491bc7-71ab4d117d1mr2298892eaf.8.1794668577228; Sat, 14 Nov 2026
 07:02:57 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111174704.24312-1-juanagusnicco@gmail.com>
 <20261111174704.24312-2-juanagusnicco@gmail.com> <avgNl96dmc23KOrW@google.com>
In-Reply-To: <avgNl96dmc23KOrW@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 14 Nov 2026 16:02:46 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqe8FETHHiWoTdK=fDkCzGWQ6ROUpryEXrPij5ut0HRgA@mail.gmail.com>
X-Gm-Features: AclHuK8s3pBSKl_JDPVFO1SWzDNENx63z4-YVcQmox4V8t9XebjFvVAd3FaacpI
Message-ID: <CAL4Wiiqe8FETHHiWoTdK=fDkCzGWQ6ROUpryEXrPij5ut0HRgA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: Fix the SO_REUSEPORT bind cache admitting
 a conflicting socket
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Juan Agustin Niccolini <juanagusnicco@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	josef@toxicpanda.com, jbacik@fb.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 14 nov. 2026 =C3=A0 08:28, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> On Wed, 11 Nov 2026 12:47:03 -0500, Juan Agustin Niccolini wrote:
> > When the port is in the FASTREUSEPORT_STRICT state, inet_csk_get_port()
> > skips the bind conflict check if sk_reuseport_match() finds the new
> > socket's address covered by the socket cached in tb->fast_*.
> >
> > This is only safe if both sockets match on everything
> > inet_bind_conflict() reads. The cache misses some of it:
> >
> > - It does not record sk_bound_dev_if or sk_reuse.
> > - It records the family and IPV6_V6ONLY but never compares them with
> >   the new socket, so a cached v6only [::] (or 0.0.0.0) socket covers
> >   a dual-stack [::] socket.
> >
> > As a result, an unprivileged user can bind and listen on a port that
> > another user is listening on, for example a dual-stack [::] socket on
> > top of a 0.0.0.0 listener:
> >
> >   victim:   bind(0.0.0.0:P), listen()
> >   attacker: SO_REUSEPORT + IPV6_V6ONLY, bind([::]:P)   /* fills cache *=
/
> >   attacker: SO_REUSEPORT, bind([::]:P), listen()       /* should fail *=
/
> >
> > Only take the fast path when the new socket matches the cached one in
> > family, IPV6_V6ONLY, bound device and SO_REUSEADDR. Identical
> > SO_REUSEPORT listeners, the workload this cache was added for, still
> > skip the scan (binding 16384 of them: 9.80 ms before, 9.86 ms after,
> > 5874 ms with the full check every time).
> >
> > Fixes: 637bc8bbe6c0 ("inet: reset tb->fastreuseport when adding a reuse=
port sk")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
