Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FE439F91;
	Wed, 26 Aug 2026 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753478; cv=none; b=qbDPhRG+LvSWD2QgqGzBT7jjHFgoeC4z13IeHrlsdSSMh5AjJ/5Fqfx6CY1jOFdeDnE8Ui7qp7VbWax5gQR61/SN3tBuHO6MaWMsOs4v6bDGXencz5FKiUBRKBhyCtVecYzJW6lLwV1sNZ9T6ML44vTsIOa8hXUZHDipp6De5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753478; c=relaxed/simple;
	bh=C2wFX4a7JH+wAsDrmBFi2nJ+gTPgJlOiAawjFmE9MPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxtYJMUC3czFOhCAmwWt0oQWRNhDBV6QWTp8ZvgurwzgMIWNdw4RwRP+EEzMB+eCxZYRaM1elTBiY7S2yb9cD9obc+HZhnR9rpIp/qQqKFl5A2tbt5HpTGs91KwyElRRsPYOpP6u9JvPdqamCc7ufdMAF5nJR6WHt6zgEvPT9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2IecTteg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2IecTteg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89C31F000E9;
	Wed, 26 Aug 2026 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787753475;
	bh=CrzOdB/wPEZMMB6aZYaBXZVWcP1Br6WDZGYvIB/24Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2IecTtegQL4jO7bnZ4BG17uFcbFjqVTY+aUCBHHmVCvIYgVmNLXtA69pnYufrrMn6
	 gSja34YePJxcZ50PEINz1/plmIZCgpjoKZBnueDfFFnWjQ7lc2RVo9mR7pj68TAmAM
	 GOTZrOqZnhHMo+tW8UDagy2n5N7SPxjf1ExGITls=
Date: Wed, 26 Aug 2026 16:11:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>,
	heikki.krogerus@linux.intel.com, jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mika.westerberg@linux.intel.com, stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
Message-ID: <2026082602-compile-bogged-877d@gregkh>
References: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com>
 <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
 <2026082540-tarantula-gigantic-b786@gregkh>
 <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>
 <2026082507-ecosystem-giant-0b79@gregkh>
 <CANp29Y5hnOWaqGw8BbPu1TCr00TbvNRciYvs_VCd6Jtk=8kSPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y5hnOWaqGw8BbPu1TCr00TbvNRciYvs_VCd6Jtk=8kSPg@mail.gmail.com>

On Wed, Aug 26, 2026 at 03:26:23PM +0200, Aleksandr Nogikh wrote:
> On Tue, Aug 25, 2026 at 11:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 25, 2026 at 11:04:54AM +0200, Aleksandr Nogikh wrote:
> > > Hi Greg,
> > >
> > > On Tue, Aug 25, 2026 at 7:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> < .. >
> > > >
> > > > Please do not think that this is a valid path for syzbot to be
> > > > fuzzing...
> > > >
> > >
> > > Can you please elaborate on this?
> > > Do you mean driver binding sysfs interface in general or something
> > > more specific?
> >
> > That is the specific thing, don't have syzbot do random bind/unbind
> > calls, having it attempt to bind any random driver to any random
> > hardware device.  That's not how bind/unbind is supposed to work at all,
> > it's for developers who "know what they are doing" and you get to keep
> > the broken system if you mess it up.
> >
> > Same for unbind.
> >
> > This is a root-only api for that reason.
> 
> Thanks for clarifying!
> 
> Some context from the syzkaller side:
> Restricting the fuzzer is always tricky, especially when the
> problematic operation is just opening a file and writing to it.
> 
> We normally constrain openat to:
> 1) An allowlist of safe absolute paths (so it won't open /dev/mem,
> etc.), blocking any other path starting with '/'.
> 2) Relative paths under CWD (so we can still fuzz normal file operations).
> 
> Here the problem is that one can mount sysfs under CWD, which leaves
> syzkaller full access to everything inside it.
> 
> Tightening the access to /bind, /unbind, /driver_override sounds
> reasonable, but trying to catch all workarounds purely in userspace
> (e.g., creating symlinks to these paths before opening them) will
> easily turn into a whack-a-mole.
> 
> Would you be open to adding some kernel config option or a boot
> parameter to disable manual sysfs driver bind/unbind and
> driver_override? We had a similar problem with writing to a block
> device while a filesystem was being mounted, which was perfectly
> solved by CONFIG_BLK_DEV_WRITE_MOUNTED.

I've submitted a patch to taint the kernel if these files are written
to, so that should "catch" syzbot and let you know to ignore these
reports if it runs into them:
	https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org

Is that sufficient?

If not, no, I really don't want to make a kernel config option just for
this type of thing.

thanks,

greg k-h
