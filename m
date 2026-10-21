Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571756;
	b=Dc8twVfY2J2XS9nM255hLKi691NqSrAeIgJmAM1gHPhKeUUBiFYVk+khfXBEru9KYQlL
	 cuVd+uOj+JNsb/RQOHTE8UxtpvMjcJIv1tEn87a0pU2kWAE9nAxySCisn8+VNdd7O9c4y
	 LaPrm+Oyk6oB7vaNc9YMLE5q69AXQ7p34kOWAB1zCKtvtoZHPxTAc9sZqwlxVyXcyXHXR
	 IH/2Nx2LvoKoKGH3w9GfVEZGcPpLMZ4CFRW74zlAN5jgsu02XwifYs065q5VOSfyaRUxM
	 kkW4cABhHPAb9XhyezBbLUsuHGAZxFk5r0885RrcTftZoGnF22QfjrtWZNCZf5Y5QIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571756;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KbJGV4k1la3/kWX07RtAQM/FAs2mIBBziR5mEoX6Iw8=;
	b=2QD4bR2j+6jtKUoctRJu2rvF4JZY2kvRVPkLVday4bUq1idPA3AXPg6IR52f3dkcgrTf
	 R5xkGukXtN/qVF74vdpHxnOLDVp037gIVF0o10/j2jRWYd+TZBVbMFqhutxFc75cf2+pF
	 RrVl5/v/orEgbzfRJ+b00ujpPLEsGfvWgq6qfpd7pC4JSzOwP3pa2tlkxQwh0kJxq8z7m
	 uxEJHwjkeACvoNV4OTZjnPAbDmDUbiOMbtquYWcAzYznme8722K4CAYGBuXVJAdrxU+kr
	 oiq4FwhzVyhSt0j+loiQE7aGYfi+uKsuKwlfnCvbdpzowo5U3e59b4mstq3tNdr7IHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=DOZo10LZ;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113A606A321
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5113A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=DOZo10LZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792571752; x=1792830952;
	bh=KbJGV4k1la3/kWX07RtAQM/FAs2mIBBziR5mEoX6Iw8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DOZo10LZ3lcaNwh/8+Iy7PE9Gxk5Vxfl3eJirctRgpX7StmMVs3Gg1o5qHCIBGLO0
	 KOT9hq+lbML1THVsvFPXrH3kXxyIaFfHtd4z7h1zrF2cYsfyQCgG1EXWjbP58Y8RnT
	 POnTewqZXHlq0VoTl25i0FFNxyZNhVEFU6HEZ3tNpAG6q4fnT4BvaWr9HNy5l9skid
	 7X0CAY610F76QH/jRSrF8Os3wFB+qAcv+4gjLtYvtExgRI9BBI7bfncwiKJJg4zndg
	 +7i7AqQqkp+rormrrZMim/6zXHjN4pTO797fVdDZ6Sgho6In12WM7VDRxsh3dVK8yx
	 S3PExlE5G3vvg==
Date: Wed, 21 Oct 2026 08:35:49 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mikkel Sejdelin <mikkel.sejdelin@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>
Subject: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and hangs when tiny_power_button is built as a module
Message-ID: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
Feedback-ID: 151291767:user:proton
X-Pm-Message-ID: a7ec0184fdfbb41669f23160cf20756961af0e72
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

Resending as plain text; the previous copy was rejected by the lists for co=
ntaining HTML.



Hi,

Since 6.18.57, my laptop never comes back from suspend-to-idle: on resume
init receives SIGRTMIN+4 and starts a poweroff, the display stays off, and
the machine hangs until it is forced off. 6.18.56 works fine.

Hardware: Lenovo IdeaPad Pro 5 16AKP10 (83JN), BIOS R1CN59WW, AMD, s2idle o=
nly
Distro: =C2=A0 NixOS 26.05 (distro kernel, CONFIG_ACPI_BUTTON=3Dm,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_ACPI_TINY_POWER_BUTTON=3Dm, CONFI=
G_ACPI_TINY_POWER_BUTTON_SIGNAL=3D38)

On every resume, the journal on 6.18.57 shows:

=C2=A0 kernel: PM: suspend entry (s2idle)
=C2=A0 systemd[1]: Received SIGRTMIN+4.
=C2=A0 systemd-sleep: System returned from sleep operation 'suspend'.
=C2=A0 kernel: PM: suspend exit
=C2=A0 systemd-sleep: Failed to thaw unit 'user.slice': Unit has a pending =
job

followed by:

=C2=A0 systemd[1]: Activating special unit System Power Off...
=C2=A0 systemd[1]: Cannot stop frozen unit Session 3 of User mikke.
=C2=A0 ...
=C2=A0 systemd-shutdown[1]: Sending SIGTERM to remaining processes...

after which the journal stops and the machine hangs with the display off
(SIGRTMIN+4 =3D poweroff.target in systemd). A bpftrace probe on signal
delivery to PID 1 shows the signal comes from a kernel worker, i.e. the
ACPI notify path, not from userspace:

=C2=A0 sig=3D38 code=3D128 from pid=3D296 comm=3Dkworker/6:2

Cause:

6.18.57 contains 38c79dacc806 ("ACPI: button: Convert the driver to a
platform one", upstream 52d864019636), backported as a Stable-dep-of
fe80251152fe ("ACPI: button: Fix ACPI GPE handler leak during removal").
The matching upstream conversion of tiny-power-button, f4203ec64e11
("ACPI: tiny-power-button: Convert the driver to a platform one"), was
not backported.

Before the backport, both drivers were acpi_drivers matching PNP0C0C,
so only one could bind; button wins on this machine and tiny-power-button
stays unbound. After it, button binds to the platform device and
tiny-power-button binds to the ACPI companion of the same device, so both
install notify handlers on PWRB. tiny-power-button calls
kill_cad_pid(SIGRTMIN+4) for any notify, including the wake notification
on s2idle resume, which button itself filters out.

Verification on the same machine:

=C2=A0 6.18.56 (no blacklist):
=C2=A0 =C2=A0 /sys/bus/acpi/drivers/button/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-> PNP0C0C:00, PNP0C0D:00
=C2=A0 =C2=A0 /sys/bus/acpi/drivers/tiny-power-button/ -> (no devices)
=C2=A0 =C2=A0 3/3 suspend/resume cycles OK (systemctl suspend; woken by pow=
er
=C2=A0 =C2=A0 button and by keyboard). No SIGRTMIN+4.

=C2=A0 6.18.57 (no blacklist):
=C2=A0 =C2=A0 button bound to platform device PNP0C0C:00, tiny-power-button
=C2=A0 =C2=A0 loaded; 2/2 resumes ended in SIGRTMIN+4, an attempted powerof=
f
=C2=A0 =C2=A0 and a hang.

=C2=A0 6.18.57 with tiny_power_button blacklisted:
=C2=A0 =C2=A0 suspend/resume works.

Suggested fix: backport f4203ec64e11 together with 52d864019636, or
revert 38c79dacc806 (and its dependents) from 6.18.y. Note that the same
backport also appears to lose fixed-event power buttons (LNXPWRBN)
without ab06eb920401 ("ACPI: scan: Register platform devices for fixed
event buttons"), reported at
https://github.com/siderolabs/talos/issues/14657

#regzbot introduced: 38c79dacc806

Thanks,Mikkel
