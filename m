Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA2357CED
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219370; cv=pass; b=iASACTuWTqmIfqCsCQTkGSuZ1NbUxAOL6IsFRaH9SkhWqIPgqNV+ch1A+q0ybuv1pcK+OswC2OBBW2Zix5FzrjCCjtKbpkvisqWy/LhnDuo5faW/ryW39knwyP9XvZyhUnoUXygvzq6Pwa4hpdLQxAtvwQUjK/JQxXMf/YN9FFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219370; c=relaxed/simple;
	bh=KGDhkeaNUAI/6zixZyd2LQF+k4+t5jv5l13iqMrIU58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3vrp786eprfNx1PYV3X0VuKzF/yY05dQLLPKsETH8X8gTMckVnutk5C6QiVWCMw9W8mglrb8GurMUt7iPcQTn2tBBm6dN9kxGCxGxlZ5fCR9Khl5hCMDVFW8RqHRD2tRVsJvbSncnH/rv544h3WgM2W9s1LSeOLF4MtOD/l6Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=IxD4kygc; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="IxD4kygc"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43d3031a750so314101fac.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219368; cv=none;
        d=google.com; s=arc-20240605;
        b=RVJBaSkxZLhVaJ6qpDm2YgTTB27qt9YKsvkeTQJ9TRtnL8glXLVTArcUl3qjpHxRiM
         ZXoIcZZQW3XLbrcJz03G3PaOKnEc+J9Oz5TlklaWNWNJtoKH8a4ZwjPk5FfDID27+JML
         PnSuJGs4vO8ZEiGXIqMcauD7ZVcpxRBzkHPMsAsc1KsPYfspc5Vqn7breuHPA78rl1sn
         8eJDJDZjLvU7w7rvOzDsijSQ8P3BU+kVgzQE5XZyG1UrFfXARWmj6IsBo80I396vblDY
         KJoRRqmjgc9EOwKx9TE2fIZ+wBfvKKlr4J90DKItnaT14h9FF5cVtiNLnITPGYACPotL
         Wklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CHpLlJLV3Hcod2loCA0BSzXxPhjsB2blr8IPHws7/qU=;
        fh=ue7C5oY44OgyxYcb6Bp5yzx2V9Ho6Wf+obR+rAqGud8=;
        b=NHe67NMOnwmP8rNs/n0uGm1BuppizDPSCTRO4fqaouTkBdBRhOhv9kvuHSfGZiQmY6
         wnAU5kx0iR3/5oYUFqHva1iMv7ASrLbxO1y8lkKcEY3mdvMapv9E+diIUdlqF1xNC3XX
         lZyYQRkqqQLvIZKPvhPQ5Gn5wu07gJW6/rF+j269RcmbgETJdzuxxnayExt1sWAJxsdX
         wT9MU5zlAICN4iTD7yQGdGm7NtxhNWXxc2Gn5SMFuwhiG5ipBPYzwLqRMqO2m504O4cb
         SAWvu2VEZzU6rsMevLDRH+t0jcSze75geSfB1ABC+kFTVifWyyin/jeqNBctro1rSj0g
         EArQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781219368; x=1781824168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHpLlJLV3Hcod2loCA0BSzXxPhjsB2blr8IPHws7/qU=;
        b=IxD4kygctHlnHtjPfLumAFl9yKtO8cpVVdRbs7yHJXKZaGMZKsdCZX5HaeDZS3txQX
         m1/seG4GFKLcflRaOMWMaqBBH+JOvUUdVyEVuw7K7c5djVKX9UkTuybhoqdx2nQQuzA8
         Zb92xr9R5TOYnz23jUphCgPe2/F4oo02SRR8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219368; x=1781824168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CHpLlJLV3Hcod2loCA0BSzXxPhjsB2blr8IPHws7/qU=;
        b=h/r2eYrf0NyO5A9H+TyqlQCOFJNnm04Pf+4/GfHqq/XiTEDC0QcdNCEYX9yR/eRkIY
         C9cfT9+roPp45OkQbJxLt3zsOYgRzKpDi+i2IuqJ30ltUi6Jjx2vAu89a7Huxzw5k9mM
         W4N+qPQvmnetWkgP9m0Xh3nHYhIJe6tQzjau1Fd7wURaJxy4dwflfnmFvtmMcXBic/EV
         dalsqL/JOxKj/qYT9RpKUCvIpChAuGb0jti7uzwE+Cr8HkLVNcXiZbwPyxwlCDODzUdU
         vDL3Vjp6e25/JWfLkPmwO5DhmPeKqpup9OWbRFByUo+v/YedNTg+o+s+Vne6ZDjBWSLK
         xp3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DCkZ8vb3l/1vnfYp8Qo7t1cmoSBq4tihWaNLbhd/DT53ja12UjR+ShDonFe0m+LvwQzDXsVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv72p5DPokp/rpLP1M8u1yiJpCzIchbr/ChKHWPZA3uUywgT+8
	pHLngc/v+L8dSAgqUtE1pB2qbLzzdwSgpaJVWMiAOJVhKmbmPu0dFivzUD0DtJiVCF2+pKwXkvk
	fltKp6jdoLgTewTJAwSfpcetb4FF7UCYnQ48zsyB9qA==
X-Gm-Gg: Acq92OFmFdS3d2qYqZ42rk0yvDSH47Zi1g8C1XzAI//rtAi3v3/3NqVDZXkvJy5I9IW
	qCHP93i1E/5rdefn06+anSkB3zJWyrimXVRgCtN+rXYXH8XkVQEcBqUlL9tRvwLar9T0cyNldd5
	LyDjVlOPbeIOpACBjs8SXz4vdQ5udYkFCKaLlY8c/5IKN2wdRj4GWCJ6DEnQ3jPdaPBNOYohzI0
	kaUPPzQuPf02lPNYENK6iBqn+1zkFc0vSUg8VCLZWKRd05YaFx+l2yB83zPNw7LgAxCnWk8KvUk
	eFnCQDnTnslEwJAARLX2P0TCKDxWu5Bx+OysBItmd52VhD8GLxpYCmnvtRayVQ+RGQ==
X-Received: by 2002:a05:6870:55d4:b0:43d:1d30:7ea6 with SMTP id
 586e51a60fabf-4426dc71b2fmr163747fac.2.1781219368091; Thu, 11 Jun 2026
 16:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611212445.4848-1-kylebot@openai.com> <dbb8c9d8-346a-486e-9e23-f200f6bebb5f@suse.com>
In-Reply-To: <dbb8c9d8-346a-486e-9e23-f200f6bebb5f@suse.com>
From: Kyle Zeng <kylebot@openai.com>
Date: Thu, 11 Jun 2026 16:09:17 -0700
X-Gm-Features: AVVi8Cf_uXFgACaWxPxtpFyW_QQzA80KZXXA3uO7qVgUYgL9pMwbcAwqWQtDukg
Message-ID: <CAC7i46_mVFdRE0a2CexemTKF+COueLhh0+tQNrcgGtYEgThVqQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: validate root ref item size and name length
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, outbounddisclosures@openai.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wenruo,

I'm actually a human who happens to have "bot" in the handle:
https://kylebot.net/.
I manually verified that my PoC worked against the master branch
before sending the patch.If you think I'm validating against the wrong
branch, just let me know. That was a bit unnecessary.

Best,
Kyle

On Thu, Jun 11, 2026 at 3:56=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/6/12 06:54, Kyle Zeng =E5=86=99=E9=81=93:
> > ROOT_REF and ROOT_BACKREF items contain a struct btrfs_root_ref followe=
d
> > by one variable-length name.  The tree checker validates only generic l=
eaf
> > geometry for these item types, so corrupted metadata can expose a root-=
ref
> > item whose item size does not match the embedded name_len field.
> >
> > Several readers later trust the item size or the name_len field when
> > copying the name into fixed-size buffers.  For example,
> > BTRFS_IOC_GET_SUBVOL_INFO subtracts sizeof(struct btrfs_root_ref) from
> > the item size and copies that many bytes into the 256-byte subvolume na=
me
> > field.  A crafted ROOT_BACKREF item can therefore trigger a kernel heap
> > out-of-bounds write.
> >
> > Validate root refs in the tree checker before other Btrfs code consumes
> > them.  Reject items that are too small for the fixed header, names larg=
er
> > than BTRFS_NAME_LEN, and item sizes that do not exactly match
> > sizeof(struct btrfs_root_ref) plus the embedded name length.
> >
> > Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioc=
tl")
> > Fixes: b64ec075bded ("btrfs: Add unprivileged ioctl which returns subvo=
lume information")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
>
> Tell you stupid agent to grab the correct branch.
>
> All it's doing is just a worse version of the existing check in for-next
> tree.
>
> > ---
> >   fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> >
> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index 1f15d0793a9c..fb072045ca18 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
> > @@ -1915,6 +1915,40 @@ static int check_inode_extref(struct extent_buff=
er *leaf,
> >       return 0;
> >   }
> >
> > +static int check_root_ref(struct extent_buffer *leaf, int slot)
> > +{
> > +     struct btrfs_root_ref *rref;
> > +     const u32 item_size =3D btrfs_item_size(leaf, slot);
> > +     u32 expect_size;
> > +     u16 name_len;
> > +
> > +     if (unlikely(item_size < sizeof(*rref))) {
> > +             generic_err(leaf, slot,
> > +                         "invalid root ref item size, have %u expect >=
=3D %zu",
> > +                         item_size, sizeof(*rref));
> > +             return -EUCLEAN;
> > +     }
>
> Your stupid agent doesn't reject name_len =3D=3D 0 case, meanwhile the
> for-next one does.
