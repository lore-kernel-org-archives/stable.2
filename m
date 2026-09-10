Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9137E5E0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007388; cv=pass; b=kELp5uUpkQrKJEcJJnapszstGmu3WChd0AKoOM0m4KT3FYnVt++fZF6+9s2aqX94sXHIB3cKiRY+WH7mOxqRDzPIxMky5qsfsxrbwZ+LZ/GmFUpQI0Xp+H3r/QTAnualaIfLLgnA/SbjCxrNDSdtG6MIW8kEO1BEy+AuTGiEMZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007388; c=relaxed/simple;
	bh=3Q+8nuxGqPVQSZj1oFD9maUUSRsIHN/XrLNvu+6zoS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2db1IDYFce5oxJkp/4Pyz2MsurlMIFlpGto2tTquRV7V+bJkg1PQC1sS+RSU9qoPrtBYmdlHF8Tpq01XVfsTXbkDhgc9dxBTlr7JXVtd+EumbLgjfDuIchVtvEMUg+cH7H5Egi5Bckm+zXTWizgnNygc4MQOrxp5V3pMU5BAZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=N8G3TnFS; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="N8G3TnFS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so50805235ad.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 19:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789007386; cv=none;
        d=google.com; s=arc-20260327;
        b=k1Fr7CJBCQXLKlb1EvaZP/MIU1AJmzH7xPlMH1I3vidWeGxenV8BACcz3djP9CPdgS
         5s+lEm3V1UvrngAIWcTZG0gqXd7kXEWSH/hkHzIBow1SfYPZFzCtCe7vnUu2dx1pWKgy
         6uX2HFq5HFdJtEpQjnsgbzlbE+dkFHt6uMRYUH1dIwiw9SaKaCkSDYnHHNraa7KzkhDh
         oP5iUUj/4W6UN1bhr+MRH3QzrCWQOTXX0rzt5rhMf6vSFc8H0dQVyEzwBfHpboHd6Ty5
         DQ4KMnEjRx/6ufd1tdkW0fSm42jSTQXKR6czfhBwaX+0F8XIb33KGhML+89bAvwcdD03
         zv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wv1FNI/9qgEGS0u+wWB98TjriXkQzGjxeqk0TCTlFWg=;
        fh=VmGgzHjuq367KanYofovXA/r5MhtfI9mfye7ykTgxOc=;
        b=gsBmuMMPMcTEVE8xV6RZcsguLVtlTharnOwwdSgnM6OjXrstMIUC8+8QFV4MmrSSB6
         qMXuVHDCRSoOQINUwNB6hBaAiNwz9D+p279QgKmssyZcZRTsC7G1SaRDFP+3NcnHYWIu
         e52YJTFm2GhfrmbP8iZ0v9qQRDQ5GCh+U9tnTdLU9x69kV8cqmSmzZccom6vOOAMv4as
         2v8fEnur+bWXenalLruyyqU+qqyp3Qs6L/4mXvXfnL+65D8Ejc1WvvNkBeyIZcjaNOLd
         JXgnnyf77L3Nz4PT6JgOg9zqTzX/kfoAwTmH3S8CMspj++HRoBoKPnqbbIqbB6EFAiQF
         aQ9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789007386; x=1789612186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wv1FNI/9qgEGS0u+wWB98TjriXkQzGjxeqk0TCTlFWg=;
        b=N8G3TnFSfqRe3SDx4heoYk6nTHK9ODbyjQJ4y1ad+tHommsUumyg5qBc9JAn5SURQK
         XNcU4AcM9omKcX/lRYjlZWb+STfKNXPnOX9/NUDPyK8FFIb+Cv8N/TKb9TxfUC+AF7Vk
         HxwO+Nj2nWUUKzC9KTdRfsQvlDI78Hz4rKZxR0AIMdDNrwBHSRG1X5rknMOQJ8TfobLs
         3CYo+NnYZe/NWErtxf8xwHvlBXz3nQdsX4PlNclEfajfR3u7fzaBfQh5c0yiyBo5mi1q
         eHYxe0wYYZ7t/RFiJuu5XkDnm8J4LrV+E9LxNL9PNoXdNx/qh7slW9ANWsXY6kiCiBx0
         JKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789007386; x=1789612186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wv1FNI/9qgEGS0u+wWB98TjriXkQzGjxeqk0TCTlFWg=;
        b=LTAqoOB1eMnq8w65Td0gJ5eF4fstc64+2SFTOmS5IZi1tJrhJBaTtpEKV0G8E63Sfo
         Q1bRYNjcDCUxITx4ncnjN19V/TMoqU9dCjgoE/Mqklt0W0fx/ansipfsjBDNyRH1ZZ5z
         mfO/LXpvDThLSkUj+xDEZB2YS93ZEF9tHHpIoKwckDu8TgCVpDhPWkbnEhZuxL8CUcB4
         z/IhyLjmaOTda/VksHkRTnj3EvYvqxwba8BBIGFEQ5g/bqaCdoZ8RbXVknOdWrKbiAVC
         8ujmV4aD3DDZDOTnarNPEQhxD8vW72PSjBJBmKxiR12ZkfKmpRTTXhEk3LwDECqzDFtE
         SLLA==
X-Forwarded-Encrypted: i=1; AKwUvByg83Z4Qwncv2k7ZcXQOFL7arEqXmi1ypRlO+aV2RYqY4B1Um7hjmQHSUWuZZ+FHXEC/LLIOXk=@vger.kernel.org
X-Gm-Message-State: AFuF++mKulNkzHm/L4tJm+DaX0AJrT0awgMrQsV2MVMNaqlIYJer6WGa
	lsyFj0pBqRAe6PX4NrpI79/4GIS5F5lfV37wYYDPrKREXCxUYmtrXwlABXZ0hBPQdzb74S/UkTH
	XU6yj4p2I9m19IHvDpUIJVm90VwwPOLMQ+ix/x52s
X-Gm-Gg: AYBFou3xZwYqfukjZN3lPIugGnoppEFWPT2lvurPh5VqPyLBjdkto/4ktXWdxQ+96um
	QdH43EOES2bOUKzdZmmsEdFjtRsUqES7/v2XcoJq7PpnyYi8Q5//2OKxX8Hamjg9Pdf0jWpJ3cw
	g+0kqlf5yrtargbAscI3b772+wN/LcZs/hSF/OD6ddlXGmtNBHP7s7e/VKu/Bji+eDo25qgyC7u
	tEdSGDcRpe+U5YxXNE7Mq9icYPp5m3G25UoGdXJX1C3qOxT74Es874u0ElELsU9WlMiOkbpVmW+
	B83iuzuPeIJPXwkApSp9N8DYwcEf9L/v3/QoABwyevOtbWIJOMBAg3Wd0L8220keRjRgzjYeUul
	D1o3BH5v2OcwSLEWr+hfe
X-Received: by 2002:a17:903:19d0:b0:2d9:2688:8be6 with SMTP id
 d9443c01a7336-2db126346b3mr512034685ad.19.1789007385629; Wed, 09 Sep 2026
 19:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906012924.1928316-1-xmei5@asu.edu> <CAJnrk1aXL9QuW+USSbx2La9qgNYU8jybqqpoSSRo6wEAAZqxAw@mail.gmail.com>
In-Reply-To: <CAJnrk1aXL9QuW+USSbx2La9qgNYU8jybqqpoSSRo6wEAAZqxAw@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 9 Sep 2026 19:29:33 -0700
X-Gm-Features: AcwNN1U6zE_X4bJd6QR0EAJdGCnUmeNIAvwSwRgyIUMzXD9aLMi9DOMScOAVzOo
Message-ID: <CAPpSM+TySLViMxRPcN2zjXhcdTouwuYYYiQzqqLQEC-W4YZnjw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: bound io-uring payload copies to the
 registered buffer size
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:20=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sat, Sep 5, 2026 at 6:29=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > The fuse-io-uring copy paths do not check that the data they copy fits
> > in the ring entry's payload buffer.  fuse_uring_copy_from_ring() passes
> > the server-supplied payload_sz straight to fuse_copy_out_args(), and
> > fuse_uring_args_to_ring() copies the request in-args without comparing
> > them against the buffer.  Either can exhaust the imported iterator and
> > hit fuse_copy_fill()'s BUG_ON(!err).
> >
> > An unprivileged user can trigger the request side by mounting a FUSE
> > filesystem that registers small payload buffers and then issuing a
> > setxattr() whose value exceeds them:
> >
> >   kernel BUG at fs/fuse/dev.c:1064!
> >   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >   CPU: 1 UID: 0 PID: 148 Comm: exploit Not tainted 7.3.0-rc1 #2
> >   RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1033)
> >   Call Trace:
> >    <TASK>
> >    fuse_copy_args (fs/fuse/dev.c:1354 fs/fuse/dev.c:1380)
> >    fuse_uring_args_to_ring (fs/fuse/dev_uring.c:891)
> >    fuse_uring_prepare_send (fs/fuse/dev_uring.c:940 fs/fuse/dev_uring.c=
:1057)
> >    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1745)
> >    tctx_task_work_run (io_uring/tw.c:96)
> >    tctx_task_work (io_uring/tw.c:133)
> >    task_work_run (kernel/task_work.c:233)
> >    io_run_task_work (io_uring/tw.h:84)
> >    io_cqring_wait (io_uring/wait.c:278)
> >    __do_sys_io_uring_enter (io_uring/io_uring.c:2676)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:61)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >    </TASK>
> >
> > Bound both directions against ent->payload.iov_len, the length the
> > server registered, so an oversized reply is rejected with -EINVAL and a=
n
> > oversized request with -E2BIG/-EIO, matching fuse_dev_do_read().
> >
> > On a zero-copied request the last page-backed argument is handed to the
> > server as registered pages rather than copied into the payload buffer,
> > so exclude it from the request-side sum to avoid rejecting valid
> > zero-copy reads and writes.
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: add: Cc stable and Reviewed-by tags
> > v3: propose the patch fixing another issue found by Bernd by Joanne sug=
gested way
> > v4: no context change as v3; add Reviewed-by: Joanne Koong ...
> > v5: no change
> > v6: rebase on fuse.git#for-next.  The ring entry already keeps the payl=
oad
> >     iovec and imports it at iov_len, so only the two bounds checks are =
left.
> >     Skip the page-backed arg on a zero-copied request, it does not cons=
ume
> >     the payload buffer.
> >
> >  fs/fuse/dev_uring.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index c6dd420c4034..981b7c295e5e 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -775,6 +775,9 @@ static int fuse_uring_copy_from_ring(struct fuse_re=
q *req,
> >         if (err)
> >                 return err;
> >
> > +       if (ring_in_out.payload_sz > ent->payload.iov_len)
> > +               return -EINVAL;
> > +
>
> This logic will break fuse zero-copy reads (ent->payload.iov_len is zero)=
.
>

You're right. This check wrongly rejects every zero-copy read reply.

> imo I think the cleanest fix for this bug in general would be to just
> remove the BUG_ON in fuse_copy_fill() and return back the error, eg
>
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>               err =3D iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, =
&off);
>               if (err < 0)
>                       return err;
> -             BUG_ON(!err);
> +             if (!err)
> +                     return -EIO;
>               cs->len =3D err;
>

Agreed, and it's a much better fix than bounding the copies.

> This would cover both the request and reply side and get rid of the
> special logic here and below. It'd also make backporting to stable a
> lot easier. I think it would still be worth having the FUSE_SETXATTR
> errno fix (eg returning -E2BIG instead of -EIO)
>
>     if (fuse_len_args(num_args, (struct fuse_arg *)in_args) >
>           ent->payload.iov_len)
>               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
>
> as its own patch, where that check is only about picking the right
> errno, not about preventing the BUG.
>
> WDYT?
>
Thanks for your suggestions; this patch is better, and I have sent and
tested v7:

https://lore.kernel.org/fuse-devel/20260910022442.3594649-1-xmei5@asu.edu/T=
/#t

Xiang

> Thanks,
> Joanne
>
> >         err =3D setup_fuse_copy_state(&cs, req, ent, ITER_SOURCE, &iter=
,
> >                                     issue_flags);
> >         if (err)
> > @@ -854,6 +857,7 @@ static int fuse_uring_args_to_ring(struct fuse_req =
*req,
> >         int num_args =3D args->in_numargs;
> >         int err;
> >         struct iov_iter iter;
> > +       size_t copy_size;
> >         struct fuse_uring_ent_in_out ent_in_out =3D {
> >                 .flags =3D 0,
> >                 .commit_id =3D req->in.h.unique,
> > @@ -887,6 +891,16 @@ static int fuse_uring_args_to_ring(struct fuse_req=
 *req,
> >                 num_args--;
> >         }
> >
> > +       copy_size =3D fuse_len_args(num_args, (struct fuse_arg *)in_arg=
s);
> > +       /* a zero-copied page arg does not consume the payload buffer *=
/
> > +       if (cs.skip_folio_copy && args->in_pages && num_args)
> > +               copy_size -=3D in_args[num_args - 1].size;
> > +
> > +       if (copy_size > ent->payload.iov_len) {
> > +               fuse_copy_finish(&cs);
> > +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EI=
O;
> > +       }
> > +
> >         /* copy the payload */
> >         err =3D fuse_copy_args(&cs, num_args, args->in_pages,
> >                              (struct fuse_arg *)in_args, 0);
> > --
> > 2.43.0
> >
