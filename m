Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41C4078D6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497710; cv=pass; b=m/2KlRHRspwJTbbZXtwO6HtYm6YP2zh9OseGCarPb2lb9axhRcOa1HweliTLEg3+gRj4f2QgTfY3tQLPuI1w84TWSpTi55tXedd9kUsmAmapG7hh8Jl4pC4iYRaKGktcbOvcQf2pxdiv1zkIrssg1n5zp+JASpViJtSuplpkhHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497710; c=relaxed/simple;
	bh=50d1uE3e516FcuKcJBARjzR3CF54j+BPldZrMS2BwRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/V1tw2ujZm+CJyyIcELzPZFjsvkcKTYAvUvMJs38sCtTO9iEkNH58+bYT5tK4RErD4AuVz6DOlZcRgLZY7F/m38/kDfjsbaO3SMXBoWFOMB5zEfSs/Ye7Dbpgop16vafgZ6d30TBqySKt6V/0FY8sIDnccanrh7izHm0If+wSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=OMBnzDH4; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="OMBnzDH4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c250f28f1cdso87693066b.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 21:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788497705; cv=none;
        d=google.com; s=arc-20260327;
        b=dgDiChAkle5+tpJPmhkeZ1UhKHVrL4a4TWFp6sPWk5shevYNjJEz2JqUo2sraRNHqk
         32ksjUahDs2oimZXN7oFTnm3RlpYDCDGs5pnGiOenoy6lWOwMasjrg1DjERt+EKJXqzh
         YsrycqhiDf0i9diuYNzz7pi61RszFTHLL9/icq/Dqx4VmMTJf2EVJmzHdps0/+rRz/Gl
         Cvfy1HC62ZUoh48/d/Dd8TfJw2ejBddlNA77IG0PHT630WvhtzDB0xxRXZROkPkXVtQt
         0/3UIAsdGYd/dwdr7TlV9NjLx5e/B88URrTuoqfXdmiXZkmB5YqTNEkzshduRWLv2IOv
         HRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EI7EvFoEjqQRvho+B0qg3qMMOSTmkt21QeZyDxiJh8I=;
        fh=q6HRy4Q5Vfs4TRjr1gFpZVneV6EfxgInmh/Ib/YOOmY=;
        b=ITYAgsFG5n6rLPXiqKriqce14H1KfTu3kGBccIYe6Z1vzOj8KcO7sjHyoOPFPwmlsw
         QyPqL1KK7nR45jzqOTLzEPdi5DIC5npjrLajU4RtVq6c2D/az/kQQd1qxi5sPXP+e7Td
         LiUl2+ouK/TVnwi4vM9zye+Em4SmC3N1sOVwjr7/IGVb6moGrQcr4yMn7mhUAVNkg1JG
         kYAKfIaoaaCvSb/bRd0VPsZ80e82zSRyDm/1Ald5CDazJcuIV74IugDtjCGS0Srdgjkk
         mi2vBzE6ew0yD+hGpvka6ddUIeHboOrvSSblRM8ul7CHdPfQR8ghAJV6VJ+0F/7f+Wff
         KKow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788497705; x=1789102505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EI7EvFoEjqQRvho+B0qg3qMMOSTmkt21QeZyDxiJh8I=;
        b=OMBnzDH4bKZhVtwZMMMGHjBVLT1/B+clbiMqcZsuI4O5RIkG5a+CJs/XRLh701n/9d
         kDTmRuprdIV5B4vdq7UfBcNpaYOUZ3o/9HnLGAX5h7CBIWEgQq9mWhj+dycW5LGZ7k4b
         jppyR9f3A3QPxBOoLjXsaWDC/oxLbvXkZqEr/BkiyiZMiPA17DQwnFbEwmJ/2+5YkzJq
         EzactsowJqBvkgnquudz3hAYh6L7Yj14R5weAweAaB3Xd+Vl46PMWk/+vGMSwyk9lVpY
         /VKDEDNGZseXUuEP4+b0Qo+3WcKIFpnEg3pP0i4KWJBgtFkYmqPj4W88o7TBJLYLS2u/
         gebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788497705; x=1789102505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EI7EvFoEjqQRvho+B0qg3qMMOSTmkt21QeZyDxiJh8I=;
        b=FFkt1c94tEnfFTjBDwYSRHBLCSflna2b0lGfVazO+OBEm70VFkanuNaQ+ygeTr7UWT
         kgjVlNCVXLy9dJCikEEU/itTFqOmQGmiRTVStj6ZOr19rSkCex6eJmvefaHAv2qBb+BW
         wOvoV80PyDi77bBxsgQvFq1QrAj0M89yBhqUOoFlCnxnlcBnPULo9TIVktbv+13rlQ5L
         JyaOdw+GQQeURLnzjugg7LMFSHpbYXQuIWzacxre5v+EJyZ8PdVJ8IQU8FMdelU8PN+l
         kui99xdsLLGlCOkjuOE852yeGNWbP5SaZ/PZWamwajfHED0yhlqEeIDnepar5HkWKerU
         kgLg==
X-Forwarded-Encrypted: i=1; AKwUvBw9GkTD7+X3wh1tv93LHVrkMpvjZ60LnKGYGN+2wDA6RXDLMMP6OcjT5GpC08k+/heN7CLd6wk=@vger.kernel.org
X-Gm-Message-State: AFuF++kyQwU/+IRpRzN3fGIiWgloVQfDBffQX+q9XQCDBGXqtQaexqYb
	Z2/dPIoAcfADpjlIo5dMy+MXtBLutGUTfW3II2LFqfj8weGzrSH8iA5oBM5WHWdioKZGn70/4FZ
	u9VHJwhF6IQa4BVHm/OTVaJ+JKV8g0LI+5F8l4VdH6w==
X-Gm-Gg: AYBFou3X4bfvukj+Ran2YKEV8zEUlwXYX8FHDLVFYTXF620fAj3uhMDXdJfUr1e13bD
	DyPb3i374K7U0oztpCUWoopcyfPAp9GmjU+qC7pY/1O82SGRG0GP0t5wty5uqR3vxkWCQHTPuaS
	5QWMtSssBXWLxYeuNq2wWE+ZBDVEQuednyR9wAjNf8vU5bwH3oWk1sFFiQMvCEtOQyyxNZwoyI7
	InZD1SUqZ05G4UVJwn/ASmga6cg6smhF7evBTFVrKwu6B9oMncXfM0UpKMG0tsz30dCkQHMpPbo
	sADgtJfX5nX5KqmssZ73S5E8kAbG9s89wSr7z6Iu7NWhqg==
X-Received: by 2002:a17:907:b051:20b0:c26:19de:9ad9 with SMTP id
 a640c23a62f3a-c2619dea784mr11829266b.49.1788497704848; Thu, 03 Sep 2026
 21:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902124026.1774575-1-max.kellermann@ionos.com>
In-Reply-To: <20260902124026.1774575-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 3 Sep 2026 21:54:52 -0700
X-Gm-Features: AcwNN1Wcef3TNpkEAvZQAufHH-QxmpZ_DOkYs40Luxtpq4ZLldX8bx-Y7NPejkM
Message-ID: <CAOJNxRJ9rUZ4JRwcqEtOPu97D3NNsjwV1mniM6LdNytRYiA54w@mail.gmail.com>
Subject: Re: [PATCH] ceph: acquire caps for read_folio requests without an rw context
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Max,

The fix mechanism looks right: a NETFS_READPAGE request issued via
read_mapping_folio() with no rw context should acquire caps, blocking,
before hitting the OSD, so it can't race a writer that hasn't flushed
yet. Two things though:

There is one existing Ceph-internal caller that now lands in the new
blocking branch: ceph_uninline_data() calls
read_mapping_folio(inode->i_mapping, 0, file) from ceph_init_file_info()
(fs/ceph/file.c:262) at open() time, with no rw context. On an
O_WRONLY open of an inline-data file with no recent readers, RD isn't
part of the file's wanted caps (__ceph_caps_file_wanted() derives them
from the used fmode), so __ceph_get_caps(RD) takes the -EUCLEAN path
into ceph_renew_caps(), which raises the wanted set via
__ceph_touch_fmode() and issues a synchronous MDS open request. Such an
open now pays an extra sync MDS round-trip, and open() can newly fail on
MDS errors. This read also doesn't need caps: the OSD object is not
created until the uninline CREATE, and this path intentionally relies
on the -ENOENT -> zero-fill behavior. Could you handle this internal
caller explicitly (e.g. have ceph_uninline_data()'s read bypass the caps
check), rather than making every cap-less READPAGE unconditionally
block?

The blocking acquisition now happens with the folio locked
(read_folio contract), inverting the usual caps-before-folio-lock order
of ceph_read_iter()/ceph_filemap_fault(). I checked the obvious cycles
and didn't find one: a folio that reaches read_folio is clean (dirty =>
uptodate => read_folio is never called, and netfs_read_folio() diverts
dirty folios to netfs_read_gaps() before the request is allocated), so
the Fb-revoke flush/writeback never needs to lock it, and the truncate
path uses folio_trylock. But please document that invariant in a
comment, since it's what makes waiting for caps under the folio lock
safe.

Minor: the new branch hardcodes want = CEPH_CAP_FILE_CACHE, while the
other read paths add CEPH_CAP_FILE_LAZYIO for lazyio files
(ceph_filemap_fault(), ceph_splice_read()); it may also be worth
aligning.

It might also help stable reviewers if the commit message notes that
current mainline erofs fileio reads via vfs_iocb_iter_read() ->
ceph_read_iter(), so the trigger is gone there and the patch mainly
matters for stable kernels and future direct read_mapping_folio()
callers.

Thanks!
- Xiubo

On Wed, 2 Sept 2026 at 05:40, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> This fixes a data corruption problem that leaked permanently into
> fscache.  File-backed erofs images are read using
> read_mapping_folio(), and the Ceph implementation of this call forgets
> to acquire Ceph caps.  Therefore, mounting an erofs image file from a
> Ceph mount that was just written (but not yet committed to the OSD)
> would fail because the erofs code saw only zero-filled pages.  These
> zero-filled backes were then copied to the fscache, making this data
> corruption permanent (on this host).
>
> Usually, Ceph checks/acquires caps at its own entry points and not in
> the `address_space_operations`: ceph_read_iter() and
> ceph_filemap_fault() acquire Fr/Fc before calling filemap_read() or
> filemap_fault(), and ceph_write_iter() holds Fw/Fb around write_begin.
>
> Only readahead, which the VM can invoke without a Ceph entry point
> above it, checks caps itself.  That check was added by commit
> 2b1ac852eb67 ("ceph: try getting buffer capability for readahead/fadvise")
> in 2016 to the readpages path, converted to the rw
> context list by commit 5d988308283e ("ceph: track read contexts in
> ceph_file_info"), and moved into ceph_init_request() for
> `origin==NETFS_READAHEAD` by commit a5c9dc445139 ("ceph: Make
> ceph_init_request() check caps on readahead").
>
> The single-folio read path never had such a check, neither in the old
> ceph_readpage() nor in netfs_read_folio() via ceph_init_request().  It
> assumes that the `read_folio` method is only ever reached from
> filemap_read() or filemap_fault(), both of which Ceph wraps.
>
> However, since Linux 6.12, erofs file-backed mounts
> (commit ce63cb62d794 ("erofs: support unencoded inodes for fileio"))
> read all metadata (including the superblock) by calling
> read_mapping_folio() directly on the backing file's mapping.  On Ceph,
> this issues an OSD read without holding any caps.
>
> The result is silent data corruption.  Ceph clients do not write back
> dirty pages on close(); a writer keeps Fb and its dirty data until the
> MDS revokes the cap.  When another client opens the file, the MDS
> initiates that revoke and replies to the open immediately.  A read()
> would now block in ceph_get_caps() until the writer has flushed and
> acked the cap-revoke, but the erofs superblock read goes to the OSD
> without acquiring caps and thus races with the writeback.  If the
> object does not exist yet, the OSD returns -ENOENT, which
> finish_netfs_read() treats as "success, no data", and netfs zero-fills
> the folio.  The folio is marked uptodate and, because it counts as
> downloaded from the server, is also copied into fscache.  This never
> recovers because Ceph invalidates the page cache and fscache only when
> Fc is revoked, but gaining Fc later will not invalidate it.
>
> My patch fixes this in ceph_init_request() by reusing the existing
> `NETFS_READAHEAD` code for `NETFS_READPAGE`, but uses
> __ceph_get_caps() instead of ceph_try_get_caps() to make it blocking
> (something which would be undesirable for readahead).
>
> Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/addr.c | 69 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 45 insertions(+), 24 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 657c2cb0f881..580b45a68a75 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -468,6 +468,7 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
>         struct inode *inode = rreq->inode;
>         struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
>         struct ceph_client *cl = ceph_inode_to_client(inode);
> +       struct ceph_file_info *fi = file ? file->private_data : NULL;
>         int got = 0, want = CEPH_CAP_FILE_CACHE;
>         struct ceph_netfs_request_data *priv;
>         int ret = 0;
> @@ -475,45 +476,65 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
>         /* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
>         __set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
>
> -       if (rreq->origin != NETFS_READAHEAD)
> +       if (rreq->origin != NETFS_READAHEAD && rreq->origin != NETFS_READPAGE)
>                 return 0;
>
>         priv = kzalloc_obj(*priv, GFP_NOFS);
>         if (!priv)
>                 return -ENOMEM;
>
> -       if (file) {
> -               struct ceph_rw_context *rw_ctx;
> -               struct ceph_file_info *fi = file->private_data;
> -
> +       if (fi) {
>                 priv->file_ra_pages = file->f_ra.ra_pages;
>                 priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
>
> -               rw_ctx = ceph_find_rw_context(fi);
> -               if (rw_ctx) {
> +               /*
> +                * ceph_read_iter() and ceph_filemap_fault() hold caps and
> +                * register an rw context before entering the page cache.
> +                */
> +               if (ceph_find_rw_context(fi)) {
>                         rreq->netfs_priv = priv;
>                         return 0;
>                 }
>         }
>
> -       /*
> -        * readahead callers do not necessarily hold Fcb caps
> -        * (e.g. fadvise, madvise).
> -        */
> -       ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
> -       if (ret < 0) {
> -               doutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
> -               goto out;
> -       }
> +       if (rreq->origin == NETFS_READAHEAD) {
> +               /*
> +                * readahead callers do not necessarily hold Fcb caps
> +                * (e.g. fadvise, madvise).  Readahead is optional, so do
> +                * not block; without caps the VM falls back to read_folio.
> +                */
> +               ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true,
> +                                       &got);
> +               if (ret < 0) {
> +                       doutc(cl, "%llx.%llx, error getting cap\n",
> +                             ceph_vinop(inode));
> +                       goto out;
> +               }
>
> -       if (!(got & want)) {
> -               doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
> -               ret = -EACCES;
> -               goto out;
> -       }
> -       if (ret == 0) {
> -               ret = -EACCES;
> -               goto out;
> +               if (!(got & want)) {
> +                       doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
> +                       ret = -EACCES;
> +                       goto out;
> +               }
> +               if (ret == 0) {
> +                       ret = -EACCES;
> +                       goto out;
> +               }
> +       } else {
> +               /*
> +                * Make sure we have caps, just in case read_folio was
> +                * called directly (e.g. by erofs) which may have
> +                * bypassed the usual Ceph cap checks.  This branch
> +                * uses __ceph_get_caps() which blocks until the
> +                * required cap has been granted.
> +                */
> +               ret = __ceph_get_caps(inode, fi, CEPH_CAP_FILE_RD, want, -1,
> +                                     &got);
> +               if (ret < 0) {
> +                       doutc(cl, "%llx.%llx, error getting cap\n",
> +                             ceph_vinop(inode));
> +                       goto out;
> +               }
>         }
>
>         priv->caps = got;
> --
> 2.47.3
>
