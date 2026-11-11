Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794396477;
	b=4rFcCniU20gEZv5/rQBcLpgKn6Y2QHPzUbooGcHP0Uj3aqXNiE64BoIc02irKtqEvVpq
	 eBkRD2DtvlQ81zpKirPaw2Z3STusmijw5gwDiGO9EdCUPSQa6LddjUqexRAA3Qh6jstjC
	 hlLNp/WVK+elEzJMhFcmjF5N6G9xl6v7snDwwB1cCyy0Uo79hHVdfZaIyFo+FRdAfW+iV
	 vNRdj3syJFBH0gUcJQSWi2Kl6bGceHovJXecYBZHhNLUY+5WUcS+tOLQHKuvQd9FroGt8
	 0UaGcnIGOb6k9pPDj432UsPBCW8DM5deXJzrUOFkBVzvRazJmrvtxblcxCmzSPyRqPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0EBxvvqXHIPO5CH2r1qI1PLw1SVaqc0qdtiXgsZTdiM=;
	b=EpZ4+L46cwkXiSfEbfSerQesU/1jk+A5FleHQC4njP2yZLK/RPu/PgZIR2If1csr43P7
	 CFAWsgOAcEkcepNXQyt/33oUIzVXxaMgnBRVPwa5MIy3hiyxWh0aXbw8EEEKKBCQRd8Xg
	 5Kb1diomqM8l+v8ZOmuRGwglQjydFbap7NLSQaDU1qxb72DAB2bbtwO8p0/OXH7hfd+VV
	 wZC9wKNAVnnBggOx+asnDCFbToRbcm7qBCsny6TJps/QrpGEv6okjgRR3ecGBrLUoHmKU
	 Fi+8L5VK2zNGCdA+hdFG1Z7wZ6IXdWhN45YgxGSp9rxEM3tATLyicWCJkwJrXbnMqDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=raytzfGr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A9606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A6A9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=raytzfGr
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67921b515a7so3439711d50.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:27:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794396475; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBVSlQ3V6ObAQRL//vk7uheEI6sZEjkMxR07SR2ZSRGL0yEoF3c/aR8hzLo/GpvIf2
         rY/M3aIIyVPWret/wjung58ltw9Ed64DAEa4xQhGljnHpXKGWo48E6IKfMrTOWOSXkam
         atBDvhzGXXNKlcchrXV7/M4jjV7kKFLZT6sfgBLtujEEyoBm+gDUYmSCDqzrBd6YXuhj
         LAKr4DBC+SANxUg4ZRBF1IVKc1gmaxRxrk0y30gS8Pi+/7E2ePBdHV1ayGZcVtKbt1un
         5JuyvmropnjzOs754ZkS4NCWfWgqlQ6qEkGCnnDy9t88slDu54G44hFv6Kzod3oAxSFB
         XSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0EBxvvqXHIPO5CH2r1qI1PLw1SVaqc0qdtiXgsZTdiM=;
        fh=cF0qye/zA61fArNGDBYe9C1J2OqA+oDbUMAfX/X9Lzo=;
        b=MS37C4mByRnXAcwureVFruaTFf8KxNbaY9xdtRnDAh8GK2+q+fG8OOVUVMDHVvkf0X
         7wAXLlPKC1OEAdMUI/yLRd/np5KNQoI4SMifFzzLUHxUlM0vcv8mOFNYdQIYLlpyjueT
         S8sdEQD8ydt3/lzDiWdWVbrpLEjrnhqMzefPBBLdyswRQIq85mrpwvqeQETvXxqjal9q
         fX07uU6TooO80KDi6Uxl5po172poqCFWJeNK50n7XOXzwYWgdJVTtW3TYrg8LzlfpGXM
         F+RUkAgMzLDlmEwJkHKku2Hjh/Qj4ss5xW0hWe/33PV27nfo62/X1/xY0K7v59H9mcZy
         6yCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794396475; x=1795001275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0EBxvvqXHIPO5CH2r1qI1PLw1SVaqc0qdtiXgsZTdiM=;
        b=raytzfGrF+/XLGb8+HEvRsggFid2xn1CZwWB2mRuLSFNZcBrVRtEjJvfseCBXQ0N53
         Kv8KBNkEPY3o38kZbYqSqwicKYgRpxNJZmqJe0Q2YqoQqtpix8RlnZx0kGOdKt3ry49C
         R9T+EZfHwYJTwcMUA+BzmywNN3Y8qM+CKO9BwikxFTnOWfJjiLNJ98ZAPLHxgakP+kLP
         H6nZF0R8Ra3xdeE+ZX80L+4zcg9BFIHis84l6ZVr13PhANe+7ksIgXPSx0RmbJbP4ark
         r3C2+jg6a0KA8BfhTRxXvclgz53tC7MWepf3Gs95H3X23mPMuS41O4F9MpsEWUJM5Rkb
         GJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396475; x=1795001275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0EBxvvqXHIPO5CH2r1qI1PLw1SVaqc0qdtiXgsZTdiM=;
        b=aDgd8hYYgYk80AC2z841dr3RE9SoKQ+8IWqSK6E8pnaLJBUZUiOxH6Wn2HA+KCy1z6
         Z6J8xADUDOZv/T7Q8at4POVDCqI0xnGt/11ffY6wsaPwaEkRv/CVL4bhuwztGxAUZDlU
         PSQHFtJXRrqCO+Pre1F0yGpRxcauWstamGkv/o6s6LDq2aV8+36hHPgcD3rEuje0tl3B
         RjEDGqxYXCiwtLAgd5ot7EQsrYyrbfSx9tPFdo7GaDUm9Jl9FNhWeVXKZZKaNRFWXpSR
         R89nmpijB8yz6AoYtr99zh7bzkoNUfSFcjhxAGGrcrFHja8INavCVyI4JtJLnLC4qnBS
         +qBA==
X-Forwarded-Encrypted: i=1; AL+hErF8uesGdED0500GmFWM6XRWjwd9iqupW9i5aQeDhih2UAAUJzsat3NAdnsJubBhzK7kSK4yq28=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TZoTnTyHQiJORnLn7Rdx1CN87yc6v9sMpfQ6eupVAx0YYoXW6
	quHAYRhfR/Z3SPs//+GhaHOUhJMQuBSnC4XUyk0CWsWvu87EQDPPLr1gzigWH2CYSrX4IVF5/dr
	zFBIkjSGkSwL1sEMP/LeUiLCFzl1QbLk=
X-Gm-Gg: AYBFou0ex7ycA91hILWQYNUd31ETQ4BQ34Nrpm9y4p8muFj1JTHns92VSHxDobOfC5X
	grFLlg2pvGZ4voc+/MmQBI5hILpt0HvDZ3+EfPb6y+vm8uNdoHgMNtSqWCf5ypfmW4ZEJ4VgK+n
	TX9vYHH1YpV+zR2fULbMnekaIDV32/Wed0Mn4id1dTE1E4qHzeTbIZGA0dXfl+b3f01lvd027Te
	8dEjfXwrSDx3XpqV+cAYNoWID16CvAt5vrUD9c2NqSki+wVuVrtdvq+q1i6FEIAmCNmvSR6gDbm
	X7/PAMIH8AqPo2Hx60pe5gOBlHgKkZgAM9XyAWcyPUzqzMF8FqONPglbGbVnqvwCeb0uxZQXjIk
	U7+MWLK07VBM7mBCAW4kMjvRSLGgZ/xHW+GXFD0tzoG9ThqHmDSZJzuLtYGAS1omvCWC1G/U/yB
	UmAsml8AeVPzM=
X-Received: by 2002:a05:690e:4509:10b0:67b:f332:3030 with SMTP id
 956f58d0204a3-67c67ea2783mr1208582d50.26.1794396475030; Wed, 11 Nov 2026
 03:27:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110150250.71520-1-ekffu200098@gmail.com> <87cxsbg1fs.fsf@igalia.com>
In-Reply-To: <87cxsbg1fs.fsf@igalia.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 11 Nov 2026 20:27:43 +0900
X-Gm-Features: AclHuK9BiFb6sNzHQ9jjn5eMBNmWcB62rZUWBjlZHzqw5mESL9SL1A56UNQEYP8
Message-ID: <CABFDxMHOy2JRYfCk0ovp3nzXWMjpXyiYsLGO3k3Up3e76Z-wXw@mail.gmail.com>
Subject: Re: [PATCH] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Luis

2026=EB=85=84 11=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:28, =
Luis Henriques <luis@igalia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Nov 11 2026, Sang-Heon Jeon wrote:
>
> > inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
> >
> > But inval_wq_set() can be called at boot or module load before
> > fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
> > warns and the work never starts.
> >
> > So defer scheduling the work until fuse_dentry_tree_init() sets it up.
> >
> > Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate e=
xpired dentries")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > QEMU based test result
> > - booted with "fuse.inval_wq=3D5"
>
> Thank you, Sang-Heon.  I've sent a fix for this already[1], but sashiko
> still has some race complains which I haven't looked into yet.  But maybe
> Miklos is happier with your patch, in which case you can add my

Sorry, I missed that thread.. sashiko also complains about the same
race condition between init and sysfs setup. But I'm not sure it is a
realistic scenario. So I want to hear other voices as well.

> Reviewed-by: Luis Henriques <luis@igalia.com>

Thanks for your review :)

> [1] https://lore.kernel.org/20261106155512.24801-1-luis%40igalia.com
>
> Cheers,
> --
> Lu=C3=ADs
>
> > 1) AS-IS (before fix)
> > [    0.011073] Kernel command line: rootwait root=3D/dev/vda console=3D=
tty1 console=3DttyS0 nokaslr  fuse.inval_wq=3D5
> > [    0.011114] ------------[ cut here ]------------
> > [    0.011115] WARNING: kernel/workqueue.c:2704 at __queue_delayed_work=
+0x11a/0x140, CPU#0: swapper/0
> > [    0.011124] Modules linked in:
> > [    0.011128] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.4.0-rc1=
-00010-gab9787d7e66a #1 PREEMPT(undef)
> > [    0.011130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
> > [    0.011131] RIP: 0010:__queue_delayed_work+0x11a/0x140
> > [ 0.011133] Code: c4 08 48 89 df 5b e9 85 28 0a 00 90 0f 0b 90 4c 8b 42=
 08 48 8d
> > 42 08 49 39 c0 0f 84 1c ff ff ff 90 0f 0b 90 e9 13 ff ff ff 90 <0f> 0b =
90 e9 ec
> > fe ff ff bff
> > [    0.011134] RSP: 0000:ffffffff82e03e00 EFLAGS: 00010003 ORIG_RAX: 00=
00000000000000
> > [    0.011135] RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000=
000001388
> > [    0.011136] RDX: ffffffff83a3f320 RSI: 0000000000000000 RDI: 0000000=
000000040
> > [    0.011136] RBP: 0000000000000000 R08: 0000000000000082 R09: 0000000=
000000001
> > [    0.011136] R10: 000000000000000a R11: 000000000000000a R12: fffffff=
f82c09fd0
> > [    0.011137] R13: ffff88807ffcfb89 R14: 0000000000000000 R15: 0000000=
000001388
> > [    0.011140] FS:  0000000000000000(0000) GS:ffff8880fa26e000(0000) kn=
lGS:0000000000000000
> > [    0.011141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.011141] CR2: ffff888003a67000 CR3: 0000000002e30000 CR4: 0000000=
0000000b0
> > [    0.011142] Call Trace:
> > [    0.011143]  <TASK>
> > [    0.011143]  queue_delayed_work_on+0x6a/0x80
> > [    0.011145]  inval_wq_set+0xc4/0xe0
> > [    0.011149]  parse_args+0x299/0x3c0
> > [    0.011151]  ? __pfx_unknown_bootoption+0x10/0x10
> > [    0.011154]  start_kernel+0x3b8/0x7c0
> > [    0.011156]  ? __pfx_unknown_bootoption+0x10/0x10
> > [    0.011157]  x86_64_start_reservations+0x24/0x30
> > [    0.011160]  x86_64_start_kernel+0xd1/0xe0
> > [    0.011162]  common_startup_64+0x13e/0x158
> > [    0.011165]  </TASK>
> > [    0.011166] ---[ end trace 0000000000000000 ]---
> > [    0.011173] ------------[ cut here ]------------
> >
> > 2) TO-BE (after fix)
> > - no error while booting, and also fuse_dentry_tree_work works well.
> >
> > ---
> >  fs/fuse/dir.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index da23ccd8685c..6965a77a871f 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
> >  /* Minimum invalidation work queue frequency */
> >  #define FUSE_DENTRY_INVAL_FREQ_MIN 5
> >
> > +static bool inval_wq_ready;
> >  unsigned __read_mostly inval_wq;
> >  static int inval_wq_set(const char *val, const struct kernel_param *kp=
)
> >  {
> > @@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const struc=
t kernel_param *kp)
> >
> >       *((unsigned int *)kp->arg) =3D num;
> >
> > +     /* Defer the work until fuse_dentry_tree_init() sets it up. */
> > +     if (!inval_wq_ready)
> > +             return 0;
> > +
> >       if (num && !old)
> >               schedule_delayed_work(&dentry_tree_work,
> >                                     secs_to_jiffies(num));
> > @@ -224,6 +229,11 @@ void fuse_dentry_tree_init(void)
> >               dentry_hash[i].tree =3D RB_ROOT;
> >       }
> >       INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
> > +     inval_wq_ready =3D true;
> > +
> > +     if (inval_wq)
> > +             schedule_delayed_work(&dentry_tree_work,
> > +                                   secs_to_jiffies(inval_wq));
> >  }
> >
> >  void fuse_dentry_tree_cleanup(void)
> >
> > base-commit: ab9787d7e66ac7e6e94fc975b37c5b56fff98ca9
> > --
> > 2.53.0
> >
>

Best regards,
Sang-Heon Jeon
