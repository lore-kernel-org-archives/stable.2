Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947B35E949
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236367; cv=pass; b=XaGXRFRTAzbZ+x3Krbjap3K9rbTEKpBaEhhz8A8Fa6ZPoe3WK/RkajhcJt+T3o3r9ceaZFWA7rk0iKYIyhITYkNJ3CQhziuiHDyXWDxsQNK7Ww79Sy3G+eB38uxqvd246T9StzrZZh3ZbVlbnV9w5XctkZrLoeO5fBQDGnHqAcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236367; c=relaxed/simple;
	bh=N9qRFu4WM8WnVsbLoreYprSqHgn/OjQDC6eflC7v4CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unxfUHki4ZbAqIN9+3EnrLGxsSUxFkDiolKqCAu6rd7/I0blHVm4mvcgwe96Yp4kD50bD7KBzlwB6+H9wn4+niEGwIZR/ED6fBKBRoRpiEfEe1EURPE4GxIzjpZJ8puQD3o9X0LZi5dZGMYdZjgUoJjJMHEncC+6Ww9I+M+EKHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nw+n33BA; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw+n33BA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so4167852a12.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787236362; cv=none;
        d=google.com; s=arc-20260327;
        b=b9COtTl19SLeboB1XC2rE4s9ad3InLLRCchgtgLYqrS+EcJPBjvZUqczeCNdDCDhiQ
         XJhFqbMDO9LS1Y70w6xx3MILyusfNeymk+dasqYva4ulXgu8kh1ORB44ZhAG8I6Od2CA
         N++9vJZZkmmSKwVGsIm9RFfh7eNqHy00/2XavecgazT6PNUjUrzestCuXErk+BTNKoKd
         rB2ntoFMmC9w9htLzQjuDegtJGaX6katArfDYLq5gh1pq4TuCjKVVXx3QTz1VwF/LPev
         nBZ8JjkXNMnXRjXWgoj32c7WzWyqHsnSdME2JFIC++oEFni1VBsHBeGYKTIH4HjNo2Et
         9aTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        fh=JIFHpbC/26t797+lURmS9CGu9ygQBxzpYlScMgEdMWY=;
        b=JLprmqr3fUaSUEhG8QREHuBKvqONGnsELZ+pdQI28XHu4RKKf+CDCnCh1LrOjSZcRp
         bJJiR/DRwHftGz/VYtQu/Uoz4gznOWHKnI4ciKOZhfka1GEx364HUkab0AhgJTFcRkd9
         Klgh+ILeq/gQs0r7Uef6rpfD90k0eFs7c/l2riFX6MwJR4+zd9SvNUmAjeGlJf0FQsJY
         /+EP8HNRrySmUm2SNaILXESz26fHPn/ZjFtY/kYlfpaz4aPXwDxwT2eUrR/qNPnSBl5M
         hu4wxuniaNV4hC6sm+iKzhlwlF0OiITwJDw2O8sQDppSid+aU6Qbd6PVzBUiEZAZ3pok
         nJDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236362; x=1787841162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        b=nw+n33BAxcbmIcTtLDMF4ZP4rgK2HZx+JLkvY8W+XXy9dFsoyMwYFpmoBPEDNFMZ6f
         Cp5jaOBVvcgy57gZy7CrzLtxvwNrxDcfLRFci5SF2bCKyKy62EnHr9WAeI+A4k+pI4Kb
         dsx2WXVOuLLev6LUgXvDXYDlqGhVE3heP4kX6EczFQkuSsQVnYESpuJenh2O5UWfAwHF
         oPTmqZ/BqpiuI1n1oSHDqi82IxX130BjBnUdu/Yb1Mtse7nZehMc4EcxZhlN5j4EUkPJ
         9wW6U1nB1V0IuwHNG1Tu7ocSQX3QYXz07XVlrFMN1NK0vk7dKk+452gDHSXX4dujdU+x
         E9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236362; x=1787841162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        b=DZFvD5KLu8wqhT7cFbIcMdR5FLnBxz+DRKHhOOenx53Jz8FJeX//KoW6xd6UCd2l7D
         Nwf0QAx50hPmy30FQgng91DWrrN0RK9yEPo7RP6eTIBIvbUEmRyX64hy8RBGADSpfxFs
         nnu8VZxlTjCOqkVn0yvYfs6FTxLG8UpiTn7qcQ2xcYyzdQROdPl08nG6Ixij81UD5EO+
         1FpSvZVycegB5I2cs4ymhYsjgaqz4S8hXNVMqNqfj0bAV003D1pu+LHo5DiaEFBnJH57
         ewpMyl2oWACesE1hAS+kSUCFL72xOzux6wKGD43sx4QkwsKZhrnC6VrhS7+t9QV1fSjk
         GRwg==
X-Forwarded-Encrypted: i=1; AHgh+RqNWJSH18yIlwSI7jEaG7taYsLZg8p9/lFOMNOoFh/CcXQcRC+JmLfuyPKXuoZE6R0BUMqdrVc=@vger.kernel.org
X-Gm-Message-State: AFuF++n9UOC7sOfTWJ/UeEsENywY2YCMvwqBbr26K7EZd3c0NHO7crtE
	58WF0g7AZOgw4Hg/yNNwPOp5JI7rEWBEBcibbhCsJLXdELvPrgnlQ1OSkJNFxcBzMaBcw6IkFem
	AnZZp7Sv85z+pdgkbZHKVWfdRLeWUa2Q=
X-Gm-Gg: AR+sD134D2pLbHf0cFrQCsZoI+P1mcr4tB8wOoW+P9K9HaB8gE5lUvx6PM7tl+HW8qo
	Gjh4RjTGmxs1onB3QD4UZ36TG3I3ExCise8ZzjKzKK9FTDm18u+S/Y8GZMwzG4/zIBEqBdPSlYE
	bEvTKRvk4VtwkEFIfMoFR1JttsAEBmQQFHoDamlD63DLP++5OM2yGFLcX3dWR/HD3FWCxIMQ7so
	pPKkNumLA3vw/7OR3BUzxkgedndl0Mc/oicfgKGtBDM3PLnQepj9cEQiZPP5XSBtwZ+YhAtaGe3
	mGXoT5Ww/KQc975wyVi2xiG/7EuCP2lCiON78dtSrG1z7nQCuUrkJxts
X-Received: by 2002:a05:6402:454a:b0:699:728e:48c3 with SMTP id
 4fb4d7f45d1cf-6a4032fc5c5mr7757816a12.9.1787236361471; Thu, 20 Aug 2026
 07:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820061349.10542-1-kmehltretter@gmail.com>
In-Reply-To: <20260820061349.10542-1-kmehltretter@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Aug 2026 16:32:28 +0200
X-Gm-Features: AcwNN1XBsXitogIEUq0ntdJxL2LGIShvPphxQse83cuHfD_u0whlH1Af-ei3Mks
Message-ID: <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>
Subject: Re: [PATCH] selinux: preserve user SID across nested backing files
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:13=E2=80=AFAM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } agains=
t
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
>
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
>
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
> nested overlayfs mounts. The policy omitted only
> base_t -> mounter_t:fd { use } among the relevant cross-domain allows:
>
>   baseline: mprotect(PROT_READ) returned EACCES with that denial
>   patched:  mprotect(PROT_READ) succeeded; test exited 0
>
> This patch fixes SID propagation only. backing_file_user_path() still
> resolves to the middle layer for a nested mapping, so the audit path and
> inode do not correspond to uf_sid, and that layer's mounter is not
> re-checked. Preserving the full user path likely needs a VFS-side change,
> such as having backing_file_open() store file_user_path(user_file).
>
>  security/selinux/hooks.c          | 4 +++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944..8b96934e9992 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3849,7 +3849,9 @@ static int selinux_backing_file_alloc(struct file *=
backing_file,
>         struct backing_file_security_struct *bfsec;
>
>         bfsec =3D selinux_backing_file(backing_file);
> -       bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +       bfsec->uf_sid =3D (user_file->f_mode & FMODE_BACKING) ?
> +                               selinux_backing_file(user_file)->uf_sid :
> +                               selinux_file(user_file)->sid;
>
>         return 0;
>  }
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 3c0a16ec978b..853f7266ed18 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,7 +87,7 @@ struct file_security_struct {
>  };
>
>  struct backing_file_security_struct {
> -       u32 uf_sid; /* associated user file fsec->sid */
> +       u32 uf_sid; /* top-level user file fsec->sid */
>  };
>

Sigh, this is so confusing.

The fix looks correct to me but I would use a helper selinux_user_file() ak=
in
to file_user_path() instead of open coding the condition above.

Thanks,
Amir.
