Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB232D7F8;
	Tue, 25 Aug 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648861; cv=none; b=b0zQGsdH1cL9QL8qiuFDjmEiOR/o8R4n1mT+GTmm5Ytli/wSgmkTJpmo77ZWHEDffXzTMNcfkUr0MB2ouj3L25CrdjrW3o8AMWjhkVNA5DJN/pMi5e4hJPz/rFmWwtMe/FXzqIjoxkclLWl5yphrH/nGeKD6ANub7M/rwFrsRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648861; c=relaxed/simple;
	bh=5j9NgmfhwMy8iFyGp5BxhBVyjLSpkpEkQCOlZ/dKhcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scZcTWpaSiEPCrMTIYh3CeS09aeCRGu2aY3QV/3KbsdaNNJEJxittS6bP1pwQQvslLf5jA5k+r+TBG2/e0dOoZ3KfujOfdtXC74WZAvDZycAjZyUzIBhSwtvoZvKi79BsqpeTjXke12G3rmxDo5z4O+sDVDC8DtXUhijNrqwSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sR76LBce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sR76LBce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847051F00A3D;
	Tue, 25 Aug 2026 09:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787648860;
	bh=MREykWfpWMIjM4Zk6oIsfpcL2CpkEZKmclpnMSs7jO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sR76LBceeEt7OrTJOZOalKxPl+kgPghiI1Gb/5V4nYcczS4a+8+QoEvbEWd1O7Ngk
	 w/7b2hIsNHV4HCfgKMqSGfAAbNVGdVUkbzpIPvarsxwS2WxyWPCOOeZreZcxJKc5bR
	 w5ePRtlNxwMuaQxTd1EQBZrXwcE4b0Ie5J7VEyxM=
Date: Tue, 25 Aug 2026 11:07:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>,
	heikki.krogerus@linux.intel.com, jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mika.westerberg@linux.intel.com, stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
Message-ID: <2026082507-ecosystem-giant-0b79@gregkh>
References: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com>
 <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
 <2026082540-tarantula-gigantic-b786@gregkh>
 <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>

On Tue, Aug 25, 2026 at 11:04:54AM +0200, Aleksandr Nogikh wrote:
> Hi Greg,
> 
> On Tue, Aug 25, 2026 at 7:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 24, 2026 at 08:43:40PM -0700, syzbot wrote:
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    66498c75b4f8 Merge tag 'dmaengine-7.3-rc1' of git://git.ke..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1253719e580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3e64b1bf01d830ed
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1a01783ea233350598b5
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > userspace arch: i386
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17491979580000
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-66498c75.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/5ce4685e13ba/vmlinux-66498c75.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6a32d8e997a7/bzImage-66498c75.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com
> > >
> > > Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
> > > KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> > > CPU: 0 UID: 0 PID: 5912 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > RIP: 0010:wcove_typec_probe+0xdb/0x780 drivers/usb/typec/tcpm/wcove.c:621
> > > Code: 48 c1 ea 03 80 3c 02 00 0f 85 af 05 00 00 48 8d 7d 08 4d 89 af 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 7f 05 00 00 49 8d bf 90 00 00 00 48 8b 6d 08 48
> > > RSP: 0018:ffffc90002f6faf8 EFLAGS: 00010202
> > > RAX: dffffc0000000000 RBX: ffff8880226c1000 RCX: 0000000000000000
> > > RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000008
> > > RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
> > > R10: ffff888014243883 R11: 000000000000001f R12: ffffffff904a7ea8
> > > R13: ffff8880226c1010 R14: ffff8880142438c0 R15: ffff888014243838
> > > FS:  0000000000000000(0000) GS:ffff888096982000(0063) knlGS:00000000f67e5b40
> > > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > > CR2: 0000000032e24008 CR3: 000000004e2f1000 CR4: 0000000000352ef0
> > > Call Trace:
> > >  <TASK>
> > >  platform_probe+0x106/0x1d0 drivers/base/platform.c:1507
> > >  call_driver_probe drivers/base/dd.c:628 [inline]
> > >  really_probe+0x241/0xa60 drivers/base/dd.c:706
> > >  __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
> > >  device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
> > >  bind_store+0xf4/0x190 drivers/base/bus.c:267
> >
> > Please do not think that this is a valid path for syzbot to be
> > fuzzing...
> >
> 
> Can you please elaborate on this?
> Do you mean driver binding sysfs interface in general or something
> more specific?

That is the specific thing, don't have syzbot do random bind/unbind
calls, having it attempt to bind any random driver to any random
hardware device.  That's not how bind/unbind is supposed to work at all,
it's for developers who "know what they are doing" and you get to keep
the broken system if you mess it up.

Same for unbind.

This is a root-only api for that reason.

thanks,

greg k-h
