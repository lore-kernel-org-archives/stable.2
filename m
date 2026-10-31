Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793461460;
	b=TEsp6ecx6CHEb4/14zFFYcZU2Gjp1aTkLquet7C6HzoYGql2oYiwXHImGT56eBD4/lTV
	 jI1faTj3jDsoQL08GZjtlTeWYLEuUg7Sw11eS3lO5NpIfr0jINXV3gx9OYSOYurgUJ2MV
	 F/YIPDKV3MysQCf9cAVitXkH0Saiew4yqkNdvUcUWA7y0bI2WCDI7dyQnLdlh4Yj3FhmT
	 Cba0koFYlHlOZUbRQSm8XDKJCoo3TEjnhBd3dOFeBF+P0h3EjOT5P6PK1v5Ro+DdfLAJu
	 Yn7PEvMUohKpfoEvesBtdcrGIH5i/M9kgkbCgxR09TRnzRGPqARf7qiNF+YaUMBeYeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461460;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From:To:Cc:Message-ID:X-SimpleLogin-Type:
	 X-SimpleLogin-EmailLog-ID:X-SimpleLogin-Want-Signing;
	bh=xalrLin20XWlk6bzYnzzbgaIXTRXr6SHiU+Ft8ewMUI=;
	b=GEzIahHZRvXYbIMg6q/z7NcOszt7hgnfP1T6GGRblrOpn5sNwxTndyeSuKCkz/wD56gF
	 ND/kAwzUvLQMZdtPnOkBF0FLIhjIo4/++sorEOxJC+PcPfenzmFP5sKyJSqoH+g65cobL
	 1g54hinx3i6gREiXed+p6GakeEcSMccjn02sbhrTI4cept5MjRGmkVXl/Qp2hhd3LyJlG
	 JtIGp+lgY3N2m1yJSK8vonU7Awb+JQ5NDtUmJ2H6FBNZkUYdQTMyVydacqxgZ+sTYT8V6
	 7BMbE74r7zJeZypcX2nLPKEBK8hlB/fu37JhQEKJ58kF01K7QcGTA/YSpSfLypZMZrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=8alias.com;
	spf=pass smtp.mailfrom=8alias.com;
	dkim=pass header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=vzQKTonT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.170
Received: from mail-200170.simplelogin.co (mail-200170.simplelogin.co [176.119.200.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69260606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 15:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69260606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8alias.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8alias.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=vzQKTonT
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793461452;
	cv=none; b=fy1nhGxdBgNPgBGYeULAMIbyVTYhTLWlYJG9Dg5X4DK5q9TR5h08gWPaXE7ssGltP2iEaX9fIomiSaTdWZIVkjb9Yhe/2zkUjy8qQvVPrjt6m0mbQqNM/B63TsmUakCuncyptv4opAn78uoF+H0BXBIPiIrqtpNijmCQVPJpDVt/9gMiu4/oYRvNaco3eKUMfH01epZYuy27C6Q85BcUo/b5BfQS2n/iHvYbXxf/rqxHvHZm4rcCJzBqS8e/82e743q5p1dTnogUCJjeeOVX8/EvIoIznFYLkNxpyTDZn2zDXEefxtAAA2/eHZnP0UG/yFjMZNsp1b6s7eMaFMYHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793461452; c=relaxed/simple;
	bh=AaZu+tZdoMwvlXleI2bXaZaMVRyFk7eBBWZBUTdqvVg=;
	h=Date:Subject:From:To:Cc; b=GaJMk2VjNlyoblVTAhJJ3jgsYCI+Y7E0cDKngujSXWVYnlxJLXcQYdljvxiiKiSQOh0Jf9toSWxpjv/Hf4w1vPNhRg5sqDXKMDl/EnO7GOpHSSIkYNeKpmymSNrPZk1K0iUVPHVg6wW8ch4NktAV8iLPsCyXHubIDMxPVlNkRbFL35LAsswigJ3ZA40CZLjfeK68E/ih0u3L0QuX0UNBOvb1nvDcYKRHU9RbObBxi7FrGPKmdSVOVPcDBQggnqQ6N1elFIpCxn5YCDn/Nt4psJIvb7dnAjP4FIqj9JbPIY739G7swjoN0E/kUQEdzbgvPj0Z/C6QG9Kjk50KGkPUiA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=8alias.com; s=dkim;
	t=1793461452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xalrLin20XWlk6bzYnzzbgaIXTRXr6SHiU+Ft8ewMUI=;
	b=vzQKTonTT5HawogrM6SpGnIN1YVuH4qET1IATmnOM465cKAMVDHshDrQeR3zFKqK2uqMHE
	UI30wJsVOVqYOOoCS/XAg2NupgZJAc83xu/teB4lcBG0yZYvtt2509EOtVOjZHyTmxYsKC
	X5w5K+/FECZRp3pfmAoDdmWDZF7it4M=
Date: Sat, 31 Oct 2026 15:44:03 +0000
Subject: [PATCH 6.12.y 0/2] Fix ioremap of addresses above 4 GiB on x86-32 PAE
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
From: =?utf-8?q?Radek_Marci=C5=88a?= <github.unusual340@8alias.com>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,Ingo Molnar <mingo@redhat.com>,Borislav
 Petkov <bp@alien8.de>,Dave Hansen
 <dave.hansen@linux.intel.com>,x86@kernel.org,Andrew Morton
 <akpm@linux-foundation.org>,David Hildenbrand
 <david@kernel.org>,linux-mm@kvack.org,Arnd Bergmann <arnd@arndb.de>,Michael
 Kelley <mhkelley58@gmail.com>,linux-kernel@vger.kernel.org
Message-ID: <179346145167.7.7861216093151225931.1735978772@8alias.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1735978779
X-SimpleLogin-Want-Signing: yes

From: Radek Marci=C5=88a <github.unusual340@8alias.com>

Both patches are stable-only. In these trees the x86 PAGE_MASK is an
unsigned long, so "phys_addr &=3D PAGE_MASK" on a 64-bit physical address
clears bits 32-63. __ioremap_caller() and __early_ioremap() both do
this and map the low 32-bit alias of anything above 4 GiB.

Mainline is not affected since v6.13, where commit efe8419ae78d ("vdso:
Introduce vdso/page.h") and commit d4a65302dd84 ("vdso: Change
PAGE_MASK to signed on all 32-bit architectures") made PAGE_MASK signed
on 32-bit. Neither was marked for stable. They cannot go to 6.6.y and
older, which lack CONFIG_PAGE_SHIFT (added in v6.9). They do apply to
6.12.y, but together with the i915 build fix in commit 8fd236b00fc1
("drm: i915: Change fault type to unsigned long") they change PAGE_MASK
on every 32-bit architecture, the kind of change that caused the arm32
regression d4a65302dd84 itself fixes. So these patches cast at the two
affected sites instead.

Please apply to 6.12.y, 6.6.y, 6.1.y, 5.15.y and 5.10.y; the series
applies unchanged to all five. 6.18.y and later have the upstream
change.

Reproducer for 1/2: i386_defconfig plus CONFIG_HIGHMEM64G=3Dy,
CONFIG_VIRTIO_PCI=3Dy and CONFIG_HW_RANDOM_VIRTIO=3Dy, booted with

  qemu-system-x86_64 -M q35 -accel kvm -cpu host,host-phys-bits-limit=3D44 =
\
    -m 5G -object memory-backend-ram,id=3Dbig,size=3D4G,share=3Don \
    -device ivshmem-plain,memdev=3Dbig -device virtio-rng-pci \
    -nic none -nographic -no-reboot \
    -kernel arch/x86/boot/bzImage -append "console=3DttyS0 panic=3D-1"

The extra options get the virtio BARs above 4 GiB with SeaBIOS 1.16.2,
1.16.3 and 1.17.0. Since 1.16.3 SeaBIOS places 64-bit BARs high when
the guest has RAM above 4 GiB, which on q35 starts at -m 2816M; before
that only when the 32-bit window overflows, which the 4 GiB ivshmem BAR
forces. host-phys-bits-limit=3D44 keeps SeaBIOS 1.16.3 from placing them
beyond the 44 bits a PAE kernel can address.

On 6.12.115 the virtio BAR 4 at 0xe0100000000 gets mapped at physical
0x0-0x3fff (per /proc/vmallocinfo), the device ends up FAILED and the
log shows

  virtio_rng virtio0: probe with driver virtio_rng failed with error -2

With 1/2 applied the mapping is at 0xe0100000000, the device reaches
DRIVER_OK and /dev/hwrng returns data.

Nothing in a QEMU boot early-maps memory above 4 GiB on i386, so 2/2
was tested with a throwaway late_initcall that calls
early_memremap(0x100000123, 16) and prints slow_virt_to_phys() of the
result: 0x123 on 6.12.115, 0x100000123 with 2/2 applied.

Unmodified v7.3 in the same setup (CONFIG_X86_PAE=3Dy in place of
CONFIG_HIGHMEM64G=3Dy, which no longer exists) gets both mappings right.

Built with GCC 16.2.1, run on QEMU 11.1.2 with KVM.

Radek Marci=C5=88a (2):
  x86/ioremap: Sign-extend PAGE_MASK when aligning the physical address
  mm/early_ioremap: Sign-extend PAGE_MASK when aligning the physical
    address

 arch/x86/mm/ioremap.c | 2 +-
 mm/early_ioremap.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.56.0



