Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C72D0629
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930540; cv=pass; b=JX4uohZMY81L7nNkzvB3NLQFnUtuFJeWXzGSLzuRJh8cMb6Pev5zva+gNNYw6kKytebovaDVKr+32dwtqAsu/91S0OGyvPv2mvnalUPoKkAZmFcefKlCqHrYAO/MW0ikljZWC4c3lUbMNlree4/M4M89d5+AfKwtsrkXaaaU7lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930540; c=relaxed/simple;
	bh=HezRIAx0sXtEI+YT3JY2PBlp5lPNNul4wM0VNcCw+wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcZIUL9OyWOy0djv3TndhMPrXD5hZ+fXVpozlOUm5G0F45oC4+DtfBBQVqsaG5zu8iB3vx9kJ8GEZO2uUF6mHm3UcCxEXgj0tMMHzKzPSi4kdKDSFtQbMjPVxXq2QZxLwtCbqNr1waUnxtY69kzIvheYx7ZnOtaOkeucDOevV80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1BsHc+S; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1BsHc+S"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so5767325a91.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 22:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788930539; cv=none;
        d=google.com; s=arc-20260327;
        b=QNNdHaM5+1Di/7h50QC45nBbk+QmbTP/6TrGUCHgsDf3IQykUMi/3TmTwuaBA2ttmY
         qQ0sx0Q/jC5gaBw1eJz9Mla91xq+m9anV7MPCZk7WfirDSRf3/ga40G42YNyAoTvrxcc
         B48b3FtyFkZHj5o8JbR8tGZ8PjhyuuDKf3/t2MdyPpT6zKcUNrV7dWw6AFMdVZ+KxjCv
         yqqLUrZ6wZ2aw6vnnowPsGkSX35fMxw+NBfetl9p4cj7EggGsCUTfFVTAENWoJ3Ahptk
         tkXgd7E3PRT9tjKYP4y8x00yIHvpvpTTwdoptJesmoOywGdYkKynse34wDTY1of1obXM
         +Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/lw5mO4gsU3bTOqtJwjVuYg0yHunzGXi2m1syQJ2Qk=;
        fh=lhFkxI/MRSeiBN+6D+ANDew3mk4cWN38Y+E/keda5Tw=;
        b=bRlC+Xeuni9XB9QUrcyNo6fV8iOyHr1aHqV0lVwpXt5wBwVjaPDd9NE8rsrYRig2CB
         JWWNVhizF8Eo0/LK2hv/ftV89ttkzx5yH/U92MN82A0Rp9XG3gUtvojzphtQKfFEr2dx
         gy8W79Be/ptPStiiV6Gfsj+zaUAEdHVanoYuZUGJGsOZJu2X2vEvI4A+JdSevEJ3aEBp
         lbzt5i6xyng2sUNLI+8KQTylYkY/SmAUquRM9USh9A3IAxdFewS7GUhRSiOqhs4jf3op
         eJCnvoB6sNejG2iiXxovKWcDWJK3hZHSNiu79lfNsnUxq8lDS8lbsKwIXycCiCOargjx
         SkzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788930539; x=1789535339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b/lw5mO4gsU3bTOqtJwjVuYg0yHunzGXi2m1syQJ2Qk=;
        b=T1BsHc+SQdk94m28uUKbjgUzkkPvEmLELkLDd95mqwOr0lN4iXQAdZXDSzV4SISC8u
         aHCatXEMmQsWPR8TqdhSL/ud9uo7IXK4OZd8+lOK869Rz1uMA0p+lq3d9ZPpqHXmKVtc
         dqMFRJ/kXeG33O4hI8/W+eBHycPLdUdmTHpcqYij7DE7eDUc5WeNLl0jLDk2dW6tg7nH
         ahCbNgFnD1tfkpksGg0GgpVZQMyZfo8iET239Xq/SaBldHmhYB0r4wTbjJ2IKb6qK/xR
         3j9TgCdkEnJKICt+AuOp9MIhluAEcRQ6gxl5ZDfURuH9cwalSAEqq+ZiDNle1lQxAcVq
         PZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788930539; x=1789535339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/lw5mO4gsU3bTOqtJwjVuYg0yHunzGXi2m1syQJ2Qk=;
        b=jGPXYQm0h5vF+GN7yAqa+gchduY/VSXimPA7Evh/YikAzKDfmOYvcrWX3eVyiX87lc
         csKCFjh6kqExJf/PV4fzp4G1MKx7T51p+Mc51Y1E+1al8fgRaE+1n2P2Fkc/hjphy2xR
         ZprULMy7taNt2gVzA9JZEf0bUVUCAwsLszDCPMymnHLDdpyZFgOs6SnAazBSenzLUEDI
         JsYv29DW0QqkKeml0DChizIG1J2NNrwvH/F0/1zpU61VbyX8Pkk2Bd4dTiLuA9LIzX0P
         MDf0x/ymSFK1+4X9pmwfB3xPfKrETEOGYDkOZhbI04iJg+B2z1w0BDEk5KPXpVk+rdF+
         nksg==
X-Forwarded-Encrypted: i=1; AKwUvBx4ch7mYcYNgfH8pUAPm2LX0pSk4Z3Op1IHylNv57iU2oiFPzrzVCiutxQJ4Ty25eMyGQUuj3c=@vger.kernel.org
X-Gm-Message-State: AFuF++nX1Acn64bxInONbPYzxyOnXTvCpcW98PTV8TGLVpN6PGV1OJX2
	j18pVKubsInBQSxhCtULVLDu4vr6pT1bG1K21sF6pS3Hvr/oCfkzMB7bi86/I3dL6/ge2P24IuV
	4zupdTL7NtEquxP8OC55JVR3LYE2Q6i/t5U0y
X-Gm-Gg: AYBFou1FUyV42ATiN8Rci/btI0PwT75LOkEduuzh9kpY7S5AiXyxEYDnviOrTEaY5Lk
	F8RMbUx3I6hmcqPktPQbivFHXgeSfdLzaB2pDtQ6n1ihwueCgta47sGgK+YkVaKw5KEybLZ4Mj3
	OpxSI6Bikm/feZsBkgylAIKC3pYGy9LmXS6iXCzukMQvIZvhpw3XhBsE3krmBM0PsPbMvjFEsRb
	/wiMSG2lgBpNyZxkiVkzXsmqAQvyRdAIt+lFTB6d8W8mFCXvfij9fnayDucvc/PyOFF6WFxSxr/
	HA1pSS33LqXgqB5qo+Tw4Z57DPUhy7WGrfq/LLs6hCCIdmibPtfwUCaoMuP73Qu2x/7impuDQ9+
	lvUTDqnmvt7AbjCUxWr+a0CPHR8W9HvikXnlgKX9jKsk++j/2l2KgMoVypHZXjhbyY/cNYUkkPE
	LXyFs61fozESNSrBnf8GVz
X-Received: by 2002:a17:90b:3fd0:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39b262981a2mr47513999a91.25.1788930538817; Tue, 08 Sep 2026
 22:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906030429.2085375-1-xmei5@asu.edu> <CAJwJo6asOVa21T==+n7qdso1DBvH6Y3rXo24DdieAQS6XeTutw@mail.gmail.com>
 <CAAVpQUDuHr4WxEOUwikYqdG9FncoY09LOMGDPciHex2bQ51ePQ@mail.gmail.com>
In-Reply-To: <CAAVpQUDuHr4WxEOUwikYqdG9FncoY09LOMGDPciHex2bQ51ePQ@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 9 Sep 2026 06:08:47 +0100
X-Gm-Features: AcwNN1XYHOLlrXffZ4dyL2xhSU8WgL5jBkszIuyqQKj86r-XafJfRNUfbGQgShs
Message-ID: <CAJwJo6b72cdQixQ9Xodx5mhWLVvHgnaULvZ0JFjFhSwDuGvaBw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/tcp-ao: don't dereference NULL current_key/rnext_key
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Xiang Mei <xmei5@asu.edu>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, co+2c72469dbbec34af@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sept 2026 at 05:44, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> On Tue, Sep 8, 2026 at 9:31=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.c=
om> wrote:
> >
> > Hi Xiang,
> >
> > Thanks for your report and the proposed fix.
> > I remember I wanted to write tests for re-connect() on the same
> > socket, but never found time for this, as it's not really used in BGP,
> > as far as I'm aware.
> >
[..]
> > > --- a/net/ipv4/tcp_ao.c
> > > +++ b/net/ipv4/tcp_ao.c
> > > @@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, s=
truct sk_buff *skb,
> > >                         return -ENOENT;
> > >                 *traffic_key =3D snd_other_key(*key);
> > >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > > +               if (!rnext_key)
> > > +                       return -ENOENT;
> >
> > I think this is quite a big hammer to fix the re-connect() issue.
> > In theory, we could even restrict connect()/listen() after TCP_CLOSE,
>
> As there were too many rehash issues, we disallowed it.
>
> 8cc3aef0cb19 tcp: Do not allow buggy transitions between ehash and lhash2=
.

Thanks, that makes sense! Two tricky-to-handle corner cases that no
one uses less to have in mind :-)

> > but I think I have an idea how to address it "properly".
> >
> > I have a draft of a patch; I'll test it today and send it for review.
> >
> > >                 *keyid =3D rnext_key->rcvid;
> > >                 *sne =3D tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sn=
e),
> > >                                           snd_basis, seq);

Thanks,
             Dmitry
