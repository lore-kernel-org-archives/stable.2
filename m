Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355282F363F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791596574; cv=pass; b=VkGYT33BgruAGr0dYBriEGx5v+/gWKOshHGTKGf+4WICcsz9fBtcezaArrTktFjuLkYxNVFAG1jBqeYiWd26zw7FNg/HAbCXoTcNoWY8vi4OlSO8jBHYfekR9sf12mX5rMAV93KSVsfWuxpKSX5YJd6qfK6sb/TB9S0IKCkLeCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791596574; c=relaxed/simple;
	bh=o+8OqkLCRVEqlAYIJtPEeGd2EGzdU7uZH+zJciEefcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aR0ozmduEahGPgu6JQyeK6UO3SaTS/FSAUi4Wx7ACi+HsOsj2ZvQW3YY9+SrN4Qo8fDDz/BRKxhwBPi5rnv/D6Q1Zp2MAi7s2wJ9U/iuEkNoscxFw62sCQQUf/515lAKZ1y3Etfo19j4JZoliQ4e66UL1R8vtsXCIG2XSP+Ts1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djP545OW; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djP545OW"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a9787a156eso3119611fa.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 18:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791596571; cv=none;
        d=google.com; s=arc-20260327;
        b=Qr4zwdqB2VbJ50LfR6eFwA4qpzu4TidZenPcFQZFku2F3qtxWriZ9rK8BjokHfZMiC
         NakFk2QGbbNf2UTarjFc97Kpsj11CKnDmcHYNdmS6wF923gWoXcXQod+VLh7mw4tx/P8
         l0vt5zemO65seCNFe4pedkqT3+TsGypscP6cJ0ZCiq3RH+GYFDzzr5Z9qMwEONYvZC9q
         tXXVwSvrw2/jq0nHNqF423scMnqJ8wPtLXZVKPBR5ZLU/JJZulM4tOA6sah/plfG26Li
         2NFg4HXzfxKdpkKAL23WaKK5eU70OwdcZ+9jVQXwrLv9GBzFldfPvLyepWIIeD6zAaCP
         4IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rU51iSJF6TI/pyu0D7m4lbncGYiHJsMgWbaT+n+hL+Y=;
        fh=RcTS0G9kSkuu/eFdIIMnPhyswuM3ZymHQ+KIiQHqfBE=;
        b=BAj36E2iyQNiQAEu7pUNHCjop7/1GUyRRwrdmIaUIZpVVMiNui3aqQQCegkkeFnnuQ
         8X0sPoG7CWsP3Nf9Oi2lRxnhVkvk9EbfCdbdJwizhkSkyh94Ad4CKav9hrGrPjxUwiCI
         8GtLGWAqAWN9PIVA+PKTtsu8WNOP5xBz1ec4Kw5Zb3h6nLmV4jax8YjzRnKVYxmQgwcS
         giDfa8gZCQ95/6nWuZ8nmC9LzynfSrbCkQvL9JKKCfAMqWqa5VO0ENSCq0YFsDWr36yZ
         NAOMEB7xT5FNvGkhIoDJK56YUQss3K3u42/mAHXwK2N2Ofm81k3Dy9hUZSpCqj7fjarv
         N7Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791596571; x=1792201371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rU51iSJF6TI/pyu0D7m4lbncGYiHJsMgWbaT+n+hL+Y=;
        b=djP545OWl4i7nLgU35Dy89RAk7/bcAyd3Q7Epu1xORO9XrpGLmUJJ1+ii9VF4y2omp
         nNJ/t0X9sByrT9wP+GWygkWr3S8qwXqGK0EyZqWjb7S2GlD1jlmOAYlxSzxgGUlpSwkN
         QH2B8muvwoybYEd5Km1r4iwOjRu2EuFLM3yT7f+QwWe1FbKe7EBGLJYt+VETNY2rebi7
         145R53Ow3Qr1pRNyhqULzd9kUqqAConh1YIFQBJU6ay9JKpal9WjQRSVO4Cf9oqcU56O
         EHb4P1o1WnaU89RDV0MWxjn+ynB7CCrIAhNZss513clAcG7fPgsjZQbQmCKB1gE7pOPS
         qW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791596571; x=1792201371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rU51iSJF6TI/pyu0D7m4lbncGYiHJsMgWbaT+n+hL+Y=;
        b=s7KQobIof6UG6ZTcfkeWFEpF9smxVGXxG3keB7oY+vfcMllHdoB7VnKTkW/r+S7Jwg
         thYRjmtJDyoxDOpl7GRdnPxlAZxLuG4jcUSnxw54p/9KjGDfQs4iwRcpWI9dB/OCe45+
         BmHNNVAaPeBWYLk5JxkDoczM9julstWAgC3IFBht6SzU3bkHckyB3DxJmr3Np8AYTqAC
         b27DdDE2NUtlcCJqXyg9Gq/0ETlZCGZdA12ewM1bXg9CUuJiCsD1l12bDZqSrtqw0tyP
         3HGRBV0R1Rg0rLp1dumc8Rfa1NsiH5c801o2ekjQ/8jSmZrFvh9TWAhinnF1doGbYCdD
         p7zA==
X-Forwarded-Encrypted: i=1; AKwUvBwln6Q9DpMA4mneAodrbdQbOgORA04k9GcMs4TKhjHktvV0286cNfoK44JLsSw0spICQ1tJklE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVkMuGAecvYPJnysJq+kId8/ccDP938DjWmNKHkwecDbMxBLYn
	vESWBapemcfIBQK/E9YShtiyR9CazSKkG7iLT7BoesDQEg6D3umhZj427byAbCecnfh52aPzd6E
	5B+ItjZTg/DwEz28FBBNhCnYc5C3fu5s=
X-Gm-Gg: AYBFou3jOq/t/0HL1i8kH84jnxXkA583Vmf4pXmq0G4VH5mGh3ruDZBKVg4SNNIUXcq
	veTIWfQoT/KUhRwabTBJUdHVvUv22pQXfLnqy8+MRx8D69160HMMPWqE0KD/5RbYNVDoc5wvFsb
	RT3hRUSFS8LFi4OpkzbO1aZFyezNOeo0kG+nbr/Brl88HUTcMO8w15uzD8RZzDkkbtjzC4hnAgE
	fdaZZkTo2XKv5NwWr3kSFq3qttMDM1d4p7gXdcnOF45vEjeKWke/41sFDqXJQ9KlJzPA5NFHD1H
	OI7HIFKmPFKGdDKbP675FEglwEE4HeIp8cXN6ewn08+LyCvPvakZEl5T/9Weh+DdXOqUhxCpaC+
	/xOdxs3FcZFGpa/+EOs35oLi6y69fpbY1NR50N23gn891sfD+4KIToy0PdsL7iG2PFIx9wA8=
X-Received: by 2002:a2e:b019:0:b0:3a6:53b7:65f with SMTP id
 38308e7fff4ca-3a9c56e2e18mr5714141fa.24.1791596571086; Fri, 09 Oct 2026
 18:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009210449.971057-1-linmag7@gmail.com> <20261009210449.971057-2-linmag7@gmail.com>
In-Reply-To: <20261009210449.971057-2-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 9 Oct 2026 21:42:36 -0400
X-Gm-Features: AclHuK9n3UVIh--yKnm4pNRVW0w9OA63SReP2p5Bgf3nbylkquF3k3WJkqHscfQ
Message-ID: <CAEdQ38EyiERiwrisqWfV+bSy26Ega2AL6HjtJESEts56sWqjqQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] alpha: load the MMU context when switch_mm()
 switches the current task
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 09, 2026 at 11:03:46PM +0200, Magnus Lindholm wrote:
> +     /*
> +      * kthread_use_mm() and sched_force_init_mm() switch current's mm
> +      * without alpha_switch_to(), which is what loads the context.
> +      */

There is a third one: do_shoot_lazy_tlb() in kernel/fork.c calls
switch_mm(mm, &init_mm, current) from an IPI. It needs
MMU_LAZY_TLB_SHOOTDOWN, which alpha does not select, and the
next == current test handles it the same way. Only the comment and the
changelog are short by one. My tags stand.
