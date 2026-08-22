Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D6384233
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436903; cv=pass; b=jY3/9Nxm0GcozbQVKyVQUmDU6m6M4DV1zoJ08PuAPKTqH6jDyCyeLcQjNoiLm/jC5TGLziOWlDL086ejVATu4bJhxLAvGnvjWR5hhkr26NUt3GOf4O+4QfvvAEnqcGsXUU9t2uq+L4U26TkZ/sCojKZQWxRBa8Rb7qJcPYF94NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436903; c=relaxed/simple;
	bh=PIQiv4rYFC/YQmUvgpMaekv5c+4Q/IQ4ibbjWN0O0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CG1XUN3kPltMJ3qb6O1LLwUr4bsxLr+/iF9BdCCcEtIlUBzdb7Rp4uGPRCwF8+5F4dyQKkOtKOyf9eigNz5KlYcllXR6gfudooSmi54a6hUH3CQKOa9xGVifSxFP+Kmohred0+SyuOfDSO05oBNSLUvH33eE5sSzDaAHhwV6oSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ekdYeghC; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ekdYeghC"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso1488139b3a.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787436901; cv=none;
        d=google.com; s=arc-20260327;
        b=W/Wev2KLgPBY+W+NHgOxZcpjEbB/aQAUulsnXuyq7VTThA2NGUMCbsVe7EwIoqALhv
         AlZVl9LPlJ4Ovv0MbMrfCqHWta0/U5q6TRHlSDKQy9G5FmPwWqXxCyB4zp3+1C9lvTEH
         /HnVLBOb3tZOz4xloQtqQgtt+b6ZnGjvUQ3eznXSg959rIWLZM+cVE9JTkL/P3ZtL61W
         Z+8hFuSHKcPBU2bp4EAE+vrXbA8BpcsDLStBXI4LAjE7GBgsRjSzeROakZA7TbTGL9ZZ
         9WLbNwG+f8QNnuTjNMrLI127u7xhOVbjUUyaUO0AS1ZTUh3yFdpmnEmvC0nEsgnfYg8O
         ViAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zdfLpdOOImhuOxfbPERCPpDH67KNJb3cbtZdAHIvCQ=;
        fh=9XhkWDaL1PN873DwfhXFLCDjIbnjAOuMkAsyGzPTqic=;
        b=WPLo1oRfXnWTy6rP38ouM9b82x/pHBgkrpOVX1dmGMi0o+BNWtCffdFftPyz4jXYuG
         w/TdSZTfqZxXeGRFvINgnCYXZ6aI2TAWQn4KBx3bWFHH/b1x8dhW6sfnfW7yOB4jhbT8
         WTigPKV1FkMvTQSWOC41Jv+oaKdFHFwmeh6KOTW2tMHE4hogKcgqLWxRYcxfEcRIK2AE
         ktZgheoXnh3illYT/nYWCTur2hfpbOQGhKYtlgVgLoTtZZnMViyIHobgWIYwt9d2Mz3/
         TS/bvhqt64ShZWS+c8qyqUMyv1ooj6qH+fDSlyncNUeDENtMru7eTylZlHrW8ca1qO+a
         F+Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787436901; x=1788041701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9zdfLpdOOImhuOxfbPERCPpDH67KNJb3cbtZdAHIvCQ=;
        b=ekdYeghCRG60najTT/WFTNvsvOyPhbhYg7SBvrZOZChhs8T4+NmNjp/uO5UVqDSev8
         M9hLFK1suweoo87rB3uqqDpiC22pm3PCTexPtaLVQBTwPbgzq4S8142cFf2lfzXZB6+N
         jQVzGksbN+rd8GaZ06aqjGhpRvnop91ItnXLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787436901; x=1788041701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zdfLpdOOImhuOxfbPERCPpDH67KNJb3cbtZdAHIvCQ=;
        b=bYY+swKumbrC+qjJbBpPYpCd1G27bvQJ0jGa5nsNALbwXAYNuF6VUGsTBFt+Bjtbb0
         f2yF3F81c4Qnkmvi+g6n7UERMjxvoNmEdIIs/lhdLiz7NClGhKGc0SJuJjboCEFO70N6
         NmM98+paNAiOXHtrT/Kd+SFDVl2MEz29d87Qt0gimS/BZu9vS1F3X6zDsCAqinFlYajW
         hCAMUcKnvIPvCHg0AtkSr4QIkVPdDB/v420+/u7wx4XzY4lODn6dPXwKmlpFnkrG3rAO
         i6sXPbcnhTbQFyoHjzaouDz+X4D6rzz5GyDpVBNG0dZX47SUnuOwE1Qx/piKI22elxWW
         4cXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCClkFNCUJFdDDfR1yp0FeNxUT2l+pvWavp53ww/ZOzzgyJwxryODHxJt6Fbs+E72lbHoaZoY=@vger.kernel.org
X-Gm-Message-State: AFuF++l4kz/udPj2zu3AFH/eHCIC/5zxGVqfpyEG+LuVCeDgyhYINXpw
	QBPTPHiCM56phAGvThISV6fAxUyjp3kvDyXp5ioopR7zgXMsNFbKUbauhw6Py1Ovkw9QbvuV6Kg
	fel7635P7CQVlHpy9hkS3twabM99UsdEhRjoqzymhl7Jj0b+b6j3jcg==
X-Gm-Gg: AR+sD113HFsAzziKS18LvrYiM7QNw2+8JS3D7GG+VaJ0SfTac/eguP2h0d60ZgKivNy
	jCK+jpTiV1eEXVU4/lGXJ4vs5AvzlYuI9RnXpg/A2/hlFSt/EmdqBnEdBI7r5zdjehfA+U+0pbW
	pUKygmJmJkaCcBZq2bROI7qPfX/+83x3UkAmHoaKHHxjLKEdLCQ+1cHARfMqLrtNDPwjVq2yb4+
	2nLDoC1wnMyPH5hn28twWcHJ7r0FpSVTl7NNcvbS5eL7+9UE9OIAJTCjB58tQr4T8r5T/cWzAq4
	7zKZPXejgnVNAswWF/8MaOvbGOGZsKTIkisdQNOyYf8=
X-Received: by 2002:a05:6a00:1821:b0:84e:4d6:78fe with SMTP id
 d2e1a72fcca58-851f972a7f7mr26325133b3a.3.1787436900774; Sat, 22 Aug 2026
 15:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095742.68511-1-jhs@mojatatu.com> <20260822134401.6545e4eb@kernel.org>
In-Reply-To: <20260822134401.6545e4eb@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 22 Aug 2026 18:14:49 -0400
X-Gm-Features: AcwNN1UuQdiXBVyJm1U15TKSxMfOSROL1QtdvrNqRuFh2b8BQchTMpRF_8rs8n0
Message-ID: <CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account
 to memcg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 4:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:
> > +     if (qlen > 65535) {
> > +             pr_warn_ratelimited("pfifo_fast: capping ring size %u to =
65535 for dev %s\n",
> > +                                 qlen, qdisc_dev(qdisc)->name);
> > +             qlen =3D 65535;
> > +     }
>
> Why not a hard cap?

sorry, where to put the hard cap and what would it be?
Or maybe you misspoke and intended to say "why put a hardcap"?

Or maybe in this case probably safer to just reject the change if > hard ca=
p?

cheers,
jamal

> We do that all over the place, once in a release we
> pick a value too small and someone quickly sends us a fix up to bump
> the number. No problem.
