Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEE43F4B4
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449014; cv=pass; b=AxEbgwD0eFpdaxiDf//8VZPvzpD8CdHbGTQXFUvPoWxy9YJ0/dlV0KaY83Vzv5zveDVJ7/+XfrDEpvnTKI0iW/E9eJTH1SZbeuMNkdUSqHsBiWgY6tcUGMes1wS11lvpssJZSu/Zzetx/s/0hYDbNDvw7AtUavnubBcme/KyfII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449014; c=relaxed/simple;
	bh=IV4YvDnORgucohflDz2P9wKiqO3GLGxNd9nPS0YBa2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGN/kUw7XZTCdqyNDSwbDxTChDqrRN/ftzhNFDRw/E8rgmNhTzC21Xn1fjl6fCzcQxNn97Mna7fLwRrHpoSbvyRDaMsc6UZ5fwtfMTXLUcHHbV7yyUgvnmSgQ0O54IyVWa/SBYZ3mfs+wi3zYL2WcF3LMy8upVDJn+p4oFYJfpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=eZdmruVX; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="eZdmruVX"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c999f162c9aso2973013a12.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 11:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783449011; cv=none;
        d=google.com; s=arc-20260327;
        b=pCbeeJyB/uG/7ETnmqZs+cp/c6ZRDjpJ4G7HpRr0yFQ/WvFJ2pXy2Z+V+u3R7Fd63N
         /newyr53S/sAyaMYXkd244YyapJopufD0Kld5PVhtD3w9xItLutXYzSbkEvrL+26VuNm
         PDRkJX/12xau4GuUUXQ+Rmgzqtk+kjmZHyWFWLifHaRFeBWRidzk6Te2nEfY0i6SxBae
         i89DI6nZsHgdG2o1bKYBf3Tq2OQG2XOYtnGW5SgV10Rfioe7A1BK/Y4/BNlHW9Xu+De4
         G5gVJr5ANPaaQv/p4IdU2cbV5lsUL+bC6lvf3ri/bzshYrWApLp6Y15uYR/cMsrf/lA1
         di8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLe42YRHnqPt+HLWXCR0C8s0diu19eHjE2bEKTQVrVM=;
        fh=UPE+JFDmrFxoyjVcVgAMihITJYW1RtW8kUxyJQe3Kpk=;
        b=aoUuOVkTKRubtwILpI7Jd/pZShVV8If3kCnZId/mX1JmpMtHcI1eRp9ZWNcXet4x9E
         pXmugwkBNmHOkx3tJUBea98+Q5CSH3cw38auNzGc0dxfHSAgFMadV0rOf/K/DxmytIAb
         SQiQbxT+V93TsutuamZ++kcF0d+AkFMcXEVxQVqSs+7FNZ7oWPdhQDA3/mlU0xB6F7ST
         i4n7LLboAFOYQn6MsyPjiklJolLFOQnf3gK3iZB9U+E6e0pE4l8xWnS279bULuuVsyIJ
         Hg5LcePeCn9a0HDJikFgVqnL/PqU4/ghMeo13/VZM8VmD7SJAXydX2jk/0kb6WuF5Fm1
         M8aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783449011; x=1784053811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLe42YRHnqPt+HLWXCR0C8s0diu19eHjE2bEKTQVrVM=;
        b=eZdmruVXNLcVOojVs8jTSZe1U/GvUkzN0BOEA23DCgPjt03M/smTgVtzQclOKs71Vp
         6df5hATdlceMe3r6YlBRcQIUNmN7nv3W7/SAcIb4/iUCZmH0ZKGJp9cGyPiGDkKIPxb0
         aZOB/k49x2Upf0pwzq/47VtU9+YckNRqBh7yo6osWyIXnYT687oif4UpjRyA+LfmHZQn
         wwWjPaXZzP338tNtCcToJnd1EbfUDAXQkHXUYOm4G1qpCq9m6LmGZngdtSae7ukXUsh1
         iidV9P3gr77jCy/7Fj/lrZLyCYQZ2VXZoPTFSXlKVq7Ulz6svxVkHH/YFwEETNg5XxyV
         6VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449011; x=1784053811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLe42YRHnqPt+HLWXCR0C8s0diu19eHjE2bEKTQVrVM=;
        b=MUCQ3l2DXezmfXUTaq97ME/6CZcg1eR0kbmFJGdvF8+wg5HwS3QOmlT1J3qJfOfRG5
         KYigzgdAtilrg3xSQdYyOf7VFluk+4PxaYEL/PBagWR7SAw6KcvtESxo9wnYEofK/qmq
         gTOq7NCwlvTjoqVhxdhun3uiiMg10EoB3CZieCnuYWwU9ce0vsA7ljm3SGkWwvHFXQcc
         SfnZNDeAIlmnh2wu9Eoxo+FNKRqk13G1++QnJLqTKujqGRx9Wjv5NWG21jc4gky2SESN
         w95po2dDaNnwwfOfjW0vaU3hmOQbsvpLFqlpv3HXlekKTVkMY+dssZAoUwxthNuRGZlk
         APDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNi4rJdfhIkFEwaTAhR4Y3Ll+dxY6JFCt4A2bsjKUpj5xmJlLPiKiA/Wurc/di/SxF2Ro8r24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGOfUywJS7JX/fUHaw716ZWfEFkLMUoKbgdMH4Xb7DEdKX2s4
	gOtk8IOksdhy50FbDj3ceYrZpwvKqECpCm4SL8LPwwMzKV2vLaH9Quov4neARHM/VWYx+3eeNOA
	8EafIYGsXG2gvsz1gJDPb9oJw0QIvkdyloVfoekDj
X-Gm-Gg: AfdE7cm4lx5iC0LoM7qlY6pYzWxKl2/37jDjfVNl+R7NvVQBwWP9QIHZx0DwehikPgd
	mapImyzDF4WfqkgZlokY0z45i3vGhMMwxOMGCDK1g93+v5IML0Bj3jcsrOoJQRTKyBkV7BfY2mL
	oRk91onJClNXrHstwD52232zWUE03DNWcOI1Nx07kc8qUgILSeSc+un/NpdXhkwAoGEDndeAqS2
	+A7nDi5LT/OLq2gey+z51OD3DcmD8duzZZAR84XqBncXU+fJ5KxsXgl6JXTt/7TmLHMpaDvmeiA
	AeoLpwnTl3iSG3s0YJ22KHu/UJ12
X-Received: by 2002:a05:6a20:9188:b0:3bf:96c6:78a9 with SMTP id
 adf61e73a8af0-3c08ed40638mr6618578637.2.1783449011139; Tue, 07 Jul 2026
 11:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706191309.2887515-1-xmei5@asu.edu> <CAJnrk1Z-6ezCKAEicOEoFVJfhg6Es6R+E=iH4HepmwrpBiETdw@mail.gmail.com>
 <20260707054031.GF9381@frogsfrogsfrogs>
In-Reply-To: <20260707054031.GF9381@frogsfrogsfrogs>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 11:29:59 -0700
X-Gm-Features: AVVi8Cce3G8c1iDY0MJ78zs7gij-Nt-NXYatlMimVr57IRJUm9QAYer-o6WM9oY
Message-ID: <CAPpSM+T4D+Ym=JwA-zqx5RvRzktN2--WJnOrt=3xcuTRoyW09A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: copy request headers via a stack buffer for io-uring
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:40=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jul 06, 2026 at 02:17:12PM -0700, Joanne Koong wrote:
> > On Mon, Jul 6, 2026 at 12:13=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote=
:
> > >
> > > The fuse-io-uring transport copies req->in.h out to the ring in
> > > fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> > > Both headers live inside the fuse_request slab object, whose cache
> > > (fuse_req_cachep) is created without a usercopy whitelist, so copying
> > > them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> > > panics:
> > >
> > >   usercopy: Kernel memory exposure attempt detected from SLUB object
> > >   'fuse_request' (offset 56, size 40)!
> > >   kernel BUG at mm/usercopy.c:102!
> > >   RIP: 0010:usercopy_abort+0x6c/0x80
> > >   Call Trace:
> > >    __check_heap_object
> > >    __check_object_size
> > >    copy_header_to_ring          fs/fuse/dev_uring.c:618
> > >    fuse_uring_prepare_send
> > >    fuse_uring_send_in_task
> > >    ...
> > >    __do_sys_io_uring_enter
> > >    entry_SYSCALL_64_after_hwframe
> > >
> > > Bounce both headers through an on-stack copy so the usercopy touches
> > > stack memory, not the slab object.
> > >
> > > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support=
")
> > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > Assisted-by: Claude:claude-opus-4-8
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> >
> > I think the cc stable@vger.kernel.org tag is missing here. I added
> > stable@ to the cc list on this email, but I'm not sure if they require
> > the tag being explicitly in the commit message to get it backported.
>
> I used to like it for XFS once upon a time when we did manual reviews
> and QA of LTS branches, because it was a headsup for something that I
> should actually watch to make sure it actually showed up in stable-rc.
>
> --D

Hi Joanne, Darrick,

Thanks for the review!

From what I've observed, the "Fixes:" tag alone is often enough to get
a patch backported, though I'm not certain that's guaranteed.  Adding
the explicit "Cc: stable@vger.kernel.org" tag makes it reliable either
way; feel free to let me know if we need a v2.

Xiang
