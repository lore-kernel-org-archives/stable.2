Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47046AA79
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278240; cv=pass; b=Di/Z2Y4k3c7LUQSMF2NEzsQLZ6y9QAkODvDMMWOhULFlJwidhEc9mO9fT2lbEiFA7PKpzVSj2gcAhp90fZYoBD+U2JN+FyA4ykgY62NRQCZ10PPi570w4fjnRm4a0EvOivP7+5+xo9sRljHpUvR5iYQrmToGIvpdcXm/ebzfXSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278240; c=relaxed/simple;
	bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDSXnbhviHavXBkcnxxe+BnPEPyeUqczAaK+LWJUctItBJFmIiTt+TTKCnS27bApGemScMTJmVnVHNeQWdZkrVYH0WSTt0rYZs8GQG8WHfMY/5XAkyXqs3uLMJGknFYTq7HJF/AMnjljBLdR2QNfZovckrs2YsvuIjfB6ZkKokY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h70ekUkB; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h70ekUkB"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517dc520840so52826641cf.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788278237; cv=none;
        d=google.com; s=arc-20260327;
        b=KMY8GsIoya1RITC5tWnNXpmmqY5rPftMwohx0JKAaUvQioY1VUns892kW+K6ETQTJc
         VMCWcvPJDu4oohbf1U483vyRc1enFsSwJkurkVCp3rDXQ0ffgDWLfLkzjb9+MmAfQDKg
         Rn9kQP9VoCF6aLo55l2YiscQOfsN9iU8DFHhCnak0k13/ozWPYHRpqE8HbrUP4LbwZie
         X2Ic6pE6wZF+bQ1nDv/0Jm5q5u8nN2+waqkkPsTwm0KLSlRVTSh193VnlT6wvOsUmV2c
         ERrfVCsVP2hVCvL9xrm636X34L79CpvT+sE7IEGJ+YMCaFKGCoOGE5smV11BbGdt//Ku
         7Lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
        fh=EuNCjZDgjyBO4CMKlA6VmxWFrBmGZIqGFshS94xmYE4=;
        b=s1xTLsniM+rpttl9MNu1P8GGfqkL4wpRF97P9unGY0Yxl9jvzYnz/jMQAVSJVmj9y4
         36bF5HeRZAcAA9jgtK4o45cHWhl1PGIu5R3ku9TN2r1dYD8pGcXcxHWqIiycb4Yh8f7D
         kE/69u5EIEbXF2RHepv8X5wQeDVNS8JaFsfFdWojtGBQFg7TDg/JfwAE0et1jBN9BPa2
         /xNWwOB3FpJ+a0NlWFRtG2/re4TGhfWAd+BUcesh70IVaLCox+xdswO49tZCwCUIpCgB
         2AaiIokKFG+PVa+7uL2Iw52gjOevp9tLgQ1gRXSiD86qyxRdPxJiKQL2qIrISCNiZsST
         KkFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788278237; x=1788883037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
        b=h70ekUkBwz6octO7VnJrhhKA+mYJWukq9I1chbkeA2Gvcz2scr2RdKQhhVi266s1re
         9xzQoAYfrgutJ7jJkaons/HnVC8f5k2KB6DNJBIcdmrkb2QKjaspRgxZ+IFtbqyJFzxh
         BdUxYZcKOeOSHQJ2FIQtIJ9xJeFlpOxkdmS29WrZgmH4bwfp72AVEymMxDWhHN+ZrpHc
         bK+jcs7DwDS4uRnxhG8TiYfI9vjBsLU6mTTINyLgHzlc+DUg7ZCAqns4qKJdPjbaNb1c
         HsW/1mewYCkq9N+JG788O258jGc5mhJZ9C9DJFoKl0WITlWbsscYpWNwK+tuE1q2Gt1+
         LRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278237; x=1788883037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0c8eX5045Wna8ziNden3Y6xoUliGlNqVmMmXrRc2s4s=;
        b=Km/wzyZnfiZcsubP+U7soYc0G7zkAKHOqSQDEQnP7IFGQ20xrnW/Fge3x3mTJ3AJ49
         zQlFcfYMi7UUJlV1yBa0BCC5lODDInwraGJRv62Ytf63+qbs1SUIU1+YB+0sL9uddE6y
         9g8lCW2iYqsZB4se3WQEUQrGrJ+7xzP1pWp9QBrtwVastABidVWWQaXBRYXcUuhHI1V4
         F3CLXUbfriZkWMhoE+jzRBoJLkQLbNhjMiS4dSHgQrKHrT1yXtOpSg/70SqlhOvxOUpp
         6+qQAScqPF5jXdrUKye2oLW+aVG1BINBrg8p8SVbeQ56lAzYYpD3XyFIq50EZNeKK95k
         EUeA==
X-Forwarded-Encrypted: i=1; AHgh+RoCUrO0+jjJMb/HVzgRq1s8Ifz9YnkMccBo13ayPBXSDT/zrvcjsWPjY+qAlhxChaqk9YWVu6o=@vger.kernel.org
X-Gm-Message-State: AFuF++nHqXj063jj4c/oeXJxV9FW+isMUCXXk2tg8QWBZ+1ia4QxWhyp
	Pyz/X8s2lU1ZHX1fgkMaVTCJLTmRGfSRfdQacj89s+PS4QZqOBKVoKampqP3ZzNupfxWSp1oyvY
	txsDvWC+52qmDw44Jegyi9tgVsTOx6A4BJCMANWqH
X-Gm-Gg: AR+sD10iJra86a0mtChunOm5yHQzcE4btD5XIhvC0GcgLpp8N1jbpz/mrrx++RFPBdj
	3TUWw4bOJOrm1JRUX3LERLen8OfA4le69WvP7bxWi1sUnvJSkADwAbw1CMV/zmBDJzl1pyUSR/6
	Qbe+F/Fc0m65x6eafJo3YXEmDC2LAfxDxIt5GrpPgQehnlyViXX1w9Z9NBmSfTQrE5a5FG1ZlS4
	WADwV8TdtUxX+FVwz+N4hGEophdDEiBv33zXbMVDnT1wu+ue0PCL8gaXANIU3JrGHxlsUNVoH2F
	NuNCptxbaZePnRCvvNuHurLNmg+95N/UNsSUFnd3zupL2HT86p5BVxYRN+aXSGT8FPRwa1FNHRP
	to68dIoFgEdy6f0I4quXOZDEEuOoPR68A0XaC+3xN2OCj1Xhzs3H0JO5JbYMYGJQ5ry+q
X-Received: by 2002:a05:622a:48b:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-52fb938d0cfmr409954361cf.5.1788278236459; Tue, 01 Sep 2026
 08:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824033331.1084971-1-imv4bel@gmail.com> <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel> <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com> <20260901085102.5c58a5b0@kernel.org>
In-Reply-To: <20260901085102.5c58a5b0@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Sep 2026 17:57:04 +0200
X-Gm-Features: AcwNN1V0ZKwY8CxffJ67D9qqHhYGRXD1ZIi8To29JusVq6P0sfEj2LbfZMr-I8w
Message-ID: <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net, 
	ncardwell@google.com, dsahern@kernel.org, idosch@nvidia.com, 
	kuniyu@google.com, horms@kernel.org, willemb@google.com, 
	andrew+netdev@lunn.ch, kees@kernel.org, jiayuan.chen@linux.dev, 
	kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > > Looking at this further, unhashing the listener and then calling
> > > synchronize_net() lets the disconnect path handle it. MPTCP needs a f=
ix
> > > too, though, because it closes and reuses the first subflow directly
> > > without going through tcp_disconnect().
> >
> > This looks like a more palatable approach: this patch in the current
> > format looked way too invasive to me.
>
> I likely lack context on this, but I was wondering whether we should
> potentially disallow the transitions between listening and data sockets
> instead of fixing these endless bugs?

+2 I think I mentioned this at some point.

Same for IPV6_ADDRFORM : we should not allow transformed socket to
even use tcp_disconnect().
