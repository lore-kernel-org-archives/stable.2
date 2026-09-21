Received: from 4.mo17.mail-out.ovh.net (4.mo17.mail-out.ovh.net [217.182.158.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6749B47B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.158.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996438; cv=none; b=cwhV/vm1zKMZ70ZQezeqPyekL5LYTxWGTG6Yz4uhVv9xY51+tzNri1mDfWnBUgVyfmJFT/TblDB2ADheELttqby3j6VLjJn2hE3GFmsXuVdNbm0jPq6wQ1coEUNNVzxVRwvJkm8qePDNkEGy2xpaJceG55JbMYV0wPLGcmM5K2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996438; c=relaxed/simple;
	bh=lh4UrIoSXewLFHp76QY/Q0+dUJHd+++CaGLD1NcODj8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CaVH1HPFmrDRhR/pQzoZKxwCKxo1si+K50sDCsJUDROiGzgLrGN1BYUTdiqX7xC4xaFC/RW3JMx+E2+s+Wo4q0v4/bAbZSte9Gsg+lsU6KhoG2lekE3QPBSz0memwvO4l7NWuVz9TLwbw5mjvZFKr4hNFl6+gxXBYCfrGkAiWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trinity-net.com; spf=pass smtp.mailfrom=trinity-net.com; dkim=pass (2048-bit key) header.d=trinity-net.com header.i=@trinity-net.com header.b=vTiMaFm6; arc=none smtp.client-ip=217.182.158.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trinity-net.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trinity-net.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trinity-net.com header.i=@trinity-net.com header.b="vTiMaFm6"
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [79.137.60.221])
	by mo17.mail-out.ovh.net (Postfix) with ESMTPS id 4hpNmN6xM4z82jT;
	Mon, 21 Sep 2026 13:07:00 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <regressions@leemhuis.info>; Mon, 21 Sep 2026 13:07:00 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.58.168])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hpNmN4r0rz6GrY;
	Mon, 21 Sep 2026 13:07:00 +0000 (UTC)
Received: from mailstore7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.1.8.7])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTP id C7A14941C53;
	Mon, 21 Sep 2026 13:06:59 +0000 (UTC)
Date: Mon, 21 Sep 2026 13:06:59 +0000 (UTC)
From: Support TRINITY <support@trinity-net.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: regressions <regressions@lists.linux.dev>, 
	linux-acpi <linux-acpi@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	xen-devel <xen-devel@lists.xenproject.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <8375109.285919554.1789996019673.JavaMail.zimbra@trinity-net.com>
In-Reply-To: <8aaad113-1952-4655-978d-0cdd8b048064@leemhuis.info>
References: <905771062.272724286.1789919301858.JavaMail.zimbra@trinity-net.com> <8aaad113-1952-4655-978d-0cdd8b048064@leemhuis.info>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-User: support@trinity-net.com
Thread-Topic: ACPI processor/cpuidle change in 6.18.52 breaks bare-metal Xen dom0 boot
Thread-Index: xFt9ystRsn0Dmv4s3yH1kJqjVpPWwg==
x-ovh-tracer-id: 3167156440896468507
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEHV8uBM0suxcILPQHuI4B8S1OlSB/YHVb8/g14zw22rJSYP6YTO3+DnqnA+Iiq/RUcQphEfXjDQ/UHfZZSRJNBTelxXbMRNo3B0LhXj3vb0nz7rj1ftl80sdRSdU+oOTu0saDMx0LVlG6WOGEqrqskthR2jdSTt/m2u4IWuJa+w4JHgqqm3bofnzgYZpue/RkXIZtFa6K1rRNM6DEitB5WBe4SeO6p8zXCFjrVomW2QLcnNQPNdv8+vC1FxRa52dzN59qcPZ5o+LlrnzTh84iUnjzdKGw0B/OBYdviw4vd1Ytcba8j7YxDIHQnBvrObdbKHApuFDwTESa88H6ObHc8Qpf0kIMm5KQGY76Vgq/nmjcmlpm3/WsIJxP9rJ0XzKduzBF2pfhPzpVG/m9x9wE42vnJDzk/0u9Klx7f/4Aqcqcv8VX46u3StkL/4QXyF1ZJgJUUSOK88EcjfPcjYladpDkqwrhuGI3+9CqS6owu58W5g1iIFxUQ88WPn/zfdGO9Mr+EUIVBk2+d6X1m+J0O4oZVS8AsQnvHFKSOntrHeUqs8fwukXDiKFOpaDYXKNLmYHXW3NBy3oZWCWU8/9bfzy8003z/9iAhiVVZzehFLAkFTlcZKZEAaN3QVu6H4/nqzz5+FfiZU4y4JY4d0tvBdf22J9dWgJsYyWSGFRDEJQ
DKIM-Signature: a=rsa-sha256; bh=QD4uKSRlS28zp5D1m/z675fqJs3w1celrAPe2tovDvQ=;
 c=relaxed/relaxed; d=trinity-net.com; h=From; s=ovhmo-selector-1;
 t=1789996021; v=1;
 b=vTiMaFm6OJNBaQJZhBE6oZXC6f+0KXjkr0BPkQ0mDJ9O0sKMaJAAUVD8gVPYo2XQXRZHoEVY
 woIukHkU1/wY4grSFnD1ep7In4CdeKPQfEC8dpZ6xkYSIK0J6RUc3ykHMxt13Hycc7+593qgcxP
 9qEwYu6k6BvnPWRAut4BRcVnH32ar2bmS85enSKkK3c36/6nrL0VCyrscLliGcMZ2dkMN8MAokS
 XCuI+DJ69RWcpSpVD+s+mdNZPBcGXsPloVYNG/Mye6bTjmlx82d2id5VliQG8KYGRjSIi8hX8/u
 7kW1WAQKTjB101q9b4AW3pJ3pEM2+GmieCKPhv6F0wsZw==

Hello Thorsten,
Thanks for the follow-up.
I have not tested latest 7.3-rc yet. So far, the regression was only tested=
 and isolated on the Alpine linux-lts 6.18.51 -> 6.18.52 path.
I will now test:
latest 7.3-rc as-is on the affected bare-metal Xen dom0 host;
latest 7.3-rc with the same partial ACPI processor/cpuidle lifecycle revert=
 applied.
I will report back with the results.
Regards,
Tony


-----Message original-----
De: Thorsten Leemhuis <regressions@leemhuis.info>
=C3=A0: Support TRINITY <support@trinity-net.com>; regressions <regressions=
@lists.linux.dev>; linux-acpi <linux-acpi@vger.kernel.org>; linux-pm <linux=
-pm@vger.kernel.org>; stable <stable@vger.kernel.org>; xen-devel <xen-devel=
@lists.xenproject.org>; linux-kernel <linux-kernel@vger.kernel.org>
Envoy=C3=A9: lundi 21 septembre 2026 12:01 CEST
Sujet : Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks ba=
re-metal Xen dom0 boot


On 9/20/26 17:48, Support TRINITY wrote:
>
> I am reporting a bare-metal *Xen* dom0 boot regression seen with *Linux
> 6.18.52.*

Thx for the report. There is one somewhat important detail that was
missing (hope I didn't miss it):

Is latest 7.3-rc also affected? And if it is: does that partial revert
help there, too?

Ciao, Thorsten
> On affected systems, Linux 6.18.51 boots successfully as Xen dom0 on
> bare metal, while Linux 6.18.52 *consistently black-screens before dom0
> userspace/networking comes up.*
>=20
> #regzbot introduced: v6.18.51..v6.18.52
> #regzbot title: ACPI processor/cpuidle lifecycle change breaks bare-
> metal Xen dom0 boot
> #regzbot link: https://gitlab.alpinelinux.org/alpine/aports/-/
> work_items/18447 <https://gitlab.alpinelinux.org/alpine/aports/-/
> work_items/18447>
>=20
> Tested results:
>=20
>   * Linux 6.18.51-r0, Xen dom0, bare metal: boots
>   * Linux 6.18.52-r0, Xen dom0, bare metal: black screen before
>     userspace/network
>   * Linux 6.18.52-r0, Xen domU: boots
>   * Linux 6.18.52-r0 with Xenbus notifier change reverted: still fails
>   * Linux 6.18.52-r0 with only ACPI processor/cpuidle changes reverted:
>     boots
>   * Linux 6.18.52-r0 with refined ACPI idle lifecycle patch: boots
>=20
> Affected hardware tested:
>=20
>   * Intel Core i7-4785T thin mini-ITX, 16 GB DDR3
>   * Intel N305 thin mini-ITX, 16 GB DDR5
>   * Supermicro / Intel Xeon E5-1650, 32 GB DDR3
>=20
> The successful boot used the regular Xen command line:
>=20
> multiboot2 /boot/xen.gz cpufreq=3Dxen:performance
> module2 /boot/vmlinuz-lts modules=3Dloop,squashfs,sd-mod,usb-storage,xfs =
quiet
> module2 /boot/initramfs-lts
>=20
> No IOMMU workaround, serial console parameter, debug parameter, storage
> workaround, or Xen command-line change was required.
>=20
> The regression was narrowed to *ACPI processor/cpuidle* changes between
> 6.18.51 and 6.18.52, specifically the idle-driver registration lifecycle.
>=20
> The working 6.18.51-style behavior registers the ACPI idle driver from
> *acpi_processor_power_init()* and unregisters it from
> *acpi_processor_power_exit().*
>=20
> The failing 6.18.52 behavior registers the ACPI idle driver globally
> from *acpi_processor_driver_init()* before *driver_register().*
>=20
> A first ACPI-only revert confirmed the regression source. A refined
> candidate patch was then prepared to preserve the working ACPI idle
> lifecycle while keeping unrelated 6.18.52 safety fixes, including:
>=20
>   * _LPI bounds checks
>   * cpufreq notifier cleanup on *acpi_processor_driver_init()* failure
>=20
> The refined candidate patch modifies only:
>=20
>   * *drivers/acpi/processor_driver.c*
>   * *drivers/acpi/processor_idle.c*
>   * *include/acpi/processor.h*
>=20
> It does not modify Xen, Xenbus, IOMMU, APIC, PCI/ASPM, intel_idle,
> syscore, USB, storage, XFS, networking, printk, or the cpuidle core API.
>=20
> The earlier cpuidle_disabled() workaround is not included.
>=20
> The refined patch has been rebuilt and boot-tested successfully as Xen
> dom0 on bare metal on TRINITY-EDGE.
>=20
> This issue is currently visible to *Alpine* users because the *Alpine
> v3.24 *stable repository contains:
>=20
> alpine-release 3.24.2-r0
> *linux-lts 6.18.52-r0*
>=20
> Systems tracking Alpine 3.24 stable / latest-stable may therefore
> receive Linux 6.18.52 as the default LTS kernel.
>=20
> Attachments:
>=20
>   * revert-acpi-idle-registration-lifecycle.patch
>   * APKBUILD
>=20
> The original Alpine report is here:
>=20
> https://gitlab.alpinelinux.org/alpine/aports/-/work_items/18447
> <https://gitlab.alpinelinux.org/alpine/aports/-/work_items/18447>
>=20
> Please let me know if this should be submitted as a formal patch with
> Signed-off-by, or if there is a better upstream fix/dependency that
> should be backported instead.
>=20
> Regards,
>=20
> *Tony BONNIN*
>=20


#regzbot introduced: 6cffb59ee50ea4
