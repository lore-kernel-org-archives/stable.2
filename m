Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF91D89EF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407095; cv=pass; b=G0i7qMHiUisxdWXJBl7C0rEiumaxfZMgE7CWSv3Cbt5S0cZB7MA1ZDKczuJXEIe6LNagZPc79IYrY0P2bKwbahinN7tIQ6IDc/Nt0R8lH25BBYiitak3lESQlvRgWExDPSiDtpB4DDduSUKtGH6ZNF+9dh/9vFHADIF5xkhf6SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407095; c=relaxed/simple;
	bh=Mq+1KSle2zOd9Gyjj4bdLdpe8xmZpzSivqd1nkt9t/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qc/JAvw1HYJ7ZCv+hdza48QsCF8/T55RED+u3MLcu8qYiaDS1hp9tFdLiiUg94ak5Ga1WzFgh06Q6/f6DLw0OgQC9MEEZZ6YTOpGGaotW6eqfDgbrAEovo+W9fCu3YHQrZCDaMfAmF4idLnIiSMdB+i2nRoxU63e9oXlLRYjxPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XG8MJ5y+; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XG8MJ5y+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2437369a91.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 17:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786407093; cv=none;
        d=google.com; s=arc-20260327;
        b=pPAjtZfnzfgxqduTqBJQeRkbRRxGu9cMqMPScQwxyS/Z7sWTMd4i7r/9HlXS9l+n+K
         WwZUyLj9XNzi6lz/TEa3njwsT/eqYd7sSaBzxpdRFZXPlIUbxtncihBsy5W52z35bTeS
         ozMPKgLUgsFHi+yoXCszFtM3SfFBcDk94evGqPf72tAZeOExmZBurXj8mZvbKYHVn2tS
         eho64QrlyeOfDPtrgTaMZTBjV1F4s+CBBsLcBiaLnYKvgKgX+2YlK2FAISmpUv0UThyH
         rDEkeJNj9tAANIHbq/KGQVy1jLPneZimTgq3zSfjp+W+P1ylYKl0mUdK9wKIMjOlMrWW
         PcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mq+1KSle2zOd9Gyjj4bdLdpe8xmZpzSivqd1nkt9t/Y=;
        fh=nXR/QCwRcZXeoZTH8SbkdviyeQmcfXkZqQDvSeFVG5o=;
        b=RioBgysGQrta4UrjI3Zjn+v9u+JkMWafoutaNrl4hBxPK9OLMcKJgM2hCiQGkMnzTl
         1ybjeY4IYSlVFDbEPfQALgCccJHmfW26669eeXa7CKnaIYMMq/n/qTC3EK0A1HU8J4wS
         m268CMx2bCFVaUdH25j3YOXu++6+Rx6NhA/beGjrkIJcb2Nk06jNR8cBBha4A0TwPgl4
         OsR8W3a9a+BjQBCVaV2lqQeLrAQY71M3A4oZ+sSygcEgc/aU/VW8QxLkN4ykilPyfft1
         RU+8Q5inqjdIJNkgNb1mdFA864R+9k1NUc0ksecSBXw6q+jGrvVKj1imcSQKZ7DkoI2/
         phWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786407093; x=1787011893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mq+1KSle2zOd9Gyjj4bdLdpe8xmZpzSivqd1nkt9t/Y=;
        b=XG8MJ5y+TKfl17vDsqWor2SFzkvBDVF6C+TTN09vSZTVep7dhr+RxmosoI3tSYLY4K
         l3o4iDGki+s+v02a0KnaRkdI4Pwa4QGy0TNmn6FdMq/9UnlBf/RlyBn8y0qWV539axLM
         w9q48u6h0WPzF2SSU8y8ulmPcEIx34f5ZeHfVBbXZxA4Fj6tqeYMZXyXG1VJ0T+r/Xgz
         tMZUfQcONzYTTjLzeRwAvEWsUPQXfQgR1EFKF8aevln0O9hk+JXDhVQpVwq90I+heESf
         Ct5IYiZZxE4weBWetmZVY9rrx+hqQJ+ZeP4AyliWNQr5aRTjo43vWhkejSrobB0U7XBE
         q47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407093; x=1787011893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mq+1KSle2zOd9Gyjj4bdLdpe8xmZpzSivqd1nkt9t/Y=;
        b=s1zU0tPuztdQdt5mYYRi4rFveZ/2L2gf7r3WvGD9afeMRA4+D4UVeFo7VrCgiluNT1
         5oxARjb7a2EZcdkVZlJVz5pjKxCeXKcsNCXACi6l8e2reRjt8sf5NR5/tqAxRbWTn95B
         MEHTnZPgHV7B4gTzrHMSVzFdIpCKxLmME6Gjx5wjQh/d6m+oVBIlkODVYUloY/men9wQ
         KVlZ7Ty3mkgVPa+ySKPvIhgFR7Jitil686Ehv2FdGl+mkgpQkxQPjS9hpQJokvDJc+VJ
         Yn8Gb5/lx4O6W1MX0BQdBCtOzM8EJ/IpsnrStAXZXSn4o7ZX1ei5jarFmcuWToS2g6Rn
         cfew==
X-Forwarded-Encrypted: i=1; AHgh+RoooSAyZv7fdBCLdAFsfQr14uVI3uuDCuxyGu7FXKlqvWZP3trgMMxBQpIHtAmMmGzWgiJGBlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6i3O18hKqBITUbN0fCJtP/ru2yKQvH/Vb60Dxh8MZYNq57W5Q
	GKm9Qtg+Vd3ZisBaY642g37SFi1ehGU2K0qeINnDFUiQUG7+Jxxn5jvWJr5K4IT/uazlQO2SX65
	46XMRkXzTTyhAH+EMm49iUKMxhPc0mboJttF/Dgg=
X-Gm-Gg: AR+sD13z9atQgYHMssAI3HwwjdEdRnhBH2V4oX9t0KPnUXF8QajmVGESgcLadkcjYdK
	GfAyQNp1JUpHj1AM0NQKWk7rPbr4oFPXuVDXGFpPErqemb1LWcnEA3d2r+iZOvsRTuLtT/ZxLZP
	sgOj7MZ5Ly5RZ03rAYZQq/lv7ypoXNPExL4D6oZwcy1AIRDi20eoTwM8bKlxfd00S5XHCK2W3uD
	KEg0fSa7jKCSwMaU4CvD721VL3Ske4DQ0MJ7CWnVzzJz/Id5Db8CM5W4VqQGZpnNFLjciYaA9My
	mefE8e1P4qgb5c88VkU/2oGsezQWlWOV8eT21NdR97n26YLtJjNW0n9XGw/rVa63FxAQE7ltzmW
	eHYpoZFhJvYnbxghNQ55x0tYfF2ejTIu9U3KpLZPcFKn1IofbhG8+uj1mStTadw5ymjEiajN96R
	8J+Hf1k24=
X-Received: by 2002:a17:90b:4fd2:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-392cc8d081dmr5541201a91.2.1786407092626; Mon, 10 Aug 2026
 17:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810073830.GC1642880@noisy.programming.kicks-ass.net> <20260810234738.0004-1-sashal@kernel.org>
In-Reply-To: <20260810234738.0004-1-sashal@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 10 Aug 2026 17:11:20 -0700
X-Gm-Features: AUfX_mwVsMJGguaU9UvzOR5lJs3kgwrZBERYuQwJWyztldT9g7AVPwq5T5lfaes
Message-ID: <CANDhNCq7sFij0uCT75B5aT3voABaK8-=KMbKMNdO1Yi6QWRhng@mail.gmail.com>
Subject: Re: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix
 EEVDF entity placement bug causing scheduling lag")
To: Sasha Levin <sashal@kernel.org>
Cc: Jose Fernandez <jose.fernandez@linux.dev>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Janne Huttunen <janne.huttunen@nokia.com>, 
	Zicheng Qu <quzicheng@huawei.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	William Montaz <willymontaz@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 4:57=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > > Peter said in April that this could go to 6.18 [1]. Janne Huttunen
> > > posted the same backport last month [2] and Sasha is holding it for
> > > Peter's ack on taking the revert without 4823725d9d1d [3].
> >
> > Yeah, this should be fine without 4823725d9d1d.
>
> Thanks, that was what I was waiting on. Queued John's version for 6.18.

Do note, as Jose pointed out you should probably take: 80390ead2080
("UPSTREAM: sched/fair: Separate se->vlag from se->vprot") as well
then (ideally prior to).

thanks
-john
