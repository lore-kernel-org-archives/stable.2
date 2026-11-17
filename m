Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.148.134.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919603;
	b=LCaXUNn0fXZKf1255zBeuw5El6GHr9sFQA7ZnRuKubfMmEHpdj/jedLrRL94rAF315Lj
	 oQNmoyN4P9OpgdJgODpxcxGbSqgDLseMbfIJ5KFLiK56TN+6BWCV8c68VtH/A8cyJ/kKg
	 noJizozDETWBRGRhLwQ6PFBmUbbSFdPvT1qrwWaQ9zIOEUKHEvuF9QanqF2Xz4rwukBTh
	 UROQlqeHthi4humI2fPPgiN2ZPxLk1qG52z+pKIpJTin7PaAEjWMp8/8pPbVbDvHq68DQ
	 rOH2/eYuQZOoltvPGCV2gHOd66a26NySZTpdSHYDdO8kKxaGspy8ZCw7JAfdTbZhXAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919603;
	h=DMARC-Filter:From:DKIM-Signature:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Subject:X-MS-Reactions:
	 Message-Id:Date:Cc:To;
	bh=eCziB/Q75kz0zuPVvzXqrd7ybLKVWo+1grfK7ZO6L4Q=;
	b=jsNBS955y+onKG1pJT9LtKJzTNoNZ+6YuTibW7GoDIVP3v0TdyzpxsnPNFA6K4SvRzU4
	 0POU1w4HcuK932bi4Eb8/op/BJMNMcbO1dfI3zzSLwF7QP0zufq6umM7YcFQxPzITg8M4
	 uZxq53d870lQXJmXDKdcQeUVB6VBxvoD/Qn1pdDOpXiLBXJt1Eqw1VxoeSK5EeqSlidMo
	 KRy/2S0Cb2Yi4dt4ACnm1nnn5wA0x51kgdTP6TCkbm4PagGLpbS5ZZLWN/QRnqZSaXPK5
	 MkOmYehW3PjN2X4iup0Cuu41PQl8yy47pCivWaAPdrXvv3H0KzUtYHhHZw4TbNRwFaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=beerstra.org;
	spf=fail smtp.mailfrom=beerstra.org;
	dkim=pass header.d=beerstra.org header.i=@beerstra.org header.a=rsa-sha256 header.s=mail header.b="y/ZroHuZ";
	arc=none smtp.remote-ip=217.148.134.188
Received: from mail.beerstra.org (mail.beerstra.org [217.148.134.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36128606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36128606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=beerstra.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beerstra.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=beerstra.org header.i=@beerstra.org header.a=rsa-sha256 header.s=mail header.b=y/ZroHuZ
From: Jeroen Beerstra <jeroen@beerstra.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beerstra.org;
	s=mail; t=1794919601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eCziB/Q75kz0zuPVvzXqrd7ybLKVWo+1grfK7ZO6L4Q=;
	b=y/ZroHuZ7T9atYM8ayhrYRYPWhJtppVH6KDZUrahJ1WeYDGnlEdqRURzwGf237GbczTPxQ
	dqxuWg5rrPScJ2cauZ+ay0VnDYssSFnf7JsUr1ZkW/T7OE4Q5jYWgbgoBbMnCuzow2/AUD
	QeVjWqLOkijopQvjSg7v3m5eKDFwWk4+EVwjEI5eOh6VAqnLX8Tr+VSLBIc+gaYz29zs3u
	albDhTeAadNV04o2PbciczQXIOEdXsvS+TOzzVVmfZ/TQN2en0yDk/Q8t/RuJWM+iU7WQp
	2r/cgDvnMidNtYMFcnUlVXaozNFkwk59ZBYZmKdYrN3MEwcEduhTaMmjcMU9Fg==
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: [REGRESSION] Suspected amdgpu graphics regression on Ryzen 9 7950X
 since 6.18.58
X-MS-Reactions: disallow
Message-Id: <729A37E1-250D-469B-B89D-E24DFA4CABE6@beerstra.org>
Date: Tue, 17 Nov 2026 13:46:31 +0100
Cc: stable@vger.kernel.org,
 regressions@lists.linux.dev
To: amd-gfx@lists.freedesktop.org

I am experiencing graphics problems on AlmaLinux 9 using the
integrated graphics of an AMD Ryzen 9 7950X.

Last known good: Linux 6.18.56
First known bad: Linux 6.18.58
Still affected: Linux 6.18.63

The symptoms vary between affected versions:

I first noticed a hard lockup when I powered off my Windows 11 kvm =
session where graphics are rendered to a dedicated Nvidia RTX 5080.
So the first suspect was either the Nvidia hardware or kvm/qemu. Later =
the problem got worse and I was unable to boot into run level 5 where my =
onboard AMD graphics for my Ryzen 9 7950X gets activated. At some point =
it appeared my system even needed a cold boot to get in a usable state =
as there were hardware errors unrelated to the graphics at booted that =
prevented the boot to continue that disappeared after a complete power =
off. I think this was with 6.18.59 and 6.18.60 but not completely sure. =
Currently with 6.18.63 the problem is: hard lockup when I power off my =
Windows 11 kvm/qemu session with the RTX 5080 in passthrough mode and =
hard lockup when I end my Gnome session in Linux that uses the onboard =
AMD graphics, so my primary suspect is the amd driver. Because of the =
hard lockups nothing gets logged, but I=E2=80=99m sure there are ways =
around that.

Steps to reproduce:

    =E2=80=A2 Boot into run level 5 on AMD graphics
    =E2=80=A2 Reboot
    =E2=80=A2 Lockup

I currently use 6.18.56, which does not exhibit the problem.

These kernels are built using rpmbuild from unmodified upstream
sources, without additional source patches. The RPM spec is based
on ELRepo's spec, with local changes for Secure Boot signing.
Secure Boot is enabled.

I haven=E2=80=99t changed the kernel config or firmware in between.
My setup is:
    =E2=80=A2 AlmaLinux 9
    =E2=80=A2 A custom build 6.18 kernel with secure boot but without =
patches or other modifications
    =E2=80=A2 I have kernel modules via dkms for: zfs, nvidia and anbox. =
However the nvidia modules are currently completely disabled at boot.
    =E2=80=A2 System has 128GB RAM, a Ryzen 9 7950X and Nvidia RTX 5080. =
On the Linux side I run the standard Gnome that comes with AlmaLinux 9: =
40 on the onboard graphics for the 7950X and at the same time Windows 11 =
via kvm/qemu on the RTX 5080.

Willing to provide further details if required or perform further =
debugging.


#regzbot introduced: v6.18.56..v6.18.58

PS second attempt, didn=E2=80=99t ment to send a HTML message :(=20

Kind regards,
Jeroen Beerstra
