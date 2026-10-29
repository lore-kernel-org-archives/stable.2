Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793271809;
	b=LlDIT/5qDZDNfZxZuI22wyVoZqUGNdKi+NG7JJ8ODJczXKRDCVvPb6ebkHtyL3MxoByX
	 q/cgawJZJJVQBi7LjHFuLwTekfJVzhQgFu7D4ByW3iiqsmorVbA3SGsGhMQluYQr/AWs2
	 i7P3iCfaM3l9aOWt5r6TfRcYMqwXwwf3TE6gnBfXch5xPK69ocq1xeDGEAFSnw4l9xq4R
	 Ebm1ea+7r2gqPbjZSldGB3olPpRN6w/TJxC+OcZAGTvOj2H5jMPNejCFFD67o5Ee3hi/4
	 inh5P1eL5HLGk8bCidxk2fsgiMXm/urnvAJe4LgvBNyDsEu+FA3KARQkpzjRbckbgmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
	b=x1Q2X2csR/Er/xuU3foU23z6UFK+sVcVkFDvEm4i1MmNb5ODgCzC96jVIFAgm3aQ0t1a
	 s39lFEsz3u4e30rPVYQvueILF4YyC7c3CCbNCzm4rzOiggbXCw7/cio3GvjiRJRnI3aVs
	 ms39ose7vBQqR0Zypsj2xAlfBSrpzMmcN51Y1zTnMriKMLeUl8zpDqCARXhoGqn7lKcNN
	 iiMn0TAjjWQ3p75yw/SZcH6/Hci+Q0rGoopYNxGjvl5w29fqnLhTpPwVRkjWZGqTOYEE6
	 vwJzL1wnC6TB7qVWy80yJWSXg4i+tGAwmv7RfmMTnlb8yMi2GfM1imzSEJAVevJ9svw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAmXfFyx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69764606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69764606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAmXfFyx
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso434444a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793271807; cv=none;
        d=google.com; s=arc-20260327;
        b=TbaYwiAh5pNThUvuJ/YoXuGb1Kp2P7Gr3dioQHehQ0KpWMjBaRcEbqbIDTEq+3PLlS
         UbVhErKy0xLUwATzTk/WoiSvRNBBX68oJKjohmII5n57a3dl8tJRltZKyAa86gwqYZgU
         yVjdq49gk0NIuvBPfJeAC0xAXSyniCvdwCQPD8HPkFsBDu6Ys6Q16TMJDpn8JwOQt0qS
         uddt1/bnEXRnz0b8U2s/P0nq8YqmQN7od8qP1W7Z7xK2JHkTdoYLrQcMA92DtCINpS/s
         Avt4NwitHw1i0mIdNCA8dGaJ22xyKEUy9U4JLuPBlTco1dyCmyRNF6iHDOpU/23FNJTv
         OQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
        fh=RTI8H+UBQvJlIoFiwxHQAmsz3ee8I54aTOSePkt06K4=;
        b=DUEzEJ569bfvNGnt0fz88o2lQRFAdJQ+4clSN2S8KRViXC7nqTOHGiTwKVFY4nvTpN
         xpY8wjtpx6lxYI4ndSVHKndvJd328msfZshIKEtOGDIU6nMopxA7hvLyIw0bz0/dauF0
         +vSTjhC0rVK4+AJNV9mP0reAo+j1He3XrEpf9l99EFp7xfI6DFoLSwkgRzh9umDXFEfo
         nEMdMEbL3cyHz1w5wW3nRMSr4MLYwz8mnzd8c9jlSom8C9p/KbRoKHmRbvyjLfKI04tD
         wDEjFrWenTE+IVIOFWdWHLys1XJ7eKfKdBwKNyA1YXwGRwxQbIhyEhFPpP+uvI4A4AM2
         LUJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271807; x=1793876607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
        b=XAmXfFyxR37ur5ieYkpUjtc0G8B7XfPmNN/QJVLMm40nz0G3ycyjyEIPX5tjlf59il
         CMGtoROgxaFWYpUVFtqBpQDXWF1CsXLq+YWIoYLDA0ssMCFszt51ULbe/IWEYIFWg+Jo
         wePXQyzQIx1rz/BHtW0ZJjKH28dy6w1RgznDWiXhbKjdwaVbeVDt2iYCTqZzqf5IKows
         udP5s/lqTK7Zj/ZnB2Eozd+J+NE4iBmFlcY7jskXteh+vNhjd9YO5jz3M5dvrhRH4TUk
         aGo418N0Lq/giIhsVKwF6I+PbWa84+LNxtGwB5VavIQgheX3c9hpH2FaguMfjlY1Nx+k
         q8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271807; x=1793876607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
        b=uC66AC/TgovniQnOz0BrtKPQYMcx//7kEIBvOu0y3qUQnttnUiVu93jIguOIsQzKgm
         DaAB+fejKjWWek0GQ38EeRGMj1gz0Hx4zJ/4nIuaCE4EriUn3sF/BFdvYp/ICvm3CpBq
         ZpcmznU7BgHw0mpLr2qgjCNz7f9Pg7DClHAApL1GiAjfTfx/LQg0TDZtW4s5npOt/Ffa
         m51hXy5rUi+fpbTJM+fbzPE7qoKPf2Mb2YxYcRTNuLU3qZMk5oRNtz9CGHCp3pSOC8B9
         7GOB+qhkcZOvY57SU2FODZSM1t6Rjv7nkHjDO44eMBiaRh3dL3VbxwV/0kkXSE5+D7dY
         F0Bw==
X-Forwarded-Encrypted: i=1; AKwUvBxT5zgBmMhyBkPSIBSnzC73Yxn3A+wqFgC/Xsv8eYKPQg0xmn0SqtoJO2i2xjbz1q0Quk50L8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs+rqf/eaLcP7Ql0731dDpcJI6ZozLPWjEJR75nkIt8Y9NRj2+
	JTJQTvM86gTMilrpaALO6DdUvbM9/aF34ua81cXuRiyj02KyP4i5Hjkjbl0K89MQxAzoTqKaUHs
	T2MROJnigB7gh+4LFhlvNW9nKhsQraHI=
X-Gm-Gg: AYBFou3lQxiNCoZP6vEUD69d2+Tpe8Tkxcm7EriUfVHz9aTE4GIPomjieCYwASmG6sa
	EfqL9K9jjjYBZW8V71kAqvxsi9yvjsyhNkZzawu0SQ3S9UbeyrAfDX9/DsUS36Oys5Togj/kEzj
	6cIBkuQ5IlCy7pBMDaEWjfAQuz53Meq9nWC+YEzGlppZLyHAeAGb9VFWE7e833fXzCq42TVk8FO
	UHa9WI/kYzu1iDZFx72wPZ5v2vw/PNP1eArrBIUyuGr9EH5DEnnhbbRpIfe8azqEezO+g3cRXrj
	VS/FP7y71Pmut1N/OO6T4ltAd9XHZKvQVTOacDHJXSk/K6Mg2X8PsOIbLgfwZTTv38rZyeYjR9S
	gviedSJhRqVqm5929pzmLlSCfgalx/aCbuNruxNNripyxLif9G8xykgE0cZafu8opKYIEbw==
X-Received: by 2002:a05:6402:34a:b0:6b4:1037:2bb1 with SMTP id
 4fb4d7f45d1cf-6b49cbe7cedmr2797089a12.22.1793271806191; Thu, 29 Oct 2026
 04:03:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154008.67451-1-dennylin0707@gmail.com>
In-Reply-To: <20261028154008.67451-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 12:03:13 +0100
X-Gm-Features: AclHuK_jPOxWwcTntrGiyWxXQmQ4_F2fFzrd1WHf0WA2kaDI5_4JgryUKHV6fdI
Message-ID: <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com>
Subject: Re: [PATCH] ovl: restrict casefold consistency checks to directories
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:40=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> ovl_lookup_single() compares every positive child's casefold flag with
> that of the overlay. On casefolded ext4, regular files do not inherit
> the casefold flag from their parent directory. Looking up an existing
> regular file on a casefolded overlay therefore fails with EREMOTE.
> Symlinks, FIFOs and whiteouts are rejected by the same check.
>
> Restrict the child consistency check to directories, along with the
> corresponding assertion in ovl_get_inode(). This allows nondirectory
> objects to be looked up without rejecting them or warning about their
> flags, while directories with inconsistent casefold settings are still
> rejected.
>
> Fixes: 16754d61dc69 ("ovl: Support mounting case-insensitive enabled laye=
rs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/overlayfs/inode.c | 2 +-
>  fs/overlayfs/namei.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 63906b3dafcb..4428c50c3185 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -1278,7 +1278,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
>         }
>         ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
>         ovl_inode_init(inode, oip, ino, fsid);
> -       WARN_ON_ONCE(!!IS_CASEFOLDED(inode) !=3D ofs->casefold);
> +       WARN_ON_ONCE(is_dir && !!IS_CASEFOLDED(inode) !=3D ofs->casefold)=
;
>
>         if (upperdentry && ovl_is_impuredir(sb, upperdentry))
>                 ovl_set_flag(OVL_IMPURE, inode);
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index ca899fdfaafd..023966d89f74 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -266,7 +266,7 @@ static int ovl_lookup_single(struct dentry *base, str=
uct ovl_lookup_data *d,
>                 goto out_err;
>         }
>
> -       if (ofs->casefold !=3D ovl_dentry_casefolded(this)) {
> +       if (d_is_dir(this) && ofs->casefold !=3D ovl_dentry_casefolded(th=
is)) {
>                 warn =3D "child wrong casefold";
>                 err =3D -EREMOTE;
>                 goto out_warn;
> --
> 2.43.0
>

Applied to ovl-fixes.

Hungyu,

Thank you for the overlayfs patches.

I see that you are sending patches to several subsystem, so I assume that y=
ou
do not have any specific interest in overlayfs casefold issues particularly=
?

I am asking because I got some patches for overlayfs casefold which I do no=
t
prioritize because I do not know how widely the feature is really in use.

If you are interested in reviewing or testing said patches, let me know
and I will send them to you.

Thanks,
Amir.
