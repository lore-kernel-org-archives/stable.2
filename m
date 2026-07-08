Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F63803FA
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552710; cv=none; b=XaPoAteAtKQjvE/cWP6YUET0co5OCsLhuqTD42CWhJootLvTFcPNGvULaGSlcVxE4riPROjIYrKSEW2x82rOgC3IFRSicLXGqTZC9l2yn64kL/TraNfP2hofvx2Ttxvi58KwL463ZPqEaWNQ0w/4XGDAlk+yRZgpziPCLjxtyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552710; c=relaxed/simple;
	bh=J22MFVVOOADszmP4umj26oLdc+JRJM3+g3IdZOuBvuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4CITYiHPJxKGVH122ia6fdDgI/EhN6g451CrBLPWdQ4dIJOakgz/92iU3P8uuJULt/g1a11VsEjNwWuSYbyRkbqDB271nu55RnrKni58qhQNZ47CXDJqg4WeiQj0QfbONc3MlSfTCt21foTquw65sxboeQXBeW+W3IMYfDKugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EgtLCKDs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tzZ7yteY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgtLCKDs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tzZ7yteY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783552708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5qIRcmJXyAs4S5n6HPsnEq9NZkqNs3idRIrshW19t8=;
	b=EgtLCKDsDu5QERE1z6vnO3fAAs5AbowiUWo8blo2z5trjiGa6/IU/Y9z+eNE8jjEWy0xuS
	QlrdV8v8Z/58w5/7R9+/oPs3PH4rDlZubWTrQgtGk3jZMbbWnZyv5z5QxvJ+tFEjUTRn9r
	HKtyGaokJt0bUGVXbWzq/462cB9OES4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-yInXOU5uMQOzxpfpmZ68xg-1; Wed, 08 Jul 2026 19:18:25 -0400
X-MC-Unique: yInXOU5uMQOzxpfpmZ68xg-1
X-Mimecast-MFC-AGG-ID: yInXOU5uMQOzxpfpmZ68xg_1783552705
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ee593a5a2fso5805366d6.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783552705; x=1784157505; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m5qIRcmJXyAs4S5n6HPsnEq9NZkqNs3idRIrshW19t8=;
        b=tzZ7yteYNgVCiAzJqKfAPEjZ0pfp0xDHXgiUOB8SKwWXcddC4W36EczrDh3oRleG20
         3DEKfTlKb+KVxK42RgnO9Y+o5NXlEW1/AcLD/3tYsCSdFNEG9GDwTBE/On3gqzwUK0yK
         z3a0rKVvKoVarEJdu2t5XoPc3WV+WzXTyAPhfaIIWQajo+w5y5ec95kNagxJ10VMKm2M
         xmKvrbtemRA1PHccz7838WZwnW1VWJk6H+Z/FDwCqpoM7XXY+xMlarxfC/oXFY88RtRl
         gtrvqnhbX4DHseGi9NbNqFkZ52JDsfCW8oew0NbeJA3WpFaM5fnNHoQzXETFV2saHw2q
         370Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552705; x=1784157505;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5qIRcmJXyAs4S5n6HPsnEq9NZkqNs3idRIrshW19t8=;
        b=H0T9zpyw1xwBGX16fqcoc5K4E4ZjDufKO9KaOztj+oPx8EvbWbeCKH6zKrPWobfwWZ
         TCOkKIPKD7FZN5tn/91BS8IKNz+gtslk/nSu5jXf5B0QSpCWgVAwPWQTPQUVBGwiU8Qb
         ZkdNmVuQY1ALIJ4+rPwpFI4hj7nb25Udeb7BjOvKlGrUxQyvfaB/vlyrG8jqzgaARSOW
         /KU4zI4oeptmLtR5VyY/Ll6JGfNYVFWJFkYN/3PD3c2DBL+SAFoP4+hW8capvolbKVaY
         fyIdm0VQIl36j91Hxj9Mj5zffRHFXtmNLK6hR0raTUiziB/s9kPA4Q8Pk/jnmjxQ4w7/
         9E3Q==
X-Forwarded-Encrypted: i=1; AHgh+RorrEm8gdEX6PObJDsN7MwSvlojrkyGqdNvfMEz5mUsZKXnfWMkpqdscGvJTdtOIvC1kYkmZJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cI5NpCGqP/NbR6nMlyid22hZD3n9el+hF9r40FRxl37lzOke
	C/qW0c8cvR5rlEj8Xcxd27I+V0rxhXQ0AD98ZGIq38bKgvUoH50diaeWXGI57sfMd2NgCotiTgO
	gVkobA8enXesesIyZCGjZeZDeR0tnhKudOLbHwQpiE0T6dw3mrHjWqqvIWQ==
X-Gm-Gg: AfdE7cmT6Mc6yPmzJkR/cItnzOtmFiQy+0TLZwE8mLZcqdGW/0pUVEXAhLwJ7Hloa5R
	C3fl9RgWDMEBbhnPs4D4EmMEd8dkvvcepez2Q5Q8Zm1m3G+YWAXgsINSUzd7JflFs+Pnh8p8rw9
	4Q36X1kdhK73uVVzcE/7+umYVV53AK9/715jCJVtuKo8rYPDbEfIk9U720Vg47/A7odt9TCQiDt
	HUCQdzC+muHrVN4BZyYsqFZrbKmbQviPBS6dhQ4DdlyjxNicmOYVaHkxHp5QB6MLjNF3eGGx5Cy
	IP8Cmx6UxuS2CJvSwXUvdn/Afi3F+qjxtjvXw5AbWgDiGDhiW3xvC6BMIylrmTRiVvFmTW0Feq4
	vbChRe1w=
X-Received: by 2002:a05:6214:8087:b0:8ee:fb19:a9ac with SMTP id 6a1803df08f44-8ffea44044bmr4033556d6.12.1783552704825;
        Wed, 08 Jul 2026 16:18:24 -0700 (PDT)
X-Received: by 2002:a05:6214:8087:b0:8ee:fb19:a9ac with SMTP id 6a1803df08f44-8ffea44044bmr4033166d6.12.1783552704270;
        Wed, 08 Jul 2026 16:18:24 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d9f6sm3681606d6.23.2026.07.08.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:18:23 -0700 (PDT)
Message-ID: <971d09c47689981c1ea44c89555f71fcc0b5db41.camel@redhat.com>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
From: lyude@redhat.com
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timur Tabi
 <ttabi@nvidia.com>,  Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Kees Cook
 <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>, David Airlie
 <airlied@gmail.com>,  Thomas Zimmermann <tzimmermann@suse.de>, Maxime
 Ripard <mripard@kernel.org>, Mel Henning <mhenning@darkrefraction.com>
Date: Wed, 08 Jul 2026 19:18:22 -0400
In-Reply-To: <b5d08cfe-aead-45f2-937d-6e9ef4dfea50@nvidia.com>
References: <20260701182857.190713-1-lyude@redhat.com>
	 <20260701182857.190713-3-lyude@redhat.com>
	 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
	 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
	 <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
	 <b5d08cfe-aead-45f2-937d-6e9ef4dfea50@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-02 at 12:46 -1000, John Hubbard wrote:
> On 7/1/26 2:47 PM, Danilo Krummrich wrote:
> > On Thu Jul 2, 2026 at 2:30 AM CEST, David Airlie wrote:
> > > On Thu, Jul 2, 2026 at 10:27=E2=80=AFAM Danilo Krummrich
> > > <dakr@kernel.org> wrote:
> > > >=20
> > > > (Cc: John)
>=20
>=20
> Also Cc: Aaron Plattner. I've provided answers below, but Aaron
> has actual experience in debugging suspend-resume on our Linux
> drivers.
>=20
> These answers are the result of my moderately long session with
> our best AI tools, using Open RM, GSP-RM, and Nouveau sources
> as a reference. I'm not actually experienced in this suspend-resume
> area, much, but this makes sense from what anecdotal things I've
> seen before.

Would definitely be good to get human eyes on this, see down below

>=20
> > > >=20
> > > > On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
> > > > > It turns out that the only reason our previous fixes looked
> > > > > like they
> > > > > worked for this was because we would occasionally set the
> > > > > Gcoff state to 0
> > > > > in the normal S3 path, which fixed suspend/resume on desktops
> > > > > - but not on
> > > > > machines using runtime suspend.
> > > > >=20
> > > > > The proper fix is to just never set this flag. Our current
> > > > > guess for the
> > > > > reasoning behind this is that Gcoff likely coincides with
> > > > > GC6, and not
> > > > > literally power off.
> > > >=20
> > > > I don't think GcOff coincides with GC6, it should actually be a
> > > > power off.
>=20
> You're right, it's the other way around from the commit message
> guess.
> In the RM sources GC6 and GCOFF are two distinct GCx targets. GC6
> keeps
> video memory alive in self-refresh. GCOFF is a full power-off where
> video memory content is lost, so RM copies the used framebuffer out
> to
> sysmem before entering it, and it reports vidmem power as off while
> in
> GCOFF. GCOFF is the power-off case, GC6 is not.
>=20
> > > >=20
> > > > =C2=A0From a quick glance in OpenRM, it seems that with
> > > > bEnteringGcoffState =3D 1 it
> > > > also saves off buffers flagged as
> > > > MEMDESC_FLAGS_LOST_ON_SUSPEND.
>=20
> That matches what I see, and it's the key point. bEnteringGcoffState
> is
> not a GC6-versus-off selector at the FBSR layer. It becomes the
> PDB_PROP_GPU_GCOFF_STATE_ENTERING property on the RM side, and that
> property widens the set of allocations RM saves and restores across
> suspend (memmgrAddMemNodes, through its bSaveAllRmAllocations
> argument).
>=20
> With it set:
> =C2=A0=C2=A0 * RM reserved regions get saved, unless they are LOST_ON_SUS=
PEND.
> =C2=A0=C2=A0 * RM channel-context and kernel-client buffers get saved eve=
n when
> =C2=A0=C2=A0=C2=A0=C2=A0 they are LOST_ON_SUSPEND.
>=20
> With it clear, the reserved regions are skipped and the channel and
> kernel-client buffers are saved only when they are not
> LOST_ON_SUSPEND.
> So =3D1 is a strict superset of =3D0, and it does include the
> LOST_ON_SUSPEND buffers you found.
>=20
> The part that matters for nouveau: in the full driver that property
> is
> never just a standalone flag. RM sets it only when it has decided to
> do
> a GCOFF as part of its own RTD3 policy, after it has reserved
> correctly
> sized sysmem for the save and turned on comptag backing-store
> preservation for the state unload and load. Setting the flag in the
> FBSR init RPC on its own, the way nouveau does, gives GSP the wider
> save
> and restore set without any of that surrounding GCOFF handling.
>=20
> So I would adjust the guess slightly. It is not that nouveau never
> saved those buffers or never had them. nouveau provides the sysmem
> and
> GSP-RM does the copy into it. The problem is the reverse: with =3D1,
> GSP
> saves and then restores buffers that were meant to be reinitialized
> on
> resume, and it does so without the comptag and state-load handling a
> real GCOFF pairs with them. So the accurate framing is "buffers that
> should have been reinitialized get restored instead", not "buffers
> nouveau never saved".
>=20
> > > >=20
> > > > My guess would be that with bEnteringGcoffState =3D 1, GSP's
> > > > resume path expects
> > > > certain kernel-driver-allocated buffers to still be in place
> > > > that nouveau didn't
> > > > save off, or rather never had in the first place.
> > > >=20
> > > > John, do you have some details about this?
> > > >=20
> > >=20
> > > In nouveau we have the INST_SR_LOST target, for buffers that
> > > aren't
> > > preserved, I wonder did something change between 535 and 570
> > > around
> > > what needs to be kept around.
> >=20
> > The r535 code never set bEnteringGcoffState in the first place. In
> > r535 OpenRM
> > seems to do the exact same thing.
>=20
> The set of buffers did not change. The FBSR client ABI did. In 535
> nouveau enumerates the exact VRAM regions and sends them to RM one at
> a
> time, and it never sets the gcoff field, so the flag is a no-op on
> 535.
>=20
> In 570 nouveau passes RM a single sysmem buffer for the whole heap
> and
> lets GSP build the region list itself, and the gcoff flag is the only
> control nouveau has over which regions GSP picks. Forcing it to 0
> makes
> the 570 GSP-built set match what 535 effectively saved, which is why
> 535
> looks like it does the same thing. So 0 is the right value for how
> nouveau drives suspend today. RM derives this per transition from its
> RTD3 policy, and 570 setting it to 1 was the deviation, not 0.
>=20
> On patch 3 (the resume state flags), I looked at that as well, and
> here
> is what the firmware actually does with it. In the 570 GSP firmware
> the
> resume state load already runs with GPU_STATE_FLAGS_PRESERVING |
> GPU_STATE_FLAGS_PM_TRANSITION. That is set unconditionally in the
> resume
> path, and it is gated on the bInPMTransition field of the SR init
> arguments, which nouveau already sets on resume. The firmware does
> not
> derive those flags from srInitArguments.flags. That field is read in
> only one place on the resume path, an unrelated display workaround
> gated
> on the PM_SUSPEND bit. Neither 0 nor PRESERVING | PM_TRANSITION sets
> that bit. And the value the open driver itself puts in that field on
> a
> standby or RTD3 resume is GPU_STATE_FLAGS_PM_SUSPEND, which is a PM-
> type
> indicator, not the state-load flags.
>=20
> So from the 570 sources I do not see a path by which patch 3 changes
> what the firmware does on resume. That points to patches 1 and 2, the
> revert plus never entering the gcoff save path, as what actually
> fixes
> the push-buffer timeouts. Your 100-cycle RTD3 result is consistent
> with
> that: those two are what stop GSP from doing the wide GCOFF-style
> save
> and restore.
>=20
> I want to be clear about the limits of what I checked. I confirmed
> the
> resume-side firmware behavior against the 570 release (latest)
> sources=20
> rather
> than the exact 570.144 build, so I am not claiming patch 3 is
> provably
> inert on 570.144, only that I do not see how it changes behavior. And
> I
> have the mechanism for the =3D1 breakage but not the single allocation
> behind the timeout. I can see that =3D1 restores LOST_ON_SUSPEND RM
> buffers that should have been reinitialized, without the matching
> state-load handling, but I have not isolated the exact buffer that
> produces the failure.

Mhm - the AI must be missing something, mainly because I went back and
double checked - and at least with runtime PM on this ampere machine
I'm immediately able to reproduce issues if I drop patch 3 (in
particular - job timeouts after runtime resume). The actual
suspend/resume process succeeds, but it leaves us with a GPU that
doesn't seem to be able to render anything:

[   93.167997] nouveau 0000:01:00.0: vkcube[11028]: job timeout, channel 4 =
killed!
[  100.365899] nouveau 0000:01:00.0: gsp: rc engn:00000001 chid:4 gfid:0 le=
vel:2 type:38 scope:1 part:233 fault_addr:0000000000000000 fault_type:00000=
000
[  100.365907] nouveau 0000:01:00.0: fifo:c00000:0004:0004:[vkcube[11028]] =
errored - disabling channel

>=20
> My bottom line: patch 2 (=3D0) is correct and is the right value for
> how
> nouveau drives suspend today, and patch 1 is needed with it. Patch 3
> is
> harmless, and from the sources I do not expect it to change anything
> on
> 570.144.
>=20
> Assisted-by: Cursor :)
>=20
> thanks,

