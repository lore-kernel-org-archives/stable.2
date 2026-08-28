Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9383371CE0
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932618; cv=none; b=VPdMYFOj3KCX1JVm2slN1cdjhkfezXJIhVPcQ/1ZBtQrec9vaFNGkdUJ6AN4v1yF3gt3Dj+k/12LDLtg3wywRO6ZZew47ZmpumM6vVFeo2HjH+R9z40J1irCRjqnRcVUKwUiV5mJUfi8FAONHyC/A5Dw2eOvYg0fuye8Y2ZVQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932618; c=relaxed/simple;
	bh=L4RZrkXTn1pqqgK29ejDgfk3W0S/BNKjkOPGuto+7LA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Gspjb+tgsq5mfnkD4M3gObWU9fCcLf5CZjGPk2XWodqFJ6BJA+mITOqrg8ZFgIj1K8aouFlmi+I8kUChYRIz9Tc70GcRx9aRnRRKvywfxw7ezhsaOjSV0y1tWdhIABR91LOugbcDy+j8ONflxSAAObs+vQfUpspzQz7pjm9KiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a69KlABD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a69KlABD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E2EEB4E413FE;
	Fri, 28 Aug 2026 15:56:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AEBD260537;
	Fri, 28 Aug 2026 15:56:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F68911C782FD;
	Fri, 28 Aug 2026 17:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787932608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yN9kxwcFABA4u74vZVBHnK4I0Q7juc3vT40/SKtK+L8=;
	b=a69KlABDqBSHKSqRfCRxFy6SVnuuXNUYh2De7jRQ4L+MGZyQNG50KH7z4yADPr+YnmejX3
	KQ/Scv08/POudvbOVTATG+DkHR32KEs0bbgwIOS9F63qCzk9HlsMllg28zWnBL+BHsEZ80
	7+p8yWQRv8QVpOrhpXGgE+a+l4KGaxa58HPSZLYSO3yXUU+EZNAd0t8PX3Nzol0PLXyLtP
	f6VMLxPj5O0kR73PE9qmI77H2t1FMI0OcSL7ClcLGtMvfXE/3vKIcROxvuFBWM04oa/EsX
	nGZ/N3W37PYQrFUwpCQgEwkbR5H35k+tXEa8aNaKVhXoqytmx1wUWeWhX6t3KQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 17:56:44 +0200
Message-Id: <DL0P7NCKVU0I.ARBMN6GAMMBS@bootlin.com>
Cc: <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
To: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Jiaxun
 Yang" <jiaxun.yang@flygoat.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from
 CONFIG_EYEQ
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-eyeq-reordering-llsc-v1-1-0c5a69fc5124@bootlin.com>
In-Reply-To: <20260828-eyeq-reordering-llsc-v1-1-0c5a69fc5124@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

First off, sorry to net maintainers for being in Cc of this patch.
get_maintainer.pl added you and the MLs because the commit message
containing "xdp". I deleted the MLs in Cc but forgot the individuals.

On Fri Aug 28, 2026 at 4:07 PM CEST, Th=C3=A9o Lebrun wrote:
> On I6500 CPU cores, lld and scd give no ordering guarantees (same as all
> other instructions). To respect the assumption that arch_cmpxchg() is
> fully ordered, we must inject sync instructions above and below our
> lld/scd loops using the already in place WEAK_REORDERING_BEYOND_LLSC
> infrastructure.
>
> Otherwise, bad things can happen:
>
> [   34.054496] CPU 3 Unable to handle kernel paging request at virtual ad=
dress 0000000000000000, epc =3D=3D a80000080838e01c, ra =3D=3D a80000080838=
dfc4
> [   34.054559] Oops[#1]:
> [   34.069561] CPU: 3 UID: 0 PID: 170 Comm: pipe_race Not tainted 7.2.0-r=
c6-01553-gb73c35220968-dirty #103 VOLUNTARY
> [   34.079932] Hardware name: Mobile EyeQ5 MP5 Evaluation board
> [   34.085592] $ 0   : 0000000000000000 0000000000000001 0000000000000000=
 0000000000000000
> [   34.093616] $ 4   : a800000808ee2618 000000000b7a879d 0000000000001000=
 0000000000000000
> [   34.101638] $ 8   : 0000000000e3f2c9 0000000000000000 a800000808a2a9f8=
 0000000000000000
> [   34.109660] $12   : a8000008139ffcd8 ffffffff84080018 a80000080837fae0=
 7878787878787878
> [   34.117682] $16   : a800000807e82940 0000000000001000 0000000000000000=
 0000000000000000
> [   34.125704] $20   : a800000802920e00 a8000008139ffdf8 a800000802649400=
 0000000000e3f2c9
> [   34.133726] $24   : 0000000000000006 00000001200406e0
> [   34.141783] $28   : a8000008139fc000 a8000008139ffd10 0000000000e3f2c8=
 a80000080838dfc4
> [   34.149837] epc   : a80000080838e01c anon_pipe_read+0xd4/0x428
> [   34.155697] ra    : a80000080838dfc4 anon_pipe_read+0x7c/0x428
> [   34.161549] Status: 140000e3  KX SX UX KERNEL EXL IE
> [   34.166551] Cause : 40800408 (ExcCode 02)
> [   34.170574] BadVA : 0000000000000000
> [   34.174161] PrId  : 0001b028 (MIPS I6500)
> [   34.178183] Process pipe_race (pid: 170, threadinfo=3D000000005ca35720=
, task=3D00000000e1013890, tls=3D000000014ebbb780)
> [   34.188568] Stack : a800000802649400 0000000000000000 0000000000000000=
 a8000008139ffdd0
> [   34.196623]	 0000000000000fba a800000808ee0000 0000000000000001 a80000=
08130c3e80
> [   34.204676]	 a8000008080d1280 a8000008139ffd58 a8000008139ffd58 1dbd2b=
22ea1dd500
> [   34.212729]	 a800000802649400 a800000808ee0000 ffffffffffffffea 000000=
0000000001
> [   34.220783]	 0000000000001000 0000000000000000 00000001200ae518 ffffff=
ffffffffff
> [   34.228836]	 000000fffbe0e530 a80000080837edf4 000000fffbe0e530 000000=
0000000000
> [   34.236890]	 0000000000000000 0000000000000000 000000014ebb55a0 000000=
0000001000
> [   34.244943]	 0000000000000001 a800000802649400 0000000000000000 000000=
0000000000
> [   34.252996]	 0000000000000000 0000400400000000 0000000000000000 1dbd2b=
22ea1dd500
> [   34.261049]	 00000000140000e3 a800000802649400 a800000802649400 a80000=
0808ee0000
> [   34.269103]	 ...
> [   34.271568] Call Trace:
> [   34.274026] [<a80000080838e01c>] anon_pipe_read+0xd4/0x428
> [   34.279533] [<a80000080837edf4>] vfs_read+0x25c/0x318
> [   34.284607] [<a80000080837faac>] ksys_read+0x104/0x138
> [   34.289763] [<a80000080802b9cc>] syscall_common+0x44/0x68
> [   34.295187]
> [   34.296689] Code: f84000cf  02209825  de020010 <dc420000> d8400004  02=
002825  0040f809  02802025  f84000c3
> [   34.306504]
> [   34.308099] ---[ end trace 0000000000000000 ]---
>
> My initial reproducer was the xdp-tools test suite. A standalone
> reproducer would be an lld/scd loop that, when the read is reordered by
> the CPU, triggers a fault. We can achieve this from userspace by
> stressing an anonymous pipe, which uses a mutex. Program used:

Simpler reproducer than the C program given initially. It takes a few
seconds to trigger.

   dd if=3D/dev/zero ibs=3D20M obs=3D70 | dd bs=3D4096 > /dev/null

Goal is to spam write(2) on one side and read(2) on the other.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

