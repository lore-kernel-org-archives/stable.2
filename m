Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E7B67E;
	Mon,  7 Sep 2026 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748315; cv=none; b=NTDZ0ptsH9lqrtC66aDF1uCF8s53NL1SNnb6puPom/oXjlgpy5QL/rx2abBC/k/v8lEwzEmIW99yRqNurX5kFjMPiCGVUEV7oZ93gX4SvfH0dNiBwW5db/DNd6RmI2uj0bcMGn153lxJBP2kzq+7oEmW8j4tY/p9rISTQjwvT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748315; c=relaxed/simple;
	bh=Yu90Q2qeuif+JQ25IQlBXrti07+lR5LahHtIV8w+GfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hfRxoTFMBejpRGg5HQWVlHaHmCqElFf8yg7pkpHeEl7vunYhV6LOYbvh0vGUOiKouZJVuIIPv0CGosxc+X9j3NeKUGmwPE2VYdc4b5DWd7xtos4+aKVs9qTl5wJM6NOlpOb0vQ57b4oUwZeQ9p0gaF/gVx69enebPQrhGSvyC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aVQVmZbm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aVQVmZbm"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6872VX1R02409994, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788748293; bh=dzpU/QIPg3opXiHn/7gPf5+nvcfiKhb83WCOOPtrRa8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aVQVmZbmi9tpBe4pTZjj6Fqmf+VjbTpnSjkkn1h4al/J2vt01MVdP3p2lip1dsx2C
	 fTrZIuFx0rDB4KDwXMNlvPltPjMJ4MvhaKkEbxy0qspxqDft5NIY+tNksZZWAJVw24
	 2rV5/sbVjvTQVEC5NU75q0qU4qT7n2MgjK5D3oeYzoHvU1XKHCJ9kYclcAD0EVrASY
	 NByWSBdGh67V/rpy3pkliniaO1Sn3y+lkcg75E7GoRJ2n97DbJseEvJBMyw0hG/tmE
	 iuDQThXPoQO3KSH/K7qK2pryX6r7cR310CSiyWPDoDOoTY1iQmAN4voennWBMLd2cJ
	 SZbDG1MUqDwOg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6872VX1R02409994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 10:31:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 7 Sep 2026 10:31:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Mon, 7 Sep 2026 10:31:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Bernie Huang <phhuang@realtek.com>, Timlee
	<timlee@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Tristan Madani <tristan@talencesecurity.com>
Subject: RE: [PATCH wireless 1/2] wifi: rtw89: fix OOB read in
 rtw89_core_cancel_6ghz_probe_tx()
Thread-Topic: [PATCH wireless 1/2] wifi: rtw89: fix OOB read in
 rtw89_core_cancel_6ghz_probe_tx()
Thread-Index: AQHdOIxRb1b3vnaWjE68iOr/Gepb47bCcHeA
Date: Mon, 7 Sep 2026 02:31:32 +0000
Message-ID: <201f792aeca14e6d8b9f2dcc3ad395fd@realtek.com>
References: <20260830143154.1751910-1-tristmd@gmail.com>
In-Reply-To: <20260830143154.1751910-1-tristmd@gmail.com>
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
> @@ -2545,7 +2547,12 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct=
 rtw89_dev *rtwdev,
>                 return;
>         }
>=20
> -       ssid_ie =3D cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);
> +       if (skb->len < hdr_len)
> +               return;
> +
> +       ie_len =3D skb->len - hdr_len;
> +
> +       ssid_ie =3D cfg80211_find_ie(WLAN_EID_SSID, ies, ie_len);

We are working on a patch to correct logic of scanning on 6GHz band, and
remove the use of cfg80211_find_ie(). I'd take the patch.

>=20
>         list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
>                 if (ether_addr_equal(info->bssid, mgmt->bssid)) {
> --
> 2.47.3

