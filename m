Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628672;
	b=1fGGJpA+lxVYFDjLWXBTyCJ4eInudpctKXrxKgWQNARwzAHi77aw3kq/7XOOM9netwga
	 p+JmC0zYJd7qc8ZSFQdEYlSDBHkInk+WcI8BjcIuHbXSd0Fh92sg2OzZws6R5UbPxAGiM
	 +OHOfqYzZwzSbstcy8Uumnisua+3LMHQR6f50xuR3MFWnDNQNOEq3DWB5Av0fkQ0gAJop
	 euOGdvcKrUgqh9T+FQ97KIHm5WudoahRrN7MmhQmLhn8z+2W7cnOeE0ZrJ343TYESvCLU
	 9g/w6P61jR+F7MR+GdbrRcT4F5WmRaGVsG8ip0NTL6UnIstSZIUF++YH+E1/3h4uKsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628672;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vi44JuB66M4crD5hxja6G77GWCvRuh5Zid8iRQ6RjTk=;
	b=GIe9qjeUlLnZjo8CTNTdoRd6Yu+0Vpv+NRHu8Jt5TP/omhFQx18yyCA1pDpGdXr25UA+
	 X3l3wajWtseRfbmM028E49LtsBi9tcsVo4zZ1vqLfB+r06u5aBVhDGrOjbQ8ADXbW3UaS
	 1N7SOrTdpgli9481A5slqaELxkvwxkKNYLytp7NfEJKbvch2Ni78x3Gf98/nPznQqXnfV
	 cTTiscN/W915hi3shM4kYQEzQrHKNSZloI52kRdgZgIuvAeSF94boddjryNo9AOp1dUo8
	 HfCyyi4EGvdQmtooj9N7Y+RX0k5e4le7sj1AcExd47OJdI8PLSXc5Hadj7dP4X3emMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdWjwxuB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29280606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdWjwxuB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59941F00A16
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628671;
	bh=vi44JuB66M4crD5hxja6G77GWCvRuh5Zid8iRQ6RjTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DdWjwxuB7982hwQ17yBhal/0wUL2OpQfjLd3zGgXHVCBo1QHo1CplJS2vO+YXDXtp
	 6T2Id+fIN9AC0SZBB919WwPdIkVh47xMGmTe2MUd/oEADEMnuBdO2justglx5RVzM3
	 Its3oAFNk4vEsQVyvKUgGdoJNsK8X2XY+m0spyGwxBxokwRu3WDRauwXYtbPLlBANs
	 j5q1wbpLtTO+pervlu7zlqR36IbBjFhniQeT+iwKRndfpCT+p3OO5ztmHLQc5ZmajT
	 DvfwTMbkoBmJCYntYRlfXdEa+85pu8AP6InsCbAk+XkZFxT4vpstTpIjbw7wsl435t
	 2sAObNhrvXTeg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be4d648aacso2605220e87.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:11:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw846/NblSbVRtjhKSU0EJUHyx2oMaPzUAnUEMBjOGBQdC96I/608bUlCuD1DaHeGKQ+Od1SAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+js42NM8gn4Ag9GxeYbNrf95J5TaRXSHbmc3SCF+sqIImUm1u9
	CxPaxCwoAldacoG8PcVoczmK1s8w4yWkNIhdvc35+luRUZMebIWZiZmxao2E0fSsUAyB89APdS+
	2XqcfJoGif6y+aqFQuVVYhY/Eb1sTiyQ=
X-Received: by 2002:a05:6512:3b24:b0:5bb:7923:207e with SMTP id
 2adb3069b0e04-5bfd957b635mr3266873e87.52.1793628670143; Mon, 02 Nov 2026
 06:11:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org> <20261102-superm1-kbz-222179-v1-1-c91a664ba251@kernel.org>
In-Reply-To: <20261102-superm1-kbz-222179-v1-1-c91a664ba251@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 2 Nov 2026 15:10:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jMA2AwzdcwFH7YW-q9LHopvKf_BfZHEpyGXq+=fMTYEA@mail.gmail.com>
X-Gm-Features: AclHuK9HJv2fcCVOo5llT60Bp3HAHvTaGFzfiEmFxy8h3095W3Oz8AnHquG8ZGo
Message-ID: <CAJZ5v0jMA2AwzdcwFH7YW-q9LHopvKf_BfZHEpyGXq+=fMTYEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/PM: Disable bridge D3 on Lenovo ThinkCentre M90n-1
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kerenl.org, 
	linux-kernel@vger.kernel.org, Joshua Perry <josh@6bit.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:57=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On the Lenovo ThinkCentre M90n-1 (board 314D), suspending the empty
> Root Port 9 turns off a clock needed by the onboard RTL8168 behind
> Root Port 12.  The NIC becomes inaccessible and r8169 fails to probe
> with "Unable to change power state from D3cold to D0".
>
> The RP09.PXP_._OFF method gates PCH SRC clock 1, which also supplies
> the NIC behind Root Port 12.  Keeping Root Port 9 in D0 preserves
> that clock and allows the NIC to probe.  Commit 4d4c10f763d7 ("PCI:
> Explicitly put devices into D0 when initializing") exposed the firmware
> bug on every boot by ensuring that the first runtime suspend executes
> the power resource's _OFF method.
>
> Add the board to bridge_d3_blacklist to prevent bridge D3 transitions.
> Check the blacklist before platform_pci_bridge_d3(), since ACPI allows
> D3 on the affected hotplug port and would otherwise bypass the quirk.
>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Reported-by: Joshua Perry <josh@6bit.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222179
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <superm1@kernel.org>

As per the discussion in the bug entry

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/pci.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..17ec7f065682d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3028,6 +3028,17 @@ static const struct dmi_system_id bridge_d3_blackl=
ist[] =3D {
>                         DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
>                 },
>         },
> +       {
> +               /*
> +                * Suspending Root Port 9 gates a clock used by the onboa=
rd
> +                * RTL8168 behind Root Port 12, making the NIC inaccessib=
le.
> +                */
> +               .ident =3D "Lenovo ThinkCentre M90n-1",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "314D"),
> +               },
> +       },
>  #endif
>         { }
>  };
> @@ -3073,6 +3084,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge=
)
>                 if (bridge->is_thunderbolt)
>                         return true;
>
> +               /* Firmware D3 support does not override known platform b=
ugs. */
> +               if (dmi_check_system(bridge_d3_blacklist))
> +                       return false;
> +
>                 /* Platform might know better if the bridge supports D3 *=
/
>                 if (platform_pci_bridge_d3(bridge))
>                         return true;
> @@ -3085,9 +3100,6 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                 if (IS_ENABLED(CONFIG_X86) && bridge->is_pciehp)
>                         return false;
>
> -               if (dmi_check_system(bridge_d3_blacklist))
> -                       return false;
> -
>                 /*
>                  * Out of caution, we only allow PCIe ports from 2015 or =
newer
>                  * into D3 on x86.
>
> --
> 2.53.0
>
