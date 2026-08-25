Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92E3E639E
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648709; cv=pass; b=BVBrjUWA6/3H5aPFXPIXXkqQmNRUGqC0qvc49dI5bc8CM/KNS9OOTP1FcsbeMqmUG/D7HYdLsF4taOAfJZLmL32cnbdCMdPaL+sld/0dy8JQlImtnf9IyqHk0/y85IcsORbiaW5oEmb3RGpiCKA4N4Zu7+6o2SxBtr2FK7Dptl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648709; c=relaxed/simple;
	bh=ePuHPz3IUOn/zqxGX9xHVY/XTOEU15Ejbga5U1h1HjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0BYCLD+bR9EkTXJmQd0OO3N5dcQAOG+A4tdGO9zLt5ZjP9THNVDCFGZ9ONZ9MLblvcC15nVThj2NyIZSpM2uISy+MF5yBf98gcFWwa7+W5SwR+8CDzOQVy3ay503RGfx102udWgVA6RGD/d/odpR5s3fyDSF6t5/zeJ6f4zfSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2Yl2j78; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2Yl2j78"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-448b89f700fso4021822fac.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787648706; cv=none;
        d=google.com; s=arc-20260327;
        b=N1GvOQf5hUDW7jTEvPyPYqtokmkNcm1SanAPlZbFPsA8M/k+tSPZJNtiPfwJ46tWGD
         V57ajxXS5NsSgXaQveXSJWdq8KEshVF0qt23Gjyz9vJxv83xB1YHTPROUSLOzA1dKbCN
         xysiJwKhR0kY4+A3bzo07IlBPlo3SPhFV55PdHhAIy/BtMZqTOQswksX8Pc5xD/KmJMp
         d/aFjzhNSgoqolyakDyOU5IXCSdEd1mIWaQHdtdVI+wZD+jlMDuUdfx6BjMJhxYX3hvV
         NcWlw4F/gD/LLtOvLf1DeFGGYpD8yW1gY34sRbIr4Yfl5b3C+axg3W4sJ4i/t1zSbhig
         acCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yXP5ICtDHoTENRbX0dZZlEib6eWsD00QduAdB9iB3C0=;
        fh=m2s0yzxXdEs07uoWavrN9DSAbCQHeIgyJAcbMlTVH28=;
        b=hV5W+OadByHCzoiI9MIgNl774/Pg8LQ1PbMzBIh4zElRmldtZArCkVWsk5NMHSsIs8
         BwUrzQrfsZdZLn8dNXA4yfyKFBtJO8MaZW671WexYspyQLPVGyZPu1WRhrf+XlJyNKpM
         16COggESm+NN9cho8B7sejYuwMom1Za3i0WMTJH+Ou97spBKO1orL708yB6hvmHJ8X3z
         f21S2UwpZNGGHR1wymtJ86lpSv7/aiwJSwhyCdL4Fndu1akDw4KpTwC/RJC9vqu41jjk
         toQ987arSD5F1qI1Sl/dGAUlq7XDrXO2IbwT7wXZyzAnRharJt5uvuqYTcbySDydumJq
         4HMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787648706; x=1788253506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yXP5ICtDHoTENRbX0dZZlEib6eWsD00QduAdB9iB3C0=;
        b=V2Yl2j78/XJtHzwQpkk7cNU0r81/66tuBkte0wmmCxgFy00d8k3gaoJi0HWbI4mYYd
         EjkD6oluVxOkA3wTMP1Vq+n3U+i4V0b/SnO1rwoxX8+lfpSGRqmeapJqI3z2WwBp5bE8
         pm3BzM0K31t/y5/o5Q7DXGAKoXMdi9ualN2IE9A2/ndO6tv/Dp846KP7/ikoBFkh1dHu
         SA3wsEMkmypc4nlOs3+XcuvQ7sYZWc6glftnoPL4h6xLev1kbgZE7q1TYSPHqQ8qq4Lv
         kqGcinqrG8Ye9SiJ2k8WiYS3xkYQIpvpMXunqArjv5O3SZvVKMT2Cp4sK4QaI4CE0PrQ
         0F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648706; x=1788253506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXP5ICtDHoTENRbX0dZZlEib6eWsD00QduAdB9iB3C0=;
        b=o76RPxZkeWzThqu57dNX2yXCcEDvQZaW7gevZ41rOtkXVrKDPFImPeGwi1IOMzNPKo
         Dey9o6rD+qOf+Nm0cm8zJlmrIWEbj0fMyNdOpvsPey7t7FzRZWRtgnebCGhNo3nMjyw5
         ZqNNJA95nKdUJyN3zbN4ChKDw3V7pnX4GSUfUU0ojFvB3aWojIya2qCVL5+aGO+KjZAm
         zYAkBmBGRRkXUvARrzidYMghLGZMnPQSuXZP7tSU7pMJLE3xKTFtOsYcDbNiZ5+mvzqT
         oksZ2phy86luoIg5BOKoUbVys7FOqTTThbwAHnntLWl5bupgBbnRMuA6gLuFIpd0HUhN
         4Q1A==
X-Forwarded-Encrypted: i=1; AHgh+Romd1i0c/FWjUdEkgD3/CwNN8GethhJPpKD8bgID/ROXKR6pzr6Uk45FR4rJVXLNcGNDfKLYY8=@vger.kernel.org
X-Gm-Message-State: AFuF++nD1QCVRqXlL3h3Yo2OYSSnruLMLIXoQipoyCzDVnGSapQFaq5L
	2Wm+sMHRPNsVDHjiT1WYU7IzvjVwzBy2tH8ALyRbaI0qGpFI6lDpIf/KaZ4l/kx4Srngi6+JEkL
	qp/FSze09a4cs9GuDHCxJIGkoLaOf6+rdD4Zi506E
X-Gm-Gg: AR+sD12v4U71+/0vbZcN2Hb8Fsu38wrqxRfhJHgraZHtE7ldX5jKLEZ25tlmIWVy1Km
	u7WOXr5VMDWTpq2aVv6kiBGNwMOBZz+PUhMP4af511iosY0pBa3FaIdch5nu3TbchrTpZNPQEsJ
	E3GeQ9eIHXIiS2pSTGC2fITZZaz3pxuavMi1IY2s9W8Onu3OYeVN1Y2mOedFnCKPXSSKsPK6AOx
	MtvT2CKu4SEJYkoYWkH+T9QbbN6ODnFd/rlPYPMJ1hrgiO/anoUGf4IJdG1mHjNgV4f41IfLsQK
	/VCj2fkxoYvY0HM7baEE8EulJaV5Dc1nJkTKF0l8VCh7quFiCpoB2Jxv2dN3yMryOd9DATboBwJ
	baOiSTpOFPITtl7QRDRiOt40dMJYNcn6O6z3MhcVlzVkjPkLvZ3PEIS1lbSTUu+BFs7/UhzcunC
	KMrKPX4FiY4AzgUramdlNGi0c=
X-Received: by 2002:a05:6820:1c98:b0:6b1:409f:3824 with SMTP id
 006d021491bc7-6b1990acf23mr556931eaf.14.1787648705846; Tue, 25 Aug 2026
 02:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com> <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
 <2026082540-tarantula-gigantic-b786@gregkh>
In-Reply-To: <2026082540-tarantula-gigantic-b786@gregkh>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 25 Aug 2026 11:04:54 +0200
X-Gm-Features: AcwNN1WmaoJsOSdeJp-RaXzMW2D833rZFMXrhzKAoqWgErgpY0dkISiynVPJotI
Message-ID: <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>, 
	heikki.krogerus@linux.intel.com, jeffinphilip14@gmail.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mika.westerberg@linux.intel.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Aug 25, 2026 at 7:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Aug 24, 2026 at 08:43:40PM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    66498c75b4f8 Merge tag 'dmaengine-7.3-rc1' of git://git=
.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1253719e580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3e64b1bf01d=
830ed
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1a01783ea2333=
50598b5
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for=
 Debian) 2.44
> > userspace arch: i386
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D174919795=
80000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-66498c75.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5ce4685e13ba/vmli=
nux-66498c75.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6a32d8e997a7=
/bzImage-66498c75.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000001: 0000 [#1] SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> > CPU: 0 UID: 0 PID: 5912 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2 04/01/2014
> > RIP: 0010:wcove_typec_probe+0xdb/0x780 drivers/usb/typec/tcpm/wcove.c:6=
21
> > Code: 48 c1 ea 03 80 3c 02 00 0f 85 af 05 00 00 48 8d 7d 08 4d 89 af 88=
 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 =
0f 85 7f 05 00 00 49 8d bf 90 00 00 00 48 8b 6d 08 48
> > RSP: 0018:ffffc90002f6faf8 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: ffff8880226c1000 RCX: 0000000000000000
> > RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000008
> > RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
> > R10: ffff888014243883 R11: 000000000000001f R12: ffffffff904a7ea8
> > R13: ffff8880226c1010 R14: ffff8880142438c0 R15: ffff888014243838
> > FS:  0000000000000000(0000) GS:ffff888096982000(0063) knlGS:00000000f67=
e5b40
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: 0000000032e24008 CR3: 000000004e2f1000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  platform_probe+0x106/0x1d0 drivers/base/platform.c:1507
> >  call_driver_probe drivers/base/dd.c:628 [inline]
> >  really_probe+0x241/0xa60 drivers/base/dd.c:706
> >  __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
> >  device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
> >  bind_store+0xf4/0x190 drivers/base/bus.c:267
>
> Please do not think that this is a valid path for syzbot to be
> fuzzing...
>

Can you please elaborate on this?
Do you mean driver binding sysfs interface in general or something
more specific?

--=20
Aleksandr
