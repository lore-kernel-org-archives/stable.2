Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B57443A92
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425059; cv=pass; b=sGT8+ft9L3UorJjPdFTn512sr+Lt4zxIe09T5EjiFqOo3XzUedBp2CIlpkR0T23p1tcDUX1RzScdDIo1R39xd/uJjX0OrHulSsBLtnwty12MWXapXofP76ZumDdONZBs3AacEvuxgpEwtzXOvPGEXTAJeXkqPeEUqHJ4jDNPqjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425059; c=relaxed/simple;
	bh=tUBWZEE0UPCaWKo8LJPkqHUWkxZIfrQc0/kpQhE7eMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3UCRbYV0j8gTpQgNs8Lo0JKPSEbactWA1HIW2Hv103/bvYIDISIt9gTlREV05esgQJuDCWf75q5oHpWUgjVib9lTUrWjIEo4e5V8k7/HuapV6RvDbDgAw9eFjBfUnAGWABolbyySRHLffXKiy8BBv5tDm/c3fIk2qvXenhZRJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2YAiqf5; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2YAiqf5"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dd1cc8dc8so1137a91.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785425058; cv=none;
        d=google.com; s=arc-20260327;
        b=HQJJUk0QUGdICsZYWZ5w+76FgRle7vVsfew9OURgHyLMU5kYc6fpJF2+nh7ePm8Avj
         CgAmQuCcfFTCKgxXE9b+Rppch7uLTNhlJ/jv5K6H8TeucvZcmfVIxiHexdOoYabmx3co
         /5B8fwn3TGdCx1zZCDV9kaTTl/TU539VhhnVYrOo9cNHqWtC1WzLnu98CLsYfomS/Lth
         lw7gntE+djopaIw5gtkL1TON4jFBsBDBUs3Jj2EBkANRSxIdtmx7U4ubCGjWxm3wVv0n
         MKo/gOT1XTfTXGJS9LWaAu9jCxn95H/6djJMBoUmSo6KkrGUv5yUBDv3s7+Q/pO/z7cf
         gwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3UrDhJjnc0lrm1ID1paCGtTzIL7+88JidvPsft3RnzA=;
        fh=eIlbWNK/PuvaMO4PHld+qGdSkeADxlTiu4I9dDX64dg=;
        b=lDRHVC7XIYx7tBEJ1nMs15d5rGzjzkTqqQvPGxOP2UU6QvTf542t0dxm3KfaLyY3m6
         XhScNQOOqSpUpf3ICFJaD0zvNK2Ixgg5llTgHLiKBWuWjJRKe/MQzf9ao9E1Q5lskQNm
         626pq6xJ0KeFSK/IT7KBP7SJMF1G/VKdGjEmau8t6p9dZc5S3hQkLYqy8M8C7P1TwrQR
         VM6PVtg3gSTx/I3Y02dqGU21sI/lBIcM5sx1Z9dA/LZOlHzt+PmyCqGdx3yl+k3PZ5Hd
         8Yx2y8IS2v9eAEy9v9beB6fHCv9j3IwroroYBSrNF/fSgYe+e+6k79IKwBaRSLbREGol
         YlSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785425058; x=1786029858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UrDhJjnc0lrm1ID1paCGtTzIL7+88JidvPsft3RnzA=;
        b=M2YAiqf5zjF9BUEexUtnZu5VO8wVUNiFrZAJuubRiiCutuYuEZIdEQ3zOLIWgfrT/j
         CtC9Ylk0UA8g05GaNI7Rur0Smtxn/i/za44vqmwQ2hzkDEQS+kouiVu3Md5heDpLciOl
         48rR2eALzH8Ayq/XO4oFAaNydhsRDwILYwHxBFcD0ks9OD0526iHmbfiJ5VdS6Wao5gI
         zoyd0IOegeStpjJzhB2XN3JDgVCnAF2bLHwKM1YueDNRIdWtGNS5Gcil73ps3AyJSevC
         YldIN1t092UQ2k1xS1SV1cvRMqMVo1RxUlkRJ4nPFGhfNWTr6YUYtz6luSuu2xonPeAi
         VffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425058; x=1786029858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UrDhJjnc0lrm1ID1paCGtTzIL7+88JidvPsft3RnzA=;
        b=EFouJ5vwS2YSNXRrbxX4G09Vx/J/K+9NsW0G8IvPDcJ/qu/KyaDzJQWenN/myPuElH
         9yqf7LoMOPR4unsu4VFFVOA0vdEx3+u6lsOYzo363w4KRdiX1MUZ7jMEnKv8DjxKOloD
         9Mns0GykF/9ba7wjczVCfS/UvgZ/gocQTfwyjp6TiQN35Vs8shf28yB3KrIrVt8aw/Fi
         DKx94r+QGOfIz5CrGsn2dc8gZKb8Ugvj6VoHYmfc6OILAvGYUp8MSmfE0WzhpVeImx3S
         HHywgvRh6uAJQwA8P6nLSOuCfzwpkYHNcf3NVB3vqPkzx8vNCO9SSHovtffN47AzrDKE
         nrKw==
X-Forwarded-Encrypted: i=1; AHgh+RrrYlqJawZo40Ct0ePYrXXifu6RzSBlQ/oqFahwlwhvWZb2OuQnRoGIQKqkLRgyvw7rBKKoqao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8AX+UbrnXUDdpEuc/qR8j2DIk7I+5f/7YXbhNAyJ2u4Z/ZGI
	WbJmG0JaFnMjzsAKJSxJ8q16J5fPDNHm/ihUZ18ox2R2hEOAYdlSMnZ/eG8em7EXsZN3p1q4v6u
	YU20+IyVVWDM6u7AV1erkcT4ySp+Dtm8=
X-Gm-Gg: AR+sD130YQkyQXIrhXuLQQC9Y7keLxfDiPT14GtshzFXii8wwcnr6olqU0g1z0tbS8L
	Bj+bY0/igORxPQPstwV+OQM9oNOdXIG+MZhFbZvcJilrb2iGrhTWPwgl80fMMQBZfvaPEtQYmW9
	JL7yANn+iygyC4N1101Mr70qHd3OJqkao1tbN2yPzct82MsMvFbgBzua3AwHK9/nV+4bckZZXJ5
	dArT9rqkzVP9bXFFe7DMQdYiLi96wuENKgqFmHTU24/LSoTpdqg8SK0nRsvgYQvYnxCHx/J0cob
	DFNBoIgeTp+45PEL/f85CJDgXzDP8yXWr9mfzOPVYEN8Xzigt2lWujWgNb4eHPf45tcB0IHeDc2
	QUVoC5XiMt4MrXQExm+F4tIV7Kl29baWJ+o8/Mg7utus=
X-Received: by 2002:a17:90b:2248:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-38fa7c5bfa9mr639124a91.0.1785425057737; Thu, 30 Jul 2026
 08:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729173742.950965-2-sunpeng.li@amd.com> <20260729223316.stable-0010@kernel.org>
 <3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com>
In-Reply-To: <3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jul 2026 11:24:06 -0400
X-Gm-Features: AUfX_mxpY30SGvliFzVOsuFGzSyte73p7B3Uzn7F21hVj7dtAEdLZlJ496TFYF8
Message-ID: <CADnq5_NymD2VUjK7ou7Z4hyGOiBr1VT0s0E3=BZcDwT7i5pt5A@mail.gmail.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before
 sending event
To: Leo Li <sunpeng.li@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, "Mario Limonciello (AMD)" <superm1@kernel.org>, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 11:08=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2026-07-29 22:40, Sasha Levin wrote:
> >> [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before sending e=
vent
> >
> > Thanks for the backports, but I'm going to hold both of these for now.
> >
> > There are two unmerged Fixes: patches against 48ab86360af1 ("drm/amd/di=
splay:
> > check GRPH_FLIP status before sending event") on the list, and I can
> > reproduce a flip_done/login freeze on DCN 3.1.5 with 7.2-rc4, plus ther=
e is
> > your own Cc: stable follow-up on top.
> >
> > Could you confirm which set you want stable to carry before I queue any=
 of
> > it?  Once the follow-ups land in mainline I'm happy to take the whole t=
hing
> > together for 7.1 and 6.18.
> >
>
> Hi Sasha,
>
> There are a few more fixes that merged into 7.2-rc5, with one that is sti=
ll in flight to mainline.
> Here's the --oneline list of everything:
>
> In flight to mainline (SHA will change):
>     18e3dd9ef45c6 drm/amd/display: Exit idle optimizations before program=
ming
>
> In 7.2-rc5 mainline:
>     fbbaca9e20873 drm/amd/display: Fix missing DCE check in dm_gpureset_t=
oggle_interrupts()
>     82730dba0cf9d drm/amd/display: Fix flip-done timeouts on mode1 reset
>
> In 7.2-rc4:
>     f39283eab44fb Revert "drm/amd/display: Restore 5s vbl offdelay for NV=
3x+ DGPUs"
>     48ab86360af11 drm/amd/display: check GRPH_FLIP status before sending =
event
>     8382cd234981a drm/amd/display: consolidate DCN vblank/flip handling o=
nto vupdate_no_lock
>
> Note that the revert target for f39283eab44fb is not in 6.18 but is in 7.=
1.
>
> The flip_done/login freeze that you're experiencing is likely fixed by th=
e in-flight fix.
> Link to 7.2-rc5 rebased change: https://gitlab.freedesktop.org/leoli/linu=
x-asdn/-/commit/18e3dd9ef45c6d1813ca1b629e294b151d38149a
>

Included in this week's -fixes PR:
https://lists.freedesktop.org/archives/amd-gfx/2026-July/149612.html

Alex

> Thanks,
> Leo
>
