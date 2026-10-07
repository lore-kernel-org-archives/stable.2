Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C43F483C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352988; cv=pass; b=IgRsIT30BY6Zm+o0PYDY9iQzCUCm/8WmyVLf6B8YLW2PCaw2SCpM2HF2cZAcTBvzCq9Hbwo1pnbHx21JYEtBOrB5tdXzInfhTc1fCNY0QF0m6sJYf2vQWSZALprGg4tlKuw9ID4Ot+nPZ9GQjOCag4NbphWcWf/redspvFLL/Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352988; c=relaxed/simple;
	bh=FieSFhLdozKsUNyoEr9PXiW853gnhNUhDQ5NE6wOnaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEB9NQCt8bXfzghcQr1gExl3VCx3eKuln/xmzwbHNfS/MVU4K3H1PDHYTmnKpaRqnOy80fOp9F7tAdNIcU+vI4x3fEpSiSc4umq8zWPSQIrvATZm/4IVkL2UBVI4KebPHofZrmHBWXMRsdCSiyjo/PA4Czs/yMhs3YNy4FJBuhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZAZjwQf; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZAZjwQf"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48af27fe287so1057178f8f.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 23:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791352985; cv=none;
        d=google.com; s=arc-20260327;
        b=qOvqvOaDE6QY/QoX/Xc908NB3cJANoKDqDN+b61CK24rA9Iu3gEnwWCmt5kunraiud
         LcMMXcMNpaqSWXYwYsqJ5mupcT6tGSrZUX/c5iZNzUQVnDTXjfDjsODJVGjPYxgOdfdf
         RKAGUn6hEKycaUqO2qhcyzktbOxQN98X26pvkZwINYfxPXZ+LK1RXq4ms6nDezCKMO5i
         jGUuCYiuZ2/IQFGUTqvrxCjt3APLd5PBtnwYCcIRIewC3divPK/H31xtHcHtLZnDYPxw
         6pLB+vmkEJ/ULQeahhrTBtqW7NsaldSTjQdwfdtowWChKwMnwugq1TvzJ7zlfIK9bp+x
         hMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FieSFhLdozKsUNyoEr9PXiW853gnhNUhDQ5NE6wOnaU=;
        fh=wlJutqKELRqFVa+Jvj5Hhm4yCzZ/i/gTFSuy+pVbHzc=;
        b=LBlHViBXAQygsws8o2cB0CxlopHriD+zmI+yDnjrb4VP8OBeEdHW5L3VoTBT9uDTBt
         cmPl+4jm0EoDCv2lite1b5Rdge8tDvnSb1iyiSQiuimPEDyUZNqnu3+Hr1BsU2bkc24i
         H4EmSpO822HaX1VoXitAKNSPIKKzUFFhXbgmrvClEvAYBwg385hUlrKiIiw6cABAgFj3
         gv7t1YFRc6eCZ6Lqy7FbvmdhL0bghTCgfCkNzhY77IpxZskIrPy7nKqismeXIIY9SWJB
         oLEU2culn48MGL0n7EW7u5o7I1Icjn28sT6EH45OAqrwgFe/u50xpo2k3qKbmeqJWiRI
         dQMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791352985; x=1791957785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FieSFhLdozKsUNyoEr9PXiW853gnhNUhDQ5NE6wOnaU=;
        b=JZAZjwQfFYVw7Hv+LfU4H7MeEKkZX3EKW0phxDUQEs37uiegwqSJhYijJdSJqf9Agl
         akzMm6UiQ35uv2NGs9NLATplBeoO+AoQ4XKL/NuFEYS8xNbJjZnmznH5mkUzNCuHu6sh
         rcUhcTb0jH4y4YLDjxtcSnJ9EjA25EpZzvxkVwx1KiXka8HLLF0fNysR1Q75Vu92mh0W
         ff8rgv7eUrbJOpIdGH1mblrc0R0MwLY1znjPFU2q+O0mAwPenzTGumKpP/h0i1KfB5ZU
         0/tT8g7hMzk+iyO4fU1/uSmE/NGDFGACXOul0ororLqaDgcI8JLMTgCndqmF+uF82VIl
         ykiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791352985; x=1791957785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FieSFhLdozKsUNyoEr9PXiW853gnhNUhDQ5NE6wOnaU=;
        b=LNeg45p42Xwqu7wifNE7Yn13D42N+CgFSUgE1F7Cr8dxBigeefF4qgLsxiKOyy0ps4
         CWO7mRYBWMiZhxFyI98iO8gzkeCM2mmfoXR6hJPTDdGUL4vloQlg4les238of3H3PNPT
         eI/7MFKY7mJr4xBDT4r2fv7u69B1gy0/iizGsMTvjAUsjC3BQYl0I3hMO8F7P09PA6dO
         dY2VcfuyDAcylUk0JXRwEK7y4qTwmEfu6sHvSxVHUB8rxHUnIwZdTGse3Sm1X6BtzNvI
         s5UhwifGOhi0VagaEf8RITRm/8xPmG2dogYkkC/I+flRZf4YRn7D7qllhZvHNtA4CTri
         2KpA==
X-Gm-Message-State: AFq9FYLZ0BXDepWmEsGks/dhOh+Nj9XueMF9PQv8WokEz8AkaCNjJTsW
	Qe54qfFDNm51ITxBGPMn6mael5oQ1stz8otS0VRYTJQKCwfXml2SeEzIR7joOR8HqCH4MSbLiHs
	jEOwxsU96jFH4LlGADoDDqzoHySYnKNvQZC8+3n23
X-Gm-Gg: AYBFou1E6MhIfv9K27/A0c5WpyEA2mYYS2nwgAyvhOai5esQwL/8XWybwfkRjkU9VZY
	Iy3Hx0KkYvKb3V3x9k7ayauxYGSax5kSRD1pbZTSOJN0qmPRSHuzB0mvELNnbAgVWpB3llYoeZA
	gY1V0XXxYVdV4ypk5RDxsIPtRvu5G+V+IHOsNJWRmZ0WL+nKDy4nvhRvll6nCbJJfFyMuzTuCfG
	97kWEkBux4PvYe/veRkBmJL5tcbyZ1obOEbUyYWGzqz0qtjhB/gioJM1mYGQK4ojkzOvzsoC/qE
	oYipVqXXAEO+aICFMIH0cnqf+bU8L6/KBPbEenFiwYaca/Ss1NB9NcJXOAMwLTn4vbwXXb5yE0t
	OVl+2pTHoJ54bThPOimQDdQ==
X-Received: by 2002:a05:6000:22c4:b0:487:27f9:840 with SMTP id
 ffacd0b85a97d-48c72898491mr2425269f8f.53.1791352982922; Tue, 06 Oct 2026
 23:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-devres-6-18-backport-v1-5-06dcf0e592d5@google.com> <2026-10-06-1-daily-reply-0001-rust-irq-cookie-7.2@kernel.org>
In-Reply-To: <2026-10-06-1-daily-reply-0001-rust-irq-cookie-7.2@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Oct 2026 08:02:50 +0200
X-Gm-Features: AclHuK8hcWrWSzFx2gPHGU-ZsxcJZ1WfkgDVOXDwBNO83no3aGdcmvQVaOUlmNg
Message-ID: <CAH5fLghSL4skGJZM3wmvq=PYiHVgB6gRUZTg18wSx8x2rETT6g@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 5/5] rust: irq: pass RegistrationInner as cookie to request_irq
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Eliot Courtney <ecourtney@nvidia.com>, 
	Gary Guo <gary@garyguo.net>, Markus Probst <markus.probst@posteo.de>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 11:36=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > This is not needed in mainline because commit 98c63ce4d760 ("rust: irq:
> > make Registration compatible with lifetime-bound drivers") removed
> > Devres from irq::Registration.
>
> 7.2 has the same uninitialized read. Devres::new() returns Result<Self>
> there as well, since ba268514ea14 ("rust: devres: fix race condition due
> to nesting") is already in v7.0, and the refactor you cite only arrives i=
n
> v7.3. This patch does not apply to 7.2 as is, because d1880d5f5899 ("rust=
:
> irq: move 'static bounds to traits") moved the context lines.
>
> Could you send a 7.2.y variant of this patch? We will queue the 6.18
> series together with it.

Sent! Thanks!

Alice
