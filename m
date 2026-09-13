Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574102F3C10;
	Sun, 13 Sep 2026 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332437; cv=none; b=kQX73uzWzPE/2jJoRlEIlcvzKKMZtO8vD1KvUJJsbHmJVyAj0HT0jKVDtjNyZtGEfsa9F9t6DLtqd/Qbva8SA7KIAtRJnJq3g63s6m+TwX94t/IUFQG5Mu9orDQQnAmuDDUOg62GilCmARqZRw8QGp75zV/ZLb2+vyWSpmydsjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332437; c=relaxed/simple;
	bh=RMieM0kE6G//7Cd+D3lycydrl5bs64X1RCo4kCEHjP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWSEF9goaeaS+YdSEeYK61fURXhx6f8d9myVCH68JlJrWAg5d/15MIuBuSFOUTmot7PiUt0Im0PCgczsg1DrinU9kvBU+yB1GRf7TDVEncSimbGspPJI9ccIkBySPFtkzlIcmg0YOcSKZb7bqn58V1hxta62b9ZAPxDf2vpKY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R3ZLwoU4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R3ZLwoU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789332428; x=1789937228; i=w_armin@gmx.de;
	bh=o69aJ+JtgvfIQWVmcrxcTtmCNvklzMYvTEoU59Im4Ls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R3ZLwoU4J3Nca7LPZpJU/ND/eqqjW8E78npvOj5BskNto/r2iaLqiLp2Xr5zx3uW
	 pVTld/KUAaMH1F1u44yDsQhzZR6O72NxN15lweYuxjQR8806rpMBLb0PfFag5wk97
	 tzdypsKvlP60lIq7IOUtaWp3k2AlOETS0us/uhJsR3BRim3Y+LvILaOmN5qIaE058
	 edElfGRJCPlgEJcoopQajewVkCSZp5ip33cJhYvA83glLpBlmUIiWxHZh9NY1RB2l
	 gg9A80gUBJ5bvaF10wSTOC320KMPihO/31UpscChkHfLVB4aCtgHs4WKmsb+frmtt
	 o18L6gRkSXMbT3HpBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1xBua61yDC-001YgQ; Sun, 13
 Sep 2026 22:47:08 +0200
Message-ID: <173a48cf-5f13-4b8c-ae5a-a294c2a12616@gmx.de>
Date: Sun, 13 Sep 2026 22:47:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: bitland-mifs-wmi: Don't abort suspend when
 platform profile access fails
To: Chris Taraszka <chris@miget.com>
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingyou Chen <qby140326@gmail.com>, stable@vger.kernel.org
References: <20260911182131.461415-1-chris@miget.com>
 <de81ce50-a55d-4a02-85dc-419bb219cdf1@gmx.de>
 <CAAcRvKOppipCzBsGeodOb4gpeG7hgL3TnP+a+GdETvHmGnTRNg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAAcRvKOppipCzBsGeodOb4gpeG7hgL3TnP+a+GdETvHmGnTRNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9e7/vLagltj/U12/po5IcEnnweH0Yw78eZN4AIcajfV7xY52lvb
 RdTD/R8AggOgQBR2FuePmQx2hUVvPQCRF51YOc9Eevvg5H/5b3OiaA+hZLoQjHVNo0UJ6x+
 PN7IPKXzl8rGfcFYyGuMgB08gPuuFh+SMUY0+mP0kdu1jKKH/9vQ6b5y/PlFQz5JSDg+jBw
 pYXuQVrBWyp8iD5uEUXNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZQaQ7hVUYds=;TKiJhVaqGNoCupERy9LvygqMh9j
 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
 N15j

Am 12.09.26 um 20:16 schrieb Chris Taraszka:

> Hi,
>
> gzip attached (~702K rather than 3.6M)
>
> Xiaomi Book Pro 14 (sys_vendor XIAOMI), BIOS XMAPT4B0P0909
> /sys/firmware/acpi/platform_profile_choices: low-power balanced=20
> performance
>
Thanks, it seems that the root cause for all of this is that your device u=
ses different
values for communicating the desired platform profile to the underlying AC=
PI firmware.
I strongly suspect that the platform profile mechanism will currently not =
work on your device
at all.

Some other users have already posted patch to work around this by implemen=
ting a DMI whitelist,
you can find those patches in the archives. I currently have a patch serie=
s pending that fixes
an issue inside the underlying WMI interface, after that i can take care o=
f this problem.

For now i suggest that you blacklist the driver until the DMI whitelist ha=
s been integrated.

Thanks,
Armin Wolf

> On Fri, Sep 11, 2026 at 10:45=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
>
>     Am 11.09.26 um 20:21 schrieb Chris Taraszka:
>
>     > On a Xiaomi Book Pro 14 (BIOS XMAPT4B0P0909),
>     bitland_mifs_wmi_suspend()
>     > intermittently fails to read the platform profile and returns
>     -EINVAL to
>     > the PM core, which aborts the entire system suspend:
>     >
>     >=C2=A0 =C2=A0 bitland-mifs-wmi B60BFB48-...-4: PM: dpm_run_callback=
():
>     >=C2=A0 =C2=A0 =C2=A0 bitland_mifs_wmi_suspend [bitland_mifs_wmi] re=
turns -22
>     >=C2=A0 =C2=A0 bitland-mifs-wmi B60BFB48-...-4: PM: failed to suspen=
d: error -22
>     >=C2=A0 =C2=A0 PM: Some devices failed to suspend, or early wake eve=
nt detected
>     >
>     > The WMI method call itself succeeds. The WMI core reports its own
>     > failures as -EIO, -ENOMSG, -ENODATA or -EPROTO, so the -EINVAL
>     comes from
>     > laptop_profile_get() when the SystemPerMode value returned by the
>     > firmware is not one of the four documented modes.
>     >
>     > How often this happens depends on firmware state. On a v7.2.2
>     boot the
>     > query failed persistently on battery: /sys/power/suspend_stats
>     reported
>     > 4628 failures against 2 successes, both of those on AC. Because
>     logind
>     > re-issues the suspend while the lid stays closed, the machine loop=
ed
>     > awake and drained half the battery over one 8h42m lid-closed
>     period at
>     > ~7-8 W. On v7.3-rc2, whose driver, WMI core and platform_profile
>     code are
>     > unchanged from v7.2, the query has so far failed only right
>     after boot,
>     > when power-profiles-daemon first reads the profile.
>     >
>     > Commit d3666875c75e ("platform/x86: bitland-mifs-wmi: Fix NULL
>     pointer
>     > dereference during suspend/resume") added a !data->pp_dev guard, b=
ut
>     > that only covers the event device. On the control device pp_dev is
>     > valid, so the guard does not apply and the error is returned
>     verbatim.
>     >
>     > Saving the platform profile is best-effort. Failing to read it
>     should
>     > not keep the system awake, so warn and continue instead, in line
>     with
>     > that commit skipping profile operations rather than failing the
>     > transition. Do the same on resume: laptop_profile_set() returns
>     > -EOPNOTSUPP for the performance and full-speed modes without DC
>     power
>     > (see Documentation/wmi/devices/bitland-mifs-wmi.rst), so a
>     profile saved
>     > on DC power cannot be restored after unplugging during suspend,
>     which
>     > would otherwise mark the resume as failed.
>
>     Hi,
>
>     i think the root cause for this is that your device uses a
>     different set of platform profiles.
>     Can you share the output of "acpidump"?
>
>     Thanks,
>     Armin Wolf
>
>     > Fixes: dc1ec4fa86b2 ("platform/x86: bitland-mifs-wmi: Add new
>     Bitland MIFS WMI driver")
>     > Cc: stable@vger.kernel.org
>     > Signed-off-by: Chris Taraszka <chris@miget.com>
>     > ---
>     > Tested on the same machine with v7.3-rc2 plus this patch: 11 s2idl=
e
>     > suspend cycles, including lid-closed suspends on battery of
>     7h42m, 4.9h
>     > and 75.8h, and repeated pm_test=3Ddevices cycles on battery all
>     completed
>     > without errors. The failing firmware state could not be
>     reproduced on
>     > demand on v7.3-rc2, so the new warnings have not been observed
>     firing
>     > during a suspend; the failures described above were recorded on
>     v7.2.2
>     > without this patch.
>     >
>     >=C2=A0 =C2=A0drivers/platform/x86/bitland-mifs-wmi.c | 17 +++++++++=
++++----
>     >=C2=A0 =C2=A01 file changed, 13 insertions(+), 4 deletions(-)
>     >
>     > diff --git a/drivers/platform/x86/bitland-mifs-wmi.c
>     b/drivers/platform/x86/bitland-mifs-wmi.c
>     > index 3a37318..788ef14 100644
>     > --- a/drivers/platform/x86/bitland-mifs-wmi.c
>     > +++ b/drivers/platform/x86/bitland-mifs-wmi.c
>     > @@ -305,22 +305,31 @@ static int bitland_mifs_wmi_suspend(struct
>     device *dev)
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     >
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D laptop_profile_get(data->pp_dev,=
 &profile);
>     > -=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)
>     > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data->saved_profi=
le =3D profile;
>     > +=C2=A0 =C2=A0 =C2=A0if (ret) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(dev, "Fa=
iled to save platform profile:
>     %d\n", ret);
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     > +=C2=A0 =C2=A0 =C2=A0}
>     >
>     > -=C2=A0 =C2=A0 =C2=A0return ret;
>     > +=C2=A0 =C2=A0 =C2=A0data->saved_profile =3D profile;
>     > +
>     > +=C2=A0 =C2=A0 =C2=A0return 0;
>     >=C2=A0 =C2=A0}
>     >
>     >=C2=A0 =C2=A0static int bitland_mifs_wmi_resume(struct device *dev)
>     >=C2=A0 =C2=A0{
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bitland_mifs_wmi_data *data =3D d=
ev_get_drvdata(dev);
>     > +=C2=A0 =C2=A0 =C2=A0int ret;
>     >
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Skip event device */
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!data->pp_dev)
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     >
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(dev, "Resuming, restoring profil=
e %d\n",
>     data->saved_profile);
>     > -=C2=A0 =C2=A0 =C2=A0return laptop_profile_set(dev, data->saved_pr=
ofile);
>     > +=C2=A0 =C2=A0 =C2=A0ret =3D laptop_profile_set(dev, data->saved_p=
rofile);
>     > +=C2=A0 =C2=A0 =C2=A0if (ret)
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(dev, "Fa=
iled to restore platform profile:
>     %d\n", ret);
>     > +
>     > +=C2=A0 =C2=A0 =C2=A0return 0;
>     >=C2=A0 =C2=A0}
>     >
>     >=C2=A0 =C2=A0static DEFINE_SIMPLE_DEV_PM_OPS(bitland_mifs_wmi_pm_op=
s,
>
