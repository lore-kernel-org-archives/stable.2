Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486630;
	b=sXxeqBwMzRO2YiDUuYv95FdMZGJk6QDzeFsaCJjmyqGnY4zsvrTPXZA542OF5FgqCb0I
	 eoIesU3IJnpTfu5OxjbBOn8B+zVlUNXYP9HfeFfHgcBf8dNKjER2/Fj2f9AcNDdxJY2Fm
	 vU123/QFGmTHcb29TIhpTibmzCt5BEim+iUzve/R1WzvGWPA2jYg9eF8DcJ70BhJj8VcG
	 CQvvgkXbBBGhMsEp9HzfuGLGcGRUSYHp6FYp5M3d6nw5huWbH9qXF/lsBn+kCKvcvd1Kp
	 U3CkO5rOQHWQi1ZLaBD0mYuvqLZUO9V5W/F76pL3/qjrymF10KvHOZLKeDPveuw2qmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Scxxr3QZh8rDu03xKq9Qg0FPWQFgGwpm1Y1nnFDFd+w=;
	b=GVkA2/v/loct0B18/KTo9r1TgUNFuJ+g13LHRPBfuivVHcQ8oBvUuaEGmbQ3lViQzqbU
	 1BY4UfbUGXIV63VDdiovnrU6VPo0GMvn88RediKQOv4J7dQzmIqJpdDioAQd+NxcAnunx
	 PBkfBQPMk3xjd/SBAMlP9iM4sxEJi6R9rJEEXTUuP3VpsFgxYFJjpVW/lod03A5KQALLg
	 /ypfTd3v4Q2fXSag3Xkk8C/kvKWsWzTji3oc1TOvEPO89T0xZtYnjjVF29ygpn5L3IesH
	 UoDLQ29SvI8GAYoIy/A7XYB76YsGvS8W/ZDXrD5kr1OlG/9LcCYUqhiTgEhMvIF2ixw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gSborAVm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A37606A891
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A37606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gSborAVm
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so26840065e9.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:30:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794486628; cv=none;
        d=google.com; s=arc-20260327;
        b=VI6SewbQrZjLKPs5H+og5L5lZsPdOvMX09oxH1ASeMR4wukwpxGzC4IVCdJeGJ6z4V
         3TgmeZkHzBvGFfPX7gOgH8/9iK0ohF4nnOq6IwQhpbKZ8beqdH5IwLeNpcyOc2WbD48o
         hP5ipvXcwuqrYGW5jT76YBQ8wJK07R5c4qs35fIwJI6O1eXDgSVIAANEBwnNWUJMesqO
         I8RsE8U8z5Eu4dUpqsy6NmKVefybljs9W7MtOQe7LrdkJ6QYafvHcE2u6H+3oOcoodDV
         F3tH0VtmkWqIYMGwmZn0ljRhzp3HtnX1mhwIu8ewqoVskF9cBwdl5+HNcp08yI9Zsr8F
         eVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Scxxr3QZh8rDu03xKq9Qg0FPWQFgGwpm1Y1nnFDFd+w=;
        fh=SrPbsAvovFSL4S0DUc9vV0q61Z+jQ/JDiZRaD/SrT+E=;
        b=MTiQTyv2nBBVDpzTTAsWMQob7R6o7KxrvwlBWJjxJveyV3a37oQr3eOYoyZzmMtu+k
         RcH9kAzTAtJTNzGUwDgjDIO/JTJ0gA+ZfQQ84IwZBMfELOoUF428m/YmZESaQoneExds
         Ue2dMuXZKy+xY+yZGeRt1NxigTyhPOMgRHYkxmJGh4RwOQv0Vc0yZnQvmWbQB3SEGKtN
         aF2mNpx0goN+g64zIXeZUQGYsoNuRjFIi6uB+7VPOWWEzFGCETF/T87Nkuo6bDHJ838j
         Zi2ONdSP+UoYmrjq/X63DQopkBgPxhC6kvUr4lpEoJ+gV9LYqeB85tD/wH7BE8gPV+PR
         p8dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794486628; x=1795091428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Scxxr3QZh8rDu03xKq9Qg0FPWQFgGwpm1Y1nnFDFd+w=;
        b=gSborAVmkkKT9hNmcAK8PcnqOV4wFyarCBbkcBPTiAhT82LtpYRmAG3zz0qKqzme87
         j59viw6UAwG7ijwgyq3xQ8vUVz8+fAVyuOy0QoYHCSZrEzlhFBampRpSs/D8ifp9KFA8
         xkTXJiA9yxczIH5p8TIWcuUsesXNa5yZRO7yAFbTHPrRVBjU08Coa6Puy8E1KY4t3l9R
         kzHQVMSKAu5WP/FX8zjFikyyqwIuaKEMt2t4xjfnSnlQtbmuoAtlJjRfdSbtyxEiUwcO
         mbs+bqfl5cOlPYwNQC6/9nhw2By5N+2/HNDpXPG/eyg8wdg6YYEdGio06FRavL9JDdCe
         rzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486628; x=1795091428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Scxxr3QZh8rDu03xKq9Qg0FPWQFgGwpm1Y1nnFDFd+w=;
        b=xiSPLvSHYcYkodziZK+ja8FK2aN0lBTJVpvH5QUQPGhVaDl7EvoF3NEFqdt6AYtPYM
         hsRonFDhgigEc/V2aVLEW/JSTPChee1a02PxqY3SLP4CQpgF4ZARLaob9VWqnXl7AbIa
         c8TY4DVIHghUIs01XzQSuP6QBtFkxelN1JFBqwDPdwgsWuia30oCt5FAFRhZV41Wq2iz
         Z2nBRqVj0Prd3MTWtgYVNOnXZDr8RUgWjRBnxF41wBHwgA2ZGrld3p72lT0GDTy+Mnhw
         1Y4T2Wk8zmyMW9ROSjptdOF3bY0Q6bdmvQWwSGunoaAYHMevIC5lLtYgdsepoy0Q6EPp
         eKIg==
X-Forwarded-Encrypted: i=1; AL+hErFlVh1j4I5004c/+JL/48ag/laLsCiZkobU0xi4F/0DraIqEDT3l6tCKBfmYhzEp3TQhqAHPSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y7uDhC5S+ZlBk1lmTuGZnLeSaM/SudnKwHI6zQ4gpl0t3Tk4W
	xkGmZiKBNjv7YyVCRGM+37V5onvUsZTwcjhZUr1kXkaftr7mfxPJ7llRLcFTr0R03ZZyYwnaoCA
	wJA2rP3+kv52OdWnBfTy/vk06vIKTcUc=
X-Gm-Gg: AYBFou0CNvIewF6Za8zYX6gkeUxZ7129j5+0URf6qauPmFMxnqdKxl+pUG3/TbIb90c
	DqPabSje5xx3qBsw4CqIsHZ9uI218jR+/b722MviMqPqryeA7bQwPmfN0XdDT9DJyMPB1TmUt0H
	lnoVogChnHgALBSZWYKka0ZHdXxAfUb88QYkCxlAVzyhG6AkmEVinP+0BIGTgSb9zdzWAdLSIjm
	YWwYNB21Cdydmtf2LPq1aRsk3nmmZTx/53++SwClRQO/wy3pDxKA5onxpKtus3bCQJ+Ym55I3wx
	D3e5Y+IdZY8ARUi9KhxxqhaaTv4CADYHZ4yLwMdsziN572Wu3wJW6cMvuGX9UuHJg1J9E59tOW7
	eKjPaTdKxJe5Kt0V1S/tHJO9SIPeLLlnkhyAqCSlYMv8+WFk8La4HFSWBHlP47/xDh7Y3UtJpyj
	cdtpvk8+yE+ydFRjs=
X-Received: by 2002:a05:600c:46cd:b0:4a7:a5db:a93e with SMTP id
 5b1f17b1804b1-4ba0931c26emr98068605e9.4.1794486627822; Thu, 12 Nov 2026
 04:30:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111224227.2496049-2-Jeremy.Jean@oss.cyber.gouv.fr> <20261111224227.2496049-3-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261111224227.2496049-3-Jeremy.Jean@oss.cyber.gouv.fr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Nov 2026 13:30:16 +0100
X-Gm-Features: AclHuK-PALtUIojkOvbIjpvKnSsZMgTvb-UczhCsAjfiBo_uVoM0-bxZwzKBT3s
Message-ID: <CAOQ4uxgZag+6MrkJsCXucUBWDaKWptkoZOStZ6Ns4+17Lw+=hQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ovl: reject different lower idmaps on the same fs
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:43=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> Overlay file handles identify a backing filesystem, but not the lower
> mount used to decode it. If lower layers share a superblock and use
> different idmaps, a handle can decode through the wrong layer.
>
> Record the first idmap on a private lower clone for each backing
> filesystem. Fail if another clone has a different idmap. Comparing
> the private clones prevents mount_setattr() from changing the checked
> state. Distinct idmap objects are treated as ambiguous.

I got a bit concerned from regressions, when lower layers have idmap
from same userns, but not the same idmap objects, becauses I have
no idea how different runtimes setup overlayfs.

To reduce the risk, I took a conservative interpretations of Chritian's
"just fail the mount" [1] so we just fail the mount if index/nfs_export
are requested and leave a way out for the poor user.

[1] https://lore.kernel.org/all/20260925-server-hager-riskieren-06116eded21=
3@brauner/

Applied with some changes below...

Thanks,
Amir.

>
> Fixes: bc70682a497c ("ovl: support idmapped layers")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  fs/overlayfs/ovl_entry.h |  2 ++
>  fs/overlayfs/super.c     | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index ac07e8769f9b..5b2f1b930daa 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -24,6 +24,8 @@ struct ovl_config {
>  struct ovl_sb {
>         struct super_block *sb;
>         dev_t pseudo_dev;
> +       /* Idmap of the first lower layer on this fs */
> +       const struct mnt_idmap *lower_idmap;
>         /* Unusable (conflicting) uuid */
>         bool bad_uuid;
>         /* Used as a lower layer (but maybe also as upper) */
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 8bc970748b96..40eb8428a718 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1141,6 +1141,21 @@ static int ovl_get_layers(struct super_block *sb, =
struct ovl_fs *ofs,
>                         return err;
>                 }
>
> +               if (i < nr_merged_lower) {
> +                       const struct mnt_idmap *idmap =3D mnt_idmap(mnt);
> +                       struct ovl_sb *fs =3D &ofs->fs[fsid];
> +
> +                       if (!fs->lower_idmap)
> +                               fs->lower_idmap =3D idmap;
> +                       if (fs->lower_idmap !=3D idmap) {
> +                               pr_err("lower layer '%pd2' conflicts with=
 idmap of another layer on the same fs\n",
> +                                      l->path.dentry);


                /*
                 * Lower file handles identify the lower fs, but not the la=
yer,
                 * so with different idmaps on the same lower fs, index and
                 * nfs_export may decode a file handle through a layer with=
 the
                 * wrong idmap.  Following copy up origin without index is =
only
                 * used for st_ino, which does not depend on the idmap.
                 */
                if (i < nr_merged_lower &&
                    (ofs->config.index || ofs->config.nfs_export)) {
                        const struct mnt_idmap *idmap =3D mnt_idmap(mnt);
                        struct ovl_sb *fs =3D &ofs->fs[fsid];

                        if (!fs->lower_idmap) {
                                fs->lower_idmap =3D idmap;
                        } else if (fs->lower_idmap !=3D idmap) {
                                pr_err("lower layer '%pd2' conflicts
with idmap of another lower layer on the same fs, mount with '-o
index=3Doff,nfs_export=3Doff' to override.\n",
                                       l->path.dentry);

> +                               iput(trap);
> +                               kern_unmount(mnt);
> +                               return -EINVAL;
> +                       }
> +               }
> +
>                 /*
>                  * Make lower layers R/O.  That way fchmod/fchown on lowe=
r file
>                  * will fail instead of modifying lower fs.
> --
> 2.47.3
>
