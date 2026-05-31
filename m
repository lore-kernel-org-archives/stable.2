Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610739184E
	for <stable@vger.kernel.org>; Sun, 31 May 2026 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250935; cv=pass; b=HpL0Js/dvizo+N/pd2jX1LgM6LSkevbeQENNuhX05SEhOTEcDtSA1BDi/eQZvoOfDV1uWZaRl4MCPHILilxyC6FXGgrCCt4xuYtWs9iDJz+dpbncFEme8hSLtKoW/JSEX6wDqBDrc19kR7Gghj3rhQCCW7KCSWlyPWVfKsaWGHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250935; c=relaxed/simple;
	bh=LX4HPkltEGsHPK17yME6ZDWufNBKXuBoPdfhHIdKp8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC+BCCYHjpOgb1NIlbIA7n3r8+8Ilv8w79oOcLRJZIX+yQCn51SWRkoXZQzaQEe6uTrf96IMlFlfV085cD6+hHiCoES+DLIkiB4jqEV1c1aDoDv7jY+Vrdul1YRwLhvvxgge0qJ7s+TT2/r6IukiHbIUOSj1iceALAZHiB70RwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apsnNg01; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apsnNg01"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-516c96d0cdeso85605671cf.1
        for <stable@vger.kernel.org>; Sun, 31 May 2026 11:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780250933; cv=none;
        d=google.com; s=arc-20240605;
        b=X/IkBNX12/wzT4FqnaepvCOWSo9yYfV0YmpbFhNzp9QuCv0E3YChm9W1mqG8UMOZZQ
         aTw/brXVpd5dHfbDn2juSnfK60cCJMc66yqmUoudFeOBPUyJuZw+MB8LTwJBfeVpBHdg
         10jen07Qa1Iloaqbb4BJqsekRB0UBmRVax9NQX7l1NEujEHWMSqL+f9echAnAe5XQvNT
         UDpKhMH5dQ02zriv9WGU2QCQPGQshpVm1IyN915njreCRuXWCdn7cbMkaEg97CnSlDDz
         tepAzcgv+EV+os0QYZ7HFmBUJ3jccyW2a4nBJ3yQyeUCxrDRVrKm5+3QmBthxFs0xBaQ
         WytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=igFYe+C9WOBYLpObw2m/zg4GWFSBeVyEOXzH0bhFKC8=;
        fh=RTiUMHctDrVr9Z8Ixu6Ahpd0nq0n1enmG+zI7QkjLRk=;
        b=GNU9EFnDkYz+cbKTkbL190Nw/lPwsFQJrgHVa8/dQ7g6SRarKArOo2YB8f6QfiIUkO
         PGFCD5aZzLtmA4+TTzetVIuDrWuHGggIsb3/JujxPpOvybANATL5WDCSH4tTmqTYIQLV
         ur3/7JH6YTrZ/Xhd8iI6nmr6UUllMzCMkZDiXE04thSfAons6DVVhH5tPasdk7jSAnkw
         BrhFEXZwSBNnuphym3AVjAD253ls+Ir3VYQs/5WDFZtroL5jssnsbBMvS0kddaxu/eVf
         gQnmEAhw9081s7/9xLUOcUTRxLgqPaZvF/FjoWqOIWwdHZiJZODiUGTjXZ3VFqBMjI4U
         1sAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780250933; x=1780855733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igFYe+C9WOBYLpObw2m/zg4GWFSBeVyEOXzH0bhFKC8=;
        b=apsnNg01Ldjc6kkTGoBAFG/3+dB6SlqNw5lzJ5lL7zxKHrUhAOAo2TTQpGG6sWGB8u
         2wx+fnSfBeYls/D3ZHynkfNxCfFhvnE0Rh8sZGo0AyH56dVFagpYx9kxwx3oJbuScl0e
         QIJ9/pQTUELVEi53XDx6s68rYbY2puot7IM1G0+D19OiJrEvF6zuMg9OWXObfhaE8X5b
         XZOlZhAZOa3QcSQ1p05fjOMwoj9WouaS11JZXzGUfJSWa/YsYXP50Sv/l9H6G44rWnVC
         MZgD0Pd8aRdfOy131GtJjgF/q2qd3iHk5fgGFVUm3Fy6v8c2ynJAWIwuoED0cK24oS6T
         AEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780250933; x=1780855733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igFYe+C9WOBYLpObw2m/zg4GWFSBeVyEOXzH0bhFKC8=;
        b=lf1NFzygkNUt+v3dyX9/GwUbszJmV1foMCZ3jNeAaW+ubOv82KiP6APkxTx/6tpI+u
         0GEDIC6APvquS9fsddasThEiQ1cMVmq8o+Oo9aeI4TwdhYd6yqyR8bFRqOGbHkG1H9yt
         rHQoIKIApRpKsLWamLioyeKxE9blmmpfcRM1RHKW9XsmSmp4iEdh2QhHdTjPEkQbkzWi
         6nhnbYAQ4ppdJtXhbWn8Fb6S5p8mkFlw3SR0oQTUGGFTfADp4F4Oc9F0+dUK2ugEreMR
         ACIjrNy9bPuRwA/qtAd2fqmJDWyoy+R1NXgrgnoS19o1uAUW+JKELId9wn2gbzwrSXWS
         8dFw==
X-Forwarded-Encrypted: i=1; AFNElJ/vMiMBSOw0Inrokucjg3aW55YUysdmmARtC1bzbDxeL7HBLQv/hv+e3Kav1RliQkj1A+j4bAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qZPu/c6+llPhvK3sYNfyHgMaXLNVXUSZpoSKc7YxMDebVj6M
	KenybGui4b7wPuOB4yixdBsksJOFCH+d4kBtk11WeOBD4cQko4tLPETIYhKaZytac96SOf12z4N
	/heS9oewV+s6ebdF/MZI3kEQ/jhpzGe6gctrrDJtq
X-Gm-Gg: Acq92OEVw/0NXzu61jr0X7xK40gj9cqmLBgPTkzdGwYdhxvD4vPD3DajS43Ja2dkXrH
	su0M9FP2mmYwKcs+BPCIMSFhdltxrD/C8ipKM9A0W40Ux9CaTxKNZIIGBr6m0MFjTbz4Rbu4W6d
	FCtx53htsz7Azoqi6D62gwgox2gXZeLw+XLeCwNQmTWVvGikLnnFhWk+7uhojYvK6gjhBOJlVBB
	BHQnpb9wjokBMhdW7CDgUOxf4GX3MDqSjgScG6AoRuyppCXltf3Xh9UC7s/rQyAZc8+LN1UQ476
	no3S6oTwirVcxNCx+dugDo6A4GOFOxlrcGA242QNJzfDQdH3NuMN20m1UrQQvGR8lwpIGTBjmTy
	bYGYEwV/1vAlCkkjVl3/7wfxADahJMX7h9Pr9nA==
X-Received: by 2002:a05:622a:4107:b0:509:1009:e7a6 with SMTP id
 d75a77b69052e-5173a93bd0fmr112626241cf.43.1780250932611; Sun, 31 May 2026
 11:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531124828.2323406-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260531124828.2323406-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 31 May 2026 11:08:41 -0700
X-Gm-Features: AVHnY4Lvjf1C_TM2wnah_-lmgXjYPamVSXQUTpmEplMnYHoO98UurOO7hdKuwdc
Message-ID: <CANn89i+FMBS31D6onh6cpASh7fApp3FfEn8j4YWCfEwDb8C_4g@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: use READ_ONCE() for bindv6only default in inet6_create()
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 5:48=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> inet6_create() copies net->ipv6.sysctl.bindv6only into sk->sk_ipv6only
> without any locking. bindv6only is writable through the IPv6 sysctl
> table via proc_dou8vec_minmax(), and adjacent lockless sysctl reads in
> the same function already use READ_ONCE().
>
> This read is reachable whenever AF_INET6 sockets are created while
> /proc/sys/net/ipv6/bindv6only is being updated. In our QEMU/KCSAN stress
> test on Linux v6.18.21, one actor repeatedly toggled
> /proc/sys/net/ipv6/bindv6only while four concurrent readers repeatedly
> created AF_INET6 stream and datagram sockets and queried IPV6_V6ONLY.
> The writer completed 75313 sysctl updates in 45 seconds, and the readers
> created more than 360000 IPv6 sockets in the same window.
>
> KCSAN reported the following race:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in inet6_create / proc_dou8vec_minmax
>
> write (marked) to 0xffffffffaa27bbcd of 1 bytes by task 95 on cpu 1:
>  proc_dou8vec_minmax+0x206/0x220
>  proc_sys_call_handler+0x21d/0x300
>  proc_sys_write+0xe/0x20
>  vfs_write+0x559/0x6d0
>  ksys_write+0x88/0x110
>  __x64_sys_write+0x3c/0x50
>  x64_sys_call+0x1016/0x2020
>  do_syscall_64+0xb0/0x2c0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffffffffaa27bbcd of 1 bytes by task 97 on cpu 0:
>  inet6_create+0x351/0x700
>  __sock_create+0x149/0x280
>  __sys_socket+0x9f/0x130
>  __x64_sys_socket+0x3b/0x50
>  x64_sys_call+0x1c76/0x2020
>  do_syscall_64+0xb0/0x2c0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x01 -> 0x00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Wrap the bindv6only read in READ_ONCE() to annotate the intentional
> lockless access and match the surrounding per-net sysctl reader
> contract.
>
> This issue was first flagged by our static analysis tool while scanning
> lockless sysctl readers, then manually audited and runtime-reproduced
> with QEMU + KCSAN on Linux v6.18.21.
>
> Build-tested by compiling net/ipv6/af_inet6.o on x86_64 netdev/main.
> Runtime-tested with a QEMU/KCSAN stress test that concurrently toggled
> /proc/sys/net/ipv6/bindv6only and created AF_INET6 sockets.
>
> Fixes: 9fe516ba3fb2 ("inet: move ipv6only in sock_common")

Wrong Fixes: tag, lack of READ_ONCE() was before the patch?

Also Fixes: tags are going to trigger extra work for many stable
teams, for no reason.

> Cc: stable@vger.kernel.org

No need to CC stable for this kind of patch.

> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>

Please cut the verbosity, we do not need to copy/paste fifty lines
just to explain the obvious.

I hope you understand there is no serious bug here, KCSAN is a
debugging feature, not a production one.

One or two lines should be enough, you can take a look at
f062e8e25102324364aada61b8283356235bc3c1 ("ipv6: annotate data-races
in net/ipv6/route.c")
