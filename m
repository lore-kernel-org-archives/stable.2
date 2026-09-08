Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F13A7F6E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855040; cv=none; b=DY11CLW/t5810n4Gc94Q+fZHER/dxMzFRVROt5kF9D8iXnN0oXnmLA29JAx/5cN4vrXOZ/WtfD9MQPf3/pD13Lty98HlDVQZcvoGtLRoWHbLhHtjOJDri7XqbYi+nsHN/8WwQ2nHqsdfR8kvUMSm05L4G/dlasIV0NtLwnlzCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855040; c=relaxed/simple;
	bh=1Ud8/dZbVNomn7snUX6HWLPxtbMautulEZ8HW9eK7+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYPxsyPoGyKFzoz21lD9hM2q97LJA3wbn5/4DXgZhRvTR/2kcObkLETrIf2d4PTkrCsVGH6AJ8ZDtGDB4mcE3s3jXmNnthapUOwFNG5LP5emyAVw7FGtMJ5Lz4xEcnxoY8S05DfBcmaAluTBmEmKV6DIT3k97duF4Fl9MZrguCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuvCCa9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuvCCa9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3331F00ACA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788855038;
	bh=/LQ40bG3b0qEiWUXfmVaeOdjqlO0VS+wXll0EN2GKX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VuvCCa9vusaCARP4kqjikR+bv6LqFhsoUvglKfI1pJ9AsquQHsudSXKaSRn8WciPB
	 PU18JpWe+CCGQx6pgLnGpxBdjf9d+Mqnyw1E9xm4a2xJ9aDt7sm9IBOWx3+xaz5O9f
	 2Ay4dvMkb9bSXsEADr3vdT7M8wxiU/jRORNkZoyRhXHNLqO1haqy9GfjsmUMdT66EI
	 /nA3gQ0tWJ5CJnqoSdyAGbyi8ZDHkzxKrSvGBcabUcF1k0uQ+jmtd8hmMrk2ac067f
	 Pv4LmFlyY+5QoFse7RhmSATPp2FEbb13AOVufv4NIVar572vARYJfyAfl/ECwAFfOy
	 Xa1T0McJHfLpw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c28fde3bbd2so211544366b.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 01:10:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwB+dHKRZVKDxV8xmG8EEeEBOCJecaVkryote0rzBP0jW7y6PHpIPqXmS463zqZjlCXI5EGFbI=@vger.kernel.org
X-Gm-Message-State: AFuF++kufvKNXE1UGaeeyDpy0gbG0Nb0l76ocDgTUxlG1ZnrCr1Qupia
	SfNRwm4JdROdtk8g111WWSlmL8Snj3dIQvRFOrNpqH6VQKVVZ41aye0eOiIbt78TAeZPyJY/LCK
	4l01mJ3bDFSEiqVljWI40g1LEThW+uIE=
X-Received: by 2002:a17:907:940b:b0:c26:1691:b366 with SMTP id
 a640c23a62f3a-c261691b9d4mr944555766b.31.1788855036997; Tue, 08 Sep 2026
 01:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907161938.1932355-1-usama.arif@linux.dev>
In-Reply-To: <20260907161938.1932355-1-usama.arif@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 8 Sep 2026 01:10:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNr7jMYkWjaRYpQYkR8yQT3R5guV=2EXTfWBipAZ5kEqw@mail.gmail.com>
X-Gm-Features: AcwNN1WdBn7Fr6APF4VR9MOEKeL7VFm43JjsPuRw9XMXiiE2ug9S5SNh0owgQu4
Message-ID: <CAO9r8zNr7jMYkWjaRYpQYkR8yQT3R5guV=2EXTfWBipAZ5kEqw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: don't fail a large-folio swapin whose range is
 not in zswap
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	kernel-team@meta.com, stable@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
	Longlong Xia <xialonglong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 9:20=E2=80=AFAM Usama Arif <usama.arif@linux.dev> wr=
ote:
>
> thp_swapin_suitable_orders() and shmem_swap_alloc_folio() sample
> zswap_never_enabled() to decide whether a swapin may use a large folio.
> zswap_load() samples the same one-way static key again once the read
> reaches it.  Nothing serialises the two reads, and in between the task
> allocates and pins a high-order folio, which can sleep.
>
> If zswap is enabled for the first time in that window, a large folio that
> was correctly permitted reaches zswap_load(), which rejects every large
> folio with -EINVAL.  swap_read_folio() treats anything other than -ENOENT
> as "zswap handled it" and skips the backing-device read, so the folio
> comes back unlocked and not uptodate: SIGBUS for an anonymous fault, -EIO
> for shmem.  The data is intact on the swap device - it was written there
> before zswap was ever enabled - and the not-uptodate folio stays in the
> swap cache, so every retry of the fault fails the same way.  With
> panic_on_warn the WARN takes the machine down rather than the task.
>
> Scan the range instead of rejecting the folio.  The caller has pinned
> every slot before issuing the read, so zswap cannot start a store or a
> writeback into the range and the scan is stable.  If nothing in the range
> is in zswap it is all on the backing device: return -ENOENT and let
> swap_read_folio() read it.
>
> A range that does have a slot in zswap is still refused, because zswap
> stores large folios as order-0 entries and cannot reconstruct one.  That
> stays reachable - a slot shared with another task can be stored inside
> the same window - and refusing is correct, since the alternative is
> returning the stale device copy.  Report it as -EIO rather than -EINVAL:
> the request is valid, zswap just cannot serve it.  The only caller
> distinguishes -ENOENT from everything else, so that part is a
> documentation fix.
>
> Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io device=
s")
> Cc: stable@vger.kernel.org
> Co-developed-by: Alexandre Ghiti <alex@ghiti.fr>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Acked-by: Yosry Ahmed <yosry@kernel.org>


> ---
>  mm/zswap.c | 58 ++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 15 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 37f34e406c8e3..fd36ac38e9a1e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1571,6 +1571,32 @@ bool zswap_store(struct folio *folio)
>         return ret;
>  }
>
> +/**
> + * zswap_is_present() - is any slot in [entry, entry + nr) in zswap?
> + * @entry: base swap entry of the range
> + * @nr: number of contiguous slots to check
> + *
> + * Context: The caller must keep the range pinned, otherwise the answer =
can
> + * change under it.
> + * Return: true if at least one slot in the range is in zswap.
> + */
> +static bool zswap_is_present(swp_entry_t entry, unsigned int nr)
> +{
> +       pgoff_t offset =3D swp_offset(entry);
> +       struct xarray *tree =3D swap_zswap_tree(entry);
> +       unsigned long index =3D offset;
> +
> +       /*
> +        * A pinned range is at most SWAPFILE_CLUSTER slots and is aligne=
d to
> +        * its own size, so one tree covers all of it and a single lookup=
 is
> +        * enough. Scanning only part of the range would report a false
> +        * "absent" and let the caller read a stale copy from the device.
> +        */
> +       BUILD_BUG_ON(SWAPFILE_CLUSTER > ZSWAP_ADDRESS_SPACE_PAGES);
> +
> +       return xa_find(tree, &index, offset + nr - 1, XA_PRESENT);
> +}
> +
>  /**
>   * zswap_load() - load a folio from zswap
>   * @folio: folio to load
> @@ -1578,15 +1604,12 @@ bool zswap_store(struct folio *folio)
>   * Return: 0 on success, with the folio unlocked and marked up-to-date, =
or one
>   * of the following error codes:
>   *
> - *  -EIO: if the swapped out content was in zswap, but could not be load=
ed
> - *  into the page due to a decompression failure. The folio is unlocked,=
 but
> - *  NOT marked up-to-date, so that an IO error is emitted (e.g. do_swap_=
page()
> - *  will SIGBUS).
> - *
> - *  -EINVAL: if the swapped out content was in zswap, but the page belon=
gs
> - *  to a large folio, which is not supported by zswap. The folio is unlo=
cked,
> - *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
> - *  do_swap_page() will SIGBUS).
> + *  -EIO: if the swapped out content was in zswap but could not be hande=
d
> + *  back, either because decompression failed or because a slot in a
> + *  large-folio range is still in zswap and zswap cannot reconstruct a l=
arge
> + *  folio from per-page entries. The folio is unlocked, but NOT marked
> + *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
> + *  SIGBUS).
>   *
>   *  -ENOENT: if the swapped out content was not in zswap. The folio rema=
ins
>   *  locked on return.
> @@ -1605,13 +1628,18 @@ int zswap_load(struct folio *folio)
>                 return -ENOENT;
>
>         /*
> -        * Large folios should not be swapped in while zswap is being use=
d, as
> -        * they are not properly handled. Zswap does not properly load la=
rge
> -        * folios, and a large folio may only be partially in zswap.
> +        * A large folio can legitimately reach zswap_load() with its who=
le
> +        * range on the backing device, so scan the range rather than rej=
ecting
> +        * it outright. The caller has pinned every slot, so zswap cannot=
 start
> +        * a store or a writeback into the range while we look.
>          */
> -       if (WARN_ON_ONCE(folio_test_large(folio))) {
> -               folio_unlock(folio);
> -               return -EINVAL;
> +       if (folio_test_large(folio)) {
> +               if (WARN_ON_ONCE(zswap_is_present(swp,
> +                                                 folio_nr_pages(folio)))=
) {
> +                       folio_unlock(folio);
> +                       return -EIO;
> +               }
> +               return -ENOENT;
>         }
>
>         entry =3D xa_load(tree, offset);
> --
> 2.53.0-Meta
>
