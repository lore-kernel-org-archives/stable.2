Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D9443A98;
	Wed, 26 Aug 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757789; cv=none; b=DIIMvQsovnFz1V3/R40tM3MWcvPH97OM7oPm8OgyuNXgKbgxKsEMGK9gIKMF3yHAR9ZBygiB+su4vJIqsLC90wKtvrwlq4yfAl0PDJug19XqwD+FkVVlL6UHtCPPimgseH9mfhledw0ClVMUXHcufafFmQKihYkkQyi9zH1Z3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757789; c=relaxed/simple;
	bh=8VYvqnCz95I8YAkUFkTaL7iMIVEyEyDqVu3CoGC0+Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOFRzUzv6HJAQYw5BS3ilNzfpdFV1B56P7fj0CJ8+lHGLtm2LBu2MCaO56VNFCwLe7Sh9MCglM0GZraU5HNF21hBUhYZPxhrY5HAryHL5t64Zv8hv7ofvrJAqjeoh8JvaP+z/7D6VJ2z3GdpO4tUWsGq9xRi7tiKsR5YYTpUA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p9n57ye3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p9n57ye3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2451F000E9;
	Wed, 26 Aug 2026 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787757782;
	bh=sc7WDYWXIIC5Nln9w/01Q0RsepL32iuRBKDB4dyjKss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=p9n57ye3B/j3wwCKK6ysa+d15Qwez7YZrmePTI15mynTGJ+E//OCD0nOVZn5d6693
	 mq65gp3EUZJLBWilZuqwhoyOSU9PxrxJOQq4YP3102mLch2C8qW4W+X1Plj1KxOVpg
	 M0iuy3lAXbyNJMR2biF4Q3R3x/2xyNk8ZN++YWsk=
Date: Wed, 26 Aug 2026 17:23:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>,
	heikki.krogerus@linux.intel.com, jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mika.westerberg@linux.intel.com, stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
Message-ID: <2026082637-grimace-rebirth-6239@gregkh>
References: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com>
 <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
 <2026082540-tarantula-gigantic-b786@gregkh>
 <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>
 <2026082507-ecosystem-giant-0b79@gregkh>
 <CANp29Y5hnOWaqGw8BbPu1TCr00TbvNRciYvs_VCd6Jtk=8kSPg@mail.gmail.com>
 <2026082602-compile-bogged-877d@gregkh>
 <CANp29Y486UwGwRJpqzQ4aU2eN4Xu3A+zw_zDUJuFR5hKQ+Knrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y486UwGwRJpqzQ4aU2eN4Xu3A+zw_zDUJuFR5hKQ+Knrw@mail.gmail.com>

On Wed, Aug 26, 2026 at 04:32:28PM +0200, Aleksandr Nogikh wrote:
> On Wed, Aug 26, 2026 at 4:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 26, 2026 at 03:26:23PM +0200, Aleksandr Nogikh wrote:
> > > On Tue, Aug 25, 2026 at 11:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Aug 25, 2026 at 11:04:54AM +0200, Aleksandr Nogikh wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Tue, Aug 25, 2026 at 7:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > < .. >
> > > > > >
> > > > > > Please do not think that this is a valid path for syzbot to be
> > > > > > fuzzing...
> > > > > >
> > > > >
> > > > > Can you please elaborate on this?
> > > > > Do you mean driver binding sysfs interface in general or something
> > > > > more specific?
> > > >
> > > > That is the specific thing, don't have syzbot do random bind/unbind
> > > > calls, having it attempt to bind any random driver to any random
> > > > hardware device.  That's not how bind/unbind is supposed to work at all,
> > > > it's for developers who "know what they are doing" and you get to keep
> > > > the broken system if you mess it up.
> > > >
> > > > Same for unbind.
> > > >
> > > > This is a root-only api for that reason.
> > >
> > > Thanks for clarifying!
> > >
> > > Some context from the syzkaller side:
> > > Restricting the fuzzer is always tricky, especially when the
> > > problematic operation is just opening a file and writing to it.
> > >
> > > We normally constrain openat to:
> > > 1) An allowlist of safe absolute paths (so it won't open /dev/mem,
> > > etc.), blocking any other path starting with '/'.
> > > 2) Relative paths under CWD (so we can still fuzz normal file operations).
> > >
> > > Here the problem is that one can mount sysfs under CWD, which leaves
> > > syzkaller full access to everything inside it.
> > >
> > > Tightening the access to /bind, /unbind, /driver_override sounds
> > > reasonable, but trying to catch all workarounds purely in userspace
> > > (e.g., creating symlinks to these paths before opening them) will
> > > easily turn into a whack-a-mole.
> > >
> > > Would you be open to adding some kernel config option or a boot
> > > parameter to disable manual sysfs driver bind/unbind and
> > > driver_override? We had a similar problem with writing to a block
> > > device while a filesystem was being mounted, which was perfectly
> > > solved by CONFIG_BLK_DEV_WRITE_MOUNTED.
> >
> > I've submitted a patch to taint the kernel if these files are written
> > to, so that should "catch" syzbot and let you know to ignore these
> > reports if it runs into them:
> >         https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org
> >
> > Is that sufficient?
> 
> Hmm, if we set `panic_on_taint=` with TAINT_FORCED_BIND and ignore
> such crashes, I think it could work, yes.

Great, thanks for confirming.  I'll add that to the changelog just to
highlight how this can be used.

greg k-h
