Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717212;
	b=eubCkjhbVV0UjC/+b6JQtSY6wQGa3mM08EcnnvjOcnRXkRrw9TlX+VfYxk6HbXYuh5yx
	 LfgOlRlOOkPtYawg/Izgz6h5Xvs3dqAcz2r28iG9XgrVM6z119/em8q6hDMXfcZnD6mVZ
	 iV3V0Xyeb6Oacc3i6qVDOUY/T+l5erHO1K4qETrFQLGB5BWJIPD0CHVYOA8WofyHuoMrX
	 ATdKzaE3hhPNEv4Pveo0RWarnEn9c7jEihJrxoRtiQJREZAe48sO+qGf5kkB3ItLb+zRj
	 h+vHh30dWUvDnnB4Nlg57BSyXA+etEOhq3GkSEb2EUUWMTzewph5+5+bT4iQWPD5rqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
	b=iLnzRLXdxUaAd0LQ0c4v7BunTxGh1OHhV0g0C4aP+aAXXnmB6KXwSWYCdXDpYu+OYYcd
	 rNtf6uJ0/c/NJ9ALPqk7pQ3+IPoI83gnyeQNSK/QttMS17uQ0QI9EUlJ3CoNPagsXMrlL
	 J1PfEVzn7BEi+LbegOSR4kiNnLMucFjVeNOhdIUW+HnV3XobOr0qcHCcGlhACok0tPCzh
	 2UdxqWP9Gjeaoy0lR4DGMfVvn7rEf9YWTLHG2dn1mW2Q6uXvAlho2eQhpI8xJeIQyej0P
	 ggYGzd0XsjX3QMtl2VI27PfbENk49pHAkkGKe/eGkMPIiZbjlSHV9nLFeApLUVfOJgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbwMCgGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384DA606D802
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 384DA606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbwMCgGj
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4c9abc1824so656200266b.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717211; cv=none;
        d=google.com; s=arc-20260327;
        b=RGUYcuP/hkTJV7j7SX+8gI2YERAcFnQRikUBg8yc3Xws1Wuiq0+j6nZlJKNVrmp/Dt
         gGTWFB36IFHiGxxlbkHkmNrklD7PgsoTiqBA5vU2vWbuPhF6tOP6fIaZBF6jPi2LtTzq
         R7Ru3H2mjp6oEh1x+1CgQjrQJGJSHUAj92VWpu+aZqyw0zjEPRGZOiFlURLS7caaE8by
         cnZ0Vy2psyTOPL/w4A36IsPIjiiV2yKOGAmRknWTTCjrhZATsrIgrcOD/B3/+ISyHt8I
         7N771rxtoZ2eIZXZnBNP9H0GjyT4S0IVKfi+uWyeW/gRwRHn4EL8+49HGbx4lxJmPeCB
         /L3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
        fh=HPO3IJMY75Vm5OD6S4yeiFKO83fPUZt9Dvph5rUXenA=;
        b=fLzPB9EiTYIP7KriPby6shH7shWBtC9+A9GsysexwyDw8XojSRoPTTyYSmddNlNfvC
         pZFTbACMQe2zpnYVCT3Lgqpra2Q5QMXvR2JcZPCVKdNqWZolHb961GUh6hPzGtYa7bWg
         VWSVAK2isnckfbo37pqIViTTcFyIfTlleY3Lz+qFl02vcRxUZ+hY28o7eil7ROp80czm
         vVI1tabj0K7/5Sj4F2vtnltAwo91DrX8yxtfSa7EXvR5N4oB36B8NmLTucv+pu0tEjEG
         HS8ebtp3MQEDMqcpR85cxUiboCIFbn4ibreAm/3iJFtGte72GJAOlJF57BeBC1oFtULQ
         i9ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717211; x=1794322011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
        b=YbwMCgGjapu2U4cW1LFSOzILIQ0bSem0oNun3PccpxdXy+Yp+l6dhte7Ey/vMaRasv
         mVCO5ZvXD+lirtIbu8AZKZDQWMWGre7XuicW2XukzMqcwRpWuHLWeib913i5htOazuvi
         zegXmhzyR9p6r9sL7PocqZX1FLzZlgRVDBjn/GvzVNnuon/fhKVuJ2MVF3sZvmpjzGvL
         o34ur4RGVmC5fGWdgDIAHxLYGYZoMSlbD6+ptfoVla9YKX+loStLyPGsoe+0FmT/9r3l
         2rDUfS9GmVdLWZttUWzZBfO1l2Er+tumP46uZi2ywLaQJcbLikbfrzHH8FHw7JPMWAOM
         Vz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717211; x=1794322011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
        b=X3e4xw9LSnMMGbnCTonYx2tnMlCYrVhG7Bz87ZEwzJnGJANf0C3SQQwp5nCJ6ZvjzN
         sfrY48h/93vNx+9jecTywEwntXhvggbsE9mUqmEeDxPzjxu4mF3z3PI4svvFJFMieznu
         bjZhht/j4w8KDF59F+9HVsZnEd8YBPhemHuVoWA3sarNnu9FACxYrQPqrrmwoWU/OOum
         apxARxJ5Enr0TaT+ff2raM5+UEM6G+VRw7yJUQ/F2Q8x+wXiTiPLW6YXSaKWfbgK4Rqo
         50igaaJDUb+AL0z338pUxyauzlqB4l3iQCooII5L+kTf1V+/DXkTROOIevBQuWpF8MdD
         jzLA==
X-Forwarded-Encrypted: i=1; AKwUvBz5A8KAlAPFNg49bBFbyvzQqlWi9Af2z+H36h3dlRsg7BWlRbH9yUboPbSFwYnWeXvtnvUjlBU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gek/AhS2pXgjzeiN7I2HpsEOYsgbJQAWD4wVrGOhCEw3ZqoCy
	WJhQtjextPiMLAtP4GJB7gEONOKbGVIjULHLj1mNghVCjKOytb727vonEpPR+VTFkImk0xKH5wm
	vczuWrwJoJE7l8HE8yfjCvmAh1xG74yg=
X-Gm-Gg: AYBFou02vrhbCBn2M3I5XBTByJReCR3fRM7jKia6AubMBF69P2Hh/RDEVJj7su5YH7a
	SVHNvm1f9KBBw4TPIJo8ugHOzQy5BYjsmM/4LKfQR32L+BlbzUGb8dBiDvdKUrw5oYzboSq9/os
	uXXKDFKS2/sPjhNHQc0LEvcYjw7eaACDXzR7a78I3d9mJXcqJEMQqcQMTcl6Fb5U5HUIRoS67ZN
	UamNI91iQ0C6pmXP9H03hJlG//2GuFXsTMQ8PEjQ/eU7tO7DLME9+VvlJQ7lccHW4jWXBUlOEfD
	Y6t55wLRj0mi0iHhPcSgEeFbmIeteoO5kHCtP5tBaBjOyZ05DY78oJVNxGSypJx3KtYk7qdTOCc
	KxxsoRCnB+8nz5PBbLuZ4OVhgtDZT0tgL9yb+o6WO6c5Dfb+ZXCrkI8K7TOhnHyYu0O1fPw==
X-Received: by 2002:a17:907:1c89:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c4ca7a4e4b9mr1032689066b.17.1793717210181; Tue, 03 Nov 2026
 06:46:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P58Wrer--F-9@tuta.io> <20261030-welpen-anbinden-nullen-b2432cee1d10@brauner>
 <CAOQ4uxjm=cGPnug18VuhKqiMvkWwLPNLO_TE3KxO8iLZG+veYQ@mail.gmail.com>
 <P5Qu3co--N-9@tuta.io> <CAOQ4uxh67+vs0mr-Lxmwz9-N+F8m29WUNz+8qFLLDpOVYB7=vg@mail.gmail.com>
 <P5WV0VL--F-9@tuta.io>
In-Reply-To: <P5WV0VL--F-9@tuta.io>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Nov 2026 15:46:38 +0100
X-Gm-Features: AclHuK-AkbE76i1M2E19O6SFPWAt7p_ENORS0HKIxbE5f-oUtF7Cy50LrWBo2WE
Message-ID: <CAOQ4uxjYX+A_xRBmfj40hmAcuQXwW4JPUmhJ9bx5ymSr0QoDnw@mail.gmail.com>
Subject: Re: [PATCH v3] fs: let backing files inherit FMODE_NONOTIFY from the
 user file
To: Edvard Conrad <edvard@tuta.io>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:01=E2=80=AFPM Edvard Conrad <edvard@tuta.io> wrote=
:
>
> On Mon, Nov 2, 2026 at 1:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > Good catch!
> > Please test the attached v2 patch and post the new test cases.
>
> v2 fixes the merged directory. An impure directory still deadlocks the
> same way: ovl_iterate_real() reads it through ovl_cache_get_impure() and
> ovl_dir_read_impure(), which v2 leaves without the user file, so
> ovl_dir_read() opens the upper directory with plain ovl_path_open():
>
>   fanotify_handle_event
>   fsnotify
>   fsnotify_open_perm_and_set_mode
>   do_dentry_open
>   vfs_open
>   dentry_open
>   ovl_iterate_real
>   ovl_iterate
>   iterate_dir
>   __x64_sys_getdents64
>
> That takes an upper-only directory that a lower file was renamed into,
> on layers that share a filesystem, so ovl_need_adjust_d_ino() sends it
> to ovl_iterate_real(). Passing the file down the same way v2 does for
> the merged case fixes it for me, on top of v2:
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -670,7 +670,7 @@ static bool ovl_fill_plain(struct dir_context *ctx, c=
onst char *name,
>  }
>
>  static int ovl_dir_read_impure(const struct path *path,  struct list_hea=
d *list,
> -                              struct rb_root *root)
> +                              struct rb_root *root, const struct file *u=
ser_file)
>  {
>         int err;
>         struct path realpath;
> @@ -678,6 +678,7 @@ static int ovl_dir_read_impure(const struct path *pat=
h,  struct list_head *list,
>         struct ovl_readdir_data rdd =3D {
>                 .ctx.actor =3D ovl_fill_plain,
>                 .ctx.count =3D INT_MAX,
> +               .user_file =3D user_file,
>                 .list =3D list,
>                 .root =3D root,
>         };
> @@ -714,9 +715,10 @@ static int ovl_dir_read_impure(const struct path *pa=
th,  struct list_head *list,
>         return 0;
>  }
>
> -static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *pat=
h)
> +static struct ovl_dir_cache *ovl_cache_get_impure(struct file *file)
>  {
>         int res;
> +       const struct path *path =3D &file->f_path;
>         struct dentry *dentry =3D path->dentry;
>         struct inode *inode =3D d_inode(dentry);
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> @@ -735,7 +737,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(con=
st struct path *path)
>                 return ERR_PTR(-ENOMEM);
>
>         cache->is_refcounted =3D false;
> -       res =3D ovl_dir_read_impure(path, &cache->entries, &cache->root);
> +       res =3D ovl_dir_read_impure(path, &cache->entries, &cache->root, =
file);
>         if (res) {
>                 ovl_cache_free(&cache->entries);
>                 kfree(cache);
> @@ -856,7 +858,7 @@ static int ovl_iterate_real(struct file *file, struct=
 dir_context *ctx)
>         dput(parent);
>
>         if (ovl_is_impure_dir(file)) {
> -               rdt.cache =3D ovl_cache_get_impure(&file->f_path);
> +               rdt.cache =3D ovl_cache_get_impure(file);
>                 if (IS_ERR(rdt.cache))
>                         return PTR_ERR(rdt.cache);
>         }
>

Right, I was being sloppy.
Thanks for the fixes.
I added Co-developed-by to attribute your contributions to this fix.

> Results in a VM on 6b4b543fa18, each kernel run once and with -i 2,
> with the backing filesystem marked:
>
>                                 file  dir   merged dir  impure dir
>                                             listed      listed
>   + c3d355f427ce                PASS  FAIL  FAIL        FAIL
>   + your v1                     PASS  PASS  FAIL        FAIL
>   + your v2                     PASS  PASS  PASS        FAIL
>   + v2 and the diff above       PASS  PASS  PASS        PASS
>
> The new cases are posted on top of the directory cases:
>   https://lore.kernel.org/ltp/P5WKBbq--F-9@tuta.io/

Thanks again!
Amir.
