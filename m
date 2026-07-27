Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D3423E82
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172375; cv=none; b=B6ZcKub7ORhGSABRWDqzV8zqjsjgoLic4H3yImz4s4dStfF/4CwHvuzLvM8ghRc+u7l/sosA6SmsUbGEUE847Kwjno8ZvfQXCDPH4ZGTt8iNrox0w6XOP4DoBnWgpAzofxU3GImd7nV3dpMGOV+nTHJsHP1plC9R6OTGpOT9dOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172375; c=relaxed/simple;
	bh=vs3HkCSryfJbeQqjrM9bgDwNIdSSDENJx70+9YveXQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TeSwsC2Lh93TnCDULmnEDUdojxkZiQGWJYaAmRiXeaqVN9oLsx2HRQU1eIURcWESEl5LEFQ6NK4PUtZerSzlXqSMrK6bLDGzS44D3/sSIT2atnX+VmxJ6mqtzbs7TU7nDa5/b4YOxxqWiCBCd5gS/sncMEwTO0CmTxjL999jPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR9jl9PQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUXaFvQv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR9jl9PQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUXaFvQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785172372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vs3HkCSryfJbeQqjrM9bgDwNIdSSDENJx70+9YveXQA=;
	b=BR9jl9PQyEgxwOTukV9EcyEvz34+jB9DLneQiR3IdYd5M89Sdziz4QTpIAdzPslMYej4kP
	WALixO82b949II7eii42K7kjmkHKoBQpYcl+OPy8gmvAGkAs4AJBC1ZpZUnWRzcXzehqF7
	UQiE0lllqKqcO8iIyfJ5MHNENy12RCo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-96CgxMa_NbCOXi6bFMf4hw-1; Mon, 27 Jul 2026 13:12:51 -0400
X-MC-Unique: 96CgxMa_NbCOXi6bFMf4hw-1
X-Mimecast-MFC-AGG-ID: 96CgxMa_NbCOXi6bFMf4hw_1785172370
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930edb4362dso315849485a.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785172370; x=1785777170; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vs3HkCSryfJbeQqjrM9bgDwNIdSSDENJx70+9YveXQA=;
        b=PUXaFvQvh6ti9ni+3DZr+HlqOSUZLIz/sdobCZvkh92WK6tbMpaF5qr5aJPShXH6AN
         9LoBJdsnbCnoywc+qY/QJbzLfqoQTWSGv9S4PH9adBi+upUcvFveNtDCvJTEUdXvP67V
         qyPkEUTZQlMvNWcDMleEVdlXunDOs3FOGk3iRnTam02dUCkp3jhEVj1Et6E8AMfFGuBr
         iBjTkQsG5jJfmxNwE0IiFrW8PDSC3CGbSlbKFGHWSMIZ51gSGD/ABc/JXa7/XBjlQjdK
         c6Wy3lyqjoE+WXdM75AOvfTpLD3KA3Hhf+L7FfB7k+B9H5ZJ2bBKPecVyyqQrs2LvD5i
         IkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172370; x=1785777170;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vs3HkCSryfJbeQqjrM9bgDwNIdSSDENJx70+9YveXQA=;
        b=PWk/yqHtrc9UYxFj201YdiXvLFh9S3sdD8/kaWay1jF5V9vpZ7czYO2KwLta/03LBg
         I1osbIafTEXGncix4oFvWrHMu6qCpf2Hsrp5wadyXTnkJS6JnLyHJkCw7Qd3jk9akQKp
         w9YyyQ4argfldE7YInFLxSnA452iLGvJOsYBxE30N2TeI8B42tgGYfhDYPGSHhIiI3vS
         ENW/swN8bt/zhzZDE2v2O4hDlQFNl1+7ym7adbka/a8De+RwsYhj9uzlxuCNB6z9gL0N
         vJAr27rM5hDC7zEl+w/DSArRWbNus1wZFt8u7YDE+WdX+QzHPSD0nCmfSQ72T70k2gWg
         vBJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMKtU2q6ECVhu/JNIufJiBs/XsUqY6HGU50/WvniSztDyv47+n0g6JVehpDhBPK9lyO+C3GjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DiRoXGIDtvNB5Qv+/yNQ/N5g7LjvQF+6D+hgNqQHWUlAEab7
	ZDkNoDsOQPRY2o6P4KSAyEC0y4wIYJwaiqPsa18irQwSBGQ0pYOt5VRalbtrkOWGszZE+dR536x
	JxVqe452ioH/9Y7YuG+Kbbhro9KJGv0ke3qy0JoKde6oI9/3xv7SvzF08BA==
X-Gm-Gg: AR+sD11Tnoq7MBkM6oEKD6jXg7EhqsbXwhg3sVmKQFXckspWCVXmoqUU+UfKm56ve00
	pSRvIZ8BVlWhZ13IwkIGEZR8j4zCKAEkcoIeTGAWOEn6bOxOPEKFL8F9lms1B/Vl3LdXYb0G5/M
	DetOJq/oJxlUFPxr3HmcwgAUzNKJfZ3EkFSn2NdCHiEjVSjIej34tmxQh7tCELeXOe4mFSgCw6x
	JRyvmD+WWiDQ8YDq4/3j9URVEMsMKOH2apx3Z5vGwdV9MeBbwVyodN6zb262YTK5QJoGEmuBDQU
	L0XfEdv/dU0p2vsF7e0xnscgrj4FEqsiHKGCgv6/OBshXjkwaPC0+eMEhghU3bKJTT/Zl/DR
X-Received: by 2002:a05:620a:8808:b0:915:9125:e652 with SMTP id af79cd13be357-932df7268bdmr861200885a.48.1785172369761;
        Mon, 27 Jul 2026 10:12:49 -0700 (PDT)
X-Received: by 2002:a05:620a:8808:b0:915:9125:e652 with SMTP id af79cd13be357-932df7268bdmr861194185a.48.1785172369040;
        Mon, 27 Jul 2026 10:12:49 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de5175b7sm659897885a.4.2026.07.27.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:12:47 -0700 (PDT)
Message-ID: <52fe8f83dee6c0e0b0bb6eff4bd965092432e01c.camel@redhat.com>
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
 Ripard <mripard@kernel.org>, Mel Henning <mhenning@darkrefraction.com>, 
 Aaron Plattner <aplattner@nvidia.com>
Date: Mon, 27 Jul 2026 13:12:46 -0400
In-Reply-To: <58219e62-99aa-4bb3-9c6b-5f96dae12649@nvidia.com>
References: <20260701182857.190713-1-lyude@redhat.com>
	 <20260701182857.190713-3-lyude@redhat.com>
	 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
	 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
	 <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
	 <b5d08cfe-aead-45f2-937d-6e9ef4dfea50@nvidia.com>
	 <971d09c47689981c1ea44c89555f71fcc0b5db41.camel@redhat.com>
	 <58219e62-99aa-4bb3-9c6b-5f96dae12649@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

FWIW - I think for the time being I'm going to fixup these patches and
send out another version so we can get this pushed upstream sooner then
later. I am still planning on digging into this further - running this
patch series on my laptop got things much more stable then previously
but it definitely doesn't seem to have fixed everything (unfortunately
the remaining issues I am seeing don't have any clear reproducer yet)
So I get the feeling the next step we should probably be following is
ensuring we actually handle the comptag storage stuff properly on
runtime suspend.

On Wed, 2026-07-08 at 16:25 -0700, John Hubbard wrote:
> On 7/8/26 4:18 PM, lyude@redhat.com=C2=A0wrote:
> > On Thu, 2026-07-02 at 12:46 -1000, John Hubbard wrote:
> > > On 7/1/26 2:47 PM, Danilo Krummrich wrote:
> > > > On Thu Jul 2, 2026 at 2:30 AM CEST, David Airlie wrote:
> > > > > On Thu, Jul 2, 2026 at 10:27=E2=80=AFAM Danilo Krummrich
> > > > > <dakr@kernel.org> wrote:
> > > > > >=20
> > > > > > (Cc: John)
> > >=20
> > >=20
> > > Also Cc: Aaron Plattner. I've provided answers below, but Aaron
> > > has actual experience in debugging suspend-resume on our Linux
> > > drivers.
> > >=20
> > > These answers are the result of my moderately long session with
> > > our best AI tools, using Open RM, GSP-RM, and Nouveau sources
> > > as a reference. I'm not actually experienced in this suspend-
> > > resume
> > > area, much, but this makes sense from what anecdotal things I've
> > > seen before.
> >=20
> > Would definitely be good to get human eyes on this, see down below
>=20
> Re-adding Aaron to Cc.
>=20
> Suspend/resume is hard, we need an actual expert here.
>=20
> >=20
> > >=20
> > > > > >=20
> > > > > > On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
> > > > > > > It turns out that the only reason our previous fixes
> > > > > > > looked
> > > > > > > like they
> > > > > > > worked for this was because we would occasionally set the
> > > > > > > Gcoff state to 0
> > > > > > > in the normal S3 path, which fixed suspend/resume on
> > > > > > > desktops
> > > > > > > - but not on
> > > > > > > machines using runtime suspend.
> > > > > > >=20
> > > > > > > The proper fix is to just never set this flag. Our
> > > > > > > current
> > > > > > > guess for the
> > > > > > > reasoning behind this is that Gcoff likely coincides with
> > > > > > > GC6, and not
> > > > > > > literally power off.
> > > > > >=20
> > > > > > I don't think GcOff coincides with GC6, it should actually
> > > > > > be a
> > > > > > power off.
> > >=20
> > > You're right, it's the other way around from the commit message
> > > guess.
> > > In the RM sources GC6 and GCOFF are two distinct GCx targets. GC6
> > > keeps
> > > video memory alive in self-refresh. GCOFF is a full power-off
> > > where
> > > video memory content is lost, so RM copies the used framebuffer
> > > out
> > > to
> > > sysmem before entering it, and it reports vidmem power as off
> > > while
> > > in
> > > GCOFF. GCOFF is the power-off case, GC6 is not.
> > >=20
> > > > > >=20
> > > > > > =C2=A0From a quick glance in OpenRM, it seems that with
> > > > > > bEnteringGcoffState =3D 1 it
> > > > > > also saves off buffers flagged as
> > > > > > MEMDESC_FLAGS_LOST_ON_SUSPEND.
> > >=20
> > > That matches what I see, and it's the key point.
> > > bEnteringGcoffState
> > > is
> > > not a GC6-versus-off selector at the FBSR layer. It becomes the
> > > PDB_PROP_GPU_GCOFF_STATE_ENTERING property on the RM side, and
> > > that
> > > property widens the set of allocations RM saves and restores
> > > across
> > > suspend (memmgrAddMemNodes, through its bSaveAllRmAllocations
> > > argument).
> > >=20
> > > With it set:
> > > =C2=A0=C2=A0 * RM reserved regions get saved, unless they are
> > > LOST_ON_SUSPEND.
> > > =C2=A0=C2=A0 * RM channel-context and kernel-client buffers get saved=
 even
> > > when
> > > =C2=A0=C2=A0=C2=A0=C2=A0 they are LOST_ON_SUSPEND.
> > >=20
> > > With it clear, the reserved regions are skipped and the channel
> > > and
> > > kernel-client buffers are saved only when they are not
> > > LOST_ON_SUSPEND.
> > > So =3D1 is a strict superset of =3D0, and it does include the
> > > LOST_ON_SUSPEND buffers you found.
> > >=20
> > > The part that matters for nouveau: in the full driver that
> > > property
> > > is
> > > never just a standalone flag. RM sets it only when it has decided
> > > to
> > > do
> > > a GCOFF as part of its own RTD3 policy, after it has reserved
> > > correctly
> > > sized sysmem for the save and turned on comptag backing-store
> > > preservation for the state unload and load. Setting the flag in
> > > the
> > > FBSR init RPC on its own, the way nouveau does, gives GSP the
> > > wider
> > > save
> > > and restore set without any of that surrounding GCOFF handling.
> > >=20
> > > So I would adjust the guess slightly. It is not that nouveau
> > > never
> > > saved those buffers or never had them. nouveau provides the
> > > sysmem
> > > and
> > > GSP-RM does the copy into it. The problem is the reverse: with
> > > =3D1,
> > > GSP
> > > saves and then restores buffers that were meant to be
> > > reinitialized
> > > on
> > > resume, and it does so without the comptag and state-load
> > > handling a
> > > real GCOFF pairs with them. So the accurate framing is "buffers
> > > that
> > > should have been reinitialized get restored instead", not
> > > "buffers
> > > nouveau never saved".
> > >=20
> > > > > >=20
> > > > > > My guess would be that with bEnteringGcoffState =3D 1, GSP's
> > > > > > resume path expects
> > > > > > certain kernel-driver-allocated buffers to still be in
> > > > > > place
> > > > > > that nouveau didn't
> > > > > > save off, or rather never had in the first place.
> > > > > >=20
> > > > > > John, do you have some details about this?
> > > > > >=20
> > > > >=20
> > > > > In nouveau we have the INST_SR_LOST target, for buffers that
> > > > > aren't
> > > > > preserved, I wonder did something change between 535 and 570
> > > > > around
> > > > > what needs to be kept around.
> > > >=20
> > > > The r535 code never set bEnteringGcoffState in the first place.
> > > > In
> > > > r535 OpenRM
> > > > seems to do the exact same thing.
> > >=20
> > > The set of buffers did not change. The FBSR client ABI did. In
> > > 535
> > > nouveau enumerates the exact VRAM regions and sends them to RM
> > > one at
> > > a
> > > time, and it never sets the gcoff field, so the flag is a no-op
> > > on
> > > 535.
> > >=20
> > > In 570 nouveau passes RM a single sysmem buffer for the whole
> > > heap
> > > and
> > > lets GSP build the region list itself, and the gcoff flag is the
> > > only
> > > control nouveau has over which regions GSP picks. Forcing it to 0
> > > makes
> > > the 570 GSP-built set match what 535 effectively saved, which is
> > > why
> > > 535
> > > looks like it does the same thing. So 0 is the right value for
> > > how
> > > nouveau drives suspend today. RM derives this per transition from
> > > its
> > > RTD3 policy, and 570 setting it to 1 was the deviation, not 0.
> > >=20
> > > On patch 3 (the resume state flags), I looked at that as well,
> > > and
> > > here
> > > is what the firmware actually does with it. In the 570 GSP
> > > firmware
> > > the
> > > resume state load already runs with GPU_STATE_FLAGS_PRESERVING |
> > > GPU_STATE_FLAGS_PM_TRANSITION. That is set unconditionally in the
> > > resume
> > > path, and it is gated on the bInPMTransition field of the SR init
> > > arguments, which nouveau already sets on resume. The firmware
> > > does
> > > not
> > > derive those flags from srInitArguments.flags. That field is read
> > > in
> > > only one place on the resume path, an unrelated display
> > > workaround
> > > gated
> > > on the PM_SUSPEND bit. Neither 0 nor PRESERVING | PM_TRANSITION
> > > sets
>=20
> This "unrelated display workaround" might be related after all,
> perhaps.
>=20
> > > that bit. And the value the open driver itself puts in that field
> > > on
> > > a
> > > standby or RTD3 resume is GPU_STATE_FLAGS_PM_SUSPEND, which is a
> > > PM-
> > > type
> > > indicator, not the state-load flags.
> > >=20
> > > So from the 570 sources I do not see a path by which patch 3
> > > changes
> > > what the firmware does on resume. That points to patches 1 and 2,
> > > the
> > > revert plus never entering the gcoff save path, as what actually
> > > fixes
> > > the push-buffer timeouts. Your 100-cycle RTD3 result is
> > > consistent
> > > with
> > > that: those two are what stop GSP from doing the wide GCOFF-style
> > > save
> > > and restore.
> > >=20
> > > I want to be clear about the limits of what I checked. I
> > > confirmed
> > > the
> > > resume-side firmware behavior against the 570 release (latest)
> > > sources=20
> > > rather
> > > than the exact 570.144 build, so I am not claiming patch 3 is
> > > provably
> > > inert on 570.144, only that I do not see how it changes behavior.
> > > And
> > > I
> > > have the mechanism for the =3D1 breakage but not the single
> > > allocation
> > > behind the timeout. I can see that =3D1 restores LOST_ON_SUSPEND RM
> > > buffers that should have been reinitialized, without the matching
> > > state-load handling, but I have not isolated the exact buffer
> > > that
> > > produces the failure.
> >=20
> > Mhm - the AI must be missing something, mainly because I went back
> > and
> > double checked - and at least with runtime PM on this ampere
> > machine
> > I'm immediately able to reproduce issues if I drop patch 3 (in
> > particular - job timeouts after runtime resume). The actual
> > suspend/resume process succeeds, but it leaves us with a GPU that
> > doesn't seem to be able to render anything:
> >=20
> > [=C2=A0=C2=A0 93.167997] nouveau 0000:01:00.0: vkcube[11028]: job timeo=
ut,
> > channel 4 killed!
> > [=C2=A0 100.365899] nouveau 0000:01:00.0: gsp: rc engn:00000001 chid:4
> > gfid:0 level:2 type:38 scope:1 part:233 fault_addr:0000000000000000
> > fault_type:00000000
> > [=C2=A0 100.365907] nouveau 0000:01:00.0:
> > fifo:c00000:0004:0004:[vkcube[11028]] errored - disabling channel
> >=20
> > >=20
> > > My bottom line: patch 2 (=3D0) is correct and is the right value
> > > for
> > > how
> > > nouveau drives suspend today, and patch 1 is needed with it.
> > > Patch 3
> > > is
> > > harmless, and from the sources I do not expect it to change
> > > anything
> > > on
> > > 570.144.
> > >=20
> > > Assisted-by: Cursor :)
> > >=20
> > > thanks,
> >=20
>=20
> thanks,

