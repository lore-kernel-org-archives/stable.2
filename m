Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6148B38F
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371358; cv=none; b=nmurcBz+tg7x8IueOlbg66lDjySW8346yQwDkxxW/VJY9T3sNLeDj+L1x3jNg/mT1YAnLgo5SPIbc8GGDhbAoQBFyK3WhNYkDkbjuXtFChKrcYJKSG8wKCO2fRZhoOf8+KpxgSsO7yR+2uvMfYBTY6zz03qt10M02msY774eM6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371358; c=relaxed/simple;
	bh=8DMF6Po5NeZA8sUTTWo7qUUSIMLASB7Oi6OlVRLSVIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAB9NuQYSTrWf+hNEQ7HdDH32EEDDZYyNttw3nMC2STTGzD9ONVuSytZ3GkdrqWkEZaYKFenufTJ/T8d1yhavnEsWFXFxjWi+xBm0bQpZFh3G+LGTR4MEY4kBWpM8bU3Qfy09JBf7FlWsgcnb/ETwUonZvnMYZlwKAbMe0WsHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDWbvclf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDWbvclf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75421F008A0
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371340;
	bh=8DMF6Po5NeZA8sUTTWo7qUUSIMLASB7Oi6OlVRLSVIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KDWbvclfgqqRaRvntjLO8Bl5sSejANcOLLH4Ge87Qj/mQDCUSi6yWPo2isQxTzBW5
	 Yw865/HOmj+BkvHrrmEUy8GWwxKDtzJr4tYc3Uue1ncGUi/OdeHzbwPYj71S0PajKu
	 fW0zuuQvawygbCnFKEnxkzSk+kxzJdRydFZGpQpmzStruWI5AaqJjL+VjfXntmOUVY
	 dsny9ClY3FzKEc2BJ3bwO61oabVQprioKPrShqkzyKEIVB+JTLlPyG7LAMKiRh1q2d
	 5iiJi51FCWu25lz2ntoLnWfdDBzGeRGa75wPhYU5PC8BHEYh+sfxux+1dbepfRXs8X
	 5eDWeYpQcG3KA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49dd13a91d0so1237235fac.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 04:09:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByvNVFy+nkbdL46qvbwC4gvxtg6h8f+LR88EGtgGygmO/LNZjR+ov6qUNJJ3o9knO9cEcCSTGg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKa55+esN2oo7oUUGgU7DvmvFJ3sYTIFuRhHFGJxnbgZN7iqVGt
	oJeD6V1v7o+5w8W3XE/Rogozol2fH0Ep7aNvMcg0fIkntrdgm2x2ZBJGp4hMAkXhF4PT7w38BZ/
	olf5AVYNoF4sLmnlm0vbZX7LbzvGfBK4=
X-Received: by 2002:a05:6870:6127:b0:491:4a20:8ab8 with SMTP id
 586e51a60fabf-4a259504734mr1896973fac.28.1791371339997; Wed, 07 Oct 2026
 04:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005145430.12777c2c@nargothrond> <2026-10-06-1-daily-reply-0020-bnxt-en-vlan-447cbe95@kernel.org>
 <cce34174-a70a-4e59-9c35-fd74309b0fb5@leemhuis.info>
In-Reply-To: <cce34174-a70a-4e59-9c35-fd74309b0fb5@leemhuis.info>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 7 Oct 2026 13:08:48 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqSoLb9kdXwdJHH2P55+9214aRRcP-61tdKBhRTK7z70g@mail.gmail.com>
X-Gm-Features: AclHuK_Mya-mXIp8BY93pJkwUEfPaM34qzfLZGG1BzLxjhDODa9HqPyHdCQr-2k
Message-ID: <CAL4WiiqSoLb9kdXwdJHH2P55+9214aRRcP-61tdKBhRTK7z70g@mail.gmail.com>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Michael Chan <michael.chan@broadcom.com>, Joe Damato <joe@dama.to>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 7 oct. 2026 =C3=A0 12:35, Thorsten Leemhuis
<regressions@leemhuis.info> a =C3=A9crit :
>
> On 10/6/26 23:35, Sasha Levin wrote:
> >> I'm testing the patch on v6.18.55, and it looks good so far. 5 hours a=
nd
> >> counting without any issues.
> >
> > Thanks for the bisect. The root cause is the bnxt_en small-packet paddi=
ng
> > and DMA length bug Eric Dumazet identified, not 447cbe95ebb9 ("vlan: fi=
x
> > skb_under_panic and races when toggling HW VLAN offload") itself, so we
> > will not revert the vlan fix. Once Eric's "bnxt_en: fix DMA mapping len=
gth
> > for padded small packets" lands in mainline, we will backport it to all
> > affected stable trees.
>
> FWIW, better wait a little longer till a fix for another regression
> 447cbe95ebb9 exposed in another driver is fixed, too:
> https://lore.kernel.org/all/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTB=
PgPG7w@mail.gmail.com/
>

Different issue, and already fixed.

https://patchwork.kernel.org/project/netdevbpf/patch/20261007073027.459868-=
1-edumazet@kernel.org/

This different bug fix will not fix the pre-existing bugs in bnxt_en.

> Ciao, Thorsten
>
