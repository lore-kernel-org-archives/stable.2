Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793341916;
	b=DhztJYrE+lJ/PAL4h7rJGcxKdaX26sON1NmI/pmPT94OfB5E9kh2rQF1oKKWiRJVwXcz
	 zFeN80f/SjF8g1Pm9pU8INcqu68uxzo48l2OTV5L8n6GFLbWh9VFnOPHieGbG2K9kH5Gr
	 Cdw99IfV9bx3Ori7etgt/sNJeW65cs2vpa/1TE0PCTqR9InuY12GTIUTPA+wl4W5pKwda
	 /9wKtUNAOzNl0SnIBcuPxDz1gDYZ1IKGMI8A6P4kv+jsmhFtDzg+gROkdx0gN0Q7rnlZ7
	 UQRk+UOMb7aTIPob3apNrMbbciAsZQeglE2PFbdA/D0/fdlCw0mFHJGetky3d/cn4cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
	b=Cr+NYmRcdo2jAl+rSCv0YGwjwPEnRD/YNk5IIH8R4UKl1W461xAcc6WSCf38Z5ZwtnZp
	 VyjO5rFiR7y4nmWLPrifgujtUcRIWe+/mNbykRFtBTlPQJVjMjIjauPabdFWHDA/mcrTm
	 ftbpgsqPwqXUtjSKlI1wGHKSAC01grlCUQDHNmiUU+7Bx/3QdqIui2XQFiVNI0JtO5uUU
	 0+qy3mBsJRnhFLgHGYZQxN0LQT1G08PRuWkZM3DtLR7Qq+jsx3LSzDatSz3wJKLvb89y5
	 pK1Xe2U61hxmXSR7T+IRPw+Gfs6MjT9FmF4FHqIdcJ0CZ1ZJS3+uWQ+raddgGRsz6Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHhGZfld;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E6606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771E6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHhGZfld
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1044251eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 23:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793341915; cv=none;
        d=google.com; s=arc-20260327;
        b=ZKwF1yXv72EBS2JdqyBoVsyYapfRKhqWKDDpHYbch/BFq6ThbH3NQk9BZ120OJKoCC
         1XOS0smT1DW3/MU6Zv0VVfQtY9swS5vPv4x7VZAPvYcWoP2VA4d3TP0KQGf6luUAfrI0
         F8vqA2b2Acm2u9akFWVPEbFqKIos9gtJn78en7U0FUIPFVNXlpXybtdzGvrL31lc1tTq
         qhKX61mdyBJuPV9W8LK814l91mireRgWZEZbfDr/Nko1NKqJPUl9x+stEtUvWqrKkaQQ
         D/G8H73zlfs1/kdg0pjvyPjblXePK40kvOht2dqEI2DmzaXSSC4RmXHLh3wqibwuMkJe
         vRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        fh=aSVOw2g7BuOc3weX+OTJCXpK/RuUcv8+ue6vMZH9W7I=;
        b=g3+5lnbT2XCrGyudBJO5qTg/wsaprLFHJX/8rZKSopiD59xW90OrxklUr1s+l1eTVH
         dWGw1o5OyWdh0HDYjj/OKDv0156vPvWc1oa9YRTqzbulGCLtozwCtExmKUPDahQWah4R
         Iwftc46l0MHsx1MqeiZBUWMZ8uW+SIsz0Jy0CcBqd3wEnKIarfslTeIEMx+b+QEsseuu
         WNTf08XyDEjsZq4PD4HfHApzpy3Wb68+E4BI3HSBOaFmvGYJOr2KdK01s4mBen8ohNS+
         a330d67hC+3p+LyKUebvJdt7OR4gN8VZR8N57mIoP+Vex3DuspN4jHKYhU+KWK/5IvBk
         Fk5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341915; x=1793946715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        b=cHhGZfldf7rwLhH5KKbJjNDRKRapNAbZx8eScm4G6BCmNEX/trTh3APCkLfh7RB+2A
         cOLu7dpCFuIi/m+jx/yTUFUZMcJ/kJsLk0BeCCxGTjWwhL7Fcn2U+1mjgVSS+5x+MocD
         3qorXUcfIr3oq9+t+uVpP9+qFn8OYOWEu8f4WNt8FwjsiisYzVDtYEsHOQZK7cmuVU8s
         3WGPwDeL6kTP/eAYTW0bJDdrufMyckcJZzLXjlZWf5QW4juLEPZ3WWHwuz41GyBX9HjW
         PKxwgfe8XIQzCbxMVJIXkqmN2gVFfKVlfxMITH16qONvocH7wAlowIOwo20nkYQaUR7p
         pDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341915; x=1793946715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        b=fThjJjJpVr/3TWe/gMbhnWms+inytZ+8nhJHPZsTqh2u221deC112+2SyqKLGga5zi
         Gzed3PEIR1h/DxtQKeI6VFFLOxVK57/IQTzeAx8iAJUmI9xpduKSW71z35bI617Bdz2f
         BhBdiEU2otnudaNTw0Ll4IaKgc5HTiohcvwAyFiQPBb7Lollv83iwRoVfPam7X2QAWDz
         AyHC9GxcN5exjR1dfjcTbQ/rX3jHfaV1Srcxs5BU6+c5l9FsVDbXucgH/4vaF9kduQyk
         3/ogOlB+/3lV4BI3tkc5l5brfifC3bwco3N6u46O85GvsH/9pO+sgQ5+4jeS8f/uMC4S
         bmLA==
X-Forwarded-Encrypted: i=1; AKwUvBxegNuVPgWZlIzsMCFEchkSaYnTjW6RwSOZW+364hPkzh7X/pwVrziF/tJ8mGnQh0vwY6V8Vbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsmCLNRDk2Mx/7VF/cuhM5iy6jZwJ2yMn7HOvUEagrKsdTDxV5
	bs3QGdI4ynM1GKh/R28iviLVnhocogYbYenOQ7/xTzYDM5hbvvmvNueINZhUvaqBbqUZFusBnV9
	4bRLpIzFmyjL3YstpStWoqumCzQ5xnB8=
X-Gm-Gg: AYBFou3A8g5/W6xJh6oBtPQVz7GqzZwkBXA87lCwMlAWHzy0VnIs/6qrNHbpcedbDLp
	lFCxprgZPQ6lv/aSTkoT8FKx+VkwcmoqZ8pe/orwX1B9+BLQzK3XJPlNhFkTidV4lUY0aHRI2tR
	axVOYulLb3uori5drTTKKUGIlUAA1UtQca4tkQX2ctnju2u0g2Ay/6InYkIo2NoriJpprKA0u27
	UvbyLx6P3Up5ivQ4Sjza/LtkwquViToz5N0ye9XDKYCKr/lRuqFKO685ToE+tRKUWbDYhjUOTiI
	V283LpHBmQYHox5i1G8qmEiDKl0YVDiGTuYL+DpMWAdjrAFyVKy2RWQ6/r70Jt12ZA+dFfGyiV8
	GMhkXknfk/Agg7AEkU2bUEHgspegcd3dXKdgpWLPcyqnoYTEitg/nR2eRt4UFZO2VaxS68SULw3
	urQSbzZthqwbj7bmeNIfHQTsQ18rfSASAUioBOKI+KDbiOHlqNEkw=
X-Received: by 2002:a05:7301:618f:20b0:369:fa8b:d725 with SMTP id
 5a478bee46e88-36a42440a69mr2479370eec.35.1793341914428; Thu, 29 Oct 2026
 23:31:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
In-Reply-To: <20261030023248.78802-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 14:31:14 +0800
X-Gm-Features: AclHuK-3MmLI6pDH5EvsdDyQjqZxLAj0eXtw9LqREvrfIl7g5xpi_yP0zHn6NUo
Message-ID: <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:33=E2=80=AFAM Rongzheng Wang <testwrzwrz@gmail.c=
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
> +               } else {

Why are you still using this 'else' as you already posted a new one?
Please take a look at my previous feedback.

And please carry the reviewed-by tags through the version next time.

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
