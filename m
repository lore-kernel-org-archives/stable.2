Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9D49481B
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168706; cv=pass; b=cjHixmQocyAA/odqgp1NXzJokJi/7Gnh575X1H9jRVKRZhNn/e9D7mpkYreeiF/18mnuG4ISyWPsKGEIlCT7dsD4UGLVKtRBvkxiDKDQFmBPYIJ9qUKbzdB/VUtJb059SiibxJiIihUYHmJ2U4Pa4BpzBn2QA1OHwCJgLwEhU1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168706; c=relaxed/simple;
	bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xaue5bZOGi4fU+9qpIDLhKw8TLGHUVDfeVdabCMGMJMHf+9tlEuf/3+QJX96XhAgln9MwTPPsDAq9x7KlUwU2Be64tbfJToCpfiwdGIcFczbezWe9/l0y386eMg3wbb0/tPagqDKXEB1Y7o+3xfogKH+G95+EJjjGM1TLxD18Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=lkdqnEX7; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="lkdqnEX7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84faf87d19dso1511269b3a.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 12:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787168702; cv=none;
        d=google.com; s=arc-20260327;
        b=KKa/RBVJnjxmmGOrX4Qzw10tWxToJ3R60CtsG7LYULcgWkGmuM0f3rrTfAf+G9tYw7
         EoauOWrNiToKny5UBmqVB0RSiu3Mzx/EGHo+SpCozSfIRWKZMoCGv/g35BuJTeL9teho
         bpkPbxTXyFu/WzW9fQF/ydJwBqJdaOQ9Jnk8AumTqBd7CWnA077sdWcEij9WdTQ+8V8v
         BTZG+qPt/hqoiTmB2tQx8KAAeBvizlu+veW1RuMEKFPHnKjX6qG6k9XNN2kkv+tNX3u5
         DdFVozfW1Yyj+oM0T1Aji1HI41sXiETNbyUH+InaAg3d1gzjtmOlYmSvyEIC6khOxSOs
         dAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
        fh=P+0OFC6hDjlDDoatlDICujiJKoQcj9YtbzhUf6k38us=;
        b=G/GAXDRMyC+GPl1pCNCx2y/wa2sP1j2PwnkjkI251nsa5D0+d+/g2TIeE1LAr7Rq/0
         OhyBciE8xo0wCCXSFX8ZE6J2TfBf4rj8TLuDNHTBP9qD0AjbvcneConkVM6Y45EP/A4Z
         dA9JlZt4HFrzSFcqgSz8tN+kJ/KRGcv4X3VelaGQXrjaL1KswpEZf0Jv69Xo9QdWWvM/
         V+Cl31kTBmffHACcM1wr3smrlkHR0Q9NpWN5gDYM7GiPdAzxAIrFNzPhktGj6gkPwv7+
         t+rXB1Cs8qlfLjzuKDY1a5cyNjB2PZOl3do5x6m8fVnL9H6kGfQrD0k3FnbiGIaKfNiC
         uf0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787168702; x=1787773502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
        b=lkdqnEX7Bs3G3er9XyEm+0c11ldTcttVSTTVqaQ6nMZqD4wocZrpzX97qJg7g83SP7
         t6H1idvtJUSHBjxcbXGlf/1oOCrwMbUiCA4IGgLbMO63sdfjSPFblHAhWZfBeT7jQ34C
         xENIECo6E5awaA4VcYRO1shDCkgHcC28U9Abk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787168702; x=1787773502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
        b=XB1z5FittEAqpM+X/7GO7qYefFlQEVcB04tdw1uNicRM4yZhYu6dZ9NYq8wb0S28dm
         XvkbXswKDqkb9sGbKaeaDcHMAWgdtc+ITWGHyuz43v2uL9lxruEExt/eyuKCf4ySmwo3
         jttRIsFjYOnc2JahuckdpD95oBAaK5Imxsai267vZUgUZd0g20cPDtoR+v6vg04LLZ6j
         XDhlso2a8gbTW66BV/zl1p28/gpCB8bDpap8c1LUPDLZJ13gj8ZUg/npkF6/blwPFlk5
         Vf7giYIulcpyDrDpXdWCrh9RNZ5r6hkCM6c/vTkp2IwPm3/Wbn92xVrQrGQ3JFGWCqts
         HSPw==
X-Forwarded-Encrypted: i=1; AHgh+RqOipdFlK36Hrh3VqgM2H9h4eNcwUDot8RjIhzGxSFhKjeUBR0sYnRc1chOQSDnYp41iCAEctk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5rf6RP7L23Kp4YLWNVv34j1z5O0sab6GZ78NCiA/BYtILwcq
	s99ExVjo3yW4qJI6zZ6jh/3qlO/LkzVYRcDbZKw9jb9BB3Jtz3D+q7+e7cPU7cpXKw1whgA5Pqz
	3pMTd78CdTD8sTttj4fpNo218a4mdJCw4W2647ovk
X-Gm-Gg: AR+sD11RKufHQP1btvuhijg8fDe5dYfkf3SEViuUTr02VQovyEl6g6EeGB9gxktLW8M
	61Bc2zQ9zg9itaZVzmqJ852TpXfTUi0kUY+kQbN495C8gEjZ1fM8dOTiO8FU4m+SjlYk+3fDxq/
	zmJtOL/APe7XAuqClgX40Gby4BJLd5b84y1IKxsnxW4l0+OLuEvN3v84ZsyhfJGagcAWcAnpYxv
	LMTM8LnLumUjbMKDG0M2DIjhCjjTK6lyeTjnwhRiT/lnwjkNCDEUeVz3NdYK+jsEeJQwLYjXebn
	1tAmcduR3HXy7jan54QVG+HHcqYrShO4vRDjFjv4aiFfoi2QbnGUqllY6/gXnQ==
X-Received: by 2002:a05:6a00:3d4f:b0:84e:b7ed:7d50 with SMTP id
 d2e1a72fcca58-851d3963defmr10807492b3a.16.1787168701779; Wed, 19 Aug 2026
 12:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
 <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
 <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com> <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com>
In-Reply-To: <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 15:44:48 -0400
X-Gm-Features: AcwNN1V99rR847SZXdnEMkm7cBtpoxTJZqSrQNy8-DwUpwkE5RcNIZz_017ZO-o
Message-ID: <CAM0EoM=dvzBUxeXVGw83uqqe0Kp0y-6e33hiJ0u1R=KNn9-qAg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 12:01=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 5:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Ok. So one patch per file?
>
> I would have done that, but you are the net/sched maintainer, I will
> certainly respect your choice :)

No worries - lets hear from the esteemed sashikos, if they complain i
will resend with separate patches.

cheers,
jamal
