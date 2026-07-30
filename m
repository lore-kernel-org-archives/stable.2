Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AA4399FF
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433182; cv=pass; b=FiR9cFENkAbiYX0xP3Rhee33I13Bulk0K0TX/g2afmJ3xffo34Vn5Wl0PpF88kx5kmmXAYouMLLs+VFcf7gYfBMaJwWH0Z8J8q2h3lKMa7kyjZBiRS72zKvaKxojdrmGNZVhgBBA1Ts0HUiYPpwVamBYkjNlER/WGem22Jf+p80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433182; c=relaxed/simple;
	bh=ulAtR4VuLOstpYyjAmbmpLdsktj2jnysAsOiRWaAHY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmBAhA8FGBgjNXu67HoXNO5vkdgJi+b61DSaVh7gPlwJp9yIF2kjhQ2d8FSLoDRlRkIIwLnpx6Hz0LAjV4R/BhdYBU1/7ewDUo1X2jbNtfAgmw5qELrcAiB1/oNa9cGZ1imoi5SMUI8+g5btTemc/3J0G4aTLudFJcfM+3AI2D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suN+wZRZ; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suN+wZRZ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c2dbaf828eso57831e0c.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433178; cv=none;
        d=google.com; s=arc-20260327;
        b=adphg3YKvuaVkaNNRy8MNcI7Hj6lwy291C3MlGhDKFPDAt5GwJTkaZ/575CK4CjWA7
         QKbqnPQroJeAxCkbGauCjFyJHXLHenRP7lBFquwtj9W0tbqsocz0ZHWLrr+lSTOrHjxE
         /Kk5vcIQ8qZU2ZMgTTTZ/C6bZxnlhyhXznP6NqY5cZGdcHyNuwArgJg1ndFmpNSNow90
         bUvdeliTOR1AmKWNKMLG/GtRLsY9hIkKl55lWS/+A59qoMdKI6torgLLVprF0CXXkdMB
         FnzjyDzk6Q12Qz2vbRKp3Mwwvm11oyTejsDm81Fw4wMXsnKBUGqJFsa+bU85kTP+j+9/
         KXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vu6ytu0gT7Wiwkav7oRlErUvDoo+NLXEtZJ0hg7CTow=;
        fh=0XzUdDgX+RdlvFlZshEn/eIDzbFlZhMKtgqCgalEbzE=;
        b=JZdYpbkkPLLbzLeIcZecXhEgCO2tLAdQjb4wbriwJ8+buDST68JK7PgwRk5sTbetpi
         9wxPn3IEX1xR9oXJIfga20lg5lLJLaV+dQnamwk9jLmL+l+paBlOPtVrRbNFwqVIu5D9
         +mWG6HpQhFDwDqtpelnFw05VfUI0n2EMkrAKO2/ypV0k/BqBzplmDHwHCToaPZTSRAcQ
         GCAyic8oIkrVceBWPAPJ4ZAK6hhmsJEQY1MgWG5+O7/AUgk/PP+o5D/OOf33R07nMJVf
         euhQndT4x7zdSckPHTeas7F+37VHbwrms+lYd8fh9XdJHNEJl5EEnAh/GjbtMDtLhh7k
         wmNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433178; x=1786037978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vu6ytu0gT7Wiwkav7oRlErUvDoo+NLXEtZJ0hg7CTow=;
        b=suN+wZRZ9Er1ByihI+5gnENMIe49wKbO4Rsbz6kmurNSNnCla0QX++rQxpysuLFb+y
         zc0C/aXbrbTmrGCDg0GvScEi/wWFUYqxs3w11iCmG6ARoSYFFcFlv0dc/ha/C4zxGMDG
         p4GedTo1gFn16iCiaygqJQUae01b7oFPTuLCfhZXvrqlNwDwf/FYNkLFUQ0qEezrmvpC
         Mxy2v41cLQGZYBqcnymp86/RLJY/dLGSdHm1S5LlZXe4LDOoJK1nWy881M6bwL0G3jId
         E3OY/74yGj/rB+jDFQdYt9NF23Wdgmj0SvqGfDyu1uXCP1KfUA5SoXV3u0Jbx26b1MMD
         WS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433178; x=1786037978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vu6ytu0gT7Wiwkav7oRlErUvDoo+NLXEtZJ0hg7CTow=;
        b=F82Q7H+7b+mRJnbQtGlOCAEY9kcu2+/wj1ZsHiaZCSwFuGazNyOVsKu+CPUJxgwTrl
         5OfB4/viz3gA0bsaTp+SGKseqqJ7oQ+N8Dq/d70DamUR9a+bjYOYQZuFPPP/46ZyCiLL
         rzMmc/BGopJ4mdskv4Gv9WETR5O8folLaXPGe9vuyhAY5g4qN8jO5xQUcBA7umZWJ6SN
         8AnMfRKAKnycamASpDwz2FlfRepaZyHhBdvLIh55ADz1ZthsY7ysrwMAOfLo1mNI/JvV
         pZZpH6icPOD2MWSB2CMypBFYgKYgKglJY/4j/FmdQ5b5MkcQ0W+v3Gao+5s0uRj7XrPm
         S7qg==
X-Gm-Message-State: AOJu0YwYVzUsGgNJr9QvnPxbzZwvaeujUOg9mKJrZ9Z70A5uG31kX6d2
	5aqPL8ClJUTNvQZUDdIwwHfbpBHYIf3GIEbRCFbdV/Fb1NjdCgbUNypqb6EI/jb1Y+a3tELytFB
	Vxc5TEpsNHO0uzlI+go22dZng73st0So=
X-Gm-Gg: AR+sD128K9Fli9XYs8fg9HvA6GORkNvLq4dc4jMYtStSJzp8UF3EzPgmqe3buCzlHyR
	U0tvgGhOZtQkputNtxJXW0dBg/v6U3ViX+wF8QIC4VVX4wRlcaKm6MIoeZRfB2Ml3EIrsRAwK6o
	XPrh8DdzL0JpnGiN0KgFyUqyQ15A67mTYVICk1gmTRqFV+2RwIL9PNHstOcvO3Vy8c2eP3Ac41+
	XQVDxMOSSDNRWYdxLtkKamIa8a+rj96gvP1LvAhdSDPimq01KDh5ecBIp4mr+iFYZoJ68eaLYV8
	uQ0RGaCAldO5ElWwSEiJz0UGCKW4AyshKAX4hAzu6sDuNBP2tIlaw1pf7buktMv1vi1Z/pNU9Hg
	lBw==
X-Received: by 2002:a05:6102:3e8d:b0:74a:992e:84f6 with SMTP id
 ada2fe7eead31-7574e3dbf53mr1246859137.10.1785433178507; Thu, 30 Jul 2026
 10:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730141444.267951807@linuxfoundation.org> <20260730141457.560203325@linuxfoundation.org>
In-Reply-To: <20260730141457.560203325@linuxfoundation.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 30 Jul 2026 19:39:26 +0200
X-Gm-Features: AUfX_mw8SHaCkrDz--v55sEJJG2F4tGTRrgvqUVHWojV6X3IHM3uGgB0MdQaQTY
Message-ID: <CAOi1vP8Ka3cbvY-wKg-WE+oTWmuJwgQpwJ1-mxSU6YrbtMRyKQ@mail.gmail.com>
Subject: Re: [PATCH 7.1 625/744] ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Max Kellermann <max.kellermann@ionos.com>, Xiubo Li <xiubo.li@clyso.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 7.1-stable review patch.  If anyone has any objections, please let me kno=
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
