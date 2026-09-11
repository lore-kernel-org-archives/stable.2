Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0204A0138
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142934; cv=pass; b=AV8M536SaDFOOxQsXs6V7h+G3PPJftGXD6kfyAYgaZwIfBL0dVhYYe1b821FvHvzY15wp5J71Y3IBFvdOkI/hsCmWCYUYIiZzn7vGZp0pTi4QR1BGmlXArXl+VpV/33hjNMJYGl76mRo97Geh2AFUIoFykab3KnaTVHS+KWJc9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142934; c=relaxed/simple;
	bh=Dr0ZPgnRW2wb/vXzR1YjQxeIUs27SLUiW9W3kIXeWRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8AMg914IT6GxXnaOrWXgQUHEzIK1rGBZ+Le8rMPsHHfrvWdPFV8HHql/1LXZl+3ShnviuPEtuXVQSzTEqr1o16nXfJ6BW2bPk/qam4ju/J97uyl6wrcQDXaD1hJRbhmf8U/jAiETb+l/hOJWuCoN35IwX2zIS9aD9iZeOrl4m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCZ9sfy3; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCZ9sfy3"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b5e5ab03afso1063549e87.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789142930; cv=none;
        d=google.com; s=arc-20260327;
        b=hAJBwPHmI71C3/VpNSvVQcJ/qkqCArlQk7U7WE/dpjg/mZ6Jx/TkdG8Xnr4sMlI/AG
         1aocCkf1c3QXy8LIv+5p+mzJZ8JuM+DWC4BMgsJyD2Jqp+odbbex2q1mekZUwE1F+J0p
         Oy+5Qgh+E3//rqYm4rtLcC/PUYO04V49836Kb2a0M46Z6nRsIQssYKKCjJ687f3rXIre
         HJDrrZFSIPfjdsWe5IWSK5P44NGRQqilaHSJHwYAGPmxPEF2jRSEpZZFHhHBLoavKBGu
         3LDiVOnnBBTdQhvb1oEleG5ZIp+Bq1ZuNiko+DH1zzdMeTqt4g9jyxMWKITC/6AtfwtV
         CEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=snwxagCQ4mrcEcTHwmB0+aYoYDwFIfdB7PhzX2AVWJg=;
        fh=WQOzd766BdFeK9YrbkmQ78m9eOwSpoKEXWALaik1rWk=;
        b=iEnG6rH5NZwbXaOMCzvuE3mrd1jzf3D5gbDAoZx2XCxiJ719kT0rXIAzZl2TTpjW/Q
         nHzk8U4znOg006EVwAWv7LWdsLmwaZVzvi1LkaTMTOzDMrAz+0W9WqMRbcIgSGJKT4H7
         bLKuaLBnlbn370W/jXbYSD/UYv1s/b3jeBzWAC9E0RBKqm8riycaaqNyCmHLG/XhBPiU
         pIv8Fk55xkBAUd6HUJibDAzIuTUYkTdtWIXeAo96UEi7zxWmzNPadrD8UeCv36mKXB04
         ywW5oRfEO153z0AXVkUejtvJER3F0aTaJONJQplzA7XPKz+H23HMx/C3EDjcr5IsL8uo
         DVUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789142930; x=1789747730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=snwxagCQ4mrcEcTHwmB0+aYoYDwFIfdB7PhzX2AVWJg=;
        b=tCZ9sfy3caWxE6hLHcE9hlyFZyIyVVsPtNbpP3IsIU7bXJi0s7Ifkd+GmPBdf2sDHt
         p72tnOY1M82gPjYn3v9U+Jqj+WPyqFeVpCQHrN815PKnsYBN9X/19+GAXCNpp0t3j9fy
         dPzMtUXJ3JSC6oWqhywoeBIh6nza5xMbJYJ24BwSU9BSOdCkUh6XvIPXm1C95SYAxNh0
         Lbn5V0Mk2r9sj2TIj+M59sJtlgKa74K0rS+ReFC8Ao/GVkD4sWfvMxChlqjcmm8Q/MSD
         jMn8AQTTTVc4JDkoTcSvZ42RxqczJzxOu0JeIsqpEtJeKx2gEar6VVLywl1fYXrYwxaF
         1z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142930; x=1789747730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snwxagCQ4mrcEcTHwmB0+aYoYDwFIfdB7PhzX2AVWJg=;
        b=jox9EF1mEx3DzWESp0XlQ6Td4/EOdbJ3doY5E2cDzcXcy69Aj8eXvAhTY2OUbyzADn
         wl/9D2tkGQGBe3ZozHedD8ucd+XeRe/+bMHnKJN9D10+jehqY9/EOdFWZqVAAeOnU3uM
         vxI5OQ21P0wKu4xjAxegH0CZcLiojlCWkisT+hgVCuA1ZoRHGyFZEp4kZ+ZJkHnZcn9P
         efvePzgAiUlIpMHF3H+vq5Q4Fj9EH1dOEqxQ0fBQkhLM/JAPq4bFIzMXwLL6FHcJopxp
         0y8v0WqQYn0+U518lERTnduRKRRKtZ6mJ/OOmhVS/VjRMJCI/KCYua4KxozcZ293UcxP
         F+VA==
X-Forwarded-Encrypted: i=1; AKwUvBw314V+Nx3/0x19So/8a3AudX++I2zSfoGFk9l62NaXXtnC9oNC6YaDK19mGRaamo11AUfOc3k=@vger.kernel.org
X-Gm-Message-State: AFuF++lctSQA+fNc+9edGOjwMWyMsfb8MTft8OH3C5CwoV6XoFd4Qq9I
	ABpG512gfUHVbzN/zqFZ3Z7cRGtwjax6y3xs72Bp+LAqN7W/6egGApLfLl1JUTnKu/6AKTauUXT
	68RoidxsPZZjN5owhT0dqH6tpwBW++uM=
X-Gm-Gg: AYBFou0cU/xViEG+MNUKLpd4vZ25oZTymW8EADBFkIqs910buztwtIaoINVM9qnwgdU
	wRhxn+Pf6UEsr5FJCgFq+yZX959dYXVrM0ffDYjFnXaJmX8dFG8q+HgHJ9QUIMK07H2T5GiXufZ
	qTsBfbpI/VK+/50dnbEeHfbzwtu/rGCtCIPMuzCoHHIo/Rw+Cp8f9eGnX5xhsx0oyFniiBFGCuA
	RPqD1ZMkmgrt5ih9WJTWasRxFrA5m0JtLD9NDsO/xSHLU7WFqcCMyQh3Y3saWhEiZ5Ewbaz4jqV
	zA6xOtOFWR7OAqpjbNBxcXHdb0a1qkAyxuVEgipLfJpwCk7C/HKF7Mt8TJszlpni6kg2GzzLsRg
	Xi5nTjTTk
X-Received: by 2002:a05:6512:4008:b0:5b7:6393:ebf3 with SMTP id
 2adb3069b0e04-5b8a03304e8mr1270246e87.33.1789142929866; Fri, 11 Sep 2026
 09:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909205028.13799-1-bub4z0r@gmail.com> <067e5ddc2268ae4678745a900108e93d0c6eeb74.camel@linux.intel.com>
 <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
In-Reply-To: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
From: Samuel Ainsworth <skainsworth@gmail.com>
Date: Fri, 11 Sep 2026 12:08:13 -0400
X-Gm-Features: AcwNN1W1VB8g78HD46FVELsdSdTjEr91Xqvo_dSAH54nzFz00UIvmNhPOfVbY1o
Message-ID: <CAHYiNPaHFYSKt6pZWpCvxui=UA8DfH=3iMqYXnziZ43_Ua-nTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Vadim Nikitushkin <bub4z0r@gmail.com>, ray.huang@amd.com, matthew.auld@intel.com, 
	matthew.brost@intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	alexander.deucher@amd.com, bernardomagri21@gmail.com, 
	Natalie Vock <natalie.vock@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I left a comment on the commit in GitLab
(https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3db7d7d583419f7b1f=
2e141e36418802dbb25cf8#note_3658149)
but it occurred to me that it may be closer to convention to reply
here. In short, AFAIU the commit description describes fixing this by
checking `ttm_tt_swapout()` inside `ttm_bo_swapout_cb()` but the
actual diff is modifying `ttm_resource_try_charge()` checking inside
`ttm_bo_alloc_at_place()`.

Perhaps I'm missing something?

Sam

On Thu, Sep 10, 2026 at 3:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/10/26 09:14, Thomas Hellstr=C3=B6m wrote:
> > On Wed, 2026-09-09 at 23:50 +0300, Vadim Nikitushkin wrote:
> >> ttm_tt_swapout() returns the number of pages swapped out on success
> >> and
> >> a negative error code on failure; for a populated ttm it never
> >> returns
> >> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite
> >> LRU
> >> walk on swapout failure") moved the bulk_move bookkeeping in
> >> ttm_bo_swapout_cb() under "if (!ret)", so the
> >> ttm_resource_del_bulk_move_unevictable() /
> >> ttm_resource_move_to_lru_tail()
> >> pair is now skipped on every successful swapout. The equivalent
> >> change
> >> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix
> >> ttm_bo_shrink()
> >> infinite LRU walk on backup failure") tests "lret > 0", which is what
> >> was intended here as well.
> >>
> >> Before b2ed01e7ad3d the resource was taken off the bulk_move before
> >> the
> >> swapout; since then a swapped-out resource stays inside its BO's
> >> bulk_move range (and on the manager LRU) although it is unevictable.
> >> When it is later freed or the BO leaves the bulk_move
> >> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
> >> ttm_resource_del_bulk_move() skips it because of its
> >> !ttm_resource_unevictable() guard, so a range endpoint in pos->first
> >> /
> >> pos->last is left pointing at freed memory. The next
> >> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that
> >> cursor
> >> is a use-after-free, seen as the resv WARN in
> >> ttm_lru_bulk_move_add(),
> >> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
> >> dereference in ttm_resource_manager_next() -- minutes to hours after
> >> a
> >> hibernation, or at process exit / reboot following one. Samuel
> >> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
> >> dangling cursor; the missing removal at swapout time is the reason it
> >> dangles.
> >>
> >> Testing the condition for success restores the removal. On an AMD
> >> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate
> >> on
> >> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
> >> crashed 5 of 18 hibernation cycles; a function profile of one
> >> hibernation showed 336 ttm_tt_swapout() calls and zero
> >> ttm_resource_del_bulk_move_unevictable() calls. With this change the
> >> removal happens for every swapped-out resource and 12 further cycles
> >> were clean.
> >>
> >> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk
> >> on swapout failure")
> >> Cc: stable@vger.kernel.org # v7.1+
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> >> Link:
> >> https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4Nu=
P8D_eSL+UJeevXw@mail.gmail.com/
> >> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> >
> > Nice catch.
>
> Agreed, that is a really good one. We had tons of people staring at the c=
ode without seeing that.
>
> >
> > This also explains why https://patchwork.freedesktop.org/series/170311/
> > appeared to fix the issue. But that series actually kept the resource
> > on the bulk sublist until someone bumped the LRU or removed it.
> >
> > Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> If nobody comes up with some last second objections I'm going to push tha=
t to drm-misc-fixes ASAP.
>
> Thanks,
> Christian.
>
> >
> >> ---
> >>  drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> >> b/drivers/gpu/drm/ttm/ttm_bo.c
> >> index ef56c18..9b85b5f 100644
> >> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> >> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> >> @@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk,
> >> struct ttm_buffer_object *bo)
> >>
> >>      if (ttm_tt_is_populated(tt)) {
> >>              ret =3D ttm_tt_swapout(bdev, tt, swapout_walk-
> >>> gfp_flags);
> >> -            if (!ret) {
> >> +            if (ret > 0) {
> >>                      spin_lock(&bdev->lru_lock);
> >>                      ttm_resource_del_bulk_move_unevictable(bo-
> >>> resource, bo);
> >>                      ttm_resource_move_to_lru_tail(bo->resource);
>
