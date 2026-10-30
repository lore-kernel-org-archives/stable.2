Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793327441;
	b=gxh/Fid/jPFOe+y6vzsqcGvvfIB6AUVQ15BDe1ZLD2LUvOz+8PbabfmKHS2EYRxi68cN
	 Yo82ejnx88mwlaumHwnNUrEmqyLWmzgpo88BQ/G4CaFB83kbl7IWah4Q5C5u67vTIBLos
	 p6IyKGeU+/lfwwtgWzm+B2n+xyJRbw2ddqSn5b7iQ4qmXvQqPljYByOSoXmqyGkn4xZQ0
	 VB77f2bMSfgg4YjMBoozQHNatUJRSQfyWnGO9O2D0mYVjS/+xjPnv0/hsiCbDy+EpqyQS
	 4NcWNixupRZOhhh/X7XC6EpFFG7B+YXVMz8grm+635P3mLy8Nx3smxo1f40USRzcp+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
	b=LKCqw215It5235W/jr/brFcr0tbFcfpR+KBzgy2iMmOHPWkvVbolMe4AWWVCsdbtd5D9
	 zTumrdvIIU9JToz6hGRTlQI2KHA+9cXOMhia3zW2zW9WmwcQ7edK6vzlbbeVdD9ftbTLO
	 E53paBtRuVshPR9JopfvQ5Zz7T6wy4Ug43sx9raLsVBu/GKnxTxtK6tWfuX716Hctngwv
	 VFlyuJWOAr5zu2b6n7h4St3qDUpI6GiKdHUTrdDDxL+YJcqNcSnpn59Zl6Yk0ypNFcjGL
	 iWrw2guVd1fHLDFdB2XiyylCL4mjp2BFVkFp7xSKvmvwwZivhYRYkisZKATnYQKO91A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8gfzGoR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3711606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3711606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8gfzGoR
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so2261331fa.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793327439; cv=none;
        d=google.com; s=arc-20260327;
        b=IrpdR+n5LaBup2h36n6mBnDzGWpqQElaGDWtH7qIOQ+WS1opE8ao0oKTr+MAARnZJC
         ZtRt5hWcsELuRhzLbs7hC8B5p8If2luZ+5kH+dScaD0eCRBAo6+0jvQ5HQaMdnGd0bPa
         jY5sssMpbVxDBJ+tOcCiebpNNKL23frw4spZrmKLoNswiQgrBCoU4Zg/45eTyhzcK9G7
         MXcok6WbmffM5cOUi2/PlPGUE80wzptCVxhWjzOuKaoPaaE36WoF8od1VMCF/E2fM0tS
         fU37N4W5ljPWJYSr1X/fos8HegPccpzZgL/ArbRqJfRPKZPBJx223A7KUKPP91dk1hRN
         iD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        fh=Ixukas01hUJN4ZnSLUFgFY+51DfEFNO4SpNsUbq94NQ=;
        b=V0FqziCWA+cd4URbBNiExR/AXUmFN9EzZh8aWUgHFgLpfHEHshJQSY1HJK6AtfOpXV
         9tJyBt3byKlZkEFkbje0uoyv5qEEUyKrnmrmYkkURYUTvMABmnFESpqLTqROWaFAmiRt
         NlBNJ1/+bvo75xegBLJg6LuuNla+wfRzzusO4f4CplNdd/0/pv1oh6Yfqt64QC+pMxRb
         Oo7Pu8MFwuVaTvHmdNQq5cbw986Q7DaL+3UcV0u3ccY2V67un8FfKCfMM/aqoOumWQd2
         cffihhk3yVYGzP2uVZaR6n1I9bc69bUFdjJOvnu6PTsqnADZierc+GGwyBQAkB/LlCww
         ww7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327439; x=1793932239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        b=e8gfzGoRM385FEsKyD02HVJxEcPcs7T3QOF/fJWMMm30PlbFERmKncV3Hstqsx2052
         lf0xfBvCVoO5IbSgaLtFUi3IOlIFZz1uzqLANxW84fUcWsKuv/UhGHOgEFLFNpxKSITg
         iZr0fs5CcKrN13lt42exXW7GYdCcJsaFZq1uGXQ+jrn6ASA4gprfcgsdP4KKcpG1aYfU
         C+NMi78+7JV7NTPtMAWIFI7q/n2x8uJES+rD5YbbVVnNBM1jrYwFbIqfjStrL9BYr9jO
         zsfza/TSP1s8HBRuKorim1idzGf7awlWuP58iN3WCOzZWQE5eRHJv9Wta5sLZjEEvL0F
         LSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327439; x=1793932239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        b=IsB2N6dl9AJ/WbUuVpb7u3t6XEAz5YS/Ew4/JIoas4E8fvH6GzmorAPH9miljFIn1K
         v6ZGHTXnrZzY/brUrm3TPx0sVMttEJL6N13f0hFhbFKtqLSaXXvFQnxZiRnEyx6xdceX
         DE3sbFkoNHan+XKOB6+zDrsL9MbfFp8WmF+qVTbj7GjgnzLSjbz7enX2CAmhjHwY/Srg
         FQanYy7tSwWLJNNXsIvQqmtS/Y+0f/i505k/LPSCtpZw5fMQNdS7ATcQ2MevcfFwAakL
         5/4BQMMas3oyqX/w/BQQghGp4Yo4Ebc2x2u4T3Un1jpOMMTY9UMWNyhF8h71BJ5RRKbg
         KU/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxlxK/1txwyx0LKFXx77tsqMqJnK2arfQU2xIGVQ9E1AA11OpPT+6mdW+zxtI3t9dz4fjmgNhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLI4AnMIGMvM1hHSRZ7h8tbNkqu2DtXLwF8N7HIw0294gs0lCO
	DbpOxd6nrY96Ftk77/SBlSNXpOD7Ol13dFo2tpPYc4AkC+ftaEBi7dR9UTgJVArtLnuYlcSTngI
	Sht9YeybK22uAkOnHCUsMCWwFQ6+cqQ1Sn6sqi+c=
X-Gm-Gg: AYBFou0yZ6zQngkHRxo2mZzyqlCZ4V7sAGpNOlRT3eBz2txzzNbS/AMzYUyA1q/UDr1
	VC8gTiYY5ZCNwtl6dVzisPCWTicKFprDrOLgQiWBVIwrWcrWnrW3mXiwbbcMCtNs94IWas8psU+
	G7WNPiUf2lyV3nPQQPXfScSK+x1RwC9OhgQIP62TNnlAxVTo/mPulwmr+HBj2kjlBni1zdApUBM
	pDNw5I4pS8nTZqECxYhaHRO/P1ga/Akm/2rNHDUUXs91wbNNjGxsV6dOB0ghAkSH8eBV3j5RsUk
	32aK3hbgacfBFiMgnnegoK4UZnG2f0HbiuIklUALi+769GaXKcbQaTvIMZz4+oU8SJvWjJUvPqr
	ZsgEjond06pj4fGUkNjczFf5LJRSk8q3G3a3nWrMClmWvGzKcHcXo1UyH06C5+5AIndiE0Ifh7k
	gC4Leyk2NUOtcEFYPXP5z0z8PackFSEbQC2jNHb96uN9qVH878Kid+EA3KgobYUOmyBvakibC7v
	/BEm8iYCvaN
X-Received: by 2002:a05:6512:2251:b0:5bf:cfc3:5954 with SMTP id
 2adb3069b0e04-5bfd954b9f2mr211780e87.1.1793327438692; Thu, 29 Oct 2026
 19:30:38 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-2-testwrzwrz@gmail.com>
In-Reply-To: <20261028025026.11401-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 10:30:00 +0800
X-Gm-Features: AclHuK9V4fvZWJ4AFY9w_N67m8fmBuNScc36Y8vzCOEgxwll8I8B9GuAiObXkno
Message-ID: <CAL+tcoA0jyxR875KocG6fwNSOPjfC-pdhJt0xCbsDQMtiNx8qQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:50=E2=80=AFAM Rongzheng Wang <testwrzwrz@gmail.c=
om> wrote:
>
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added =
to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
>
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
>
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
>
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/xdp/xsk.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..aa6b010192ad 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
> -
> -               if (unlikely(pool->tx_sw_csum)) {
> -                       int err;
> -
> -                       err =3D skb_checksum_help(skb);
> -                       if (err)
> -                               return err;
> -               }
>         }
>
>         if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> @@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>         return 0;
>  }
>
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
> +{
> +       if (unlikely(pool->tx_sw_csum &&
> +                    skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> +               return skb_checksum_help(skb);
> +
> +       return 0;
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> @@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 if (xp_mb_desc(&desc)) {
>                         xs->skb =3D skb;
>                         continue;

nit: since we have 'continue' here.

> +               } else {

How about removing the 'else' branch to avoid unnecessary indentation?

Thanks,
Jason

> +                       err =3D xsk_skb_sw_csum(skb, xs->pool);
> +                       if (unlikely(err)) {
> +                               xsk_drop_skb(skb);
> +                               goto out;
> +                       }
>                 }
>
>                 err =3D __dev_direct_xmit(skb, xs->queue_id);
> --
> 2.39.5 (Apple Git-154)
>
