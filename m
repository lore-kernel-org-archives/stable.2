Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8E2857EA;
	Thu, 23 Jul 2026 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767447; cv=none; b=fJCQBhtS6aXLm0yhhrua91IQ5/+FhPgGcmlw1HulX/0aZjBI1z+M0/oFDo9yFbayfPmqiUR38a8Oc98RGBIJwVVJv65QbVww+sYkgRZJCiSxckLsU5m2V56JqBylOw0i4lhRLWkUt6xDGJYshr4kHK5p87Sut+apflKG6VXGmvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767447; c=relaxed/simple;
	bh=GIWJct6xVNWZss/hTycbbpJK97a7jEM/TeTuuBb0l3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EippFPxsW9DccUadypsMbuTsW3jYFwBLqj6GUVJ9Y9D1uH5ABfmB7N0z5vKraBPFmTVfW9950F6T0eoEbh0kSZcvX8pwlvzlC4ja4y2LFWhlpAztuxMGgWhTZ8Jp3QWbydrQKj92ZcXEpKtAHpZcxz0J5ja+rWi1x5+t12p6+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nscYdGrT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nscYdGrT"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N0i1W91064054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784767441; bh=Xz90xggreQtVt6hU5KolcDFevxlahnR5y1xWP/553fs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nscYdGrTVErBP0+DH2WeHGilg+ZzKWl+krnm5nCNnhSQpGQ9vVVeBvImPVaNHV7Ld
	 PiDxrxwB6tWs7hzOEtwYkAZfsnxo5f1cvxg6u5/ulLP2mliMzFo76n5SMl0Zk5kdrz
	 CyTnFP+fxr/etlx78mD+/rV+JVJK5MBch806uySinxjT+TthQP71SB2byrjI+Lzf58
	 EQEQ8WS5pvOgmplpLvTOyzsZfqaKrtkjujL8ZlZPnTV+usAz0uR211jNAFOZEA0/78
	 Ba1q1Et0MvEOYhHbFeZei+aQu7XFUpfhCIdtyTrenyYTbXLIK79IhCZFx+Aexi0oa5
	 fi2Vk0g1BbExg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N0i1W91064054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 08:44:01 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 08:44:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 08:44:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 23 Jul 2026 08:44:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192du: Fix possible memory leak in
 rtl92du_init_sw_vars()
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192du: Fix possible memory leak in
 rtl92du_init_sw_vars()
Thread-Index: AQHdGdNxG39Zy+m01ka8NKFSiqmt0rZ6RD1g
Date: Thu, 23 Jul 2026 00:44:01 +0000
Message-ID: <8e45358b6fd74839a827c25193697ea5@realtek.com>
References: <20260722121236.136754-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260722121236.136754-1-nihaal@cse.iitm.ac.in>
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

Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:
> Sent: Wednesday, July 22, 2026 8:13 PM
> The memory allocated inside rtl92du_init_shared_data() is not freed in
> any of the subsequent error paths in rtl92du_init_sw_vars().
> Fix that by adding a call to rtl92du_deinit_shared_data() in the error
> path.
>=20
> Fixes: b5dc8873b6ff ("wifi: rtlwifi: Add rtl8192du/sw.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found with static analysis.
>=20
>  .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
> index 7bafb051d5ec..c7eab3382b73 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
> @@ -118,7 +118,7 @@ static int rtl92du_init_sw_vars(struct ieee80211_hw *=
hw)
>=20
>         err =3D rtl92du_init_shared_data(hw);
>         if (err)
> -               return err;
> +               goto error;

I think here is not necessary to do rtl92du_deinit_shared_data().

>=20
>         rtlpriv->dm.dm_initialgain_enable =3D true;
>         rtlpriv->dm.dm_flag =3D 0;
> @@ -145,8 +145,10 @@ static int rtl92du_init_sw_vars(struct ieee80211_hw =
*hw)
>=20
>         /* for firmware buf */
>         rtlpriv->rtlhal.pfirmware =3D kmalloc(0x8000, GFP_KERNEL);
> -       if (!rtlpriv->rtlhal.pfirmware)
> -               return -ENOMEM;
> +       if (!rtlpriv->rtlhal.pfirmware) {
> +               err =3D -ENOMEM;
> +               goto error;
> +       }
>=20
>         rtlpriv->max_fw_size =3D 0x8000;
>         pr_info("Driver for Realtek RTL8192DU WLAN interface\n");
> @@ -160,10 +162,14 @@ static int rtl92du_init_sw_vars(struct ieee80211_hw=
 *hw)
>                 pr_err("Failed to request firmware!\n");
>                 kfree(rtlpriv->rtlhal.pfirmware);
>                 rtlpriv->rtlhal.pfirmware =3D NULL;
> -               return err;
> +               goto error;
>         }
>=20
>         return 0;
> +
> +error:
> +       rtl92du_deinit_shared_data(hw);
> +       return err;
>  }
>=20
>  static void rtl92du_deinit_sw_vars(struct ieee80211_hw *hw)
> --
> 2.43.0

