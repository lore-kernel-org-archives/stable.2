Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C0366816
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139518; cv=pass; b=BiPoJ5DV7+yxv1XJ0Vs77MwSzADpSw46m5rzXlqqYaTXaSk97pSX0WD1KAySpqeuMm9D8b/WemCUqw70+1+YOOwlrWebNlSGvoGPqMyCHyBKGW3OtcXMu50Z9Ol4wBs4IWxXSEdGDaI4N3TnLebKH712M5jvhqykid3JTidai2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139518; c=relaxed/simple;
	bh=a1WAq8z6Lr5iIEubA1slcVW5P1heZAnFuDZolrmXxz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBZQmRV1WN0pjTevxCXgDAByaR4/M+hyLTUfobfsdSw9cToFtKRJo0gztVu/K4bf6CQZZ70j7fA3ZQun/sdRJNDHJ3dLWE7WlIJKOkp9OHf5zFz/Xc2xeoGQerFWQlhhB9kRATGkrnPsyxdipvg3ThxGDOhSwzSqnoX4OZKi3TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKuu6Wdd; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKuu6Wdd"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6cso115ad.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789139516; cv=none;
        d=google.com; s=arc-20260327;
        b=K6pXy29kGpkwfX1eX5K07IECLKyPeIwj0M0Ze9KvKA+a9oeS4qiwWxcTQKRPOJWwux
         eJvdRllUwVEGJMb+L+H8lrqyr3B6dKcFv6QyLS/F1MJcFe9S8dPXoK65pLIl1IuorseH
         qQWaGy+LtTwDuJ9Tz0d7ki/KT5BndCGogwlIiiNfdplJhTJB3qMw9wL9djbaf7hU7i6L
         xKZaglz+9CkLjtPnRRqUymy0ZbiUAO3iKZPH+DZ3OCt/dRSzSP2bIykj9NyKKG9IX5wX
         TwE6yLGY/uLnxHz0buJ+QS8VXdNDTOhdmovGvyRgP/zJY3OphUogrFWWf4YsyfMK8Li0
         KRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JwM5Epgg3IOjgygjiEjc2zoeXrLUf/Epju1L3iuJNZk=;
        fh=zkNsCI3+RLEljHCVSDRrlCIN9QSu5RMePo5tjGGrPBI=;
        b=iHMgBzyAX9XeFxIG6XDALXh+fywffWQ2g3URVL2UUfCWSQ8XPkVRZg/UsFzTUsvLN3
         Q0iZFwgnOS3yjt36QG5zDuCmOsM9lYjUzsrPfgd1X+FRIQ6dQpxSoquM1JQYPLTdn3Z2
         MgIF1UmpkeIxdPdgXjdb0BFJOVlNrrQ8SmhCyV2g25WmT8gchOFlAHUDaD9PwRa5cuCp
         0cZSTR6aYfMy+gLH+jgwbmOMlIlBT3hW072NYWWxxq1Ev+QQvU8do9M5810AlCYRX0ZY
         DkSBzKr5EOsQ9jiakz+kpp68vYBkAxpjipQxPcVG8kQ0rABWr1p7X7ixgn1UViCTAZlZ
         Mc5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789139516; x=1789744316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JwM5Epgg3IOjgygjiEjc2zoeXrLUf/Epju1L3iuJNZk=;
        b=BKuu6WddAtNn13Ezu/myWUrl8wRcirs7lJnORviTmc1pNq3zz8wrOYdnDa7K2cWUjn
         7qIuHQT7YQoVpdZfvYe5Hts8v0BvUZWf2y8Ncz6k/bzDPLJHpU5tPCS6kgo6K1KxYfsP
         RM1s3g2ne7RHDHhc4E3ULstmP4N+Kjg+OgnrmS1AT/+/AARhli0F8jDgJ6QWLfe9beuU
         24obPTwjhfvBcjcNQqwnl6G84hD6UML3GjvxMb9kFRnqQudyKTvO/xMmBgONinhnrLa8
         7oqzOdmbLt8giRI9tnl4yNW2z8EbiYjD1vlBjw2CMS+3WSgOY8iZeZvIZnr6AXfv76CO
         ffZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139516; x=1789744316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JwM5Epgg3IOjgygjiEjc2zoeXrLUf/Epju1L3iuJNZk=;
        b=fArRKa79VCZsl7I59o+EjARUBmkA5aPeVHERRhYLUQ9QHbb7VdgcpsVgm1aZyDUaW0
         h5M5ZebvOqwD4H6u6CFhjODIr01/C5Clsck074dgpp2BTDs+E679o70bUrFEXndQeD6g
         osmvTjY8Vwrn7mCiwg4fygtDMjpyt+0/0GJEKNiOPyRH4L+kIZNTIaFYAGfR29Rham01
         lQSCGHFamlwvlNclhYV8dzIFo2lysBjMpDcjog2dA/DscFvGlzVoBNdP/qEv8ujpzmAe
         /xyJHIXhJpJFGpjlLviHe6R3pLAY4dIGDdwfVB7fbHN+PqjfT+dJIvdsXaCk5QXqLx/7
         A1rw==
X-Forwarded-Encrypted: i=1; AKwUvByFB65/G9oR48Ae6Q6IsRk3rAkMCu+ejcumiN4NMWiZV2ffEmDz73A1JiSORaZJ14SDOl4RfxE=@vger.kernel.org
X-Gm-Message-State: AFuF++lYY+J68qBPu615OQewnD6vXWPLz9kOfnj1OTSNDmyTH3ESNCDy
	oL3wjlSRWJjvxDbrV8qkpICIznYAv6iT5wIrzX60lNJCHQF83LfsvlHaWY9OCj08YWO0mbqIRsT
	r5k7GVUHeGqrBbum5cLZs8pN6CDMV5VzIvcoPvOBh
X-Gm-Gg: AYBFou0y5EFphk9sbTuqq5NdykBwXKO5HTCEuBdx+1QawrWDXggGVBDH6s3UowotJgI
	25cywRseXccHcYf5lKqgD1G3tDBJD5uxku956mQXaW00E7XkErWNR7QKOSkvjR5zgCbilo3khBt
	jmQZKZgAoM9g1CFmp3EWzLz+7yPg/Ioh6hMmNIugXGwHgltzQIxbkc8FPVd+iuoIhqICRiivtCb
	Qtu9FT9TF7GlfUjTpovmGT7Lqm4u/mRnIS0DEtsQehfpJtPUpU4C8Dj+vjK4oUa4D1adFbIRIF1
	f9BbdcjUQ6GdXc4VuBZqF/YnmEdICY4r9e48sYXFEenX5ZwO4fGToMf4hAbcPHjVghg4jId1kLq
	EP//8bB8CnDFpbgB8huM3FSL5QXZLRHj0PcDVV05yiw==
X-Received: by 2002:a17:902:dacb:b0:2cf:4353:f117 with SMTP id
 d9443c01a7336-2dd2bf06220mr7129715ad.0.1789139515742; Fri, 11 Sep 2026
 08:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
 <87qzj09gau.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87qzj09gau.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Sep 2026 17:11:18 +0200
X-Gm-Features: AcwNN1UfWUuTxT6T6m2fFK9oBs0vwCiHpncLk9iQ0jXOn-ma2wM-nV7MC9jABfg
Message-ID: <CAG48ez3f=-Ydf6rQWRxgeD1jz40LTup3MUmNJgqAaUAgAekDuQ@mail.gmail.com>
Subject: Re: [PATCH] exec: do_close_on_exec() before taking exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Benjamin Peterson <benjamin@locrian.net>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 1:30=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> It has always been a requirement that in exec_update_lock not be held
> for writing over any userspace accesses.  Which is why it is taken in
> right after exec_mmap is done updating userspace.
>
> In the original version I missed that do_close_on_exec calls flush
> which can block waiting on userspace (Is that just a fuse thing?).

It's particularly egregious in FUSE, but I think network filesystems
can also block on network I/O in there.

> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks for the review!
