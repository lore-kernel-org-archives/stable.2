Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793296283;
	b=vnei8m5SFiw4INSmUGotpmiTIdt593Le534Poc6kiWjPXFbja3hUuVRriol5S+trels5
	 nOx19EP5D7Am07G5quz6VfsEr6VaUE8KQnRliLNxcwhOePKjH6vjoU2KSiE3016cBdNsV
	 MCRVHTtaS60KSEfZ1fTWFO0Sj6xkfL3jcpactKIlXecmtJzHIHcE6UkI2SABXDEd+S8qr
	 8a3RMat6Gd3QOwTN9AHkjyyYTnxjwuaQDQS5M2m7vGTtKZGb12bBuVIwOqS9TFOxp3U1J
	 etArtpYA2mb1kiVuL4hMct869JSiZQSXKxTIf8EScetJcpPWVEKdGSZwz+QYV7oLlwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
	b=fAeq/0+B48hl4+bLg3mj7pJzWwdMaXA491gOBwlhA9OASFi47mr9fqjj59TlclmaOQHb
	 HQYO6pR8sdTkNvwMA3emz3yXZCOmJz7o6SbgroAhldrY3OAv3NL0Vo8BVyD1pXIxXTKYf
	 W5phbg8wdOjnp9X1H0AZl7ZKjF46rhDbmdm0CrJk0fBfOR/VR2BPZIjtmIBD4WuqAj5HF
	 CPB4gybdpGK2DrPNk5XiB9buBLXLTGSp/hAKq8VAd2TPv2sePU40FgcW7OxorAbeG5veB
	 NTDAtkjz2StvaL+aDQeDYBgM3hf2qsyX0X1Y1gPNpY0ys72b/UaAdQAM7UVomsP0HRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsUMIjZr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEE606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FDEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsUMIjZr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so19296335e9.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793296282; cv=none;
        d=google.com; s=arc-20260327;
        b=rjALRDbeVxKj3M9MLv2XPhwO6JoIoYfQ5wSjPja3463cpcRQDiVYptdQMxMhu09gJT
         QYLU77JJgu0OiWP4N1OBn7HBIqTeU0FHz3F+m704Rhu3i1yBe+i4nTS7dFRB3/toS9h0
         bXZC2pDi60gfZVmM1yjx/ZBjOOVtdtSfy/rVyAcmXXIISYi2ZIjEtjjaW3dtyosxIyOC
         671Zc/dMuPYsaVitZyzWhMU5eVmdSZXuPiX9HXNMDOtVS/wx+DDTZcOhThDPdpcoDre7
         4G78RhNZl/pC5O6Jm55QpiO/2Bt/THOSN5Itm7neNWT+bhtwVxH95fzOJHYrHph5niZL
         EQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
        fh=f5m0zK75eTl4baubv0utkaDtZ2s9erelpFA6Gd84eyo=;
        b=YBLrtgi6eGGx9qPgVz0do4OaKV19cEaBB8tVTMYxz8ydPj5Lc3Bptsyi61dYZuX9ve
         MjjS+QppdFacyUU8+rGlErINA91eEH/x61F8a3t7AP56tR9Q/G9AEl0XkgMptVh8qkPz
         yaO4p36r9EYMbMQtzi7Hd6oWVClzPf+D1tf8llFyJmtO9I04iU4TSsT4pf3hJqzAH20f
         ilVmd+zDlGPlh0I0qrgVqBuE36GBrLXTPs7cMDEw6JJ4PDXaZDCa8H/cU7l+1m0HEzef
         WByryDdYZ6JbdefHYqIAbbdR4vCsr1SKlRSrDdJ/XG87mgTwcw2MPHy4P40U5m6r2b+l
         jLmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793296282; x=1793901082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
        b=dsUMIjZrl7C+D72ks+mMd6uVvuKH6tmCREMXGG111TaB7HyXv6AQbiQNUFzIwXinn2
         DGAjeSUGTzceE2KWNIs7Xk2nGxv+fXrGAurSgVGDmYbLbguOJyh8mqVh5Fx3qQ8qxbiv
         4e0tqMrrQFcmAcys65CZKuOSnnwH8V2nAAQ3p27d+dHoFzbSSN2e3M/u7FYQJRqQACK/
         TSxHvs4CtD81JhMWF2+xQJ4oYZ9z1zgx41kQSCh3DYyhhlrCEPtaBEs3dBHrPl2HF/mQ
         kpw4/IbPYVK4bydt0cFFlc81eBiRmR49ngFCQAJHw2gakaZm7YpZ+L6AQCDKKRF0+s6S
         TVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296282; x=1793901082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yz5ABXPNYwfCJWPGT7FU0b1CFUvEbyvO334M8WGBcc=;
        b=tZld0zuxYLXKz7ioskkJvaekfUe+D5WkQ/WgHXCOap+/Hdbw0zAGxiNesXfdMHO9Fo
         KuqhNzHq7gdgV7Pt7UQpZFkPoa0Q4RdctDUVXJwhpSByMILZMPNSn9ESosurbvWwTwhz
         NQwusTLzxNDqOAJsYRIkA9tWjgQ8QP6JJZ8soA/OzzfoZ8pg6EEKv8ozs6u15uC0cuHn
         ZppdHBDiebZvNlIMdkQMcnMn/yeuxtdV0jJwQVNDoEUxFPb4IQB1TrOAUb3Kchn/oqPB
         8aj8qd/bf4CHdDaFYXF/DQ5IVBNQjrThOXm13H1myGWEYWzqwv+go/3wJcRHZRTFKW7Y
         9fRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUGU2E5iwpmFmg+VLSEktvqpUdElZLKU+pQpltswy84+BbQGAKqehWEJl5rvcNyO+mGkB3Yzg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkDdvffGKTh7lQGoPHlKCwLl+P/Tn40egvP+wCE3iye8y5lKGe
	bcYCxnwqsn4DPmkb7Yimb6e3H6Pd14mJ98gQVFE/UhXDixlnrJAu6Z4JYC2mBRdlq1Z+VWi6u0W
	znTEkBpZFBb+sFhs0018Y9mA5gQKFM9E=
X-Gm-Gg: AYBFou36PjADCiDhbLGSsYVr47zgbqPDaNJmdtvAqeBeE+pKIPm2MPn173WuOCEsz/F
	i2BcyF/ycJQsobAbapIisinuvU0ExiV5inxM3JhneDS/8CEg4J3NG74xK97PFxjUJlZOcPJSXRt
	JNyohZUWN7FQw95cLU1sZsZEcx5vpCdP0cvj5ux5QCFeHfHJbJ0igajsc9vIwr0z8sg62oh6lqS
	DGNpQYqvbc0jgaEUvRMclAOYSfeVohLxzsdbCci1YTMNHnvn7GswafsfikKZA4d+vqd1PV6VdSp
	mLbGRS5Da8x60QFPsm5mXRTKoqhmL7ppdJTxXpwfj4Nk2D5ZZaeaZ8C3pI1JIGJeO7y5ztGy1P2
	A2eyq+FSnaIEaQNDCQvWddbERCoGfqIXRvx2yELNC+9RLGc4TLtFMzN7dcD80+U9GjMzfBhECQQ
	+uJm9X6NzyqQkvyRHE
X-Received: by 2002:a05:600c:46cd:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4a96695ec9cmr127938455e9.15.1793296281562; Thu, 29 Oct 2026
 10:51:21 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
 <willemdebruijn.kernel.26e1d6a9b487@gmail.com>
In-Reply-To: <willemdebruijn.kernel.26e1d6a9b487@gmail.com>
From: Ahmad AG <ahmadag1001@gmail.com>
Date: Thu, 29 Oct 2026 20:51:09 +0300
X-Gm-Features: AclHuK_BDFig-sbWsCR5OlIR4qFenHDi679NHRbcj2yJJ_-aS7hAWsW_5ci89gg
Message-ID: <CAASqGyYuJCObsoPsifvbksJqjtyx4sPZKNzCb4eo8HG_CjW+=A@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: charge fanout groups to the memory cgroup
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. I will scan all allocations in net/packet/ and send a v2
covering them in one patch, using a mail setup that keeps the patch
intact.

On Thu, Oct 29, 2026 at 7:10=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Ahmad AG wrote:
> > fanout_add() allocates a new group with room for max_num_members
> > socket pointers. Since commit 9c661b0b8544 ("net/packet: make
> > packet_fanout.arr size configurable up to 64K") that is up to 64K
> > pointers, 512 KB per group, from a single PACKET_FANOUT setsockopt().
> > The allocation uses GFP_KERNEL, so it is not charged to the caller's
> > memory cgroup.
> >
> > Each packet socket can create its own group, so a process with
> > CAP_NET_RAW in its own user and network namespace holds about 512 KB
> > of kernel memory per open socket that its memory cgroup never sees.
> > In a cgroup with memory.max set to 16M, 256 sockets each creating a
> > group with max_num_members =3D 65536 took 264 MB of system memory while
> > memory.current grew by 380 KB.
> >
> > Allocate the group with GFP_KERNEL_ACCOUNT, as other allocations a
>
> This is not the only such allocation in packet sockets that does not
> account. If addressing that, probably scan all such allocations and
> update them in one go.
>
> > user can make on demand in the networking stack already do. With the
> > change the same test in the 16M cgroup is stopped by the cgroup's OOM
> > killer, and with memory.max at 512M the 256 groups charge 262656 KB
> > for 264640 KB of system memory used.
> >
> > The missing charge was found by code inspection of net/packet/ with
> > the help of an LLM and then triggered with a small test program that
> > creates the sockets and groups and reads memory.current; the numbers
> > above are from that run. Tested in a QEMU/KVM guest on this tree
> > (x86_64_defconfig plus kvm_guest.config, KASAN, MEMCG, PACKET),
> > running the test as uid 1000 in a cgroup v2 memory cgroup.
> > tools/testing/selftests/net/psock_fanout passes before and after.
> >
> > Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size
> > configurable up to 64K")
>
> Your email client corrupted the patch.
>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude Code
> > Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> > ---
> >  net/packet/af_packet.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 823e0911c91..406397acc5c 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct
> > fanout_args *args)
> >   /* legacy PACKET_FANOUT_MAX */
> >   args->max_num_members =3D 256;
> >   err =3D -ENOMEM;
> > - match =3D kvzalloc_flex(*match, arr, args->max_num_members);
> > + match =3D kvzalloc_flex(*match, arr, args->max_num_members,
> > +      GFP_KERNEL_ACCOUNT);
> >   if (!match)
> >   goto out;
> >   write_pnet(&match->net, sock_net(sk));
> >
> > base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> > --
> > 2.43.0
>
>
