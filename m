Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1039B97F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150177; cv=pass; b=Yh2QpMK98naDKzDcPtjeWEk7DNnlMMlp1JWnneJpec/Fli2wukU6J+OowIAvfamNg95UWpD4d+onPUaM38EVTPEz5MyCwZz09MekYGtrTSS6DG+oJR43fuhW8jCwvITwVs9eoASq3YH27KozjLIiwTlTT/2YI6qb88KPRDspVr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150177; c=relaxed/simple;
	bh=Rermr5O7zQBvdp7UlCslACPvb4RLrNoTG3kGofUdVhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6KFYlVybldhZHOCitpRwyWh3J2ohyEvaSsYz2Fy62zT9MwZ69h9JjurSyzFJWM23LR0yWMmndN676DMttGvmt6qsMtCg52e0RpRHoaXU6Ap0CTTNkOBzrjrWvz16hp3v5TtVkSGa5bcTma3Mx2unMnu9xFP3lf6XxCB2Sl3LiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8jL2mJV; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8jL2mJV"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so120465566b.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150175; cv=none;
        d=google.com; s=arc-20260327;
        b=m2JyuIkM72Ve+HA5maNo1CTnZcqWuf9uyuCpvFicVLe5CJGR8cAlCXP5mpZIWDEI9h
         5Vy5b5ywXQs3iKuEPvx+3n8jQ4i8X2sKLXYRaBollcJ3jhYzM4QdXl5jZg+Re1YgF9hu
         zj14noOmIDesQi8mtmnDkBaD4z7HNYnsnnxJrMi/OpZ24WOyGu+hIrcPJ90JUUPCdPPD
         PkRW9n2BXR1Eipyer37/q5/Bndn6TwPicLECYN8iUWECrgzHkMpApnxzc51OUWJdP+bj
         egiPz/0U4UEJ5B7/HAt1yAlie8C9RAog57LnPYIcCOB+1p5vHyPp6GNNBRW+FX5kRkNy
         QXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1kxdqNC8r0qbvk7oh4vDXSfmPCJ3uT/yaEKKebfKREM=;
        fh=l+CYYVoQoXytOmRkUOcA8KW8PHpCOiuAU2c9Wxlydh0=;
        b=oKIbPDXdagbEMG7QjSx9mtIxmQwcIuHjEZKi8xqgT2wU3swG241GFQiWdG8/zCGwj5
         a+bIpB2PN64Rwkiqm8aRv7zK2ByWmH9wgxlu/phLoW3uqf2dR9A7Qf0A9ZissKFjBhx+
         6Dc4yBiEzf3Ho47bumwTqHLANMduYuSgDfMkXsE6PM1inChb/tyjKeyF9Ni4UfRJmQgK
         1miU1309rgceSYQmzSdNLBGIMkMiIzMEJTVRy4MLVGiXWYM7BcXdqA0Sr1iM0FbrXxRT
         vJ7aCI3lHZf5OLS9j7X/+LVF+amBUVEVbDJuko4yyRMbCoj3hMyLNyeelINUQAcgdKVr
         eNuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787150175; x=1787754975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1kxdqNC8r0qbvk7oh4vDXSfmPCJ3uT/yaEKKebfKREM=;
        b=M8jL2mJVIjpcaBqmSS4xGCauftiA90F4fg6wSDz5FLRZwVNrjAG0X6KZ+U0MzZ3KAa
         g0+99O2aHmPSIrmpu8Mmh7tSAFx4p3kIilBjVJg3zgMUpjYvlUHHncAFtsZCvynCmXHA
         BtVVzLopGmx+A/epzFEsDkDsJ1+o3XChftnOyCNxH5ENxLsT9I406YlWXszvtv4P7GPk
         vrDUo3/FcpErUCyMevGaqb4W5tHPSb0AUrcwHwzH1gLYTv+/qIkmDn8Ku6mf4pLruOCn
         ar0QtIdsEJvhLkt4L7fWOwsAzn6HjF+5bGec/iXPTVO4WQtITMGCg4knsNtknQ9UuFU4
         JWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150175; x=1787754975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1kxdqNC8r0qbvk7oh4vDXSfmPCJ3uT/yaEKKebfKREM=;
        b=c75iKnQVAjOWQlgXW5JY7vgxmGHBof7LMhfDtQ15H+ADtkUESxHviwYhLTkS4V2c6R
         CTT4pKG0wFwgWw7geXVmFt7cdE5WYMTZCRx1IYm25PhKt7f9CDgdfx3zDrJyv4nAR2SA
         oHZa9RJNArs+0teFImBbk8Ie8dIv4vc4h34ROVmy7uo2iw+GiHD1bE9RYDu/zj9KLYpb
         mD2cHJCsVTcxuE787n9jJfgj73fxReaPUVl9+iMPB54Ont9HHo0EpWHgTG2XaVXmZmLj
         tO8Y8kTr/9rdCaUcG/mD7dSF4TpaqjvngYQ1VqWaB++5HHoTwWYG9loJPWqjaQuCZcvo
         3UFA==
X-Gm-Message-State: AOJu0Yy0zaXfCI8vqUKQ6X6gNspbIuhoU7+6E449Dy9OF95rS6G87XDy
	Gdu7JY4LjyetwaagPTBo0ZaguE0UDu94uW/aJF5/bBHPGEjkiawgV93Ip5Nf6n1xb61g9z9S7ie
	W2cxL+ue7DkRlJp34XBuGv/nnky6IMaA=
X-Gm-Gg: AR+sD11B8o5E5Y1oIkN0EJ//7lGwdHmL2587AKtk/88H7sPIwvurYw2Ba6QTaWSM9xF
	aHujgItk1nQ/1ce5zKY1vJSLpJRg0xOfgF3foHilAYec0HVLDjSxwVvmOQ/QDwZxVXP0u8iD1O8
	Q8gSvGSpTGMetW2VfoeqUjkHJ1M9YR265Ob8saAxa58QOjTR9tjnN3ZFbPv+qfhGU/rfuaUnrEO
	nkPd6Q6mV8um8GHr53Fci36Nu+JYT+zI7QsfC45vMNCXWLpTZHYvkWwZqbgLkjk5oZRhQ0plBCQ
	zdPT2L1O/Zo0XHrpDcjzxWFAEIBRDhfJkXGdSPQrrb8vCnu8amSXcHfK
X-Received: by 2002:a17:907:d26:b0:c19:473b:dc8f with SMTP id
 a640c23a62f3a-c241ec8aa11mr334124766b.3.1787150174511; Wed, 19 Aug 2026
 07:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817195833.2971170-1-coshi036@gmail.com> <20260818220420.1@kernel.org>
In-Reply-To: <20260818220420.1@kernel.org>
From: Chris S <coshi036@gmail.com>
Date: Wed, 19 Aug 2026 10:36:02 -0400
X-Gm-Features: AcwNN1WltV1r_MTk7wtZqp-XXKU1SfgA5uG8lLKnaTaE-VD8qiTLMOfCcUY1ZW8
Message-ID: <CACd_6n2VRLvabdA5UVPxwtW34rAacbnssrMKG8wwWx7m8AWVtA@mail.gmail.com>
Subject: Re: [stable request] block: stop the timeout timer when releasing a
 never added disk
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Best,
Chao

On Tue, Aug 18, 2026 at 11:32=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> On Mon, Aug 17, 2026 at 03:58:27PM -0400, Chao Shi wrote:
> > Please consider the following mainline commit for the stable trees:
> >
> >   26cb8ebbfaf7 ("block: stop the timeout timer when releasing a never
> >   added disk")
>
> Queued for 7.1, 6.18, 6.12, 6.6 and 6.1, thanks.
>
> --
> Thanks,
> Sasha
