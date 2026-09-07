Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1E883F;
	Mon,  7 Sep 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748829; cv=none; b=sCaN1hEuyWrSskXtnmF7W0FWgXTynNvowtuk3t3e5vPQ687xDeHqirqu2rSTHVnHpaExaudihGL8BSQe/OsqF5eiSErymDXSQUIGJeBD/BHn0Hs41fYMh6Xdk15ZKj3UG4zeKTZQaVstCqDSr52BoKK+wLIGhS7fifqpXqzaYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748829; c=relaxed/simple;
	bh=ThpeK2ik4ReGazR65sPK1I0GylKFv3ulbdOB3NmhqG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j0T770d6OPApSr+ZodgIoPCr6d5fbHBnHyhN8ZFYkYYOQY3CfT474hFY3oAY9X9TwNcXtXITWdlDG0nSfRjJnD8Fp7ViQFz6oc+a+zDidnPfW82c4o6DzpBhVUaitip03SMjAuShHE5NoMBn6nNeDE4KI2LlbsnoMlOwppA9qyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=U6K8NsjK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="U6K8NsjK"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6872e87j92413737, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788748809; bh=Pulgy9ZZOouR6PMWUYjfrXuSoB0jKzCcVXvOK2FlC7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=U6K8NsjKh8eLZVkt0HDDRmeO+/VIkJxtAIKKp1flIMtotjXH+FznJh169ZP8rfrwq
	 +qov6V4oXCY1SnGM7F+K9In2GmjHxepI7J45KDtG7qlJ467uqkQ34Wvbx5/UEJNjrG
	 KDjOUxiauHwVbAXRgbeaHSpxlLG0++Sl5fHazti2ndspBbyjdnGgprUHaZRPGsOdwd
	 rehJanEnvAAO6flIbTFG0wYTI9sDU6jr/uDAHwUMoS9OVDsYtVMDLrvKld4kRM5N1P
	 jqjKPzaokhigYNmh7xVIBkr61I50VrYcXLlefQadQmdL0HeeFEd1Rk/Ykzz6zDNMeo
	 hd4P1tXC21bDw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6872e87j92413737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 10:40:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 7 Sep 2026 10:40:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 7 Sep 2026 10:40:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Mon, 7 Sep 2026 10:40:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Bernie Huang <phhuang@realtek.com>, Timlee
	<timlee@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Tristan Madani <tristan@talencesecurity.com>
Subject: RE: [PATCH wireless 2/2] wifi: rtw89: fix OOB read in
 __rtw89_wow_parse_akm()
Thread-Topic: [PATCH wireless 2/2] wifi: rtw89: fix OOB read in
 __rtw89_wow_parse_akm()
Thread-Index: AQHdOIxRRhVJWcdn70CpojTFkESnvrbCcm3w
Date: Mon, 7 Sep 2026 02:40:08 +0000
Message-ID: <b997de89af864c3d9ed7d5d2ef233169@realtek.com>
References: <20260830143154.1751910-1-tristmd@gmail.com>
 <20260830143154.1751910-2-tristmd@gmail.com>
In-Reply-To: <20260830143154.1751910-2-tristmd@gmail.com>
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

Tristan Madani <tristmd@gmail.com> wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> __rtw89_wow_parse_akm() computes a pointer to the IE area with
>=20
>     ies =3D mgmt->u.assoc_req.variable;
>=20
> and then passes skb->len as the IE data length to cfg80211_find_ie():
>=20
>     rsn =3D cfg80211_find_ie(WLAN_EID_RSN, ies, skb->len);
>=20
> skb->len is the total frame length, not the length of the IE portion.
> The IEs in an association request start at offset 28 (24-byte header +
> 4-byte fixed fields), so the correct IE length is skb->len minus that
> offset.  Passing the full frame length causes cfg80211_find_ie() to walk
> up to 28 bytes past the end of the skb data buffer, triggering a
> slab-out-of-bounds read.
>=20
> Fix by validating the minimum frame length and passing the correct IE
> data length to cfg80211_find_ie().
>=20
> Fixes: 480dd4dddfc5 ("wifi: rtw89: enter power save mode aggressively")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/net/wireless/realtek/rtw89/wow.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wirel=
ess/realtek/rtw89/wow.c
> index 8dadd8df4fc65..82b74ded68631 100644
> --- a/drivers/net/wireless/realtek/rtw89/wow.c
> +++ b/drivers/net/wireless/realtek/rtw89/wow.c
> @@ -16,10 +16,16 @@ void __rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, =
struct sk_buff *skb)
>  {
>         struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)skb->dat=
a;
>         struct rtw89_wow_param *rtw_wow =3D &rtwdev->wow;
> +       size_t hdr_len =3D offsetof(struct ieee80211_mgmt, u.assoc_req.va=
riable);
>         const u8 *rsn, *ies =3D mgmt->u.assoc_req.variable;
>         struct rtw89_rsn_ie *rsn_ie;
>=20
> -       rsn =3D cfg80211_find_ie(WLAN_EID_RSN, ies, skb->len);
> +       if (skb->len < hdr_len)

Since the skb is generated by local to do association, I wonder that
does it possibly happen?

> +               return;
> +
> +       rsn =3D cfg80211_find_ie(WLAN_EID_RSN, ies,
> +                              skb->len - hdr_len);

Straighten the line.=20

> +

no need this blank line.

>         if (!rsn)
>                 return;
>=20
> --
> 2.47.3

