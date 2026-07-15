Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD341F5D5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140240; cv=pass; b=hu4HVgDARm/Yl70C7PJDxOpyCHrl8vq3qgVpgTxKOSaT82yBPkbPtMzljLo4OMH8VJQsjSnKbxnDZqnfotuaWiW60jcDoDcQF6EMqjpV4fZA8wCOaRjuKy6XALwJZiMz03UtbJbhQ5DNfUj0yjQ/1I6iOjsZ7K4ykBu0iY7qVu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140240; c=relaxed/simple;
	bh=LqZQ7GhvjznYU5Bodyh7xffu+f6vi+N9hg5ldo+B/i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqf69PJodsZd7EQmzwtgh5p7/G23atfZ2dTU96Yjv+Mg7T7wQD8wZoauGAxZpbIMIQ2ol8/dd+4jO3JnAqssumaqyH93AsHKOXgx8evg5yLhqLXvBTwGSYKEVoxHZ5FGEPtO9+rqMRVYkzn4PDYXVDKi8NcrlofLBezXmw9W+js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9lDK2rb; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9lDK2rb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f60208a5so48688735e9.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140233; cv=none;
        d=google.com; s=arc-20260327;
        b=MHwb1+uOyeBbE1xwgz5LX4mvs7Cxt+6DD9XG1jp0sWpT2bgJobuVHIqOKaQxF81sIh
         msyJPpeWhiexzpZcwjoI+t4ePhutD6fb6TUBNSoMyzLMSFmusAXg2rqKuvfd87YdlyRV
         xaWTUiXla0fvJYiZ0JzZr832tC5UtTfWB2vTByAIFbuhvMvmSGQLcq2Uj1H8wfta/xLj
         bQZqC811mCr2hM+jiOaAtyPqve4rMcfZyWeCu1YMvijTgJMh637IjAGXeMZPOHGHSvYr
         SmQbS9dshXDMCfUlkERlzBXb1ujgVwgP4d2iIkpYfvkh6zPwfrf3JhiIPju64u09xBbb
         5qMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eflNygwkucfn8rSal3UDLFQ6W9vndZUg982/8SGMCAg=;
        fh=Eho8fzfQ7mtPnNV8x8wKKrnjVN0Y4rCl//XpF93uKBU=;
        b=lHrBX0Ud1jGHFAoFvB0J6BwVVkmdNeqWqEuGnrzO8vk0jQno3BWEErxnmB7AwQ/kxU
         hUNiUNi6SMbYqRZzooyWWEhHuHNv6kyeVmixkYEN2CnomkqXY9tQeS7OAFv/pnbqQhov
         JBTMGAJjNbzKVXXxeOsFQ8gs/aqDBPklcSTclWnFSnnwChTgfX82cktyOoHywcohi4A3
         VL40ruH8yu60FxzALRzFgVGtFIn9/8yVEG1Lj2Pgc2wDktL6+FvMbYkG1W4WUdjonNGY
         Z0qahHZXeTbYt6pvTwG+3ZcjxOoc86pPJSGNxPng8LdfPDBim8M67HAQ+O3GTaT5ixFS
         bZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784140233; x=1784745033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eflNygwkucfn8rSal3UDLFQ6W9vndZUg982/8SGMCAg=;
        b=h9lDK2rbq5wUM8wtk2YsXnGw4qzoqeJ3EsIDY/pVR7XozbzSKQyUtRi8aySNUnu9Ro
         1OTbhU7VqSIrhVpk2LsX2AjHbAm2oyKG6Y9uP0Kgdk50TH87//v/9TWXv06HVWImIC7f
         i9vgyIZG3k/3SfNByQZnYvoVRYc6X4+ADNaCYLzCjGy09eGj4eJkZsUt7OLg3QiejQZK
         TRIYH5Dbo05hTZXJa16QIzCBUKIlRQbVRhdNbH4lY4DdFQvXoVSU1y/9DbFZ0ls/8sxw
         g1SbhX4cdfzcMiEBI9t3yfdaNszZNo/toDaHkRMirviaiD7srqweQ1i+37JM0gYjwI0F
         8Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784140233; x=1784745033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eflNygwkucfn8rSal3UDLFQ6W9vndZUg982/8SGMCAg=;
        b=EsOZlpFDTz8e1p+qJJ8Y4DJQIrb06t1ZPCtF9xr4vPLvE+R+EFWyqTkpINfmlHoaze
         45z6X+zt7hTANLSDCrBAapatwhv7yflsZXimSRx6FjEJ6gQ2xTc5EolYJl/VbRmTEmCW
         YEfIco/oPbx5CQxluh05sa9DcR/rp6+W9IQto+R2Wo96nj74cG6aAxk3WRuTHNBL638K
         6gZ/mI605qbD1tJ19oqRlBO3U96zcM1vb8RR/RRwO1aDJ/MHwyfTlc4zZ2LnOdt1TLLx
         81TGOjtZMwyK9VkvJYocaTm4ARF5XTkNlG4wfwgQYQl86J594gnJt5/LgJMT/eldfR67
         +C4A==
X-Forwarded-Encrypted: i=1; AHgh+RpmAMKOGcFfxrRjxU45SNVP/BTwxTA08ijmNyRjD/I0OZ1BY/iYi0nMo1jW0I7RUh97r1UGqLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEVC/iKbNfqqZm2PJWEfb7afyhqADJ5nRKsZAGF3RO53xuwfq
	LOEycH30vzRxlnHemLGxtv0DJfIERaj5lU4arVLJVAWWDSFV0QlytaAfIdFJaa5Oj4X4LmZhcHz
	CeA6GNlsr0ygFhY2frXKO8tDPvA0y4pU=
X-Gm-Gg: AfdE7cl656/3iymUlG/B8mis3yUvd6uqOAsTLwWKoxtmnCWtkpgIxC0/jzaBAfZQy7I
	omyB/f1vDvDyxlqlU/QVrUD/tUaS+CDJRSSXxXL4k1mmY4p4rxwykR1dCzfK+z+cb5x3LpZnbmg
	w8gqP7oS1Kk4ZjHDhfDVV+gl2FQBeUkQ1hfu+nPRktVH6+YSqPirRxz5xM28cVVLHF4vlxZxRCQ
	b7bqNyYrmoJVlfdxa+dLoUB4a0iIEL6NBXTvGRzHrzi8ZovLte4GSj9RvyF3js2p09ilVkscZBo
	t8wMAMVkTUlc5684kQp82UyZQcrBbCpHf8HYkehoUf+RepxoyDyj
X-Received: by 2002:a05:600c:58d6:b0:493:f262:b8 with SMTP id
 5b1f17b1804b1-4953c147474mr38215745e9.1.1784140233078; Wed, 15 Jul 2026
 11:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714235408.1666063-1-xmei5@asu.edu> <20260714235408.1666063-3-xmei5@asu.edu>
In-Reply-To: <20260714235408.1666063-3-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jul 2026 11:30:20 -0700
X-Gm-Features: AUfX_myhxLCfqR4n7aGibfgh8m6ozVVwNoTPdhZMyVsgCsfFwX4PP36R6t_ZV1Q
Message-ID: <CAJnrk1YRmyaPeeBgd2HQSfmwDYm08cev__Y8LgyPyTqaTZE1vw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fuse: deduplicate the oversized-request error selection
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:54=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_dev_do_read() and fuse_uring_args_to_ring() both pick the error for
> a request that does not fit the server's buffer, and both special-case
> FUSE_SETXATTR.  Move that choice into a helper so the two transports
> cannot drift apart.
>
> No functional change.
>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v4: introduce fuse_req_too_large_error as a helper
>
>  fs/fuse/dev.c        | 5 +----
>  fs/fuse/dev_uring.c  | 2 +-
>  fs/fuse/fuse_dev_i.h | 7 +++++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index b8e43e374b35..56c38aca7389 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1584,10 +1584,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *f=
ud, struct file *file,
>
>         /* If request is too large, reply with an error and restart the r=
ead */
>         if (nbytes < reqsize) {
> -               req->out.h.error =3D -EIO;
> -               /* SETXATTR is special, since it may contain too large da=
ta */
> -               if (args->opcode =3D=3D FUSE_SETXATTR)
> -                       req->out.h.error =3D -E2BIG;
> +               req->out.h.error =3D fuse_req_too_large_error(args);
>                 fuse_request_end(req);
>                 goto restart;
>         }
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 4529505b2bca..cebd8f871627 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -729,7 +729,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *=
ring, struct fuse_req *req,
>         }
>
>         if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->pa=
yload_sz)
> -               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
> +               return fuse_req_too_large_error(args);
>
>         /* copy the payload */
>         err =3D fuse_copy_args(&cs, num_args, args->in_pages,
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index b511aaab6bfc..4958158c0f02 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -13,6 +13,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/fs.h>
>
> +#include "args.h"
> +
>  /* Ordinary requests have even IDs, while interrupts IDs are odd */
>  #define FUSE_INT_REQ_BIT (1ULL << 0)
>  #define FUSE_REQ_ID_STEP (1ULL << 1)
> @@ -367,6 +369,11 @@ static inline struct fuse_dev *__fuse_get_dev(struct=
 file *file)
>         return fud;
>  }
>
> +static inline int fuse_req_too_large_error(struct fuse_args *args)
> +{
> +       return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
> +}

Could you add a comment to the top of this function? Maybe something
like "A request whose payload size exceeds the transport buffer size
is rejected with -EIO. The exception is FUSE_SETXATTR whose value may
legitimately be oversized and is rejected with -E2BIG, matching the
vfs setxattr path".

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne
