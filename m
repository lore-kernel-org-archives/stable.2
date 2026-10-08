Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51914F7CD6
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493433; cv=pass; b=tH182BKulnGRjQxLM0/KIhJj/mAZbKmK1zZ+r+PuQeF3wPHikHllWcVFl5OOc95D1R3cu2XKKwxMN64ES4sXFq9O1U2aiuxnYr2UseadTVZnZPxhnrFw3B+0EDNmhTEL7gYOzG1vlQhmnpBdxSgx2HwjaRzmue9n+ro31mbs1rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493433; c=relaxed/simple;
	bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikomK0MYjcKUm0i8Jx3T71b3VurCEGn9xQjNATC7a7eoFJunE8Vj/D5TrBePixQcvj3OKRXIDqVVcPHoTEnZEBn4ZGGftFlFyjncBCdzSwDxvnQ7qFr1G9BnzALVA5Oytu/4Ghy2hTJO08QQW9111LuM/eSSqJ8/v6Io8jWpvqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXb/7leP; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXb/7leP"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6711f05fb14so3812950d50.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791493425; cv=none;
        d=google.com; s=arc-20260327;
        b=fGOysnaxZMt5jOXfuuZg1RShoZX6EhprhEJqbLZFjVVE4yfuwKdvgogl1ACgif0OYR
         RyfDoCUWRn2AthUTTJIB/4htms2BSsZnclwUsu+PjeASkLxWGTknF3YUwwI8z7cBMSYk
         mFkXWbptmVWZ5sBJHwdt5u0PawicCH1XqlrV/Lc3KquPUXbZ8WMCEhGQXSWiBCLNaZRB
         vIJI64ajS6HEyan/v15J3t/gRkQP2OdlrAjBLHHCEIRuxWWFxBr6GMyoTmFgMuJcgyon
         XqLhVanc2XT2U14t/Rs8LtEjtD5smRICQINb0Mw+R7wPrHHeQ/jpw3gOgNVGCBxfaZfm
         GglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        fh=ezPvSe7FFGNPny2QheL9Ij7ntOpGCr295MNnS3ND4cY=;
        b=Th+XgH2gi+CqDkSNvskAAPXlHxcermv+CclrPzDdVWJoW2UhiXG5QkqSSoR+0t2sJv
         Vfowy2B4B8rJA5kz6ll91Q6jqUPFRuOiPck4GcZbmyiRlhl0IQ3vzodtFuMgO/AXEgJ7
         i2wiy2bcqBI9rTga9T5nRj+NDy274x0EJwzFqLOB1gpFjhzGEI4uHYaZIvwqwbwviGm/
         q1zeCGD41aascbnfDo7yop/cYieuBie8eNX4RtbkiB9t9vwWzxSCIMc/pnp8vFZbCUJg
         tqF+F8FBFVolzzdrxNijQuLL5PAphVsYOhuiqg485YwFqCxN0/ZDfStib8kQF1mwiB0X
         1RqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493425; x=1792098225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        b=UXb/7leP6TGNYUifCSK0ZJavuFWdrwXthwZiI6/dWlDhkOz4RHlfPFOujRweRjd/ks
         OiWVTAmZK3nO0GggLSZfwN8B2gWdsKQnsSA10Ke8dGWQcFCYicp3IP29KG+cTVlhft1w
         MqB6+615PiU0qCOGJw3Q6YbiFMFan84RlyjV7Yza1ad85M2NkQJjvLH25YMwb4W7MkWm
         YhFIrndChRBySsVyrWboOrEPjUSAZ5+X4aSujD0WUKIkNPX7+GH6Z6rbyigdR49T1uSW
         qp6t7DKOC3r4nvc8GB5W9LGamVawPCFTigLsreM+nINugjPbXlzsMQ41BFDXrMOH6PHD
         SCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493425; x=1792098225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        b=oTVBCQNY5tnSnOKD7pBvA2PIgC6H0P7M+bzNgxhkEbxbU/LnzoEDZBhR4qxQuDSphx
         X56sfpcH1z407uCMDMrA2+CM1R+gyU4sN34KbleF8Y8odSjFKAgYBentvK8AM8Fqvncr
         /2RPFjBICCos606pBsb8BayXegs5Fd8ykVH4XBcHwx8UE6IWpSzH4vZAr4KNsA2PJeV5
         yPVLV5glSw6jk84gb1XKKZCLAFSt65Y57yzUiF223fvStqQuvjmNObQWdzIdNvMHqw/C
         0UBqgVLRZTZZenkzHBtAS/uMScyfJkMj2PU8ZICc9hbgWzMicBnIzBMULlKpfh3t2Z+l
         8QuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxApvDsatUgCtBfIcR2VKQzUgeTCQiLK89pQFTpkhcJ70zGcpcfz/WD4p8PlhC+ONZknDMERKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuaC5QAXMOWYjzTXOBvcWbL2XMS93Tf2MqixLludcTGMa4OCQz
	JC3PAewH+fBL5URAChVM3ciW2SIDARzSEOUtGf58PbSQACachxkVqkn5wJ7Sf9q2Ex8yE2oqvWh
	KjINLmpLIsQ0Rj1V88u3CIZuJRIbvmhk=
X-Gm-Gg: AYBFou1EMY9c5Z8CcJ2x2Q1jGy/aDzElAXRyszRzDYYluwV1RMzCfRY01nsN0wpZB1O
	32I2ljKTU/3qfKe1YOxSu5Bsx+nKpNNOO3bDnp9Ur4hK6T5ryWk49Zc/kYq1gyv8Wl3SY49I6Y2
	gpavdRD4kw2wb2MEePq0cSrPI4Jr8Kqe0Spzp5HgBzoHWQW4knLaJORvG6XTSmpN0WYbUhriEdW
	isorloyilYEvFdutb9Tvo1ZhF7ZD3JIdCFmfrpCtMnC8gTO1PWyXBknEkvJNbPVLs5KxUTJHzLl
	GG7M09GPu1w5J9zpPgo1lTpxQjhpOfNiLVkNSv8+O9BOejhaY8IY3p0wyUmL1+RXkWz/L2excst
	2+oJUM9Y9GoG9QoijwI8JyKyzymOeximLr80PEM0CdBWyeK3lA6Ca
X-Received: by 2002:a05:690e:11cd:b0:674:1e05:9b81 with SMTP id
 956f58d0204a3-6793628e483mr25302d50.91.1791493425421; Thu, 08 Oct 2026
 14:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <willemdebruijn.kernel.cf8fec88827c@gmail.com>
 <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
In-Reply-To: <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 8 Oct 2026 17:03:06 -0400
X-Gm-Features: AclHuK_qKmc6ZKE8_x2MdYae4trfNS2WogXUatNfjY-lv9_2jJsmiBMEjOiQbLM
Message-ID: <CAF=yD-LO0u5z8SU_Aktu0-0aeM-1UknYsGc+rCpD3y9bpwxtwg@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:58=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
>
> Hi Willem,
>
> On Thu, Oct 8, 2026 at 8:37=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > Jason A. Donenfeld wrote:
> > > The kernel's various networking applications keep churning away after
> > > userspace is frozen during hibernation, even as a memory snapshot is
> > > being made. This can lead many network applications to an inconsisten=
t
> > > state, replaying packets and cryptographic state changes. For example=
,
> > > on wireguard, there's the possibility of this sequence:
> > >
> > > 1) hibernating begins
> > > 2) handshake state cleared
> > > 3) keypairs cleared
> > > 4) new handshake round trip completes
> > > 5) machine memory is snapshotted
> > > 6) packet is sent using new keypair
> > > 7) machine is restored to state (5)
> > > 8) packet is sent using new keypair
> > >
> > > The idea is to prevent (6) from happening, especially if (6) and (8)
> > > contain different data, but the same key and nonce. Presumably the sa=
me
> > > issue applies to other users of udp_tunnel too.
> > >
> > > Fix this by just dropping sending and receiving packets during the
> > > hibernation sequence.
> >
> > A few high level questions:
> >
> > If the issue is reuse of key + nonce during send, why include receive
> > side functions? Specifically tunnel (encap_rcv) functions.
>
> Because I suppose (4) probably shouldn't be possible after (1). I
> explicitly clear the result of (4) in a PM notifier. It seems wrong
> for that to then be violated after. Similarly, userspace doesn't get
> packets after that point either.

Since this is an issue specific with security protocols and reuse of
their state across freeze and restore, is that the more suitable
location for this check? Drop transmit of packets with that risk
(unique for that connection nonce) only, if freezing.

> > Is this a problem specific to UDP tunnels?
>
> The stateless nature makes it more poignant there.

udp_queue_rcv_one_skb is the UDP hot path. Since it touches all
packets, the last resort for adding checks that are relevant too only
a small subset of packets.
