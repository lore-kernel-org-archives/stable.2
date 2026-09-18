Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57136B929
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703848; cv=none; b=KZVV/JVS3gnnpub1XA0qE71SqBRLd66ErT1fa/Llo1pu1tVfjIfzt+xbx9HaM3nevkhHWSmKR2BLyDSfLKb9gAja52yDlwWxHeMM6xBftdafsUVRY12S+yaFIQbL1dW9lgiFHDhY6Tkh00FlJswy17QPTqcPa47lSoXN5EDtUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703848; c=relaxed/simple;
	bh=2B8ZkTKvhPAi9c5C0WKfZ0hsj20J1k7WZPUYzZ++HUU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IcjDm/jC9GGu5Se4fOD+aZfziU7Lg1AawVFRY214IxdeBnsjzQ9q/s6Mm81NwYE7yQYVYkeqDLGUsB0DFnA/dn16jmpijajFZW1H+aRSeE2+dxYbqZ3UzTwyq+/yJ8qxe/SWEesuJ+HW+H/mmWWCtmkACG70JYTzOT9ZcIX4YIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz20t1789703835tc56d9d2b
X-QQ-Originating-IP: zVpUxNE8gwQCwlWGHnuI88s6/ra1uXcLr9NeP0vFfCw=
Received: from smtpclient.apple ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 11:56:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2156956776955812050
EX-QQ-RecipientCnt: 14
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net 1/2] net: ngbe: propagate resume errors to the PM core
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260917090050.1927999-2-zhangyunfei1@kylinos.cn>
Date: Fri, 18 Sep 2026 11:57:03 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 aleksandr.loktionov@intel.com,
 leitao@debian.org,
 weirongguang@kylinos.cn,
 u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCA2A6CE-8E92-4517-930E-C36101ED0AA6@net-swift.com>
References: <20260917090050.1927999-1-zhangyunfei1@kylinos.cn>
 <20260917090050.1927999-2-zhangyunfei1@kylinos.cn>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NvWD9bNzdSSunwYEbBQgHOmp3JpGdwy+QO2adUojqNTVztqo+q8axx6I
	51zEM64V3+zgiJYcvPD+piwcUvEd+XC2gaJ4yMd826pahQyOtzzJt9gHuLbP/9zCSTp/G+Y
	9htPtk9qbQwV4r2kdp3jMUbpBAninIMfbGav1mY3dTq176SoXCM99fgh4hv0W2bjg0fjmkc
	D6TwDW7s1j6S2/U82jJuNIAx8++huSUzIHpHBoa8smJ3AHa3ydt8VQMuCTo15JHq8MX8/nX
	FkYtsYFlpyl0f91iNZXUFCIcSL50E2cOEwLkPjVuutqobHsth+my8TC7ZN1c1Pp+qdz9BLW
	OwYIbhclzFDAtvyuNFbKs8ULxmVTO6hpQOM30Uj6rTN0AqZCsnAtgLEIohTUPKAnkWdOBEj
	UphtVgFi/EDIiCiiiN9sk59V8qA03YVu+YQ5cuCN0uez/payEtOw+nbopHOa6u+OLMmhK/N
	hx+y2T94A3TRGnUbp/qETmcTeCdwC1nxbiJ1iixwunfpBNxW7mqsDVqDVMsWbAIw9O2tXCn
	Vz1P0UrWTV6X8c+NEgtxMTDF1jJBGs6M+buxjG/+L4yJhxlNopzLS/9cTP/MR7MlEM8MTHP
	CuU+4CPMKyeQM8SR/FfoinIqPlAwhZVTwIJQyJnLi8wvT9MoHo1G/O2v7mjpMRDidGO8IJD
	6isfxXyl5HZN4v//52IIk3dhqK8yzsFr5cekVMiN9qdnip1NU8H+e04Wik2z2iqAmOvAJ/y
	JxnIyKztPYa5OhmJsPXxV3Juyqig4NAklY4qdqXjYSmy4QH6Fmsj08jnFG0CAYqxqLRcEWE
	CbxV8T9qVFqjPeEy6FuFUCtMeSX76ITEhk2TWqF4yuTAQcep/To8LFs3DFdoskgdotsKuT8
	UXsOjKj+aTqlMXIMcYltesyt4cn79d4aAA8tLo5dwC29dR9eZ+g88uWHMVVFzek0f4D7iBy
	vpWYUalGFSdjQBs4w6+7CVK6t033NJA9Hkdn3Avs0bTMId8IeFUkaI+kr35yQFgBG0VM/e1
	95BGqGzRtSrJlTN8lDcSArO9U/JKzU6GOHmwqUt+lG8Rd3ZRd2x9FVP+WA4/1mjW97cgp4S
	pyjE6TkxLpP6AVavDPVFdalgsneACB4biUfdOOkThD1
X-QQ-XMRINFO: Mp0Kj//9VHAx235w5pKcATsBnINcSeXWMQ==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=8817=E6=97=A5 17:00=EF=BC=8CZhang Yunfei =
<zhangyunfei1@kylinos.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ngbe_resume() declares err as u32 and unconditionally returns 0, so
> failures of wx_init_interrupt_scheme() or ngbe_open() are silently
> swallowed. The device stays in netif_device_detach() state with a
> broken interrupt scheme, the PM core is told the resume succeeded,
> and the netdev never appears in the networking stack again: the
> reset task also bails out early on the missing
> netif_device_present() check, so the device cannot self-heal.
>=20
> Fix the type to int and return err, making the tail of the resume
> path consistent with the pci_enable_device_mem() failure path at
> the top, which already propagates its error. A failed resume then
> becomes visible to the PM core and the device can be re-probed.
>=20
> Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>

Reviewed-by: Mengyuan Lou <mengyuanlou@net-swift.com>

> ---
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610..6d8289e2532d 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -954,7 +954,7 @@ static int ngbe_resume(struct pci_dev *pdev)
> {
> struct net_device *netdev;
> struct wx *wx;
> - u32 err;
> + int err;
>=20
> wx =3D pci_get_drvdata(pdev);
> netdev =3D wx->netdev;
> @@ -977,7 +977,7 @@ static int ngbe_resume(struct pci_dev *pdev)
> netif_device_attach(netdev);
> rtnl_unlock();
>=20
> - return 0;
> + return err;
> }
>=20
> static struct pci_driver ngbe_driver =3D {
> --=20
> 2.25.1
>=20
>=20

