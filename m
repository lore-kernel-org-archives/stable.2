Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F53BF665
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510698; cv=pass; b=ZQVKYFPmUAlpcTXVXxKSqqMSCc/udOzlVZElfkt6O5JAth+/a2y9mtD5TQRRsSPqnnrihXvb846mJcE6BK2ZBJOU7ePKjG+Bq1fmcxbZmtMPJ6ke60FdhPQzzidq31lBcaoaz7XV9l7KmSqI0eWpn7jV5Hian6tls7UimSuXTqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510698; c=relaxed/simple;
	bh=Zct3tA1vd0s2hqzChN6hFnwvudPWbiHeihh3PxhVjYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2fbVJhKlgWRMOxHyYYyd6Q3PTA/34iz5lIGUZVnBQxYg7wsftX6knEFa8OUYEjma0D/sOtUefnX2wr0wIyDQ3ZCMaWtwljdjkXedXKJDt5W23MivuwQiHWG01QI5AK/vj4jLEBaSRSOgq76RvSsM9RywYO4fslWop0pUM1D5hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=G/mQasY0; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="G/mQasY0"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8520161fdb9so867228b3a.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788510697; cv=none;
        d=google.com; s=arc-20260327;
        b=hGS0a+17FtRfWzFmwFm+FaRELeIoCAGIcV03pZLnBbHpQzatwyWK2Zw2BoYW/xtZv7
         +adrcpouD1s+WnSbhSAveFKOzU58YYNsvM385BGUsPDHl1UyEU+9gGDXgnQhYH8NZR4/
         yPtF+XHQ+O+Sj6o/zJ5EE5tEW14OYeIhcpgF46xourHjRJIuH1PE+qnbFX0ZO97mI+Gn
         V2d2ONhhs9qCBso8+RvgonKPqKY1BX9Xnlatjol1NS5fmK+9sG5r2vsAZU393vsMk+la
         AbvSvcROFOJV1gADnBbyYwLJw+KPGXaOyzmt+zP9fTOTYNIgpEnWWJUy5ZvfGS+nQbkQ
         T+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=707kDHdR/FNIPTJBC69xcl2naZm5MV0ZXXSBtfd5zfg=;
        fh=5Ix9ZlHp/tEtPnAUpJC0FoKyLzbtGXYdCuos8PaAVBI=;
        b=GiE1Kuq0Aom6onl4Axmr4lI9YW/vwAWKC2MYelUzw4bSzRtCl9sOEagQFAd0JBW1ha
         pvyqKYqC4qG6AlVYDeRhs/lQWw1M/8jGf4HjbLajqqX9XPGcIQitQdaWvVlXBFx3wyr3
         JH68hCBQExpywsl7vu7qGsgp/ezCCMI+sOMKk1u5Netq0UjU4gLalL9qQta+Cx2eK1/Z
         r03alLTxjgp/U38+VW8+4x2v64uvszhhN8NUD+m28R6rLVSqhIJ60ApnTE3iYojXiy3m
         LFtT5PdpJShWChfteqbSAyZtsck+xLTYzqbxjAg0VN7EAgV81H+hSnnTao6wVovycMfA
         T7wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788510697; x=1789115497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=707kDHdR/FNIPTJBC69xcl2naZm5MV0ZXXSBtfd5zfg=;
        b=G/mQasY0lkxTaqkd/jFbKxrubAv1G0XGsGNvlMCmBi+0qacc/qrMIsQ6VEi7jZuh1w
         4kWfb1df+/30bthZDhJ2o1ADVPTXE0Le/enfrV24hlCXRqI7rsGLJKGEPMdnDuSffuz7
         qZ9O/Hc/9HvRACOoCOgLAZaAZo+tLxwbJaBpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510697; x=1789115497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=707kDHdR/FNIPTJBC69xcl2naZm5MV0ZXXSBtfd5zfg=;
        b=CmS6S6MTKqze9bYFpq1rOhg14abBT4iK/FXev8/YiQyY1yM+ptVgkVtAe88qBrQ+xc
         qVbWD6hg+gg5De056JJfqg4rmGFVH8R1fiMEsXT2Sx9YtCocaza9bYnWNc39w+aHpHFG
         9k6KahwO+H63WWYRtETNUIgeqXnExGVZn5BV805aDNhwsbB6V4Yuspr3sfryuIG0eAZZ
         iuhfMz+2kZKRgrPCnaQW+Atlp62GNji9Bd2DRRcRhXwFBIJxgnQWmw1LVOam4NLY9xrc
         W+w0sB2pnQSZS22hcNo7Njviv7f8swI23jr1stgWzaBnDXPvRtqkKIHz6zfRkgpGC5Ta
         aCtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv+Bal/U4vu5AYQ95LSx69hB3hNZt2z9U+ZXcoBQ6y4fLRyH7nO851bBs0i2g6CwE6+ZFwGIY=@vger.kernel.org
X-Gm-Message-State: AFuF++kgt8LzqQhFn3JBx85ihqIbf9SXzJC3qoH6/n+1gdMSZS53e8VI
	p5YsfstYxM8jwfadlxlJMYob6CxN/31dWpMosRVQh3SwfHkkX+vT0KAuKhWNaXnXZXOJu3b5FcS
	gQl6e1ZtHPAMT5dhiPX0aSd5/j8GgFPxByJe8OLYi
X-Gm-Gg: AYBFou30w103eoMjAiqPn9qSue40xTvktBGwh4w7HobmHq22SgyeO3JcKQuAFtRJ7/R
	ZdnEBQ2lrL9Lu3mOb53xLOXWV7AIG5W8r2me/E9VQraB17k625C5f/j4XWaLZzl0Bw+ohFX2RM8
	AukjdL/WTqvksduJ2bAx8OMFnxQ+I4xvmkufqSk622I7uFHeDT1+pUZdA00FN9i8zHK7P6kitTA
	52rK5oSMhYlM9+dE0D0xU3kmC2bNSTciNzTPvZMjwDxRmfkClvbO0CRLjIcmLVf9MZ8vQ2mzSyF
	w9yn6QDlO725ucGlqog2CYzY7D7qzQ4SjhFxKuJmMEym9I3nmbhmFFnY5iPSsd+CCswkbo/qfFe
	IC7TDV7oc7OBW2Vr7ObHPpf5DPOnkAx/h4Q==
X-Received: by 2002:a05:6a00:178f:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-8616967ccfdmr5757402b3a.1.1788510696674; Fri, 04 Sep 2026
 01:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com> <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
In-Reply-To: <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 4 Sep 2026 04:31:24 -0400
X-Gm-Features: AcwNN1UO-DsxSwJBEw1u402haO7sGBSEBLy3v4Unf6zC228XqPGtU0z0wn8jRpg
Message-ID: <CAM0EoMn5M__WHkniZLw8GNtHpTresTC2dQuL6brmAzUXH1YUKw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: codel: bound the dropping loop per
 dequeue call
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Sep 3, 2026 at 10:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > The CoDel control law schedules the next drop one interval/sqrt(count)
> > after the previous drop, using the configured interval
> > (codel_params.interval). For very small intervals the scheduled step
> > rounds down to zero, so the dropping loop in codel_dequeue() never
> > advances and drains the entire backlog under the qdisc lock in one
> > call - an unprivileged user can trigger a soft lockup this way.
> >
>
> ...
>
> >  static bool codel_should_drop(const struct sk_buff *skb,
> > @@ -156,6 +161,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
> >         struct sk_buff *skb =3D dequeue_func(vars, ctx);
> >         codel_time_t now;
> >         bool drop;
> > +       unsigned int drops =3D 0;
>
> SGTM, note that this line breaks RCT.
>

Grrr.. it was in my brain to fix it, but my fingers didnt get the command ;=
->
If needed, I will send a v2.

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the review - struggled a bit with this one and wasnt 100%
sure it was the right approach.

cheers,
jamal
