Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFF3F6C48
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910973; cv=pass; b=g6XakdglagOT3DcDrAhaF27hKvG89GPXkDu5Krt++IhHBKKBlorzmwnB8diCeK88GzABrklxVbII3IEoFAp/spr3uV7sbqcN8dRgfwxnP0Fa54urQ7kn9L9V56nXBFeL71gFFjtzkBKVTJtYczXBIuggO+GIJG1HaQ+1MgH5XTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910973; c=relaxed/simple;
	bh=SJkoXE2LDFoycY5CvAR6OLmTFDyh9eXkmfLnoJEE86A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra8cPiqJGZnvz4zSAbIH8Z7Ju2EmyoTjoyV01LO/6Cqra6Hx9VMi2XXP9ssW3R3DxXcTHZkMxAVUb7gAFz5ZUFbTyBcOqvyIrGUt830YUiAewMO4+H67FlFzPqulke6b6np65dS7ItK71WSLr29MJvsN1wZy7M4y58D1e6ymblk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCDO+Gib; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCDO+Gib"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso6724655e9.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787910968; cv=none;
        d=google.com; s=arc-20260327;
        b=VFGZB16eCCzhEYUgMXAHUdHVNnFE2361dgfi865mSl6m8+dQZIlAgnTfgBtcl/G4v6
         sIOGgpd7vCFGNUaXrOPbdYH82ZesmjAZhD78oDXgLoU2Y5/jr3U0R+L63IzVh3iCFKl8
         +9e0RUjtR97SAyHBsoWaX3kXsetV8ckNrh8iBE091Akav7SS9Gj7RA+70bw+BhXVdXDJ
         4HImlxgMb04xXmfBpwwbOGptpRMtOJGNrtop+J9A9wDT8BQ5Ps/UHwPMNJ6sAw+cCV3z
         zLSsP7D2G0EDtU4n0feysnyMWURP7IofGsMTSNcLxPHaQYN9HZopSjrfapQDbkN6BZ4x
         0rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXhc6GUfnqTLNzw9wGDoz+Flj8b1JzYpQruHE4OUFPI=;
        fh=HY0YDQ3NcYN2m+sH1E/Pz2qD3fBU58dhbCtNeGcf7j8=;
        b=ZTN/9g23MGsN0y2iTOGdA0QI07i/pkVBqUVcrUJI8LsizlAY3Dy5AcJEr6qc6VRUNa
         Ef8+MXFnMN10cF78fHd7iJIb6rSfOG3ieuJwB6BWhsbypXcfbWDjNFiWZ5ulPJls5emm
         ErWkAKjyxIZjfQX2PDM5zEzDG3p4TfiKhjzLaerij9zKEbTEmfaCwjJqstFtB51qHCex
         wlhtyFoNW1d1iE/hNqSPnyUtSpskbhKQFumgyC4FAuhx+FR1B/TiG1HQ9bFhkyAh9Be7
         T0bB7jt1oYPcyRLWTL1ZWz/QGfXTBmBJBCjCkR5D516aT381hxBAZ6feoYHOsqMNskzh
         icIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787910968; x=1788515768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lXhc6GUfnqTLNzw9wGDoz+Flj8b1JzYpQruHE4OUFPI=;
        b=WCDO+GibFY043hIlmxokYPi6UytvwVpbohN+2dH9sdXM1J1vKt7IbShIFCm8CBLdlA
         ZFNkt0obcR3rQzoUywsXhdSBxLV4wTuewOmJ1LyNEOrakHQRkgFJU8DceQa8sGUk6pjn
         jHJYxFZgXni8+c98demf6PYEsko6P85rYFxbDykGi3ib6xWd/ELu5BQgpVln0TJLkohw
         TGvdKfg13J07CpmAnLb5ENi45t8hF59XMjjkntdjpja/FqFycE6mXUCOeg8aFsxW3vSZ
         +Cu7++/pHaTvTXgPI4DQdLyc6Z0LkmgqHFHEs6hA7flj9jlQt8hPS9zGdvfKfW/aG0/K
         4kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787910968; x=1788515768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXhc6GUfnqTLNzw9wGDoz+Flj8b1JzYpQruHE4OUFPI=;
        b=RMAnkSfb06BO1F1iaRwCRs95vkAGeWUKVJkabU4Um3Vd4Mm3/rTkBxpsxrfzKIYD82
         jC1GVksrVY0nv1Es1ft2w5vKEQvh4jDCa0v0Js09woa5C9AsaIBAI/E5rM5lJwlMFsM4
         qgT0C/Q0+Y/zY7mg+oFrZpK+J9ix2hz25VG4ploThNzAlxmgggnqyR7Q14OqnYryURTI
         JNE8n7PIhN3PoY3N8wbzrPk4MVrPXqPKwy2vqyFvrWQ/9mI5TONrrkponfIgTHbt9239
         nmI1ouAlITuaNBmuGRGNhpm8qTlsUaPSuujx6BV2pK+HVAwTgNJrbb+1tRVoavwzO/hN
         swNg==
X-Forwarded-Encrypted: i=1; AHgh+RoAyZB61Xh5TWzLmEgK22tib5gAeOD7RPWBe33TXR5+ATrTQsQylZGkWjKgbKsttvQM10Zq8b0=@vger.kernel.org
X-Gm-Message-State: AFuF++lhK5Hpnpuuhhx1w4Yq1D7saNAczFPyayZbHIPj/zbY6ZE//Qf6
	hl4dhbPU4FUn3nY7SQVUyB1a6MiDmFLYr0X0SUlv+RaJPBYsFBwxg8unxQbpV+SRkXUVYFm1DvS
	a4PGz1m7eDH11turaVeT+HTP0WCh/B8c=
X-Gm-Gg: AR+sD10J0Uud8hc8cKMJRkxFkBXCCQu92ejnF0LqGcVVgX3iVhXbl8SvZNEzsMLwDtY
	TqiX3nkQjWeqo2WqMuumlLTB9arlOqV9EV3L7/PlGvKqwu7Wd86oKl57O3h8JOiciVg5GozCu8C
	96MEmP0wmnhB42VKmmIDlMUpFvmq9cDxvamXshdDwqibScq566iMhA750d+PmW6LttUYJdR+yGi
	o8+fPmRCEYTONf/P6UgbJ5RJ9CrL90tlBcddCar8+lgsiP4H+amdEIaSnwIsLUirkwhktRVQEqO
	A5Oe8kBD8SSLdmze1EnPcJSkrY85FecXpWwXbDhWr76b4nztuJe50eYXk1tXcpQj+RFVNgPaEAC
	L7Q==
X-Received: by 2002:a05:600c:4443:b0:499:b3f0:ff05 with SMTP id
 5b1f17b1804b1-49b91c56f41mr63926635e9.13.1787910967695; Fri, 28 Aug 2026
 02:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
 <20260826151520.202465-1-kunwu.chan@linux.dev> <ao8F2ZO2GGvxIgcQ@gremlin>
In-Reply-To: <ao8F2ZO2GGvxIgcQ@gremlin>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 28 Aug 2026 17:55:55 +0800
X-Gm-Features: AcwNN1XLLuUW5ug1ksrH3NHF46jSKOiwPOPgx_Pcen4_qbW40l2Xxpb-yeltmF0
Message-ID: <CAN_Opa_mAyku745gobtT39mM--KKqCkw9kvfU2Oq0c_k+RV9uQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Li Xinhai <lixinhai.lxh@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Wed, Aug 26, 2026 at 11:15:18PM +0800, Kunwu Chan wrote:
> > On Tue, 25 Aug 2026 08:55:26 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.=
org> wrote:
> >
> > > Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can r=
eset
> > > a faulted VMA into an unfaulted one.
> > >
> > > It does so after the page tables have been moved to the copied VMA wi=
th
> > > MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfa=
ulted
> > > as the page tables it had are no longer present.
> > >
> > > However, in doing so, it violates the invariant that the anonymous pa=
ge
> > > offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.
> > >
> > > This is because a VMA may have been faulted in, mremap()'d (causing a=
 delta
> > > between its page offset and vma->vm_start >> PAGE_SHIFT), and then
> > > mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.
> > >
> > > This condition is a violation of a fundamental assumption in mm, but =
now
> > > also triggers an assert in assert_sane_pgoff() which explicitly check=
s for
> > > this condition.
> > >
> > > Correct it by resetting the VMA's page offset at the point of complet=
ing
> > > the MREMAP_DONTUNMAP operation.
> > >
> > > Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE=
@google.com/
> > > Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with M=
REMAP_DONTUNMAP success")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > >  mm/mremap.c | 22 +++++++++++++++++-----
> > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index e8df5cdb0ac9..2b4b523a86b8 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -1331,18 +1331,30 @@ static void dontunmap_complete(struct vma_rem=
ap_struct *vrm,
> > >  {
> > >     unsigned long start =3D vrm->addr;
> > >     unsigned long end =3D vrm->addr + vrm->old_len;
> > > -   unsigned long old_start =3D vrm->vma->vm_start;
> > > -   unsigned long old_end =3D vrm->vma->vm_end;
> > > +   struct vm_area_struct *vma =3D vrm->vma;
> > > +   unsigned long old_start =3D vma->vm_start;
> > > +   unsigned long old_end =3D vma->vm_end;
> > >
> > >     /* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
> > > -   vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);
> > > +   vma_clear_flags_mask(vma, VMA_LOCKED_MASK);
> > >
> > >     /*
> > >      * anon_vma links of the old vma is no longer needed after its pa=
ge
> > >      * table has been moved.
> > >      */
> > > -   if (new_vma !=3D vrm->vma && start =3D=3D old_start && end =3D=3D=
 old_end)
> > > -           unlink_anon_vmas(vrm->vma);
> > > +   if (new_vma !=3D vma && start =3D=3D old_start && end =3D=3D old_=
end) {
> > > +           const pgoff_t pgoff_unfaulted =3D vma->vm_start >> PAGE_S=
HIFT;
> > > +
> > > +           unlink_anon_vmas(vma);
> > > +           /*
> > > +            * The VMA is now unfaulted and it is an invariant that
> > > +            * unfaulted anonymous VMAs have page offset equal to
> > > +            * vma->vm_start >> PAGE_SHIFT.
> > > +            */
> > > +           vma_set_anon_pgoff(vma, pgoff_unfaulted);
> > > +           if (vma_is_anonymous(vma) && !vma->vm_file)
> > > +                   vma_set_pgoff(vma, pgoff_unfaulted);
> >
> >
> > Hi Lorenzo,
> >
> > I think the fix makes sense. One thing I wanted to make sure
> > I understand correctly is the distinction between anon_pgoff
> > and vm_pgoff here.
> > Is the intention that anon_pgoff should be reset when the
> > VMA becomes unfaulted, while vm_pgoff should only be reset
> > for a truly anonymous VMA, since it may retain file-offset
> > semantics for VMAs with a vm_file?
>
> Yes.
>
> This is to account for both MAP_PRIVATE file-backed and pure anon. But to
> keep everything consistent (+ simple) we always update anon pgoff for
> everything.
>
Thanks, Lorenzo. That makes sense.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

> >
> > Thanks,
> > KunWu
> >
> > > +   }
> > >
> > >     /* Because we won't unmap we don't need to touch locked_vm. */
> > >  }
> > >
> > > ---
> > > base-commit: efecab401cb15fd3bb9bc05990609acb6b267ff2
> > > change-id: 20260824-fix-mremap-dontunmap-pgoff-a687134e995e
> > >
> > > Best regards,
> > > --
> > > Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > >
> > >
> >
>
> --
> Cheers, Lorenzo
