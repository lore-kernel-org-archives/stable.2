Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF596274B4A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086349; cv=pass; b=bk21TtEcaDp3g4MWKK8BdrGvR8areCdL/PD8FyeJiKCqdNEoEi7ao7risRhv6WxeJVbwN95Zxs2/ak54p/RypVaewNgcnsc3iYDcWzW+VhtJ1plSYRMrnW4gqYT/pxFe902KGJXS/5kY6OIGeTgPDK6QvgNaSEvrUvG24UNGiiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086349; c=relaxed/simple;
	bh=uCOZ0LrS3n3H3n+rg4kATp9ASsY5FD80qLKYusb39A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vs0ZoUzbcSRnRVEmvQrMYyyX+7rP5qD/TkJKK18DuQ1vOBmBobMP+czFADIkAozIVtj8rLoeDEUBbPeic2NKg51hFUFFtPtpUX3xWSxqGcOWHL75Xm32js3c4mXra2BjbL1LoPl8yXKHB7xX+Kb2wyDB2NwchyLs57jR3FIwOwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWzOrb13; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWzOrb13"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so226698b3a.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789086347; cv=none;
        d=google.com; s=arc-20260327;
        b=U9hzhYtBV+amWGSGtKkNVaOupKPDJZtaE4z7wl2d4FnCY0rjoB3wZzg4lDG+hsV9Jo
         +IXEcrU+T/ZVlr6CpEuiuJIL1cWVwRsykI2CW7nP1JnfZlZH+HhjKENfxrT7GDKCHVu5
         8dfum6U+S42jZ+g5I3uEFncDlDX2QXLujYHlBYAljxhEsK04cYyxKrnBjaCKfsEBHgaq
         a6yohQ8EjpFq6q7uy4D66PhcW00afnPnnoP1V4t/+tsr7uJhIiN8TFJ866uGp4L6cKSR
         CTrkghwPt+r4drpoYSesMHFQAIhO6bo/l35KMzEbq/tdP16vK5TNh0C7NIiwppiWV7hb
         +OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6cY2czYH1vDPyw0bwgbm9H8oNJcDXC0fpW3vN39yQ0g=;
        fh=4zeXbthTQ86cmXjQTJHyU+6/dO4JYKsgFrblGqF9dFA=;
        b=ZtNgcrfQ08ZfG6M/tK7Jh3JNUnDMlflhlfoU4d+f9+V4zewrX5OflYV6H2LZVb6H2s
         hlv0YgMGTQjm+I5D8h4tgjcW5qSfa3jUdsqoJKJqM9m+Exhk4QT/xiuF0MUpLnA94PjI
         mRrKgZeVcylKBivwIyJA0jXXHzduTsm+jr/VEPLiOs7m8HS737NNLWpwWCSqAz3H1UnZ
         f9RDZick8Sxgtrmpk4romxJSGlq65qD4aOxjJ+5XHg2Q2C/lZcob6LKA9my15myi5Nl9
         DmVQcdbKJW7CycvLippCrRsjb42S91KOnNKIsqSsJr8cQ5JRymlau70jg5eYKuSYmlgT
         /QMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789086347; x=1789691147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6cY2czYH1vDPyw0bwgbm9H8oNJcDXC0fpW3vN39yQ0g=;
        b=kWzOrb13cmbYUWa5sQN7/F2vv/IT8LFBB5CXPspowCrhWl+5HIhEb8oU9lGqPLFdYG
         X/1vNU6Bo0seVZYkhzo56Dk6Jb30GDAbOA+d7uU6cxUXISlqk7bEtOCrTwFtBUXQ0lso
         yXNj8tV2J8LcLDMz78xWVpUrBzqTlZdWvlk2hz1EX/bZafmiEJDRGnB10M1aN2WpCe7i
         4rwKYBavbaVeiaYahDigksBmVSjjOFwkD298+FoFstnxn3Q/r5umklVz+TJrKYEHOm7n
         6Pk2nqxaFcnLUC7exsJtjqQ9rbsIWn//PfC4u3CLiZk5azYSyYL82NLa8xoF6hjgfkTQ
         fd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789086347; x=1789691147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cY2czYH1vDPyw0bwgbm9H8oNJcDXC0fpW3vN39yQ0g=;
        b=sNNByxImx5Hke9bftGN75sFSPCuNMRCN8yBDJg4d6beD1mAAX1nxwZC/fiF4W9oXod
         WPn0M4LZRZjtJ/QC/zxK0Bdiddb9nP+Bp1oFYPcpx8XYDG+xLae5auE0965iuLaC2NmA
         9s4XaCChwCnDdWFB1VNBZNx/98UQAk8fyc/e23G22nr2XF0AXSP12TZC3c8VnD4bwF5Q
         20f3YeYw1Jm9KqYio+ObTj32qp9XNBcxEP2UKBVlSUYgNSpuVmT9C9HxaU0NcsDraUO9
         C4BEJ8tedVSDobBnt3LUuktHKaRYx06IvF9QGTlPOjqmZBkO5TPHgsFCrlTyVYha43bh
         Gegg==
X-Forwarded-Encrypted: i=1; AKwUvBzpslW3f99xJGf1Ysx+duEtPkcQAgDw6EUGbeq6voN6zKHjOnO5c4e2PrWW+bl78Cb/mXcR2gE=@vger.kernel.org
X-Gm-Message-State: AFuF++lLUG6lpvm8afOL819QMu0j+kKwN/z/grul6kCDllS73hDFbluR
	B1oiHQJ4L7DsyA2jIQ0USG/azaWaSHbiJ4LnWL+SZmikMW+frdEr6Zd+gsMVgsIBi9xtQWWSQ+H
	QfKN4YGsl59EZjwwe8CEc5N495+WhzsI=
X-Gm-Gg: AYBFou1CXcPUsvRJD3pP4pjcyOWkEXGkYHxNV69W9fAmKaduHwEC5rWOFCKQ5TKczQh
	OEe98y0rdac2kGUH1IDShJV0G90WPSocLOh4vQOwOoS5D3tLvxrj3a6foRIosditQ6LrxxPVccz
	PD/cUforJyy/LWNjdKL05xDR+YOiYZmAzqL57gf6fhDrm01uzD/Ywl0kvrtMTlEMrtraFTznPbB
	3Tyr6Vpo3bbgGC1F2BzrLS8dHI8B5BqPqEeskQ/Z4u8drtnPHp+fkJnGKbFT5vYBgSllI3gqnl0
	zIx4txaM4dlKIJeSR7d+VcKGrE/vubS/kMgTwH1s4nRW3Iw1pb2UCwYt2tafaUWOw3Tzk1KlDoL
	7xUlic3lD5e2OzxuK7poVrUG9ta9xTLZkOWqM7pDlQII5k6Rn5JmwwspZxP5Yk047PQ==
X-Received: by 2002:a05:6a00:3a27:b0:869:9298:ba50 with SMTP id
 d2e1a72fcca58-86b2aad0ec4mr2473923b3a.0.1789086347093; Thu, 10 Sep 2026
 17:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_dFoagLs1c4b-3aFqsbDueu3VO0t-8S93+6GgevuoRBLQ@mail.gmail.com>
 <20260902025206.phbpyxmpf4zrtdpx@sunyiqi-llm-kernel>
In-Reply-To: <20260902025206.phbpyxmpf4zrtdpx@sunyiqi-llm-kernel>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 10 Sep 2026 20:25:35 -0400
X-Gm-Features: AcwNN1XUuVVtdAD4rJUmZCOIjcTX3a30cN5AS0GEJXKtJi13ZMB16vRmNezrcKU
Message-ID: <CADvbK_e-7_aLVKYUr1hogQLJJPGEOCG_HqrTE2+6TFC3Mg=Egw@mail.gmail.com>
Subject: Re: [PATCH v2 net] sctp: avoid livelock while updating retransmit path
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:53=E2=80=AFPM Yiqi Sun <sunyiqixm@gmail.com> wrot=
e:
>
> On Thu, Aug 27, 2026 at 3:50 AM, Xin Long wrote:
> > After removing the continue, I think you can keep using
> > if (trans =3D=3D asoc->peer.retran_path) here without 'last' needed.
>
> Yes. The v1 'last' variable was redundant once the SCTP_UNCONFIRMED
> path no longer uses continue. Drop it in this revision and retain the
> original wraparound comparison after the candidate-selection block.
>
> The reproducer is attached.
>
> sctp_assoc_update_retran_path() walks the association transport list
> from the current retransmit path's successor and stops once it reaches
> the current retransmit path again. However, the loop skips transports in
> SCTP_UNCONFIRMED state before checking for the wraparound condition.
>
> This makes the loop non-terminating when the association contains only
> UNCONFIRMED transports at that point and asoc->peer.retran_path is also
> UNCONFIRMED. One way to reach that state is through ASCONF wildcard
> DEL-IP processing after an unconfirmed address is selected as the
> primary transport. sctp_assoc_del_nonprimary_peers() then removes the
> other transports one by one; when removing the current retran_path,
> sctp_assoc_rm_peer() calls sctp_assoc_update_retran_path() before
> unlinking it. If the remaining candidate and the current retran_path are
> both UNCONFIRMED, the loop repeatedly continues before it can observe
> that it has completed a full pass.
>
> Fix this by considering a transport only when it is not UNCONFIRMED,
> then checking whether the walk has returned to retran_path. This makes
> the full-pass termination independent of the transport state while
> preserving the existing fallback selection semantics.
>
> Also restore the NULL guard around the retran_path assignment. In the
> all-UNCONFIRMED case there is no eligible replacement transport, and
> installing NULL would leave later retransmit-path users and the debug
> print with a NULL path.
>
> Fixes: 4c47af4d5eb2 ("net: sctp: rework multihoming retransmission path s=
election to rfc4960")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant 'last' variable as suggested by Xin Long.
> - Link to v1: https://lore.kernel.org/r/20260827075006.3979566-1-sunyiqix=
m@gmail.com/
> ---
>  net/sctp/associola.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index c0512c827d0f..4521be3bd85a 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1289,18 +1289,19 @@ void sctp_assoc_update_retran_path(struct sctp_as=
sociation *asoc)
>                 /* Manually skip the head element. */
>                 if (&trans->transports =3D=3D &asoc->peer.transport_addr_=
list)
>                         continue;
> -               if (trans->state =3D=3D SCTP_UNCONFIRMED)
> -                       continue;
> -               trans_next =3D sctp_trans_elect_best(trans, trans_next);
> -               /* Active is good enough for immediate return. */
> -               if (trans_next->state =3D=3D SCTP_ACTIVE)
> -                       break;
> +               if (trans->state !=3D SCTP_UNCONFIRMED) {
> +                       trans_next =3D sctp_trans_elect_best(trans, trans=
_next);
> +                       /* Active is good enough for immediate return. */
> +                       if (trans_next->state =3D=3D SCTP_ACTIVE)
> +                               break;
> +               }
>                 /* We've reached the end, time to update path. */
>                 if (trans =3D=3D asoc->peer.retran_path)
>                         break;
>         }
>
> -       asoc->peer.retran_path =3D trans_next;
> +       if (trans_next)
> +               asoc->peer.retran_path =3D trans_next;
>
>         pr_debug("%s: association:%p updated new path to addr:%pISpc\n",
>                  __func__, asoc, &asoc->peer.retran_path->ipaddr.sa);
> --
> 2.34.1
>

Hi Yiqi,

Could you repost the patch in a separate thread without including
the discussion below in the commit message?


    On Thu, Aug 27, 2026 at 3:50 AM, Xin Long wrote:
    > After removing the continue, I think you can keep using
    > if (trans =3D=3D asoc->peer.retran_path) here without 'last' needed.

    Yes. The v1 'last' variable was redundant once the SCTP_UNCONFIRMED
    path no longer uses continue. Drop it in this revision and retain the
    original wraparound comparison after the candidate-selection block.

Thanks.
