Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A43AFCFF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946982; cv=pass; b=ZU5hccKUFrgJlp/vgWs04n2cmrqzw7hkWJ6eqeDngK2xe+8TVqGiTxm18yaywGq3eYmXdT7lXzsr5odqySxndIygMbNKmlhijbgc9CF+sNcLT1bRt9wQsz+ZpxYsXykORf4KWejTw01hHBvGJP3RDqRx2Gbpb67/p45DSFDaz18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946982; c=relaxed/simple;
	bh=XbnitDCqJmDt4WiuCkkU/XQ2pMAbka+HkyNqYHBdhkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3qQnzn2PBRGEnFlxuGX3y9R5uxv7VRX8UhKooXZdjF22eT1WDCQfcMijVeXxI2Lcr6b8NocgbPilBu/5IKGHiLlleKtYgTuZk13ZJ22n4OooYnyWTvL2XnqulaGpqItX6ODQpKMoA9P1C2TqbSseBzTRgd76frOIHVGtmOwh7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr6ny/FC; arc=pass smtp.client-ip=74.125.230.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr6ny/FC"
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3a9ad752b4dso3318431fa.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791946979; cv=none;
        d=google.com; s=arc-20260327;
        b=lQ4y+ae1oedvZ+O0QoW2AWgjh0CSOS7+gHZ85f9D8DWNy7RaOWPAV6FoAZAY16d3in
         6M64z6CjZjxs4fBIdCVXFhMkTyoV3UmrY2vR7UAw8jempEJ2+yhYcojxP0EG0Z84qrHC
         GeLYqEoAWr0EaO4L6mynyd7QJrmP/4kG2wG0e9rrZxplOpVKmJl8X73MZDAoojBLyV1z
         5VUuJh0xmt6YG6HU1Iq/qy6K71fOch+WSkoSVLR+JMTk7oP+DnSJGhMxmgk5Qg2V7XB4
         dOL8eosZYuUoE8Y6/dMnVMItGe8IpbqI1uXybeB06QiGdAk/DO/vtZtQvH+GrvT1n5Pu
         15bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
        fh=cee82V7wgAYLsVV0AEpEmJiB3hTIwbYTnf+9FQ4pks4=;
        b=XlEKs0lZI+YkRqipn3j42xQE6zKNrb5LYmhlmS3P+/scb1W6Y8kLlAy4bMMHSKbkSy
         xcRoYcF8VoPNEjly3ldHMN0ZuO+D5y+oKgXw/lTE0dnTkjzJWe54ZtHM2ZLPQMD/qcFi
         Y1/SJTKLTgJmCpnknPkt5h7Ea/Vr+MMc575/tncL7C+ZbIJvH2Nuasx5JU2amP9Q/bKE
         LsNI4N9GvIrspZ0YJuyfcaDt9Uipqm9W4AlR9xqtNcsVThRFBMvdz5OFkP9wY/PnarM5
         gB8boiSAauh8bS56c07HcYCwtDqHPtsF/XrwunRclwGPJOxmkHUMZjDFKi+fsaMbM90v
         SdhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791946979; x=1792551779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
        b=Nr6ny/FCNuxO7wKnt7LHbQ2mJTzNobX5EkYz3yTUOp92xNQZyaoCW3+BbiTthhSLoM
         VFSjIOYuET0+gI7Nbadtn6DyN6gS+s4iXAr2rHGWeNqcKofK0lPjaMDJeWIkTW4emCMY
         /PkkU6gLOmALKnmmmhOZSENFPzFIbfEn/BIzBgWn8+dnXUkskrvGBrWaBOUYvtQgGqx8
         Pety6akyXpi/nDQqPE5uKcMc3jaOnyHGyagZqGxjQWF5MlzNV0mmyfJ614RBlO8cnqtz
         /i32U64HuxW5qgb8p96YkrFEDmVe/g1O1EBP9/z2eYBfut7m81aW/WFSuNPd6Xbo0XDP
         P26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946979; x=1792551779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
        b=thxjXOA6fpl553JgHmv83uXvBLcMBW6rOvJ7uu65fV5VjcR1XgGFXv0KFXLfloDm7Y
         jfqCpZlQaokdvPHFOglJkG2QZWLwCMW3WAk/TBrSIz0K9JBxURZdEWOTU5/e4p9JBMVT
         rRMhiMlL0H6IMxgZiwWfzOT8u3esU3JkRLZtgfhzrL8i/jEFkbv4e18/el5aC1U8USfP
         yTDDzW0etxB0tiwWl3/VoHXCd1W+b7yZyrKyWf0Eyia6vucztWUxNgUfFsQpW4JqiO4a
         bgGJOfHf9uGUk8wJ6+QY1oW0/nRanW6Z6WOXz5WLGIX4NPQdLn7q0JcXyo2fMInM/Neh
         RLLw==
X-Forwarded-Encrypted: i=1; AKwUvBzcsnVRa3bC7KeEcSSxkQPXgS2FLnWvegjDslcGSUC98arO8tGBenHcy9RpCV3QWjHh8UW30p0=@vger.kernel.org
X-Gm-Message-State: AFq9FYITnQ/xEAUeiFApWFhvMy4UE1twg4RQiFfiA256ITUguvwUHRH4
	vX+xF2aH5NIGX5g17/XD2t9HBjY2uWZfgbQoQi60iA7RMsm+GqWOV52qaZXkvP3K6c25omL1u2a
	aMJr3Py6U3Llh1wMiSvtdN+EmbSrd/BI=
X-Gm-Gg: AYBFou3isOEjgentLymJ8NQFI29XW5GAowBl10ZBojoT5qHUpqrQRXn11fIfoTwncmX
	/9KXYMdD71VbHUWxlWk/gqyFIBagj9gAh3YVZGG62OgLJIpuH1RgAnK/wAOuwqZB9TguF0afFCt
	BvuqCkUSabEfolWDR1kEMIGFe45/IrbTpglfOz+VUJsmdV5jx/jQO+z6P2DhmnvO1RR/2emy9pu
	ofyqAsHw4ac+0sY8dgFruA03UbxQpK7ov4dN8d/nP72e2EdQWJTSx77+fwxTWK2ZLy9eKYk7gdn
	1myItU1cFjMZpAfQmyrpPbROmKa6AVpOnGDEuzGxpUKWLztLz+7Cmk2Hzk2Z4LKqxoQ=
X-Received: by 2002:a05:651c:1542:b0:3a6:692d:b7ed with SMTP id
 38308e7fff4ca-3a9c539343dmr38351911fa.20.1791946978412; Tue, 13 Oct 2026
 20:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com> <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
 <4df51e6e-b017-4057-96dc-32d4003f8705@amd.com>
In-Reply-To: <4df51e6e-b017-4057-96dc-32d4003f8705@amd.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 14 Oct 2026 11:02:46 +0800
X-Gm-Features: AclHuK9wmlZSIF4pzMKiC6asGVwJ7ETTkkdCmGmvxP7lUevo_EYe8yPIyar_-KM
Message-ID: <CAEnQdOpWJ-73FyQzgov2g9___KWptdK5PZcOkwi1FS4b6mhOFg@mail.gmail.com>
Subject: Re: [PATCH v2] amdkfd: fix doorbell allocation race creating
 duplicate allocations
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

No objection at all - 16f0013157bf ("drm/amdkfd: Allocate doorbells
only when needed") looks right to me.  Thanks for the archaeology
and for taking care of the tag before submission.

Regards,
Henry

Felix Kuehling <felix.kuehling@amd.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=89 01:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-10-09 23:02, Henry Martin wrote:
> > The check-and-allocate sequence on pdd->qpd.proc_doorbells is
> > lockless at every call site of kfd_alloc_process_doorbells():
> > kfd_get_process_doorbells() (mmap of /dev/kfd),
> > kfd_ioctl_create_queue() and the CRIU restore path each test the
> > pointer under different locking (or none), so two racing threads can
> > both observe NULL and each allocate a doorbell BO and bitmap,
> > orphaning one allocation and handing the two mappings different
> > backing pages.
> >
> > Move the serialization into kfd_alloc_process_doorbells() itself,
> > using a new per-process-device mutex so all three call sites are
> > covered regardless of their own locking.  The device-global
> > kfd->doorbell_mutex is not suitable here: it is acquired under
> > dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
> > kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
> > the sleeping allocations above would create a lock-ordering
> > inversion with dqm->lock via TTM eviction, and it would also
> > serialize doorbell setup of unrelated processes behind a
> > device-wide lock for per-process state.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 2105a15a2046 ("drm/amdgpu: use doorbell mgr for kfd process door=
bells")
>
> I don't think the Fixes tag is correct, even though that's what Claude
> suggested. As far as I can see, the code had the same possible race
> condition before that change. I believe the problem goes back all the
> way to 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed").
> If you don't mind, I'll update that in the commit description before I
> submit your patch. With that, the patch is
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
> Thanks,
>    Felix
>
>
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >
> > v2: Use a per-process-device mutex instead of kfd->doorbell_mutex
> >      (avoids the dqm->lock ordering inversion and the device-wide
> >      serialization) and correct the Fixes tag.  Pointed out by Felix
> >      Kuehling.
> >
> >   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  1 +
> >   3 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_doorbell.c
> > index fdcf7f2d1b5b4..55acadc986bee 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> > @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *k=
fd, struct kfd_process_device *
> >       int r;
> >       struct qcm_process_device *qpd =3D &pdd->qpd;
> >
> > +     mutex_lock(&pdd->doorbell_mutex);
> > +
> > +     /* Another thread may have won the check-and-allocate race */
> > +     if (qpd->proc_doorbells) {
> > +             mutex_unlock(&pdd->doorbell_mutex);
> > +             return 0;
> > +     }
> > +
> >       /* Allocate bitmap for dynamic doorbell allocation */
> >       qpd->doorbell_bitmap =3D bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_=
PROCESS,
> >                                            GFP_KERNEL);
> >       if (!qpd->doorbell_bitmap) {
> >               DRM_ERROR("Failed to allocate process doorbell bitmap\n")=
;
> > -             return -ENOMEM;
> > +             r =3D -ENOMEM;
> > +             goto unlock;
> >       }
> >
> >       r =3D init_doorbell_bitmap(&pdd->qpd, kfd);
> > @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *k=
fd, struct kfd_process_device *
> >               DRM_ERROR("Failed to allocate process doorbells\n");
> >               goto err;
> >       }
> > +
> > +     mutex_unlock(&pdd->doorbell_mutex);
> >       return 0;
> >
> >   err:
> >       bitmap_free(qpd->doorbell_bitmap);
> >       qpd->doorbell_bitmap =3D NULL;
> > +unlock:
> > +     mutex_unlock(&pdd->doorbell_mutex);
> >       return r;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index d8631847f0eb9..96e59133fee02 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -779,6 +779,9 @@ struct kfd_process_device {
> >       /* per-process-per device QCM data structure */
> >       struct qcm_process_device qpd;
> >
> > +     /* Serializes process doorbell allocation for this device */
> > +     struct mutex doorbell_mutex;
> > +
> >       /*Apertures*/
> >       uint64_t lds_base;
> >       uint64_t lds_limit;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_process.c
> > index 0a7c1900da959..4efe4dae79c13 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -1788,6 +1788,7 @@ struct kfd_process_device *kfd_create_process_dev=
ice_data(struct kfd_node *dev,
> >       pdd->dev =3D dev;
> >       INIT_LIST_HEAD(&pdd->qpd.queues_list);
> >       INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
> > +     mutex_init(&pdd->doorbell_mutex);
> >       pdd->qpd.dqm =3D dev->dqm;
> >       pdd->qpd.pqm =3D &p->pqm;
> >       pdd->qpd.evicted =3D 0;
