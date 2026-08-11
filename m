Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CB34252B
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459198; cv=pass; b=NYg3MhUkOEePmliIfwefA5uxm2/20fyDdaiP7eb5bxjp9lEq7FB/gzXgfjswWiqdhrGK1ML2IOm++olavWxaXFU+bOVDrsa00hWbYoof9Q9C9y/9CRdziBObC7vXFiRbPMHKxz7CMPxHopHJZo3vV9MKCfVjJCPUJsf5Y51gx2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459198; c=relaxed/simple;
	bh=nVPVR0zRjjQCzRypL5OmiHULMHmTyGcRwmfzDYDhGQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFikLYJ/IEp3Y9rxifCMfucuuHzLRBafddHlEaH5w13n1uNHYi67NRKKCtsPQmByAFykHYcfTA9kr+svD7TGLZPWrfvz1SkzlR9M2y5FjZUkv1cvwh/DPtOqiWeotuahQLNN9gmr1c+tzYBe3iMv/QCpoVdRMi3nxV3huIYnpRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbgbTNy9; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbgbTNy9"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so3660929a12.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786459194; cv=none;
        d=google.com; s=arc-20260327;
        b=DsXg3UFvdy8wWIYzXaFFDZ+aFxhSpISbeNahG6bSy0g9bfak4kLGgs5JxLqD454jfX
         KSndweno1if26s3h2TW3BsHgyjkjtWKzu+NZYiVSacMTS7h+xCMAP/Q6Up802FPT5fim
         aXcSjpbktQaGHf5W+i73Mc7QMFX9lLs7RoJWYSaV3kFPyHRwI4pfDnkIyyjq/+lxxa2I
         HAewR3S5xJ5xthuE040qGVvUT0yJp02JUJ/1Kcxsz+uha8a1lcg3rmUO/WeIjp+o5FBQ
         Hv452EIOa0AgdSKVo5XgxCpaEbbJA1y8YihmBpD0/VO4rWxw/dla5qyp6leEhLxjDlF/
         Et3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1+dl9fZXRnYwGtmGEJgrmW0ZxaoVPhl9+scQqWpDRGQ=;
        fh=j29jKfJtSuUdtAB2+dmNpUNWhkwgcrXhhNqj+NpzRNc=;
        b=BrREVIiL9ZBLetlM54i95PWs2i3lnrEKgDMkS3GReHkGr4jS+CjBjPgxD1Lq5SYxsr
         Wm1ZRaujwNOczBrv0G3gsR1727kHY2FqwHA7BUVjRhEi+BqqMom+w4gx8w/zhHAqVmOY
         OWkKkKBo/H/SntnAiOIlYOeWOgaG1S0CrIS0JMZlPHTTnNWl1W2zzTJYpEU/VLjh8K/S
         aDGCuZsorzpqMFiae1rzpC6LfUiu8NPI4EdvPIKKFai3S6UvjpFFMYyff69iGs/TG0TD
         pXuBl1P/6o8qpySwnS90gqyYmU0yrYwdmXX4v78kFJE+Vn57zmLj7CCIejhVaF4UFeY1
         iDUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459194; x=1787063994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1+dl9fZXRnYwGtmGEJgrmW0ZxaoVPhl9+scQqWpDRGQ=;
        b=sbgbTNy9UYtTRAcqN8BeJQlafBsB3Gh7kusVWcOH53pF+N+MyxfV1qzu2tNJmnYwI6
         WVHm5fjopwSiPIxYWFClnT8mT/wc9CyCEqVhHaDfwcPcvYuAAhnu8nZx3X5xJbwfTUDg
         2l5lD/wHanUIJc9BDZqoJ6w03EIH5ObPG5erIUnfq0LIQgTfG306tX6EchiJ6YZ+Gf7P
         onb/BfQ8HunDXaHOlocJTXlPABD/7cf77fZxB+iw9F//lTvzPDEVnuCvo094/w5nRfk9
         XYjkFuVcdP0xc4sKR2l32k9vhMmtBXFrMX7khM1aWPAuB8phcDPJHahC78mH2u/nD00I
         phzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459194; x=1787063994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+dl9fZXRnYwGtmGEJgrmW0ZxaoVPhl9+scQqWpDRGQ=;
        b=T2FVbBPmj1+GIevijObqXsiE664JdynQsgq+E7FvJPQDTvjKPAHDzFmH2Om6/VaFBY
         Pgf/iJLaHQk8nasRIozhIFnYX/BCYc7T8SUbtY325AxXXFDd0SQ3pGusdQcE96Xu9shk
         RrnCR2Q53MC6dCQe26KEowNxBFq2nyCT5l6z54ZjiSV472YJ2hMLq39YKE2KSpNXE04s
         mi05pgFI7L72eJYDETSc/d9J34zeIihGTsZMkH3LB2n+r9rgqd1RDqThkjzYomE9H5EL
         xITN44EpPywDbHrulLYnwh9EcDLBzIhNDy6wgvw9ZZgK28IDgdaKxcSIMTh+COyrqtba
         psgA==
X-Forwarded-Encrypted: i=1; AHgh+RoUgPrKTU5k1vOh9Oaos0c4fPtoZkLRo/qzymq3aTtCRO0y+lirvq3dnWckVpneY1Jy2PYYMxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cq+g0B4084nqRSpb/EkjlJhlLIeIKeE+UQg3uF0tvDW+iP+O
	HyBatfi0K0b/jC27pRBaEoHLwkFElxWJ+fHcMl9x4E8AAGHryEI4++9jInzqyfbg19XlBTvyMMQ
	7VrYBCk2nRf2xlbu7O+d4/xTfdXXCyf4=
X-Gm-Gg: AR+sD10A5/JDAZDUl0g3SJPo915JQpdF6VSOSbJCTq9zrMco3jMDbVc1vLMCJKGGBIG
	4u8wN/Tt9XJm+m06lhNkLlv3/iIfK1kvCUBjEW1atV0KYVXQHL+XjVdamb6CastrYeZ9UAJT5U4
	JovNBhG4RuaxwAUICaM8WvHX18X4LFJqKaHI2L+O1vrh2OQHlQx+tq+5JgiMAyxFxYCp7V5a7IX
	r/JoJ2UTeATqj/toQIZfjeir3kNOe3j21pcRXjOFPE2owR/wsmRp5RUUh82G4EEeLHSgbyJmJ3G
	4KsaX0m2z2PoW2DsR7DlTL5WcMvlmca06yzGZ5pj+qnLVhmWg9fV6m/63zD7afLynSKIIkhhP2s
	S6Fo8PX+dNLb/mqW25izqHD+wB0HbirBFO1Fumo9H8zNt
X-Received: by 2002:a05:6a00:181b:b0:847:8449:2ba6 with SMTP id
 d2e1a72fcca58-84fa867de2dmr3537170b3a.8.1786459193566; Tue, 11 Aug 2026
 07:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809043806.2768302-1-yangyx22@mails.tsinghua.edu.cn>
 <CADvbK_cv+Wkb5r-8_sGnKsuA5tfErvLoiPZYVN=yXALbWfBOGw@mail.gmail.com> <20260810164158.2c6821b3@kernel.org>
In-Reply-To: <20260810164158.2c6821b3@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 11 Aug 2026 10:39:41 -0400
X-Gm-Features: AUfX_mxUqV6zeBTI5OtRJ6DcMDEFwMxz_gmXIIliFx8FhaX6oD2roVpYsRIQPfE
Message-ID: <CADvbK_f+LbCtszU5WJMpAhcYGOu3ReyVrqXx+Tstr+bwkyHueQ@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix use-after-free of cached ASCONF chunk
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Aug 2026 09:09:15 -0400 Xin Long wrote:
> > On Sun, Aug 9, 2026 at 12:38=E2=80=AFAM Yuxiang Yang
> > <yangyx22@mails.tsinghua.edu.cn> wrote:
> > >
> > > addip_last_asconf caches the outstanding outbound ASCONF chunk. The n=
ormal
> > > ASCONF-ACK completion path releases the chunk and clears the pointer.
> > >
> > > However, sctp_asconf_queue_teardown() releases the cached chunk witho=
ut
> > > clearing addip_last_asconf. During peer restart handling,
> > > sctp_sf_do_dupcook_a() queues SCTP_CMD_PURGE_ASCONF_QUEUE, which invo=
kes
> > > sctp_asconf_queue_teardown() while the association remains alive and =
leaves
> > > the pointer dangling.
> > >
> > > A delayed authenticated ASCONF-ACK can then reach sctp_sf_do_asconf_a=
ck(),
> > > which accesses the stale chunk and passes it to sctp_process_asconf_a=
ck(),
> > > causing a use-after-free and a second release.
> > >
> > > Clearing the pointer exposes a race with T4 expiry. Peer restart hand=
ling
> > > queues the timer stop before the purge, but SCTP_CMD_TIMER_STOP uses
> > > timer_delete(), which does not wait for a callback already running on
> > > another CPU. Such a callback can reach sctp_sf_t4_timer_expire() afte=
r
> > > the purge and dereference NULL.
> > >
> > > Clear addip_last_asconf after releasing the cached chunk, and make
> > > sctp_sf_t4_timer_expire() consume a stale T4 expiry if no outstanding
> > > ASCONF remains.
> >
> > Acked-by: Xin Long <lucien.xin@gmail.com>
>
> Hi! I think *shiko has a different suggestion which it thinks covers
> more cases. Does it make sense?
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809043806.276830=
2-1-yangyx22@mails.tsinghua.edu.cn

These are two pre-existing issues:

- The 1st one needs to clear more state for ADDIP in
  sctp_asconf_queue_teardown(), such as src_out_of_asoc_ok and
  asconf_addr_del_pending.

- The 2nd one needs to check whether the expiry matches the ASCONF it was
  armed for. We may also need to add a new member to the association, such
  as last_addip_serial.

We=E2=80=99ll need some time to reproduce and confirm these issues. Since n=
either
causes a crash (unlike this issue),and the current patch does not make
either of them worse, I think it would be better to address them separately
in later patches.

Thanks.
