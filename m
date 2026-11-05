Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793863781;
	b=J/taXJroIPFIS1s0mpqLVk6tZMT7cm+clIexaNlZwELUpLDQHnab6sHJ6i3Nk2vM0r+b
	 LvpmWDVmDAX4ITA3FNgkINuok2Lpm+kqpG7GjOP/rR0Gt15WSN0cSQfy6zYFD966Zs0Eh
	 FlmP1NorfpiGTAReEhYbtiT9iuuQgesNZej2yUYDjxx7vMoTGiKO4PSn2INdNcbpgLKHc
	 9VHy91Qb1CT9xResoRmo3Gb/2nBvT/4WhsPOGDiaJJ9n4G71oeHcwENMrtSyGF5tshglp
	 BtWjmAm7/zfUfQcs2XTlgkw7D2Bp41MUVXTBrZKFeV/o31M3GBHFdHgLb61Na0JbbnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JH9RdTUSfrXX6vn8dBjywzXH0emztfe7YJMx43Z6hko=;
	b=aEH2JNjVq83T6hS/rg1GnWR70x5GGauiMboWkpA5C4okVqMsE2+ADROXvi7w8QvDpi0h
	 s1XJyfVUHnDYIUE89c2NkJph2BmEUBMiYZ0PfYu9vGC8IO6dH1HaQ4H5htX1AkYqmumxx
	 ATeeP0xd3VrcaGTDW+kTzXUsvA6lL8l44/wMycG+/OuijY6XNM2lQprBEB8dAfAKluXCt
	 z9YuVEyzN69rNbJIjXYr359nyQq8RZkViKpQeVylGWliF8opnCcq72g2C75EKAvh8GPaD
	 9n+qsXFoYd44zBqVF3OIpQOjg87EVkyJPB3F66kknKfSqzhKVWZvOFy+fchTJ4Zlr/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG9vKvJJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D79606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D79606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG9vKvJJ
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso1750267a12.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:29:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793863779; cv=none;
        d=google.com; s=arc-20260327;
        b=FWJV7YaMLBYGvtNRwUqFnPXnxkiMzeKX3RGt1NZWwYTE2asg8+EPIGQVTBtKCnutYG
         qo4+yYD4hBKRsBBl5POdKSeFRnZt7GJtGR1yhPwrgbp0ha/FBGH3Ri5NJ97ruko20GOR
         8PcPYy7DeZcvo59ekA3xUWaVMdtE7sW7qwx+NnO6vkBg+T3TlHKWlS3orvmb+tarPDHD
         zpOwbzSW3CruCVk044LvWi+pwzxoNK7tDOxzOcL72yPgfk6h1Q0wOX/u+nvYXGSuSqcy
         LCpkzvqUkvl6BLMkL6SYIKm7/pjp1CvCBMxHrBrteuEzygwMQ1lWQfK+O4ZdvoUrf3k+
         YAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JH9RdTUSfrXX6vn8dBjywzXH0emztfe7YJMx43Z6hko=;
        fh=FXLp4gEbFzNTgLxBa0xKceWB7WxLtrTkEo5nCUIQzpo=;
        b=Goa4vF4knUreyUOdFWEMGMruzIeET73IJ/79F+ZPUVybTXHI7UBjw9HpKcJRSsck2S
         ei1ZEVtPi3LA68xikdM7IUY8sFzCZnKZTApQCXsp4ZBaV1y1G7NF4vEPZxCkTaDW3FQY
         jdulEPhUqkEreLJBl/42qjR0c5ZUd9W9gFs12ttNQ8F1lpE0TIIc2puEKpPeHAZc/+o2
         byYnlqR26PFbe0BMb30k043pggh0+e8DMDzU+GfZhsv2d4UCvPwc+TOdymcK60We1s4o
         W4ApA2WoPsammAWUAX/SgMQSCcGUdvPlbQMozvukSWXxKKNYTJSQKz3kA/bBhN+edWn9
         10yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793863779; x=1794468579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JH9RdTUSfrXX6vn8dBjywzXH0emztfe7YJMx43Z6hko=;
        b=wG9vKvJJsgQ8qDrMz35fmeNkifSjjR0QGg+uG+tgRpGOb1bYaPjUYAPMiKELrNFb5z
         Q9gA+4pG3f6ojDL9ZJrCEEWLbTnqXmtPPHDQfUXegT1cWnyAfrw4TX2nElKxBuxGy/A+
         eTwOc6S90Rwe2xjut1AhA/EaO18I5AiJGnpI86Muc0/c74swc6f9Z5WuVO+I3M2478IK
         Z1xgJH92LPHzSUFdPD5BmSmVrW2KjR4nGZyQQbSHOJ4mdkREDLKs2d2M28lZZgpgE/Iz
         nXaLBJXo/UlX83zqjQJbKqMb17U+/C0nyCG6JUYD9JlInwQC8O1YdLqnGjx5FH22My+u
         fhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793863779; x=1794468579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JH9RdTUSfrXX6vn8dBjywzXH0emztfe7YJMx43Z6hko=;
        b=igImj6MsLR+LzxCWSswZo0pZZN5STElNNUg6CTLxI3v5cp23aUd187QVlGTPc8g+tA
         wjGiir3L/Jm/La90okGSCDZe7uUtuz2P+dRcbmXJiRDrGiDxA/uk+Ct53jIntyK7GpI4
         Ect90npFf59z7Z38DXLKkkNFuPdvXViP7mnOGBs00PWiPU1bsBa6NthnDxa3solZQGJn
         3snfz6N20m5f2amzgLh0ugG1kFfasYlGZkI48P6jtxJcFX2xSPdYV/quaPIdeDu1tWGx
         2bDB75TQJqCTmbEzcSqw9JwKHS/l6DhxXzfMxdGCGda33ayTS6ttn5cke4w/jt4UqzlF
         WYcw==
X-Gm-Message-State: APuU4Z+7F0uoeOLpIxSBEzPIdFqFVZLk71R7fKkNMl1pgnxtNT7Xlo0a
	8gC6y07tcgDKCvG/p5Qi8X42XsrnZ1Rr1uQDo9ZKv76nYMeXqr3gMlCGrUqsW9CNPM9usnHMHNW
	E/vpXtIa38U8nj1Vh/4+bokpHRzQMyyE+vVWW8Mo=
X-Gm-Gg: AYBFou1I46N6/LRaQjt/wuSnxe3td3QV/1n2CbWqwJN0GhCansh0SkTT24l5gOJjNEf
	obGR4QjonmnUDhVc1ck3Qa+a66Nbs5WuMiaEgH/CGcdlsJmNWynTGL7de+EkeY4ax+7fVf8RRC8
	oBhiLl16PQ8vjidcUfV4pxkojkwhn80v0WYqFITzQZX4uUOPpaUDyoZr+h44t606ZgwhMHkdljE
	/tWbKS8dTxPNuuEmNghe2MUEW3YXkYEs6uirW7fabKaTIL96BVuUpvTtQg1YMtfR2y873zrHIzO
	8Cww4vxtbh4wxznWwkkvvDYtH3FTkn/hE/M8Mz4DB6EZ4MExn6i1oF9rug2I1/X4GhgNCIppDQ2
	fPxD2Wau6hlMqr3Vo3h/4LiKyzt50uUU3+fXf7sysOaTTw7l3OB1F9efat4gqwbaqluGJnA==
X-Received: by 2002:a17:907:1610:b0:c46:7de7:e425 with SMTP id
 a640c23a62f3a-c4ca7a4b2eemr1606479966b.16.1793863779546; Wed, 04 Nov 2026
 23:29:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110427-yam-conjoined-4ce6@gregkh> <20261105034400.1253169-1-sashal@kernel.org>
In-Reply-To: <20261105034400.1253169-1-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Nov 2026 08:29:28 +0100
X-Gm-Features: AclHuK_CA3I6FFsOL-WdXlIz8eHrr21-iBHIU1BJwK9Og7_FDCpqPiHfQOWU_VY
Message-ID: <CAOQ4uxgX7BShwXD31adtqA=mwuah2vrZ2ut-YqWZLOFJb=wESg@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] ovl: use the pinned upper dir in ovl_fix_origin()
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:44=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Chris Mason <mason@kernel.org>
>
> [ Upstream commit 4f61ff2ebfb3d2967b83b6a4d456242244d5a61f ]
>
> Renames made directly on the upper filesystem during a lookup crash the
> kernel.
>
> A dentry that is passed to vfs_setxattr() must be pinned.
> ovl_fix_origin() passes upper->d_parent to ovl_set_impure() without a
> reference, and the lookup holds no lock of the upper directory. A
> rename on the upper filesystem changes d_parent, and only the child
> pins the new parent, so a second rename and an rmdir free it.
>
> With delays in ovl_fix_origin() and ovl_set_impure(), renaming the upper
> directory twice and removing the intermediate parent during the lookup
> of a merge directory without an origin xattr gave a KASAN
> use-after-free in vfs_setxattr().
>
> Fix this by passing the upper dentry that the overlay parent holds.
>
> Fixes: 9678e6303057 ("ovl: fix inconsistent d_ino for legacy merge dir")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [amir: add helper ovl_set_impure_dir()]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> [ sashal: replaced ovl_set_impure_dir() with a direct ovl_set_impure(pare=
nt, ovl_dentry_upper(parent)) call to avoid adding a helper ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Why avoid adding a helper?
This just makes LTS out of sync with upstream and future backports.

I dare to say this is not your doing but AI, because you should have
known better.

Anyway, this version also strays from 6.6 version which I asked Greg
to apply to 6.1:

https://lore.kernel.org/stable/20261104184559.3630145-1-amir73il@gmail.com/

Thanks,
Amir.


> ---
>  fs/overlayfs/namei.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index cb8ca730c0ecf..f144fe91ccbf5 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -819,8 +819,11 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct=
 dentry *dentry,
>                 return err;
>
>         err =3D ovl_set_origin(ofs, lower, upper);
> -       if (!err)
> -               err =3D ovl_set_impure(dentry->d_parent, upper->d_parent)=
;
> +       if (!err) {
> +               /* upper->d_parent is not stable, use the overlay parent =
*/
> +               err =3D ovl_set_impure(dentry->d_parent,
> +                                    ovl_dentry_upper(dentry->d_parent));
> +       }
>
>         ovl_drop_write(dentry);
>         return err;
> --
> 2.53.0
>
