Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C64418E4
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756499; cv=none; b=dz81apoG1+7EWPgRNc3ckEJUCVNyiLAp1Liir2cV0mNWnhapMnSfJgxS9kqz1FGpUlZDU5etDJJkVbxgjfm2kFU+LWIMp+zwAwYEkmTxDp6RoxYL9w+RupgM4w6kFfkwjdsr6kAHRJyqpg8E4RBWSAgvqa3P0U/PJvJ0bMCtO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756499; c=relaxed/simple;
	bh=yX/6RORiQ/CP1dqjgZ0/IpYBv5+6Zke4SmnXT55+r9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAQajz0MVLmVPybIAKLe06Na1RBdjKT+UnyrC8ofKhRU6R+bHe7Sv5aGPZkll4GNEhKOjQYONdQe9DSvqFmPWNlHLYyjxvO5myEnvwo7T0qukK/unfaa+IjjQYQ0AjpKC4TrsvupDeiId79W4jnfittOQJAE/KsLvqDQjRWxmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQRsoF9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQRsoF9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101231F00A3F
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756498;
	bh=ypjuAIQb6efh/8oIGum/E6D1WtNQPSF3Rpm03VRyfM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EQRsoF9Wq77ic94yAQCXGeKg/yJ0vC1VWbl2fknXoOrp6OEKsBMFSqS9WtdOZ2T15
	 s0d0bew1n2UHvQfSkDqVANQboQ/tKEyXI8QaOHz6KGNv669bYJfvYNZVvT0RIOCDzS
	 oq+9QfwKPVZcY5CggOpwYwdvb/3oAztdzMS7Bw/xu664GFBrum9XMGpUIIjLIB6BWQ
	 e49AVxwF8WdxSKB3mTLi32aS6zmVEFYzXPMXYs/Aq3Q0k/aDK05Y/UWRc+NvfpJP/z
	 Ixsg6IuAe0kmdSoC/x80AIX5qLZew9iT34pAEMqAWWmLNxJkisCNje9LuGDveUOcmt
	 XJfDpSslIFEeQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so1785443a12.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqsVWuTVpjI+EnTculJCN5skyNqBt2IH8k2qPN4NQRvJ5o0IZipWfyuuIUEP/BE+27hAuhOBbk=@vger.kernel.org
X-Gm-Message-State: AFuF++lQiw5xRw1UujYD3fY0g6EROSKfItUxqZU7q+HDU84FStJb4WV/
	yGjAfWxQg2cvHmpgaO3ctEx2WzU4v3FZ9eUrqpQ3oSFIw9+lACf4osekzEuBy0EmytqN+UW2mEt
	DQi1S9UhsZxTkyd9czK3BA2Y70JLGmGo=
X-Received: by 2002:a17:907:ea8e:b0:c24:d914:6d64 with SMTP id
 a640c23a62f3a-c250c32cb23mr952867266b.23.1787756496658; Wed, 26 Aug 2026
 08:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-6-chenhuacai@loongson.cn> <285743d2-6b4b-44e5-a0e2-b43a5e3cda29@xry111.site>
In-Reply-To: <285743d2-6b4b-44e5-a0e2-b43a5e3cda29@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Aug 2026 23:01:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7yNSBzGhZDSUadi--NK=0g-eL87Fxp-Roxw0wR6qVOmQ@mail.gmail.com>
X-Gm-Features: AcwNN1WJcO27SLXPpPoCC20exyVm4-H7GL8J2q-G0zW5SFPGmUEtjYyMNe-6vKI
Message-ID: <CAAhV-H7yNSBzGhZDSUadi--NK=0g-eL87Fxp-Roxw0wR6qVOmQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpufreq: loongson3: Replace IOCSR read/write with
 MMIO ones
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	jeffbai@aosc.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Fri, Aug 21, 2026 at 1:01=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
>
>
> =E5=9C=A8 2026/8/18 20:39, Huacai Chen =E5=86=99=E9=81=93:
> > Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
> > nodes in one package and SMC mailboxes are also per-node. However, IOCS=
R
> > read/write can only perform on the current node, while sometimes we wan=
t
> > to perform on other nodes (e.g. when switch governor, the get and targe=
t
> > callbacks are not run on target core). So replace IOCSR read/write with
> > MMIO ones.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/cpufreq/loongson3_cpufreq.c | 31 ++++++++++++++++++++++------=
-
> >   1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loon=
gson3_cpufreq.c
> > index c75c0e30e881..e5062cd62390 100644
> > --- a/drivers/cpufreq/loongson3_cpufreq.c
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -164,6 +164,12 @@ union smc_message {
> >
> >   #define FREQ_MAX_LEVEL                      16
> >
> > +#define MMIO_SMCMBX(node) \
> > +     ((void __iomem *)(IO_BASE | (u64)(node) << NODE_ADDRSPACE_SHIFT |=
 LOONGSON_REG_BASE | LOONGARCH_IOCSR_SMCMBX))
>
> NODE_ADDRSPACE_SHIFT is defined in numa.h so that file needs to be
> included, to avoid a build failure when NUMA is disabled (if NUMA is
> enabled, numa.h happens to be pulled in via some other headers).
>
> Also I'd suggest to use nid_to_addrbase(node) instead of hard coding the
> shift for better readability.
Yes, that's better, thank you very much.

Huacai
>
> With the changes:
>
> Tested-by: Xi Ruoyao <xry111@xry111.site> # on XA61200
