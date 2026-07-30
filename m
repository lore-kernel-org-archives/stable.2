Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC9443E45
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433223; cv=pass; b=EpNbAXB8ermsSLQksVGFJGkaHybkxjD65kSwrU80g6HA07I6a03BSCV0xcNoM2z0oJ8R49qxfBM1Y9teaKLM0htbQaPnuXfKUUp6Ii3+DiYXlBm6EI2D9DDT9vOWzFJg8JfVPI5rD3JIb/xvta6Kcf1TtreE/dl5q3hwc8wUtr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433223; c=relaxed/simple;
	bh=VQYoRDa8djrStfRwliSIZQyvhHJsrSXXPRhrwSqEOy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTlv0D2Jdbq5Sj+dHEgRVEtEaOGoDdN69U6UkU9y+Co9+T0g/YcEu58VbxWf7JxZjiRUd3tIwcVfDMQ8KLesu+4/LWzloKZarrYxLLCT3r7/xxPxLb02WK1xZFk+a2roN+8F+lmdU6KORQOOvlnPoRnfjWcNjoQKP4bjUlbnhSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cieUyJwW; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cieUyJwW"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso50800e0c.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433220; cv=none;
        d=google.com; s=arc-20260327;
        b=CZGjA0rhov55aCqw7k2Wr1S3YRuHcoGZgWPqijOidrus/6FHgrLVjxJMffFk51C8Zd
         SAhQ3ag+gGz40QMTz56HzW2DHkNXRfTBc7iocM6SeX39K9tJFyUEbspmFAFXyrq1qoX6
         cD7m3chsZVW9IKiw3tMCwsE4w2XK3NzNQZAszNkg+/RgT9zsTb9bVK5UIv0x/nfx5vVk
         yF6J5oVRNajqACrrGw/a1Kq/G8upzVZkLr4H1yf6kTR+D7dMlOkFg02eA6HRtU16QKU3
         2+/popuI7UFDuXgk6PD74z2h7Gtl8U3R6hB24b+jJzDc/7DjqmgOHIIDBYeVoRiTpASG
         A+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rHM6MUOomu94ms0Fx6uSN9MB+yKFG/rLQTHmoENXpC0=;
        fh=0XzUdDgX+RdlvFlZshEn/eIDzbFlZhMKtgqCgalEbzE=;
        b=pIj+dawy95zXCujeiw/FvyLa3QsvvgSUThrHl6yaRgoUPptWMQnjJKsO/Mfj/gCy0L
         f8UMWz8hmk/6lkugzAG8sJ5j/4rWXyZRjGAGeqxkLOtNI1dBus4ktlA4HraWJv8NAvsu
         TYDED9m3JPzkokpEbuvOOhzImg0dEehMjasSLvTaawNJQXHF2QbeD9CQPBfriN40sK1b
         TkisbDt8+XFxt/Bk3HrMtHqb6/T+amP27saZE4wGSRhBauivMUhS3fHyE7NyxdwiOPWr
         gaF9Do0TOdvRZpMD90s4UDzhLSDtBuYP4tF/0UV8qRYRtAL/iB2rwgmqty/J/2abslIZ
         QaGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433220; x=1786038020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHM6MUOomu94ms0Fx6uSN9MB+yKFG/rLQTHmoENXpC0=;
        b=cieUyJwWIHdEJVPWNQnbsepeTaoHBJZ8UMs2bOV4KuiG1JiuNIFb8jsB4Hb1FTdTgz
         dohKNI/nPDygkCzrPkwHe+/Yl72L2jfKEvG6icIpdB0BpSqucZFIpVjBqz7U2hqdsIBS
         NFXvgznlWw3zUxcdL55z9YwTfL9W2CtaS2c17Dae+NvLJt00JeRI0druApmpZXVZCMla
         a5nImMy10G96rUOGsIJznuZ9Jtqi4nC1WrVq6aJZhcQnB4MSHxwTVUFb3YjiNuR5jeiF
         +5GddcmzyhVtXoKlaWb681At6Bzut+pMLBmAlezbIl4+o6sqctNdxP3+VgMByB6kjxNF
         /bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433220; x=1786038020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHM6MUOomu94ms0Fx6uSN9MB+yKFG/rLQTHmoENXpC0=;
        b=ktQr34TOGwRbB70ATyOFNofqweLooUJDyif20jr698f0f0GeWM1o+rhlRUWVEavR0H
         M7CRxBVxcElQYcI1YF+37el3/QaD41ku++JC+5lq2iVR+jGWMeYshgu4dG67mDZwl+Gk
         zjE2a34bTbNd082Z/IE+jl6KmXQJ4vThU19jnW8MmvO6OE36xypD+w7kmZO/vZnM4Ksl
         xl6sm/mplggjUgpVL2aMTClnhBdSuSkVXYRa6jaXJRjZYzf7HlkdI0RVNGx27mRy62AC
         ois6ezaVfVYtjBhv/lr+jCu59r1HHy2uSYE+FYZ2TkgVBFYJlWFWqbM/Y25CN2SnC7rJ
         znKg==
X-Gm-Message-State: AOJu0YxXyk7Ua6KG2Lgn+p44xC4Kpc5+lRNUJa+iWtNfBNJDW1LWTpAG
	tfVrC1/K15HOHh6ZHG2A/U4v9Cv7xaiNBymx1l/BgPwRF4LpgQiN+1HMdDOqMtS7GTitmLpqiU2
	BBPWQ5wpzZcHuAwTDenoSJTUHTDHo9B8=
X-Gm-Gg: AR+sD12fjEGbFb5ZKNbDY/dNrOuTeENG/cSSadCl+0ZwAs14uuqOLQaOudoN2k+p1/W
	+PTnSi4FHnd8Jbz+KxyEYUbi+/3CuMA2xNqvJ8n+2oRrp5x6NIi/pRBW3dcjvCG0JzInpWlXrvh
	FqYlkOK/Oh/uLbqAg8T5GgiGqqa4l9zLf8KofZPazvi09GRRTegW3gDN9Tau5PBtARHHK/k6At8
	Q/Q1zW2f5/zlpSvYYqkpk5HNiCZ/pSaAthnNE8Ov33QELkH8A+ydRxfLZufLYt3syfgIjSBnxN6
	4eZGOtKEgZuZBr86Fv8xmSyQrty1lXW3FgBxCVAFJs7sgmZA6hAyungGEnOtopjVk+qTAjdrz7+
	CWhpruL1w5xq3
X-Received: by 2002:a05:6102:50a6:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-7574d78f71bmr1124355137.2.1785433220513; Thu, 30 Jul 2026
 10:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730141445.110192266@linuxfoundation.org> <20260730141455.967176535@linuxfoundation.org>
In-Reply-To: <20260730141455.967176535@linuxfoundation.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 30 Jul 2026 19:40:07 +0200
X-Gm-Features: AUfX_mwF_KxgnyDyDefBgHI_hXMmlmwO9bJDhla7NkuoQzhG7n6aBswQVVR5lJo
Message-ID: <CAOi1vP_SPcsFYqEefOu4ayhh=E+y-b_jw2ySdUHT8QJbV9CS4w@mail.gmail.com>
Subject: Re: [PATCH 6.18 510/675] ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Max Kellermann <max.kellermann@ionos.com>, Xiubo Li <xiubo.li@clyso.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:21=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.18-stable review patch.  If anyone has any objections, please let me kn=
ow.
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
