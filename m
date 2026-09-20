Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3D439F91;
	Sun, 20 Sep 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789912183; cv=none; b=ujFACGZxMSvfo8oEBGe/plsmRHpXPaF3XD/gzPTfRlAg2o8wsylJw4fv7rRync5uOggGwT6NII/0lIZL/D/Obg5EAaLx6mZHtVUi/NJHtKqxnFFE22/a6BlyOMdoip963b55gDGum5jUZFCCanSnXW3TpLNgSmlJAFFrwCB5nyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789912183; c=relaxed/simple;
	bh=3BGKPjEXlHJ/7EQvEX2Y+2jm8uh1xcJQttD0VeU5MmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzDT0rfdLjTY9gXSVGQ0cAaLG/B6eJ1piZTUjW9lxjlbpOYwDvlyz4vi4pdSIJF9Mq/UUTjGHx1Q+vTjhb6q1nxUAkMSYfg6PlL8OpkcwAkZqjYBMeiLTmBry3+hTV8ljFM+Xh2PUW5H0xQKUdERSfw4RY5IZvPQIIkr0UBhXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b=np/lIuvD; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b="np/lIuvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1789912152; x=1790516952; i=cito@online.de;
	bh=AqcM6OH+H51Vyn6T0c3uTYZxt3s2a8bLr9yFqcooSIQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=np/lIuvDoWNp3wOgFxVvQ36G5cx3KYXVn5HQsqtQEN2EFoPZLLifePtQYE5DOzxC
	 kU9aCUJ52XbWBCdVA767ELspkyFr3bx/UPgJulF8b9e2adlK8yEs5nX1Pm2NYSqKQ
	 p6cTViT34oHWmlsy2xy8E9qNH/iQhwfs2FL9zTBKLD4BbEmPS2FyMkkKJwUhr0hVE
	 ZO+q6rgGM7v2WTNbncSKL9+WW+3IDU7b/FGfHRrdtmKa7fsI0UjJREWW2o5PhZ3Fo
	 7aFiddizvnVfQQR1qgNuUPQfD96vgHsavJ7FPgCHtikAfQz8UqWR+XQHv7g/HZcpG
	 tXplC6kXdPdaE5oSIw==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MzQXu-1wutrL43iy-011wXF; Sun, 20
 Sep 2026 15:49:12 +0200
Message-ID: <0fd8c1c9-7f56-4bcb-a727-e4386d8ef094@online.de>
Date: Sun, 20 Sep 2026 15:49:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] btusb: ASUS USB-BT540/BT600 IDs backported without,
 RTL8761CUV support, adapter re-enumerates endlessly (6.18.50, 6.12.109,,
 6.1.188, 5.15.221, 5.10.270)
To: "ra.prism" <ra.prism@gmail.com>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Max Chou <max.chou@realtek.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 regressions@lists.linux.dev
References: <9ac1c05b-e9f2-49e9-af63-9cd0e42115fc@gmail.com>
Content-Language: en-US
From: Christoph Zwerschke <cito@online.de>
In-Reply-To: <9ac1c05b-e9f2-49e9-af63-9cd0e42115fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R4csNoRzKW9O02+9m23soDiC297hXinYTrzF6Hr+dk6LHcjBHuk
 16MIukKmvtXrMSzcypbpCkivxPrPeikAINpBXKJhjemq9n5KqQm7d2NzDDVgi57eQQxFQec
 fsUMVaybmqUU23PymazWoXfilIqQoHseAcKNaU/6aATlwcHKkXxnIOSR5tfrE3FneViz6rs
 BqkkSOJFTz8QZQJmX2D3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yK4M75rwyEc=;Y/kENATl2cXDYOH2KBw0KNi6WE/
 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
 Bb+4E

Hi Ralf, hi all,

I submitted the two commits. Your analysis is correct - please revert
them from every tree below 6.19.

The commit message was also wrong where it called the adapters
"non-functional" without the entry. They bind via the generic
Bluetooth class and run their ROM firmware. I had tested that on a
machine that was also running ASUS' out-of-tree rtk_btusb, and
credited the working adapter to my patch.

Measured 2026-09-20 on 6.18.50 with the two IDs removed from a local
btusb build: BT540 (0b05:1bef) and BT600 (0b05:1d70) both come up
with real BD addresses, no USB disconnects, and carry ASHA and A2DP.

My recommendation is the revert rather than fixing it by backporting the=
=20
RTL8761CU support that btrtl gained in 6.19 (4a23ce935f74). I tried the=20
backport against 6.18.50 and measured it, but it is hardware enablement=20
rather than a regression fix, and it doesn't seem to gain anything=20
substantial: against the ROM firmware these adapters already run, I=20
could measure no difference in audio quality. The revert is smaller,=20
needs no stable-policy argument, and simply restores the behavior these=20
adapters had for years.

Sorry for the breakage, and thanks for the report.

Christoph


On 14.09.26 13:44, ra.prism wrote:
> Hi,
>=20
> two btusb device-ID commits were backported to stable branches that lack
> the btrtl support they depend on:
>=20
>  =C2=A0 980084de4d9b ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek =
8761CU")
>  =C2=A0 6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek =
8761CU")
>=20
> Both set BTUSB_REALTEK for 0b05:1bef / 0b05:1d70, so the adapters now go
> through btrtl setup. btrtl only learned about this chip in v6.19-rc1:
>=20
>  =C2=A0 4a23ce935f74 ("Bluetooth: btrtl: Add the support for RTL8761CUV"=
)
>=20
> Without it, setup fails and the adapter resets in a loop. Before the
> backport the adapter bound via the generic Bluetooth class and did not
> loop.
>=20
> Affected, checked against the stable trees (btusb.c has 0x0b05/0x1bef,
> btrtl.c has no rtl8761cu entry):
>=20
>  =C2=A0 released=C2=A0 6.18.50 (aa7b93fe98ba, bce588b4ca08), still in 6.=
18.51
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.109 (f05baf6e0680, 32412=
aff8d11)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.1.188, 5.15.221, 5.10.270
>  =C2=A0 queued=C2=A0 =C2=A0 queue-6.6
>=20
> Not affected: 7.1.y (has 4a23ce935f74 but not the IDs) and 7.2.y (has
> both).
>=20
> Observed with an ASUS USB-BT540 (0b05:1bef, hci_rev 000e, lmp_subver
> 8761) on 6.18.50: 203 re-enumerations in 37 minutes, one every ~10.8 s,
> independent of the USB port:
>=20
>  =C2=A0 [=C2=A0 =C2=A0 8.008281] Bluetooth: hci0: RTL: examining hci_ver=
=3D0d=20
> hci_rev=3D000e lmp_ver=3D0d lmp_subver=3D8761
>  =C2=A0 [=C2=A0 =C2=A0 8.008294] usb 5-2: USB disconnect, device number =
3
>  =C2=A0 [=C2=A0 =C2=A018.476022] Bluetooth: hci0: RTL: RTL: Read reg16 f=
ailed (-110)
>  =C2=A0 [=C2=A0 =C2=A018.852034] usb 5-2: New USB device found, idVendor=
=3D0b05,=20
> idProduct=3D1bef, bcdDevice=3D 2.00
>  =C2=A0 [=C2=A0 =C2=A018.875711] Bluetooth: hci0: RTL: examining hci_ver=
=3D0d=20
> hci_rev=3D000e lmp_ver=3D0d lmp_subver=3D8761
>  =C2=A0 [=C2=A0 =C2=A018.886986] usb 5-2: USB disconnect, device number =
4
>  =C2=A0 [=C2=A0 =C2=A029.228274] Bluetooth: hci0: RTL: RTL: Read reg16 f=
ailed (-110)
>=20
> Same machine and adapter on 7.2.5, which has both commits, works:
>=20
>  =C2=A0 [=C2=A0 =C2=A0 7.816015] Bluetooth: hci0: RTL: examining hci_ver=
=3D0d=20
> hci_rev=3D000e lmp_ver=3D0d lmp_subver=3D8761
>  =C2=A0 [=C2=A0 =C2=A0 7.820005] Bluetooth: hci0: RTL: rom_version statu=
s=3D0 version=3D1
>  =C2=A0 [=C2=A0 =C2=A0 7.825030] Bluetooth: hci0: RTL: loading rtl_bt/rt=
l8761cu_fw.bin
>  =C2=A0 [=C2=A0 =C2=A0 7.826003] Bluetooth: hci0: RTL: loading rtl_bt/rt=
l8761cu_config.bin
>  =C2=A0 [=C2=A0 =C2=A0 7.840001] Bluetooth: hci0: RTL: fw version 0x7bf1=
5762
>=20
> 6.18.48 (without the IDs) did not loop. The kernels were distribution
> builds (CachyOS linux-cachyos-lts 6.18.50, linux-cachyos 7.2.5). I
> checked the relevant btusb/btrtl lines against the vanilla stable trees
> listed above. I only have the BT540 and only tested 6.18.y; the BT600 an=
d
> the other branches are untested but in the same situation.
>=20
> Could you please:
>=20
>  =C2=A0 - drop both patches from queue-6.6, and
>  =C2=A0 - revert them in 6.18.y, 6.12.y, 6.1.y, 5.15.y and 5.10.y, or ba=
ckport
>  =C2=A0 =C2=A0 4a23ce935f74 (btrtl.c, +15/-1) where it applies. I have n=
ot checked
>  =C2=A0 =C2=A0 whether it applies cleanly to any of these trees.
>=20
> Thanks,
> Ralf Ahlbrink
>=20
> #regzbot introduced: v6.18.49..v6.18.50
>=20
> #regzbot title: btusb: ASUS USB-BT540/BT600 IDs in stable without=20
> RTL8761CUV btrtl support cause endless re-enumeration


