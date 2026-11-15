Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794742998;
	b=F9x28ojUGJ2xhHGmgLWOPNiH3ysIcOji9wX8OGOqtk/m5feZzp7frVh/vzZaSN1h8mHu
	 0ecaab1O05uTwGVpCZmTUmQm3652TOYmzp9vs1o3NOHXdjbhc7eYx+quLf00g7uDlA4ge
	 XS+BzwYVMhalQ7O4J9PGohniUIecgEeAHXhbMfb1/tMecISsjCtRwOXApHPQKFlhY7z/O
	 K50SONo1CZMY+JTQ+5ZGeVRmh7pruWHGpgUcU/BDzAbOxxgGZQfUK5Ao2vXkldP7xMJxC
	 d32jA6K3M/YA4FEJnciniSYJaW2HMLh24YNaGl8+yckB4A+aGnC06vw65bK+Fp9fxTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
	b=5eeWoDKYkiQtRnUkArCYPcDJyxHSYBKWDFdS0qeT5rq8IaaNTMJZ7lD4zBLyXz1z2SMq
	 H9SyUvTbbshFT73Z9JM/Wn/cdcDiWavcJxtBqCJ/+qaGQBlVNCZZB+YQNsY/D0QxwMl/0
	 Canwo1sbFsthlp4olYB5vyS7siVbSvzDqQTlykeT3uOmXfGI1mfJ4UOVRybwD9QbTrjbk
	 mYH5INPmPXt3+lvShezFYtX9kDIKC38IC/sSdWkU5GJ8IIti8XqevAQgFAYHcav/SCq+H
	 f0ECw6menxl35SdEFO6/UTWTYsyVOxpFOimxnP5AwaZB7yT+KYEGR0KmsF4wxLbFaew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgMq15ZT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C76606A31E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 11:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C76606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgMq15ZT
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4697404c2bso351326366b.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 03:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794742996; cv=none;
        d=google.com; s=arc-20260327;
        b=gA09v0zwXm+Xw2hnnD1Dx5Vmp4EoYQUrtcPWSM6xOQs36NMh9T9yjxFeLRht2+3711
         ecUH7/0fBCOECx1MDu00cQ9ZIVcTfUyjsiTrBXuwVRsyExQxIfhiKLVFkUPj4RCDmYde
         VHxkGjLXuJWoaqp7jisGCAW65nm8C3HPdm2w+s7yvwc0Op4kx8rHiM1eP+8SyapYCzl3
         mPEnhDiknGfd1X7nyNaoB+2MAsqhaCLp/RpxhOpQ1EHiVI3U3iQPKFIWfeqM4FZeDyy5
         xnvDLmaJE8Cy6Xp/JMCsfd8SsLbTxbkqEFtLlf/JmUbxuWGC2h5sSOvqFmN6BZ/qIzsm
         gRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
        fh=PVCn5P8CksEwR6ix2H/RHzw/NmG1xpCEqnlkKOb3zYQ=;
        b=rRBOHMEszAZQ1FHYBdNGqGk9qsqI7ohHQJHyfSTfA7gNMo6AX6Rd2dNyZIA090AIHP
         0EoKw3OBgNeAfUyB2VLgQRG4e4OM16NWK94D9EvTSepJMHSMFvLA/E/T9JKz/VINyODk
         zDyZzHDnvNynoZVjlL6fNR810GARa+uDG7FrWBhOZWypixvRitpf9LdJd6l63GJ+BVmH
         bzX93AVun/ndFuLrPBd6wNNKIXvvG/R0L/RF64X+PHpZi7Y2+jZLBNsNE7obfv5fhWTF
         v+mj1pLhpcdWm+0gYSdbHhWoQHVE48B+SFsGzJf+WgXHjUvuG0+HG4BLrN/S44RMysFM
         /wgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794742996; x=1795347796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
        b=NgMq15ZTWXW4+TO4lims5QvJ843nwsfQ1lMyAIl5Oxdu0N1VHHby8kgomJHx+RQYdw
         eXieXjUW1jyH4u2GK/nxeM784opwix3HC1Z9JhAawLtrUBs4Xnd9H88hiG5j0GQOZ0Fz
         E5wpEcw4UpqSiNVjEkqNROa+yPrLBc8afMvhqLlhtGN9IXklieU/8LjvdeZO8TrsWmQ4
         pUuFMnyIXm1u9iAXpOP2Wn8WpH+B0wC59byObJELDhndZAdKHQtRuR21fbPoji/shbs0
         /rf9Kc4xS6lmkXOVu9ffW15FwNhYvQx2THr5xGX/jujM0uE2NkhVH9+N8UM3cybYyqxI
         Lxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794742996; x=1795347796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
        b=W1zPiM59eNqr8nOe4hbC586OaXsL5ZJFiOjgJhd4j5cK7fyHoqFnZJfkp7mv2K5G3g
         r3zcKE/QO5ApkZhSNE0F6wI0fDEFTeq7WG5X1tt8laNNhAZFTd3ce+cLQ9IkA5THqWLE
         hqkgHEqlZ1lGH7Wu6MH7gK7xedIarMwx1PvaOddsRJPnNoAiQzM1mk8XwdzJTTrra9bp
         TzE6sVG24Xah3ot3jxY1sNG5nHhiMFQVaLLMljM/H/IqPM6r330IWqMbwQg9FOIiJcbb
         HhHeSYj+9NAZ4Pis/aJBL0ojCrgI/s64Di7iRsmnbQrYVlBGGq4RBeaHsrKEaJxs3chK
         sdwg==
X-Forwarded-Encrypted: i=1; AL+hErHZYth2GhQv0fu8w4xX/7VmwQjWyFRSu/Vv7CtzeM24m3yVSwMMvPHVEeJ3UETetxeWedXUmAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Mf3t6unJ2OTwsT1erUR2wpfBZPgkjumvGvH9z8gszbxE/DVPZ
	PmQ60DDOycIxtGEGdiunlilPgdz+wFDg3/w6hI5Bri343lkUcwP3DpdJY9S41aXB+rI7YBC71sF
	lUueRlQBkcd+hSp92MCooRV40Zh51yMM6n9FSV//rmQrM
X-Gm-Gg: AYBFou2KZZKyQYUW2UIxedu9OAj8DbvKTVExynG7mobSvk9+rIJuJpRp9/nLoqlIA3/
	96V+z4zrJUpFNHoxERRAy7Xqwys90gK+2YAXZXh4uh7q+cPg0l2tQwTQwladBCIhCTm47oQZ2Ej
	pm1vRjT80d2H/vHXWgEnftx3GwurKgvoAWSccMKYXvVFXAz2oec7cEWHsMICvxcnf3Xn0pQqKqK
	Db1a/g7WDve2IrlKepwgjQ3cdL9gT6Hm2s16yCx7Iw8qiU7A2m+7pO+Z1j6riqTD561RRCowMCD
	JLfrJf63W1ByjFLL+tUYjqZAH9l/iXONRArfiCjF6ZV8+mpdlDj1EZ/TmFQPhNH8w5ue2KV3Sj7
	/MKHk+h/f6Y4dYn4hKJYJyr5vjW3CkkZyCgaNyw==
X-Received: by 2002:a17:907:c13:b0:c42:e6c8:e494 with SMTP id
 a640c23a62f3a-c5096547278mr574061066b.37.1794742995902; Sun, 15 Nov 2026
 03:43:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021085635.3633692-1-r772577952@gmail.com>
In-Reply-To: <20261021085635.3633692-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Sun, 15 Nov 2026 19:42:39 +0800
X-Gm-Features: AclHuK90wWzGoA4H29cy11pmb1JHH3C1yF5Eojyo_HIgeidC5_U6uD5eFeRWITg
Message-ID: <CANypQFYkEkoxA4vJzGd_TzoqV+_TA1nk6-ResYvG7PZ80221WQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: clear in-inode xattr space before adding the
 first xattr
To: jack@suse.cz, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca
Cc: libaokun@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, stable@vger.kernel.org, 
	yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=89 16:56=E5=86=99=E9=81=93=EF=BC=9A
>
> An inode can hold extended attributes in the space that follows its extra
> fields, whose size is given by i_extra_isize.  When ext4 loads an inode,
> ext4_iget_extra_inode() validates that space only if it starts with the
> xattr magic, and only then sets EXT4_STATE_XATTR.  Without the magic, the
> space is treated as empty and is not checked.
>
> ext4_xattr_ibody_set() passes the space to ext4_xattr_set_entry() whether
> or not EXT4_STATE_XATTR is set.  ext4_xattr_set_entry() walks the entries
> there to find min_offs, the lowest value offset.  That offset decides
> whether the new value fits and where the value is copied:
>
>         free =3D min_offs - ((void *)last - s->base) - sizeof(__u32);
>         ...
>         void *val =3D s->base + min_offs - new_size;
>
> A crafted image can leave non-zero bytes in that space without the magic
> where ext4 looks for it, for example by shrinking i_extra_isize.  Those
> bytes are parsed as entries, and an entry that claims an in-inode value a=
t
> offset 0 sets min_offs to 0.  Because free is a size_t, the subtraction
> then wraps around to a huge value, and the free space check passes althou=
gh
> the value does not fit.  The value is copied new_size bytes before the
> start of the space, over the inode's own fields and, for a large value, t=
he
> memory in front of the inode.
>
> On a kernel without KASAN, the copy corrupts memory: it overwrites the
> inode's own fields and, for a large value, also the memory in front of th=
e
> inode.  The bytes and their length are decided by the setxattr() caller.
> Nothing is freed and reused here, so the use-after-free in the report onl=
y
> reflects where the write happened to land.
>
> Triggering this issue requires mounting a crafted image, which needs
> CAP_SYS_ADMIN or automounting of removable media; after that, any
> setxattr() on the file reaches this path.  The issue was found by fuzzing
> and has not been seen in production; a reproducer is available in the
> linked report.
>
> When EXT4_STATE_XATTR is not set, zero the first 32 bits of the space in
> ext4_xattr_ibody_set() before calling ext4_xattr_set_entry().  These are
> the bits IS_LAST_ENTRY() reads, so the space is treated as empty and the
> walk stops before reading any stale entry.
>
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Closes: https://lore.kernel.org/lkml/CANypQFZzxTAH=3D4QRRDoqH6VAw1daAq88N=
DWiQKoM7QTOnP40sg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code:claude-opus-5-5
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v2:
> - Zero only the first 32 bits space instead of the whole space.
> - Add a comment above the check.
> - v1: https://lore.kernel.org/lkml/20260916084723.877552-1-r772577952@gma=
il.com/
>
>  fs/ext4/xattr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5c310747b965..8e1fd26329d3 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2274,6 +2274,14 @@ int ext4_xattr_ibody_set(handle_t *handle, struct =
inode *inode,
>                 if (IS_ERR(ea_inode))
>                         return PTR_ERR(ea_inode);
>         }
> +
> +       /*
> +        * Make sure xattr space is properly initialized so that
> +        * IS_LAST_ENTRY() returns true for its first entry
> +        */
> +       if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
> +               *(__u32 *)s->first =3D 0;
> +
>         error =3D ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
>                                      false /* is_block */);
>         if (error) {
> --
> 2.43.0
>

Friendly ping, please tell me if any further change is needed.
