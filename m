Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663F1DDC37
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316054; cv=pass; b=ThqKdIrqftYUzx+GKS7/PAGAzM/nuWTLqj1+P+JxnkcCphWHYT3Zhx++pQ2/Tlbqyar2kkXhvBaoLGFxoxUfUHENpCLLBha3c5ZK/VemwheLWglKleMkZmN5bITCgHIDlqKFs5Cm6Z2Ei+cddOhZSJbepk1IUWjDG+NPdC+h6qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316054; c=relaxed/simple;
	bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryVFwvAp1Ot89+NVzChxSfDavdDVVU7Yeas53o2QyN3bK1NwRzqOOWrHpsRyzIz1SG40coMfunEso0dB7XiQxHranCQvMCtve50aFoOe7Ls+Vim/3wVgJfA5QY0ilZx+XUmR9ThD8EC6g9s6SU4IpkjhYtTuA1LRYupN572B9Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=qy8ZZVaD; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="qy8ZZVaD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a652535dcso512724b3a.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 05:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787316052; cv=none;
        d=google.com; s=arc-20260327;
        b=Ys9BmMp/62rJacO8LdYHzCRs+DZdh6TBrJjNQA3ibkAaHtQ6u1Fe8GDrlo7KZXwvlH
         AemA+D1Mb0Mkogz8aALSmzmISXAPYKxMUSvKqr6untVQ77Fe2G22v1KS26rCBDmADr3f
         AyVyQVX6ffE0yqzGEzluhUKz7NmaxIwWIEvYtgytVVVOFEOZkjttE/32ui2BVMQuciCa
         3QoyEKfIpgd0RdG/kPuysn/pJmVHc/f6Ld5qfWZ43wzRGa7JBz0KT4Tuhamd8ExvKI46
         j9i/GwKn1TP23QxMyE3OIFiOjnl3nAryeA15xmzQ58eikJE9YAsGrllzp1TuNkW+40Aa
         yHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
        fh=KrHLeqR87MS92Eb+N2A8BdX4d7WhMZ0jKkGe/TdOfl8=;
        b=OWVFSLUoC8YPZGR5N9r1cmQ3LI26+VsjLBilvJu9h65c0d7wS3t6RhRpOlH1dJ+e+B
         eKXdvyr4NL483+dOFmqonW2/JApt/zdm3YWdHYyVEsezrMUjB4voXvHPCOpgDQY1VZyX
         B5cCveT8oUko1EmNIAyLXEYAk9K0DM4b1Ri2jxmmiEiOJFvwNy5Pvv9hRPk9GGvR96I+
         BaY5Wyle+uXrkRa0Sk+/pNqi5LqzEi0UYUVY1C7XGbvdXymt4m2PJSDTZ0JcDWDKPa67
         9ZgFP8QH+J0/jmrVtvIBcyxMOyLvgeiV5puAgFvyNIqby3nF8Y882bIHiPMyP1XxbJzh
         joRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787316052; x=1787920852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
        b=qy8ZZVaDcaA5/dBfO6ykA3iQVHmwZfNsWoXTZeXKrJtt4vFSRDpPvpZszz5Kydg+7Q
         V778QBlcW29W7PWm5Zmo4Zr+YMJzgbiFPgNgCib4GYioF35XE50TDMQKjPbVct3M94Dl
         pkLhSN7S8K1PAKZ7dh6dtbG2jtr+39A/dwYl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316052; x=1787920852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
        b=Fd81NAZPdCm1/Tiqw6B/ipqYWO4mxmQcHjtKCoqkkTDrs9L9xQaw64Xhj1pArWaHs2
         paR5SAFjx3il12Wz5v5DXmWm8/vd9rDU1PS+bCFZYPJjD38kZ/OkznNFFZ2pdUlJcPpU
         QWDMlcG9+lJi61b/ENWDqTSIEJJjzMWlz5q8HEXVRMHNjcP8CMNlLN3pNAqrujQE7kQo
         bDZABQlhvoHHRuLlhogiAz0fZ1bH0LSyrtec2hGy4X3E74v8t0TP6Ritm+bzmnYSO6+9
         YzyUBdssv0KqlLfiBDvlHZdxeV+Aelm+KRHcfaMRZ3JnjCX+JW18xkIJ02qHRhArkvMl
         cXXw==
X-Forwarded-Encrypted: i=1; AHgh+Rqng1MaOvmQM9dsKOYiKbQ162CuF54rmi73Xx7TxLG57tcSGO+RRuQpe2LtNeubPUaPHOOxqPU=@vger.kernel.org
X-Gm-Message-State: AFuF++lvg2VIaPWpj20/BFIgkd9aA9XDhrRGTqA+kZiW1ZgbX5ePRWQ/
	vwVpxIWAzoa3yQUcVDvUaLqLqditIhe280ElmtKUEll/ySLigp1XxtczksheuR0XEI2UP2xN7oN
	Ch2XQJhUVJEpxy/uyGk8YyO0YkKjS0Lxogz76u5qR
X-Gm-Gg: AR+sD12nhVcC9CcMgwxIG66/I+gbH697BqkewvVFlkKgnATG7dKrjqr9mMXmufYwvn5
	A/cxLE13v1/tZOJoSXWeWfuXZGX3bi/vybrt3X+5ACfeieHzsiO2wyxFLva8OzUPakY35dyKgF6
	3WjqcznLH8HKV87Fc1Xv8IvYR7dO+m372ciJBm41s4aVKyDhtjqYZEdi0zlBESh4l2aVNbsl4VU
	JGahdFwc/gU1PhHKHxxcbyPdk7OzKdLMXhT75tuhJzQRpO5aCLMlkFV4vQ9IzLcchslKXa408sE
	OD3amTXmZN8uzd0IMoYPzA510dgdCbO0vfMepMPQEUSz9bYhyb0v
X-Received: by 2002:a05:6a00:2394:b0:845:dbdc:8652 with SMTP id
 d2e1a72fcca58-851f9a295d8mr9588657b3a.2.1787316052165; Fri, 21 Aug 2026
 05:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
 <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
 <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com>
 <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com> <CAM0EoM=dvzBUxeXVGw83uqqe0Kp0y-6e33hiJ0u1R=KNn9-qAg@mail.gmail.com>
In-Reply-To: <CAM0EoM=dvzBUxeXVGw83uqqe0Kp0y-6e33hiJ0u1R=KNn9-qAg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 21 Aug 2026 08:40:40 -0400
X-Gm-Features: AcwNN1Xq-xdldO-PU2Uv6LCy2b6HZO5pjL2hlQ64C15yBGx5SLzPN8JNIi8EHk8
Message-ID: <CAM0EoMmXh3buZiPrb15A034Nc48ucwjPz75N2viYr1b8QmjfwQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 3:44=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 12:01=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 5:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > Ok. So one patch per file?
> >
> > I would have done that, but you are the net/sched maintainer, I will
> > certainly respect your choice :)
>
> No worries - lets hear from the esteemed sashikos, if they complain i
> will resend with separate patches.

Ok, given Sashiko's complaints (some of it legit) - i am going to send a v3=
.
And lets see if i get this patchwork instruction correctly:

--
pw-bot:cr


cheers,
jamal
