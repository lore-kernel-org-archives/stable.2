Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECF431E73
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433255; cv=pass; b=FQDtYGIyyig9cFlFdWcTPYsEBXrrHxIzuz15C7vui1HimANfIslsnmQ2Oo+dibF7BDq+yY7vt/4/AoplFgkE13tg9y3x7EtSaKSCePbQBu8YO7cwWHchzhbhRvP8ANQ3UvHGSXrXNmPdhbopzquHS+R5AQfb3ILstPF5UXYlPzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433255; c=relaxed/simple;
	bh=VzPeMaow2cjP7QPl1BU1/NoTpWiQ8c3YWfCcejmcsdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQkPchz/Q1XDTOnol4/6hh5vvnDPbs7lp/3r5rmkGoUG8HsyGB3IJhpF2iqi/fc6lbpIsyia74pva9VRp2wS+AENNvbAFHlfcul/jtlHgjzdUP/w+XWzCzxZD7zN8pWXBdmLcVbmOG0e4QS7VSJibXolxyf3t93V+vRFti65jLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzmUpP/E; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzmUpP/E"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-963a722ed59so741153241.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433253; cv=none;
        d=google.com; s=arc-20260327;
        b=renqCiNr55dRGQsPdezri6X3n0Aejc4Vh+gogLI14/pTZQ52V3gvgGu6MCoKBPGJc5
         5cAjzGPy+ZT8DN2ZHi34V1Aabxfoi9d4rv04B3mbN2xMPZHq3c6AcucDaOkuYuI8KdVq
         YJ77qPJ51LfXOVqNzW6YQG5JkafakuRIJ6gti74XIs9UmCC0b3Xf/ICNQ+SVUijn4bkm
         p3jZcM0SwkX+nZj7yEwUIee+dzYUYu+FgNavfLuMQAHuxo1XqgSEOpUnyIyZi2aZLZ2z
         EycrVq4SlIc2QHSaP63AB0IKhbdpnNZZ3zjuZa+x9naVCgyER+6NsLKA5xlbJ7+PpYAc
         uB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Za46GFkBiCcCSv95JFZjk5TniDu2WbUeFUNdRNWHh1o=;
        fh=0XzUdDgX+RdlvFlZshEn/eIDzbFlZhMKtgqCgalEbzE=;
        b=ACXshFr6kQJgVKomzEnRs6FoFLYTfC1Yqb1Nq/JZtW5Qv2w27/PNqKQUGtHIkNXuRt
         SPKTsTAX+OKmTp5/tIj/i7OtjuHpyAvQGnnTBjjeLtLMGoTBahzI4qwNlL5mDid0pWUm
         uqe5bXq/Dx2KS1OY4AVdsFpnCUD8/nFNQulBEBGKHji1RHRd3t1U1Tvy/tJjiuZN8xx/
         bsXp0pseBnXnCwO1dyzatAOKcobvRhbyssuoHHPn9QPk+9yCef9Cd8DH3PNbs/Jj4NF7
         IgIQChliNpEDqBulZALK0JuARqRCedfX8c9/v2flDwu0DBknPqLUKxm3xyKNSrsCW6GT
         ALkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433253; x=1786038053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Za46GFkBiCcCSv95JFZjk5TniDu2WbUeFUNdRNWHh1o=;
        b=hzmUpP/ErUq6WGZCBsoa2IjIfXXOZbMTZjkS3xAKoCoFhTnhgjPK0B2ISpNT0W/iHh
         ta/9yByzmUg9Gd3HnAf3ZEinu8KT7ZNqksRqlnNC3llAuTvPqkRMqaNADbvsxfpfT51x
         bbKikilAHQ9zdq4cEUyZqE4ULoq/AI3FU0MBVB0pxPg06vcHsl7K/cp0fQaALvF6xUMl
         q7uIQXNQvy5UT3g5cjCfG0zMFGRNujP4yIp+eCyk8QRrMm2EL2JZt6jyUUj1YyVRsOVm
         YzfTYMlfF3rGf+4Xe0l5hUpVsw3AobM5YV9eJHyqY/WSl22wiiF0q3jJUY9j/e+KdT4L
         6KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433253; x=1786038053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Za46GFkBiCcCSv95JFZjk5TniDu2WbUeFUNdRNWHh1o=;
        b=kViDfFnknealB3OXqKbYD3GQ31sWMnakcHiah6mC3Mt6H3CVWO84xibDuOMbRlkjwk
         K12llJe/NNlxHtvUQC8aGC+b0RJGbThSCy3WvnwJB+C+sxreNPoPXCkXRgCJPqG2IWTp
         0nXQSUMpLgOqhETPpdYClLJ1cTaDFZLA0fYf3xRRIEdqCkgvN4F7jLI9zknIAkC8DjfA
         fgVRSBZVx1PIYcS4GWWH9kBuYGiCG8D9ocDWKXNWdzKNy2gtDWX3dVneFIdufbniLrit
         C+RaMYt7Wf67WrHD6eEPrn42vZqaQw7mLkSyFDgUtk+ThL6iy2IpE4bQ1xRBYCbshSly
         WNJg==
X-Gm-Message-State: AOJu0Yz1s7inq2C5zr1Mee10JirkXQKhwhQgggQEzmvJtoWOys9OBqn1
	x52X/N2iVMBDNxJuNtpWtTmpL/YHC9H+1fNbOTKoe8NQQodpSDOaiMM/3G6eWfZN3UUeEbV4olo
	ifgF3CSgm+YVf/HLyjAtgsKE5wQjaGJc=
X-Gm-Gg: AR+sD11BXoLM2kt1o9DZo0/Adl7UmeV62A+7UblFWwPv8DT7rlGPa6/IIB+89JBtCOU
	r6FlIuBLyeI1X3ceQybL2TJtP0MlPInd+SE5a+eFn8CfvQUkpWakTwWsgwBWn5AI+J2rYEEHNza
	PvKksc93gWGG5520MPOLFX41qIekyWSt5hE04TlWmEwVMvobm18g26yZyE/En15SEIBu+djzNZL
	VYGJcHLst+G0D/UqZe5hEqBXmFcQh+GYO2ZJnBIE5U43B+puVsk0bfodxUiuhNzYCilf4Q8bE65
	r/YRelUFbHx9SVHNfk7Way9g5u+OQrXYHQG/qvZXso6QmBBudMvsCTCuxbM7k9Fv6EnbVDqlCRE
	DYA==
X-Received: by 2002:a05:6102:3e8d:b0:74a:992e:84f6 with SMTP id
 ada2fe7eead31-7574e3dbf53mr1249224137.10.1785433252734; Thu, 30 Jul 2026
 10:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730141435.976815864@linuxfoundation.org> <20260730141444.131774875@linuxfoundation.org>
In-Reply-To: <20260730141444.131774875@linuxfoundation.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 30 Jul 2026 19:40:40 +0200
X-Gm-Features: AUfX_mye-Gtvfyg03yzdCq1En1BWqfP2uQbSgwAWQYc0ZHYj3yTfPeZOeBRSPH4
Message-ID: <CAOi1vP9HPx_H9jZ+2O-1W4Aig3D_=edzF8E8Mn-dnAF8sQ=v0w@mail.gmail.com>
Subject: Re: [PATCH 6.12 389/602] ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Max Kellermann <max.kellermann@ionos.com>, Xiubo Li <xiubo.li@clyso.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.12-stable review patch.  If anyone has any objections, please let me kn=
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
