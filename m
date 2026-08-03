Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC339479B
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748679; cv=none; b=VoadFJMYttq8H3II+W29ueGUXrumLYsA+Gu4VGFaf8A6TmIooiY4mgq148BEv2lEfRwtUXyMdz4LqjY3vc7p9zAo2mzZRDx87Emhucuw+JHicnV0qIlD80rLdcbTgNB+CWNp0VKOzVq8RomGPw0M5Ai1vPBm/rv4E6zDXIuZrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748679; c=relaxed/simple;
	bh=rpdNvi25y6YL/db0u6CTvRLJE6R3TUxXtVl8/6g/hvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uve9HNO8pcVYjZFQjV+WQ60Ioq3b6kFIBA5q7zATctvL1EW7daPAk/it2ek2PZffwoJhOZm8v7scrWdHn85qsiZbFHSdOBPGwOVboTg/hgSTilqyGo6lG2foR7RuDuvdBfjKX4sOJzWS5nC01CWWPqUPAmp1QZfZrO/b2EHnxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzXopaUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzXopaUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2371F00ACF
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785748677;
	bh=fxyuD0oss58ubgzj1FvTC+7tUw49ZGQl25e5UWdLsh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bzXopaUFvz6eF3NhFb4UpuJ6Pyqp4WVoWUBykPWH2CJ5V/G/Nbls6Dm/a1p8D6rwR
	 GwvbaXXvzISYvTgv0x35Ts0FQmZLr8GeeWmhaWGQo0O+KPKtr3iNI3u3Urq9+to0mK
	 w5OwAt+Dvx7oMOtZvNFJ2KuVomsSmpy5iHdvKfF/TT9kSYF1O01cDZ1c0DeEDqmZM2
	 Oam53YGx3zR1UvSiSLjA+9NzSLgMqO9e/yjX5Jt222t56ZuPbyUXbWRUpJvdfkMqAy
	 MqOuay4TnrRHyjzzl8usI27OV/sVHWozrUP59rbn/Jr085pdvF+2sqhl8Ote2epWv9
	 VR3fZb6e8BbzA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930c0f9c1b1so172591985a.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 02:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp9bQVYzJ70c36gdWesadcWAty/pp7fa58qUSPM/vb2cxJEn7bedKSZakVCoUnKAI5rSAsVCP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgJgvvWanokUK11h5dMk1pYcZ4In8VrAWL50qE8asCQv85TlO
	PWsnpPwse4VyyRZ69jN1WA4iATpyBoLKKkC+z+3sz0sjTPxpm82WL0cN7hoEO0fikcPWyBC6oFg
	DMVyNWjhCCkXoKC73vp9/6hAf5dFFTN4=
X-Received: by 2002:a05:620a:390b:b0:934:9524:2e89 with SMTP id
 af79cd13be357-934a0789904mr1748731885a.13.1785748676518; Mon, 03 Aug 2026
 02:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
In-Reply-To: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 3 Aug 2026 17:17:44 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4x3MQVU7_Npxf3JQ8Q27TsAW1Tx5-ifH8c6+gKtg5QkuQ@mail.gmail.com>
X-Gm-Features: AUfX_mz8oKCS0mJlMGsIPpYo49S4g_rtl56yBju74CQn1opkjI8-NpakPIKDA3A
Message-ID: <CAGsJ_4x3MQVU7_Npxf3JQ8Q27TsAW1Tx5-ifH8c6+gKtg5QkuQ@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Hugh Dickins <hughd@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 4:28=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> folio_may_be_lru_cached() is currently only true for small folios, and
> for small folios FOLL_PIN adds GUP_PIN_COUNTING_BIAS references instead
> of 1 in try_grab_folio()/try_grab_folio_fast().
>
> Consequently, our
>
>         folio_ref_count(folio) !=3D folio_expected_ref_count(folio) + 1
>
> check in collect_longterm_unpinnable_folios() will currently always
> identify "reference mismatch" and first drain the local LRU cache to then
> drain the LRU cache on all CPUs, as collect_longterm_unpinnable_folios()
> is really called after pinning the folios with FOLL_PIN.
>
> Add a comment because the current code is not quite intuitive: we used to
> drain only to make sure the folio_isolate_lru() would succeed. But then w=
e
> also started draining to make later migration more reliable.
>
> We'll refactor that code soon a bit, to also make it usable in other
> context where we really want to remove any references from LRU caches.
>
> Let's add CC stable, because having an easy way for excessive LRU cache
> draining on all CPUs does not sound right. In common scenarios we
> don't expect to every have to drain.
>
> Fixes: 98c6d259319e ("mm/gup: check ref_count instead of lru before migra=
tion")
> Fixes: a09a8a1fbb37 ("mm/gup: local lru_add_drain() to avoid lru_add_drai=
n_all()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> Found by code inspection. If someone has a testcase that can easily
> trigger this and result in migration problems, please test! But this
> change seems to be "obvious the right thing to do".
> ---
>  mm/gup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 99902c15703b0..41c3317e0f0f4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2273,6 +2273,7 @@ static unsigned long collect_longterm_unpinnable_fo=
lios(
>
>         for (folio =3D pofs_get_folio(pofs, i); folio;
>              folio =3D pofs_next_folio(folio, pofs, &i)) {
> +               const int pin_refs =3D folio_has_pincount(folio) ? 1 : GU=
P_PIN_COUNTING_BIAS;
>
>                 if (folio_is_longterm_pinnable(folio))
>                         continue;
> @@ -2287,15 +2288,20 @@ static unsigned long collect_longterm_unpinnable_=
folios(
>                         continue;
>                 }
>
> +               /*
> +                * We drain not only to make the folio_isolate_lru() succ=
eed,
> +                * but also to remove any other folio references from LRU
> +                * caches.
> +                */
>                 if (drained =3D=3D 0 && folio_may_be_lru_cached(folio) &&
>                                 folio_ref_count(folio) !=3D
> -                               folio_expected_ref_count(folio) + 1) {
> +                               folio_expected_ref_count(folio) + pin_ref=
s) {
>                         lru_add_drain();
>                         drained =3D 1;
>                 }
>                 if (drained =3D=3D 1 && folio_may_be_lru_cached(folio) &&
>                                 folio_ref_count(folio) !=3D
> -                               folio_expected_ref_count(folio) + 1) {
> +                               folio_expected_ref_count(folio) + pin_ref=
s) {
>                         lru_add_drain_all();
>                         drained =3D 2;
>                 }

Not regarding the fix itself, I agree that the fix is correct. I am
just a bit curious why we cannot simply do:

                if (folio_may_be_lru_cached(folio) && !folio_test_lru(folio=
)) {
                        lru_add_drain();
                        if (!folio_test_lru(folio))
                                lru_add_drain_all();
                }

Or at least the following diff?

diff --git a/mm/gup.c b/mm/gup.c
index d110f30d9bf4..3aa1d498e9ea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2300,13 +2300,13 @@ static unsigned long collect_longterm_unpinnable_fo=
lios(
                 * but also to remove any other folio references from LRU
                 * caches.
                 */
-               if (drained =3D=3D 0 && folio_may_be_lru_cached(folio) &&
+               if (drained =3D=3D 0 && folio_may_be_lru_cached(folio) &&
!folio_test_lru(folio) &&
                                folio_ref_count(folio) !=3D
                                folio_expected_ref_count(folio) + pin_refs)=
 {
                        lru_add_drain();
                        drained =3D 1;
                }
-               if (drained =3D=3D 1 && folio_may_be_lru_cached(folio) &&
+               if (drained =3D=3D 1 && folio_may_be_lru_cached(folio) &&
!folio_test_lru(folio) &&
                                folio_ref_count(folio) !=3D
                                folio_expected_ref_count(folio) + pin_refs)=
 {
                        lru_add_drain_all();

If the folio is on the LRU, why do we need to drain? Is it
because we already know that the folio is not on the LRU before
calling collect_longterm_unpinnable_folios()?

Thanks
Barry
