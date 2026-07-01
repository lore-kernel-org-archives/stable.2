Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED23B83EF
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910213; cv=none; b=NSLmpXZ95Jy4Nq2CQPwPvL2TtByY8j1Rd53OEUV3CIJXmk645o3gYVHgg48VitFs+flBX90++Pyvy4g0l5oShh4jf+EqNQdkLPLnd2X6975PdIRQ8z4k6x9Zy2PW9a8WuNUzdeeDFtHFeFfvQj1e4P22g6OslQT9HAKrjwQavEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910213; c=relaxed/simple;
	bh=ka7QnJN4tdnWVmhlb/tOiO+HN/iNCJ+GTmw5iPpNAhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8Ib7UmPhnH6byRX5WvzeHjjhxGx7xe1Qomu4eRiJ4d3i/hiGTW61/WUklBt7DXo0fvQvF88oFC/C/pG5Ask83s5jcPBBQgYFhnvhZa7/TJxU/yAoJ8EP1AMgPuvQpcEUejyIYeywdB1Ci+FX5Iavd+P1ALGXJu7l/wMGmMRqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsVendUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsVendUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1215F1F00ADB
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782910212;
	bh=ka7QnJN4tdnWVmhlb/tOiO+HN/iNCJ+GTmw5iPpNAhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NsVendUc+xlXbwfcV/MeSOuOSKIWnrzKOb697WibrhMO8d2jJZgICMwCA8tVdR1WL
	 EyFY+UfVwi3MQiSWnRYitDADK57Eki3DZVoz9HuCulWm10rE7CT2jKzn88EK//ta5T
	 bo2yhX6leUxqHqxfVlIfLrrDKoejNg/Ejr+kCVfYomuDjnPjctsBpLsNACwAGtkD10
	 oiTUa5/nsGAjOwL2O23VTAIwtB7yIZWkmjO+FvTFd3G8pcplooUcPznoWC5Z3tq3XP
	 wl4z21/n1Z5iWGNo6qbstil1SHlARsmwJkyXvrNwrvnLSqIzOdTENuMpYeUkm4m1lJ
	 oIpqz34CZj88w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aebbeba529so564068e87.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 05:50:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrX5SIeq3fKgsu8tXNWJ2NrpsX9r4KKBJzEDv+qP7dhongV01Z5aGLkPwyJvCMRjKvS3XZmmfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMUgAEi/cBA+e9Hy9VVG0oEjebHuFrXWGpzuZOKvT5kqn3obu
	1DzIwy0YGnFisX4CdHj2ymIWeOknxb3jc9oiTXaU639121PKqQj3tSs/qth7Oa9gPm9EwahqeeN
	IW1LVBVxZNDQzAjGZ9SyCSjlJxlGxHXM=
X-Received: by 2002:a05:6512:312a:b0:5ae:a9eb:c5bc with SMTP id
 2adb3069b0e04-5aec68b8a6bmr211539e87.54.1782910210712; Wed, 01 Jul 2026
 05:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org> <akT1lr2iNzbnGEzH@shell.armlinux.org.uk>
In-Reply-To: <akT1lr2iNzbnGEzH@shell.armlinux.org.uk>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 14:49:57 +0200
X-Gmail-Original-Message-ID: <CAD++jL=_j69pFuM+vv-8Q7x4VA=PUX8iV1Yfw4YkdxGDFo9D1g@mail.gmail.com>
X-Gm-Features: AVVi8CcUQBe3Ypind6UEgo4R6TXZ3SBFDAQ1fOheUwkqZ3hP3JStneA4_dlmptA
Message-ID: <CAD++jL=_j69pFuM+vv-8Q7x4VA=PUX8iV1Yfw4YkdxGDFo9D1g@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: breakpoint: CFI breakpoints only on demand
To: Russell King <linux@armlinux.org.uk>
Cc: Nathan Chancellor <nathan@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	slipher <slipher@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:10=E2=80=AFPM Russell King <linux@armlinux.org.uk>=
 wrote:

> Have the LLVM compiler people responded to this bug yet? What is their
> plan with the silly choice of BKPT usage for CFI failure?

Haven't heard anything.

My tentative plan is to follow this up with a patch to LLVM (and I guess
then later also GCC...) to enable handling CFI faults with a read
to the guard region at 0xffc00000 instead of using BKPT so we get a
good old predictable segfault instead. I was thinking something like

-fsanitize-kcfi-guard-region-address=3D0xffc00000

My idea is that the unwinder can then see that this is caused by KCFI
and act accordingly, but already the existing stack trace should make
it pretty obvious what happened.

It's the best I can think of at least, haven't seen any other ideas.

Yours,
Linus Walleij
