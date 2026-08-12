Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C4270EC3
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498645; cv=pass; b=fIuFTAyhHChdy/lMhy+CdqfWhc2yGx9V2eJDTWYb+Uu/BmNbs5c8GsxH5qA8TIztUwTncKHrADHOM82wUGMXEApDfHUlcdr53/RTR9LaaNpmEUs68wN7ikouGoxv0ZdgpVQjk6ohL3ctly9Xu2A+sr6xJqpwH9rJxxhmsX6xCQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498645; c=relaxed/simple;
	bh=MzM5oOBWe2rVVHtSNyNDzjdpCPZ3ET6tb4EqIDl9rYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0uQagBbkeBwyUsJhH4cTKMK3EVFVhZcmY8p7Y8YRdJfrDSZflozjF8FP4YGMMgGQjcKwPqdTI+hK37tZUuieVkBM6a1PksadAoEnokYmYMOq71j/Egx3aTgSNh+CwPlA5P3ceSm2ZbsKqYNicBWRfxXGGsubSBQWiOAFifn+M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAyWgk9F; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAyWgk9F"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15b1da6b82so44823166b.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786498642; cv=none;
        d=google.com; s=arc-20260327;
        b=hoh4fCuCnOUf6sSWt8hs4EkNOwsz5V9S+Wv1neKGMcdguyQf+L5g6GPJACYhRT3Foi
         I1RobZiao77foj9weXNSYf0Ck/34VtdZrvj+hrWL52ayHTQ1WAKweLAzIdGrVviMzpXW
         WozO+PjI5S8UwhHHquITPqkieiN0zpG+j5lznLhrkKKSsbmpsrZBcUj4ig2V2WvVpHv3
         5xBT61fklQMnvT+0YZJR04lFAqP6H5jujaQDM7R09Jq9OizyV6bXUCTrX03xG/xNfUQR
         PN0XCEDZFlUkInnfcsKz+hlxv062VieUtEZ7FXeqm8Xy2izf73mxMR3/MCQKV5ALJGVt
         fZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6I6ES+poJdPEE6jca90KgbmyPtxCPdFVXMB03i5vsA=;
        fh=zy8eeVoNlnXAbCJiCh60gkiDPgwmeK3QUv2TI+2eaiI=;
        b=GqENTtQnqapst8UNu89Kh1IIYRhpCPKghF4Xd3xWqlw9GC48NiYyxgUMeZdYIo+n+H
         kMpsdR5Mb77o3FOWHN+lG35g7XA3uWRy5wns4iGpJlcwI6RYpWzBs6FVgoJSASDHfzBc
         1IQBHP51cGFRtoWM6w/eg6VYwBPjDShJsJJAiWQZ7sukq5qJfAR5X2U2ORKTTA/1a6Cy
         3tN5YRnO7yrZlHlMXSeEkAQAH8hBpkMZtYPF0uVbdw9/vka8MSv+aWA1VvKquzK58/+c
         ynsVpZfzPWLqCSXZ16I6g/kgRSqfpOq1r16dUkpdpUDSk7ZlAgzw7cYc7ZiZkgu4icbc
         3/DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786498642; x=1787103442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6I6ES+poJdPEE6jca90KgbmyPtxCPdFVXMB03i5vsA=;
        b=XAyWgk9FdGfWJj2sqmV/CX7MYDrICz2zlZt5/TmPUfqFZoHnqALXtx4Xid+revGEuI
         DLQ1fLFJmHUwUo2oaaSaMkgOS5Od3bhIvb/nPh6qbZy5uPam7AUZjjJ2yezEw+CfYRVl
         F288CfM6kKYugX4TQwc6EMmoZY3Za1KB8RUe+lu6p8uutxetHywBsP2KCr/ZH7KC+U4m
         gpoijwMXOygDPgT/3ffsXs1WNCeDfe46O8uFb5BUh81+00pnMqWKR69nqDKNvDtuYMDi
         1jmCHfsebARDNbuifwyPuOwyHCmnl4j3lTUSu640Vs5BQw89Ws54jM6Q2Tf8/yGZThC1
         CGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786498642; x=1787103442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6I6ES+poJdPEE6jca90KgbmyPtxCPdFVXMB03i5vsA=;
        b=WGkEIXSEqzE/6FhC0D2KNhzIoZDQWzPjcmukTXd3GocE3CReXEYBz/wcloyvD5bvp5
         DVwp0efnqk2lkMloBOViPALo+5y8RZNpKzPhX7nLRliuOooaRyhRhsS+GJ9NeMsmvlEk
         iSZQcBBYA2x/RCQ0OFlmfNAqXX1KbUg+Z0WS7o7+Xf5ZWpqPMFLgqPs+C/J/5+df+9EL
         bcuzkmYJUfaQ38+9lpYSJvwhtd21Alslx4XeY/WctZx8HZl782OCeiDOm8HiruLJ0/W3
         9ob2Oyv8SBkJee8lrwxoqHpphphCTRT6ud0Bl9n6Dq4Dhyl7uoFzlT2UbW92VIeJR925
         yVEg==
X-Forwarded-Encrypted: i=1; AHgh+RpZpHtosZVwZbG+inRBonmUmLpW16OT0+XAztqWoiQwI0injT6tnAfGvfDXURJIhJwX7ep6Zt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJvyESre3br1SqoVThHNCp0aYMRPk5bmz2ft7unQO5SIycubB
	HB3uCKwO29i/mRjdRerQnG7CZ+tS17ghVx+iJ2JdbMiKpfbWX13rlKnKtokBOjCH+d5qDD72hNG
	4xBz4AwBrh0bf4ceQ02gHY368ok6AGUk=
X-Gm-Gg: AR+sD13vfmkpCEM235gdASGmHlbNChtNRpd1eLNHPdjNofFfVKUIS+Hy3t+/Ot8hDoB
	VZlgwuZ5+INhPmkxSmSAw3Aj+OiXkKstvVyVQPXuzZc0LBggvPTT0dJkkp275f4LNwLicMFixKb
	nkVbwWZ7Ey2fQoN6fZhjq6f+MEh4UeLOR5LYCiPt2s0KMmNybAe3ggRcCJoZPG9eDWhU9FyhUdq
	tMdUkaPR47NN3i5qEG+5dJDJz3LTsCZ/9k1BqKPJJtpLgS+Y+uCutOrnFzgAqYgQhxZiXxoxTML
	gkQPmbqLh2NXP5TaXvGT+h3EGBKx07OC32fqiTp7msYfA1diNlrbUfcJ
X-Received: by 2002:a17:907:a46:b0:c20:e709:f944 with SMTP id
 a640c23a62f3a-c20f30507c7mr53249966b.27.1786498641287; Tue, 11 Aug 2026
 18:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com> <20260706180003.2124317-1-r772577952@gmail.com>
In-Reply-To: <20260706180003.2124317-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 12 Aug 2026 09:36:43 +0800
X-Gm-Features: AUfX_mz_sFTQ_X7muC45bcq2GPZk5Ug0Dk4RTT4P57_TR_B2GxG0kXl_LxWLo60
Message-ID: <CANypQFbv4bDaN1eF+GYsHfJmeau_4d8fc=THSNq-rZNtqk8i-g@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
To: anprice@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:00=E5=86=99=E9=81=93=EF=BC=9A
>
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
>
> Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQ=
qco4gjdmKVbdURg@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v2:
> - Drop the defensive unstuffing changes in bmap.c.
>
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

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang
