Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD82C15A5
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791508254; cv=pass; b=Rea4N0V2l0Eg3Gk0RcGEV+Mv2OUPV/lTyQwJqmCvUs+J384YRhYWtAhQ9K4ZKy6zhi3qFQ0Cq9YnZ2erSLtQLNYw1ZGtGV+yAdCHzpBQxMNgsBWJED2ttZGAM7n6H/N5T2S3RsgeoCh0MIOV/p/z8HpgzLmgK9RFEmLB/3y/Tsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791508254; c=relaxed/simple;
	bh=8UwMj18LiDU8omtljeuGqbPOCEMqF3lUBiJrddjXbVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWREkBpJZRfdOLek+x8d4cDPAdl9QlnkAHQU0IRbHTYwyI1HD59ve+aYs13To6A1FgW2gYlhNAFZ1GRGphh5Y3oUp4v/y5yl2mHTrZeraOhl38vks+lOpOVoltKxIGoVXz+Hhu9nav4OBc2djayf3OQlj/w/r3GjNApmh05fh9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+Ww72kC; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+Ww72kC"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-88b8f0a1bcdso2830484b3a.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 18:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791508251; cv=none;
        d=google.com; s=arc-20260327;
        b=PDpq2uYhMngifXMhnuRz6YmPMMQYs2A2RqZmz9ls0ShrrDsMmTSCoraSqGiAT9qJwJ
         mIFRqtoiR9fAbB7LgeEzNl1vnqeEnqSxfak1Sp1ru9uaXIKul4h5th08bZFwYvidfUJk
         kdB7d0Oq8MdJt3pNPiQKlPRa6GHwk/6zbnrSYoxoezRbJ43Zi/56XuZVTkH1ARPuDz72
         KDL4UjxjoDTmEDHm0fo2JO+6MaE0cOwmnBVukFNEgTHiwGROjYZVQh9PTrItBnSNc0FT
         kqLYA0jyBaPkjjjNMG1S5FZDYhs3hLLzQBYGhkaBF8PGBuKbX2kLKOApJ+9vUlAbBvdT
         +YCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TthLjPmhPgp784Yx0bbWlwVp5UD5cL85TnNZ6vgW0DA=;
        fh=cmbQrRZ5TcPr0x1biL+wyI5MC6wBOKI/9mt13e6bmQ8=;
        b=AaIUlp6JETq+XAzvTvbCmnj86SY1ym+AjBYGKxuZHKtcWC3YWEhPxcjMAcARI84gHt
         6ZlrpD+2JR7avSlGSfPPlVYsoR/zL2+DrQmasbJ2UuhGG8DB7sQW9lVMRkk7SQZzsd5a
         rdczqGTvKCSj643lkgwXYriBmVIzfrsAYosw2UETRfwYELG1LxhI0eCXg5qpiDZZIhKi
         DdOt8unIitS8zuwUKeKxiGtKj+aW9mTvnpdXiPLP8/aN3rxL0NJZj5l5jm6psjHhDy15
         6yEwAhhZAHc2TNjmh6hEwzcMrB4Xfn2yW12qwEFFigZfHcPG4i0USBwfmhq9xG3UYI50
         tZvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791508251; x=1792113051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TthLjPmhPgp784Yx0bbWlwVp5UD5cL85TnNZ6vgW0DA=;
        b=B+Ww72kCHNK4UWPVD482LKT+PV7FjN5Snch/q7mpIDGwQjA6HmtNcXEo2lv7yfbPWw
         5TXc/n0I0G8FMQQM7DmAi/OjLa7dCV/MbMUR2wxBCuyNxCC1u8tgRB6VrpmbzOj/7RxT
         3/8N63B9d6aGWHhv56MikDKy0oRiqsRv7Zh0s53OLKU4xloXWP0erTWkifKyelejrG7T
         Cm/U2qy/xCchxKlt3hkuc5qmDRPmAucRSDntgc3VLNdfPRNU8fWyLuWnUow1FpPPBg6B
         HnSj8HK8PWeziBVsfr3LBBNP0XW9QN+SgWRikBw9WMyMlK58w6rYqFlQbRfYd+s/JOfy
         a7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791508251; x=1792113051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TthLjPmhPgp784Yx0bbWlwVp5UD5cL85TnNZ6vgW0DA=;
        b=Ws9ViGqwVhRiNhe+nDWMrdc9UKR/lDK72RQeF6w245+egSUopk8E0ildnzgIhtsWgB
         wny6g3q4uibAu1MG+DSkxklAu36804bKfnqZ+j8Cs5CXj+akak1s2UDKw+BFGgvLATpo
         HB7n3G2SwhIMmt0XOLjyeyZ1FgilVf93tWTYqhjUV2dfLebwYegGcVha76PwO7hHqoKp
         wj0goduigoQTU8ZjBxrXrcTrUgx66C9a06xDQL0Hng+Fo2jj9NFOBbm8zv0cRJ4q8HYM
         E65PGHvbcwZAuiEkUi8lPKS+S4K76wsr5D8Qg5TjFKNJy7M9BlZK9QzibRzO5o29M8Se
         ggwg==
X-Forwarded-Encrypted: i=1; AKwUvBzFYCMNO0T8xAeEHAdq2J9JqRb+60AX2eIgS3XjJ7K326SyaHIDiCrmwRIo+mnWV120cEFgvoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAyEdHvPF1eOPJIMCxvmC6stIf1AhKG/y/Ucleti/NvgsULglA
	W02idY1NQeeNOixcKrOzJY84XV2zArdAbvUQfzWVbvpJuJX0WETgw6N8X2AD9KitWZrMdH0fbr+
	5s4e803XSq0F61Hyqvlnz4BoFoelgGdw=
X-Gm-Gg: AYBFou1I7EKcBP2LQ94OTq18UgejfkvuCzeXSgVYilKQRVNYHYnRaotyeOiDAzPGjqC
	arIltsp9eWYJtqN61tU0ISgPkEnziR9yJ39BwJ2dW3CUPORhDio2sLXvOjl/Pj+VHBuUaAhXC1Z
	0BCyNhNoVHDc9GmtmVR0r0ObBovESG3Pr/HthbGFBmJpyrn7Rlmb4Y7Xb1P/kGf22xIa+LX7g9R
	58RGDCA2nNI8xR3DX1YVPWa6dUZboQofIhBgOo8RzDAWyFGOzBRHRdq+0mz83984iglnkm99Ikx
	3JhJd5AmGV207rbtZ1JM2LCt6XpzJWXryX+2UfnnUETVEzqLRh3UCOtfq00fhKpVsQiHk62ZcJD
	p4YqtMkO4mlX0rRio4u9Jf9NTDL7tOysgA2KvT8SScpt/Blz1MbUu
X-Received: by 2002:a05:6a00:2793:b0:893:1336:481b with SMTP id
 d2e1a72fcca58-897c76e19d8mr195881b3a.21.1791508250173; Thu, 08 Oct 2026
 18:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007035739.3472432-1-4ncienth@gmail.com> <179147504220.434549.18146896790420057417@kernel.org>
In-Reply-To: <179147504220.434549.18146896790420057417@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Oct 2026 21:10:38 -0400
X-Gm-Features: AclHuK8ziYcW9_tKZ9snSpT-kBT87Cg3V8VqJZ6z386Jui_JW-JG3uBKMbToqQ0
Message-ID: <CADvbK_eFDf3j67Qen-kOUYtg8+JWicMfQFU=iqxgrSqcyAVsqw@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: revalidate output stream after association
 connect wait
To: netdev-bot+sashiko@kernel.org
Cc: 4ncienth@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 11:57=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] sctp: UAPI breakage leaking -ESRCH to userspace on stream
>   validation failure
>
> Pre-existing issues:
> - [Medium] Pre-existing ownership problem on the sndbuf-wait error path
>   in net/sctp/socket.c, not introduced by this patch.
>
> --
>
> sctp: revalidate output stream after association connect wait
>
> This commit moves the output stream range check and the extension check
> into a new helper, sctp_sendmsg_check_stream(). It runs that helper again
> after both the sndbuf wait and the connect wait in sctp_sendmsg_to_asoc()=
.
> If the check fails after the connect wait, the error becomes -ESRCH, so t=
he
> caller does not free the auto-created, already established association.
>
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index e35692dd8d303..321898f22d80d 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -1786,6 +1786,18 @@ static int sctp_sendmsg_check_sflags(struct sctp=
_association *asoc,
> >       return 1;
> >  }
> >
> > +static int sctp_sendmsg_check_stream(struct sctp_association *asoc,
> > +                                  struct sctp_sndrcvinfo *sinfo)
> > +{
> > +     if (unlikely(sinfo->sinfo_stream >=3D asoc->stream.outcnt))
> > +             return -EINVAL;
> > +
> > +     if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext))
> > +             return sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_s=
tream);
> > +
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
> > @@ -1830,10 +1835,9 @@ static int sctp_sendmsg_to_asoc(struct sctp_asso=
ciation *asoc,
> >               err =3D sctp_wait_for_sndbuf(asoc, transport, &timeo, msg=
_len);
> >               if (err)
> >                       goto err;
> > -             if (unlikely(sinfo->sinfo_stream >=3D asoc->stream.outcnt=
)) {
> > -                     err =3D -EINVAL;
> > +             err =3D sctp_sendmsg_check_stream(asoc, sinfo);
> > +             if (err)
> >                       goto err;
> > -             }
> >       }
>
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. Does the
> ownership reasoning from the connect wait also apply to this re-check aft=
er
> the sndbuf wait?
>
> The caller, sctp_sendmsg(), frees a new association on any error except
> -ESRCH. It does not check whether the association is still CLOSED:
>
>         err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo=
);
>         if (err < 0 && err !=3D -ESRCH && new)
>                 sctp_association_free(asoc);
>
> sctp_assoc_add_peer() has already hashed the new association's transport =
at
> this point. On a UDP-style socket, another sender can find the associatio=
n
> through sctp_endpoint_lookup_assoc() while this thread sleeps in
> sctp_wait_for_sndbuf() with the socket lock dropped.
>
> A possible sequence:
>
> thread A (creates the asoc, new =3D=3D true)
> sctp_sendmsg_to_asoc()
>   sctp_wait_for_sndbuf()
>     release_sock()
>
I don't think sctp_wait_for_sndbuf() can be called for the first send
(new =3D=3D true) because sctp_sendmsg_parse() already checks:

        if (msg_len > sk->sk_sndbuf)
                return -EMSGSIZE;

> thread B (sends to the same peer)
> sctp_sendmsg()
>   sctp_endpoint_lookup_assoc()   <- finds the CLOSED asoc
>   sctp_sendmsg_to_asoc()
>     sctp_primitive_ASSOCIATE()
>
> the peer's INIT-ACK shrinks asoc->stream.outcnt below A's sinfo_stream
>
> thread A
>     lock_sock()
>   sctp_sendmsg_check_stream()    <- returns -EINVAL
> sctp_sendmsg()
>   sctp_association_free()
>
> Would this tear down an association that the state machine now owns
> (COOKIE_ECHOED or ESTABLISHED)? No ABORT would be sent to the peer, and t=
he
> counter and socket state would be left inconsistent. The commit message s=
ays
> it avoids this outcome for the connect wait by returning -ESRCH.
>
> The baseline already had the -EINVAL re-check here. The other
> sctp_wait_for_sndbuf() errors (-EAGAIN, -EPIPE, -ERESTARTSYS) also reach
> the same free. With this patch, sctp_stream_init_ext() failures (-ENOMEM =
or
> a scheduler init_sid error) reach it as well.
>
> Should sctp_sendmsg() check whether the association is still CLOSED befor=
e
> freeing it? Or should this path remap the error the same way the connect
> wait path does? Earlier commits c863850ce22e1b and 4f1da630d13de0 used a
> similar -ESRCH remapping.
>
> [ ... ]
>
> > @@ -1848,6 +1852,11 @@ static int sctp_sendmsg_to_asoc(struct sctp_asso=
ciation *asoc,
> >                               err =3D -ESRCH;
> >                               goto err;
> >                       }
> > +                     err =3D sctp_sendmsg_check_stream(asoc, sinfo);
> > +                     if (err) {
> > +                             err =3D -ESRCH;
> > +                             goto err;
> > +                     }
> >               } else {
> >                       wait_connect =3D true;
> >               }
>
> [Severity: Medium]
> Does this leak the internal -ESRCH sentinel to userspace?
>
> sctp_sendmsg() returns its result through sctp_error(), and
> sctp_error() only special-cases -EPIPE. Whatever
> sctp_sendmsg_to_asoc() returns here therefore reaches the sendmsg()
> caller unchanged.
>
> With this hunk, sending on an sinfo_stream that the peer did not grant
> can return ESRCH. That happens only on the first send of an implicitly
> created association with intl_enable set. The same request on an
> existing association, or after the sndbuf wait, returns EINVAL. An
> -ENOMEM from sctp_stream_init_ext(), or an error from the scheduler's
> init_sid hook, is also reported as ESRCH.
>
> ESRCH ("No such process") hides the real cause from the application.
> It also misleads, because the association is alive and ESTABLISHED at
> this point, and a later send on a valid stream would succeed. Since
> this is Cc stable, the errno change would also appear in stable
> kernels.
>
> The connect wait failure path just above already returns -ESRCH to
> userspace, but that case is pre-existing. This patch extends the
> behavior to an argument validation failure.
>
> The remapping only exists to keep sctp_sendmsg() from calling
> sctp_association_free(). Could the ownership decision be made
> separately from the errno? For example, sctp_sendmsg() could free the
> new association only while it is still CLOSED. Alternatively,
> sctp_sendmsg_to_asoc() could report ownership through a separate
> out-parameter. Either way the original -EINVAL or -ENOMEM would reach
> userspace. Or is there a reason the errno has to carry this?
>
This is not a typical user scenario, and this patch is sufficient to fix
the NULL pointer dereference.

I may address the original error returned to userspace in a separate patch
by passing &new to sctp_sendmsg_to_asoc() and setting it to false once the
association is established. This would also cover the failures reported in
v1, where sctp_datamsg_from_user() or sctp_primitive_SEND() may fail after
the wait and reach the same cleanup path.

Thanks.
