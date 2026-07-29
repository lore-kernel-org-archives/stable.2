Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568E3563FA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340056; cv=pass; b=JoR4v2YVV6xV+RCqZN0mOeFM3OI7CKKwta2XacmEyk10DRIULk54s4LwJsq5dpAsJksrvG6nByn6NGgNPaNtz32pCl5tXWaEzoRNibMpwH43iK3xwBWyjz+gSoKrofHPdrqQ9udaZBlQBAtLOYybF1LDlyevmEyaIxSecdUiOJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340056; c=relaxed/simple;
	bh=mgGDW7odZQJtTZPmsadDeUWjf7CLsPvSwU4pVoMogJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwHU4ybbKgSYgi4A3ItZMDOyZFL0Lf9u2BQIXsrce4b1QuU8JJxc0jliqJihhNkaakACLpxTGC5xEYtqpjR7/zVcGi9aLN/HvI+HZ8OH1v4++xQQyeAAvZrF4X10RbmJ8VP/ElgnmVdOpjxaJg0TUguw3zzu0x8SjjDzG0o2CEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFdG+0mv; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFdG+0mv"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-969524c1a63so624915241.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785340053; cv=none;
        d=google.com; s=arc-20260327;
        b=ZYAtRU/ROhGckrSIO1FGFOTraXxWw7b9zIBiGe1VytaUDs1D5xmoN0gYx9QhhWA+ks
         dMeQrwRw7Sj6eMDXKob5u/HZmNTbBnTQpGyt3qdZqPGhRdDVLcFAkbO1ysKf6pcby9RP
         RgyNRcF7oeCACSzH/RMF2py9xXM+F90VsQD0Z0wDCVCmQsjuOEWsRs8F5UEKDg4N19o9
         dnhzt7dKvPYjwgkUN+nRDdPhkrOTpEUDIfXy7/9D9HVtMx/NW+1p8JsevQMkq+wOCjzE
         W3Gza7d6t5fD8/KWZEkEojz8jwJDie1lp9DRFskejk1agtKqBM48ZpcY8KRC07FV6wSO
         MEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPm1Zkyu3BaX1h8XC4TjYemj4kfTSOFBWz8obT4dB9k=;
        fh=m4r6seMh2dAiOHOfNk8Kac8K6pvS1u0zCk0qF7yO1OM=;
        b=A2keqgEg+ofvHpBamJqcXFnz9D8dlcFUdih3sfx3XT7q5+BrBrwdzd1tBH8QVGjBqg
         MRBxDrcORr37vcegMi3QBdCWJWmKKq+9ivwZLuBj1aSonlVtn+VtiT+hg9SoeidfGsNN
         HXnDJUwbvq3N1qSe+pMn1OgQifIPsWDthAkmGtB6IuYJ1GpvWm/A1QhNz8gzeYvPmLfq
         BBgL4DIWODnglNqYyzQFppl+nhIoOyjsFLr7dsA37FcSF8Ft7SzSLOq3ipFWpT7UFarf
         KLgkUNITdO3vDwBCzuup+WMjv3eHQkAwIwCPhUNLLzM6fUPAc6KqtEMjHNFVaClunzqf
         5ZgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785340053; x=1785944853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPm1Zkyu3BaX1h8XC4TjYemj4kfTSOFBWz8obT4dB9k=;
        b=kFdG+0mvD9EcLXxllv4ahYIH+C+fdXF6/i2UbccqNWiIkDQcxITIoalcJqczDUl2W1
         5WIhowg2UA2mJvM7BQRZit2SuGAVRosT4Wb/OKm8COE9w+/NSHmYo0vn4RMiewKKjDyo
         TyWNrLt2Dx6/e6/M10T4GAUNZCdIZ0Bvnh84+u6Fts4iGz7dtBKOFSE7qFK4aKLGdWDf
         nyDU6Utmn4FaEBmxVzggZmoYUBjLbgOVoz9WwERUib+soQvnNV3WbPI7eHCUuX/a1uOG
         ui72zNlX7pvMAbxQvd/hLa3Hm6p3vAm69cKRohFWpfnFHYbIN8EEh0U5I35n2wRvQzcd
         1Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340053; x=1785944853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPm1Zkyu3BaX1h8XC4TjYemj4kfTSOFBWz8obT4dB9k=;
        b=JVpnPGazplMVZ4P0rUcwmAOJkciuhp3daEQ5/Iy0kHmzNUDabpF0Bh0qUQJBywxKfA
         Ao1tN8ESYDdlXyE0YnKIyjeBiOFcZgNxsfdr2so/zII9DyEva+Y9QZNTUJL5ImogPb9B
         HM1fUK3xxwt7auKHYK7vxGfTEJzkW7p0QNbAoPujFTH4V1niI3D62y1wuh1mCDjbEUOz
         DMJWnpFMXTsXgh7bp84stw2Cg5fbPez9Ljz2LWjN4MgajBlm3sVEyKWFGVEnPtP0Hsgw
         i1g4UuGq2MW21GJxeNEMKTVOEfXbl65AqQu5CKwS7xRJpDCsnxuCyoqFJsEmavhcwAOy
         ICaw==
X-Forwarded-Encrypted: i=1; AHgh+RrBOvlnmL01DkZQsO+iLxHHLlbQDq72/iZVnW6CflGgnVjQ1LPNdEiMkXvBeio/mP+ACCefR3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVsM7gSWhH55Hhudd6QMTz8rW/6mOpNvT3cIAJR98VY+PJx0V
	7wl48xhUjEM1U3NAWhT9zNVzhBIB38/1wv/CwU5riilGOCDByWYSpZ6r3cqi8k3qrVB6eMRAhPG
	S25PB8l1qxEkBWGSPEo3arL+1Ij8fyls=
X-Gm-Gg: AR+sD12JCkXlJY4iRzWWBvXFkZ7kqqxNmq4AE/r5kbrUb0qiya6LuFL/4bMOzmrM8Wy
	pSA9O8rzc0LBbfbPDsr29QIghZkPcyH/EShsziD0wig+LcJsmJb+yEwcyR9AzyI33fQS6mc7jPw
	Pra8LHpvvRXn+lGTV2gLLu181HBkKwj3TKOnXDEpv0SwwFa260nv4Ml1RZH79+Yfq75bsEP+Jaw
	LBJtY9IhTEZnwqWNnSX+/N6/moZ+CJsREBSE5u9hSbPRzSRiT0FpW6yFv4QyZpc6hn7dJhG0T3a
	udKdvjBqnWPRcr6zkoqG/zoCBuLYf1d5EOSiXrIPruTO6/lvsNABhgXdWPoh9EjMVwhdXgupdek
	pFX21a17TdegHEXSkBjAmH5G9QVUO4+/5Ib0zhpXUWhM=
X-Received: by 2002:a05:6102:512c:b0:722:826e:1423 with SMTP id
 ada2fe7eead31-754a23c05ffmr3550572137.20.1785340053326; Wed, 29 Jul 2026
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726060453.42730-1-baul.lee@xbow.com> <20260729124929.5885-1-baul.lee@xbow.com>
In-Reply-To: <20260729124929.5885-1-baul.lee@xbow.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 11:47:20 -0400
X-Gm-Features: AUfX_mz9nZndAK9KdmKF1YI91jpaV8MXnQ4Zg4xcsY1aSJ5xem0vHknyrBE68Uk
Message-ID: <CADvbK_cv4CAqN4sX-M0onYZjCeF03==vpkgt6AfvohFn8qvLnA@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: keep chunk->transport in step with the list
 it is queued on
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:49=E2=80=AFAM Baul Lee <baul.lee@xbow.com> wrote:
>
> __sctp_outq_flush_rtx() moves a chunk onto transport->transmitted in two
> places but only one of them leaves chunk->transport describing where the
> chunk actually is.  The ordinary resend path is consistent because
> sctp_packet_append_chunk() rebinds the chunk in
> __sctp_packet_append_chunk():
>
>         list_add_tail(&chunk->list, &packet->chunk_list);
>         packet->size +=3D chunk_len;
>         chunk->transport =3D packet->transport;
>
> The gap-acked path has no such rebind.  It parks the chunk on another
> transport's transmitted list and leaves the stale back-pointer alone:
>
>         if (chunk->tsn_gap_acked) {
>                 list_move_tail(&chunk->transmitted_list,
>                                &transport->transmitted);
>                 continue;
>         }
>
> So a chunk can sit on a live transport's transmitted list while
> chunk->transport still names a different transport.  If that transport is
> then removed - sctp_assoc_rm_peer() from an ASCONF Delete-IP - the last
> reference goes away and sctp_transport_free() RCU-frees it, leaving the
> chunk with a dangling pointer.  sctp_assoc_rm_peer() scrubs the
> back-pointer on peer->transmitted and on asoc->outqueue.out_chunk_list,
> but this chunk is on neither.
>
> While tsn_gap_acked stays set the dangling pointer is not followed, since
> sctp_check_transmitted() skips the flight accounting for gap-acked chunks=
.
> A later SACK that reneges on the TSN clears the flag, and the next SACK
> then reaches
>
>         tchunk->transport->flight_size -=3D sctp_data_size(tchunk);
>
> a read-modify-write inside the freed sctp_transport.  KASAN reports a
> slab-use-after-free read of 4 bytes at offset 216 of a freed kmalloc-1k
> sctp_transport in sctp_check_transmitted(), freed from
> sctp_assoc_rm_peer() via sctp_process_asconf().  The removal and the
> faulting SACKs all come from the association peer, so an application that
> speaks SCTP and accepts multihoming is enough to reach it.
>
> Assign chunk->transport after both list_move_tail() calls, so the
> back-pointer always matches the list the chunk is queued on.  Doing it on
> the ordinary path too keeps the invariant local to the move instead of
> resting on a rebind that happens later and only if the chunk is appended =
to
> a packet.  Fixing it here rather than by scrubbing more lists in
> sctp_assoc_rm_peer() covers the chunks that were already migrated before
> the transport went away, which a scrub at removal time cannot see.
>
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> [Reported privately to the maintainers on 2026-07-10 with root-cause
> analysis, a PoC, a KASAN log and a fix; posting to the list was requested
> as the follow-up.]
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
> v2:
>  - fix the root cause in __sctp_outq_flush_rtx() instead of clearing the
>    back-pointer for the retransmit queue in sctp_assoc_rm_peer().  The v1
>    scrub could not see chunks that had already been migrated onto another
>    transport's transmitted list before the removal, which is the case the
>    reviews on v1 asked about
>  - correct the Fixes tag: the inconsistency is as old as the code, not
>    introduced by df132eff4638
>
> Link to v1: https://lore.kernel.org/netdev/20260726060453.42730-1-baul.le=
e@xbow.com/
>
>  net/sctp/outqueue.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> index f6b8c13da..1b2d08f2e 100644
> --- a/net/sctp/outqueue.c
> +++ b/net/sctp/outqueue.c
> @@ -650,6 +650,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q,=
 struct sctp_packet *pkt,
>                 if (chunk->tsn_gap_acked) {
>                         list_move_tail(&chunk->transmitted_list,
>                                        &transport->transmitted);
> +                       chunk->transport =3D transport;
>                         continue;
>                 }
>
> @@ -715,6 +716,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q,=
 struct sctp_packet *pkt,
>                          */
>                         list_move_tail(&chunk->transmitted_list,
>                                        &transport->transmitted);
> +                       chunk->transport =3D transport;
>
This one seems redundant on the default/SCTP_XMIT_OK path, as it's
already set by:

  chunk->transport =3D packet->transport;

in __sctp_packet_append_chunk().

Could you please remove the second one? (Sorry for not noticing this on v1)

Thanks.

>                         /* Mark the chunk as ineligible for fast retransm=
it
>                          * after it is retransmitted.
> --
> 2.53.0
>
