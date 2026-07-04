Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4C3749EE
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184209; cv=pass; b=L/yw+48ryaR3XKcoECvW15xmeI6kItFoPVEWOJk/UVKUvMlu75mXT/DpPbEW1saWrR6i58FSXCIE6HZAieomHinHPqWgNU1yftqs/UixjC40TxxtS6ESs1k4Pvyvpa5eaEqbhjrqcglGvVmZmhehlCGxp6azD2VGdQbk9a/Jjag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184209; c=relaxed/simple;
	bh=w1NQ2pKqz3g9ab7jmMMtW75lol/MffqP9prmhNIFkew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0kLVxPmWkugVrBWRAyIoxGJNikd/mgWpQVm/DBBMlgDgx1Hu6kYnsQe8xiwXuJYNrtlJXdS+cmG95I3+gtAWRctnrS9Js7Olw+lZ1B8g9dNe89ZjqQxK7+dRf2vLi1TJQ+WJnxveJdZ+KkquVvKM6DM0oScPUzqriwqgp4IDl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNd2e5x0; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNd2e5x0"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39b293079d1so13447561fa.3
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 09:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783184204; cv=none;
        d=google.com; s=arc-20260327;
        b=HUAQ1mwI954Ubz8bLejtiPccbgzvPa61MyE8kdc94nQXGe2rzmyVLmb2p0pV/Sal0J
         2kmgYPpSXuL/51Zfo/hM+9oKURRiYG1XNmfY+myOqCjdcLgKAXYTlW1ny0M1HbJBoBUT
         h3UVoOvwnIJyGthHE1TPZYH39ouaL8Dz00BDuXd5y8lpeH7c4fARmVNrBGcZGni8PFOb
         sWOSZO7Yr+fmr9vhpgoSe86veX+UQ+vVH3wr64iuLE+jrsvXXPsN4EV/feyQzPAgNvXy
         aG+Yw8R/DzxKiybKGCL2wB7S4EGqQwIw/ULJQ/ZMQDYPZhRRPaMn6N/FJsM5wl2OjU5p
         YKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1T1olNimwkjRU+Vde+WeenpJhKN6hTkj0enHPynd8c=;
        fh=37848fCeDFSXAD0Qg0QAu3MSkm1J7WbxT2I2Ls2w1Bo=;
        b=FstKVhMUOJ/75bZxfREW6LSw38eochgYw5oZ8AVqXiwq4jO6MzrjYGFbaXlSZ8xr+x
         dqSi2EpsYVGqZXMQMNoGFoqtAktFQAMU9AQVNKQ6+mSOlUifgohQqHtDh8vvOl1zFaah
         7xp7dOkLekdjBAzAUAPrySQEXGZr+WNoR4wes/uitBf6kg7vJykzWw9H4fVsNeqvaJE0
         EkdrWqZhDC2z9kr2LUNSsbEwhWmxbWWc5RrMHD4Fvlcu9kJiPJwJeZV+iD1MzYfav1ye
         sQUJD/qf5mMxXrQGsgXaRGR2m/8gTBX5kk4cwUVTyp8cztd+hjBh8+pJTeao5b8iq0tn
         yO4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783184204; x=1783789004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1T1olNimwkjRU+Vde+WeenpJhKN6hTkj0enHPynd8c=;
        b=JNd2e5x0OMrhFvp8OC1zRIJjUUjQnryvBclhy+VGQT2NRbY4crZf3+VXvvfL4K17vk
         tmtPX4oTAEp8Z+hJ+aL0MrexcIVGO5TOfuE+ppQZiwhxtN1AK9NFVyRri4J1LXVPyBK0
         dCkrsKB7By10TbMUJn+A+LEAumopm+VIxZcJcAR7ftgeD4/77tF0nwpB/mwkRrQiAsCv
         xofCDTrrkzhQvEoTp1KTtxx+yOEeXupFCSe35n2Dw4ZPO8AaggwMOOSXWf1LbbIYZG33
         dmU7gVFNxw+zB55vi6xMYc15snOqHeQgNuhpcUyPwPgUDDgsm0zeNavfxjvp62ouQTd+
         cHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783184204; x=1783789004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1T1olNimwkjRU+Vde+WeenpJhKN6hTkj0enHPynd8c=;
        b=IlS5UKByRFqriXHgiyTLfoOxULmFeAnWftB6I0BFKqFiY3IhOUcpuMyQTs4lFw177v
         nLuI/uhfP8k7HZIAKVMiotnBg+eCaxOOki9KR+8ipZWsr0HRgj3JWgE46h9hYNBK+Fpl
         4EjvgII9b+sM/2jud9XyQCkwcRJUlVpmscFZa+Se3VrtoBTkKZLtmN2ldxWFV+Aken6R
         wtLQ+y2zIruVAHdRuL4QCdu9CpXBGDYmMxEn7y9ZXD83jtxvCS+Sq6hEBwFvnpcHqvaL
         QexZECenqp839j9rWw5MZNqoLQo0C7EzrDfjvaefQLGKX9V7n4GQolamYusj+ckOzEj9
         HavQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4QsGDcDSgE5LXIdFTokm9S6QjMixIno3BZVAg2U0q68U8uaVAuOGhAUSBChIdFks9M3ngi3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/fDtsTPmSu+N0NddwT11+k/uOlZrq+rUc2AurwjWjaqQxm3w
	BjtcYLSpdnco1io86JdV0DzyChxNtJ9MHEv/jYrkz/Jq/dYwFvznJ9d0BPM9OPSjczYJ3ufzsgH
	df/VqqiLMYekB8qB/EMKlt5MLnfSExZA=
X-Gm-Gg: AfdE7ckQpbhcdemz628z9GXfyMvlj08tPTwWDiVLJyiZfnLIpvMXYPvwAcUs5mLl5Jo
	GvI6MsQv9KM052pQ1hRigoKpc6Vf+WVpnuDaxHbypbksxhZXBF7bleh1F4xpmtwKuOc3IS20KXY
	Fu/YQedk2Yi61JJZgvud1oQZ7LsE5WfyEdaoiKxzlQee5OoF/DUtFhBIBiK91s/QXS0xUFwjS9E
	ykblYhNyBKwoeJWXyafqSfZOlhK90MyklT/QNlGMn1/He7hNXW7x9h/3O8C272LBPENeHlj66dX
	kdyKvdNGsTaVR1cmR7iGzMHrw+4XCrbNWrUypaNZFXv5qnbHOIW9XZFR
X-Received: by 2002:a05:651c:1548:b0:39a:f7b4:d828 with SMTP id
 38308e7fff4ca-39b53dd40bfmr7309521fa.32.1783184203484; Sat, 04 Jul 2026
 09:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626204945.18868-1-meatuni001@gmail.com> <82c8271a-4747-4930-bc31-bc0786178c6a@gmx.de>
In-Reply-To: <82c8271a-4747-4930-bc31-bc0786178c6a@gmx.de>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Sat, 4 Jul 2026 21:56:32 +0500
X-Gm-Features: AVVi8CfO4YYzd26w1Cc_sDfnje81ZYCsgDbD7cNq0XO6gwW15qcnaNpNFx-rC8g
Message-ID: <CADqcGB=HuQHq9gcmB2N8AgwJbbqfoUwaF-01D0unMA30dLg-bg@mail.gmail.com>
Subject: Re: [PATCH 0/2] platform/x86: hp-bioscfg: fix attribute enumeration
 on older HP BIOS
To: Armin Wolf <W_Armin@gmx.de>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Armin,

I've posted v2 of the series, which includes an additional preparatory
patch to ensure parser iteration remains bounded before relaxing the
package-length check.

https://lore.kernel.org/all/20260704160759.236249-1-meatuni001@gmail.com/

Thanks for your review.

On Wed, Jul 1, 2026 at 1:29=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 26.06.26 um 22:49 schrieb Muhammad Bilal:
>
> > The hp_bioscfg driver silently fails to enumerate BIOS attributes on
> > HP EliteBook 840 G2 (and potentially other older HP models) because:
> >
> >    1. hp_init_bios_package_attribute() hard-fails when a WMI ACPI packa=
ge
> >       contains fewer elements than the per-type expected count (11 < 13=
),
> >       even though only the first 10 common elements are required to
> >       register an attribute.
> >
> >    2. hp_populate_enumeration_elements_from_package() returns -EIO and
> >       discards the entire attribute when any single element has an
> >       unexpected ACPI object type =E2=80=94 typically after a BIOS AML =
error
> >       returns malformed data.
>
> Hi,
>
> it could be that the ACPI firmware still transmits all the necessary data=
, its just
> that some package elements are combined into a single buffer element
> (see https://docs.kernel.org/wmi/acpi-interface.html section "Conversion =
rules for ACPI data types"
> for details).
>
> The correct solution would be to migrate the driver to the new buffer-bas=
ed WMI API,
> because said API ensures that ACPI objects are properly marshaled into th=
e common
> WMI data format. However this might require a lot of work :/.
>
> Regarding the BIOS error: this usually happens because creating a ByteFie=
ld with and
> invalid length does not cause an error under Windows. Passing a larger bu=
ffer usually
> fixes this problem.
>
> Thanks,
> Armin Wolf
>
> >
> > Hardware affected:
> >    HP EliteBook 840 G2 (DMI: Hewlett-Packard HP EliteBook 840 G2/2216)
> >    BIOS: M71 Ver. 01.31 (02/24/2020)
> >
> > How to reproduce:
> >    1. Boot a kernel with CONFIG_HP_BIOSCFG=3Dm on an HP EliteBook 840 G=
2
> >    2. modprobe hp_bioscfg
> >    3. Observe dmesg:
> >         hp_bioscfg: ACPI-package does not have enough elements: 11 < 13
> >         Error expected type 2 for elem 13, but got type 1 instead
> >
> > Testing notes:
> >    Tested on HP EliteBook 840 G2 running Arch Linux kernel 7.0.13-arch1=
-1.
> >    After patches, hp_bioscfg loads successfully and enumerates availabl=
e
> >    BIOS attributes. Attributes with shortened packages are partially
> >    populated and accessible via sysfs. No regressions on systems that
> >    return full 13-element packages (checked via code inspection =E2=80=
=94
> >    pr_warn path is only reached when count < min_elements).
> >
> > Relevant dmesg (before fix):
> >    [   11.xxx] hp_bioscfg: ACPI-package does not have enough elements:
> >                11 < 13
> >    [   11.xxx] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT,
> >                Index (0x000000032) is beyond end of object (length 0x32=
)
> >    [   11.xxx] ACPI Error: Aborting method \_SB.WMID.WQBE
> >    [   11.xxx] Error expected type 2 for elem 13, got type 1
> >    [   11.xxx] hp_bioscfg: Returned error 0x3
> >
> > Muhammad Bilal (2):
> >    platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP
> >      BIOS
> >    platform/x86: hp-bioscfg: warn on element type mismatch instead of
> >      failing
> >
> >   drivers/platform/x86/hp/hp-bioscfg/bioscfg.c         | 11 ++++++++---
> >   drivers/platform/x86/hp/hp-bioscfg/bioscfg.h         |  3 +++
> >   drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c |  7 ++++---
> >   3 files changed, 15 insertions(+), 6 deletions(-)
> >
