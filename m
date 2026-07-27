Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF53F9284
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195559; cv=pass; b=fnktK/3zAEsf5qYupS93x/n/tPZP9uUM0D48O23LqBtZZW9HWFk5iihelfHvdMypmLLgvOZcWQkiWYo1zh64RNhWaZdSaTSKsKy/GH7k2/of0T3At2G2csQrxHRHy3lEwlCge9/bY/AHhcLSy3mWgkapuP9/jnyUpFTLqsmdCmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195559; c=relaxed/simple;
	bh=V5YWr3MKVMqaHPNkDI2H2wxmRrxgahysyRn4PvMMfLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm1z8blXdxWyutqZcdDcrLRWWwk6vYjpHglQJJO3lIrlW2j+ZbVU/vbQwudAe+tGWGV30Kd5RhrPVa56dK7thBHBmQ6Mh3gTLWnxzcgC5YFUrqdDS6LCGBs42QI7d8WnxSYaNN5ePyTxUgFfrvZ6IwayX2cYnqX9rU1NZk9aYJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W39Ie9dW; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="W39Ie9dW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso36474155ad.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785195556; cv=none;
        d=google.com; s=arc-20260327;
        b=PFvT4TgR9fz9gQSZqy9jf6kv1pcwlhy0yxeQmE9EuN4nEUMEpCFo+5cv6gcgM0rb1V
         Kq0O8uW58Z9RGRPy9SCH4VC72nMMt1VSt9AV0tmfCfDszkSaeYBVrI39/7sTXJD2n3uI
         0fqfK8GHwfXvoBZ6cYjTVEuAYYGF5dvYtDHYO8Ui0FIx9az4Ufn45z32AGaNnmt9rjZe
         lBo8a1Lx9ka1rlGNXbTzHK0fLvBHrMnh8AgNZiXqVHVppcSJJGtjrcdSPDMDAcR4caS4
         4bgZnXRVatJbEWGCruZ/h8yVCgS/4aNNyEFu9SsnIXGPR8IuizQCH6NOR/O0Mi5tj96b
         y7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RqFceQZgdQjZo7xGdNfi40Q0nXWHUMZpsmINYgmFEmQ=;
        fh=+gto0O+A1Foew51XiBtOUXfbLIX3dDf8UVs7y6Fv2wc=;
        b=jbawNrNImcQHnW8EktHfTYBpTNKypsxW6M0YnDd513n4uvWJ8IfKhzfdI+D/NDmFMk
         mGIObp69g5xJaoWsSp9nfkJ/Neoi3z0XBgEBmBQwV6hvlMfnOLuCzgbsIpYY5OaMZlg7
         xfvKhRpzWm8XLG27mpTveydWr+/EpL2bxqkpq8J2IDRi7TjdlkLXXqFpX6bQUxyhhus6
         6Hy/DvyAZsCAdX1fkrS5J+MgJOphVBiKLzuMbJNpeD9eOkcf6Em9egpZVKPMKSL5u0i2
         mctnzJvXbh0aU7/5LPbtmVI7gemX5rGY5P8Aw99QmE/rtPKpjBFnRwW+sL5hpqv7G4PM
         d1ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785195556; x=1785800356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RqFceQZgdQjZo7xGdNfi40Q0nXWHUMZpsmINYgmFEmQ=;
        b=W39Ie9dWiAkbrkSmuAVJI2+Y87fg39oHty7kwaLyoPkFBt8n7Ll0QACCSbMfHq518k
         OCQEofo+le5P2mIPD2abk4v4E5gDcRV5P+hjqBMCRwxi4TbyKxtmnudXkw3eKUD5OdfN
         n9v7sZv//bALCYzCCD6HWirP1WyLjeuqErMj2EGgCe7pVEJKZUaAih9hkcWenxUdTBO+
         +jLZJBoxXJiVpaJOlyIBCt82k3HwxSqtWhbL383xiLXsgqogc/IylOlWjUv5gwYORg7L
         MNbDggi/My2wFjTDjNmxpJJO3Ck44gJpjd15ZkYuM2QzYWvHmjCpUP5Twz7MPjjzckCt
         R6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195556; x=1785800356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqFceQZgdQjZo7xGdNfi40Q0nXWHUMZpsmINYgmFEmQ=;
        b=N3pf2ASVUzH4/p06MOvFCaECf3a6dKEhKn1lP3Wm+JBzQ9aP2uOdpJvLWl5qEO9bD4
         R50i5cfN2q1j6tc4VjmYG+4pgoY/d8w4lItyqnmfnDxl6AfNWwGtwjY6HxOpE38q0WVc
         NTHJ9M85v55aP5hu23dvcJZxDAn2PcIHUxoskjobtyUH9jR9xcmtulWR1dY/GpXN0+uB
         upW9un7v2cJ6VUAguasjSj6PfKnqyyqkgtLxx0jZHAeS1uhwTEZr39cpiubuP6Lgiybk
         teXt4U0mzncNPgb/N5RQRP5Eke8nKeB0xBKMzuW1rp2n/G90tC88pBrTARIQ7FhyIjve
         tADQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBu41VW/9h7G/sfLxMyqNRcDbXb5kTM8XS7Wo4mLIMJgr4744oTkI6r8HA82kGK9pZ9+wOkag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzijk0AbGLtW5wBNXv+2hTzGx1fO2nX+erbdITMnwrTTeHWSKGj
	t3dG1+CfTCnfdO1S7JzxAY72ZMd4LIUS8k+u1vR7+xCQfiMQ2Ly7J0XyjQSCF4RFpdKlJYmzw57
	bJUwYvewwI6cWUuTR19wchs7SM/vxBQTQXgZMcZLE
X-Gm-Gg: AR+sD13mxzJZ14XmB0mh5HO2jwK00OMIuj796Gwghz7cRY6O7yai4A32xd4KScZNAG7
	Qn/td/l4XIuStdzhCqUElKTq8/RfEzBGYsP5X2atUj3cDFbhNUu876cDFmCkTa/txhNaCCOGCHI
	4CaYM071ENempxBxuDGgi9qtZpolxuMPoewaY4SlxamfPUlNnJMLEM3MhLmlMZpFLE5LYOQC76K
	dLUARPhe1Q8HEaAofilgKyyKaVvhUPSGib9V68ziLPFldRVQ7T1nWk85uO78BGOZT3R9dle+Rvv
	AFhmjGbhA7By00TtUhjn
X-Received: by 2002:a17:902:b701:b0:2cf:8131:75f3 with SMTP id
 d9443c01a7336-2d015a8940bmr115955ad.7.1785195556400; Mon, 27 Jul 2026
 16:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714235408.1666063-1-xmei5@asu.edu> <CAJnrk1b4VAsyEMx7obFTBgP8M3dBcD1+QnKVQK-r881MBySDOg@mail.gmail.com>
 <c48c4541-c62a-45cc-aa3d-1c78a48d0676@bsbernd.com>
In-Reply-To: <c48c4541-c62a-45cc-aa3d-1c78a48d0676@bsbernd.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 27 Jul 2026 16:39:05 -0700
X-Gm-Features: AUfX_mw5Vb7r-H4GegBkxIrI4-ULi3jkJQ4MMMUyOB-n1gwlaWOaUgAxYZC8Qr8
Message-ID: <CAPpSM+RbHh6toxSR00HCA_+R5Cj+yBwVXDw0ruiMbrVhnMX-6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fuse: whitelist the request headers for usercopy
To: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: Baokun Li <libaokun@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 2:59=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 7/15/26 20:13, Joanne Koong wrote:
> > On Tue, Jul 14, 2026 at 4:54=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote=
:
> >>
> >> The fuse-io-uring transport copies req->in.h out to the ring in
> >> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> >> Both headers live inside the fuse_request slab object, whose cache
> >> (fuse_req_cachep) is created without a usercopy whitelist, so copying
> >> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> >> panics:
> >>
> >>   usercopy: Kernel memory exposure attempt detected from SLUB object
> >>   'fuse_request' (offset 56, size 40)!
> >>   kernel BUG at mm/usercopy.c:102!
> >>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >>   RIP: 0010:usercopy_abort (mm/usercopy.c:90)
> >>   Call Trace:
> >>    __check_heap_object (mm/slub.c:8268)
> >>    __check_object_size (mm/usercopy.c:197 mm/usercopy.c:258 mm/usercop=
y.c:223)
> >>    copy_header_to_ring (fs/fuse/dev_uring.c:618)
> >>    fuse_uring_prepare_send (fs/fuse/dev_uring.c:776 fs/fuse/dev_uring.=
c:785)
> >>    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1306)
> >>    tctx_task_work_run (io_uring/tw.c:96)
> >>    task_work_run (kernel/task_work.c:233)
> >>    io_run_task_work (io_uring/tw.h:84)
> >>    io_cqring_wait (io_uring/wait.c:278)
> >>    __do_sys_io_uring_enter (io_uring/io_uring.c:2685)
> >>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >>
> >> in.h and out.h are adjacent in struct fuse_req, so a single usercopy
> >> region starting at in.h covers both and nothing else.  Create the cach=
e
> >> with that region whitelisted.
> >>
> >> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support"=
)
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >> Suggested-by: Baokun Li <libaokun@linux.alibaba.com>
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >> ---
> >> v3: no context change; add Bernd's Reviewed-by
> >> v4: drop previous tags; use kmem_cache_args to reserve usercopy area
> >>
> >>  fs/fuse/dev.c        | 9 +++++++--
> >>  fs/fuse/fuse_dev_i.h | 5 +++++
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index 5763a7cd3b37..b8e43e374b35 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -2404,10 +2404,15 @@ static struct miscdevice fuse_miscdevice =3D {
> >>
> >>  int __init fuse_dev_init(void)
> >>  {
> >> +       struct kmem_cache_args args =3D {
> >> +               .useroffset =3D offsetof(struct fuse_req, in.h),
> >> +               .usersize =3D sizeof_field(struct fuse_req, in.h) +
> >> +                           sizeof_field(struct fuse_req, out.h),
> >> +       };
> >>         int err =3D -ENOMEM;
> >> +
> >>         fuse_req_cachep =3D kmem_cache_create("fuse_request",
> >> -                                           sizeof(struct fuse_req),
> >> -                                           0, 0, NULL);
> >> +                                           sizeof(struct fuse_req), &=
args, 0);
> >>         if (!fuse_req_cachep)
> >>                 goto out;
> >>
> >> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> >> index 668c8391d61c..b511aaab6bfc 100644
> >> --- a/fs/fuse/fuse_dev_i.h
> >> +++ b/fs/fuse/fuse_dev_i.h
> >> @@ -81,6 +81,11 @@ struct fuse_req {
> >>         /** @flags: Request flags, updated with test/set/clear_bit() *=
/
> >>         unsigned long flags;
> >>
> >> +       /*
> >> +        * @in and @out are the usercopy region of this cache (see
> >> +        * fuse_dev_init()); keep them adjacent.
> >> +        */
> >> +
> >>         /** @in: The request input header */
> >>         struct {
> >>                 /** @in.h: The request input header */
> >> --
> >> 2.43.0
> >>
> >
> > I think this is more a matter of preference as they're both
> > functionally correct but imo the previous approach seemed cleaner,
> > given that only the io-uring path needs this. The extra hop goes
> > through a tmp stack variable whose memory is already in the L1 cache
> > and the memcpys are small (~40 bytes), so I think the cost is
> > essentially negligible. Not sure if Bernd or Miklos or Amir have a
> > preference here.
>
> Sorry for late replies, currently on vacation and reviews only when
> everyone else is asleep.
>
> I don't have a strong opinion, I wondered the same if the stack copy was
> avoidable, but then came to the same conclusion as Joanne - negligible
> overhead.
>
>
> Thanks,
> Bernd


Sorry for the late reply. I just got some free time to continue the
patch. Thanks for all of your review and advice. I'll keep the code
simple and just use the stack var to fix it for 1/3 and add Joanne's
suggested comment to 3/3.


The v5 has been sent:

https://lore.kernel.org/fuse-devel/20260727233706.218446-1-xmei5@asu.edu/T/=
#t

Thanks so much!
Xiang


Xiang
