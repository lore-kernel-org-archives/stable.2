Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55123E49C2
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821749; cv=pass; b=T1bAXIpJGib82bCaaXetmQLgO3pDacJPa+uxQPhDBD5o1J/xNlehpfj6y1+Ti7znqRnHuXs7KEAuyLxBCkPZEovFo/0uD+SDvwh1/lDmBlWZpaI8qKEjmDQRe7cJ2jRp0NtJJvzxcizQNua/TMWnIV1tJUmKp8S2oij6L4ZMkDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821749; c=relaxed/simple;
	bh=8ScfO32hrCuPJaHEfel7EXpblrq+8LxT0vfmYHwZKY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6CK4LLvwwhJcG0H3Vi9hLdOhpQyUsFIn9DN5iyIBi/YB4OuYepCBlTLFxBHl+QG2WSnvskVVIv81RKECAKi+033IkkC6ZWn0pzbTYDRPbAA4oBR4NmevQSCmURg+b1S9Au12uNlMRh7w+Fd0pV34Udz6UjuHL+se0/2euid1PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoBDJbve; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoBDJbve"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43b7e186a0cso1056530fac.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 02:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787821745; cv=none;
        d=google.com; s=arc-20260327;
        b=Uk8x4QJpWS1Qkrh5R4rbxVjthX5+cdphuOgHBji12WjQMrfR9u72oYqwVnxwzX7jk+
         EHQ+0GUzYgPDFL/NK8UwHsevrYrr2EOBFt5Lflid3ik7wRM3p5QryNNnXswtbB5Q0+le
         Uw7Qoxakf2Ura14F/xJIoja0YgBNwiWIJ/a/eej9z+itvfMixRscQTQHssd8BmWpQsUA
         UrAGMEQNRzF/TWFn7VMP8Y3dkG6gXcQ521Z7PJJxe6e4EUfEwyJHPZVARkV3UIk2metS
         uz1x9SBI9Kncla9nmecjh272UoQQ4MB2WvSjyi2vQUEd1hBpS8Hl5yETTMZCep8CY9nG
         AnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJk8AOF1uYTdFAZc5WqubZUc5UyWwi9WNtT23V9H294=;
        fh=vJgmsP7+18Xuxq0Rfgtis0lR6Um8kbix7EY5WJVHN6c=;
        b=S0G+r/5OHpvC9VM8qGzx0eQZDP4FrOlkhGxBsjEBU3y/vTdlCHhJeSLtQwcgrXtBVt
         cu7cB6S4pVNFnXOlKbsuFuQ4MDSgQcTNnCUIbKnkkYfE1kWGY3sX2RJgpRpcwNPTxeIm
         +3V2dh2Ob30P7z3HKGUuyBe+EJHWSc0g25Y9w8m1F1fBYVFGiN8GhNO7JAsewluFJr73
         W7t1n+yaWd7723TvnJPi6XX+vTS+oLQE+9tOWafPJ3umZdmjk5ubo74+J/E/md31cW59
         jxbEuLnEGs7F7TyfHQtrAGWsuKyaTBzvlsgpSq+BsgIz2oEJ9nWNg38dtvpJkJ/abRp/
         h4Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787821745; x=1788426545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJk8AOF1uYTdFAZc5WqubZUc5UyWwi9WNtT23V9H294=;
        b=PoBDJbveNkAh+F3fp2rCiHIPZzcpBzC9ECmA58vdy16Gny3Rzo4c3LVsym8MA13jQV
         hRQ5SdhdAOw/q7u/Q1XNTZkwvye3OxsPrlA3xMt6oSKXJyxCVRDjXZKBRi0gn6gD67gS
         lbDHruGQQe1TuA5w2UFSRkQPTCqXWhGwD5Vco38hlI9VS8Rlaj0xTqF+9ekOQbdiN/qs
         BnqKZxsOa4dp9tOJ+NS9ncghxxLKMk6z5ebEiGLVPrH55VBsaV5/dwvrOT+D8LF72cus
         IR4Sp4KBreiFPd8bEHldz0lhCuE2xdioMRV6LuQoFskgtfuPOiLX41QVhS7eBqZbEwmQ
         c5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821745; x=1788426545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJk8AOF1uYTdFAZc5WqubZUc5UyWwi9WNtT23V9H294=;
        b=HpLzpOA5LB7x2gYjzIsiZfHp8rWweaOO6dE7Dea3bu6Yn6t6OYVp7mvRoI/GjVZXHf
         YUJGJryOzaytIVG3va1tDNA8cNbhZNma5UvAshK/56xOsJ93MbCgpDsgP+/Ea/H8iDV+
         Hx/6CpbMrVYJLm8cT6enNSXZ1U8MCCQyRUXeSdG9wc4reyhMDryWkF249ZQ8CGb7SHhZ
         5Bf3Ze/g+R0MDF5RI4R6Am31eIRTw3gqLxqJ3cVDhHzRDl0nRd5JmqwpWzr8vYboEjJ1
         gqfwv1tju7ueR7A1OHuI3YoGwdBfDkeXkrJI2nOWl2ThMQ25VrK1xSNtouVnZp9itKFO
         wA2g==
X-Forwarded-Encrypted: i=1; AHgh+Ro8bMu5t3loNf/AaFIBhu8ZYAFwIWex83rhyhRQyXxzLBLzXS4e2jNDJotgQyklviZGR0knnsY=@vger.kernel.org
X-Gm-Message-State: AFuF++lJDOk9dTTvefppD6Sq48b7+Q9kqjsCG6wkg6+Qj+5tj/HO4bw1
	v0N1ee8Q9qPv4FPBm4s8Jpl72ym5Z2VcUgakuCwMoWr6GGO9bw113EQ2RcWCrznWJzg8fCcBzcH
	EkgjLCN2bG+0np6xriJu/OciX7OkgPU3gz/SrXwjH
X-Gm-Gg: AR+sD10UjVIGvznxGQHXYgguKSIUY4ZCHJwOU47bWNLHnzOB9hHelAWJR1DZXK5hYmk
	pSw8RApvyy71DDlIbsrOZa7M73PrZyBuj7VG4wMs/7+0tCwt/wuPVyiX93owGNfT/WS1fAOCQb9
	Y97F6WzdJ6O03jUviGLh9PyOpPHSBsimLQ8BotSWh6Toaw29lr1eXWUWH6sYqfqHXULv7uCuaMv
	dd+kMlC4Wze3X/ZA6Zm4wN2hDrk7dYw7Dpdd3/XKoCAnHJmVIvitxTaZhnRZDzs6emIhgl0WkxN
	gvr6mHYEzaWptsGe32VDW/9skXgYeHWeBhkjTMIfpYQkOlba9RDu2PTxPLbN9mLHRFj0G6nvHc4
	PiIZpG3VfOqYTjEnOvEXjCMI8mxE5nnDDwRWGXST6oQV/YbLbtpIOg9KmXtxEUIxQPFudqPAtGK
	Hs09xVwBvfkminRg==
X-Received: by 2002:a05:6808:3305:b0:495:feaa:9e3b with SMTP id
 5614622812f47-4b36691bebdmr14734837b6e.7.1787821744779; Thu, 27 Aug 2026
 02:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com> <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
 <2026082540-tarantula-gigantic-b786@gregkh> <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>
 <2026082507-ecosystem-giant-0b79@gregkh> <CANp29Y5hnOWaqGw8BbPu1TCr00TbvNRciYvs_VCd6Jtk=8kSPg@mail.gmail.com>
 <2026082602-compile-bogged-877d@gregkh> <CANp29Y486UwGwRJpqzQ4aU2eN4Xu3A+zw_zDUJuFR5hKQ+Knrw@mail.gmail.com>
 <2026082637-grimace-rebirth-6239@gregkh>
In-Reply-To: <2026082637-grimace-rebirth-6239@gregkh>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 27 Aug 2026 11:08:50 +0200
X-Gm-Features: AcwNN1UnK2acP0iRolYNvxKjKdPD1tCSgUflGMpAAN5EmHBwPZjO5KMQCfjsHXE
Message-ID: <CANp29Y6Q-SmBXEUtHQqg8qdsG4fUSiN8_LfOO15Af6OgQ-sx+g@mail.gmail.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>, 
	heikki.krogerus@linux.intel.com, jeffinphilip14@gmail.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mika.westerberg@linux.intel.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 5:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 26, 2026 at 04:32:28PM +0200, Aleksandr Nogikh wrote:
> > On Wed, Aug 26, 2026 at 4:11=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Wed, Aug 26, 2026 at 03:26:23PM +0200, Aleksandr Nogikh wrote:
< ... >
> > > >
> > > > Thanks for clarifying!
> > > >
> > > > Some context from the syzkaller side:
> > > > Restricting the fuzzer is always tricky, especially when the
> > > > problematic operation is just opening a file and writing to it.
> > > >
> > > > We normally constrain openat to:
> > > > 1) An allowlist of safe absolute paths (so it won't open /dev/mem,
> > > > etc.), blocking any other path starting with '/'.
> > > > 2) Relative paths under CWD (so we can still fuzz normal file opera=
tions).
> > > >
> > > > Here the problem is that one can mount sysfs under CWD, which leave=
s
> > > > syzkaller full access to everything inside it.
> > > >
> > > > Tightening the access to /bind, /unbind, /driver_override sounds
> > > > reasonable, but trying to catch all workarounds purely in userspace
> > > > (e.g., creating symlinks to these paths before opening them) will
> > > > easily turn into a whack-a-mole.
> > > >
> > > > Would you be open to adding some kernel config option or a boot
> > > > parameter to disable manual sysfs driver bind/unbind and
> > > > driver_override? We had a similar problem with writing to a block
> > > > device while a filesystem was being mounted, which was perfectly
> > > > solved by CONFIG_BLK_DEV_WRITE_MOUNTED.
> > >
> > > I've submitted a patch to taint the kernel if these files are written
> > > to, so that should "catch" syzbot and let you know to ignore these
> > > reports if it runs into them:
> > >         https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a96=
5c@linuxfoundation.org
> > >
> > > Is that sufficient?
> >
> > Hmm, if we set `panic_on_taint=3D` with TAINT_FORCED_BIND and ignore
> > such crashes, I think it could work, yes.
>
> Great, thanks for confirming.  I'll add that to the changelog just to
> highlight how this can be used.

Thanks!

FYI, I've just merged a mitigation into syzkaller:
https://github.com/google/syzkaller/commit/c53a1b9ca227. It should
prevent syzkaller from touching /bind, /unbind, etc., at least until
it finds a workaround.

Some more such bug reports are already in the reporting pipeline and
may still reach LKML, but new ones should stop appearing.

--=20
Aleksandr

>
> greg k-h
