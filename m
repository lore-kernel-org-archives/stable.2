Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60624EBAC8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073941; cv=pass; b=op0QII1qU+i7YvZy3b8LIjc/d9HtDTJEQlz6pBvFusRCcwC0Ycg15s/aa6K3uqVim6Y0TNwuO+LQF0wL0lthY9XesVbDdi1uYgKkncSoQv95vTA+ZozSRlvvQ2lKS2NW+8GEMyQq6Nj39153nHzQI0neyYqxxGR9CY5IoqrHy6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073941; c=relaxed/simple;
	bh=GE0mUrsglv7uryn8BI9Nl070Uq5d0Ou2kQcEz9yCTF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBEkgN/RBEpuzX3vKk7JrksQ7U7zyGiUFky6/0s8nrGrxgHAbPgsRMskW5jFe/wCgGfdV+gRYG+r7GA60tMxob7tMsbR60q8VxPWreZ/FVoJtCtTJ6fafQwJ7hCQULh+vrHqKADiTCJqkgJjZ0xt2+C5pNnAhaZUu0hsXjKoyDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3ova09d; arc=pass smtp.client-ip=74.125.224.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3ova09d"
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-66c70f9ad8aso1852171d50.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073939; cv=none;
        d=google.com; s=arc-20260327;
        b=bONX9aOiKj7is2oHIc96PmC8kfZ/pX/MFjPraBi6U4cO8/sl4E4m2QByOaDuKf+WXU
         3Jk9lqfmVF6xA3lzmCt0C0ymDXc7aYZsdFJmcVNW3a+DMbekvnq79FPcVU5b7xM7Ku80
         STSg/I/V+JPEECrVdS0eXK73Su8XjZR+zg9riLzEqdXyLy+keAQh+eCAW+G38EeVVJV/
         MnBewJlvQ69hVFgSD1PbKFpbzmO5fLvn+4CzfaYm7nF8ZRgf5lxkoCpk9NdeJIi46+fa
         WQ9JmrNoTqpBhnYGHW5qgBDj1LZQnPG96w0Gz/ly8b5/KmprjQkNRbsiiqNMR8eLXGBP
         0S9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xSN1yQdp8zpcfJuoyWCP9n5+uPspbmcoGBxcmTAtR1M=;
        fh=ZaNpqkeZQeok0mfz4QF5nQ9+Uwsb3uhvGRJ25pB2mEA=;
        b=lwK6myIZaIYEh0eZPYfztRGmwslDxqRVCeOiSmARSoAJYPaPw3KHGsj6Z5DLcyHWEk
         x9IBbxrbRyNUlNG33n3u5jGJbyMe1P5Vc9GoQMEQQChhBfrECem8Ox/N6DaXGgBBqlFn
         KRuJkKM0pSbvDtpUuD0FeKpllbqf7kwS7Ii8HXVa/73bjOFJOOliVU6IpjrwWUO9KMpi
         AaNJZyGVBGKof8VbuFQfDoiewttHkL/kPeLXPxxGp7SkcjhpDTL1NSbSECq8KcQI0/FG
         1VLv1CVhDvUZVMuCeP/SJBiZutrj6PMibV6IiXel5EU0IUq64h4vUKNzl5YFiIv8K5m+
         QP7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073939; x=1792678739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xSN1yQdp8zpcfJuoyWCP9n5+uPspbmcoGBxcmTAtR1M=;
        b=g3ova09dfr+Gmy9t3OMHP9kkPaLHo53bE70nDznBBqFnK2CFZDBMLB+7sBDfFef0Pp
         dVqMJbLHKU1+PzfEHHhGhTdnxaywHt+5FF9GjXoWWyv1p9oH4tiTUeYRHle6o5BJ79Wu
         Hl8dAW6sBgalGNxC4MDbZp7ohGr54xED6/TNrhMbd2kCUqTP5Lca2Iy89HSpM76Vgn8S
         uOZHhRJ335E8Yu4iX/zmqU+paxPyirC5RWx2ioQjCQXIHvHINZeHnlyJYgH9Genm1Sm8
         E33W2T6Ofl5aEZo3oTSrE6b32es4jPODzCP9MEU1V1yhk3cdxHbJXAuX6QH/iinYMAf6
         MG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073939; x=1792678739;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSN1yQdp8zpcfJuoyWCP9n5+uPspbmcoGBxcmTAtR1M=;
        b=ks+5+KPb6/CtphneYeyjdp4mj4wmqGoyty12kVUNQWgGhKTZd7gOEnrS3/k+WB3oUq
         o8yA/MFp1V4iijjq4IsSVv6HwJhyeo3DHWHS5wzAqXM90HEI19sAz4zUNA3kyo2Ea0su
         khNN0knEGmMAuE2EkbcHCIEMKZ8hy/mIJCrc+TgN/LdpdA8BffbDACCY+rwDTK42e0LS
         M6+KKTVxMkBBMpVKnI0Xrrck0yWm2rHRWwhIKMSmU+oB0Swek6l1QSbZAQLhGbTk9rk6
         m6Op4hQKqSt6R6kfhT0J/FEYpO/XsfutKxl1gHs11uhd4UxX//J+wkJWsN9ErDr/QscT
         P8Hg==
X-Forwarded-Encrypted: i=1; AKwUvBxC4CH4uTbp74/RT9kEJFFhHl+Khp44+XwRuDhkgSfDRnxBpIzNVtX6FkDUvBZKkgyCQMWNG2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8u6x7qzH4QXC/vM8taEoez18hXnTs1o75pshDP0PNVylXuFP2
	DJ+RgmspmQYxtB7VCa3kF/POm/a5V5omfU3SnDAd73D88rrFelr9Ec1pJf237vuqLN6PFO79oDs
	l/I+YUhIbo9p4dQAplp0Cu+yFE8NNv8M=
X-Gm-Gg: AYBFou3n2pIWIrHLx4ci1zOf9MXYZ7pFa8NZWg0uxn98kHagOGrrprm+U3tnlMqLaJA
	EKhxbl9zDnUpKGIz31R/lzS9z/C7cR7DMRzH453+aMrUCVGuABJhtiWVl+OrXu1hVNjaKySy6MZ
	9g3anlHYMHnmm29eIaqPoCh4wip1W6B6NYtKV5fOtNwVx8DA1nnw9gaCNXJ7GbJJp8UBy/HZY2X
	CFCBgQYnsY75KRCETAxcPs0e+VmHj6tXJzu0iSNuctYm51fNaXyRvPcw9KTvNiRCcsf7ySJ6k9c
	19HOiAc8IOdB3AucA/VZEFJrm2qFpHahsMs24mQYsjNXT0cyGO4uagH/qjPXYAw3MJfwg1ISW3O
	eYaVDvuiJD1+cAGx7cfjsbtH/6Mb2vZzZn9MX+eqieyAW4lI=
X-Received: by 2002:a05:690e:1685:b0:672:f58f:b9c9 with SMTP id
 956f58d0204a3-67936a1faf5mr8821758d50.59.1792073937854; Thu, 15 Oct 2026
 07:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012144925.6728-1-jianyungao89@gmail.com> <as95bXy1IfqNUCFo@bfoster>
In-Reply-To: <as95bXy1IfqNUCFo@bfoster>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Thu, 15 Oct 2026 22:18:46 +0800
X-Gm-Features: AclHuK8aytQ7H4Nncmnmre9ei3UMhClX2_Eg7b6Gz9NoVPwY9-qoKaBctsbcYj0
Message-ID: <CAHP3+4Aea8kfmh5SqTp-dvCBrXEpAS-tUMwmm8aNkgiL4oYuWQ@mail.gmail.com>
Subject: Re: [PATCH v2] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
To: Brian Foster <bfoster@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, 
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <linux-fsdevel@vger.kernel.org>, 
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

You're right, the bug was actually introduced in 0e79e3736d54("fsdax:
dedupe: iter two files at the same time"), not the rename commit. I
will fix the Fixes tag in the next version.
Thanks for catching this!

Best regards,
Jianyun

On Wed, Oct 14, 2026 at 8:45=E2=80=AFPM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 10:49:24PM +0800, jianyungao89@gmail.com wrote:
> > From: Jianyun Gao <jianyungao89@gmail.com>
> >
> > When dax_range_compare_iter() returns a negative error code (e.g. -EIO)=
,
> > dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds t=
he
> > positive return value from iomap_iter() indicating more iterations rema=
in.
> > This positive value leaks to the caller, where vfs_dedupe_file_range()
> > interprets it as success (bytes_deduped =3D len), causing userspace to
> > incorrectly believe deduplication completed.
> >
> > Return 'status' instead to propagate the actual error code.
> >
> > Fixes: 39eb05112987 ("dax: advance the iomap_iter on dedupe range")
>
> Hmm.. the patch looks fine to me, but the above commit basically just
> renamed compared to status in this function. I.e. before that commit we
> did:
>
>         if (compared < 0)
>                 return ret;
>
> ... which seems to me has the same problem. So I'm a little curious if
> either the Fixes: is wrong, or I'm just missing something..?
>
> Brian
>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > ---
> >
> > Changes in v2:
> > - Add Fixes tag and Cc stable
> > - Add Reviewed-by tag from Jan Kara
> >
> > v1: Link: https://lore.kernel.org/lkml/20261010021010.19575-1-jianyunga=
o89@gmail.com/
> >
> >  fs/dax.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 6ba50142eeb2..1f6a4fbb97bd 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -2261,7 +2261,7 @@ int dax_dedupe_file_range_compare(struct inode *s=
rc, loff_t srcoff,
> >               status =3D dax_range_compare_iter(&src_iter, &dst_iter,
> >                               min(src_iter.len, dst_iter.len), same);
> >               if (status < 0)
> > -                     return ret;
> > +                     return status;
> >               src_iter.status =3D dst_iter.status =3D status;
> >       }
> >       return ret;
> > --
> > 2.34.1
> >
>
