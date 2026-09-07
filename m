Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDB340401
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765356; cv=pass; b=DXmavnawonDxuyFiUS2dXbhg2iTGi41WN/AAkFx10xoXFj8l+rTjuUQgNt3YuKWmj4fTCguNR721NtZdxCLmEw1Mi9Yrd+BwFDmyn56h6ShK/79CyPnWoJPFn1clvHdj92oT68DXc8jpuJOeKDPRcxDGbXijWvzXHohfMTQojPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765356; c=relaxed/simple;
	bh=leHVZXld9eH9iZDPZ6fIXvSuhv4Lo3E5ocYgQ1ebU9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEZQqU57+5fYK92LpXAOJ0aFML9lYDIwwaJjKjuEIRwcnAryLfX0DoRvz+PpVJ/oZZQkxU306ttpqg8APbJuHaOb3Gi/KjlSzboxJuWsjMqZwCkyu2meeRrV0TzLuK5EIblNAq0sFtqDUcQr/w9YiFC27U0MxJwItmLHyPg6CFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Lq1YwZgP; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Lq1YwZgP"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a1981228f8so26537081fa.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765350; cv=none;
        d=google.com; s=arc-20260327;
        b=Bphwb73NW3oztegXZD8DEIec67Ykc9f24E56FTOKJJ45LqTq8r/sZzUpxjLMS87k85
         fzSBE18DlPfAu8xj8nH6HVtoQrKY2MOyBEmq7nk+k8MfX3ufYU9h1y2Dby1Ckzb0+OPT
         yPq/uPny1RtukI+Z5MjVkuJaKXyo7IsngygVtI10aEcuaxmjZsVKMAq014oRs7VJMQh2
         LMjYont1S0zCG2SV5ZNXugLhn26TVektFcwBvc3OI5rG3KcllzGV9c+h4ERgLVyChY1u
         KGk/r4ha9msAPECEpdc9X/hhzbY1Rry5RSi0I0Xrtq4aVcmw0G1t7LrXIU5r2cuv6/IG
         MVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        fh=FJz6SINbDlg4Pw46K33/zSgSB4S0V3jdlKxXGgs/gp0=;
        b=NmkGq0M0y3eSj/zZ3rY3Z/rqQKNjVGIgKCAf6lith7zGO3eNVrKXzDO/jnd/6QWFmi
         zqmZtHgQA55+XvcwWe1NNsFqEEbU+zlGDo1z56t6HORJwMVBCMYECkSek3naXLZvZp0k
         IBX0dfoY/5BxtFeGwht04LYd9qpOEfiXNf8zkT+9kGAhX5i8SWdl0sdI5GkUEC2wUpYr
         18eTMiKpXhtJab2/1c0zSjqwe6W05ooBWyooVE0/+QnHbHN2G0ryGGAVHl8gEDZ06mAb
         SJ5QrsE+pEIvDAwllqPM0sFSTZZ3P1BZbsh6qNcDXdxfDVkyYpoBW+plm4vL5XC3GYVG
         ki0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788765350; x=1789370150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        b=Lq1YwZgPqRf+7Pxl9disFZ14dqGl/QPk4Q92znevy1bB4ggHV+vi6ltGVKpRmbXSeY
         Fz6I/psXx6S5j5exsaDwFrnRr65fPKk2efBueXG2RcEiQT4NZtQdhs/RsuTa3m70o1bw
         H6vnT+hB1BCqedp6kAOjo4jEVz3PzJKynHawAZ6gCaqVnyUeX7DxbFseqFq2vkXH2NHm
         avTL/6+q3Icf03UjmNMx6EIPZn/XmdoW+ysI1bpzh3l5PgWUKDvbBdDoTuJpImd2TxrX
         JIexykIu2edhMbyLxJzM3O27zDY6wBqYCTbi76dRReRRMy2mvfsIvB+5IPgUwHLmGhtV
         O28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765350; x=1789370150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        b=kjK8zYNjPMXNGP7UogaLI/l9vGsHo50B9AnANU/XooLME2mioXylyar6RDUkLHeCW1
         m4wZoKGilwWxCpqA5S0dCkgXcNwBvOjnMLDDEhd3DPaqaQcdVWxoil38CGG70Ld6VC22
         IMRYKVM/ax4g6BdvP8yeGH7S8tfDOITnemsAbOn6/8xM0dAOcCyIWB1g0g29D+Q+gYaM
         c93QdFxxrbAqzNipUhpsDb7M5NW9HUdGp8S4GJnj0lxMGOVNuKliPLtyJ0IjvlIXzUXr
         6TdKC6auTyCGh4bzyG6rsM0iX2Q9MMty101nzt0wamKGAAfq4cHBWl2kphjtpM0iHzAQ
         ubfg==
X-Forwarded-Encrypted: i=1; AKwUvBzPiv5kkOBvM2Apv7zo3XLHlqE+kn2mYZqYkGOluSretf8nLZQM1ii3tNfyG7jgHnW8Jla+ezs=@vger.kernel.org
X-Gm-Message-State: AFuF++nHJ2TzghkHjOsj6KJh+3iOBZktFgkXwrP3UZBvH2S8EHqDmNC6
	KO71MYRV+6GAZ4jSWv33cp2Yd9a1+rriR19wrh3/WRGB9FXVbYbuEMax5BnQcxYq1RyLJJuK7A0
	XqYBvq2EajaKFoFAxkq6szI4MlRJqkRUrHUZSctZgeRg=
X-Gm-Gg: AYBFou1ylTXPkv6Zpw5sEJURLijNdzIHPqmRRLdRNwD9NLqzQkal0BGlzurpMNsU+W0
	HiIQiHNnSNmL0IL1RBXDWjcJ8luoNcilE/a+f0Crr61MIMP6DpIlUBkYek/Tv2PjEQoCIkpkAMv
	LZW8aQFLpWqvwr/DJjidv+FFCeP3rJGQEBzCTKIAJQe2kj8mPMrBwAfLL7yvTZ8qqmHZXhV115I
	xVgE/IOgJ6srh0KtSYp/hvoPVah6M3jUjK5DP1X8xJOwQy2qNp2k8MHOREz3yrrSB5ASBCYxUbk
	fJQ/2vkvUWk1L96e7ESkAWfkvxR2VY/BHbIupTTVM0lNASwwilEnr1lkOUMCzP/ePofbjvYrzvU
	=
X-Received: by 2002:a2e:a98e:0:b0:3a3:2a41:c0c4 with SMTP id
 38308e7fff4ca-3a371bdb9ecmr21466191fa.14.1788765349741; Mon, 07 Sep 2026
 00:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
 <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
In-Reply-To: <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:15:37 +0800
X-Gm-Features: AcwNN1VAmgJsxlkj9OvW4LjLVIy_57TEsN_AWLvPrdkLDxAVfSNlHuWjRZ_THxg
Message-ID: <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> > - bind cursor UAF / dangling tb2: valid
> > - unconditional sock_hold() on unpublished TIME_WAIT: valid
> > - clearing s_num on cursor mismatch: valid
> > - lockless cursor-membership checks: valid as a concern
> > - commit message overstating bind/ehash fill-under-lock: valid
> > - missing note that MPTCP needs the follow-up patch: valid as a
> >   backport note
> > - endless re-scan of the same bucket head: not valid as a
> >   guaranteed livelock; duplicate output after a rejected cursor
> >   is valid
>
> I just saw your patch today. This is absolutely insane.
>
> Please limit the complexity of a filter to something reasonable.
> Absolutely no sane user is using a very complex filter.
>
> Same for UDP.

Thanks for the feedback.

We will drop the dump-cursor rewrite.

A follow-up can cap inet_diag bytecode complexity in
inet_diag_bc_audit() so TCP, UDP and MPTCP dumps share the same limit.

Please let me know if that is the direction you want.
