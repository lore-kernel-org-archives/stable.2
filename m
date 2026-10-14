Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980B53D0AD
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986968; cv=pass; b=CFZnXyPJ34K0JnZPx31kq2ITeQV6IIFFCwUGsxydVKl/vz92OdZEyO/gONNZ+edxuIt6aMAN9ciV9Oh0Ujv/l9702m/GG0wSVMaiPSm7Hzwf5Ysx1wTt5X79y+WKTAk8e+BeU33qma4kby7eS3jQcoIgUSW8Why0QDG0xAkfZmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986968; c=relaxed/simple;
	bh=sd73B+0fv4kFWg1/BIpMIx0XVt6pOSOqH8NxgJdLnhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAlUKz0dfjBaVWaTxcFnovZH65re4uiuDTXFlzdTIuMx6cWqWHcyYFMScjO3Usj7ZjgtIy3SbgKxxge36kNtUemhBdfQWsHiahdEDflBIQAfmVmjWg9bTVEt29M8mzDkA1ZUH69hKDW7qhMGMniu3rl/mlu/itYZ6R7sdHEr+FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv9FP3sb; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv9FP3sb"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so4985851a12.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791986965; cv=none;
        d=google.com; s=arc-20260327;
        b=YuxWFxcRG1Kwoq8mSrNClj+1uO0nFY9xwBHj4TAV1sio/HUJporyyBiv8A/Po8C4J7
         blH+fU/IZj6/ZIBNLR7E3gbNzhjMmDii1ATUm/1U2PvDkYecPP7ARgr5k1F2eAzNzZgU
         DMDALWB6XPmLIHslVTjDPnHEj2gjc0ImJdrchEwnsRvaTJpZvfaKKwzSGDdRSBUqYQpq
         d+6jJRZ35bTo25Q7VpaCEbp0RSvz6Cs/ZnsQDnHoB2U9js1qJ8zC4L6Q1FxQeenhRkRl
         YG1uT19a2tgGrEEKTGj9OVpZgzGCoNpV06ewZ+n4alN1QCQIRWXz3PAuwkdDFpGIucXX
         1EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3FLZn3X7YL11DIAVkQWpw7vFctgltGOcmiwV6tG+5Ks=;
        fh=iV0TuMWGkqbVAcXYKdEft8ReZFgFNUDtGfgF90hQytg=;
        b=YlHncs+W5ttoec3mJLlXTS2TqVCarPE1pxmPqg/pxVRiKAs9Vrrodi3brTTWVOdicu
         o/BMxp3NZrlmEL2lcBLTG6laHrNmoIvXw78vnosCCTSOMW2jjrR5t4vZgiHfjBFUGGGK
         rbGrNHu3i5o+Uj6zsVfvRXmxDVhagxeeNC/uhj32SSuMQ2uIZ13TCZyd70Bj+AaAlxyu
         kLa+BAZF6JhLa+WlHE2TInEk8m367IylXNMW4PZyt9BRh80QzvnJs83BmCo6qiWRhD4R
         uGW10/6XRkK8TTutjUjqmVVCt8xNJhbY/uFDfpxPKCC45cNmtdgJ0QZ3e5hOAPDm2UBJ
         y9cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791986965; x=1792591765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3FLZn3X7YL11DIAVkQWpw7vFctgltGOcmiwV6tG+5Ks=;
        b=Yv9FP3sbiIObVAd7cQCkT8vTjPQW2euo9H17lTc683i6p/9tjAZHD3S9ayAId6G0zz
         dQYUlx/P+mPWnqR8kIwELDxA4rrlK+DZSm+KaUQTAMniHDkNZnPCR++KRwh7RTt9+Agi
         I9i7NLKsLJS+UmpnuE9zPi0jx6n/+/T5irpT7bVmblmpFszyxhKin/46rGpydo95BcKq
         IcyN18iUvpnSLYyb+pKCR/J6dInJLThCGAfphxMtfBW1C1+VN+CsTQ2MJ2gii8IBuZTe
         80PVez7adrbGox9g4t7B1FfYLvu9DSMHEeD0fm38bCBymSXz53Xvaub2gtunyZidBGOu
         OVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986965; x=1792591765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FLZn3X7YL11DIAVkQWpw7vFctgltGOcmiwV6tG+5Ks=;
        b=JoGVWSAHN2sHuOVNMtyKTPUInKiU4FbOtDXIbZ1QFqPN5OkvmqNR/pjnoH5Ofn0/km
         Wp1D/2XHJOSb0QQU+8T90v9/mO3RRT/Pi1eXcxg8yV9rcPDl8TnOfMM8FkDxhZqjAlhw
         CgoIcANY8qdg2s8ID7Bc/gO+YVaU+46MXFaMXtYQkqf44Lxlb4kOVSVLsv2/3WKyK8f8
         /xOHoTpdR/HODtPNz2X43uKsjQ9a8u4CEqZ9EnvGyBsUmBKmSoyfvCJINzpXrGnXDQOL
         KAkaaamdlPwf8o4fdQRQaafBcsZcqsVS9TWQD1D4kyUft/cTXGWLPRY/1FArnpQZ4gOc
         u2nw==
X-Forwarded-Encrypted: i=1; AKwUvBwKj5/uafwgN//zi/YK9QDwN191n2bSjbCh9m5bmSlbpEx6Ny6NEo0+11Vx6S7V7h2uEL7zOEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKp1A/ji9pc8EiQrDnpRObB7oAsm7zsDxUFjdRY4U6J+QTdDJpQ
	oSXvMtRgComfT9Yz7d4T48ChhaLRmZ1VjG1GHpqm4EWyQJoEigDzwhOj22bjx8Qhkn9ufpVPMQp
	NYl5hb7rhcVJa35iMLgD+BcUMlzYVQPc=
X-Gm-Gg: AYBFou03d1R4yj18+cyqE9YO5bZ+r0En1VfwNzm+bjJb9QRiEmR7vwHismweSWztoVy
	Zb9Pv0UuEI1WnMuEM8qK0H+J4vChr2565aHpxjdA06si2ETsNhfvbJnTobCOhARzVfVeMUTNL3Z
	6i5qnVFmpBEebeg8HJEetPvEGIfP7GfJr02vPMqWBirrfczl6eKC8xYI2nI3q6BtGg27BIrgcTJ
	FR/nW2a5D3jS+DYYQ/DxiuJDH76Lzt6T0MRtv5E+8bv6uXUo9ho8nvdl6QX0s6mBIG1V2vi1qIM
	tJJIpAK+dQo+1lX68z7E1D1btcjHXRSlyeWrePThFSObhFlW74xTs9x/GGZZVOTBO8EK
X-Received: by 2002:a17:906:dc8c:b0:c29:555e:bf2 with SMTP id
 a640c23a62f3a-c31a9fe3cf5mr1382766766b.41.1791986964194; Wed, 14 Oct 2026
 07:09:24 -0700 (PDT)
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
Date: Wed, 14 Oct 2026 22:08:45 +0800
X-Gm-Features: AclHuK_KOZRXvkZAlVmDLv2Mmd5CCVB7SGq_bvSi3dxWQZgMQy5Ldx3OdNtwlzo
Message-ID: <CANypQFZCx7iAhsMzb1-WRAMwi1T_sk34LkUX8-bDquWrez3_eQ@mail.gmail.com>
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
