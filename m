Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405505;
	b=IZ/ObkvzGqo2FLv8ahoA554+c+zK7EFH7rv5ZMnjhk2W/ZnBfgpwL26Ypn/YH2hSk+2i
	 lfIAOVivMYZ61rvDRUDGvuQfFvdqvnk3XKTrJE1hdauvKUmInIhRBldR+vG/1TAIq39wr
	 yfcmIIY06BNCC9+BmfaAZHCRkM6au4O3TMtXYa3wplyi+8gYfY7l0USSSeFwmcV0LQewG
	 NXGwg7oMD1X6WWThXMivRZcyK/M1jV3i5NzRXf6jv1wmszzklMbxkPoKAa+3xDC/VmsZ6
	 nsSV/VRjJG5wlxHqvBKkeqOVAZ4yZYd6lzSASjPlqfZH6hsq9D98LqF4FUnOffVyHgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405505;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bq+DPKenrrA3UwT5KiiqalwoYc+RZBQDTV4Tm7GTzTU=;
	b=0U4RWI8IysSArapf4WDDFnCSNd2D77/JPhrkg/GSi2x6csyr2HlwQy0FX3ihX6fB6uHM
	 wDvvRslJDl/9fEfqISHk5H8x6COjP4mNOVjSXqChDl4fg3UnkrHGf4kb040j1GP3qyoBd
	 4Xjh4hwSlWq68WERVYNmnGFGWn6e8ywAfx0O55EtSmm5DrdN/1ZbFl7bV39Cv514jWzJW
	 Xglk+JHJIq5pidEvsrQ1NIRtVwVDMoP0JSimcuDoR/QhS1R7SLCmlHuM4y2gPM21+BRsa
	 CgyN5YIcZ4Pmd6WJrVKnU0S3ywd8XT0bgyUENxARyhEeoOg7Err/V8o8CD8UDlycuWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VvHCNe9a;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BDC606A321;
	Wed, 11 Nov 2026 13:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45BDC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VvHCNe9a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=Bq+DPKenrrA3UwT5KiiqalwoYc+RZBQDTV4Tm7GTzTU=; t=1794405503; x=2109765503; 
	b=VvHCNe9az88hUK4BsX53T45O7ReJaFzbbmT8YwtjcQivqiQ9J3VqA6vdTjHXu4N4EPfO98KPjMP
	rlBMf3jthFSo/R/ErXnC8rzm+p7bYo0Maq4C4czjnHmJcbYOcwi6p8/7jZJ+Z15IRCwQv+DQ/Z3i+
	v9Xfa/b6I/VnznhsJ1plZKlAZrlSgwYek4a3yiSvTOPdaTm23d1Bwr4HF/dYjAsryk9/oop1VVyU2
	pBPZlMnGgPFr5BhapQy9WZ18wQvsSi0QOF8iX/D02H/SrzeMR4m9/Z6MzNfNPxTxPphwmCAOsCK3Y
	aKINqLKc2p2Li+ep/cLhMBdfLvFByrLDfl0A==;
Received: from bl16-24-61.dsl.telepac.pt ([188.81.24.61] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xR8q6-008qkM-37; Wed, 11 Nov 2026 14:58:14 +0100
From: Luis Henriques <luis@igalia.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  fuse-devel@lists.linux.dev,
  linux-kernel@vger.kernel.org,  Miklos Szeredi <mszeredi@redhat.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
In-Reply-To: <CABFDxMGJ+Uum7dde3AN5Ab+H4Gwb23Upj7r9=SO21NWCo+Mhow@mail.gmail.com>
References: <20261110150250.71520-1-ekffu200098@gmail.com>
	<87cxsbg1fs.fsf@igalia.com>
	<CABFDxMHOy2JRYfCk0ovp3nzXWMjpXyiYsLGO3k3Up3e76Z-wXw@mail.gmail.com>
	<CABFDxMGJ+Uum7dde3AN5Ab+H4Gwb23Upj7r9=SO21NWCo+Mhow@mail.gmail.com>
Date: Wed, 11 Nov 2026 13:59:55 +0000
Message-ID: <87mrrf8o4k.fsf@igalia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11 2026, Sang-Heon Jeon wrote:

> 2026=EB=85=84 11=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 8:27=
, Sang-Heon Jeon <ekffu200098@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>>
>> Hi, Luis
>>
>> 2026=EB=85=84 11=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:2=
8, Luis Henriques <luis@igalia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>> >
>> > On Wed, Nov 11 2026, Sang-Heon Jeon wrote:
>> >
>> > > inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
>> > >
>> > > But inval_wq_set() can be called at boot or module load before
>> > > fuse_dentry_tree_init() initializes the work, so __queue_delayed_wor=
k()
>> > > warns and the work never starts.
>> > >
>> > > So defer scheduling the work until fuse_dentry_tree_init() sets it u=
p.
>> > >
>> > > Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidat=
e expired dentries")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>> > > ---
>> > > QEMU based test result
>> > > - booted with "fuse.inval_wq=3D5"
>> >
>> > Thank you, Sang-Heon.  I've sent a fix for this already[1], but sashiko
>> > still has some race complains which I haven't looked into yet.  But ma=
ybe
>> > Miklos is happier with your patch, in which case you can add my
>>
>> Sorry, I missed that thread.. sashiko also complains about the same
>> race condition between init and sysfs setup. But I'm not sure it is a
>> realistic scenario. So I want to hear other voices as well.
>
> I also checked the other sashiko's complaints from your patch, the one
> about race between module cleanup and sysfs. It looks easier to
> reproduce, but still I'm not sure this is a realistic problem. If it
> is worth fixing, I will sent v2 with serialization between module
> init, cleanup and inval_wq_set()

I agree that the first race doesn't look realistic, though it could be
fixed by adding an extra spinlock (which could protect both inval_wq and
dentry_tree_is_initialised).

The second race would be easier to fix by setting
dentry_tree_is_initialised back to 'false' in fuse_dentry_tree_cleanup().

One thing I like with my version of the fix is that it replaces the usage
of schedule_delayed_work() by mod_delayed_work().  But maybe that's out
of the scope of this fix, and I should send that separately.

Cheers,
--=20
Lu=C3=ADs


>> > Reviewed-by: Luis Henriques <luis@igalia.com>
>>
>> Thanks for your review :)
>>
>> > [1] https://lore.kernel.org/20261106155512.24801-1-luis%40igalia.com
>> >
>> > Cheers,
>> > --
>> > Lu=C3=ADs
>> >
>> > > 1) AS-IS (before fix)
>> > > [    0.011073] Kernel command line: rootwait root=3D/dev/vda console=
=3Dtty1 console=3DttyS0 nokaslr  fuse.inval_wq=3D5
>> > > [    0.011114] ------------[ cut here ]------------
>> > > [    0.011115] WARNING: kernel/workqueue.c:2704 at __queue_delayed_w=
ork+0x11a/0x140, CPU#0: swapper/0
>> > > [    0.011124] Modules linked in:
>> > > [    0.011128] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.4.0-=
rc1-00010-gab9787d7e66a #1 PREEMPT(undef)
>> > > [    0.011130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
>> > > [    0.011131] RIP: 0010:__queue_delayed_work+0x11a/0x140
>> > > [ 0.011133] Code: c4 08 48 89 df 5b e9 85 28 0a 00 90 0f 0b 90 4c 8b=
 42 08 48 8d
>> > > 42 08 49 39 c0 0f 84 1c ff ff ff 90 0f 0b 90 e9 13 ff ff ff 90 <0f> =
0b 90 e9 ec
>> > > fe ff ff bff
>> > > [    0.011134] RSP: 0000:ffffffff82e03e00 EFLAGS: 00010003 ORIG_RAX:=
 0000000000000000
>> > > [    0.011135] RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000=
000000001388
>> > > [    0.011136] RDX: ffffffff83a3f320 RSI: 0000000000000000 RDI: 0000=
000000000040
>> > > [    0.011136] RBP: 0000000000000000 R08: 0000000000000082 R09: 0000=
000000000001
>> > > [    0.011136] R10: 000000000000000a R11: 000000000000000a R12: ffff=
ffff82c09fd0
>> > > [    0.011137] R13: ffff88807ffcfb89 R14: 0000000000000000 R15: 0000=
000000001388
>> > > [    0.011140] FS:  0000000000000000(0000) GS:ffff8880fa26e000(0000)=
 knlGS:0000000000000000
>> > > [    0.011141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > [    0.011141] CR2: ffff888003a67000 CR3: 0000000002e30000 CR4: 0000=
0000000000b0
>> > > [    0.011142] Call Trace:
>> > > [    0.011143]  <TASK>
>> > > [    0.011143]  queue_delayed_work_on+0x6a/0x80
>> > > [    0.011145]  inval_wq_set+0xc4/0xe0
>> > > [    0.011149]  parse_args+0x299/0x3c0
>> > > [    0.011151]  ? __pfx_unknown_bootoption+0x10/0x10
>> > > [    0.011154]  start_kernel+0x3b8/0x7c0
>> > > [    0.011156]  ? __pfx_unknown_bootoption+0x10/0x10
>> > > [    0.011157]  x86_64_start_reservations+0x24/0x30
>> > > [    0.011160]  x86_64_start_kernel+0xd1/0xe0
>> > > [    0.011162]  common_startup_64+0x13e/0x158
>> > > [    0.011165]  </TASK>
>> > > [    0.011166] ---[ end trace 0000000000000000 ]---
>> > > [    0.011173] ------------[ cut here ]------------
>> > >
>> > > 2) TO-BE (after fix)
>> > > - no error while booting, and also fuse_dentry_tree_work works well.
>> > >
>> > > ---
>> > >  fs/fuse/dir.c | 10 ++++++++++
>> > >  1 file changed, 10 insertions(+)
>> > >
>> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> > > index da23ccd8685c..6965a77a871f 100644
>> > > --- a/fs/fuse/dir.c
>> > > +++ b/fs/fuse/dir.c
>> > > @@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
>> > >  /* Minimum invalidation work queue frequency */
>> > >  #define FUSE_DENTRY_INVAL_FREQ_MIN 5
>> > >
>> > > +static bool inval_wq_ready;
>> > >  unsigned __read_mostly inval_wq;
>> > >  static int inval_wq_set(const char *val, const struct kernel_param =
*kp)
>> > >  {
>> > > @@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const st=
ruct kernel_param *kp)
>> > >
>> > >       *((unsigned int *)kp->arg) =3D num;
>> > >
>> > > +     /* Defer the work until fuse_dentry_tree_init() sets it up. */
>> > > +     if (!inval_wq_ready)
>> > > +             return 0;
>> > > +
>> > >       if (num && !old)
>> > >               schedule_delayed_work(&dentry_tree_work,
>> > >                                     secs_to_jiffies(num));
>> > > @@ -224,6 +229,11 @@ void fuse_dentry_tree_init(void)
>> > >               dentry_hash[i].tree =3D RB_ROOT;
>> > >       }
>> > >       INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
>> > > +     inval_wq_ready =3D true;
>> > > +
>> > > +     if (inval_wq)
>> > > +             schedule_delayed_work(&dentry_tree_work,
>> > > +                                   secs_to_jiffies(inval_wq));
>> > >  }
>> > >
>> > >  void fuse_dentry_tree_cleanup(void)
>> > >
>> > > base-commit: ab9787d7e66ac7e6e94fc975b37c5b56fff98ca9
>> > > --
>> > > 2.53.0
>> > >
>> >
>>
>> Best regards,
>> Sang-Heon Jeon
