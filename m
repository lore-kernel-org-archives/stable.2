Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23627707
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577611; cv=pass; b=INNpa0vIdKmJrcIvoGOzh/n1SUqNmAD0rz5U4j5JbHpL/s+sARQVJZIqNISkH24HFxT0o+qgTGEUIMyfmW1aJW3GpiqYIwE9ldBareGDbZLCyrKhTABIJWG7glpVPdhlPVGSw5+HZ7KBuB6br6sKXEhIInIBcG50SYhqQxID0lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577611; c=relaxed/simple;
	bh=5zwcrhlBNuIW/SXWnuJp7mKO8MQPS5znGHCoEmAaylE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqRgtS+8YeVBQsBveb5wX76Bj9PS54hG+p1C68UsKlDP8LgR2HEAMXqI94fQWPmJVXtJI4aPg/LtE9H6XVJM/l0pwAZuonWQ7f/Zl4S9NqF5O2DtAHVlLTwBGyVtW3isyZfFBEEaJ8eO/mjrKpFZx25ym7lJWH4QSyiy3nGPTMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3vvSsfE; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3vvSsfE"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66095de1c10so72196d50.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 05:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780577609; cv=none;
        d=google.com; s=arc-20240605;
        b=KFVP3xA0tGsxtHqbTRgkOO/vEQ/M49L8Yb3M6pvN0fkqMg/eThurvEqRUhJi7/fdWX
         nqjA3aeq1Gz3+kCuaLss0LMMALDqLXKYDa7oWWuiFLxAGayT6KmyRis7yk2Tb+ZTQH0T
         3K9Oi8Ta0eRjnu84txHc8VFIw/mZM/KMmi6Z+dOq02j6VrbTpk68jV8Qcii2hZo2wN9R
         Z6GB8/YZe2IiB8Fnty9tRY7uRv7En3imva7kLa3QkYg+aPmJwOz/baxbS+q3LBgnt85/
         eKN3MvCh73KbSRoBAACD5/fzrnlug/HYHSIDNrwm02Fy93cOgSHIFoSKMkW1Umr8KNij
         gfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g69Tg8i+2AI/l9rLO/HBsvL7C8sDT3SBWBYRRkExyv4=;
        fh=zQQIc3jC/ATDQ89e3kbpf7U/3Cth8hBfnS6P29n/+ok=;
        b=KfUwAAaHwi2jvvv3mHKhWbc90f2/2YCWFn1pLiUI9gxIvjwuWIAK6Nyft0oNBV+1Av
         dlXYsPZ6GRkQGvMK+zkwAhEogK6OfhDATkbtzghylJ23KJn3z9diSZH2UZF6eyPVVTnz
         1LTMmSVu8WSNsABsK6zCL3IJFXNOObHQT7m5Ov4wVP84qn/vnRWcIftyzzAGcd+VI9iC
         6D15UEhnyKDxYjOw8jneB/1I+XEgQNj6l0B42itovoNLzP/ky+dU3g81A958pcBcSkc4
         FfSv0bC2UZuE12wBWfcYWA0jShHXgv2fn5gzuSEaU1u3VGocg6T6VWVaBVd1AjalBcs3
         7GmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577609; x=1781182409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g69Tg8i+2AI/l9rLO/HBsvL7C8sDT3SBWBYRRkExyv4=;
        b=f3vvSsfEE6j6wntb40AOjrfaaaZ8mxmR7KN1ambNmK3FDr1loyjmbliXoA3CUwF6WD
         2Oh2SaBFM/gUmGukxaYf9GAqzq7P6/UDEuFpYuG9JSBmAodxiuTi77oEFluY9BKKyF8j
         oKnpXHmGAIt88v6LBkhXbGtoumnsvuxY9T45qKd/13Lau9GivrUC1qgkxokK90r5EUEM
         OUnESpOUXvSDgaxC9GiS4Fkm2K014I3RieTpbv4H82d/OzaeLbEriP8Uc5gxlexPWgf8
         BxkrAyZJRTUUmwX80VB+sZrzX5bbpB2Uyi0V/3dD9w7v2qpUotlMQ64/WHtesut1wV3M
         szWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577609; x=1781182409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g69Tg8i+2AI/l9rLO/HBsvL7C8sDT3SBWBYRRkExyv4=;
        b=kX8a8eh21tALUa/Rd35NMdRft/bL7wwOTf2FY3zcLu8VVa0fSTakjK2lJIct8hHl+0
         IhKK65AGSv7pFD7B3qdEKEevjQHLsdFq0EMhI4prgfs4XjkkTbgv2dJFlYh69zCCEstj
         UNtXq+6e6tmbpAK8W6p/ALy4VQS6/42tNugPGI0+DiMvpFjjHp+46HuKFdZREAb7zLU1
         6NojwpzWtzU26r0mHd5LLKvfNH5spmstjXI+uNwAfWohv7gf1hjzuNgosT3kXdfl/itT
         97UG0u60NRpog4m2bUxw35KQ5ewsqcH1TlfsepL8XdcgSFpE7ZZmqxrYDxLT8MntQdJl
         whnw==
X-Forwarded-Encrypted: i=1; AFNElJ/oMFlfrLuzij6Lf3zJATgUhPRI3SaFmC27XHZJ9+PD3KP4eKxhVi1jUjL1rD5Xo/4QuPevIMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmbKmccGTZKBxtnKKYuaIDWKXImhdMomr29PeTm65Fw2bHgKJ
	lOBoFMdZ+gynociBCZkqU9pFh4uOcfAG+nfmD0Mv40xrffuUHVtqv8MaGsdfnK+6ubxr0Tg+gPl
	MoiAChlEFMKl4uoJP2wPv27nn4+YS8l4=
X-Gm-Gg: Acq92OGa2RfyMcgIzpggzBPzY2+J9a0qrGQT5UHpsnjJXxnLBBh5v1peLFKp10zCDqo
	Bsr7Jku1FHUA+inwZ8fJ4KKnImnquJJUijDobyerkR/0dqiCNiYfRQEDg9pO62RURziMioqG+TC
	0tuX+TLivHKdOG0wL0Ak7BSKk7hnA0AijzjDrdOO+2WzTM0M8C05j3UIuQFAF/RlSU114f/nkZy
	GIBtNNo9p+ZLwA7nHH2JYIpAbAcotiPi56XIvtMtVvB+zA96gF+APXApiwRtCh1l5pDxiLWloBY
	06MFNfvYnJeMWAKuDnbk1bxB+E30u1uzKW7QKVVls47KI/WoFG5GiI2ku1uJYLYHL40OpNbPX0S
	uKKR8Gfm9WOXBaGnwvsD7FCmWG+BzKEpg
X-Received: by 2002:a05:690e:1915:b0:65d:6f14:9070 with SMTP id
 956f58d0204a3-660f45c9302mr1314879d50.4.1780577608699; Thu, 04 Jun 2026
 05:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com> <20260601134427.dda82558dfb2da579d66cbb0@linux-foundation.org>
In-Reply-To: <20260601134427.dda82558dfb2da579d66cbb0@linux-foundation.org>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Thu, 4 Jun 2026 16:53:17 +0400
X-Gm-Features: AVHnY4JPI5ZoHsj3kCakMzoQNU0ShVKpROBSnYaYX10AP5q-EBPKGug1lIOe_RM
Message-ID: <CAE7dp2ou3f8d0dAqyFQf8RQ1jgYtdsBxq70GF=OECAcvfA3UKA@mail.gmail.com>
Subject: Re: [PATCH] mm/compaction: guard move_freelist_head() against invalid freepage
To: Andrew Morton <akpm@linux-foundation.org>
Cc: vbabka@kernel.org, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 12:44=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> Seems correct from my reading.  That code is rather twisty.
>
> > This issue was identified via Coccinelle (use_after_iter.cocci).
>
> But AI review is worried:
>         https://sashiko.dev/#/patchset/20260601133941.111989-2-giorgitcha=
nkvetadze1997@gmail.com
>
>

Hey Andrew. Thanks for the review. Yes, Sashiko is right. This seems
to be deeper than I initially thought.

My patch is too broad and skips the freelist rotation mechanism when
the scan reached the limit without finding a suitable page. In that
case page is NULL, but freepage still points to the last scanned real
entry, so the rotation should be preserved to avoid retrying the same
unsuitable tail entries.

I'm thinking of assigning freepage to NULL like this :
struct page *freepage =3D NULL;

and later checking:
if (freepage)
move_freelist_head(freelist, freepage);
