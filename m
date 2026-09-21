Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A24EDCDF
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013904; cv=none; b=kh13nXyMoA9knsXaZvjOM2ggLDuAC66INzFcLVi49xGbr79BB2RAdHkkkzsoy/FuSOF/9xoimWvIqN/Qc3hSFtofz4cq64GLUmRoxIXm5igczj3NsbWNzyDXnjF6/ZksVOCDdWQTGQxdB1z5247/Dq/r0dOPs3ogfpOzfD+vNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013904; c=relaxed/simple;
	bh=xAz1Za0IGRvxTu1SLcrq0u25knNEFAxNJLC+t+BBsCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovtVFeNayBjMnDWat89+2LRToCH5LKousZtLRYVv+Z7p4tpR8xZ0NQsETvYJuJdMibYl2WAk+GVx/gpD6U3cGI6kD9910Kvx3SzkExRUHkVrpHQyQm8855CLUbzXNDTXLBaot/wWTZUzEf1ND37hNgDCK1GZ5Da8Ll3q7aJiECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFXk9FkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFXk9FkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7044D1F00899
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013902;
	bh=z+XbqSwIlygDp/k2jWmjBOZ00p46tZ3MqZOaYtXteAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FFXk9FkAVeSJkZn2IAoXZobgrULqUsGgEK+GSFO8kHuCe/vAqr1KbzXEq5dAjhDRB
	 AZ15mJ6dw4r6oBCKcL+x3+kCCD+ceJHbbt06Z/sWJWtWit2O3AOKCz7pyU/vxDOutQ
	 MfzfRvx1FZATnhYHsNd1YXwgkdT6Y+HEr2VRhaezyYiJ5SPTJydrBrBDrF62HW+aY+
	 bh7BrvPWfgIMgsSXXqfa0JHvRmjoB9RB0o/kMZ3b4B6PS5hCBC/Oe6WtlR/Z+j/3jA
	 zIWHyLjsEuCd9rcjwnHZMndwHNw/ngfc2pDF/+/Xy8da/oUcjgxLrP7vZCV9xIvwYm
	 GUsH9AXs4CEng==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60e33d456so16412431fa.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:05:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzinaSFzXR+Pbdl88eTeDCH4VhSBdCbfVzf6QMyKHVk08zc3hYN3FqAHgFcCkK8TecyYqYAoJs=@vger.kernel.org
X-Gm-Message-State: AFuF++m5ENAYm/+3wWDeCPSeM5ldN14KG0HtWjrIf7nr32LeGqsO0CpH
	uclDv3GiR5cKK4R975f9NKUdAE5Mt/sP19WBeyqbnk596STsVhaODuSVlVlfez8XfWpxsv8KgqA
	vpcDV0F+P0o/jhnIeC5ekwmlz+3akAP0=
X-Received: by 2002:a2e:be28:0:b0:39f:1b37:82bd with SMTP id
 38308e7fff4ca-3a5fbe6a277mr23646281fa.11.1790013900691; Mon, 21 Sep 2026
 11:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <905771062.272724286.1789919301858.JavaMail.zimbra@trinity-net.com>
 <CAJZ5v0gg7kBtEhagR9SYKaPNstPC6aSyP7W4xBjP1r-kzbcH1A@mail.gmail.com> <arFe7-xa3HtCUOHs@mail-itl>
In-Reply-To: <arFe7-xa3HtCUOHs@mail-itl>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 21 Sep 2026 20:03:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4giv53a2mPvJYT=fvBTj7vVXs=b7+qC2Q2L35qSTOSA@mail.gmail.com>
X-Gm-Features: AcwNN1Vj0ZFSOOwh98D75XigHm-CPGlbbuwMjMKPEsP5Ta1JIqAFG3h-Yf_ZOC8
Message-ID: <CAJZ5v0h4giv53a2mPvJYT=fvBTj7vVXs=b7+qC2Q2L35qSTOSA@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot
To: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Support TRINITY <support@trinity-net.com>, 
	regressions <regressions@lists.linux.dev>, linux-acpi <linux-acpi@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Huisong Li <lihuisong@huawei.com>, 
	Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 6:44=E2=80=AFPM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Mon, Sep 21, 2026 at 05:26:55PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Sun, Sep 20, 2026 at 5:48=E2=80=AFPM Support TRINITY <support@trinit=
y-net.com> wrote:
> > >
> > > Hello,
> > >
> > > I am reporting a bare-metal Xen dom0 boot regression seen with Linux =
6.18.52.
> > >
> > > On affected systems, Linux 6.18.51 boots successfully as Xen dom0 on =
bare metal, while Linux 6.18.52 consistently black-screens before dom0 user=
space/networking comes up.
> > >
> > > #regzbot introduced: v6.18.51..v6.18.52
> > > #regzbot title: ACPI processor/cpuidle lifecycle change breaks bare-m=
etal Xen dom0 boot
> > > #regzbot link: https://gitlab.alpinelinux.org/alpine/aports/-/work_it=
ems/18447
> > >
> > > Tested results:
> > >
> > > Linux 6.18.51-r0, Xen dom0, bare metal: boots
> > > Linux 6.18.52-r0, Xen dom0, bare metal: black screen before userspace=
/network
> >
> > I'm wondering what's special about Xen dom0 bare metal.
> >
> > Does adding processor=3Dnocst to the kernel command line help, by any c=
hance?
>
> It does not.
>
> > The patch is essentially a revert of commit 13ebeef6a1b9 ("ACPI:
> > processor: idle: Optimize ACPI idle driver registration") which I'd
> > rather not do without knowing what exactly is going on.
> >
> > At this point it looks like a missing check somewhere or similar, so
> > it would be good to find out where exactly it crashes.
>
> I can reproduce the crash, I get this:
>
> [    3.525669] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [    3.525677] #PF: supervisor read access in kernel mode
> [    3.525681] #PF: error_code(0x0000) - not-present page
> [    3.525685] PGD 0 P4D 0
> [    3.525688] Oops: Oops: 0000 [#1] SMP NOPTI
> [    3.525693] CPU: 0 UID: 0 PID: 21 Comm: cpuhp/0 Not tainted 6.18.52-1.=
qubes.23.fc41.x86_64 #1 PREEMPT(full)
> [    3.525700] Hardware name: Micro-Star International Co., Ltd. MS-7E06/=
PRO Z790-P WIFI (MS-7E06), BIOS Dasharo (coreboot+UEFI) v0.9.1 01/17/2024
> [    3.525706] RIP: e030:cpuidle_register_device+0xd2/0x350
> [    3.525714] Code: 00 00 8b 55 04 49 89 c5 49 89 d4 81 fa ff 1f 00 00 0=
f 87 68 02 00 00 48 8b 04 d5 c0 a0 19 82 48 83 3c 18 00 0f 85 ad 48 12 ff <=
49> 8b 7d 08 48 89 14 24 e8 31 73 30 ff 84 c0 0f 84 72 01 00 00 41
> [    3.525723] RSP: e02b:ffffc90040133db8 EFLAGS: 00010246
> [    3.525727] RAX: ffff888235f5c000 RBX: ffffffff834d4d40 RCX: 000000000=
0000000
> [    3.525732] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffff88810=
1c39c00
> [    3.525736] RBP: ffff888101c39c00 R08: 4ec4ec4ec4ec4ec5 R09: ffff88810=
1c39c00
> [    3.525740] R10: ffffc90040133df8 R11: 0000000000000000 R12: 000000000=
0000000
> [    3.525744] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8=
34d4d40
> [    3.525752] FS:  0000000000000000(0000) GS:ffff888235f5c000(0000) knlG=
S:0000000000000000
> [    3.525757] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.525761] CR2: 0000000000000008 CR3: 000000000242c000 CR4: 000000000=
0050660
> [    3.525768] Call Trace:
> [    3.525771]  <TASK>
> [    3.525775]  acpi_processor_power_init+0xde/0x150
> [    3.525782]  ? __pfx_acpi_soft_cpu_online+0x10/0x10
> [    3.525787]  acpi_soft_cpu_online+0x123/0x170
> [    3.525792]  cpuhp_invoke_callback+0x134/0x470
> [    3.525797]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    3.525802]  cpuhp_thread_fun+0xa2/0x170
> [    3.525806]  smpboot_thread_fn+0xf3/0x220
> [    3.525810]  kthread+0xfc/0x240
> [    3.525814]  ? __pfx_kthread+0x10/0x10
> [    3.525818]  ? __pfx_kthread+0x10/0x10
> [    3.525822]  ret_from_fork+0x158/0x170
> [    3.525827]  ? __pfx_kthread+0x10/0x10
> [    3.525830]  ret_from_fork_asm+0x1a/0x30
> [    3.525835]  </TASK>
> [    3.525837] Modules linked in:
> [    3.525842] CR2: 0000000000000008
> [    3.525845] ---[ end trace 0000000000000000 ]---
> [    3.525849] RIP: e030:cpuidle_register_device+0xd2/0x350
> [    3.525854] Code: 00 00 8b 55 04 49 89 c5 49 89 d4 81 fa ff 1f 00 00 0=
f 87 68 02 00 00 48 8b 04 d5 c0 a0 19 82 48 83 3c 18 00 0f 85 ad 48 12 ff <=
49> 8b 7d 08 48 89 14 24 e8 31 73 30 ff 84 c0 0f 84 72 01 00 00 41
> [    3.525862] RSP: e02b:ffffc90040133db8 EFLAGS: 00010246
> [    3.525866] RAX: ffff888235f5c000 RBX: ffffffff834d4d40 RCX: 000000000=
0000000
> [    3.525870] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffff88810=
1c39c00
> [    3.525874] RBP: ffff888101c39c00 R08: 4ec4ec4ec4ec4ec5 R09: ffff88810=
1c39c00
> [    3.525878] R10: ffffc90040133df8 R11: 0000000000000000 R12: 000000000=
0000000
> [    3.525882] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8=
34d4d40
> [    3.525889] FS:  0000000000000000(0000) GS:ffff888235f5c000(0000) knlG=
S:0000000000000000
> [    3.525894] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.525898] CR2: 0000000000000008 CR3: 000000000242c000 CR4: 000000000=
0050660
> [    3.525904] Kernel panic - not syncing: Fatal exception
> [    3.525931] Kernel Offset: disabled
>
> And I have also another data point: Linux 7.2.6 is _not_ affected. And
> similarly, Linux 7.3-rc3 works fine (haven't tried -rc4 yet).

So it is likely that the patch in question went into 6.18.y without a
dependency.

Let's see.  In 6.18.52, acpi_processor_power_init() is called in the
!cpuidle_get_driver() case, which does not happen in the mainline.

AFAICS, 6.18.y needs to pick up commit 0089ce1c056a ("ACPI: processor:
Update cpuidle driver check in __acpi_processor_start()") whose Fixes:
tag should really point to 13ebeef6a1b9 which is a re-introduction of
7a8c994cbb2d originally fixed by 8a1b5d412cb4.

Thanks!
