Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28A495AE9
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372473; cv=none; b=mZVWpM/ScZ8MYe4wNp1g8NIb2Gx7Fmr/NmoOmustnmVone6xp2iUue1yzGpHAUXfjZZgrvFXJnmv9lHJAsFChWzVGVvu/H3Y2rUD+bQSiIc25euaoVj2SLUjNL7Hku9jkkot1deVTrrBNkdwVHnb4uhWU13ugB7+ZhH1UE3wURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372473; c=relaxed/simple;
	bh=y02v7SVJT4K9c+u92pUX8aB0KOIWkjP5bkhyg0xDmak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXkiGa3p85zEHnSC5BrIZYer4yjfYnaWq05IRvgkIN9JkooWPivA09Jx+nPLk1D3qN8QYnIOLyWERNb+/UoXd6qeuZH1Gze+oHY16pRFdRm6AvvtDu7+r3lw4SW6NzvrBouQHT8LNPQm7TdrVYsPiNvk1No571w1FMvjyAZgHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkTxy+Xf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkTxy+Xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E11F0089B
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791372458;
	bh=y02v7SVJT4K9c+u92pUX8aB0KOIWkjP5bkhyg0xDmak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EkTxy+XfvtPBwVrn3idS4VmccDY5FCRytKIvh0NA61Ncr8+N+gcZF4TC9If5cY88c
	 1L7fXFonOYFxaJ0em0NwKivGyaew1+RG6+R4/3ULbvS0aTw6Yb95HuR/LvaI2OUrRP
	 0RvpvXzX86klP60vEfinEPiLN7NT827tn7Z8uiqS7xUVB0XGLyKMW8mlr1kAe4vcS6
	 y27MLU/UNdxQELjvnZHyTGoR0zssFKqbUeSO4BsHL5AV2WkvxNm9XH9GzPIpSKjfFD
	 khwBPxZuzWZH24XaBx8C6f+pX2MP7DQgE2I4M3EyxGtbdGujESQKu6TCNw3tQXK2R2
	 6eagT0I4auYIw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-49e1251674cso1330404fac.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 04:27:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxs3sAEBZgCd/Ctk+Vwle8goM67fK6oa30xclrcvNtDfODoQvJB33OW1KZk1jeSJ9s38PCEgRo=@vger.kernel.org
X-Gm-Message-State: AFuF++mvHr2yemx+cn5gqsnFBdC5jpsafK2RKqLpq6ClUl7X9R0ykjri
	OKsLxcpfayLvc5PNVHcek5vCXJ4RWFzkOfsNvJyq55wp0Y+YEirnyxZnYEDT2FPm0dMc6AhMlh7
	r8Gs1fFNyqRw2hzlBK4+EPsAaX4sj460=
X-Received: by 2002:a05:6870:ac14:b0:490:ccdf:1931 with SMTP id
 586e51a60fabf-4a259692aa5mr1851883fac.55.1791372458102; Wed, 07 Oct 2026
 04:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005180150.1024336-1-mario.limonciello@amd.com>
In-Reply-To: <20261005180150.1024336-1-mario.limonciello@amd.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Oct 2026 13:27:18 +0200
X-Gmail-Original-Message-ID: <CAD++jLnO6QuphZwOiT9kYpn=CiPFiQfxj9bdbDw08d=GdAhD=Q@mail.gmail.com>
X-Gm-Features: AclHuK9nCczTq1ZItTciTo5UlMzbWPuWNOKhd7xeO3CKIGmd3JxncOU__rvXFoY
Message-ID: <CAD++jLnO6QuphZwOiT9kYpn=CiPFiQfxj9bdbDw08d=GdAhD=Q@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: amd: Clear S4 wake bits when firmware has _AEI
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, 
	Olzhas Marat <marat.olzhas@gmail.com>, stable@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:02=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> Commit ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
> preserves firmware-programmed S4 wake sources because some PCIe devices
> rely on them for Wake-on-LAN. The system that motivated that change does
> not expose ACPI GPIO events through _AEI.
>
> On a Chuwi CoreBook Plus, firmware exposes _AEI but also leaves the S4/S5
> wake bit set for GPIO 24. This causes the machine to power back on
> immediately after shutdown even though Wake-on-LAN is not enabled.
>
> GPIO register dumps show that the only relevant difference is bit 15 on
> GPIO 24. Clearing that bit makes the machine remain off. GPIO 24 is not
> itself listed in _AEI, so _AEI is not a per-pin indication of which pins
> the OS manages; it is a platform level signal of which wake model the
> firmware follows.
>
> Use that signal to decide what to clear. Continue clearing S0i3/S3 bits o=
n
> every system. Clear S4 bits when firmware exposes _AEI, indicating that t=
he
> platform hands GPIO events to the OS, but preserve S4 bits when _AEI is
> absent so that firmware-programmed sources such as PCIe PME that bypass t=
he
> GPIO IRQ wake API keep working.
>
> A platform that exposes _AEI for some pins while routing a wake capable
> device through a raw GPIO not listed in _AEI would lose that wake source
> unless firmware re-arms it during the sleep transition. No such system ha=
s
> been reported.
>
> Fixes: ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
> Reported-by: Olzhas Marat <marat.olzhas@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222041
> Cc: stable@vger.kernel.org
> Tested-by: Olzhas Marat <marat.olzhas@gmail.com>
> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch applied for fixes.

Yours,
Linus Walleij
