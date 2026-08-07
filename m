Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0731CA4E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112658; cv=none; b=DvNYQ7MvblQUdjE6GMujK0krjQUg/UI0TBMEhdfWuTyseojfvileMiRjWGvkCHANw52253kGpldKPn6ubkvSKwBdrKtexmiinCURFACIyDTrcR0yjHjelMqUxXWcxELOB2cDJVhP+dVW3L7++7zd0gS9sw/R6Yr+sIxOINYcXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112658; c=relaxed/simple;
	bh=G4JigUvci/jEjPBhVDLUYj0Nij9+zOu5w/lLNwfurek=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qK4bNoLT2BITDntGPurxPA3CaKh+hb3hvGt53aG3Rcvf4+LLf9R1cUUFXp+InaBJ90rv5IcX+BO+bm94GdRRTWh33MRT5eT6oe64zNcu9nqBv+txluuIB2cO/Bp6bY0fGL0PAhOGKnWO9cT8z85fdbDH4jAB6VGLxV7oKG7sAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=r8Us8PZr; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="r8Us8PZr"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6acb63301acso1639350eaf.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112656; x=1786717456;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G4JigUvci/jEjPBhVDLUYj0Nij9+zOu5w/lLNwfurek=;
        b=pQzDqM1ngCqH576VacHJK7k7xXXFxw80d8hGvvtRR882A+QkyZ0hsKdfOOhyvYSbxU
         OgENHkHcJx+uq2CorP0g1h4EG2MiS3Sm82aE4uzzvFpsko8aj2LeAVnjMSy41JqUDS4+
         lqwWb1oFJhRAi19maCdn2lIDhTitjFHzuC//2DN4c5kFzghS2iRPcrmpjyProKwCZ0+x
         ZAxjwKlvUnl3NJBYwy0N26Q4anNsInC5KYMXtieLlaYsQFRAbmPMTSnlHi18l3isgZIe
         88AWGtIwFofKNi4Q/wklFzJZRL5hqMoMT1Kl42ZqRXJN6eKpajw4dYt2rQa3SIlRxSnJ
         rLrA==
X-Forwarded-Encrypted: i=1; AHgh+RpYAMuwFPrHe27M9tVTo4N5umTwenzBEnjl6cf3wTGrgLXYg6Ao8Vo370m8HXh7l5rUhVaaCoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7123O/Ynvdo771+iDMwE5IvPS7g7jjsjLYLnEzol3eAaAuJ0
	4NO7ecZnPvn6tYn7I/Av5gtv/TuE8d1edtzgj8+kqoQ4yBsJ2I211Y+o
X-Gm-Gg: AR+sD13bNPPq1KldXulAB2VZ59M46I9jwlqk58O7jZwBFE7vB9HBP1qO69bEEpu2DWf
	8PAJz5lejiOR8mXGkj79joeLDc9+UMKurH/X7HhiP6O7HZ+Eyg2Q/VD2QQIVf4RrWxHn7zQidzr
	oiS5CNA7DZFO4uZR9x/unfP6yFVCzn5MeZijeWIrhdQzipGd3uF8aerevgpk9PtY2CDC+3vITg/
	J00eFaa8EdUvGfp6WnnF4rkjD5ZKaIjq2BYWhpMW8K2PhV/IQA7RnMHekdvQse04SqBGD6hPV01
	JkfaYKl5Z8MhZ2Do0NWm6whIw0ODLQ5S5lHwNXEz7kzgLlAGOSzNhk8CCiQ6lt7i9gkK1CwTnfx
	eOL6sg8vwFGAafoG0e8e2zo6VMglZUwjLu+3oOb4CuIR819N5FR5ybDKm9n3evinNZNahMn/TDK
	a5ZlizsDTtTcQeDMc/NI8jraGgmbekqyJY2jPn2RyOJI9UwvaUiyuxatKb2ibaqO0Z1i9O5kNr7
	vfsJ2eYxatHW0PFBLw770Y41cPMAICVQNBWzb3ZPkGSOCIe0CTJDgXkvtQeHbHpS1q+VDrkGOh8
	XRA=
X-Received: by 2002:a05:6820:f007:b0:6a1:451c:9cd8 with SMTP id 006d021491bc7-6b042da34c3mr63442eaf.4.1786112655683;
        Fri, 07 Aug 2026 07:24:15 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm2408541eaf.11.2026.08.07.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:24:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 829D6609E3;
	Fri,  7 Aug 2026 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786112653;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G4JigUvci/jEjPBhVDLUYj0Nij9+zOu5w/lLNwfurek=;
	b=r8Us8PZrMwruUGV62MD2igliPvDNuaD/ikBeMxWX6pa2xnEZds2E+peKfy97Qrh4E14dtW
	qiwedx0VHfVUM7V/ZO9sZ4oh0s3uyhHvnrQBVgDEDa/080pIR473B+gPhtjCmAvIgmV6Hs
	KFbUExcXyZM5ZmlIF45ZKFiE4V5peU5CSxNaj010+z52rmhOgbcnGy0VI1PmcbZ+Y3OXzf
	uHNF1eyEQQl7Qp7O4XjIfScLSlHJx6b8vEs6PVkWxqie8QbZlBJ2ddv+nZTPk5jp84dv06
	ORtLPshfw2pU7mRJHNPuJ9mzbxTWw8CpiVZKT/iBEGJo/ufZMqMCddResgZLzA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 11:24:08 -0300
Message-Id: <DKIS3B7UYPHB.2DJBGSQH050R7@marliere.net>
To: "Greg KH" <gregkh@linuxfoundation.org>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?=
 <ricardo@marliere.net>
Subject: Re: [PATCH] selftests/bpf: Fail unbound UDP on sockmap update
Cc: "Shuah Khan" <shuah@kernel.org>, <sashal@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Michal Luczaj" <mhal@rbox.co>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Jakub Sitnicki" <jakub@cloudflare.com>
X-Mailer: aerc 0.21.0-146-g87073a0460e3-dirty
References: <20260807-selftests-bpf-sockmap-v1-1-8c4936fa03cd@marliere.net>
 <2026080745-difficult-batch-6866@gregkh>
In-Reply-To: <2026080745-difficult-batch-6866@gregkh>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Aug 7, 2026 at 10:58 AM -03, Greg KH wrote:
> On Fri, Aug 07, 2026 at 10:45:27AM -0300, Ricardo B. Marli=C3=A8re (SUSE)=
 wrote:
>> From: Michal Luczaj <mhal@rbox.co>
>>=20
>> [ Upstream commit 203b06932777b9ad5085319389dea566f5c2ca63 ]
>>=20
>> sockmap now rejects unbound UDP sockets. Adjust test_maps. While at it,
>> check socket()'s return value.
>>=20
>> This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
>> test_maps now that sockmap supports UDP").
>>=20
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Link: https://lore.kernel.org/bpf/20260707-sockmap-lookup-udp-leak-v4-4-=
f878346f27ab@rbox.co
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>> Signed-off-by: Ricardo B. Marli=C3=A8re (SUSE) <ricardo@marliere.net>
>
> This goes above the --- line, right?
>

Yeah I'm currently fighting with `b4` in the stable workflow :/

> Please slow down, there's no rush here.

This is actually a different commit, I sent before seeing your reply on the
other one. I'll double check before sending, thx

>
> thanks,
>
> greg k-h


