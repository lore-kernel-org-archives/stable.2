Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54D3AFB18
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489511; cv=none; b=DoOWBT3Um/6OsnKIUH+IOz/XU41hpuDl5k1kiyZykPsc5iafdcZoUccTcgQycaQHsRPA9GMJ+GzZrZcJ8sEB3xw7mhDyuCaJFhOpP4yXRhTQwh6Y8Bqq8ZMG243mY5WO01vgYZcnB2edyFMqB9ISV/341d/gcikBjUY+pGHXZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489511; c=relaxed/simple;
	bh=hcwMIGp/ItvbKuWskirhr0jAfYMcYkEhubcSn70VxP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKsvhU8wCpW9yZFkd+TyTRTaOvhC8QA3HltEPnM3Qli6hGMASifAptlExcLlDYAv7hv2mQZOBiwS41lYeaSmkMTw355na21T0XKg+oKxEfPYJhXOvBnsA7zVRPqlgVVhfZ0wEPydV+tTdEtrbDMDMaKX0ZGG6WeKS0W6NC9kIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KwGVfiVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KwGVfiVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A10C1F000FF
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=KwGVfiVv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791489506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcwMIGp/ItvbKuWskirhr0jAfYMcYkEhubcSn70VxP4=;
	b=KwGVfiVvifEggmNf9VWhZOs74YhBrzF34BT+FpWZJT4aBSOaI2YAJBiD3Tbu7W7+QEZuZ4
	dbli0Bxe7ntSfYyGxJoqUIIB/wkyGOVBT46y/SkZXy0HabWoNgV3o9FdzRQRTcJDNktPgo
	E+ITcunDDeyxpVGt9v6vx9hns2RR81o=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 52066722 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Thu, 8 Oct 2026 19:58:26 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2055573c8cso463950766b.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:58:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzSZB3WPhB/fayRhZyodZ3ghIChipXgdCNKwIq/aUHgTIMjZQzWSesO4+Syxe7Xmx/2gX3dioc=@vger.kernel.org
X-Gm-Message-State: AFuF++m/nuJiYEWYKVmEZ14zyigLx6kvtmDbynH8PqxEDf4KhYzuQBNR
	NTxfTQR5OhLAiY/JmzxCcjn6yj2KlzShasHK3R1gIDSk1/RfroNKD1KoshwrB7lzpLxAd3BQ3A2
	/ai4a54T4K3s1HQysASpAiaeuWTefDa4=
X-Received: by 2002:a17:907:d516:b0:c2a:cf73:63fe with SMTP id
 a640c23a62f3a-c317bb4a7aemr611808266b.6.1791489504577; Thu, 08 Oct 2026
 12:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <willemdebruijn.kernel.cf8fec88827c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.cf8fec88827c@gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 8 Oct 2026 21:58:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
X-Gm-Features: AclHuK-nMRR4vDW6p8Uf5Up3EywswkHru31OUDV8tShUhR4s3Srh0YZqfW9UwsA
Message-ID: <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Thu, Oct 8, 2026 at 8:37=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Jason A. Donenfeld wrote:
> > The kernel's various networking applications keep churning away after
> > userspace is frozen during hibernation, even as a memory snapshot is
> > being made. This can lead many network applications to an inconsistent
> > state, replaying packets and cryptographic state changes. For example,
> > on wireguard, there's the possibility of this sequence:
> >
> > 1) hibernating begins
> > 2) handshake state cleared
> > 3) keypairs cleared
> > 4) new handshake round trip completes
> > 5) machine memory is snapshotted
> > 6) packet is sent using new keypair
> > 7) machine is restored to state (5)
> > 8) packet is sent using new keypair
> >
> > The idea is to prevent (6) from happening, especially if (6) and (8)
> > contain different data, but the same key and nonce. Presumably the same
> > issue applies to other users of udp_tunnel too.
> >
> > Fix this by just dropping sending and receiving packets during the
> > hibernation sequence.
>
> A few high level questions:
>
> If the issue is reuse of key + nonce during send, why include receive
> side functions? Specifically tunnel (encap_rcv) functions.

Because I suppose (4) probably shouldn't be possible after (1). I
explicitly clear the result of (4) in a PM notifier. It seems wrong
for that to then be violated after. Similarly, userspace doesn't get
packets after that point either.

> Is this a problem specific to UDP tunnels?

The stateless nature makes it more poignant there.
