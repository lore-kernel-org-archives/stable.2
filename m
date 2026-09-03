Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911384A3841
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438746; cv=pass; b=A4XPElqFEfjc4tODvQvws3evtVvDsDVFApK3nkQT71eMTSq9cz3v5RK44oXnUfFI1VtAOytpUckjwTE1syYdWDYun94y3fFw4W7PzI5j7oHuhSv/Hehq+v+l7naJs1LQDHY4jUz5pgvFaJ/EDWE6a7zc1/b1m0+Qs8N0K3fL0IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438746; c=relaxed/simple;
	bh=K5kiV1pGpE/oIFL9kGCW0HX9tRAcBztC6D1QkspHn8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/P1Sryhthv6utaH9Keu5WF78Ddv4LW6/NaNQmDJEtUsWDBHHeOpYnobQ0X1TBz0sAX3AOOKRTEfrrOkAaqFxX4ioAkYifrhsLKdoo4alnM8P/CQosDNRMbjDukzBMCAFW1N7uEFFzoWbP0SGOwYXl5cnCeUQWBMlDvOiuG/shM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgfoRvA/; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgfoRvA/"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-45837e52d8aso1816158fac.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 05:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788438743; cv=none;
        d=google.com; s=arc-20260327;
        b=U+IvGi5Q9auNVebm+n5sSd89b/i5QWrKoVPsn/KsrLXBP2xwwt2Kr4VG1qnqeU10x8
         xXgG7nRjL3kx2N7F/+2nJKarQB66elr6CGFs1UvJBc1NzHvSEQsLuzt+zQyiztFprLEz
         MPCgKcye7zQIwsbST0Ja4rjHBXXHzqYpOxpNgcIv8Fsy87zpgGgnhHCwvVZAnuEKdcTB
         g3h0S2Y6UK59SazBcGdZgzpw7GYJhj8fYHbixNa0C1evGcini1cuCnXBjJcf1EyP5n/k
         cQ7IRpc3gcJ/bolGotCzVHvGTOvxEmVLiTiqJeycandA5/YBGqHmDohlU/2G2CeKuWAY
         Nrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XokyMpC2uz3u3fmnMRd3git/TgidI+/M4SWX22okfiM=;
        fh=n1yjwA01LJonopXIGBkCByr3fAAUvG5OAP6cnd1Mqe4=;
        b=gFWNdDg8vBy687Zneq+lkGKEpTIUSul9QdoUAj+LcLpfptvf5w3MvqxlPko8BjHYGF
         h94wM/41NKEMDUS9tugAzCbTm3XPJcLmXFA+PcgpHCljOKwkQVSzFrKaa9gk688l0Tl4
         0UlNQOW/wFRg4mqFqM5HfUKPNcWn6i5ndDscBv64u/CZXU/BVNizlKZUo8TrOJlLFTNJ
         qoEvoyNEbq2mEPf80W7ZiLil5RwRqqoJb6EFRMq+hQdiNPsgcVAPtuWB3GdqGYUQGvUs
         gULS8ZSaQCdvie9AKrln2UXyT27bX/lH9cFxrf1HiFTN9GOpDRGtnRM8tlbvpGN2xc1d
         ho7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788438743; x=1789043543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XokyMpC2uz3u3fmnMRd3git/TgidI+/M4SWX22okfiM=;
        b=dgfoRvA/NYejTEOAcvgS5wUA+8Z7Urc+ZwLFeZMzwkYe8Gsee24JnU1vFaR8vrkukS
         VEjXvsdufXzqB31LlH3k0u/xi8R3IRMZ79F8skPW2lqixi5QqVGjUdjLnXqslMDGFCfi
         whgIIpIG9GE9vSdixHZ1WZu/ocmvrH+zUGmMQtOZpmorMCHj5eF7TlleVPwJ2t9TTdrI
         YePQ1g6iyv3guIFM8n32idn3bsQ0HnK4bNjXir08C75sJO4jUcm8S9iY1Z289zmb2Seu
         x9xgMOJrvlXRpuKuvCR18BM8SSjQayEWTY1OsMhsE3VycGcyYU/IHvCBOJBGApRZbrCl
         INyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438743; x=1789043543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XokyMpC2uz3u3fmnMRd3git/TgidI+/M4SWX22okfiM=;
        b=LYh3AbEmi5ckOZBWhikzz1yWeV9ZIEiV+ETmjSOqDoTEuj2/29HGm+1KsDs9bCK0Jh
         dQFu1cIKZt7qx7BiIKIKLaAPwhC+0YAEGVkcUxPLbOIKAHoKdDNB1+E+sRc2wam3voez
         Y9xIdySAnXnlDUa43r3lDuwOZzDwcfurBqJ5U6YhrDpxAFmtFaubOw2CGLQNkPnAFwDn
         gX3UMsPcFU3bP+DLxcElSH5pKtXEZYE5ap23SqMNuXZVoXGwZQd00NihKRxMXYPJOvoy
         IXbotg7C/dpi1d+sDfZgOltv3WzagJTAL6JHPUfaGpQoWUDwYfpaGSuRU+/uYvrbN+yI
         VU8w==
X-Forwarded-Encrypted: i=1; AKwUvBw1u6kBkRpD6HPF39QVYn+F54DgIttdGEWd2UVRV9q6QS1GWHFahbGn375Sl0ij1gPWwCdtuZE=@vger.kernel.org
X-Gm-Message-State: AFuF++mSePpvsmOH9fu0dQYj/UCZkyEneF7sYvBO9/wgHNuW616+0qcH
	/++hkicv2PEmvF7pB5J6bWyMqXdtsag+GXccxFHACC1qoec++wOv4y6hYWGhvr9z6LT9DoxnoR4
	ZuLR4KP8SRFrlJ0PivZdU6N5vvJTz24uNwg==
X-Gm-Gg: AYBFou22mFSYpIFPcsb/58JlZprqAhms+djqQ3ZVli7QnzuA0tPcnG0lY3VfV2IsCeL
	4g8tEzDtLrC8d7Gxcy+wyX2T3mVQr0UgeGC5YDkirDmzMlFUkVGXz8zC/LZTq3NjiMtrknLcyrX
	Qz1D7hmDnSz8g6RcL3Yeb+jl+r5n56DhqPWIWqGbXWHQ1jp7udy3qbV8Ecvw88/hNKadZu+6YrH
	Fx16eUhoQltzu4WR9K6yMYUUhwSpoMmdacJCV5TMK8fAaoKhUWDvgvphfQNhpjF/4rbEMbIy8vY
	KXgOG7oYO2OQaQXfZFPSNmmV/zHA0H79tummXfK6H9zb
X-Received: by 2002:a05:6870:46aa:b0:451:b3ae:e444 with SMTP id
 586e51a60fabf-46f858a7dc3mr10636349fac.1.1788438743135; Thu, 03 Sep 2026
 05:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
In-Reply-To: <5be8f666e660371dbc964c2348422a25@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 08:32:11 -0400
X-Gm-Features: AcwNN1V5N92UiGFZ-i9pCIWxt79RhFNzFeD5m_A-JclL3TKEK35sC70WcAPuReg
Message-ID: <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Paul Moore <paul@paul-moore.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Aug 30, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> >
> > __selinux_socket_bind() and selinux_socket_connect_helper() call
> > sock_has_perm() which uses current_sid() as the AVC subject.  When
> > selinux_sctp_bind_connect() is invoked from the ASCONF processing
> > path (sctp_process_asconf), current refers to whichever task was
> > interrupted, so the permission check evaluates an unrelated subject.
> >
> > Fix by extracting the sock_has_perm() call out of
> > __selinux_socket_bind() and selinux_socket_connect_helper() into
> > their callers.  The process-context wrappers (selinux_socket_bind,
> > selinux_socket_connect) call sock_has_perm() directly.
> >
> > For selinux_sctp_bind_connect(), determine the caller SID based on
> > the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> > chunk parameter types only passed from the softirq processing path,
> > so use the socket own SID (sksec->sid), consistent with other
> > softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> > selinux_sctp_assoc_request().  All other optnames originate from
> > process-context syscalls and use current_sid().
> >
> > Factor out __sock_has_perm() with an explicit subject SID parameter
> > so that sock_has_perm() remains unchanged for all other callers.
> >
> > Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > Changes in v2:
> >   - Do not use sksec->sid unconditionally; determine the caller SID
> >     based on the optname so that process-context callers (bind, connect=
,
> >     connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
> >   - Factor out __sock_has_perm() with an explicit SID parameter and kee=
p
> >     sock_has_perm() as a thin wrapper for all other callers
> >   - Move the sock_has_perm() call out of __selinux_socket_bind() and
> >     selinux_socket_connect_helper() into their respective callers
> >     (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_con=
nect)
> >  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 35 insertions(+), 12 deletions(-)
>
> Hi Tristan, this looks much better thank you for putting together this
> revised patch.  Unfortunately, while looking at it I did notice one thing
> (below) which I think we need to change ...
>
> > @@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct soc=
k *sk, int optname,
> >                                    struct sockaddr *address,
> >                                    int addrlen)
> >  {
> > +     struct sk_security_struct *sksec =3D selinux_sock(sk);
> >       int len, err =3D 0, walk_size =3D 0;
> >       void *addr_buf;
> >       struct sockaddr *addr;
> > +     u32 caller_sid;
> >
> >       if (!selinux_policycap_extsockclass())
> >               return 0;
> >
> > +     /* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chunk
> > +      * parameter types passed from sctp_process_asconf() in softirq
> > +      * context where current is not meaningful. Use the socket own
> > +      * SID for permission checks in that case; all other optnames
> > +      * originate from process-context syscalls.
> > +      */
> > +     caller_sid =3D (optname =3D=3D SCTP_PARAM_SET_PRIMARY ||
> > +                   optname =3D=3D SCTP_PARAM_ADD_IP) ?
> > +                  sksec->sid : current_sid();
>
> This should have caught my eye in the previous iteration, I'm sorry about
> that, but now that I'm looking at this it occurs to me that the sock's
> label isn't the subject in the ASCONF case, it's the label of the remote
> node (sksec->peer_sid).  After all, the ASCONF operation doesn't originat=
e
> with the local socket, as would be implied by sksec->sid, it comes from t=
he
> remote endpoint which is represented by sksec->peer_sid.

Are you sure that's the behavior you want? I don't think there is
precedent for performing the socket layer checks with the peer SID as
the subject rather than the local socket SID, and if using NetLabel,
that peer SID will be limited to the peer's MLS label and whatever
type was assigned via netlabelctl.
