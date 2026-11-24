Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795530049;
	b=CMCaNzJButjxMI8H8k/4ynUSbCjiTcA+w/6kcfqxnK/O93UuDNmTNtwElVuqimCl119W
	 9aBoRco711gb6VDhYJKFE4b4KBxNM8CUCIZKnQ+wrLMeGDOWRn11mIU7kjlQLZNOOLO06
	 R7OfUYF7EdbwcfA4BYUHYoAx/hHSYsRtQUBgP1f97HPVLXe5SqgTOMW/1oUpnVQkF7oY+
	 y/f74f0rE3cTF+yf7C0V1Bp7YBoXqBQdJ7GpVMGcTVg2UyNl6AdUbidVcjqruqsx7Y0Yl
	 uWDjG6jqSITBI6PfluserRQFCi9K/NSH4HkoxbSn00zVEzGKUZCYyqbLc9s0W+JKL1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y0h22hVZxbtmWk7yVQqewBkuV98pktZusJwPn6z69Yw=;
	b=LbYH6JmIoRmixChAe+YtUBqDsj9PP8VtwT3pXUL0btZ4vnnvaY8Rdk8PBPnI8xyS7Wxu
	 bZt2wQ2fQUYISrCDy7m/1yUbs5XVFHqBte1KBS9cNm+9a64St5b8yJx1KXuP4GSIpn8uF
	 a5rDk69Z+EX4TVLYYnhVk2WO0O2/rZ/M3WMeoBpGS6uHeF0mCgX8/eXlXePeXs92Rffry
	 haiI6bfOqDwZh7Im1ISCC5YBzkEOll1uRhEaFQmDxRv8P4AZN7blpFIgAHcDrStzXRC6u
	 rlEvILNi+LWHJjRq9Han85Rmsv5FyAN4tFNDSX+tXvZM5ZGk/qyxAMaqZu40tlDd4xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CJYylu9E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF322606A335
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF322606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CJYylu9E
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-18818daa3e7so2723080c88.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795530048; cv=none;
        d=google.com; s=arc-20260327;
        b=bl7BpVce9PSRchtxgZFZhaqdVO5kdDw9HnJ9U9UlqsnLX4dBiaedP+UIsBNPmaCoRB
         rX1SZlqvsERavqiztN6anysP8ewbm2tvkEOGMKR6cj87oIDPp/SWj/wSktMzrHm5eE2V
         meoJfZO/q2j3bE6ZbxwuxytznKKv18IYUh3bdtQgQtjPs4cAylEPsVqGWBM4Pb+tQQdz
         vVtKf3OgkcKuvCfMV7W1iq90xE6Sv6b+uKAfwurMIRLltvCpLXXmAHlW9iQ/dVPAWigD
         ptJmtmbUE+lM96xYCQOXFI2Q0UvOJYZVidfANoDw9Wt8PO3ZfS6gUdK7BowNrlXbdd4z
         Eb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0h22hVZxbtmWk7yVQqewBkuV98pktZusJwPn6z69Yw=;
        fh=2Eh5GypchGp/KHHzISp4X9j/HVOcVNJYQ9ZhzDjcQCo=;
        b=HqGMy7tW/J2wxai1k0h1TqgFruw21r7m391oKVD6IG4A9F4/Mh99GoI6XIE2gHh1Ud
         hHMCIiwcuo5zyq7cve4k54udfnISg4HYRRpo5JMaxPpN8H1i11VhZD1MDWDkA7rW7N2V
         ZgrlUQj12X2vO1ci/80AyFoRitLWcM2iRBxt54aZTDY/FSaURjR4M+d3VxucrCTlMCCn
         q7/eXirJQmlwt3J7H4V4+6V07s3/u5uiqwjUpPPohOlOLLxsuOToHuet+WppyVKcjowS
         tZ1+fySWWF5p+VFrtEDoXuMbWqCzzulV48is/JYtmo2vJYK3VZ7hx7MUBa3vc77PBLCE
         8bTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530048; x=1796134848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y0h22hVZxbtmWk7yVQqewBkuV98pktZusJwPn6z69Yw=;
        b=CJYylu9E8v3fGsQhDxIDvVuZ6KSDA3nvOFJj/4LXQvNZ/yfEhYIt6O41JQESuenVPk
         lWbn3UCPRSYmFWxFDqftRaDrZ9lc9QhCGE46ENnvhhue8Me6AWmEbqcKlf7wLBABK9oa
         3mE02y2f+9+14/q4hzWCinQSzGYjqj6adIK0AYIHWjrPvpsKpBQzz64z7pYSdmeWiiY6
         mgQOjNxLS2zC79krZtgtkxFv96sVj3puoIMQYlBnyOWYeOgYsOdF8MkT9n65OIJiIoIO
         e0lYCpkbmPVWzd2faLZjdUKVCAI3f1iitOPybfojYT8MnxhP66TAOE1TBKA929kFdJL5
         qJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530048; x=1796134848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0h22hVZxbtmWk7yVQqewBkuV98pktZusJwPn6z69Yw=;
        b=KqnB2F2GZx1FFJ0nWT4lpJ+lDuSWwUXU4qZH5QjnsHQf78gtlY8dChtpc04Zz0vSYq
         MfOPerqGy0r1gQZ3fMi7lPbAX81vYPNlUz+TL9gaGswrbJ9AGJY80Ze25ggbEUaNybYQ
         4iP+5xHl1f72Cy5mAi32kbUMuwinnOESCZu6wded6cp8GGl2Ski/m5NbPl9A3c+yZjC6
         hQKsVz5HnMkXaxD8qZkJqURt9kz+cLTguT3A2WmQmlMeJHot6yVJul/04Gb6tKDimGrZ
         bsgtmZ6DyANxPOhODAPPYK3U064C39MhBPAt3CJgfWxTcPri5kMjeD4IcWzi+6Uv2YuH
         c34Q==
X-Forwarded-Encrypted: i=1; AL+hErGRikhA0Gs90cJ2jEtu1n8zPlp0CKT4hmaEtBXTCIg4W8NW0/RCP+bPMlJVtZay0vOKCxKwEYU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gmAavYg8WcRkx22dyV8xvVjUSUNPpYvbET6e5XscN7/g4CRkd
	YQEWEv7uR63WudXXKq96Sl2YkKXKstp0TOMuEpVSqJ8/EfP1mnaQOdb7ntSpqZK4+aTvgK2aiko
	Df3Qx5b+Cce4YZVU3ltkNcNgRr9PunUo=
X-Gm-Gg: AZFdTZdsppQ7be2CHT1fpkziPidhskHdb1CTyiJPx4l+9r39TwYDCmnNszdvx38BDRo
	wKtQh6JjjyJid/ptnuI0pmbJMHlRUtQeRuUU8c+cJpmdjmkd4CpP9Z6vIf9RQWAanaRxK5nnftl
	9NUl1Xf16vQP3ibu+d9a6n8Dw7p9YuDLrBTtslJWDMD0q+l6vcnLyt/+56InBmzjnSXVGtaQyH8
	UQXk/Ut+f+o4qWqjZXXtZRDl+2R3zBLvFnPUL7hm14ij9aNixHjqeiPQF5mES9FWAtdxp/nidTw
	92FDemeoViuspc3rcoLW6Yd6GWe27NlBDXYgVr/sHeFNOAZqpZ02OFbuqDJp1UUlRnk7pVW5+u+
	kv5+HjKNhljbVgPADxZHYeEHPfz5/Dd8p543c/4A=
X-Received: by 2002:a05:7022:ea4f:b0:1b5:31ed:e23b with SMTP id
 a92af1059eb24-1b5568aac99mr12606778c88.6.1795530047559; Tue, 24 Nov 2026
 06:20:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123044347.3273-1-chenguoming88s@gmail.com>
 <20261123075116.3868-1-chenguoming88s@gmail.com> <DN2JJHBVAPCY.2CNUCGCO781D6@bootlin.com>
In-Reply-To: <DN2JJHBVAPCY.2CNUCGCO781D6@bootlin.com>
From: guoming chen <chenguoming88s@gmail.com>
Date: Tue, 24 Nov 2026 22:20:35 +0800
X-Gm-Features: Aa3M54pt207_jk8iesQauUtcEdhbIWiMbFM_TfJYFPmwgZG_F_2cdAtL7SC0sqE
Message-ID: <CAHNm3OizHNb0-N-E5Vrkv+2g69F=J47Cqirtnt9Z76EYvZBiJA@mail.gmail.com>
Subject: Re: [PATCH v4] usb: cdns3: fix NULL dereference in cdns_host_resume()
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roger Quadros <rogerq@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=
=8823=E6=97=A5=E5=91=A8=E4=B8=80 19:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Guomin,
>
> On Mon Nov 23, 2026 at 8:51 AM CET, Guomin chen wrote:
> > From: Guoming Chen <chenguoming88s@gmail.com>
> >
> > cdns_host_resume() assumes that the xhci-hcd child is bound and passes
> > platform_get_drvdata() to hcd_to_xhci_priv() unchecked.  The child is
> > created by __cdns_host_init(), but xhci-plat probes it only when it
> > registers; cdns3/ precedes host/ in drivers/usb/Makefile, so with both
> > built in the child is registered before xhci-plat's initcall runs, and
> > with xhci-plat as a module it stays unbound until the module loads.
> > Platforms that allow runtime PM (cdns3-imx is the only in-tree user)
> > autosuspend the controller after 20 ms, so the parent may already be
> > suspended when the child is probed.
> >
> > Resuming the parent, either for the child's probe
> > (__driver_probe_device() calls pm_runtime_get_sync(dev->parent)) or on
> > a system-wide resume, runs cdns_host_resume() while the drvdata is
> > still NULL; xhci_plat_probe() sets it later via __usb_create_hcd().
> > hcd_to_xhci_priv(NULL) then dereferences NULL + offsetof(struct
> > usb_hcd, primary_hcd):
> >
> >   pc : usb_hcd_is_primary_hcd+0x0/0x1c
> >   lr : cdns_host_resume+0x24/0x44
> >
> > Commit 87e4b043b98a ("usb: cdns3: fix role switching during resume")
> > only skips the callback when the role changes during resume, which is
> > not the case here.
> >
> > Return early when there is no hcd to notify: the host role can fail to
> > start after cdns_role_start() set cdns->role, or the child may not be
> > probed yet.  An unbound child has no state to restore, power_lost is
> > only consumed by an initialized host, and cdns_wakeup_irq() already
> > checks cdns->host_dev the same way.  Also publish cdns->host_dev only
> > after platform_device_add() succeeds: the error paths free the child
> > with platform_device_put() while the pointer stays set, and the next
> > resume would dereference freed memory instead of bailing out.
>
> Your commit is too long and robotic; didn't read!
>
> Reading the patch, you protect against two things:
>  - cdns->host_dev =3D=3D NULL
>  - platform_get_drvdata(cdns->host_dev) =3D=3D NULL
>
> Your commit message should say that out loud and give an exact way for
> those two to occur. It should also mention the hardware used to
> reproduce the issue, with full kernel panic log.
>
> Thanks,
Hi Th=C3=A9o,

thanks for the review.  You asked for the exact way each of the two
cases happens, the hardware it reproduces on, and the full panic log;
here is what I can share, plus what I plan for v5.  Machine identifiers
are redacted from the log.

Both NULL cases are reachable in the code:

- cdns->host_dev: cdns_role_start() sets cdns->role before calling the
  role's start callback and does not undo it when the callback fails.
  cdns_resume() then calls the role's resume callback regardless of the
  role driver's state, so cdns_host_resume() runs for the host role with
  cdns->host_dev =3D=3D NULL.

- the child's drvdata: __cdns_host_init() creates the xhci-hcd platform
  device, but the drvdata is set only in xhci_plat_probe(), by
  __usb_create_hcd().  The parent is resumed before that: when the child
  is first probed, __driver_probe_device() calls
  pm_runtime_get_sync(dev->parent) before really_probe(); a system
  resume can also arrive while the child is still unbound.

What matters for this bug is the configuration, not the board: the
glue enables runtime PM (CDNS3_DEFAULT_PM_RUNTIME_ALLOW), so
cdns3-plat.c uses a 20 ms autosuspend instead of pm_runtime_forbid(),
and the controller can already be suspended when xhci-plat registers.
cdns3/ is linked before host/ in drivers/usb/Makefile, so the child can
exist and stay unbound when xhci_plat_init() later registers its
driver.  The in-tree i.MX8QM glue sets the same quirk, so the window is
not specific to this platform.

The oops below is the second case.  The faulting address, 0x208, is
offsetof(struct usb_hcd, primary_hcd), read by usb_hcd_is_primary_hcd()
through hcd_to_xhci_priv(NULL).

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000208
Mem abort info:
  ESR =3D 0x0000000096000004
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x04: level 0 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[0000000000000208] user address but active_mm is swapper
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:

pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
pc : usb_hcd_is_primary_hcd+0x0/0x1c
lr : cdns_host_resume+0x24/0x44
sp : ffff80008007ba40
x29: ffff80008007ba40
 x28: ffff0000993c8000
 x27: ffff0000a0a39148

x26: 0000000000000001
 x25: 0000000000000000
 x24: 0000000000000001

x23: 0000000000000002
 x22: ffff0000a0a39104
 x21: 0000000000000410

x20: 0000000000000000
 x19: 0000000000000000
 x18: 00000000ffffffff

x17: 2072657473696765
 x16: 722074616c705f69
 x15: 63687820746e6569

x14: 6c63203a5d6d7364
 x13: ffffc001a9b23dc8
 x12: 000000000000083d

x11: 00000000000002bf
 x10: 0000c001087aec88
 x9 : 0000000000000000

x8 : 0101010101010101
 x7 : ff7f7f7f7f7f7f7f
 x6 : 8080808080808080

x5 : 0000000000000023
 x4 : 1fffffffffffffff
 x3 : ffff0000a0a39c80

x2 : ffffc001a829e030
 x1 : 0000000000000000
 x0 : 0000000000000000

Call trace:
 usb_hcd_is_primary_hcd+0x0/0x1c (P)
 cdns_resume+0x50/0xdc
 cdnsp_controller_resume.isra.0+0x14c/0x198
 cdnsp_plat_runtime_resume+0x20/0x10c
 pm_generic_runtime_resume+0x2c/0x44
 __rpm_callback+0x48/0x1dc
 rpm_callback+0x74/0x80
 rpm_resume+0x44c/0x63c
 __pm_runtime_resume+0x4c/0x90
 __driver_probe_device+0x64/0x1a0
 driver_probe_device+0x3c/0x110
 __driver_attach+0xf4/0x1fc
 bus_for_each_dev+0x78/0xd8
 driver_attach+0x24/0x30
 bus_add_driver+0x110/0x234
 driver_register+0x60/0x128
 __platform_driver_register+0x24/0x30
 xhci_plat_init+0x44/0x50
 do_one_initcall+0x58/0x264
 kernel_init_freeable+0x1e4/0x3c0
 kernel_init+0x20/0x1dc
 ret_from_fork+0x10/0x20
Code: 52800003 f9407ca5 d63f00a0 17ffffe4 (f9410401)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception

The fix returns early in both cases.  This does not weaken the path the
commit was added for: on a system resume the child is bound and
power_lost is still forwarded to xhci-plat exactly as before.  The
other hunk, publishing cdns->host_dev only after platform_device_add()
succeeds (reported by Sashiko in v4), keeps cdns_host_exit() and the
next resume from touching a child that an error path already freed.

The log is from a 6.18-based kernel, but the function at the crash
site is unchanged from mainline, and the v5 patch applies to current
mainline.

In v5 I will state both checks and the exact path that produces each
NULL in the commit message, and include the relevant frames of this
trace; the code is unchanged.  I will send v5 shortly.

Thanks,
Guoming
