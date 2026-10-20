Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517832;
	b=ANw5HJI02UkH2U1bE1+D6PJ1pnECQOHe49iVBkfo7a5wH7oI9ifM49UVTjkuU4qI0zMw
	 F4BY9H3lPIL8i3CsBOZqbmAhTYbu5ocPg7LHOFTWUM/Rq2pwkkhHNzwAzO0WYWWisYliI
	 m6akAwf5NdMfOtbH2hCEMgE3udIUX6guDUkoRS+AzvB4pfvpcILHX1iT8GXcwwGmceBTR
	 v9vvyMyLFTW/NkGm0WfeYUX96ffU6NmucQDs8pHBMNJ8Fye7Zed7D1LDkpv2iMU3HM/SR
	 evjuHIvnDB0XTldY4kbSofwqLmoEA9zVTlF+UFUGQkv/tPDRr404/McNFBmP+iamgng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517832;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5fkSfLaeVzOxHCGTLgV2rcfLR1uzal0xGnFN54iZh0o=;
	b=O/kkDPo4O4imPoAAbjUPjSTPNJUE+qTvOfsPQVS/0yPFMZtNsWiYsAZsaeU15zDZGwx/
	 5FKbJYWLc3+8XY5XXkwQXCWMuNG0oRVKwCNpaInROxw/s2jmFGhtI+1+Y7ymRivQs/OZQ
	 HGYbC/q+BHjJGZIN3x7cy/I3cZSN6K/HRjTk5m3ON4PTCTsEKTrZW0GFF90EOsjOAtjDZ
	 BrhQJeEIYTMrr2uSvFn4hMt57UWyoGv9x85QYkQd49a/dA6UjTL+3yDxr5wXGtzl6sQ/T
	 lggP4OP4+KWXA9RlhGI+9UcErCUvFkCxNy2WGviisM+RXzNtvL2KyGhM7QoFrEDt3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxeUmY75;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3F606A32E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxeUmY75
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4652B1F000CA
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792517831;
	bh=5fkSfLaeVzOxHCGTLgV2rcfLR1uzal0xGnFN54iZh0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZxeUmY75l2Wp0Dn+uMAghoePDtguOCJrFeeX0k2PuMMrZUu4IRQgwooQEmVToHnWe
	 dVxMnmJla7b5JLU5G1FndWD7qp3C3/vjyVuwA0U76Hw5sWaVtcXupMHiNm8K251iit
	 Ythb/wTR3ob+VtC9Ict/FJKmmdNRwxQRSQYXZKeFOefPgT066XUhx8L9WbommJ8hjy
	 4YaHPn24Jzslt6kEjCzOHi0Aa0uBPZJcW14B/alOpm+rQZW6BecqLTRgC61G6TV5U3
	 Bui+S+TuSy5DF93TiKw9ifO0FZmE5g2W9rNkzUAU/mC5NbPatmvYXLQe48H/Lj/bjK
	 0pe3Mf8Pi3tBQ==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e55db58cfso291977885a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:37:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwKVxqCOlF0l/ENSYndukC9hZMYoUBRdseqKu+fAb4VopzookDk2Rh4DhRotetiBJyhxFWUWeY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKd4H8Jwcxk6tJDoy/9zZP7yYlesDKiLHaCaeIznRgDK1MI35PN
	1cOGcqTjeY/5C+INJDhi+SIXFCh4EV0lkOZYTMeF65xFf6Ziutjv+6kksadAsDkTBsAyNfPg9aJ
	oc9Okhh55bt8EXSK/lsCN7xzjzP/yzlg=
X-Received: by 2002:a05:620a:4491:b0:93e:c12c:9b6f with SMTP id
 af79cd13be357-93f29df45admr1849134685a.74.1792517813956; Tue, 20 Oct 2026
 10:36:53 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-2-matt@bobrowski.net>
In-Reply-To: <20261020105014.97985-2-matt@bobrowski.net>
From: Song Liu <song@kernel.org>
Date: Tue, 20 Oct 2026 10:36:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5LcmQkANg1hzz0U0HskrJ-9NzN+7e8RmxBhvb+kHv+=w@mail.gmail.com>
X-Gm-Features: AclHuK899YpzPcxp4mjqjQL7lgr3tszVq5e23B_cgGOF0EjYuXaU87fb6LLw5SY
Message-ID: <CAPhsuW5LcmQkANg1hzz0U0HskrJ-9NzN+7e8RmxBhvb+kHv+=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
To: Matt Bobrowski <matt@bobrowski.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:50=E2=80=AFAM Matt Bobrowski <matt@bobrowski.net>=
 wrote:
>
[...]
>
> With lockdep enabled the fault is taken in lock_acquire(), from the
> seqcount read in get_fs_root_rcu(); without it, on the read of
> fs->seq itself.
>
> Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> cannot race with that.
>
> Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Bobrowski <matt@bobrowski.net>

Acked-by: Song Liu <song@kernel.org>
