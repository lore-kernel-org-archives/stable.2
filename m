Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090531E85C
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781959350; cv=pass; b=D8poLAFaFmWB3UoL+1d6rJqBspuiT5TW59djye+S35DLHdYYiyX03EYMniqqiwhaYQdlQuq4JA3JK+dQvIXInVDRRAvGgI+/7MASxNNmwZXdbUMGpqWZSfpmFmYk1VQiwrLzkLy5bnzADmn8k5weabq3Hi1Mrf4PMk0f8cIz5Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781959350; c=relaxed/simple;
	bh=8UtZkE1qj9b82bRkkkebOs7Sc8Pv9kYTWQxgpMFXeg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSmwJCVomUvDhJuS7BJE1IApdcCUVXHf+ahdrakuc7HNcrxXPbd8KyIh2c+ENgfnLT6F/knB52qGNiDX6Sr5gPrxyoYszZ6vlbTRrzfaPmKG8UHGvbjN+RjKl/drNdLZC0T6qLa4Lxg3TnFK1xMqGCgYWTUlFBhWveng6AHLQjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pashVic6; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pashVic6"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7fe8bc0a01bso27899647b3.1
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 05:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781959348; cv=none;
        d=google.com; s=arc-20240605;
        b=e9xjFOTKSMhMGJlpqKxECIhI1sYWSlohQdzQQhwCHN9+wvPKnX3kb4IvdOJTa9rd6q
         fp24umkVdMpcjjdILIBPAeVo7TTI7Y8RV9fpuxEXt+R+32G2BkbqxME2o37pYVItqGpD
         O6cxW/P5BRSzDxLAKmxPtWm+fPT7Yg4M4HgSLA/t2q4WxqHHwXyY5/3dRkiIoPd1VK0R
         ApsuV1KFuaxcFusR5xU81pNAk9Azii02OluzqbYP84lkASTpQKnvDM2HLy/LxkQBq+N0
         nr2otF5sjo4zD+4KLNEar8WwhE2F0rvnRzov61UwxWfI1B0spOre7mQUjzcaVUFkLDwH
         s58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nEQ2JR83lz7mlI1Yc9K1ICN+Nzlj2YYOxiN77HJg7NI=;
        fh=vSBlLU0TIvIIeyY7e1LEKAf6w3spWWRAG0rD2WT9o6c=;
        b=Xr8AzK1MEVpqpjDTEeBuY7FyoLWMxc38kgF+E3plV1sHADgqY0k2SfDKWfM08QLNk1
         3Frm55Gr8irmYwYJ7Rxei2FZ5kIocE7nl/2wWmVVXZI9qf78BUZ0qoQW5HMV50TrL3xe
         u5hbHvN8vhWX6a531mgyKxi3M3eDzxPrcEhTOWxLt8j2Qxww6vmLHjrsQEwgjpBaaECK
         mUZBrOgxxYsleKD3V4nL/DasKKaM1oBYCOIKB5EqEGJXVcr68pPcNOIF18rJemuhtig7
         OI7/jjECg4klpMaTLswDUkN73m5t9MLhY0mH38ZpzjAxBsTOIQHrBXcr6yfiy1bDYZGb
         HFEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781959348; x=1782564148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEQ2JR83lz7mlI1Yc9K1ICN+Nzlj2YYOxiN77HJg7NI=;
        b=pashVic6hT7ZB6aw46HaL087F6A+EDSpiEmmkDjJ7t71zhdZMovVV6kGqN2Kw5EQ/G
         ejqbfx632yEvzEurEJ0ZkZwlRN2Q7c+nlUZxmESaQM2uo+OHsssMlr9yz9PPd9RAfhWH
         MmqKSmKqaNrtVX4i/AwMk/LjGBbsJJS41cusxrttjeDSyaLY120RLSz26cmzu5qzIPEI
         R3kP6pdm02e4znL/Shvs39TJFFpPMGh/gkUbFNhCQb+bQ29wonVaI8WfIAu63wKjfrLd
         BPsE3wjqz8zleKARu+ddFkMpRNi70fiKJJLU4uBq8VPZyjRqBUvy4559bKXGM1b3nOgz
         JzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781959348; x=1782564148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nEQ2JR83lz7mlI1Yc9K1ICN+Nzlj2YYOxiN77HJg7NI=;
        b=RZnwzyqpvsZPvzMCYokmVVnq2V4TrhvmNL1nE33+P/gHoim+V6ejW7WrSjIXkkm4Pk
         Ht5jiLvCp3hyyLTuhHm+zwvmXmWL/p6ZKEOXPu/68C2+jfjjkwfnSgR19t7XsJit8zTD
         sC2RnSzuaGxM9M5CdJOnuoErEeV8paGbTFXL93OACdlN0fLiz+2RpiNxR1gRR4iq5/Ve
         AwLHTPlVFi4PFM3coVQ1Gx9Q5MbfKTFl60jjeCxyi48mQ511P2UrkF3kQHGMgzUNhMFk
         SZIe1vssF0336u1Bzu+6Ig01YNlM4YgsZsdpYStzgjnHz4FxOLVEBCm9z9wPNmesSwEt
         9pyA==
X-Forwarded-Encrypted: i=1; AHgh+RrBw8FaJD2+OEimY/5A5OCtynJY+uvuIjzgFdHrYwzMrV4Qi106PB5l/CJpSnx5w243eeDizkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5ai9EKBGAi3U8WfX+27Cq41HFEJaC+WQzG9MBc24VT79soQk
	TRxpmsWoHjKac1GQB8sXzUwSBo6Yd81pf1z8q9uPeynYNOR2A+KakbrF80KLChiE94PY+SEEFTJ
	lfgu87yrc3a3cJRrFbzLZqGamsCZr1e5HV7z9
X-Gm-Gg: AfdE7clCoI3wJQ638X7We+ib+0Eg43ZlqLck5kHAtrSeQqJSXiFu6gotyhAo/Y1XeJq
	NEVo6LyxE7qEZ0Ldf5tVxrLq8wVmYji129SHR+b+zjg7htSUHGb8Mp9efDZt8GK0EwYS8ifzqgY
	J2BNSfTamtKUZkU/LG4ISBOzs5GAKxrpWZBHmrk0BGgas1rpQYYMwYfRAEm1pQuQz9az9MoMHlk
	OUevQjMVRgrvysrKBTUr6BMrmaeQnj2mnZXoPy5jMrz+hIbcBD8Sp7Nkn4bYHrV6C/DbbZ8VE+L
	8MCskDI=
X-Received: by 2002:a05:690c:4984:b0:7fe:200f:e7e0 with SMTP id
 00721157ae682-80138141211mr81116397b3.36.1781959348280; Sat, 20 Jun 2026
 05:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>
 <2026061625-starless-mascot-691a@gregkh> <CAFAa3YBciYSJxDT-SH=4oppyBS3hWUSEwJP_86EgUriJfYkjLw@mail.gmail.com>
 <2026062048-posted-scarf-dcf2@gregkh> <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
 <2026062051-doorframe-crayon-d390@gregkh>
In-Reply-To: <2026062051-doorframe-crayon-d390@gregkh>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Sat, 20 Jun 2026 14:42:17 +0200
X-Gm-Features: AVVi8CeqdpNwGHrorykGXuC3-bncaCfxQ5vPqHg_WEnzQVSupw-FCxTEi87GX2E
Message-ID: <CAFAa3YCJXV9uW==2776dbfNFH4PhBPUYnTxDJ2xs7kn0b=4UTA@mail.gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
To: gregkh@linuxfoundation.org
Cc: kuba@kernel.org, stable@vger.kernel.org, linux-hams@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks, much appreciated.

Short answer: yes, the same series applies to 6.18.y, and the same bugs
exist in the older trees too -- but only 7.0.y and 6.18.y take the series
as-is. ROSE was removed in 7.1, so every stable line up to and including
7.0.y still carries this code and is affected.

I just test-applied this exact mbox with "git am" against the current
ROSE files of each tree:

v7.0.13 : clean, 15/15 (what I sent you)
linux-6.18.y : clean, 15/15, no conflicts -- the teardown code is
identical to 7.0.13
linux-6.12.y : applies up to patch 3, then conflicts in
rose_loopback.c (the loopback/timer code predates one
of the refactors the series builds on)
linux-6.6.y / 6.1.y / 5.15.y : same, conflict at the same patch

So for 6.18.y I can send an identical batch right away. For 6.12.y and
the older LTS lines the fixes are still needed, but they need a rebased
backport rather than a straight cherry-pick; I'm happy to prepare those
per-tree once the format is settled.

My suggestion, matching what you said: let's land this 7.0.y batch first
to work out the workflow. As soon as it's in I'll send the (identical)
6.18.y batch, and then the rebased older-tree batches one line at a time.
Whatever order is easiest on your side works for me.

Thanks again,
Bernard, F6BVP


Le sam. 20 juin 2026 =C3=A0 12:52, Greg KH <gregkh@linuxfoundation.org> a =
=C3=A9crit :
>
> On Sat, Jun 20, 2026 at 12:37:16PM +0200, Bernard Pidoux wrote:
> > Hi Greg, all,
> >
> > Sorry about that -- my mail client dropped the list and Jakub from the
> > recipients on the previous message; I did not intend to take it off-lis=
t.
> > Resending the same note to everyone, with the mbox attached again.
> >
> > I have prepared a first set, attached as an mbox: 15 ROSE fixes for the
> > 7.0.y stable tree (7.0.y is the last stable line that still ships ROSE,
> > since it was removed in 7.1). They are the use-after-free, refcount and
> > teardown-race fixes I developed and merged in the linux-netdev/mod-orph=
an
> > tree, where ROSE now lives.
> >
> > As Greg asked, every patch carries a
> >
> > (cherry picked from commit <id>)
> >
> > trailer pointing at the exact git id in mod-orphan it was taken from, s=
o
> > they can be tracked across releases.
> >
> > The whole series applies cleanly with "git am" on top of v7.0.13 (no
> > conflicts, no fuzz). The 15 fixes form one coherent set -- the three
> > core UAF fixes build on the earlier refactors in the same series, so th=
ey
> > cannot be cherry-picked in isolation; this is why I send the full set a=
s
> > the first batch.
> >
> > Please let me know if you would prefer a different format (individual
> > mails via git send-email, extra trailers, etc.) and I will adjust. I am
> > happy to follow up once this batch has gone through.
>
> Great, does this series also apply to 6.18.y and/or any older trees?  Or
> should I just worry about this branch for now while we work out the
> workflow?
>
> And at first glance, this looks great.  I'll try to apply these on
> Monday and let you know how it goes.
>
> thanks,
>
> greg k-h
