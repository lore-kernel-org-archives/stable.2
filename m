Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27F2BEFF6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345429; cv=pass; b=KpYWgKjCGHi+LJ5Vh3VVqpkUKnm6Vh/O5KZnLGpYwIEVdkjmf4558Sr8oyAZqttbWFN3pVfCa1cjs17Ei/HZgP1aJ+H+RsTN4TSQBhfbeOMb+BTOhsBo0GwksxxIoNdFJeB8SAR6g+jFYzFXm9JA9OdQqZcejxmltV9maDm69NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345429; c=relaxed/simple;
	bh=OhmbSmdM0u9DdOQrpt0cd9CMwSU+7fo2RA//JQhrP5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mu0Le2PQxezpWq2frwgE4+Bael7AOX8pjJ9GexL2in3TEdivmsUbPMNE1do0lnv5PlofF4ihOUFIMQ2ZDSk62Oo5l05cE20Pj0b95WFMGBByxVHePC1XW+4HIxbprZnaqp9QaXrsp2OBtgvhQX+q0o2Vbac0BPYBbcmLFItde04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIchv2Af; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIchv2Af"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a2c90e383so81005b3a.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785345428; cv=none;
        d=google.com; s=arc-20260327;
        b=b7SY+rdcDeQofLKGaC8tO1yV2HWZts1ZM4gyu/GIEaWi1FFkkEsRVDbG2g0Rbya6Kx
         bB37cOD376LH7hZlZ/foB2z/B89K0ahq9smZLETcziu0iSW2SeZpSeZDuEqdAZXQDmBs
         Sw73hYcDBXfjPRet9jEpZYvk+L8FVCkTIotqfni4QWcLt4pdp2HgOL20KURwqsku/sJz
         ygUztO4O3CYTXOxX8rEL5ILwXlg6sE2gIGh+PFPYK8JLWz8ePYyFcQATc7DbnGRdI0UZ
         EAs5mdhBknTWLcJxsVRvHZ55OxXMVkZHA8kAYPIep2xx8q5miGDV4eGPJpPNA07Nn1iH
         5qcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THkS45SRNxVl9I20kniMraMAUjrTFAmlyl7h5NEZIog=;
        fh=HC8CoFcXOClWyhe3Kk/xTj2IQpkaOdrrKBu88IIA4Zc=;
        b=ON6HOL5U5m93+3imjueXu7txJJ/VEo9FT58kG24xX5/qF8IyY5T150EqM5B+jY5mh7
         eyJrR//NQE7cpn3lDYbG7ofEgDepUMMh5E/2LjdcPPibq/N2Oa01MIrsJyCycvR0BY/7
         URnptKze5hLfEV5on7FQktQc+HDrHxeK9wzNBg3WsVn1hbitEh4vMnF8jECAe8HMVzV0
         Nu9EwAq3Cq3MEFMtesscoSw5SKYUE22GPLHZCz2Z401Y2+9BR4nSVpOLOV1rhMdenKeU
         /sy65rnPfE8hh7v0YC6sa1e0+yXPgG5pFncm/jXsG2MBfWQ94Gs+TDe2Ekm8JhifG6vV
         5s2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785345428; x=1785950228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THkS45SRNxVl9I20kniMraMAUjrTFAmlyl7h5NEZIog=;
        b=BIchv2Afs+jkdWlV1UgVEkPeSgbhL3Rd8Eqs/fi4kBZkelKQ04NMg2NWABZ4Hiyl3N
         xadmvaqq9KL03mCuEwyMJoYht37zLohmLPqawc294OLsqy2TCNuLjUGogYLfh96faua3
         lfh8ISf24SdGJ+3mSbzV8qwv/1k9V7DE6rMKaJVs7KJwAl/zMfoANLou5btDQTIgvytr
         RbNYltwmjSmGN8G/kS/LHAV28MR4Tz6cJ9qc9QidZ1RRDTAQdQkJ1Jl3o6qMZiHUiluN
         VbN9dIs+3CkZtQhNsJcwjoqNZ08U0QDDaD6evwrAPYnxSqxu4ZPiA0WMdp4555z2O07O
         uqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345428; x=1785950228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THkS45SRNxVl9I20kniMraMAUjrTFAmlyl7h5NEZIog=;
        b=i3MBSgSr+9YDd394LnXJNhHUe67QxcleMgNYWF5yEa/rfg2EX6lEKzSEAQhxv8tFf4
         DF6Ni8rxM4aqfY7rgwz8ii81kAHJyF2ZVwXW9klaHeJJWfjkTHh/sa82mufGLQxviI4m
         PQWZvV7ewkAeloevPUn52wLDnXMaEcWyp6KK8E46V1Hj8twrvw+6C3Ld0kFyplms7Pl7
         teh/olYlUw39OrI18OeOus3ZP4Cl+YnlssRhhwhY+Puxsq+7crD9cOpCUOIiEt4fF5JG
         A+6Xk/MGVApXOnayMxPMN7p4JKDVZ8FHP59yCDbePasvDcv2oJjDIGYG+HTAS2u1uhfR
         8JJA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3CVjezor18xrYqW8UztT1aow8GedzG2pk8+oJpCguTcl26PREIiudRQfmwicKyWfLL0o51v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FoSba0xi63XdCgVoNqO1rGXCyjQUvYg1EutvRxjsXO9DLjKv
	ozhZGQ72+6kLM8nVNUw8uyyHGsgx+lJD+QaSTc1cTxsl95ExfQkOy6eOl92NKDpLcg/XjGZxfiJ
	fC9rTITQYmRd7ALEGjKBJgMg3b8LqXjQ=
X-Gm-Gg: AR+sD1097dzj3Se2oFAljNfFl8pTrP87ESp3BgeqP1FQjnV9jEYVZ3iKDHK/y/xg9RD
	8DX94kNYIyuSsNCos32iMj4P/3sw7gKIC5aYM39NZvogtmKq5XPJQt7f7HKQgVDisNchuIHYbK2
	+dpF7CnC46rEX8cPVDGsrxlfFPJSlYNul970kM/1IC9YIKEIEX1OABLfiny4KLinh1rrzICHGr0
	t/zjvWMPAXcRwvjFmFsOG59atwxnssT3SCHa8KIuhuksD0oQNlQ3xrjy09HbrKVLMEhz2UX4zHJ
	2KSXPG4uUIbrovvYuy1iD8JvLqVY15okeBKgAcTLpax/cCZTPLv3oYh8OiBbO3WfhXSp+/cCpxk
	RZA1tkrltlB34dNSDz8femTUD9RfPbHlCSLWgnTtONHBP
X-Received: by 2002:a05:6a00:240a:b0:836:6f2e:bb6d with SMTP id
 d2e1a72fcca58-84ea7980b0bmr3344957b3a.14.1785345427563; Wed, 29 Jul 2026
 10:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729160028.54546-1-baul.lee@xbow.com>
In-Reply-To: <20260729160028.54546-1-baul.lee@xbow.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 13:16:54 -0400
X-Gm-Features: AUfX_mycAA4GRHZLpXxPNLNWzWds11yaKRsmLmnwj2-pURl4kFY9e09gLFpPNa0
Message-ID: <CADvbK_cCCaE3BiGb9cUE1SM8BwJ-vJn+ezRiO1h538OeHyPutA@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: keep chunk->transport in step with the list
 it is queued on
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:00=E2=80=AFPM Baul Lee <baul.lee@xbow.com> wrote=
:
>
> __sctp_outq_flush_rtx() moves a gap-acked chunk onto another transport's
> transmitted list without updating chunk->transport:
>
>         if (chunk->tsn_gap_acked) {
>                 list_move_tail(&chunk->transmitted_list,
>                                &transport->transmitted);
>                 continue;
>         }
>
> The chunk then sits on a live transport's list while chunk->transport sti=
ll
> names a different one.  If that transport is removed - sctp_assoc_rm_peer=
()
> from an ASCONF Delete-IP - sctp_transport_free() RCU-frees it and the chu=
nk
> is left with a dangling pointer.  sctp_assoc_rm_peer() scrubs
> peer->transmitted and asoc->outqueue.out_chunk_list, but the chunk is on
> neither.
>
> The pointer is not followed while tsn_gap_acked is set.  A SACK that
> reneges on the TSN clears the flag, and the next SACK reaches
>
>         tchunk->transport->flight_size -=3D sctp_data_size(tchunk);
>
> inside the freed transport.  KASAN reports a slab-use-after-free read in
> sctp_check_transmitted(), freed from sctp_assoc_rm_peer().  Both the
> removal and the SACKs come from the association peer.
>
> Set chunk->transport at the move.  The ordinary resend path needs nothing=
:
> it reaches its list_move_tail() only after sctp_packet_append_chunk()
> returned SCTP_XMIT_OK, and __sctp_packet_append_chunk() has rebound the
> chunk by then.
>
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
> v3:
>  - drop the redundant assignment on the ordinary resend path (Xin Long)
>  - trim the commit message
>
> v2:
>  - fix the root cause in __sctp_outq_flush_rtx() rather than scrubbing th=
e
>    retransmit queue in sctp_assoc_rm_peer(), which cannot see chunks alre=
ady
>    migrated onto another transport's list
>  - correct the Fixes tag
>
> Link to v1: https://lore.kernel.org/netdev/20260726060453.42730-1-baul.le=
e@xbow.com/
> Link to v2: https://lore.kernel.org/netdev/20260729124929.5885-1-baul.lee=
@xbow.com/
>
>  net/sctp/outqueue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> index f6b8c13dafa4..e92fb9da4647 100644
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
> --
> 2.53.0
>
Acked-by: Xin Long <lucien.xin@gmail.com>
