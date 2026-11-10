Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794276633;
	b=mBWABTicnAPpTOhF0h49gwzcsoE+ca20rndAde2hm+WUIlB2fYk1Z52d8uArYQyx6TVw
	 5ZxXhyyE2BL60yEGae5a0aZDy8UsIoWsSi1qgl3Br9r/4I21Ih5KrRpc6tT1e9Y1pyHsO
	 zj8PVypagE7MuW5ka15MLXiO6DEBMqNYVtXB+CeiOR6r5yaXZW9l4Vc6kmVMa0/unRCcQ
	 p/WWvtbgxP438MQR7j0zY3yd+O3eSVxfvzUMDFKo24C3CXeAHZ7OZ98idEbdw1MhwOe0y
	 Y0ViH6oDF2hSnVe/7ZgBx8HwdIzplOPz+lqL4TC0hsv7n/HCUjSqhsraRvRIgjx5gjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GU9EjYSQxV4eVGM8pi1wTcBqlYubWYJf24gfH5mqmRo=;
	b=dFEK6hx9WhI42mm1CAueO/2gIhtULyXSDzx+9htxZtdzX5vk6x9a8bCTTIOlaMN4jeqx
	 258A2v59nRVSHqtHl1uxqAoKDMMcX/V5sebkKDr90lKmCjXZS+tQSRzCsdIYk/NOTRl5A
	 iHkf/CPXQ1JpfOQelFNPa93cx5hueTNXhRaH1w/wzuRpp4gxrMp/mJdw+2XOjzHiSXFuj
	 N3oinxvT2Sn6bXmeoKwyoth+58NnJNL6byuDss7sGWGf2nyKwsD8v99uT3zPhflR9cX/1
	 dsnMhp879lrGM5GAUqOmyxNBkhZEEft1kB/ij9cKzpSRG0bMabVMpGXVAP/Dq3Mhpfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx6UBesi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9063A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx6UBesi
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1079346b3a.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 18:10:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794276633; cv=none;
        d=google.com; s=arc-20260327;
        b=GJvg3fwspsJ5avNAnS9nMBtrms+BmY3+B0zu972DtLqL7FAr/NRJ8oa6u8fP2bD06u
         4vpxesAk0mAW0Vf9OIsNz3yGshe53G5gJcp+nTkApWodZQZbPPGYMbXtEBehYzKsRs3O
         jGnQUsM7vz5rcccg5Ej1GyaGC/qf3FjEND3xA6MgMPQkkjVd+KifpymiN/5mk7rxP+xh
         fasi6ECNN/S8pJcprcZzvNAcCXGGbQkHFb5otYjc5AavNyBvlyvZDhibQDuSBsqgqik5
         6c44fzXdCmygbGQntfytVh0NiiCAaZrPeF6ZGvxSvV+VTAJYqro6bK6YkuV4aZp2y/Eb
         3FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GU9EjYSQxV4eVGM8pi1wTcBqlYubWYJf24gfH5mqmRo=;
        fh=VGZDhfX0ixHRVSuCJ8hZEWSSUtZZYyWCEIT9Vn0zHpA=;
        b=YoW2tK6hNlCzScxHm9ohGsP1ac0wKxrTMzAeRYZCsEz3rNugxTv+fb0MiN51xWgR5O
         tfi5V/Lg+n8QZNu7cett99qtuY3cxDEOpHO85A425M80lp2lSXyXquwEa1Qi73SpVULH
         9a1BnapJxrKrIhF0ijtesNl9Y/5W6y/5RxYvRMqmXujnBqWG/hMZERSVnXhSNVJP+VMa
         tUSzZMcf3YYpuiUdz9lFcbrqzk6AHkmdWkIJKXGgbaiPN2aavz0lbyMbKY48fQsTeytE
         sLxMPJnCu758oLukWrU2mXLWgNN6s32IXbz+JN5py9zLSjWuMqkAFyttaGWWXc5U8MWX
         juPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794276633; x=1794881433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GU9EjYSQxV4eVGM8pi1wTcBqlYubWYJf24gfH5mqmRo=;
        b=Jx6UBesibvKmFXUbiN1heQ0gwpowE3/vZ86/WkwBWZjvZ5aRIqEPr5NCXsRZN9FkGq
         /zKHRJaBYarzlNszLkbDm7gBobre8/jK2rb9IaAb3Ip5Gusn+UHQFfXM7x8Mlia+QsZi
         AftAcFbmRg7+SOxFGhXLSxbcBgwWQ+Z8tQsg3n1UjTo90zNKNkWLQAhTUA2mnu4CFDNh
         a9z79bhvI7wmB3JBpmnURO9MvhIrCQ1jT6eiPCfDF1RlL+O2VSVeYn9iizYF2ynDoPYs
         qR1R5FnAorCK2qjBBEuK7/gIaK8DOZJFOWVdHQGSlTYqOFPyALOtlxhNA9ZtnIEPbaDS
         aoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794276633; x=1794881433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GU9EjYSQxV4eVGM8pi1wTcBqlYubWYJf24gfH5mqmRo=;
        b=OZpI5RUf/c68nVSGjDDQR6vOfJEY699iBxwUpOO1DEl1bq/humd5gt4ogCfpdQfVf9
         wrxOlxRXwqp4Rajao3jYBA2Najobk3vMlDxep83x8Q2zUP7QS7kDOmrtUcxRdUA/YIjt
         bgULMbiQrX78yRfq4E4+ciOt33s7YdZvQ4ny40h5CFgxUZzjt08ZZW1lGGi+W1tsLJbM
         u2SD1onzox6r1vFLE8kz/5rkyYZRLJAlrtUnTcFgJtdtiTDvnfsRKw9PS8J6TYXJ84uZ
         v7qH+6y6/iT3TyO3ulKEu+NDR+X7U24LfAj1ERaWsf0Vq3EYJfcNv/85ACpOPOdqd/cw
         QA8A==
X-Forwarded-Encrypted: i=1; AL+hErFj5ElNf9DukFIRjEbiHd6iVEpX1IeoaNHnRIJkmtUzd9pUsuk2kYpugXzZHohnunfVPJ0CHc4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6ft92/sZ4Nr60K+9PBCKzQjIiGtt73vyAVLczTRSQt+6aB2Y+
	CEuv32WFveXHNG6O3twgy5lAZItiKIC8eie/PQiPHA8gJtJnB2VWswsICKGx0Fhzn40UplihCL1
	b9MvJ7VKN9hstMs8m6oeilF+9d70VGIE=
X-Gm-Gg: AYBFou1K9V1suy8MCtNxEcTIKC8EoCPRcOPwLLC23mwRFRVrwaermBHjYDkbSGtcgen
	hA04uPzrsbOJaJcfnbq9xjf1Gb4iP7bKzh5I+Jv/AfEnfHftAdVesfpp7p6o0DGkqmFY0AuTlQU
	0JfnHfDbpAJtgizuwMH7cPXAUwaHCZthqp6kvz7GJaBb7YmO38u6GNmxYJ/JW/cd8RKLFg8/ksw
	+tO/xmKVcK3/CbcfIa3iygoO6Bku/2n+bwzKbtXNAl5Bsy7bcmTulR9CD1zs5DeKA+Wrnga5RQw
	lrQZGiHrZ38vSsPQiuUPg4JjjE+J8dnBZYLnAUOueuaXFApKNW8jfKuBL5wft//QecINTduPeVG
	sJPUwTlnD/5py5KSDW7BJmKjfzKhp2H0rtXFwmbPs3Hhi05yu4mVvkIcwEJWY97yBuqNH0HKcRY
	74jkQ138vDRZoblPOEeaRYcuFIAG32vrbC1A==
X-Received: by 2002:a05:6a00:391a:b0:8b4:b88a:c2d4 with SMTP id
 d2e1a72fcca58-8ba881e8931mr1491983b3a.59.1794276632703; Mon, 09 Nov 2026
 18:10:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106195126.1563231-1-andrey.misyrov@gmail.com>
In-Reply-To: <20261106195126.1563231-1-andrey.misyrov@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 9 Nov 2026 21:10:21 -0500
X-Gm-Features: AclHuK_xDqAXw_TmBik1qZpjy57T3ZinrxmJok9KVaPZUDx9W2Oq2jkZuacmkfM
Message-ID: <CADvbK_dNcVHxMQ4NhqZqVFCcCy0R_ufW=QbXXyVFdhV9B7O43A@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix ASCONF address change on single-homed hosts
To: Andrey Misiurov <andrey.misyrov@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Jun Yang <junvyyang@tencent.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 2:51=E2=80=AFPM Andrey Misiurov <andrey.misyrov@gmai=
l.com> wrote:
>
> Commit 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in
> DEL-IP processing") refuses a DEL-IP of the transport the ASCONF was
> located by, so that a later wildcard DEL-IP cannot use it after free.
>
> This also breaks the single-homed address change (RFC 5061 5.3.2). The
> host sends [Address Parameter L] [ADD-IP S] [DEL-IP L], the association
> is located by L, and DEL-IP L is now refused. The sender never gets an
> all-success ASCONF-ACK, keeps src_out_of_asoc_ok set and stops sending
> data, so the association stalls.
>
> Fix the wildcard DEL-IP instead: look up the transport of the packet
> source rather than reusing asconf->transport. Both DEL-IP paths can
> now free asconf->transport, and chunks bundled after the ASCONF still
> use it, so point it at a surviving transport: the packet source for the
> wildcard delete, the primary path for a plain one.
>
> Found by manual code inspection while reviewing a backport of commit
> 9b2854f86f0b; reproduced on a two-namespace single-homed renumber.
>
> Fixes: 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in DEL-=
IP processing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
> ---
> v3: a plain DEL-IP of asconf->transport set it to NULL, but chunks
>     bundled after the ASCONF dereference chunk->transport (e.g.
>     sctp_vtag_verify()); point it at asoc->peer.primary_path instead,
>     as suggested by Xin Long. Reported by the netdev Sashiko AI review.
>     v2: https://lore.kernel.org/all/20261029193454.1028626-1-andrey.misyr=
ov@gmail.com/
>
> v2: the reworked wildcard DEL-IP branch could itself free
>     asconf->transport via sctp_assoc_del_nonprimary_peers() and leave it
>     dangling for a bundled DATA chunk (sctp_assoc_bh_rcv() ->
>     peer.last_data_from) and the following SACK; retarget
>     asconf->transport to the surviving peer. The pre-existing wildcard
>     SET_PRIMARY / sctp_source() point is left out of scope.
>     Reported by the netdev Sashiko AI review.
>     v1: https://lore.kernel.org/all/20261022163639.2566945-1-andrey.misyr=
ov@gmail.com/
>
>  net/sctp/sm_make_chunk.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index ddc31a5..9719464 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -3151,9 +3151,12 @@ static __be16 sctp_process_asconf_param(struct sct=
p_association *asoc,
>                  * packet MUST be deleted.
>                  */
>                 if (af->is_any(&addr)) {
> -                       sctp_assoc_set_primary(asoc, asconf->transport);
> -                       sctp_assoc_del_nonprimary_peers(asoc,
> -                                                       asconf->transport=
);
> +                       peer =3D sctp_assoc_lookup_paddr(asoc, &asconf->s=
ource);
> +                       if (!peer)
> +                               return SCTP_ERROR_REQ_REFUSED;
> +                       sctp_assoc_set_primary(asoc, peer);
> +                       sctp_assoc_del_nonprimary_peers(asoc, peer);
> +                       asconf->transport =3D peer;
>                         return SCTP_ERROR_NO_ERROR;
>                 }
>
> @@ -3166,13 +3169,9 @@ static __be16 sctp_process_asconf_param(struct sct=
p_association *asoc,
>                 if (!peer)
>                         return SCTP_ERROR_DNS_FAILED;
>
> -               /* Don't free asconf->transport; a later wildcard DEL-IP
> -                * parameter reuses it.
> -                */
> -               if (peer =3D=3D asconf->transport)
> -                       return SCTP_ERROR_REQ_REFUSED;
> -
>                 sctp_assoc_rm_peer(asoc, peer);
> +               if (asconf->transport =3D=3D peer)
> +                       asconf->transport =3D asoc->peer.primary_path;
>                 break;
>         case SCTP_PARAM_SET_PRIMARY:
>                 /* ADDIP Section 4.2.4

Acked-by: Xin Long <lucien.xin@gmail.com>
