Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6941F942;
	Tue, 28 Jul 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206726; cv=none; b=PQkiOJZd50b8EwvG+dIFvthywtan3QezB5CpIbG4XApZRIxvpeNQUhk/nHTHOB0klnVwVdikrjIb1ryNf0X+i6xgWFZxexUQFjlYiOBFw4GAmwz49hhD9zUeMwTrhDg/HCRry60jpZXmot6WzT8JeJ+xmRodhmt1HjX2BuyDxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206726; c=relaxed/simple;
	bh=pQDFNH40sZNiB0luwZuiog275VTkEENkY9lrVDGL3pA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQdsIGKVohvY7iSNNs5MqGTgcZ1gOIuXSuSudb1cUvzIuIygG1+VfxD2yvYsJmOcSpI+13Sv7edbFPqqX5G3N2Mrx6RYG8fli1PBEY6cBjZdY3jsL706LJmIL0vbuH6F6a7UvFXzHZI09EKLwG/yVpfpeqn4xpQRsZ/tg0pc1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vPfOapCW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vPfOapCW"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66S2jJznD3555728, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785206719; bh=teowrk55cfCSQZL70MFwIA8kk4HNMeCdYfP01z3Uanw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vPfOapCW2Xw5w79bOY4mOWHj7iVAFVwrq5oNhQb/teypoEdphX1wbigVAUwTKJZEr
	 XoW8eMsiIOZ7BDVBvhP7i53P/wsFQQkogDB/MRhSvVJLA9n0EUjBht/Vs4OwT1IR43
	 irWTcv6HwjQZMp5ukHnBbOA5ZHHSgdIN8hweqh6qBX1nCjiMiIUu/icQ+a/ko5vnlF
	 +m2G5SdYFgWmmVMS7nEJqXlscjljK48+t5lGOXw/t3B6mlkjTyOTS+elD75KWvARdP
	 tMSIIFfYZZMM7DFLFHML7v1/2Smsa+YAOe3sGC3amdGBSCqzE2jVs7fOYfeFlISNZs
	 vZRXaLfOy/9tw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66S2jJznD3555728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 10:45:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 28 Jul 2026 10:45:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 28 Jul 2026 10:45:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "yhchen312@gmail.com" <yhchen312@gmail.com>
CC: Damon Chen <damon.chen@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852be: add .shutdown callback to quiesce
 device on reboot
Thread-Topic: [PATCH] wifi: rtw89: 8852be: add .shutdown callback to quiesce
 device on reboot
Thread-Index: AQHdHjQ15yuLO5GH90GecNOHrVXHNraCM1qg
Date: Tue, 28 Jul 2026 02:45:19 +0000
Message-ID: <142c91dfc7334136a5dabc4f91504ec6@realtek.com>
References: <20260728015435.1585953-1-yhchen312@gmail.com>
In-Reply-To: <20260728015435.1585953-1-yhchen312@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


yhchen312@gmail.com <yhchen312@gmail.com> wrote:
> From: "Yuhang.chen" <yhchen312@gmail.com>
>=20
> Since hardware rfkill polling was introduced, warm reboot on arm64
> platforms can panic with an asynchronous SError when the rfkill poll
> workqueue reads a register while the PCIe link is being torn down:

Does it mean the work is running after .shutdown but before .remove?

>=20
>   SError Interrupt on CPU8, code 0x00000000be000011 -- SError
>   Workqueue: events_power_efficient rfkill_poll [rfkill]
>   Call trace:
>     rtw89_pci_ops_read8+0x94/0x160 [rtw89_pci]
>     rtw89_core_rfkill_poll+0x50/0x1e0 [rtw89_core]
>     rtw89_ops_rfkill_poll+0x40/0x68 [rtw89_core]
>     ieee80211_rfkill_poll+0x3c/0x70 [mac80211]
>     cfg80211_rfkill_poll+0x40/0x2a0 [cfg80211]
>     rfkill_poll+0x30/0x88 [rfkill]
>   Kernel panic - not syncing: Asynchronous SError Interrupt
>=20
> During device_shutdown() the 8852BE PCI driver has no .shutdown
> callback, so the device is never quiesced and the rfkill polling keeps
> running.  Once the platform brings the PCIe link down, the next MMIO
> read targets a non-responding device and is reported as an asynchronous
> SError, which is fatal on arm64.
>=20
> Add a .shutdown callback that runs the existing remove path to stop the
> rfkill polling, free interrupts and power down the chip before the link
> goes away. A NULL drvdata check guards the case where probe did not
> fully complete.
>=20
> Fixes: 0b38e6277aed ("wifi: rtw89: add support for hardware rfkill")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw89/rtw8852be.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
> index 5bc0a6a99d1d..9aebecbac067 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
> @@ -92,11 +92,20 @@ static const struct pci_device_id rtw89_8852be_id_tab=
le[] =3D {
>  };
>  MODULE_DEVICE_TABLE(pci, rtw89_8852be_id_table);
>=20
> +static void rtw89_8852be_shutdown(struct pci_dev *pdev)
> +{
> +       if (!pci_get_drvdata(pdev))
> +               return;
> +
> +       rtw89_pci_remove(pdev);

Not prefer calling rtw89_pci_remove() twice.

I think we can add a callback .rtw89_pci_shutdown() to set a flag
RTW89_FLAG_SHUTDOWN. In rtw89_ops_rfkill_poll(), just ignore polling, like:

@@ -2010,7 +2010,8 @@ static void rtw89_ops_rfkill_poll(struct ieee80211_hw=
 *hw)
        lockdep_assert_wiphy(hw->wiphy);

        /* wl_disable GPIO get floating when entering LPS */
-       if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+       if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags) ||
+           test_bit(RTW89_FLAG_SHUTDOWN, rtwdev->flags))
                return;

        rtw89_core_rfkill_poll(rtwdev, false);

This flag is very similar to USB RTW89_FLAG_UNPLUGGED flag, but I'd add a
new flag.

> +}
> +
>  static struct pci_driver rtw89_8852be_driver =3D {
>         .name           =3D "rtw89_8852be",
>         .id_table       =3D rtw89_8852be_id_table,
>         .probe          =3D rtw89_pci_probe,
>         .remove         =3D rtw89_pci_remove,
> +       .shutdown       =3D rtw89_8852be_shutdown,

I think this fix can apply to all PCI devices for this driver, right?

>         .driver.pm      =3D &rtw89_pm_ops,
>         .err_handler    =3D &rtw89_pci_err_handler,
>  };
> --
> 2.34.1

