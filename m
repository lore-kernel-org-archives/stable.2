Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926136;
	b=JcqKgRo2t7WmweUOqJsS3mI1tsBsaHxe5yEtahPx5sgSkuYCBsFNYcv05jl6EceGSfB7
	 dg3pYdzpUAwFtSmDQ8M7UsWfJG8fZbfYyVX3LkutcoThJYqVzHC9zTXoIPci1z68S5KVy
	 ZBGzsBdet29NgR3rDrVygrzcFfVJqiDEi8gUfBk7WbvVQ5YJlwUPmz+xQEs46IfYzOVHg
	 d4gujPcSR0FNjGTy18p1p80UnOXo5OkFnSLLKgeYOd/c8kMT0jE1xancH8oKLzYjeU6ky
	 UUwfbwRu/KmlxppuypXQbF65wB7wJXJMtX63aAQaEwTnxCcDO26uCjaltipvooph1CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
	b=5WbId/HzWWcgx+nH4D8usEkLEolsBmyvWKUaTaHQ/G0EycRrAjCgZYHCYclncvQbWm7n
	 oiK/uswPOGHMkghfU2E3nZHVVTs0/za32X4OZ2Kxqr1HfqKke63oQG29bx9V6GCzvtnLl
	 H/MfkW8sYRl6lN7hu8dTXQmd0QueQA6Ea7nOSPydDKQlaGGlC65VXqF5yjYlvdEfQgZAX
	 ip8Fuq70SpnEW6sgQ7GRdUtgEMglTSSRFu9yx5hZ4orHsJcEYLO9HcCHQpisFyPXsevmn
	 X1XsT5yADXx8qBOQUCBmRxepg/SHpuPb6nebQAywwBdAsGfBjzOrIb8at3tqf5rqSOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URmfsKnN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82F606AF58
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D82F606AF58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URmfsKnN
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso725326a12.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926134; cv=none;
        d=google.com; s=arc-20260327;
        b=Dynk+qYTgEJGnOJnn4iri5jZO5r3QUhdY7j8tZ6km6oeqImoKdhHXnZBWl9OuFxpu3
         IyYqtb3T5emZr4Qnd3PnQxreI3jThWP43DUbKnEbXQDgt5tRKJeYmVLR6ZhuxhzfvWp7
         gt/yPDKk0JX1IJQFAWRWIDsrKXGK3+NiDrMcsFMUUu4mrECvTr5/umT7a/BmMBowkJFu
         xJdxbIbr05BxPeY67dt9+QQDXZyElL0+xfdYBSLRADWkK15pgvklNv/9N57a11MYEUz2
         +xm/4PnEebuDILnk6mJTxBp4bY0Jm0t8zKyoGYulItmqa+EJWz5HHjw9vBcsNHIYIhtU
         KreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
        fh=Sv//VvSKF2Dy4eQzalG4+o1lwIJeRA7zwi2H04g5zhM=;
        b=PMLnZvLr1pot9yNHwwy3bNaC13KCK6shW21TxJ8+tn+zf5OJqG+r0F2tHSKnON+t2J
         g4YF9NZDs4tkarLY15EGTMphAuya2olRcDQ+NCi/uv6ZpN/WGW3/iILrNqqHR1C/gqjo
         GXUMW6YxPB1GhEh4Zl/LQESsh1CFDvbgF6SqV7vziacsGhg7J6lteNIwJijcLFwmcCra
         ytNcuNHOAKrE6uptp/u9J/tz0RR1bgLmsCsMLNhLBiCPEjaawXCqMZ7L1CCylc0wrxkj
         BHk7mC5O4b8nx9zfpRYIN8wSytkSpMkQ381OCfj0ZMBJe48lS1I3qtF0NazraPtts+p6
         LQzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794926134; x=1795530934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
        b=URmfsKnNWJSODYZrfj3c/NpMWLpE9pLm6rNI2X3ysZ7qIqhaoJiC5GieCaPi82mGtn
         cmALgIGRweZqbcX/4nSU9t5Sd7yGAyeSwUC00OBDXLEMsXK09GQO8t4Zo29ULjvYi6Al
         HK6l+S+GA+7vyo/WpBUEBAjaR3tv2GRNzV7JewrMFxQAevi0dZe9mFKoopmgsdpdOVGU
         BnOFpK0SUSQoJLXkIya5t79OX3bvHHrYXeIbSXVVmE8Dm5fXT2Z3W+RyHevDV30pL6oY
         ZhwD+uuaXvPO8SrEnbM11zfysNQhVTeKAJQ3IsfySXy0eu306VggRaS6EYvoJLP0BY6B
         sIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926134; x=1795530934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8Nm8FHzKmIfnRj5B6yPP5eTVD3vNbmx6rL+eezv180=;
        b=XWMsCiVvzZhZ7QseQ+1WeqBBmWVZDSBDtwfQiP49pjw6uQU9tpFU+wEipTRdJVTrIZ
         vn4KBY9BpHNa+zkxtcf6kkayAaLbTsX3M2xvtmQNlpgY1I/3QlC6AUNTmW8rUG60+H40
         uO7nTKG6JpvEjL7glGOOfTlbcflI3U+X4oLteIAnefmAf+ucbhsPyi+wWE2hnfRWBSpG
         v1umR+d6ylpOLnRuHZDOmpFV+3vgcDAC3heGeNDtIrmVabec3Yu6l8Yj5UBM8nsHBkT0
         gEcmbnrOJ6ePRNZs0Wo/nw7eEtY2/PKTvcvz16wKZOny0PO6i/McRyDda+ppgox7xdbG
         NNpg==
X-Forwarded-Encrypted: i=1; AL+hErG0GSKFZVREarRse5l9JsqhMMe1baPGb/XrgjpbsJzgVIKOslkYMxxIGyZ9z8HAAsAav5IXAsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RFoKCOBY3Uj5y3PtMpG4Prl+4/F/vFlzg0d70YHhabEatk5F/
	oopFDe8KdMlkOUpQnHapdFR9Hb0KkfEOneCdoV4lqZQn+zX15a09T5eGxDgDYphFvb0cosXg8EF
	vYcT6nn5xClySbIrG7GgUdLoVk+WhUNs=
X-Gm-Gg: AYBFou3da0XoljkIul1d2tWKt6DRn4Wx22PdsEyAKBpcLbRPEY5bRFYm/wXKaTeOVNb
	ma9FzyCKBEfcQuiL3ni+wM453kAhB/JYdkWHQPOhZ7dFDCUkw89qMKi3eQgyzG0z60Bx47Qho7+
	/5ap4SU3HaaZdkFXF3L3cJT5XIHks9+mlDQ2YKG/NkHa021gtlBTCqkl4JV9+uCXimxMdw9qLZb
	xNUdr5itzD3r/JilFsCIyOaztPkdl+gYUK1NSl3HpwcKYls13a7NUuq+HuaCD1BqPkF1N5CJ95m
	0imgAY0SQG5kK9ZglgnUgo7JCUTbm0xGbLzZpMR7wF/FvOndIAXLPMdIp/RVqp+AsO5REIxL4tI
	lk/DOEjN/Unasfavre1AihKV048UbmFruHhB/dByr8UdK0c/ZNBrbV5ds2+J5WwRhuEDzOV1dJX
	vzbY4UAhD4fzvpYhA=
X-Received: by 2002:a05:6402:2b91:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b859739689mr2260195a12.10.1794926133831; Tue, 17 Nov 2026
 06:35:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-2-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-2-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Nov 2026 15:35:22 +0100
X-Gm-Features: AclHuK8C4CURJWV2PAqKHkl0J2MOz_Ngu3IxgsUB1ZW-CuNtY3L1YeTqpgF395s
Message-ID: <CAOQ4uxjMNxS-jtBt7w4nwJpMQXFraec2UFDRoiXoQqs9eoq2gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fuse: skip dcache instantiation for readdirplus
 names with embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:52=E2=80=AFPM Junyoung Jang <graypanda.inzag@gmai=
l.com> wrote:
>
> FUSE READDIRPLUS can pass a length-bearing qstr with an embedded NUL to
> d_splice_alias().  Unlike verify_dirent_name() in fs/readdir.c, this
> path can create a dentry whose d_name.len extends past the NUL.
>
> For such a name, strscpy() in inotify_handle_inode_event() and the
> fanotify name-copy helpers stop early.  The kmalloc() and kvmalloc()
> event-name buffers retain uninitialized bytes within the recorded name
> length, which copy_event_to_user() and copy_fid_info_to_user() can expose=
.
>
> Some FUSE servers include a terminating NUL in namelen.  Follow
> nfs_prime_dcache() in commit 78d04af4995a1 ("NFS: nfs_prime_dcache must
> validate the filename") by skipping dcache instantiation without
> failing getdents().  Return -EIO from fuse_direntplus_link() so
> parse_dirplusfile() sends FUSE_FORGET for the unused lookup reference
> and continues readdir.
>
> Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v2:
> - Keep FUSE READDIR and READDIRPLUS getdents() behavior unchanged.
> - Skip dcache instantiation only in fuse_direntplus_link(), following
>   Amir Goldstein's NFS precedent; forget the unused lookup reference.
>
>  fs/fuse/readdir.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 1f6cf565477f..6b2468b575d9 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -191,6 +191,8 @@ static int fuse_direntplus_link(struct file *file,
>                 return -EIO;
>         if (fuse_invalid_attr(&o->attr))
>                 return -EIO;
> +       if (memchr(name.name, '\0', name.len))
> +               return -EIO;
>
>         fc =3D get_fuse_conn(dir);
>         epoch =3D atomic_read(&fc->epoch);
