Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72193481FA5
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063491; cv=pass; b=BXffggffIY5nKvKjLUXRrDVxjWsuMc7CqRyBf/bWG5l3QlxwotmLwWSPAa7phtdmlHGK6kys8Xxy9iHm2s+/MI9HucogD5+1c77qyK497iB6IqQk60FTp39LVhhk5n+ZJ8PonfhDDWyuhft7qGlKJgeA0xvDTqXzA3iRHSChkys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063491; c=relaxed/simple;
	bh=/JiSL9KtMYW39gs+t7l5GNFcMSkI1SwWlTIMXx+UrPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsWITzaOuCTItYN4W8z6rZe9bCLHsnbSxeBOXpinzEqMenjDYSqQyh/g93EUoZtzOQ2q0J8FQ+KifbXso+dDFTdqOCj6OxsN4g1ZApSXaA4Ja7iyJ1J/uWVYb3+Qhu0yc/wzCBfiapeZDnaczYtWjdlghYOpl7l+4Vs3voalCoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEskD115; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEskD115"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de0093c42so11866f8f.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789063487; cv=none;
        d=google.com; s=arc-20260327;
        b=GICHstwxOBfzkV0eMz5cMA9ZgVatksrB5DAnw5AUWcHFAw9uRX9lUsf7BoEcVvlNch
         jjFGWJPw4Jk7ha1kDlPOV4QlBPb/EvjoC7qIvdX4AxOghGUuBwJQMIEKMXt4zBZSsGef
         dsMjV3JUEvVycqXEkhD7fTj/5jXvqDXAFu2Q+xzb7i48ijh40CkgYwJCBuH2wM9uOay5
         X5Smu6yg0pFBW5FNzbqMnGs+6NQc9SuNUHQ6hRmz1Z9hnXd+iu1PCpfYwPccFuoG0ksw
         8riUPGUfWymRsE+H6WSHJiuAfWdD+WM0oTujCBREFvZlVn19OeGeRmA2+9NOcoSSICYd
         3UIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmlSkBU7Yx6aRJKzEZrvFOirNAsuneJxXll9dWdAM0g=;
        fh=0Kx1t+E+nY63mU9mzRNS2frwFvbDNBE1sOeLnz1Go9k=;
        b=Y4htMN3VhirjV1lfQ4SIq3Ga8RQGvTv8fDzEVLRV+iqU+2ODruvMUxb2O1eGF9tkua
         cDhM/oIFEHdxZ23AhBPkikH1/4eNvQt/g6FKhRNVlT7Aqd5TUidYvYCqZ4ZDVTvW28Z2
         6s/qhTxYyueIrltFdtxz5V0pzTUQVsqXDr+njmRDG+7NugJhH9TqpMD9bhwTZdPBi480
         uYTQLv9SqlP/7me5fqqAHudfVleQv4LYOamX0ZqCY7+Y+S8gTjDefeJMn1ErRTa7HaTI
         scqDEP/rfonhk7HXEBeq5HbeNmELpMmph5aaTOOcdTQJGui2eDrvIk4JZ/asKiT88rHO
         nCmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789063487; x=1789668287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmlSkBU7Yx6aRJKzEZrvFOirNAsuneJxXll9dWdAM0g=;
        b=sEskD115CpRrijD4cFzDelRYsF8YWzl7654MOPwh89cY6gbyQnrSMlfZ8+AKtEU6a0
         yil0X+5Y03DWkpDho47+1NAYo+9/rc5Ntu4BGlZoQvY8681Czq/y3kop9p1YyDoICKUZ
         Bl/BuaEWMVrX0NR9l6hsA07pLxg3p/uiPEdDDl2wqmLdkocKj3cSuATuNlc55zMhRcXf
         Yw4XpXsR/QENFv0L1WtfkrnWaBxCIUkK6+UxPETdSNdHUYunrvWKe8sYpr5ECPlUovvX
         Y4p4bU4kQSYZV/cCZbtjmxVcaudKGD0f5mYvLJEO66Mf2Oe/LztwKisydDQ/AtaAusff
         op9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063487; x=1789668287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmlSkBU7Yx6aRJKzEZrvFOirNAsuneJxXll9dWdAM0g=;
        b=qVOt+SmKkjcQ4GoStLfrw2ohld3WgrinE/2w2IbgmiOWiYU2qhvabOVCxIxksPWhbU
         OJ+v15Vsso/jz6GyTgcrn6qOTvKbZuyjYZe0C1rP5n+pZ4ADOm+QILAi9Zr+qoI6fvwY
         DMaIEYwkPuLf2q/Mp23gQrSbs6xxjDzZofAremHy9Hp3+A3dlE5LbEr/oOLBF6YiN380
         mheg+Yn/5txKVajDBy5VxxGs6TL/OEx3DYC0JHYaCkvf7dzl5BRxjNno9VovWdqvlnDe
         ccJRdqFtJGhg1zce/SoIQHZnrfR89oMBV/jv8izirewQlowmbJm1Axe8slqzDLgiK/HK
         rqEQ==
X-Forwarded-Encrypted: i=1; AKwUvByNg1v4Lbgzb7iDWu5qcZvwv2Wq866ZzU+eD4crUC88KMu5kunN6o41yF14q04/HTsyXxV/3jc=@vger.kernel.org
X-Gm-Message-State: AFuF++m9+tUDKRWZnNZvA4LKc0g9aBQV6XpYdy/HaPFkob4AH4Jvp8vi
	knGkp7H9WITR3Yfh/YaJQTXhm61rhJxpOO1Xf0VW8Tl3uiUxG6fsFSwVfyGc8tC799dBTqyCt+p
	cmfWM3130u8EYYaWdT9rxMTOg3m6JBdLzxkur
X-Gm-Gg: AYBFou3go5GIyNWkQtqbCjdetcVMTu5WgfIlZYbTiE5QtDxs77GMOYL2b3acqa14lNY
	4L6PBW9B5TosGhJrMY70/9oD9PI5DD4P0Edpm2cB5OyPK680qBXkKDaNYWUaafN1kyFP06lblZ1
	VS0Eye6H5Alytq0FBFtD3c99agoMCrk4Wm/3uBhLaWqD3urZUVqmHK0+2uBPjjk06KUcxuiWEZg
	GLdIDICN8GcT2s22rLhHDFWuDRXIbh1e7A+rRxZsTCCAuDqHGnwWVARAC96iBbzZQ4FW8j2C4XG
	nUsOKNIORg2DYDsGqWXsM+18gOGAAUhFrKO+KX4TBTZ4+pWfDvItWn8sUUuYNWpvxVH4+loBwre
	4vA+WRNgJaDo/TGcvbW3/4pHXvuy+DHwdtRg43A==
X-Received: by 2002:a5d:6f10:0:b0:485:8c16:5ef8 with SMTP id
 ffacd0b85a97d-486eb3104f1mr167913f8f.50.1789063487446; Thu, 10 Sep 2026
 11:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910022442.3594649-1-xmei5@asu.edu> <20260910022442.3594649-2-xmei5@asu.edu>
In-Reply-To: <20260910022442.3594649-2-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 10 Sep 2026 11:04:35 -0700
X-Gm-Features: AcwNN1UPtHpn5Ju1AbUXHO7M6POxnBVC4rOVn1G8Fc3LCftjvo7b6-mIt_6WkRg
Message-ID: <CAJnrk1b=WoRPqKLEex-WuTVxjjw95Aj77Azwzv=BeR9VTu4PSA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] fuse: return -E2BIG for an oversized SETXATTR over io-uring
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:25=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_dev_do_read() answers a request that does not fit the server's
> buffer with -EIO, except for FUSE_SETXATTR, which gets -E2BIG since the
> value may legitimately be larger than the buffer and setxattr(2) reports
> that to userspace.
>
> Over io-uring the copy fails with -EIO for every opcode, so the two
> transports report different errnos for the same condition.  Map that
> -EIO to -E2BIG for SETXATTR.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev_uring.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index c6dd420c4034..6351f2470e09 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -893,6 +893,8 @@ static int fuse_uring_args_to_ring(struct fuse_req *r=
eq,
>         fuse_copy_finish(&cs);
>         if (err) {
>                 pr_info_ratelimited("%s fuse_copy_args failed\n", __func_=
_);
> +               if (err =3D=3D -EIO && args->opcode =3D=3D FUSE_SETXATTR)

nit: might be worth a comment above saying something like "fuse uring
doesn't use pipe buffers, so an -EIO err can only mean the in-args
didn't fit ent->payload"

Thanks,
Joanne

> +                       err =3D -E2BIG;
>                 return err;
>         }
>
> --
> 2.43.0
>
