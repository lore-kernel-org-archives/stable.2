Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B1393DDC
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791668982; cv=none; b=jaRPgIaCAApLsEB3rruaaYb1p8OnQMU+JXlpwsSACWDTxR1ujOkVQtLV2B0Amv5p7w6YapMv8AMjDJQ3gQ1oRhu51oPfGpnCme+V0FBi8V2qur4hTeukZktqF1tcCkwXcU6RMH6Axp8XQGEAwT3empfUh20p0FhwbeMXB5aucI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791668982; c=relaxed/simple;
	bh=mYPCzofDCpgtxceQtfXryk9Cux3NxRM+a2WQZrwpm2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCq++lra+I/rPCEq2/BBWfu2lABdc/TzNYOGd5ZbRMPQO9IloCP0ywLaTRlbiGdCIErgPrkFioc3d7cG+ExnE4aqowpfFN05Zucr+v61nBE2oKJwG8znRN5cev5d/cknxXefffexTaJ23+EB/YAZLeaVGFq7voYJrL790gWeuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oDSTd+aV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oDSTd+aV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7AE1F00893
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:49:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=oDSTd+aV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791668976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYPCzofDCpgtxceQtfXryk9Cux3NxRM+a2WQZrwpm2E=;
	b=oDSTd+aViTpLUb/P1zEp11qJ5KKmpcX7E3Ck712HOJCL9vw7+RIqUPMVtj9/DFRRNKcSPl
	ZiZXzl9jrndsHBijZSLf6RVjVJ1UgLVA4CzM0orumxoR6EmTxdCNc1QYbBxQ5tGliPreEj
	LOdR2guDr2IRNWMPkcDU9fgvcdkHK68=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 07580033 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Sat, 10 Oct 2026 21:49:35 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2a4e013a44so120746966b.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:49:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzEJi+YXmS/duBzA8pjjP2D7oxM9pnBjMusExtX3/3XCTi/GC2TGHaYpdZZvJqL84irgkfbtwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyO+Ahf1q9c49VsUeTa14BbJ5rNbLT5rfo9wzFw6GYzIUFUkb7
	d3LyeTvx8bWAMC/DljwIsNW9RZNsP4MCpT2Orn0FLbvhJmR/vgMwdH81uEwoTFdy2ZA2CPdFSHL
	jObHVKC4+vf8B/yozH4rkEvlxSCTPXRc=
X-Received: by 2002:a17:907:3da7:b0:c26:2fc8:4e91 with SMTP id
 a640c23a62f3a-c31a9d579d8mr556961366b.29.1791668973776; Sat, 10 Oct 2026
 14:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <willemdebruijn.kernel.cf8fec88827c@gmail.com>
 <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com> <CAF=yD-LO0u5z8SU_Aktu0-0aeM-1UknYsGc+rCpD3y9bpwxtwg@mail.gmail.com>
In-Reply-To: <CAF=yD-LO0u5z8SU_Aktu0-0aeM-1UknYsGc+rCpD3y9bpwxtwg@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 10 Oct 2026 23:49:22 +0200
X-Gmail-Original-Message-ID: <CAHmME9rW6Pav4vLdHbvvuf65v-+gtoHpDagFpmqrHYnkTKKNuw@mail.gmail.com>
X-Gm-Features: AclHuK9CRF4lh5BWYFipjlI2xY5sQemDdJpeewYr0OLBqLIX0DUXGveQsSqp81w
Message-ID: <CAHmME9rW6Pav4vLdHbvvuf65v-+gtoHpDagFpmqrHYnkTKKNuw@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 11:03=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Since this is an issue specific with security protocols and reuse of
> their state across freeze and restore, is that the more suitable
> location for this check? Drop transmit of packets with that risk
> (unique for that connection nonce) only, if freezing.

I was thinking this is a pretty common problem to UDP apps in general,
and it's confusing to have these sorts of replays due to hibernation
that userspace doesn't have. It's an odd problem to expect every
in-kernel user to fix independently, so maybe it'd be more clever to
do this all in one place. I can put it in only wireguard, instead, if
you feel really strongly about it. But I was thinking this just seemed
like an odd behavior difference that could be easily fixed for
everyone.

> udp_queue_rcv_one_skb is the UDP hot path. Since it touches all
> packets, the last resort for adding checks that are relevant too only
> a small subset of packets.

Is there another way you'd suggest doing this? Some other trick for
disabling the socket? I also am not keen on adding branches to hot
paths.

Jason
