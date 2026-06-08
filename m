Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4E3D3CEE
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937200; cv=pass; b=oh2fqQQEiex9E9Wt1uWQeFNKs8lZXy9slE3T73SQl0t1eDSGR8U9hilhucgfu5KCDPt3jWLdeJbVuq90knWQkJdJ4uIv8BnltjPGVUDrq0jB/wRX3T/H4DRcHKnoIdGfOc5YlLSIbfmAcJnp59bCU5BEg0VIKPmZEObyj7z5tFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937200; c=relaxed/simple;
	bh=Aei7+3M7OS2MalnvLV5efs8dT2ETEaZ+AJbk7E4XM8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdrGucHdayLs8BN1mGmUTx0+Q1bXw/JspmuJ+YBRel//Es+F/84DiJdFlSTWQkuYdqyUKCo3dZCWpRTsc1Jg4/RUdOleYQp2B5kAhvGjVFaBXvThesCTEqWSJgQJZP/dyDXfypfmZP/fchdsk4iPqYhisz77xkHFUaG24nlRgRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERQ2sLPs; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERQ2sLPs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so37118665e9.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 09:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780937191; cv=none;
        d=google.com; s=arc-20240605;
        b=VS2mHgpLGlhQ66D4AAKjE20p5F5QKQMkgUMi2f5wPxbb20eZRFngb8txtCJjTAMH/r
         XVBOwg9DFl16zhdgp70jWY1NG5sbweme7BCiFPtAAdoCJbi2Ex1PuixcTS0HbwJmPmmX
         kanAI/LFrAwpldE7VEWpsL7kJ78T1/2Kr4ZcD7WG6gqWDgyGad7iKk/ypBzpwxr57+QU
         BbnsfJrWaVrNN9jyjgAdtStnCvn2i23VeHdCswdJmyz1UsLjo+tHKl6fI4+maTpggM/z
         I7mRgjz7ve3ohD8FHIKEP4Zv7CZZlqwDfXdNRlYm6Seou7tEts+USkLVvUL917WBwjbo
         gcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+X3fJ+9WnGjPOr2VJBWEjvlIwpcfv/0FYoyWzfs6bb8=;
        fh=Zz6x4jlrijvITBFGSx6Be+jsE94tKonTQSjFD684pQk=;
        b=U2EDfB0pUHPzIIT61uWTOakcaaojjI7pxLsZVFbz8HwmEDPVq1n3MAsBOmKi8nwzcy
         O0L4nJKJA7VWfCd/bg8/SoepDrCrikhrMlL7tM2BLJ6kLdz0ApO7mzvZiOytk8GuDcB1
         AKwXpmV40PrqIQ1G5HqQtLkCli8lZro+xM6UIO/oPuel732iJyygbHNG/2JEOq3Haxbk
         S0UEtth90r/ubTqnUu0sHoqYMSEbBUvuYf8LIV5oBlhMSyDI6vKX+84k7840TFEP0zOS
         8wjGf+OTu5j4LpmLLYHqQu5nO5JZFSGGAut3FC4Xlbow7iG0KS7xys3Z5JiTJirtOAPe
         TvSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937191; x=1781541991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X3fJ+9WnGjPOr2VJBWEjvlIwpcfv/0FYoyWzfs6bb8=;
        b=ERQ2sLPsQe2sxy//k/Xp8SC21Sb6BsmP57VZxw7duC8O490BDJsR8wagxohFlYykD+
         dqQl5OHB/vCmdKGZWKDQ17NwpQlaH13I2AdQW8XB6z5vlv7NZJPFeGNxoIbUALVJ2wKt
         BAeIFjewz1QXKdvg7zqVijltqakgbypBGlD4T/eZeXpHmp4+V9aHQbcfQWBax2l8K8tT
         ZuOJr3MNaI6Hjm6LV4X+/wou9ZLs+riLUt8vB2iYFWi7GWXrxPQ5eEAlVwOmbyDwobhJ
         wiokp0VVZQPWJc/n+17pyRK1Dj/2FnHkgyYkhRDycV+kRyfE8F+8tEfOmkGNChvnFw71
         qxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937191; x=1781541991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+X3fJ+9WnGjPOr2VJBWEjvlIwpcfv/0FYoyWzfs6bb8=;
        b=IzWBRA//lEdjlaTd1kc1JizB/z2a6wC2DGa+gotZN7Mz8F4Ego7rLdzzm5ooOpQyu3
         JmuuEflnaFS+37lA2Qd9YttHO16QUVaAMxVfTKJ9XksciWqlr3DpQSt/b+tKC0ar4Ejj
         bPvAWp0Fsl5PrtxM/aR5iyOlQM3dFcaxxwo90fC71d/ck+N62U5zPEYBmXuzkMoMMaIp
         8whgLnM9FMMlVmCbR0QXwabGnEsxqkN4CsySSPQA/+yVrrTbVAxAmAK3m1df/sXKPaH1
         6NufIfKRru1Epa0v3QnNWmn+ljNc8VsbVe2DHLS0L5tf8/z9IbQXZDMSjQkkeuWmhbk7
         +BaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qGm3ZzBUYxeAC+ggkHO+S5KTKi3WSaFq6aUeoIy45TcoXgPtHa+LTPSMDfiQFREkWnsQPccU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiiVKu/KRGpOvz4/yvkmYvEDZz5KNqw4d7w+jgUUNZ/1/G0jD
	nnYZK6rcuySilZA3+SjHvdFlywEnQaE7jYCY9RagsjiOQILtfa9CvSHPhcsbHAV03ZvQf1z9eMN
	ROdm7K0wLQAclsEWwO8F9V8RZYo94Uag=
X-Gm-Gg: Acq92OG1pwRooWeHdwhyk3D9cgNJKJn+GO8oTlFjL3wjqjcUxNMKZvuCIN44xIVZdR/
	I6txvyxi9RDppFkIz1Bc5d3m3JNkO2IKWgn4iyATknCuKc/rxH/1ibhG+F50/ER+YV3bVxfmdRn
	OoPG3O8a5UNe9ZXRW6Rimq1zzq7yqR0J4+Qp7lLjly71vjd77oqnj+c1JzDyNtJd3SeluSfjH/1
	4j+l84F/HUv8LyIpOzCtH5iolbyQTOB0IOT9fzRGnT6TqL612OleJw8usaM8ejNsA8p+EVMmITb
	Z7q8sD2qhvB0qgYDq+JPrJMaefY=
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id
 5b1f17b1804b1-490c25e4634mr278897665e9.19.1780937190891; Mon, 08 Jun 2026
 09:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605192708.141921-1-joannelkoong@gmail.com>
 <20260605192708.141921-4-joannelkoong@gmail.com> <058fd2d4-3ba4-46e5-9107-3a7e0ab66653@bsbernd.com>
 <CAJnrk1YHQEtpwA-ForFWXsLntc950ekqAHg=L9VExVfJ2WF1Rw@mail.gmail.com> <742e68e6-c456-4655-a441-aaa8267f1a48@bsbernd.com>
In-Reply-To: <742e68e6-c456-4655-a441-aaa8267f1a48@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 8 Jun 2026 09:46:19 -0700
X-Gm-Features: AVVi8CcHW1wKDIqiTm2CslN6JixDpNiU105hbDeu8QQXU2KJUws3g1EbCoD1ldk
Message-ID: <CAJnrk1bz=BHryaWkZ0uBCpzLoVM-FSsb4mhA8F7+fnMQ4Tt_YQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: end fuse_req on io-uring cancel task work
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 12:41=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
> On 6/6/26 01:52, Joanne Koong wrote:
> > On Fri, Jun 5, 2026 at 3:09=E2=80=AFPM Bernd Schubert <bernd@bsbernd.co=
m> wrote:
> >>
> >>
> >>
> >> On 6/5/26 21:27, Joanne Koong wrote:
> >>> From: Chris Mason <clm@meta.com>
> >>>
> >>> When io_uring delivers task work with tw.cancel set (PF_EXITING,
> >>> PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
> >>> fuse_uring_send_in_task() takes the cancel branch, assigns
> >>> -ECANCELED, and falls through to fuse_uring_send(). That path only
> >>> flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
> >>> it never discharges the ring entry's owning reference to the
> >>> fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
> >>> dispatch time.
> >>>
> >>>     fuse_uring_send_in_task()
> >>>       tw.cancel =3D=3D true
> >>>         err =3D -ECANCELED
> >>>       fuse_uring_send(ent, cmd, err, issue_flags)
> >>>         ent->state =3D FRRS_USERSPACE
> >>>         list_move(&ent->list, &queue->ent_in_userspace)
> >>>         ent->cmd =3D NULL
> >>>         io_uring_cmd_done(-ECANCELED)
> >>>         /* ent->fuse_req still set, req still hashed */
> >>>
> >>> The fuse_req stays linked on fpq->processing[hash] and
> >>> fuse_request_end() is never invoked. The originating syscall
> >>> thread blocks in D-state in request_wait_answer() until
> >>> fuse_abort_conn() runs, which can be the entire connection
> >>> lifetime. For FR_BACKGROUND requests fc->num_background is never
> >>> decremented either, so repeated cancels inflate the counter until
> >>> max_background is hit and all later background ops stall.
> >>>
> >>> The non-cancel error branch already handles this correctly: when
> >>> fuse_uring_prepare_send() fails it calls fuse_uring_req_end()
> >>> before fuse_uring_send(). The cancel branch must do the same.
> >>>
> >>> Fix by calling fuse_uring_req_end(ent, req, err) in the cancel
> >>> branch before falling through to fuse_uring_send().
> >>>
> >>> Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uri=
ng")
> >>> Cc: stable@vger.kernel.org
> >>> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> >>> Assisted-by: kres:claude-opus-4-7
> >>> Signed-off-by: Chris Mason <clm@meta.com>
> >>> ---
> >>>  fs/fuse/dev_uring.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>> index 7cd50990b097..b5cc700575ca 100644
> >>> --- a/fs/fuse/dev_uring.c
> >>> +++ b/fs/fuse/dev_uring.c
> >>> @@ -1222,6 +1222,7 @@ static void fuse_uring_send_in_task(struct io_t=
w_req tw_req, io_tw_token_t tw)
> >>>               }
> >>>       } else {
> >>>               err =3D -ECANCELED;
> >>> +             fuse_uring_req_end(ent, ent->fuse_req, err);
> >>>       }
> >>>
> >>>       fuse_uring_send(ent, cmd, err, issue_flags);
> >>
> >> I think that can race with fuse_uring_stop_queues(), which leaves us t=
wo
> >
> > Hmm, I don't think this races with fuse_uring_stop_queues() as
> > ent->state here is still FRRS_FUSE_REQ and fuse_uring_send_in_task()
> > can only be called for a registered fuse ent, which means the ent has
> > already grabbed the queue refcount which will trigger the async
> > teardown worker to run in the background during abort until the ent is
> > reclaimed. I think this adds a race though with the request expiration
> > checking logic which (a) fixed, so I think you're right that we'll
> > probably need the same cleanup here. I'll look at this early next week
> > and send a v2.
> >
>
> Right, actually no race at all, just a plain use-after-free, because the
> entry is set to FRRS_USERSPACE and then cleaned up during connection
> abort and then released again through fuse_uring_queues or
> fuse_uring_async_stop_queues.
>
> I actually do not get this part of the commit message
>
> > When io_uring delivers task work with tw.cancel set (PF_EXITING,
> > PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
> > fuse_uring_send_in_task() takes the cancel branch, assigns
> > -ECANCELED, and falls through to fuse_uring_send(). That path only
> > flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
> > it never discharges the ring entry's owning reference to the
> > fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
>
> A mean exit does not trigger fuse_dev_release() with a fuse_abort_conn()
> from that function?

I don't think tw.cancel implies a connection abort. tw.cancel gets set
on io_uring task death or ring death which is different from fuse
connection death (eg a single worker thread of a multithreaded daemon
exiting doesn't drop any ref on /dev/fuse fd, but that thread's
in-flight task work still drains with tw.cancel)

>
> I do not think we need 3/3 at all.

I think this is needed for the cases where tw.cancel occurs without a
subsequent fuse abort, else the application syscall thread is stuck
uninterruptibly in D-state in request_wait_answer() for the
connection's lifetime. tw.cancel with a fuse abort is the common case,
but I think unfortunately we also need to handle the case where this
doesn't occur.

Thanks,
Joanne
>
>
> Thanks,
> Bernd
