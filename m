Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AF4772A5
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153601; cv=pass; b=rIskHxFnRMFVZreqsLyziWBxkM1qXW8u/PzCkY1Jjzt944GwCl8kDXDz7sMb/fH9FwCO7ZlM8/sERf9FNWHRRPft4Ynml1crSbH5J/UGGC4K+anDrDFpJSVD/pZl45stXtpI9SeeFDlKlK9fIAuDNPlNax+EV///uYfUFQD5sVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153601; c=relaxed/simple;
	bh=sd73B+0fv4kFWg1/BIpMIx0XVt6pOSOqH8NxgJdLnhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OK3vSmEwRxBHk6fuKnitLK4Hmjem4sqWgZaGqNHfnlKbRuI5kBSFamwAhiyygIUrZd7mKMqlkXDIiJ6aOGkIe6SxWbIIK9yOYbu3etSL3ZIquT6kpheX7I2QTvP874UK26LXNPe6zKe58H2VSura6M6caKTWY5ANgDmQmfSAbMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MesPcnv+; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MesPcnv+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so96226866b.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790153592; cv=none;
        d=google.com; s=arc-20260327;
        b=lwhJSW05w2VHLOmP+4oJhnS3u4WdEcfV9fhw0kcuIcQUM1vLhdwPFFal1LWMZnI2Wc
         WM4tFJRZdj922X4DTc4IET/TGfYvI2ABzmP2Yre+HB85FIz16zFmK8D+SYtm/Ei/nX/0
         95kUE8YHkwJm4uSCggXEx+BmTch9UBIjyATQl5Hj82q/Wq0Sknc0TSr88/nGBEpuMZMw
         U8IlpzSuxBjYbL/zjvdymaawFKeRR1z898VZEvGmclEtsTJFpKc95kA2qn+BcNRv74jZ
         fTQkgOlyxcG/ENpdUI3GG3zMGnUCoNUO7JNkGQGHSxl3ZLlLg/RriRWuKmbFpFXnwUC/
         4AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3FLZn3X7YL11DIAVkQWpw7vFctgltGOcmiwV6tG+5Ks=;
        fh=gXnYdF3lXB3FMjZEEFYRKpjHaxF9n6n2Z6x7JYpvwT8=;
        b=eciUZfXydlK/gDPKImoNS0tsX/bOzTq6Y055QPUeLW70wFi1Lq2yciMYoPx/tmdx5p
         Qv58dgyb6Qvf7F6DvG0bjhvo50WXAuCLWdVpo3YGsqoG+6ZpCpiidjtt568EE+lcX33m
         tEq8Xa80ZTdT6y+PMyFm/D7II1EJinEG/prU78LgqOIrZc8BgOwH7YF6WM3h08qv8wsX
         U2egjVzM7eh8gR+7z8PxBLC+ZclHL+ZjNQoAYRVwzO9tcUdrJpprZEm5ggkiGvVFTBY6
         WSe7UC9SmIRqktIzPohAVBGzOYJmvaWqq4Da89jrMg/3VjdhMtOFc2jEwdA08F6kr0C+
         Hs4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790153592; x=1790758392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3FLZn3X7YL11DIAVkQWpw7vFctgltGOcmiwV6tG+5Ks=;
        b=MesPcnv+Gj0HST6wUepYrtVQ5V4Hcj+RKx783JSHfmhvNmhigGefBfytwDZ4SSH4pl
         neb9bZcSGdYsWqrIOuOmI/9+U153HF6RXp/QJEKPtK8uM3x/fL43PRx+5cRrqgju5fjA
         cMJY7Vy9YdqldLljYwKj1EecmIZL0XLRiMsoL+wj+VYPM4PI51nOOu8ERG9YOs6qBvwq
         myuaC0myKfaBPQm9iLkYjY9XrKAJGSu4Z2q1AOpjLNTswm39CaXZ4/tcScubYNYLq7/D
         fsMGw0eK8kBXxF3FcA69rs6NN3IhAbdKpQxe1wDoTrY5EUi4Vy2iR4nPA1fwIKTDoLXQ
         RE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790153592; x=1790758392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FLZn3X7YL11DIAVkQWpw7vFctgltGOcmiwV6tG+5Ks=;
        b=yxPOjZCPXmB7U8QCSpm9gLF2l8FGuUmbJGlYtix/O2eajz6BU9Hll2VC+CXWqJP7QE
         e9ZD3hdxVpMyTZanloSPyMQ4G133czBbSTDmTkMjRrmgXOYcpTWb0mKLj4J3RrT5YtcQ
         pSAyFfg8/hIpBbbCVjAe9zgmI1/w3pY7QD4/J5Qc0bEEdfyHq+PK+XooERMeuGlJ4+WO
         opzfu+IVNlPf5aRt/yirYAiB1jPbKWtKA/VTMEEnNof5PJugnJnEEEN0ZX9s+ZRVwSN/
         ULu4d1vGVCYlJZ9OCS7N831l/l8Om9vPijCPh/eTuReJXoPxivED+klXX/Ohf4Vjyhgw
         53hQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+BozcvV/DG1oCpNiANdFys8e33nJ2MKCJ0/OFQJXg9r7GE2s3HEPyLhVGiUnaM5vFdQMu620=@vger.kernel.org
X-Gm-Message-State: AFuF++n/kBShmidVGwsjUJj+45Dab/MvadVsntO2WjewmJMDeCum2wMo
	0ZivqRxgiSNB2kJXX0Nl+Fo/dGdLKa8H1iUhwZg9pk45LtN91O2SPPlDt1gCr9CvlpIbyfnE0Os
	A3Xb/hdbZJgVDTTHb6eyoNs21eVcXads=
X-Gm-Gg: AYBFou08cilbj8XmwbfDXFVRvhTD+m7PEdm4aQsBJy2VLLMGJmPHi8nrlUtJJyycWxf
	W227YPyFaa6Z2P2PxSNPOCkVT4bXoIcBsPMZkVCmGrUMqSfG4leuMFuEeXXAdHI6DmgSGPzwS36
	I25bMpPaRQdDd7tpRudMUuOJawvHwh0dhZoaJzTrADI/FoZvsmxJIYZparUdV+W6k9MRjf2Mxw6
	DOBS9ZvKwBHSSH6R4tSVb7cSp7s+xuU9eIaPhPLJyYcqsSHlWMi39fbYgc8GsTm5qUOSDVU5cv4
	zBpZHq9wjgo5n4sZ7nNUt4e8EpP5NS2HrOVQ3MY2+nm1sECSgssGqX8BfvmOXt9Xys5w
X-Received: by 2002:a17:907:972a:b0:c29:f5d8:9c7b with SMTP id
 a640c23a62f3a-c2aadcc89c2mr161328266b.42.1790153591027; Wed, 23 Sep 2026
 01:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFZzxTAH=4QRRDoqH6VAw1daAq88NDWiQKoM7QTOnP40sg@mail.gmail.com>
 <20260916084723.877552-1-r772577952@gmail.com>
In-Reply-To: <20260916084723.877552-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 23 Sep 2026 16:52:32 +0800
X-Gm-Features: AcwNN1UMfSu8IzUIQZOKw71fWeU3uvzM62Ysf-NXrGIr3kl704yBCqU3vyMQB5A
Message-ID: <CANypQFaFf4mGrr_pLRyPgKCTDX-0vCd0nnwHenwn1xxQSa5X0w@mail.gmail.com>
Subject: Re: [PATCH] ext4: clear in-inode xattr space before adding the first xattr
To: linux-ext4@vger.kernel.org, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, jack@suse.cz, libaokun@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com, 
	syzkaller@googlegroups.com, yi.zhang@huawei.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 16:47=E5=86=99=E9=81=93=EF=BC=9A
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
> Clear the space in ext4_xattr_ibody_set() before calling
> ext4_xattr_set_entry() when EXT4_STATE_XATTR is not set, so that the walk
> starts from the empty entry list.
>
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Closes: https://lore.kernel.org/lkml/CANypQFZzxTAH=3D4QRRDoqH6VAw1daAq88N=
DWiQKoM7QTOnP40sg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code:claude-opus-5
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
>  fs/ext4/xattr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5c310747b965..2e5f39b710bd 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2274,6 +2274,10 @@ int ext4_xattr_ibody_set(handle_t *handle, struct =
inode *inode,
>                 if (IS_ERR(ea_inode))
>                         return PTR_ERR(ea_inode);
>         }
> +
> +       if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
> +               memset(s->first, 0, s->end - (void *)s->first);
> +
>         error =3D ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
>                                      false /* is_block */);
>         if (error) {
> --
> 2.43.0
>

Friendly ping, please tell me if any further change is needed.
