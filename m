Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA234D90D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711733; cv=pass; b=RS0TgrtN0G6UUs3paixuAXkJ8GBOJS+gbimF4064wsthglFRNQ+HWeRLOs+QWhKjj0qUYETdpsX3Tb5rLuizzPrdlFdBXr13bF8ZlV/iJUJLDtwRdtyfNR657WSYJZmdOLaQ8n23kigl/YYRqlPXV6p0cAoFJRlakenAGBuiDpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711733; c=relaxed/simple;
	bh=0svBjYU8Rlxkjftgl8zGK+GshjTNX38hympT6l5KjSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKDEZahhuzVHAmvGKYt7mnLV4ot4mcwxd+adgI2YS0ExnAPQ+QXQYpGWn8HEqQBRzTz/cbiKdS4wKBaFgpdvMRV45jzBcR+RerGnCZW/B+mvy2n8tihKIV8wgy9RHxn6zSixol6fY5QEVmUm+hiEacPcwwpNsNfZ0Dh4kU2w148=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBA2jcDn; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBA2jcDn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8cceaacd07bso68577926d6.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781711721; cv=none;
        d=google.com; s=arc-20240605;
        b=SNRf8I5D+wp7XzvdN3OAR7xQveRNR6aWl6vSF9TGBHH7axPfJkBtJ+1Ds11ukvNT+r
         VUuAgetf7vzATISjheI1pS7aezCi4PVchiQzqhYpNdsTb3M/U4CpyGHGuu+AlctIPUFf
         Wcv+6nZ5lpUKwkauuWyiQdpVO1se4dSkn2h/RDZ72LwJZRhq2sBSVBxzbvMWWwwZ/oMu
         TYyNf2MBX1zLosS36xZK/cKw4grF8Qe8uTYhJJ6IVO5P++VX7vgS/h+UE7oHJ8ewLeAM
         JS0gq/apjHYEHC5JUP2JV7c+7Rgb/BR7YfAh4WZAge+f//zYtK61cjzhKyasNc8vvw2g
         UKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s0GZODSrZgipIY+mYkKr0WTQPzn3Ok5TDY0Ttij7IlI=;
        fh=EfhqQcCYpi5HK3RlgUoHc8rWM8RGBoRLKuZuu+Qm52c=;
        b=jAboXQZ4KSSGqMz7Vd1fUobkOx/eImaaeVeYxZD7Up2cRuMKjRpW2WVCPT/Kx+yC1Z
         wYQXXGeofQTkudwkq0FC5mRUjXm8QSybHmTAuC1Hk1whkGBX1lZG7lSJ/4mQnz+8jq7z
         yVuvcgnNhwCRE331t3hcmB4yPnJK8E/NR0gjTEEz4bI9AfJsGYBP1+iJmANz6kVjO3wD
         ENQjxWEx83K/En+f9/9R/Co8NSCgqwdWkzlSE9jXqcnHJOV5eIO0WQWNvaCHUu5PtjR3
         GSJuk4hFemh1oLFOtMF1m+YypSQaQEdbB0gFHqIeMYdNf9aLeQkgE3ubDFGE83AeF22x
         r1+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781711721; x=1782316521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0GZODSrZgipIY+mYkKr0WTQPzn3Ok5TDY0Ttij7IlI=;
        b=iBA2jcDnSJShyJy1mjdVuNziZ6FmCqn37jwU7ROhJ3NiBFxrDvupxhl+ao1TZSl8si
         jXO0jUXAYtrChplUzMD7F75Twk1Xe+iWYjvU338rKA8fPkKlLSs27mio+cmxoc91ijSx
         IDOwr/rsDbJzs0bX5PSQsUoHrou4x3OjKgKwK8V3VfmTRzFxF/rQNHqqYHeMqpfCRYj9
         5h5YDrt4UWR3iwRy7JL2a0ud5n/HoaDLtT/AIgYVDX/5ccC2AU66IGyreNTPQjmxRT0m
         wwkR4GMnX48ok4JvUIlRGggszjEq8Otstw7BZnmyvYUUseQWBPA8AsWP4RkwYHgAhZwR
         W1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711721; x=1782316521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0GZODSrZgipIY+mYkKr0WTQPzn3Ok5TDY0Ttij7IlI=;
        b=ZnviJRBN4sClO1wdgkavwyF+tPdf7aB8Mx1KMqK0Lyd/ioSScIvRarLvJlcdW+XVGn
         wKMV//BOdCDlb5LFrsrFFAsW/EkOin2+fnM9//bm2FXQt2Xbt2Ta+jNad92aeuLYO+sV
         m6T4SwnoV//VEETjBJaG7h/2/xhSyrc2kHtXuzK+RnGGDKv8fvMkRojb0QcN8GQ7Kt6Y
         9xOwTgtEMG+RzbgPR8DPAuNIP1xIdh1NwETJvVT48bCXDNz6yZEk0WVLwAEEal+2UV86
         9wmCPQKmd9gI62HV5uw2a+C+WyKnPRWzhzoCZGleWpZRrPyxgRSDbIhYnp98IuTxgj5g
         YWNg==
X-Forwarded-Encrypted: i=1; AFNElJ/SwuQXdlUCnimOM5OOzPHDSMi0rTDoW+Yrc4R3UAsFnVMvr5nTKvml3/0+WgGU4B8n8vpFx48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuJWdxl8pwN+ZU3bT/2IXWn8dpolx5juAmN9vJll3kjOnhl5a
	GjjYakP2V7cb2lNdIOedSMA4p9UEi+6021/ftBOYbOQsr+VEKWYDbAtEidXdu79SP2CWkb3bxBj
	ajY8zg8KDU9ZTF8w6yKLTwNyWWDKJvYk=
X-Gm-Gg: AfdE7clHV2XmU+A70rVocrMRCrUQROz2hp7T/YvzCj4cv8+w+zW8hZxoOvGDH66cNse
	7Me7t4OG5BUqgjZy563S1UmW6yRZQB6Cw5SzgSbWA53oBsj7GNi8Wh6RTey+6+jZwSXhG7OS5wr
	dzp+JXYz7drrlO3+o7CSiPRX4MSknMc1vij1XBGAeKD/2D36iQT2/17I89kQorXfLowY4NDlEL/
	PQzmeHw6JbieTA3Jn6z4fmbVWlfs0dWDmaiDipSQxDGPr0QgGuancG8TlOJI+PdzmFFGAyC/A==
X-Received: by 2002:a05:6214:4885:b0:8ce:9cbd:b0ce with SMTP id
 6a1803df08f44-8db83be3792mr79261076d6.34.1781711720531; Wed, 17 Jun 2026
 08:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com> <9o1psn77-q665-0rp6-pnnq-9179802p2nsp@xreary.bet>
In-Reply-To: <9o1psn77-q665-0rp6-pnnq-9179802p2nsp@xreary.bet>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 17 Jun 2026 08:55:09 -0700
X-Gm-Features: AVVi8CduFyKxlhK1RSjwdH8nJ6Ov3bv8dg2gVWyi3GEY7zVefRXqpDRmgWhQReA
Message-ID: <CANRwn3RTGZcOV_kcF02C18Jd6uLMdHz4vB-n-GaCiuobNBubzg@mail.gmail.com>
Subject: Re: [PATCH 0/4] HID: wacom: add report length validation in irq handlers
To: Jiri Kosina <jikos@kernel.org>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>, linux-input@vger.kernel.org, 
	benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:19=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Sun, 17 May 2026, Jinmo Yang wrote:
>
> > Several wacom IRQ handler sub-functions access fixed offsets in the raw
> > HID report buffer without validating the buffer length. wacom_wac_irq()
> > receives the length from wacom_raw_event() but does not validate it
> > before dispatching to the sub-functions, which do not receive the lengt=
h
> > parameter.
> >
> > A malicious USB device can declare a small HID report in its descriptor
> > and send a matching short report that passes the HID core size check
> > (csize >=3D rsize), but the driver assumes a full-size hardware report
> > layout, leading to slab-out-of-bounds reads.
> >
> > Note: this is not mitigated by the recent HID core bounds checking
> > series which validates actual_size >=3D declared_size. An attacker
> > controls both the descriptor (declared size) and the sent data (actual
> > size), so the core check passes. Driver-level validation against the
> > expected hardware report layout is still necessary.
> >
> > Tested with KASAN on Linux 7.1-rc3 (slab-out-of-bounds confirmed) and
> > verified kernel panic on a production device via uhid.
> >
> > Jinmo Yang (4):
> >   HID: wacom: validate report length for PL and PTU handlers
> >   HID: wacom: validate report length for DTU handler
> >   HID: wacom: validate report length for DTUS handler
> >   HID: wacom: validate report length for 24HDT and 27QHDT handlers
> >

Two main comments:

1) I would prefer each of these commits to pass 'len' as a value into
the sub-functions and perform the checks there. We already do this
with several of the sub-functions, and it would be good to be
consistent in where the checks are performed.

2) Please define new WACOM_PKGLEN_* values in drivers/hid/wacom_wac.h
and use these definitions rather than magic numbers. E.g. `#define
WACOM_PKGLEN_PL 8` to cover the PL case.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


> >  drivers/hid/wacom_wac.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
>
> CCing Ping and Jason for their review. Thanks in advance,
>
> --
> Jiri Kosina
> SUSE Labs
>
>
