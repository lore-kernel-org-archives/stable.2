Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02F3D47D9
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238264; cv=pass; b=m74nNClSL9mSUJQZssWMqRc13Puccc6ich/L+2HI4IAIG5DVaCqZwJtVIxdju/8GeXUS87HT1WhUyub0OldG4Ok7tq5D5R+X7WqZvZeYpWaEbo7oiKlxQIqHudiyP3rn8zHBWDij7HRlhF5R/36/wq5tAp/sDP3VlyA+K9kM3y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238264; c=relaxed/simple;
	bh=l3Tm1AV8dcK86Un0HFAsfoCUZAjWuevQd8t/b+qY8Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6UvP+IHz9bOAgtMQRHhZaZwOdPsjW2KBG4atzdZr95HVvYsJx3mhyKkBJmzsFfJrNGYB230HPxIYpsapCdLQl5er/UuvumZIHgo6qsdfGu0TiImTQ3/B2mNCv9236xFNH1THF9/Z24I8daY+rox9PbVNFklU9nzcjgE6CLjDwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUbjnXu+; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUbjnXu+"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9773507d36aso2088559241.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 04:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238262; cv=none;
        d=google.com; s=arc-20260327;
        b=WhAiOqtLQPquik+22gFNlD0yRanzdGR1xbGrhLxAeN3AJ+8caJlpAYbdT0ScF5eSrd
         5tqCAFtA8CjvSKezB5ty054ivkRj8dWU+OZhghggZX7yttag6qKi/3DwJinTPEIFmNzG
         PyAFQ2kDSAOWRW5AngGozPLaedtYddo+H/e7nX5CLVez+PqEbD+lwQQX+xGjHquQEhWK
         wUN4ekzsQYhPnQ+mnn4U6MCA3kE4Dae170EQ7TOYZ2M+1VDH9Op54fEuYMJEN9zKQ4Sp
         MmokKAtyi7GtGc8kfb86OAFd1wpRC8pBxPHa4c85cOJCk8YEIb1ktorLLc6Q352z/rxe
         aFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VEUA2hNG8LcDuIh44rfCasVHu4mLqVaGDQhYorW3toM=;
        fh=370XuC40NcMZ0lyeSAiqsbZ5ucT2c+sTil1MPqiubzE=;
        b=EJMzwIWPtfqo8evSFRpCvYM1S30LGFH5Vl9Rbf1HBPAOYNpDx/FDHegyMkbInzZcUs
         J6GLHsQGb0y/ZJh/Bgpkk9ZUNZslpwFb8QqMp6+Bp6Nhfq+ihu0mfJl9CnnXPi2afILU
         1R18ktQGM6hRB5QGFiAz9z6z121zsqmx0h7w4G/7kIehOpBFCdncjwyNnX34sTkbaMVc
         dDo2LODoBeoQM5skbZ3Hwzqh6dPSy5NGYBqF1VZXcRytInp50ABENHpD7l5NIg9Hifne
         V0GKb3WMjLDtkG46DkzegY9WhbWaP07HMINHiaQrDhgkvF7jNtMX18X8NhmGC9nYHLVo
         Ftag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785238262; x=1785843062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VEUA2hNG8LcDuIh44rfCasVHu4mLqVaGDQhYorW3toM=;
        b=aUbjnXu+9GXjNVOAK3QJo1rSytAEBjQMu0qLft6KnnF/xE8U0VM6KikLC7my2KTCNO
         J2LuKr61ph5QqPQIzMEtzpfOQ4xvi9k2qFGKNrUZeqbWTMHt3NLmd6dRb9X46x4vN+0r
         ICu4fx12Z5oHoYBxvVcYh4MJ/hlq5+Lhl39ldIA1C05ulPMJDIWUyEoqhoAWCwjAYDX6
         LdDPzDoxpCI4oRnYsPaSAiN62PInsHcryBmMT9XUnIV/LhsCuuLSd5e5vo3buOBUwD0V
         /9Yh6/Ef7BuBEic6QKJy79balQ1lKI+d1hLN8P3Swh9UHe5FAxIlcIEg/vkAxqwsodA3
         KqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238262; x=1785843062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEUA2hNG8LcDuIh44rfCasVHu4mLqVaGDQhYorW3toM=;
        b=QFg9OZKierbkpxDHidhm2PtQ0Zwoa8BFCpxTauuRZaiif9kG4XuBG/mjK/CVJalNiI
         HGxc+sYDRNNTjavRCmS0t/eNu8RQVO6LFVLSGoCq537tCRUblL4tuoB/nUweaPYqacGr
         Sjoe+KD4OEOLW7zyj30fsRKu0W21WyBF1KXee2v6ApwIlpKcR0wOOjtsZFCa1+TgguDM
         T3FUTDGTn6r3UYvVQS1Ok/8kjjiVfzU+v1z6da3q6KMcYbz07V5C5REVju+3nACn5BxC
         MwPWvEc3/QUYjD1kSEkkcJ2ob0+AFtinjDhiHJRBTCWVSD0Zb1qxsDQXPvEmt/1sZWMh
         vKYQ==
X-Forwarded-Encrypted: i=1; AHgh+RreH/Er2Hw8n2JHhBbXrO09kKH5Z6Qa8HSPN4ksXx5qnD7EV3i+DJRuzLiPQdKUEZUm0BDkCqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Zqq40sEqhl9QrZLNqsFPLAMxoKU4A7S0rdIE6fcIFEk+RPkY
	47gkewTgGCmwUwFjWgEk1DZHZs+m2ghJFsg/QbsvQbwTdiqpRhhTiQwMdsmiWUxXCfoJm/UlYjj
	aiVqadPdb/W3E2m92FFWaWcr+2S4Dpu0=
X-Gm-Gg: AR+sD13gnNb5kQca3uzTrkRKDjlPZuIOlFMfrKeYVTMpYVWF82Ea4V08J2h5mNH6E2p
	Bnhd8X389L6SxynQzULo7qaJSt5opj8N4ntUP8IxjrGc2U8+R3SPxV63u8VVHfmYYDTxq2VIB3Q
	wWrnM4uROT1jcHj8SdEU9HfqfKMvhD+r7TGsRVVW2J7zk451D0FNhSsc3NzDwZb8+/LiaJGsRty
	MRhpsF6LROWAKBcP1ewfGhgEGYQX492v5uxh8HUD/7IU0FMkMoBfxH5lWoFj2dJPTBBRcX3FJPC
	fSSzX3dRWVq/KfsTVlU=
X-Received: by 2002:a05:6102:c47:b0:71e:39e9:ce5a with SMTP id
 ada2fe7eead31-754a24bc971mr769236137.26.1785238261819; Tue, 28 Jul 2026
 04:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
In-Reply-To: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 28 Jul 2026 13:30:49 +0200
X-Gm-Features: AUfX_mytE6ppl0cG8sc6kC0q1t-euIDfIyWvsizyrI0wGinuaHfau49fEDCdf78
Message-ID: <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:47=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail=
.com> wrote:
>
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>
> ceph_ioctl_set_layout() and ceph_ioctl_set_layout_policy() call
> inode_owner_or_capable() with &nop_mnt_idmap instead of the idmap of the
> mount the ioctl was issued on.
>
> CephFS supports idmapped mounts (FS_ALLOW_IDMAP), so on such a mount this
> compares the caller's fsuid against the unmapped on-disk owner rather tha=
n
> the mapped owner: the actual owner can be wrongly denied with -EACCES and
> an unrelated caller wrongly allowed.  Both functions already have the
> struct file, so use file_mnt_idmap(file) instead.
>
> Fixes: cee38bbf5556 ("ceph: add owner/capability checks for CEPH_IOC_SET_=
LAYOUT*")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  fs/ceph/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index de07f19b0caa..12cb50e0a166 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -72,7 +72,7 @@ static long ceph_ioctl_set_layout(struct file *file, vo=
id __user *arg)
>         struct ceph_ioctl_layout nl;
>         int err;
>
> -       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +       if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
>                 return -EACCES;
>
>         if (copy_from_user(&l, arg, sizeof(l)))
> @@ -145,7 +145,7 @@ static long ceph_ioctl_set_layout_policy (struct file=
 *file, void __user *arg)
>         int err;
>         struct ceph_mds_client *mdsc =3D ceph_sb_to_fs_client(inode->i_sb=
)->mdsc;
>
> -       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +       if (!inode_owner_or_capable(file_mnt_idmap(file), inode))

Hi Max,

Was there any specific reason you used nop_mnt_idmap for these checks?

Thanks,

                Ilya
