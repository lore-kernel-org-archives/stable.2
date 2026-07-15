Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F0437127
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108428; cv=pass; b=GyrGFF7hw6TpXvnFlzp98TzGii9oHUNCgezoXkDMFDmwEqUtJQYQhU7xrmaSO+r8ayDRSUwi+Hfl2+R+k+2fu5add7vS+ubVqqvdQAc4Sw/cHo/DT4qeov2OA5ofAcxLUcT3557betd6nGvZeV4jVlzPxKVk+fXThxAIn4TCk3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108428; c=relaxed/simple;
	bh=u5x5UjFfiIypuUG/u8VBeYI24RclQQxYRKNVOEumIHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iexZpxSxWb8WoD3WLEkTJOw9EgC07wnSRXyLQKx20C45OPziTI54wZMKEEfSS/XZty5EbOCYLjb7u6kirdWGSMzCMN5+x1fDJdmnHN84kkx8EERdxWdrA8UcHhDUdWg2x+v3sb3wThl2zG1D6GcG+bVCZs0w9LgUUf/waL36Rpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4D4in7/; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4D4in7/"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso804226a12.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784108416; cv=none;
        d=google.com; s=arc-20260327;
        b=glxPYFFYNW4h6sCanovs2lvP3R4ZX80UGjKJ9pWyYhkQoQIV+95XzNKcYLl7qlwREb
         eqdOQ+aBZmBzxtcKRUkTAnH5c9YX1U8gOsnd5GDFMMownKsJh/3RNJyvA+BMj7bzZDoR
         yU8+nmFkA6dN2XrGNPu5f83TszwkAmPea7HrosodNPBPiSf3ITsiLt783c8cLrWHPRPz
         qrtnbEN/b8cmO9i5Nf7dzLxkQDppZiLrDSvOD2Kr/N8ju3O2xT1InrO2Vf6G01A10kim
         TmOFvnt0P1EarQH+QC7PLqnem6Sghgc9oQizSuKaVV43z/4HTwgmeTookvRzBDBJE3ln
         HaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayP+P5/Pd6BGHZjCoYBRcVoPcvH07ra6Sodaq/Yi54U=;
        fh=lbvIoN/pLvcafNjKakeMBuZdDGfM88P+l+c8H/86IOc=;
        b=nAlFXa56n+SEhgBfKVuTDHTFfGGTUUioxmnuCVlWawUH1PobmaWXGxkQ55IyW5l3Pk
         /+4ydV3o4+eZpWKzJhZzlnYz6X6fC/9zwI29wIgIJjVF+20PrDjYseTPc+4avoccGyd4
         udPnU9aKacfpvzrQTpBQLDAkz9IEWtKCgpwyRgu67ctCAV+d/B4rg/SgqweFCn9SbZRo
         Jt6qdxeispDgCIcTwDBL3i9v5hdmPQ8mt2A5QX/Omyxm8SaxGgj76Hc7EkaxcjqU1edl
         SdVhEwmCzaWzHDVRJXnAWuUOtgUoEf8+fcWvLX1tgrVK5sXTBtIFQyyNTgZfYfHBoroE
         g7Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784108416; x=1784713216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayP+P5/Pd6BGHZjCoYBRcVoPcvH07ra6Sodaq/Yi54U=;
        b=e4D4in7/Ck70VkX4eAF5tKnxnFQv1sMZVZApngXtf0s0DtyigcrQr5S51R8GYijc7H
         jnCfC4twqFHunYGeKftAi1OCutBidgVGf4UbqEgECct5OlOwZRxe8epzr3L/O34zqthE
         cJ+ngDEazznFCLLzYdaoxMoK3kZZCG0s0bO/oqYRZfTQt+i2MA/Yx8LCRxaTnk1MVYp8
         jLQmp9z/3rqDwHAjCiM5BdcZ/VhzrWtCF6y4EXjmlrIrKa6OlsXq4okB8iyi5FH8ZprY
         NjsL6cZjf3I0rnGWj8imgDOeV0HHOJuFHdKm7nZ8zQgbTXUm2wLq7TYfizM6h3iceIVu
         xErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784108416; x=1784713216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayP+P5/Pd6BGHZjCoYBRcVoPcvH07ra6Sodaq/Yi54U=;
        b=LYe91uH/bmI72B5/b/QKxAwvfF/1G4d7itFfmAzYyCxcKxz9wzh51vsjUVkS6w62X7
         f9jwP6ZH7kolENhB7r5UkJIKZ8UK6Ynl4fUujucBS7pI1vV7ltK9Jnry5x7b6Hbr+yKM
         XmOqkHfQ95Q/yL3tHeYljX3a8smZyt8O9lkwlsZt2jidmQcu4C1RFlt4jmCnKMZwZSr2
         gysYqpEiOTIxdNquUvPDOsV8AXVAeLNdjMNqiyJ05PB4X+FJ0k8wQEdzKixtojXu4Sgl
         GHojyUMrnfXCNX+4O/SrXsOKXT2txP4JDZIL3tJWykL0FdlpJsFUhomJCPePUHT3TKsG
         CsPw==
X-Forwarded-Encrypted: i=1; AHgh+Rol5h9ranbSnTLkjOqUKb2d0C2RRpRCJTvnhN2ux0O2RofDiUTPx97oJgE9OGiBF6DVctb2snM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxOYtOjaNikDUPL9MRC3Gi2BaPu66gwXqvDeLfH1zDRdJ0jya
	PGA+YBeWxO+W5C2TXKy4l+Neb0RxkCz7x2g+XNrS9t4SP2I8i5MCjsJ8P+dFjMQE6hHdZwY/2Nt
	SUeD7R50GJROe5xtyOahiVBHUUIrspZEvDARP/YQsag==
X-Gm-Gg: AfdE7clhtqWD8YwDNYxzHaWSDqKmQQnlRK9kXhN8xye0ACfcoESXWSzmdYFolUV2tSy
	PNnNXo1hYzDSqz/GlRbkLqa7F0JO1uk9bbZyBESAJLTsC4St0/gertVIA3DA9fnZhvsNHgc0hzX
	vvJOf7ypKpBGeqLIvrVvGISrQIgF6ObO0K17BN1nVcsG5Mvc212JC8pzYFPpWj5H16ZurqYdikX
	gUZHoO5VfDAGV2Kco7Rt7CnsXzuNVtYvukZrHCgFpT+UYONnhVTQGKDYxALk3+QDjKYGo92Ew==
X-Received: by 2002:a17:907:6e86:b0:c08:5bdb:e904 with SMTP id
 a640c23a62f3a-c161e89a8f7mr791839866b.9.1784108416323; Wed, 15 Jul 2026
 02:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713220932.413004-1-amir73il@gmail.com> <20260713220932.413004-2-amir73il@gmail.com>
 <20260715-seilschaft-fahrbahn-talstation-6c45445d2535@brauner>
In-Reply-To: <20260715-seilschaft-fahrbahn-talstation-6c45445d2535@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Jul 2026 11:40:05 +0200
X-Gm-Features: AUfX_mxOzjZVXHNjf0PogjbfsvYj10SoFZT144LLQab9SavhtKt6eUxVr6kJ1c4
Message-ID: <CAOQ4uxh0J6CMCeUYRQX7buf+SHp2Az4kvWWvtMk9A1h-tqhmmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: preserve ACL_DONT_CACHE state in forget_cached_acl()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > The ACL_DONT_CACHE state is meant to be a constant state for the inode
> > for filesystems that want to opt out of posix acl caching.
> >
> > Commit facd61053cff1 ("fuse: fixes after adapting to new posix acl api"=
)
> > used this facility to opt out of posix acl caching for fuse inodes with
> > fuse server that does not negotiate FUSE_POSIX_ACL (fc->posix_acl).
> >
> > The commit also takes care to gate the forget_all_cached_acls() call in
> > fuse_set_acl() on fc->posix_acl because there is no need for it, but
> > there are other placed in fuse code which call forget_all_cached_acls()
> > unconditional to fc->posix_acl and those cause the loss of the
> > ACL_DONT_CACHE state.
> >
> > This is not only a functional bug. Properly timed, a get_acl() from thi=
s
> > fuse filesystem can return a stale cached value, as was observed in tes=
ts,
> > because set_acl() does not invalidate the unintentional acl cache.
> >
> > We could fix this in fuse, but it actually makes no sense for the vfs
> > helper forget_cached_acl() to invalidate the ACL_DONT_CACHE state, so
> > let it not do that to fix fuse and future users of ACL_DONT_CACHE.
> >
> > Fixes: facd61053cff1 ("fuse: fixes after adapting to new posix acl api"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > index b4bfe4ddf64e..3dc62c1c2708 100644
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -93,6 +93,13 @@ static void __forget_cached_acl(struct posix_acl **p=
)
> >  {
> >       struct posix_acl *old;
> >
> > +     /*
> > +      * ACL_DONT_CACHE is expected to be a "const" value and xchg it w=
ith
> > +      * ACL_NOT_CACHED would enable acl caching for the inode -
> > +      * clearly not what the caller has intended.
> > +      */
> > +     if (READ_ONCE(*p) =3D=3D ACL_DONT_CACHE)
> > +             return;
>
> Still on vacation this week but I took a glimpse:
>
> If this isn't what the caller intended, having ACL_DONT_CACHE end up
> should be treated like a bug. So shouldn't this then be a WARN_ON_ONCE()
> and return?

The caller has requested to *forget* any *cached* *acl*.
The value ACL_DONT_CACHE means that there are no cached acls to forget
so the call is a success.
Therefore, WARN_ON is not called for IMO.

Sorry to interrupt vacation.
Let's continue when you get back.

Thanks,
Amir.
