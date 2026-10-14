Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354B4A4EEA
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011799; cv=pass; b=OKEtPthdpn3PCSQkdWR+lZ3eY3veAtPeIEJFOTl7p0008jg1k89W9dcvK6+WBgTKjl2U6A9rMnnkge1zjSUI/Jt9wI37jEtz/AQBLWAd2ngXeG9moR2U1uiJXZaH+cEWemPkCsH5cEd/DRZUKmZjSeYuJtoVb/cEKdfGyKEqNWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011799; c=relaxed/simple;
	bh=T4Qy6GFRO1ST1QLZrYR/490K2fdT74b4dRkAKQGKFgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugunzmiP71wc7Ot/ziYGsIPpwThk8R+Wjgdl5dMVRmjsS0tIPI5y4qOXToZT/Ii8gfRJEV0bGBCTXJBWu6INbL9+Qr9g6EPPo38Y4r00hBrsU2X1n08ZYIqFeZkIfZh1wWG2i6YLQcpP4aQ4UiyeoWl0ZgjY/do1NOAuo556tEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6rmrFuo; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6rmrFuo"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a75f960be3so16735811fa.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792011795; cv=none;
        d=google.com; s=arc-20260327;
        b=mUgFGYh1nrlfIr8WF6N/jZ2tEcD7yS3t+nZQWmbh19VtGuWWV+LgCQbzwaPFH9BsoT
         B/KOYA+OjY9uNMXKP2j6yFhhaTYl1lbovjOTRX9n63Mm5jo53Zr6Q6BTbSdBlyJE9a91
         lA9MBcUFnOXjyhXjPwuLPTMwx0kjabd1GLhpVxumuPOc5PWrgb/3TSrO1+1BZ6yo91t5
         i5J46u9CnaelURGTodeu/dcMeXFTEw4NaoUZFHpVc4PhxVieYWWtSNIt/EEqCBKHukS0
         14rb5jbItaN4ai2u10tD04t2rKaKTW3UGC9JCHwyCM0fWUQOcZ/DrJcWoVqhuD6AJhlh
         TlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=;
        fh=3UZLG8EW479o9nnAT9xpGYcqpqv2UpgVwIGh83V5eTE=;
        b=R1hkn7fQks0/Ald/hD22n1XuSuLGi4Dqz0g828eO5ft8sNQ25rmtKoh710DlazgLbY
         4u/owZ6/bi8YMl2rK40bbtSR4huhCHEOMziBHSiZ2QWCzAPmE3LEDPfEdYhuSeVZi6rL
         7zY2DqL5NrhFYN3GOSqEoCjy74MNH8X/0Wa2JyO4i34E941+aogpqzhFkAZhuzUiVGQp
         rpmwohOviMvt2woVXQLEe8J/6HRkJpiw4EeIRf7vCu93Nd48MZ3sYanRb2yDSWJ8Hif9
         jLC4JdtiHG57qG2U8u+7S6MpXqBbhQ68y86p0+Pu7Nm7xGvRE5YNiLWUQZOhTPkPg6VX
         phyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792011795; x=1792616595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=;
        b=p6rmrFuook6XBkT1FyUVaG7PnGlClKjiGTvXYwuumOMSAiH4jafl3vEOJ61HeR1fxN
         SNELFMoFThTXB4mZdndM/Odu1KsgcBNjYjW8AUVxaqbbWHA9Mpz8szL0F7H16JoGnF4o
         iuVwBA3AOXhkJlLoWFfsslfengH2mXuBDVfVxeUyPVR7HxTQmQ+yLCoopXM6dqxXPEzq
         oN+HmDJ729Bci836/K5EvPBtcohFR4lpV5pRuiTdHPomhqH25ohiDX1p6dzHREEfTv3E
         YKJN+8QLk3WRe2tZtrmDoW3qXjXMinZDf2R+OzSsu/zrnG4tqG77ZUpxedV84JusdC1q
         2hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792011795; x=1792616595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=;
        b=iT/BetoYmdc1BnB9YPYloeIHG4DH+y0urslhTU0w2h56f4CCH6uJldGe3yEchnr+Eg
         lcuQtONH1WR+9oiD6yNz7eUlKF0ywlVWzsxrHDq7v3BIgSEmYR8JFmqYpvOPR719rtfp
         vkpRP8a2WAXKjRGBhTvWZkK95KPvFwvwSmktLKqRKUbW4FFkIcyyYhgOTKSIl8SVgev/
         oHVlyrVlELJuvi6061Mo59iPodAoJbqoDS9U6QaKaOHRbqfi65WFSJtdkjSyTTnB0xRc
         71o/B5WK7WAXAhQPoe780jWGrcYa4nZp8BMI8XzLmD7w43Gg5X8HTpDNU5WeYkCf1aPE
         srEg==
X-Forwarded-Encrypted: i=1; AKwUvBzc0I7vW7ypUWS70oPT1qypQJIeUNeuyXNxYEItEJTm/6OvQ8HnVx1MuXP+wWbl/wsfvZ2nlR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5ldbO+oWrbQyePClQ6M29BZnOuMFS+tE804S1CbuPP1Z1G4ME
	zuso1oBIr1i2ZCp8fIL+uR5IrZah63M1ia9ShCGBM/Z4qzVk8FHDPekQ5m5D7eJQDgD01XHsasa
	zxWp1p3rLuuShS9Rxb+1Ck/ko/kmRTdQ=
X-Gm-Gg: AYBFou2+gFqeQw2LULGnmg4lNSwusargHk9UR8fvRLh4UimwJt5W/30xM+q5BlEMUvQ
	xdy03wkkM0BR7gr74UxiU1PMF7peoFGXYIP+a//BGsxQrK2FSi/8sMQtimm50KbEkVPkcvVSEww
	rS5NQwqOfoTSJS8HIvvUsH+hJ4NYiCT1YPIXUiiC1zAYIxhgK00hfdeAos7vCpr82BAT8CJRScy
	YGUswO4s321uznlr1iBRwr45MzVQzvvWZLHrF+bDToZKtMZuTnoDmEEHYcc0XnVnW30tQ1VqbmR
	g/4MMvNtqV2h2m+YBusaHEaHSZH/YwOEuKl+6smdvICXqFLKwNNI2iRiP4TV7Fkzww5moa0UbDM
	wnH7CkPL9xKcbPBrogYayzQUsCBZ/hpg/ShNY1DLRrDpc
X-Received: by 2002:a05:651c:2221:b0:3a6:58f7:da9a with SMTP id
 38308e7fff4ca-3a9c54acd7bmr39702171fa.27.1792011793698; Wed, 14 Oct 2026
 14:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014152138.138281-1-daeho43@gmail.com>
In-Reply-To: <20261014152138.138281-1-daeho43@gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 14 Oct 2026 14:03:01 -0700
X-Gm-Features: AclHuK9ssELmbfFeOdtC11wQQOkFMUhWUeAu0fXdFEVJnCmum3r_7J3AOUUwHzg
Message-ID: <CACOAw_yLf9MDqBdkvhY9rwe=pLjkrGkcrHtAmdsvhcOdU4Zt3Q@mail.gmail.com>
Subject: Re: [PATCH] f2fs: expose resizable_tail feature via sysfs
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org, 
	Daniel Zheng <zhengdaniel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ cc: zhengdaniel@google.com

On Wed, Oct 14, 2026 at 8:21=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> From: Daeho Jeong <daehojeong@google.com>
>
> Userspace has no way to know whether the kernel supports the
> resizable_tail_secno mount option before mounting. Passing it to a
> kernel without the support fails the mount with -EINVAL, and checking
> /sys/fs/f2fs/<disk>/pinned_area_max_secno requires an f2fs instance
> to be mounted already.
>
> Export /sys/fs/f2fs/features/resizable_tail so that userspace can check
> the support before formatting or mounting a filesystem that relies on
> resizable_tail_secno, e.g. a filesystem whose tail is going to be shrunk
> online later.
>
> Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinn=
ed allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
>  fs/f2fs/sysfs.c                         | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/=
testing/sysfs-fs-f2fs
> index c4746c416ac..8df18b5d479 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -271,7 +271,7 @@ Description:        Shows all enabled kernel features=
.
>                 inode_crtime, lost_found, verity, sb_checksum,
>                 casefold, readonly, compression, test_dummy_encryption_v2=
,
>                 atomic_write, pin_file, encrypted_casefold, linear_lookup=
,
> -               fserror.
> +               fserror, resizable_tail.
>
>  What:          /sys/fs/f2fs/<disk>/inject_rate
>  Date:          May 2016
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 9749da70089..8b844a8b0bf 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1421,6 +1421,7 @@ F2FS_FEATURE_RO_ATTR(linear_lookup);
>  #endif
>  F2FS_FEATURE_RO_ATTR(packed_ssa);
>  F2FS_FEATURE_RO_ATTR(fserror);
> +F2FS_FEATURE_RO_ATTR(resizable_tail);
>
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] =3D {
> @@ -1592,6 +1593,7 @@ static struct attribute *f2fs_feat_attrs[] =3D {
>  #endif
>         BASE_ATTR_LIST(packed_ssa),
>         BASE_ATTR_LIST(fserror),
> +       BASE_ATTR_LIST(resizable_tail),
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(f2fs_feat);
> --
> 2.56.0.385.gd3acb90ef8-goog
>
