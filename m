Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09F4E80AA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450495; cv=pass; b=uE5IBhcSyHdPsyDqlbzuBtp/vaUttQ3UUsEuAyDlYl73zfhtTucL74pNyaTWLmdkMU8xCsfW/UOq0SVycCCOb4v/y2tTQ3AMmep0iVnpHGTf1Er0m1hFIW7XTDtyuEGnuLIz5Ff5epwA0lhPTAsmuJhFgD503+4Mv7pgYkhZHAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450495; c=relaxed/simple;
	bh=ysGWC46TVAgt8Kh/5/8QIzyhKkK3xHCTvCSqjeflq74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBVJuYqYXDhMtkbrDLEGoB5cuSTrednBHta6a0dBXZZn3CbLXe/UIiIoDsi7boJ2pOoKqn/eM9NOS/cTYk5VZ17pIcEytalTGH7UFBBJ6MnJ2Mr9wFQwFZLw1MyGJgaKW5joufleZAMZUkW+SLdKmlKk1EbLvCPGVpaM+V6j7FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MTfOo6nK; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MTfOo6nK"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso82844a12.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788450493; cv=none;
        d=google.com; s=arc-20260327;
        b=o7YWyvnn2LTmnew3pfbzizgmeZ/tQQOq99Dr17dGRSfbqejrYpRy4WQyM4OOjpDBtd
         N8I2cBch8lcC4agotQ77LF4ljWilmekM+2XTP3gvXwyilP+nZRqOgh8Eaqyz+iXTyu+Q
         WFjqJVsRoO41LEXfFZZ+jrwxR9N74jAc9Hfqq/zZwhFSYO/22LTGCoUnE8DF5hnUbjQi
         6S5q1inwJ2uANwESUNJw32tl/8WRPWCoXW1qmVK+3XXFgyVINbNjoftXZO2SnrbxPZub
         Np9KLfq5btOBmXu976hoPvXAgc2a5EjX8sPswMvjonLVNSbx0aWzsyR1S57IfwiCYpA4
         Smmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zfz+px8BqAfZBHsH8Cz0nrkeyup7coS8NIva+kDPyM4=;
        fh=Xy7PzhxDG0XRgzhE/dFFugwpPbwFKW0oKu3XBzqlt+Q=;
        b=AwbI05EolLvHa1DTvWWxaDey0sJqzf6fgIPDiFgj+LAl8qqshCFQRrf6bKXiC6/P7I
         7UEGVYTx4or0rt/mzbbk+sry7sb1YQLR5FgUxmYmnLBbsgez3b3oakinOQ11a0t+Ib3u
         wFGNetwY9am55Yt2i2g+8Wz6qA3n8OT0VR/znXMS1GHIhLpDDFS4KMFxFIHhdXmfLXJA
         +R56O+tKulNjvKiopajAsmRgKwAHb9GvgNLJt8pTNWDLpYerQyphutztvgidkGiYcMjb
         qJZzTtEDLNg8KYqyQVw3ReBqDA6P586tTJoN8q2gSo3VM8H1v5QP9yqURH6X3WM/v2OI
         XfcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788450493; x=1789055293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zfz+px8BqAfZBHsH8Cz0nrkeyup7coS8NIva+kDPyM4=;
        b=MTfOo6nKPb7BfRabUf+KPJxm7CttX/6ZodV+LEtUZ6EcdM1msMddYfILWeUlVUI2xA
         HTyYVlMvF/oh8MT3G8u/yHXatQA+quWaZBJFAcA+Ni5kFPc6ycRcu9TLHAr1yK+8BJuf
         Q8KlLNlLcJNBEOuEKC9zEsg9EhBWAu9+5Fn6lL+5XEjAcDFVj77XFncslhZw7pmt08cL
         kiCdV3MD0rsSfIrH7C7XcRL1mOb61SYkX5GHvGqEXkLfWOBfkoI2eUj5LKhD+Xc4bBje
         dalVYw0QyosuRHi700gizrkoUfIQkNJntiN/VqFdnO93x/13/NlrtX+E7gb4q0JzvD6l
         pnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450493; x=1789055293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zfz+px8BqAfZBHsH8Cz0nrkeyup7coS8NIva+kDPyM4=;
        b=lxhSj9c12Zwgk6vN7s97Mthb6qKqdgCSQJ2zJSY6shu9nLc3wW1V+zmrc4Ytnlxir8
         FIWa+ZD2EMN+o61P2M82BE/yfMEu9ZqMA63Fj+XGGfL2kYfXF8XpDNl4yhFdy6JGb5X8
         EpAAQtwZ7RbcysrzOvjraZAqgShLGgm0kg8jdM/tU6MsRUrqDIGe9W8yr3cSzUuRklkS
         6Vl2DA6+pG6sre3lK0Wg2CWc7Ibg4IbWLtp0ELPlcwGypTxS8lVqecTWr5h8lQyNGmj2
         CyVcjxMBnujxLCFW6ggHDPcVANd50rEk5JUdcJc1GLq24qdTBPr9XpuZEYo+FPjqycso
         VKjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxe3OmIbljPTZZsAt5odjOZriNrU9tdx6XipQ4aX90M2SpiMt2IQTOP+626clT3d7A6Q9Lm6oQ=@vger.kernel.org
X-Gm-Message-State: AFuF++me0XfA4hKS1jJPXQlHgaHMbQlkKBS9rlVjh3yVF9Fu+qK0r9hm
	+Fifdp/qcJeFiGL9otZ+Qtr0J3WG9kt5+/QJNhDS7KkqylV8/sGiBhzqcBR/pkT1EUElCofI8D6
	pn1FiaA0QxIdquqr8NkGH6Eqgl1iAC5s6xRV+Ierl
X-Gm-Gg: AYBFou3DvWFFjeKJ/7SViqf3Mm8j6YHWwGyq8wqwNNAPUCN/hNeFwSg14tqcMY4zlPJ
	jWZmzCDbzoo5Z8gPTX54hEAsuHly5pQ2tZryYyQxhpqBBL5SA9IAtEFlntoqXtAOlvI4DmYlYfo
	TM4lPHyTyPJUGI4036RzBl0M4xThTAkyl9Niv5sbzFy7iDLe+eUZXks3pQR0blHBe95baBwxISh
	ViVYkjYvi51Cxdzd7IlTrFSZ9HNFsIokEg8WZPoJsb2slwenZ9p5H6MQggZ00AHD7n66gnov32R
	+JxsdVXkofAqnP9+0VSlm6FrddFmHkVyjwYLY4gpEUpb
X-Received: by 2002:a05:6a20:938e:b0:3d3:ae50:97cd with SMTP id
 adf61e73a8af0-3da35fcdbe3mr1075867637.26.1788450493217; Thu, 03 Sep 2026
 08:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
 <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Sep 2026 11:47:59 -0400
X-Gm-Features: AcwNN1WRh6bIzS_5E7FQAMT0lE88uQHSPbMJnb8bd6pclmcyXC-IOtQe9nhwqy4
Message-ID: <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 2, 2026 at 10:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Aug 30, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> > >
> > > __selinux_socket_bind() and selinux_socket_connect_helper() call
> > > sock_has_perm() which uses current_sid() as the AVC subject.  When
> > > selinux_sctp_bind_connect() is invoked from the ASCONF processing
> > > path (sctp_process_asconf), current refers to whichever task was
> > > interrupted, so the permission check evaluates an unrelated subject.
> > >
> > > Fix by extracting the sock_has_perm() call out of
> > > __selinux_socket_bind() and selinux_socket_connect_helper() into
> > > their callers.  The process-context wrappers (selinux_socket_bind,
> > > selinux_socket_connect) call sock_has_perm() directly.
> > >
> > > For selinux_sctp_bind_connect(), determine the caller SID based on
> > > the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> > > chunk parameter types only passed from the softirq processing path,
> > > so use the socket own SID (sksec->sid), consistent with other
> > > softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> > > selinux_sctp_assoc_request().  All other optnames originate from
> > > process-context syscalls and use current_sid().
> > >
> > > Factor out __sock_has_perm() with an explicit subject SID parameter
> > > so that sock_has_perm() remains unchanged for all other callers.
> > >
> > > Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - Do not use sksec->sid unconditionally; determine the caller SID
> > >     based on the optname so that process-context callers (bind, conne=
ct,
> > >     connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
> > >   - Factor out __sock_has_perm() with an explicit SID parameter and k=
eep
> > >     sock_has_perm() as a thin wrapper for all other callers
> > >   - Move the sock_has_perm() call out of __selinux_socket_bind() and
> > >     selinux_socket_connect_helper() into their respective callers
> > >     (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_c=
onnect)
> > >  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 35 insertions(+), 12 deletions(-)
> >
> > Hi Tristan, this looks much better thank you for putting together this
> > revised patch.  Unfortunately, while looking at it I did notice one thi=
ng
> > (below) which I think we need to change ...
> >
> > > @@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct s=
ock *sk, int optname,
> > >                                    struct sockaddr *address,
> > >                                    int addrlen)
> > >  {
> > > +     struct sk_security_struct *sksec =3D selinux_sock(sk);
> > >       int len, err =3D 0, walk_size =3D 0;
> > >       void *addr_buf;
> > >       struct sockaddr *addr;
> > > +     u32 caller_sid;
> > >
> > >       if (!selinux_policycap_extsockclass())
> > >               return 0;
> > >
> > > +     /* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chun=
k
> > > +      * parameter types passed from sctp_process_asconf() in softirq
> > > +      * context where current is not meaningful. Use the socket own
> > > +      * SID for permission checks in that case; all other optnames
> > > +      * originate from process-context syscalls.
> > > +      */
> > > +     caller_sid =3D (optname =3D=3D SCTP_PARAM_SET_PRIMARY ||
> > > +                   optname =3D=3D SCTP_PARAM_ADD_IP) ?
> > > +                  sksec->sid : current_sid();
> >
> > This should have caught my eye in the previous iteration, I'm sorry abo=
ut
> > that, but now that I'm looking at this it occurs to me that the sock's
> > label isn't the subject in the ASCONF case, it's the label of the remot=
e
> > node (sksec->peer_sid).  After all, the ASCONF operation doesn't origin=
ate
> > with the local socket, as would be implied by sksec->sid, it comes from=
 the
> > remote endpoint which is represented by sksec->peer_sid.
>
> Are you sure that's the behavior you want?

Think about how the socket/connect check works for local operations:
the task requesting the socket/connect operation is the subject and
the socket is the object.  In the currently proposed patch, when an
ASCONF socket/connect operation is requested, the subject is treated
completely differently as the socket is used to represent both the
subject and object.  Even if we consider the socket's label a proxy
for the creating task, using the socket's label as the subject of an
ASCONF permission check makes little sense as it is the remote
endpoint that triggers the ASCONF operation, not a local entity.

> I don't think there is
> precedent for performing the socket layer checks with the peer SID as
> the subject rather than the local socket SID ...

I think that is because all (?) of the other socket layer checks are
initiated by the local system.  The ASCONF operations are unique
because a remote node initiates them, which is why the network peer
label is used as the subject as that best represents the remote
endpoint.

Please feel free to put forth your own reasoning on this, a discussion
would be good, but I think we do need to recognize that ASCONF
operations are different from local socket operations.

> ... and if using NetLabel,
> that peer SID will be limited to the peer's MLS label and whatever
> type was assigned via netlabelctl.

Limitations in the peer label don't change that it is the remote note
triggering the operation and not a local task.

--=20
paul-moore.com
