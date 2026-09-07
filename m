Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25730BB8A;
	Mon,  7 Sep 2026 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754944; cv=none; b=GpYv6QJ4NqZWqkWIrEK7LJDBj5UOapdGKlBCtXZy7nHPo1bh/M1o+hkv89QWwuHvSRLmLc3tSvTYG49+ZA2mh3RCq8xQGgkDoOyIWfvslhW0EuoCnP9h/nk2kuByZUA2PJLvvKHK3kAJrLaqRYfMqaQZHU1Ut8i1mZbzzvBzsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754944; c=relaxed/simple;
	bh=TfrQiX8YZNxgZbMz4/4/O7f0zbDCeGDID9CQJq+qOM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fiuFUDlvu+1VjN9761/sAcqfL0P5XgbJP8vg99QkGCkV1j/MT//NDxDVWXcKskBSBR02EL2UqqG7llFnkuN/Ora+SLA+31ZPObbDOQmCrQlFThNsP0fXia1vz7rGiBQkMdz+wGvhMw/DESRg6XXvG/Wf4qDEodwrieGr4nChlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ROqQxj64; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ROqQxj64"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6874M5Eg82478183, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788754925; bh=qpcmFgFALTtrJUTS/1k/LqdUuaR0ns9ck5KXZq5JDx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ROqQxj644PraYMhXmCOqw4vkdrb2qNLLZNVzEy7sQ7MD0pP14+PTwiGu9BS65oyyC
	 J6hCwEhTqYkaMGDPIPRq7X6V/7HQqjzhnBwDhspwGEgCp2+1OskKfrrwnDlwCwzwEj
	 Qs11kBC1hft3A5aUkRFr9dsnRzvbZERg1Wi578hMw0OCiXsdckI7TjkT6CU5/ne0SX
	 72ILTjvvP5cTOa/Z4jtaYRqZisaitZCdT0K4jBriT6afPGxEH4Imcap9VO9LUMNgbw
	 onSeZljMNGOvgKIgZ32/aTaRSqeMNVx9ivIlvGs0Nz3+h5qIffzkQxIp0kAjbqdq91
	 YeToUPeD0IRoA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6874M5Eg82478183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 12:22:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 7 Sep 2026 12:22:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 7 Sep 2026 12:22:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Mon, 7 Sep 2026 12:22:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tristan Madani
	<tristan@talencesecurity.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH wireless] wifi: rtlwifi: fix OOB reads in IE parsing
 functions
Thread-Topic: [PATCH wireless] wifi: rtlwifi: fix OOB reads in IE parsing
 functions
Thread-Index: AQHdPEpfInXUMvtYbUS4tyy0zwRr1bbCgA9A
Date: Mon, 7 Sep 2026 04:22:04 +0000
Message-ID: <2bcd6795858e4796b4c5be09a667ad2c@realtek.com>
References: <20260904084940.3885379-1-tristmd@gmail.com>
In-Reply-To: <20260904084940.3885379-1-tristmd@gmail.com>
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

[...]

> @@ -2597,17 +2597,17 @@ static bool rtl_find_221_ie(struct ieee80211_hw *=
hw, u8 *data,
>=20
>         pos =3D (u8 *)mgmt->u.beacon.variable;
>         end =3D data + len;
> -       while (pos < end) {
> -               if (pos[0] =3D=3D 221) {
> +       while (pos + 2 <=3D end) {
> +               if (pos + 2 + pos[1] > end)
> +                       return false;
> +
> +               if (pos[0] =3D=3D 221 && pos[1] >=3D 3) {

I think the 3 is because length of OUI is 3 used by rtl_chk_vendor_ouisub()=
.
Please leave a comment for that reason.

>                         vendor_ie.length =3D pos[1];
>                         vendor_ie.octet =3D &pos[2];
>                         if (rtl_chk_vendor_ouisub(hw, vendor_ie))
>                                 return true;
>                 }
>=20
> -               if (pos + 2 + pos[1] > end)
> -                       return false;
> -
>                 pos +=3D 2 + pos[1];
>         }
>         return false;
> --
> 2.47.3

