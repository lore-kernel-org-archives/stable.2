Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794838453;
	b=LZJ+tGBhnofnmOtYIcAC4oqb3zhzsfMWYFpIeo+No6yEYHFM7MrlmZXzljQYgu8FSnNY
	 Iyo+ikrYkw2YU8XQfJil6qvApYa3MP3hsQlo7DrXORgk6vscM/qorYMFO2mO0ZtrnTUrX
	 swzweZ7pX0jb5l3UvJANxPKn55TQv3g3Pz+5HlSdqtQ7vNf1BhX6gVCvLghcejGcTim41
	 cBscUcyXaWE378wW85zmYkRc51R4Eeq+TNzARyfuqKz7GnbP3nfJuCPto/dCZQhT9vyTH
	 yejzJ0TitdtdtsqPO0KfS8IjRVkAITcN7NFwG27jrVVHaL+dUnd70piIAoTgA+GciMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vb4ZJkfWv6+aUtGCDcEszVkftPli53KYaMyMrkK/QeY=;
	b=TBr/j9OTvfYJBM3NcMjyeWtsNOvKYPbbMtyEPN+VWgsl3IVtrJA9+AnlHbT+ze0xEM9P
	 z4hEipQXFoOyNM3ysxqBWxjEATugojq9OveQ8jEdetXBq3D8fG4LjSBfJxtxuK2zljQH+
	 l6nX2++eyMan37mB89pqGrj0M5sF1sxXVbh3rcpgc26W77rUqTmpLIvQ+nR7yidor0+NS
	 RykFrF6vLpNawmC6L6jyPR1R2zvsQF/YvNV9THWZCVQr+9VZBPLdVF1ALDcCuEh9vYeME
	 fypHi/QrNbij4BlIIAc5WsnQ5Qaw3ogjdvBIqxLNaQsv+1f8FHB0D2cN7WvALA8XKHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vG+CvywM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EEC606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38EEC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vG+CvywM
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b600fae14dso1551029b3a.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:14:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794838451; cv=none;
        d=google.com; s=arc-20260327;
        b=Iauqwrfn1zBSvNk5iTRO/tffoS1Zg0YERLVO+oxLhlcNh+AvvREQc427HHl3ALF74s
         f2MIymGsWm5IhdnaA16DUF31Pzvb1to0IQrv1/wECHoh4owM5p6RnONsVdO/jrTeIMkj
         Qn6SWauIpHvX/e+0ra6H6NeBagqWAtB5yHsHUH72bWiwg2xJPklNAjfUBESA45CBJU3Z
         j/2VhoV5DPNMJnleBYe3B6pzksd+upTiiysjTrD9V0Bzt11+wtYdBo2YgNicFzqyXxVr
         O9x7hTMf5pAH+YkATQIMtJICi8EzDRsUPMNGyKFszk6ymLBamIdlAEGXy6m+uTzQDdjz
         lFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vb4ZJkfWv6+aUtGCDcEszVkftPli53KYaMyMrkK/QeY=;
        fh=kp3mlbkEOCbHu4/StUiH2ceZRNvOQXWgbyuy2F56Ucg=;
        b=ruBaYnjy9poQv1R4xdWOkMBj9ywV1UeDe8wqqFthfZpsaQN3oawyUwVsFMdjMbqUfO
         smyuuUp5Irb3v2jslgdWk0Yj2c3vevnBRl4S2y/D0idpXcL2v1zNp4JX9vPYtnlCdt2z
         vTKZwWTgtMNnnUCsQAgqKkw6WW/ljDbIm30eNnEWCC6qyqwlSIEhgWAJpIYspQOElvIv
         tiAGIXrz2n2fGmrfQrkMQ3LmOdVdF8qJwUY4knpwtqYDlZLwrbeeOYl/jDpI279j/5n6
         WVNFOtZkH97G+FNuwKHAuqBbCZlmsgR14OMY2Rr5v8+duStAtiq2pFP+qM/HuE8QGCdz
         eK3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794838451; x=1795443251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vb4ZJkfWv6+aUtGCDcEszVkftPli53KYaMyMrkK/QeY=;
        b=vG+CvywMm1ldTXvGLhdGrQ39Y1Mc0sORNZCeR4GJ1dLmKEiARwnhn6ElkivHNtn20u
         MIxt5M8bR7Qq0pXOfhvZgdnaVIzPJxi26+/t5orEtQJWPon9vzvfQwmZHPVT6HsHgswG
         +kFK5YQE6ZXGfOos/BBLIpBAEQ1G6pydqP4r4yb4imRlq6Xw6pmghrK9qQpJTaHLU8Si
         5LBETHLbSgtbfKTFp33L/Fi6Q/43vh2ETPbSiQ96Mu2rmjYlqPWhEUvkJfi/fmMGrN94
         fDfIoVK63qyENq4WmDq3kNG/MuAU50ixMb0BmbvC0NdIKa143YZt+16zHk6b3fcjOGYu
         9N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794838451; x=1795443251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vb4ZJkfWv6+aUtGCDcEszVkftPli53KYaMyMrkK/QeY=;
        b=S4LhwcFY1pLn/o/zZuqlh9Q44K9t+2qI+TIeQohp1fsHdK1YyhUQfFdqWJbqPeng+i
         FQaKOq3S4an6BKcIPcJ+cACIVteiKqSfor5fqrbJCZ73OSun200odiUjK3hhYCVgFDlY
         WGbd462wYYe82PSHjjL6ClZN5ykxF+QYnJlUS2AEX7SGqmn8mGLxQn1eP2rXT/NXOZH8
         FNWIV+oMNL3H6xPQiUTUVUWZagR9fODi0NXtkktj+gvX8M/0c9vA42JR4gmC5rpd96HK
         l1W8rdyiDjAuLF4+CzscUHhYlhBrCYH0cYgnR7fu43elTFeauc1E1ohJZVm4B2Ppq638
         KDDw==
X-Forwarded-Encrypted: i=1; AL+hErHLsXzZXSjoOj5tk6t2BayHkO0kOeUZ/Ps1nJd1nIa9yJfWdufO4gYrW6o1HB/bE+g5QFEAZFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W4i7cRupjWDDhknUpS9S5v1AS2JJXzG4nbF12hWgcVKWabvw/
	35zqt7R2YTaOfApE+f51XqBgZm/1yxeE0lxbQyjrkqsNGpg7Ktytg5SADEGMgsgXruOUfFutKNw
	FEQJ1RiChIv13/lS4QXFjq3h6xzha75Y=
X-Gm-Gg: AYBFou2cEj11+dxsW2P4k+WeYSO34TxmQ2qervoetM8y0GadgnAR655LYLNXfYY6z26
	1uRLURDCnXIsc3DLnM1YDQdaKr4e2vICh/lfJbZD8R5S2GcihPUvZBaZ5s0ecGrQvUPut0UnJlB
	NsUasfeQGfz6nLBknJHi4u+Cp5CJ5MwLtPC+OdbecSl+xjKx3fqQY/qdEZgWsOyO2Z1wie4NxrO
	YDOe7t8BJVsQd5Cvj/wyvjomuXbn14q3Ti7/tO//0xRobg0EZMgqD49PaHRMA9+DHAlGP/yHZms
	P+A95PiNIkEOXccyuP/A+GpLZe0wuH2Qb3bRcZmWxinOWmW0EkKMlUmtm0R8ZtH4f/62Z4390Ah
	tH99XD5rjaZOrIJp5CXcds5R+Y1IVCbi/DIUh1O9kTekXP84SnppBM7/IiyDeJ4HyK9uWQS+St8
	Us0UCJXYI/BISjpVZUzrrnkffOYympxtShGCVK
X-Received: by 2002:a05:6a20:9191:b0:3e0:dc12:8908 with SMTP id
 adf61e73a8af0-3f7a8dd95damr9049521637.81.1794838451265; Mon, 16 Nov 2026
 06:14:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CADvbK_daN6zZNPckkGh=r70ooNwTz59VViJy5jPp1w18SDPrzw@mail.gmail.com>
 <20261111082313.1606366-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261111082313.1606366-1-bsdhenrymartin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 16 Nov 2026 09:14:00 -0500
X-Gm-Features: AclHuK_PBS5DfVRnFcTFsg2uR9KLfQjm6-Pkb_EVvsTPuHEoQpl0gvLNWQC5tqI
Message-ID: <CADvbK_dKWmcM411yC6ZKrYtduukEL_aTp3Bw0XdkqOd5Tn=sXg@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: fix skb_over_panic when adding addresses with a
 pending delete of another family
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, edumazet@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 3:23=E2=80=AFAM Henry Martin <bsdhenrymartin@gmail.=
com> wrote:
>
> sctp_make_asconf_update_ip() accounts for a pending DEL_IP
> parameter by reusing the length of the address being added. The
> write-back side instead serializes the pending address itself,
> with its own address family. If the pending delete is IPv6
> (20-byte parameter) while the added addresses are IPv4 (8-byte),
> the chunk is allocated 12 bytes short and sctp_addto_chunk()
> writes past the end of the skb. E.g. on mainline (05441d697f7f):
>
>     skbuff: skb_over_panic: text:ffffffff84859c77 len:392 put:20
>         tail:0x188 end:0x180 dev:<NULL>
>     kernel BUG at net/core/skbuff.c:215!
>     CPU: 0 UID: 1000 PID: 379 Comm: poc_sctp
>     Call Trace:
>      skb_panic
>      skb_put
>      sctp_addto_chunk
>      sctp_make_asconf_update_ip
>      sctp_send_asconf_add_ip
>      sctp_setsockopt_bindx
>      __x64_sys_setsockopt
>
> Requires addip enabled on the endpoint (net.sctp.addip_enable=3D1).
>
> Account for the pending delete with its own address family, as the
> write-back side already does.
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Cc: stable@vger.kernel.org
> Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host=
")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> v2: move the pending-delete accounting out of the length loop and
>     drop the del_pickup flag, which no longer guards anything.
>
>  net/sctp/sm_make_chunk.c | 16 ++++++++++------
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 90de272842512..b8e4db81636e2 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2870,7 +2870,6 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struc=
t sctp_association *asoc,
>         int addr_param_len =3D 0;
>         union sctp_addr *addr;
>         int totallen =3D 0, i;
> -       int del_pickup =3D 0;
>         struct sctp_af *af;
>         void *addr_buf;
>
> @@ -2885,16 +2884,21 @@ struct sctp_chunk *sctp_make_asconf_update_ip(str=
uct sctp_association *asoc,
>                 totallen +=3D addr_param_len;
>
>                 addr_buf +=3D af->sockaddr_len;
> -               if (asoc->asconf_addr_del_pending && !del_pickup) {
> -                       /* reuse the parameter length from the same scope=
 one */
> -                       totallen +=3D paramlen;
> -                       totallen +=3D addr_param_len;
> -                       del_pickup =3D 1;
> -
> -                       pr_debug("%s: picked same-scope del_pending addr,=
 "
> -                                "totallen for all addresses is %d\n",
> -                                __func__, totallen);
> -               }
> +       }
> +
> +       if (asoc->asconf_addr_del_pending) {
> +               /* The DEL_IP parameter is serialized from the pending ad=
dress
> +                * itself below; account for its own address family, whic=
h may
> +                * differ from the added ones.
> +                */
> +               addr =3D asoc->asconf_addr_del_pending;
> +               af =3D sctp_get_af_specific(addr->v4.sin_family);
> +               totallen +=3D paramlen;
> +               totallen +=3D af->to_addr_param(addr, &addr_param);
> +
> +               pr_debug("%s: picked del_pending addr, "
> +                        "totallen for all addresses is %d\n",
> +                        __func__, totallen);
>         }
>
>         /* Create an asconf chunk with the required length. */
> @@ -2917,7 +2921,7 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struc=
t sctp_association *asoc,
>
>                 addr_buf +=3D af->sockaddr_len;
>         }
> -       if (flags =3D=3D SCTP_PARAM_ADD_IP && del_pickup) {
> +       if (flags =3D=3D SCTP_PARAM_ADD_IP && asoc->asconf_addr_del_pendi=
ng) {
>                 addr =3D asoc->asconf_addr_del_pending;
>                 af =3D sctp_get_af_specific(addr->v4.sin_family);
>                 addr_param_len =3D af->to_addr_param(addr, &addr_param);

Acked-by: Xin Long <lucien.xin@gmail.com>
