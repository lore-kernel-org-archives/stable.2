Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151A388890
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657395; cv=pass; b=ca23hs0plE2qEshUkV88Pef1Ee1sfrgWRrAjak579xJzZw9TK7pvbampM5Sf2iPeRGHKaWjZNmubGD7p5ctpliNKXQjFUrsbl06mDoRPQ/Nm6pFlwbdFg0XZ39YUlmHM0dLbZDkR8DwLwYaQTaS7S869ityql+KVGhVyYLq89ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657395; c=relaxed/simple;
	bh=zdj4FCCRRFIrBGGKe43OqqrMrkYf3VN8KZjEUcQrLdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooueTgOsnBGBnbMlG5EXrSjHOnRPTBCPHQ/ae+FV6Bs7cBH5Xy2RClhzh6zLRZ42uKZEl/kuQ8vG0QKkcy5bkEuOC2HJGBpX2F/xPE4kINPHcoCCU7CAolCXJoIEojPgaadfULZW5fKF61dg9TEKwlxuM2jtSwT7sjTprKJD5zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsErDDzA; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsErDDzA"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6b5737bb2so9082572a34.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784657392; cv=none;
        d=google.com; s=arc-20260327;
        b=AeE3V5ic2sYs0olcywHku0f0BrMLdSlfktJsKdMhuvqh3W6HKWGtQK+8CUDjTqJaWz
         Qp5jgkoV5JcM1euezxrJ9N3YKfppCiXfFIG7qG9nFDh126yDDUZq6Wh5B4tKBawkp19L
         jbhk8N6uO4h5imCEMHa6MXmAl2RnGaCWnPG+L0/c0uBhggdWfPGkhhQ9KOJDEY25drcd
         5vK2wfTSHBREyzIEjZxuJROC76+L13Pz9uY06muu+rORMzvylzibm6QxjHaxUhNfX8Zo
         3joKIpaJZ+UbDkLGW6NwHBA5onGI/a1NtIjtC6Y85jehMrkhoTA+DGuSoZee2ruYxaWU
         3oBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=657PTF+kjp07ScPIuFpyWerZ9DUGDt4h3eqh5FIi338=;
        fh=QeLN5D9DygO31Rwmi2tOTgNUrldZoTT16ZUi2Drslk0=;
        b=JkWFTXj0hkTPPYcWYa4/NKN2q791HvZEt2asxjaYO5FRQPtPnI5UoDmaSffOMiKDV1
         nicTTwi6B9FmdQgRCsaNbkY/h57AZbEsPgx4af8Iv+7WJLl73zwnEcmvbR+gglqrZIfV
         nhPKJiB608gt4gICPtiPYcaKXY8OMZtMN//dLsmBm5816duLob7j8uMLafDzOCEcIN7P
         +vbT4ZyjjC/02VMAT2DvBoJAFDMeJ8ZVvmaCxAZG5CCewQT6+Dc+OJ39SbebbC907G/k
         UWGame2gV1SXKLpa2Dc+LiizpDE7Xdg4kDLbcqpkzI4wIJY8ThlPKtoSTO11Ofw+1GMI
         kphg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784657392; x=1785262192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=657PTF+kjp07ScPIuFpyWerZ9DUGDt4h3eqh5FIi338=;
        b=AsErDDzAdzJvZr+Mk2uW4Glt0bXygCtVDqTnGFeM29I+1rEaYMOG1YhI4oJB7o1i9d
         Cr3qW2AqdrCLpz640CMpoFRo/40cPKQtkQxW0h+CNLFCN3GSB3RIOsYexYNosowuP20r
         YQeUPRSMlIBatP7A2NEYHFFV7UuAF/U+cf2uezyitMc0RUKlVpZExC9C9V490jfM7e4u
         p2d/jUOkC3xwzTnHXxmRY8l3jvSdoGuxP4b5gsTUXGa0062huDQZ1B8Hk6qxMFL3ZYQm
         zqdsyKoiSPVgai5QuQ+H70cGr6+gCM01kfhLI6pgDTLPqtEd/AriT/PTRFHSCE3dP0F4
         HxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657392; x=1785262192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=657PTF+kjp07ScPIuFpyWerZ9DUGDt4h3eqh5FIi338=;
        b=DmL4bZqfxkS3igBTzgsmUSoR+hJo1mVxwaQVLaUKUefTgcfYriG3n6mt17EyJdbHmz
         eOheUqjWslG34lEkBHLcn5txSPfVyxej7hQdmmIAWoHeFevviBYZZf+63xiy19NwOeA7
         bAPfe4k9JZXdeWZAPH1Nf5nRcTvR1g/ZUmFhUwKBu5HaAifnujne5IfGEhxE/+C+tyA9
         czeyfaum1QaUMySUJu8Ti0BPFVlVJ7W9jKqL0+OGuIMoOgVI2lteOhKFJx46UesAsALO
         4HEqPSBoBL3DFZkOph4l4WjnnCO/snaGO6IQqIMHWj7p8nhHzEHb1HbETRqGoM/OYIsQ
         1OCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmjUHra6bq27YwaZ91WUizTJXqJ0dImtaSfJLbf3Naonx0AMN6PQTMQQYdvcVC1MFn/rw1Xzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4A5pWf1rzuHY8H5Bu4vH5lVFRnhVlmZ12zQwXWktgsd9/Eu9
	V7j1+46BGIInki2T0OkgQZh1jaDXSzYRjwPH/1ihaVKZKw5onBSMYL0E9vQlYIghXMZ9orlV0FF
	Abdz+yMcNxq/Lzhd34pmGBmF8AO++qHw=
X-Gm-Gg: AfdE7clFzETMV2hkGZLhfqm/qXvIrKf7UZMvLgUhEHO06Ul4Rg+e6iQ2eEwjLkPlPUp
	EU9ehO6GDNCmz5UmGycQQdKdtF6U7hbM7JC29Y55iJOYSe7tmOHvzxON2YzHbBeUUw3vYQC9RmW
	+u+rfw0m+GIWOtZcASWG5dMClubyOjVIPjIJt1qcjth1pibwdqQvoNlTSgoiDGUV4ylw2IfH0fa
	HtGnDIGciaQax9PG/tIPzsU0dgVNdo92YWWpImCOZDUN/CX3YW9uOffqx3lvHnH
X-Received: by 2002:a05:6830:3496:b0:7e9:c72e:e5d6 with SMTP id
 46e09a7af769-7eda084eaedmr11684574a34.14.1784657392489; Tue, 21 Jul 2026
 11:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721001851.113927-1-vitaly.prosyak@amd.com> <20260721001851.113927-2-vitaly.prosyak@amd.com>
In-Reply-To: <20260721001851.113927-2-vitaly.prosyak@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 21 Jul 2026 23:09:39 +0500
X-Gm-Features: AUfX_mw6I8-srEOZv-ct3TaNXNnCqiGWYvw5PMQwSGtCQxNY5ldnuWYUg2R-rDE
Message-ID: <CABXGCsOsrFVyFEuOfUm5Vqpf64fbC3RifzGV2QDpGuP0o+gu8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:19=E2=80=AFAM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Move fs_reclaim_acquire() to before all lock acquisitions to eliminate
> false positive circular locking dependency warning.
>
> This is a 7.2-cycle regression fix suitable for stable backport.
>
> PROBLEM:
>
> amdgpu_lockdep_init() trains lockdep by acquiring locks in sequence
> while calling fs_reclaim_acquire() in the middle. The fs_reclaim call
> was placed while notifier_lock was held, teaching lockdep:
>
>     notifier_lock -> fs_reclaim
>
> However, at runtime, MMU notifier callbacks run from inside memory
> reclaim, establishing the opposite dependency:
>
>     fs_reclaim -> mmu_notifier -> notifier_lock
>
> These form a false cycle that lockdep reports when reclaim unmaps a
> page covered by an amdgpu userptr notifier.
>
> LOCKDEP WARNING EXAMPLE (BEFORE FIX):
>
>     WARNING: possible circular locking dependency detected
>     6.19.0+ #48 Not tainted
>     amd_lockdep/3762 is trying to acquire lock:
>     ffff8881756f3c30 (&amdgpu_notifier_lock_key), at: amdgpu_hmm_invalida=
te_gfx
>
>     but task is already holding lock:
>     ffffffff92e4b5c0 (mmu_notifier_invalidate_range_start), at: try_to_un=
map_one
>
>     Chain exists of:
>       &amdgpu_notifier_lock_key --> fs_reclaim --> mmu_notifier_invalidat=
e_range_start
>
>     Possible unsafe locking scenario:
>           CPU0                    CPU1
>           ----                    ----
>      lock(mmu_notifier_invalidate_range_start);
>                                   lock(fs_reclaim);
>                                   lock(mmu_notifier_invalidate_range_star=
t);
>      lock(&amdgpu_notifier_lock_key);
>
>      *** DEADLOCK ***
>
> The dependency chain shows:
>   -> #5 (fs_reclaim):
>        amdgpu_lockdep_init+0x61e/0x730 [amdgpu]  <- FALSE EDGE
>   -> #0 (&amdgpu_notifier_lock_key):
>        amdgpu_hmm_invalidate_gfx+0x77/0x110 [amdgpu]  <- RUNTIME PATH
>
> SOLUTION:
>
> Move fs_reclaim_acquire/release to BEFORE all lock acquisitions.
> The acquire/release pair does not create a static lockdep edge by itself
> (no locks are held between acquire and release), but it registers the
> fs_reclaim lock class. The actual fs_reclaim -> notifier_lock ordering
> is established at runtime when memory reclaim invokes MMU notifiers that
> take notifier_lock. By moving the fs_reclaim registration before any
> lock acquisition, we avoid teaching lockdep the false reverse dependency.
>
> VERIFICATION (AFTER FIX):
>
> Test reproducer (based on Mikhail Gavrilov's standalone test case)
> creates a 64MB GPU userptr memory buffer, then repeatedly forces the
> kernel to reclaim it by moving pages to disk (simulating memory
> pressure). Each reclaim cycle triggers the MMU notifier callback path.
>
> The test is available as an IGT subtest:
>   tests/amdgpu/amd_lockdep.c::notifier-reclaim-splat
>
> Results:
>   Before fix: Lockdep false positive warning on first reclaim attempt
>   After fix:  Completed 8 reclaim cycles with no lockdep warnings
>
> dmesg after fix shows only test success messages, no circular dependency
> warnings. The fix is minimal (relocate 2 lines) with no runtime overhead,
> only corrects lockdep's static analysis model.
>
> v2: Address Mikhail Gavrilov's review feedback:
>     - Fix author name: Michael -> Mikhail Gavrilov in all trailers
>     - Add Fixes: tag to link regression to original commit
>     - Add Tested-by: Mikhail Gavrilov (tested on RX 7900 XTX)
>     - Rewrite fs_reclaim comment to be technically accurate about what
>       fs_reclaim_acquire/release actually does (registers lock class,
>       doesn't create static edge)
>     - Add note that this is a 7.2-cycle regression for stable routing
>
> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock orderi=
ng validation")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Analyzed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Test-case-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_lockdep.c
> index b251350b1fb2..718411f724f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -150,6 +150,18 @@ int amdgpu_lockdep_init(void)
>          * Take locks in the correct order to train lockdep.
>          * This establishes the dependency chain.
>          */
> +       /*
> +        * Train fs_reclaim FIRST, before taking any locks.
> +        * This teaches lockdep that fs_reclaim is the OUTERMOST context.
> +        * When memory reclaim later calls MMU notifiers (which take noti=
fier_lock),
> +        * lockdep will see: fs_reclaim -> notifier_lock (correct runtime=
 edge).
> +        *
> +        * Bug fix: Previously fs_reclaim_acquire() was called while hold=
ing
> +        * notifier_lock, teaching lockdep the FALSE edge: notifier_lock =
-> fs_reclaim.
> +        * This caused false positive circular dependency warnings.
> +        */
> +       fs_reclaim_acquire(GFP_KERNEL);
> +       fs_reclaim_release(GFP_KERNEL);
>
>         /* Level 1: Global userq scheduler mutex (outermost) */
>         mutex_lock(&locks->userq_sch_mutex);
> @@ -168,11 +180,6 @@ int amdgpu_lockdep_init(void)
>
>         /* Level 7: DRM file list mutex */
>         mutex_lock(&locks->filelist_mutex);
> -       /*
> -        * Mark potential memory reclaim boundary.
> -        * GPU operations might trigger memory allocation/reclaim.
> -        */
> -       fs_reclaim_acquire(GFP_KERNEL);
>
>         /* Level 8: SRBM register access */
>         mutex_lock(&locks->srbm_mutex);
> @@ -190,7 +197,6 @@ int amdgpu_lockdep_init(void)
>         spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
>         mutex_unlock(&locks->grbm_idx_mutex);
>         mutex_unlock(&locks->srbm_mutex);
> -       fs_reclaim_release(GFP_KERNEL);
>
>         mutex_unlock(&locks->filelist_mutex);
>         mutex_unlock(&locks->reset_lock);
> --
> 2.54.0
>

v2 looks good, thanks for fixing the name and adding the Fixes tag. No
objection from me.

One question on the comment above the
fs_reclaim_acquire()/fs_reclaim_release() pair, just so the annotation
file stays accurate. As written the pair is:

fs_reclaim_acquire(GFP_KERNEL);
fs_reclaim_release(GFP_KERNEL);
mutex_lock(&locks->userq_sch_mutex);
...

Since fs_reclaim is released again before any hierarchy lock is taken,
is it right that this pair does not actually create an fs_reclaim ->
notifier_lock edge? As far as I understand lockdep records an edge
only when a lock is acquired while another is held, so with nothing
taken between acquire and release the pair only registers the
fs_reclaim class. The real fs_reclaim -> notifier_lock edge then comes
from runtime, when reclaim invokes the MMU notifier that takes
notifier_lock (which your comment also calls the "correct runtime
edge").

If that is correct, the pair is functionally equivalent to just
dropping the old misplaced acquire, and the comment's "teaches lockdep
that fs_reclaim is the OUTERMOST context" slightly overstates what the
annotation does. Just wanted to check my understanding.

--=20
Best Regards,
Mike Gavrilov.
