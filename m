Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E338AC80
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433311; cv=pass; b=o3QWooACj0U6vxjRbwaeA0AGfxzr7WlEtieO9IRMU0NYHfoeYPpP7cXW4TJihcXeKT5oW8q/49LUiA/U8aPRJX4tnGfb7wGv1QBrofp/M6hFi2JbkYKqQYISXKspdPKjLKuYJ7kx3sqovECwBINXf1rMlPc9T35VyEJ5BcCdepc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433311; c=relaxed/simple;
	bh=38Rgp+sQ19WuXaGsYOlOkyRAeVrqXuzbNNqpV6hl1Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF7ERZ3E36CRHGYb+kbb1nrUU4T33AlMvBtvEFmHvzh+MYMA1BqIhrV8byq5Tq6jNH5My0NrWBt6B5ncFR3Gkpm7SYx6LIBQS8ZdHrSZMHe/3cOCFDgZO6wccze7cSoFA1EsDkrbHN8A/ebUqimohUzmWvDyYIYJkFfFwEcurVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX8akFLH; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX8akFLH"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-75609e844faso698534137.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433309; cv=none;
        d=google.com; s=arc-20260327;
        b=aptIUm6PmIkC+jr0+oGFB1pTOhBDNUjV0wLa3OLtvaANXZ438/lwQ87SsmmhG7pSLL
         yVlYxKshvIczcu0LlJiJ9UIbnjO8o6NQHZpHxWVEy5sjCoNnIsIArUaYTzM1PrRO1mFV
         PxtAyZVYuQMSV8cPiRaAC5J7NXKZ0gXMLbjCREPwTJTSuNQWYN9gX4v+5ubEbIVkg203
         tlExteVKzTdGcP36hNs2tSswSHd/FplnC/UJyUG/we1wk3DpDz8fIHINuCHN4wmHeg3/
         OU4t8SdnwAFpYCmBQwBzUh9fu36Q5Waj8P1edZ3fzhAm30e+9kl43P4BEMW/eVeL18cx
         mrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V4Kqw/TkLVkzGuwHe/UF+DyDxAHM6IdVuvV/MKWb3Xk=;
        fh=0XzUdDgX+RdlvFlZshEn/eIDzbFlZhMKtgqCgalEbzE=;
        b=YDRtFLaywyUdbGG6karXydnHPeS38ypkduLjWYVBVXfvCiE8lD+B6EwMV8obhIILZC
         8wRGyJTJTgsb30Ou+wXIUb3BuLsdUYAonFDAdQHcGqukHgH+bRwG85pU/K9m6+VmBTLA
         P33NhVBtTHz+apToG6folpEjEtds44Bt6eIsCHbwc3GW5lnvBRb0CqVAHT5zSCXreM9V
         rIO91rqY1VrU7NyYbQoy1Lzljk0bS7AuKqdUBAhpqXpE0wtdGGGHv8J6I79Tzh8M36Ir
         h0KfhgZsWeOAuCF2fzW4d09YrUedzHvlWqG+VzAhBMGgORF0m5y9PCQXpE+8VuXn6dum
         oFUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433309; x=1786038109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V4Kqw/TkLVkzGuwHe/UF+DyDxAHM6IdVuvV/MKWb3Xk=;
        b=KX8akFLHtACcYNXiox7Q/XgrKg8wu0mpLizPmh5rHT6m+Bn6iZcvnIuX5srGA+zGGc
         knRgouLO5vo6IiQu90CsvkGE5wvasCMNtnZKCZqEKmzlh24AhywLLMai8m+UIVFtIGuz
         BIJuxuXXf0YswZMPA61YcYsRi9qDAzSBin4/b/9H23GwTqlNGFFIzpU/mGSDIWwWZTnG
         w1D54XSMfE4EvZFTgebKtyqGF2uFYWDWI9rw4IrzXOAlP7ELt8tkbGduH5fwzoUk+W7J
         5GqTYzWSZQ+mPp82yQPqy2vi1vawte3pGMRft06WcGdsKnvuMxUmWbF1lX6tTt4y+s9C
         eJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433309; x=1786038109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4Kqw/TkLVkzGuwHe/UF+DyDxAHM6IdVuvV/MKWb3Xk=;
        b=Uofe8owGPJOTL3ZXG+dmpSnwgS21x/MVL8B0ERA3evE8rFcUoT5NOGHYjzCkouJgkr
         IhLoj4cVboZ+P4u6JmGCxlXNaz2zlgQGhuTMOs5MMpZevahvPPqciUSKDlFEgkQecP/0
         C5yr0FIVMJ5AJ+lNZON2/8OwPFwp+DKrAUoqp/OM3f8otY8vqSY/oP754IDH/TpBLz50
         4meBB2czQcyiPg+jYPUOUEITDdlTxG99lIy41lTGlcp9xUzinuPhcKS0jSpR2Mb1t6vH
         Bvpk4ka7qsc+swLR3Y1PVt4nuPTSgwzDx+LY9h9UsCrowOfRNPqb9HQyz8tmSAsboLPi
         hXZg==
X-Gm-Message-State: AOJu0YyMyvj+x9lVw2MFwwWCrSOvSRQKXJsL3r5YRuf9CLRs+oYLOurs
	+bfyJaSWO2e+IXf5odQbPwo8q3yTAkpustg5ZA4jvYTU/20hKd+aLknEUTaQ8ysvFNBsWnwtFT0
	GN+qbC7GfLm9V1c5KZ7NjuaiVKEN23Ig=
X-Gm-Gg: AR+sD13SrAWeojYEkFaamWI9FBpP37dymYfJfoAGPz9Da54JUfM6c/MMo5uuueuKf/V
	gOgWhnTs15KwJMgWpqe4x+w4IX4SbC7cwn0Ef4S3YV7dfSaG+NR7dhxuF4qb9gGj02TI/9H6l5c
	3XaBJZfcVeAXV/QqthS1DaH+XjW3p1ojJZ5WXVO3XPFl3p7JwLX7qlHUmQQqSI0W4oinCOuOM6b
	WHck1fFokztF8TIvh/14YNXpzBudPEwDudPZkHKrh7wEkW34IcipENDKGZWhAMMZUnZxFQnmc9i
	UNxfPQxsDqFBw8iR+WqFg8zbB/RO/LL8b0557+er/k8F0Gx4463mOdGpm6hTaKhVy77Y/XYrGSN
	LvQ==
X-Received: by 2002:a05:6102:3e8f:b0:632:5db8:f672 with SMTP id
 ada2fe7eead31-758300e81famr516959137.6.1785433309303; Thu, 30 Jul 2026
 10:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730141423.392222816@linuxfoundation.org> <20260730141430.052514003@linuxfoundation.org>
In-Reply-To: <20260730141430.052514003@linuxfoundation.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 30 Jul 2026 19:41:37 +0200
X-Gm-Features: AUfX_myUUlw1bvUmv3g2cpqmr_-9siqhv-Ltr18YbAgaPtiHVfgJ-bmln_uFUIU
Message-ID: <CAOi1vP_PpsJ_Zfe2YsqHOE6E9OCZvW712e+DBCdJve3pXwMJXw@mail.gmail.com>
Subject: Re: [PATCH 6.6 302/484] ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Max Kellermann <max.kellermann@ionos.com>, Xiubo Li <xiubo.li@clyso.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Max Kellermann <max.kellermann@ionos.com>
>
> commit cee38bbf5556a8e0a232ccae41649580827d7806 upstream.
>
> These permission checks were already missing in the initial
> impementation of these ioctls.  This Ceph allows any user who owns a
> file descriptor to manipulate the layout of any file, even if they
> don't have write permissions.
>
> It might be a good idea to guard other ioctls with permission checks
> as well or even disallow regular users (even if they own the file) to
> manipulate layout settings completely, as this may be abused to DoS
> the Ceph servers, but right now, I find it most urgent to have setter
> checks at all.
>
> Cc: stable@vger.kernel.org
> Fixes: 8f4e91dee2a2 ("ceph: ioctls")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/ceph/ioctl.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -72,6 +72,9 @@ static long ceph_ioctl_set_layout(struct
>         struct ceph_ioctl_layout nl;
>         int err;
>
> +       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +               return -EACCES;
> +
>         if (copy_from_user(&l, arg, sizeof(l)))
>                 return -EFAULT;
>
> @@ -142,6 +145,9 @@ static long ceph_ioctl_set_layout_policy
>         int err;
>         struct ceph_mds_client *mdsc =3D ceph_sb_to_fs_client(inode->i_sb=
)->mdsc;
>
> +       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +               return -EACCES;
> +
>         /* copy and validate */
>         if (copy_from_user(&l, arg, sizeof(l)))
>                 return -EFAULT;
>
>

Hi Greg,

There is a concern about the correctness of this patch, please drop it
for now.

Thanks,

                Ilya
