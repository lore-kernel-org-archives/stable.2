Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEC45199C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469127; cv=pass; b=CLE9CC661l2Q8319a8Au5bNccw9AhS2VaffkQFfi+UTt/yWMZq43fUd52AbEuWZOHV5pYtYxIJemOOjZG4uOfWZtB3Tz5Mr2CIDmGbj1Q81Ox8OB6nAmPg/3WXg1Zi7+J4N4Kut6jWdqqXG8NO09ilJK/c0YI6G8Stoq7RTIr/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469127; c=relaxed/simple;
	bh=EKdDZrC9AJlrQYmnYkeOnBhcEnSUmfbTXjwDGQ4IKqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+wlhbBjb924mVciJkKSLm46O6xFIomDP5mAIsPCAWvkTOwlJBUm72l7ClDnPQQd/FD2iiUke1jrK0pIisU93KCxk8BSghPRdtlW993B8b//u3E2TzPPxvbZ8jd82UKGhEbc/JpMUS0v0sWc1iG2M1OHbLtSB1lk/vJBb7Nh6MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W++Tt6kC; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W++Tt6kC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so26563a91.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469126; cv=none;
        d=google.com; s=arc-20260327;
        b=QgeU81BXa+r9qkPN9c1X5ZfG0EoYH22GjvafMxgGSMYJTQ2WsYi8iLmj3Oczn0Fv6F
         XUoZmaOYwM3o2DZ70bbTXwwt3Sa48YnFZweybm1dY6w0QZ2dub05bTWfr8AE/m9tIKvA
         a7qSQGojxLoNUF3fkY3oserWncqz/N399hyCJ7W8jfeq002NLesTLOMxtbzmFfqocE5a
         dReyFkSXwCFPiZnTgGN7FPtS+f2+2hINDCMFEwA506s1iwvPxv8uMDZntAXBw32hwM9L
         aCzNgLyqxEu0B+4jYvHH9BqDS7LHnu2gv7ch/1Tp20wN+JVN6O9xSR7dazauGmY80cBo
         c6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VnCf0z9Ked0EoU1PHfiMbSxVtjmvWOlMFbDKXa+KErw=;
        fh=D27jkL5C19MoANVYaWD+JPmVKq5SfMazbXU8tfS6GOQ=;
        b=n4XU1LSGItvaZ6r0evQQtNh0C7jF+EzpbvjSxys3oI/2s3OrcLfFlrHjEWk0J3Cph/
         VPatTotAbqewqT8fQIcySZqlmv5ygM4dLfouzbeglGHbpnMcGnNOomQrkTnHfNK+vv5m
         Koy2RcWwmjFNn6VZJsEYFpCyizegwWXiFFRZKfavaFP1Eco3rcTkceZPEtVm1f71/18v
         LGyF1FwObsrkGPF2DtM1O/q6mLW/3PjnhMWIvujqdYi1Fl/KTcgWNZF3ZTjbkLdkAXiU
         ffA93epeE3w73KlrfKt0NPYJAiPEDvXjzgRxxxzc73I1wu+Gu4rA7AYjO57mQiYT5Z9M
         hspA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786469126; x=1787073926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnCf0z9Ked0EoU1PHfiMbSxVtjmvWOlMFbDKXa+KErw=;
        b=W++Tt6kCFDfCJ1edY2ZlXPrbS4oZP/AV/7eY0y0KGwsqnqeCkd82useFyVxNNzJnm1
         fdoPPTtYfdktzdOIgYRY9Lt6yzJuX11XoPmpKF7XVMmwTsxxg6ESVP6r1CgdfHC5yEfb
         tK9w/ay7CKQBYchS92YRIZNQCzlPb/k0lG+C7ObmRGJ68wofiUlpTvbJO9XqcGR8kjMC
         tqtHot+b5j5HY88ubn0PdTyYMTl5FPcBKPOuKuZ7acWZFUZymANOtBXQ6s4vkTEVvbA6
         8fe13w0kNO3OSEex07/D5pq5PPH4uSngBW5WakOi/US55NbkLiVBZ6emFg0g9hfDKFkQ
         5Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469126; x=1787073926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnCf0z9Ked0EoU1PHfiMbSxVtjmvWOlMFbDKXa+KErw=;
        b=gwvhoOXQyr+5e27RY5HFQ2nxWp0ZovQdwM/5vynHhhc4yuBOfxxnhzkTgALL0K/MRT
         +Bnb4u5Qm0cstINU+55MgYxnkf6S+PR42T5n16cd/+v7mk65zxrC7yRTcpnpnYw+uNfs
         GR6hqheonrepUc9n7HVE+96AOQFpwnbs+3Nl+Mnwowq9kwXuFIfdF45C3BJdbISy47WV
         Wg+VeF1xDHYC2u9wHaZfXitZmZX867SfEUqr0/HHWq4K1P3YA+SERLcQFtWJQdi+joU6
         hOCQyIetQB+blf8m/wt51VXD2+HqM1RzL1C30zIimmpg1iZZ6lsT8CiJsf4g8HHQN7Yp
         4dRA==
X-Forwarded-Encrypted: i=1; AHgh+RqWkob+k/DOUwSxFkqmN5HoptwyDurJi3XsvomT9Cw/bJn7ni6WAI0ci0mCK4RMhk68O1z+ypQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4NM2oAR+QgEQLbz8e0g23oxQDUhGtWpXRvYORDkrgaKMCSVy
	C7NDwnGbJDMJQDvmrVi8doSgr+sarxTDJfPq/PPVDX68fk6zuo0cNzvf+2yuaBEw3VzlgX0Ftdy
	/eg9mbY3F9G9UxCFmCwrP88oMw/L/UgU=
X-Gm-Gg: AR+sD12cVGYvwiHHoUfeS9s7NTNGymoeAQ5OreArUsvqWQKv6jNLZV2A4vJ+GMbnKbH
	lbcdooq5jLs5ePZJi9m3pIaXO7tvOax0heCmmlAmFKKJbaYj2fXzL+qQL2b7KwV7DRrTXlZ9Z/5
	hIPy5XnlbC4HnIdFvjVswHdpvnJbNKnG/KZRcjU3SSq7vjg895Q54sLWuWS+iFlUbOeh+gU/bWB
	GPa298Zgi3GzQZhdb5KlJ7dO1ZDyy11okkurF1eWR5VCO9srUHDlTEqX8HH1eCVGFW9J3efVdfI
	qwEIO4EtHO/BbPRJOwfLELFSVZvBUsOpfyce0yFwMZRCs3SIzUkxPvBglJUz4Pyr0GqEzByvCDB
	/9/Bhhvp3DBIlUejukGxV96jzeX3EdA==
X-Received: by 2002:a17:90a:ec87:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-392ec4d2710mr3743472a91.1.1786469125571; Tue, 11 Aug 2026
 10:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh> <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com> <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
In-Reply-To: <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Aug 2026 13:25:14 -0400
X-Gm-Features: AUfX_mz9ctPsNNIvI5n7PNT1dVO_8-kv7BTU0GjEEq0Wv5KbQ8xlxsfBpZDT3qU
Message-ID: <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	George Zhang <george.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:25=E2=80=AFAM Sergio Callegari
<sergio.callegari@gmail.com> wrote:
>
> On 11/08/2026 10:08, Greg KH wrote:
> > We aim to be "bug compatible" with Linus's branch, otherwise the
> > "pressure" to fix those bugs goes down.  But I defer to the maintainers
> > of the code involved if it is being worked on, and they want it
> > reverted, great, we can do that.  Otherwise we prefer to leave it as-is=
.
>
> I understand. Sorry for asking about things that might be obvious to
> most people here. My expectation was that only a selected subset of the
> patches on the Linus' tree were to enter in stable, so do we really need
> to have stable "bug compatible" wrt this bug? The original behavior was
> not free of issues, but they were rather minor (a reporting issue). Now
> we have this very bad behavior where the display remains dark.
>
> To make the matter worse, on systems that have encrypted root the screen
> remains dark also on that password prompt (observed with plymouth).
>
> In any case, I managed testing 7.2.0RC7 and it is fine again.
>
> Looks like the Linus' tree has more changes wrt backlight, and the
> interesting ones are probably those in the cumulative fix
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
>

Thanks for testing.  It sounds like we should revert the change from
stable.  There must be some dependency we are missing in stable.

Alex

> Best,
>
> Sergio
>
>
