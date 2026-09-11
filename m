Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3A3EDE57
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168363; cv=pass; b=ZvwJ5HCelqWm+KaJfZtvXg7ydPeclnUCRrQmXnH8hj9mA7bQFaI3WaqHDHnRR26UfXVtrFVLMwQqEe2mNH0uY20hfUKcA2fb0zN1va0fu7IpPDdZ6RtDEKeY2NXU8jPSFXb7BwF0VBMZloGvYf1RlCD1S8atarK6gry/eQ7nu44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168363; c=relaxed/simple;
	bh=U5b2EGQ0h1hGiuvcKNAxlYftbTygKbTmyhHzJL26viU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlviW36PxNvEvR9mjuh1GYUI3zNHFz6QOxyoIxrA6qq6p13MkVRYJ632820wZbsMGIlPuXBhijmmoaqQTKEH8u/pQugMYEmaqgJsM9hs4FShEhCswnA/5O+JmhcLrQTTV+SvsN7eRlgap7BHG5HL8Kf05t5xm29exskOQn3epAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bDJBQdJM; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bDJBQdJM"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c6so490776b3a.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789168359; cv=none;
        d=google.com; s=arc-20260327;
        b=oV6tvrzBIAwduXJJyREG2Ht5VRUNQYBRGnJAeQD28nIj3zubPo6icbhY6XaFd3zDxh
         RjJ6GUBXl096V6xZenO7k8WdUrtNCop5kA66kDwnuskO5UVZY22YltsY2UQKTMxoLAyU
         Oj3KzkdX4TRucj2mEBv+4PmnHwz7ycbZaKUoDzcw1uBUXbny8PydI0fooFG22euWSJaM
         34KBFUN5Ydm2VPJxvHAoVlS4SgCtuk2gIF6Wm3VkLIoRsj3xgGbD0Ims2SZ37cZcA0Pc
         +j7/mc23HFzAZ9463QqlRz4z2lPQBXcGaMgvV3trAK6QWyZDDMyLF/HQCraq+abjwI5C
         DYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVHoZLNQTSNiN6B8aYa+VAei/rQkC1SW8nQqoOBjgYM=;
        fh=LuXZ1ORCs0fLEUQS8nKmXDdab877CyReEfkOyxpp+6c=;
        b=llosKh+mn1qgSsqFSD2fQtS2ZzVnxwIIxVuIsR2eY/c7b9NBLDs+WAaAwNlfBoQQju
         IIFp5d8B/Yt2o4OaHQez2h6I+Ezi2Ry4ycpnKLf0XuoQz3IQWJt6sCCSTgfHcn+CRkf8
         xi6S+cKKOg2ax5iNMAQ1raiYEdUsk0a7Sk8k2tqoMgfrpfa9UulgPvZ6ZVjv21Wh+scs
         xheD/7LBDkx0xV4A65sAz5GAj38kHH2GDOVatqLZCxZrv7IA4JJho21WiggZ1anG83Hp
         tvxjMlDUCsR9AOi4iOS2441Azp9Kacrb9TASQraxeS3OrfsPx1vTsK0ur0nja1r284Ac
         1XQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789168359; x=1789773159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVHoZLNQTSNiN6B8aYa+VAei/rQkC1SW8nQqoOBjgYM=;
        b=bDJBQdJMUqEJ50EiXOho9fklpxlxedv//KcHhF5I09IZPnWY0ZK77hZhgg63T4gPDR
         rNFqKhEtwDhvXpMUcyZizQbJpwdfhmhhFrfv3bZnaKdYCknLELNhRVakV/Yl8Mz4qFIE
         YsKakeem92K9QzyrTgL0a6/3jxSKN/yyO6RVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789168359; x=1789773159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVHoZLNQTSNiN6B8aYa+VAei/rQkC1SW8nQqoOBjgYM=;
        b=sPlEvx0bJa1IkQxfSPT6Cn2SHr6mMLK1dwMhMEVkWiszHdP3Rszy3vJyd1/VkSlvDa
         zOmaqWN64a3XORXNjYgqv816ivFGW2fJrdGCTZquyhXu6p4qqUpQksecvXXmxSnqa0gk
         Dp9whuHq6egBnhY48E9dqiC0z31AObTQmcO0+0Tl7v0ZdlM67KPqUX3kg2fRp0sO7evV
         aVtJcx3xMqFdIVqnkqfrVuqDHbdsJ30IQpi3kbceKUIwqrAGacVsMZbeLJC/zYheJ9Ks
         P6cMl2UC6wkCk0s6yk5VnhZIzuzKaJSsxQJqWuq7Z3kA87UVT4FsDvQugbZgHNqFSX2Z
         /9hg==
X-Forwarded-Encrypted: i=1; AKwUvBzVfU7P/zKs7ykYkbfFfS7LGAcIL+H+KIVgGXZ8M2+kVLLNrr8ECSqdjuIzoVbeOcjKiaOc2uw=@vger.kernel.org
X-Gm-Message-State: AFuF++nZFr5kjgxBCrw9sHcZhsdPjAWEd3Cz9T2Tu0EUkXCBCC4pZ83W
	OkuGs44Xr4okCw6pytq2cCe82F3/h9MVz0nhJERyDcO7wSMPOXjjH0hFjlrSEfqGqOajE0jtJPm
	NdjyXiGR4uaUFyPvHGV/+OOKi1q2yVXwoUFxY1M3VfmUXx0SQTjNFlg==
X-Gm-Gg: AYBFou2gQomP6IeuY8dILR7begNGVEFVyn7BPtfkLMoXZ7xlkmBljDDLZXLsPD9MIl+
	BV2EooKonI9cbZ8dcbKiNuhpR4nejgXAtqsTbnQEVwedAOE2h3/dHIMYaVzgVDXURpxl3wGjfHp
	URKD44lu/VPae6IAkN0ksQlBQJeMU3ctE2LFXF/n+x8mR78AcbU1DICLxKTAuAPttWSfSwBpzxV
	+NXVKKtvtGXRS2wDIn/2vmIbS7+2CWzybcU2DIwUO3+0lTGfqLRdB8iPo9HfnCdFjdkSNadk+rt
	wZWsCkwhWbKaXEQ2rcbSBBmKfrr8n0jefd/PYhyTnZd+WAY4UJ6DSjJBOy/Ng0+HAdWBG0cW8H4
	SbdbJoxW7zr0w5V8ImpfHb7BaqT1k5phECw==
X-Received: by 2002:a05:6a00:7541:b0:86c:b39b:66e4 with SMTP id
 d2e1a72fcca58-86cb39b6a6bmr818636b3a.18.1789168359596; Fri, 11 Sep 2026
 16:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com> <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
 <CAM0EoMn5M__WHkniZLw8GNtHpTresTC2dQuL6brmAzUXH1YUKw@mail.gmail.com>
In-Reply-To: <CAM0EoMn5M__WHkniZLw8GNtHpTresTC2dQuL6brmAzUXH1YUKw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 11 Sep 2026 19:12:28 -0400
X-Gm-Features: AcwNN1VxwBhgJyQS3MJEPkDfRRZ_FKlaOla_PtSbjvxx1Fh58EDgtZfXE8iGhas
Message-ID: <CAM0EoMkzo3s7QTLm=w4RkyAbKat3iVZ89dPtPeQoFRvqigs_4Q@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 4:31=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Thu, Sep 3, 2026 at 8:35=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Sep 3, 2026 at 10:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > The CoDel control law schedules the next drop one interval/sqrt(count=
)
> > > after the previous drop, using the configured interval
> > > (codel_params.interval). For very small intervals the scheduled step
> > > rounds down to zero, so the dropping loop in codel_dequeue() never
> > > advances and drains the entire backlog under the qdisc lock in one
> > > call - an unprivileged user can trigger a soft lockup this way.
> > >
> >
> > ...
> >
> > >  static bool codel_should_drop(const struct sk_buff *skb,
> > > @@ -156,6 +161,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
> > >         struct sk_buff *skb =3D dequeue_func(vars, ctx);
> > >         codel_time_t now;
> > >         bool drop;
> > > +       unsigned int drops =3D 0;
> >
> > SGTM, note that this line breaks RCT.
> >
>
> Grrr.. it was in my brain to fix it, but my fingers didnt get the command=
 ;->
> If needed, I will send a v2.

Should i resend this? sashiko-nipa never reviewed and other one found no is=
sues.

cheers,
jamal
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Thanks for the review - struggled a bit with this one and wasnt 100%
> sure it was the right approach.
> cheers,
> jamal
