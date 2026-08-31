Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E03E557D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177582; cv=pass; b=Lld3mofVqRCCCHMTkUkXmUEkdh+j47DxdZiHQAdQPFHI/SUylwTnBXFK6B15mzA+BbVjdum2ZXoODCAgHwhOZrxRfcxyYY+RSc6OPAfVeXetyv+AyBfghp6zTeIFSe4Kscj84jzFag9ZnuIT8jbXd/v/2nBZEks1ZXKkQOj2724=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177582; c=relaxed/simple;
	bh=XtJMReRayz5u01/Y3Wpc4UtRjykDXRN/p8mH13avm/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzJXD40RxKwlwnrj+9L6U2Bb5QYtoD6cOvjgvSLzC8YcCuWVKW1jlHg42LOVIAs2i5ykCEmRw0LgzhevSDHOmNsAhrpDXbpm1k29kLA7nsp905NdH8+XcZY+XfFPrc6+J69au9zQkTmBR0Y50NnF5Rn76ZXUZh38UhnGTLzzML4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPMM1WOl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sx1kT/tq; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPMM1WOl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sx1kT/tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788177580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpUyKt6NKpZOqi2PHbUzsqSHu/r4oFmeIS7Q+YbCn84=;
	b=VPMM1WOlDszFN+NJTD7yNg91r6VrHLTvh68mZrUvUecDfWRngj/EkcY+moVb0XntKngsC+
	oH7ZV81YofTgFXwfUaPfIceYdDHevtgUYRfGNnmuhw5+W4y4OKCPqO6KWgce3bdcttmqxW
	FvOVHm/Rpjtt12pRCwX8wbXUot7bVfI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-tDrNhAm2Mzq-Vy3VNE4Bqw-1; Mon, 31 Aug 2026 07:59:38 -0400
X-MC-Unique: tDrNhAm2Mzq-Vy3VNE4Bqw-1
X-Mimecast-MFC-AGG-ID: tDrNhAm2Mzq-Vy3VNE4Bqw_1788177578
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-853a9c4c99eso63760147b3.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788177578; cv=none;
        d=google.com; s=arc-20260327;
        b=A8cOBnN3/fu9mPB9gs01fgHZajpA082Ub23d2m7HL1fXaXZdcPrZAgs2yYtQkjn6Xt
         7D0eXgYGXEUZ+Hi/RmK+dj/zcO1bHUnvBmDUC4uHeXTmNr1KFgtCzvO9221vuGfrx40m
         exqsouEO9vBLb9GhxDSYMt8G7lSsD7JtvYrjIgpv+hf8bAp5eN/H+6ZAYgjDXTAcJA3f
         HXGplALD3M9KxnDpcAcTlTOIYZMqyWW5QyhSkXNTH4TWOCPPUEOqy0k2HgzXSZRUWE9F
         pwGolBXiVsmVj8NMlDZssJBrL4RQWLx5Qmk3lqxMilVjA4MFzQMJpyNJ4FgN+9/yv8kh
         cSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YpUyKt6NKpZOqi2PHbUzsqSHu/r4oFmeIS7Q+YbCn84=;
        fh=quSS6s+6h1fj8cVpzaKTWGwNIZ9Q6Eve2iB1PzUBPes=;
        b=O6ue3Bc04Gav5Wvl7Urv6sUIj6ylNELj9IKyBdqAuADnBqtE7w6SU8DUFIh2I39nD+
         b0V7zEQL5bykjeUD/cbzxhLGQD/iq6XGTLw3pA9rWhl8VqsTBjM4YPlZJTC6NCLviJfu
         Y/E1tPWDW7AP6i50JCMGgu7ExWD9p8j6aagDW2bCSPFeav13le84waRfJ/FgOL9QZZH/
         XC3lO/vgKj+59CGUi7moeNRt6bxgsd553TUeM6BYUlBRaGcdEs/JAOORV7rREWY9IVaQ
         idwoW8RLRN5JemQidTbn+Jul3xNAeO4TcaS2TiUE96Bl+5SZU4zBf2O4j+D6beObCqSY
         Lc/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788177578; x=1788782378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YpUyKt6NKpZOqi2PHbUzsqSHu/r4oFmeIS7Q+YbCn84=;
        b=sx1kT/tqH8TpCl6dQychTj/7MdEv52OnsZWhIUWz3B3nDqsg+GSzf0S4KBWxuGZgHc
         w5CWP6n26rucYr9XldiLqVPn8YvsrB4jQCkopd/EbqLR2LTOrKHTythYyptYgAd1nNuj
         FwR+q4F3uV8f2MZaqAMwF/uwNUrzVuwfKpQIxzh+DaFq/2Ts/naN0FIJLjbBBeq+8IU/
         pDoI5kVAk6AePueoIhrdmUOFyObp8FMOAj6jOioHft7sCNfavKev176KJpJ0DFeDSO5R
         nJ0GCI98E8X80uAfI9yq10+sjxSI3tG6TQePvZ2FMTkkojoOuRaYgVQKTCw24XPrSHMM
         uBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788177578; x=1788782378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpUyKt6NKpZOqi2PHbUzsqSHu/r4oFmeIS7Q+YbCn84=;
        b=sOWXewtwUueV7h26+OvVKSwfdlvA94YfJNV69KjPaa3pOHZ8NeTiR/CNhv/xYpg1Jy
         udcXwVWOB+tb6X3WjSabna/hPy43+WsVMKLwaIkKBgeNTRymTdCvGy82EtCS+7WtNFgn
         gN4FA2uqYcKEJjt2pg6EnUqZbCY/aIBkCMnpf+Aczd2aRiwRf7/XSnPTTwxuPwGkjFBt
         XqVwwNPOD99qw35M5yWnEQVuSwRJJwU3lGnpo+SU4+qhT5XNS5ta2XnfAWBPlGRvVDlN
         hDy2OtGFvjRSdp7lfUxAln3NZSZWPg/5Hj7u0d2Lj/X2CdZYtqZ12sTpgijGF5iF5g9H
         wZ/g==
X-Forwarded-Encrypted: i=1; AKwUvBzghLbks1/E7w5b2vCbcTnX8GiPq32GrV8FhL5Q1kyRM8GT++bSnQQTUpx4e4WgQaLw35t05NA=@vger.kernel.org
X-Gm-Message-State: AFuF++mae0O8hpptoHPNIXB1tm+s8c8bfVPuBMXLeiCX1PceKHMcOTR7
	pKQNqkYj6NRbFFYHHxHLe755AbYijHNe1FWsXoe2D36KrQXC3jqYPDhp7GnihzSBPBdR9n54T70
	quYOfHW5RWcjhdmC5vDlfYPHy77/zwJTKjFuiUfd51Mdaws9DA3CJQePGXpIeF9aTulluEvmwLF
	5S5hnH7JIEzc6gzpzaAf3W/Y/6r41o7Vsh
X-Gm-Gg: AYBFou1ATLtNOp2fY+RXasKSglG/QU+aP8DxHhM5LLT0V7tZ2SA0Ga9+7wQAD1I5vzB
	MrV4sSOryxOkFo9VkedAcLnASX26+Si99n81fMCTWKHQp2Gef1igE7HKoYXln/cFYLrpEcRZIGA
	sMY7lnicb8BQrjDNvTIFavS2XU1evwKVpjf1PWS2YH4KATQOauuVN/Di/+R96wL2IQLoI4nE7Zb
	Nz4gp0IPwo6X3rda95DycVxy0eNk0VUCBMUJBAuKmX7
X-Received: by 2002:a05:690e:43c6:b0:66f:80b6:e954 with SMTP id 956f58d0204a3-66f80b6f278mr708895d50.42.1788177578172;
        Mon, 31 Aug 2026 04:59:38 -0700 (PDT)
X-Received: by 2002:a05:690e:43c6:b0:66f:80b6:e954 with SMTP id
 956f58d0204a3-66f80b6f278mr708883d50.42.1788177577730; Mon, 31 Aug 2026
 04:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831105425.622254-1-r772577952@gmail.com>
In-Reply-To: <20260831105425.622254-1-r772577952@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 31 Aug 2026 13:59:26 +0200
X-Gm-Features: AcwNN1XEYDO6BbANnYdL4InXzS-PGISlnDhdt4_420VqSyNsR953nV8_5jm--Yg
Message-ID: <CAHc6FU7x8J_pPKzbmSJEpB8AbcV1bJuEx5+i0nqMpboZ6xDF5g@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] gfs2: reject oversized dinode sizes before i_size_write
To: Jiaming Zhang <r772577952@gmail.com>
Cc: gfs2@lists.linux.dev, anprice@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Aug 31, 2026 at 12:54=E2=80=AFPM Jiaming Zhang <r772577952@gmail.co=
m> wrote:
> A corrupted GFS2 image can store a dinode size that is larger than what V=
FS
> i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64=
 and
> writes it directly into inode->i_size. If the value is larger than S64_MA=
X, the
> incore i_size becomes negative. That negative value can bypass the existi=
ng
> stuffed inode size check:
>
> inode->i_size > gfs2_max_stuffed_size(ip)
>
> Later, gfs2_quotad may try to sync the quota file and unstuff the quota i=
node.
> gfs2_unstuffer_folio() reads the negative i_size into an unsigned length =
and
> passes it to memcpy(), turning it into a huge copy size and triggering a
> out-of-bound issue.
>
> Reject dinodes whose size exceeds sb->s_maxbytes before storing the value=
 in
> inode->i_size. Also make the stuffed inode check use the raw on-disk size=
 while
> it is still unsigned.

applied with the changes noted below.

> Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQ=
qco4gjdmKVbdURg@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
>  fs/gfs2/glops.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 28f32424ee64..8c5d257451d5 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
>         umode_t mode =3D be32_to_cpu(str->di_mode);
>         struct inode *inode =3D &ip->i_inode;
>         bool is_new =3D inode_state_read_once(inode) & I_NEW;
> +       u64 size =3D be64_to_cpu(str->di_size);
>
>         if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr))=
) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> +       if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {

The (u64) cast here is unnecessary, so I'm removing that.

> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
> @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>         i_uid_write(inode, be32_to_cpu(str->di_uid));
>         i_gid_write(inode, be32_to_cpu(str->di_gid));
>         set_nlink(inode, be32_to_cpu(str->di_nlink));

 Also, I'm moving the additional consistency check here.

> -       i_size_write(inode, be64_to_cpu(str->di_size));
> +       i_size_write(inode, size);
>         gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
>         atime.tv_sec =3D be64_to_cpu(str->di_atime);
>         atime.tv_nsec =3D be32_to_cpu(str->di_atime_nsec);
> @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>                 return -EIO;
>         }
>
> -       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(=
ip)) {
> +       if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> --
> 2.43.0
>

Thanks,
Andreas

