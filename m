Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9AE20D4F0;
	Thu,  8 Oct 2026 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422484; cv=none; b=HB/Jk4A7D8tNoXqzoQSH0C1/xFwSeCWjnPZk6ibiz+KeucAgj5+OfXFh5o3q1V9oOgqdOjzqg17s+twIJdiZPfvhuMF6RciTgbzJhzZp8QzvnTkOj365EEFnrGp7XxUg2YUrqbrv0z5WpywY1/HDIy5xAtT7yAyMbVrZ7Wntaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422484; c=relaxed/simple;
	bh=ly6BFI7Y+J+UWNSe2Ze/J2qy8AlYCVPTFhR0YgjJ794=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JRncIh7PlBiZZMQLqXPY6Z06uva37JpGZblPosoJFYdDhMsuP3nMwzts69rsZpdO40ElE0siDbA8HoSgFSeLE6oqfSr7bAqR3XLCA8UPDlv6UYg0Um5c5Eu8eRKMIocBWfk8vnpNlW87U71oWB1/0RXKYGG/MtdZ3hkfVUPXJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jzb+QY4C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jzb+QY4C"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6981KwCM2071317, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791422458; bh=LnLAAS5JBE/OAgA3IP6GATfRxde0M/zv1+1Adti8950=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jzb+QY4CGDSpZIYeJnQL8tTnuP9qZsBg/udQdL4BsLMQHVAU8FCvR9D/a0UMXG7iN
	 EYdTygJYEFGRv/+Ysd9aHgFhrmIjkaZZWbaw34AAlcB9a0sBuiJtigjtCJsR/bAh1L
	 mJYCpTxeclqPA2v3MbhoF4XucPqknejG0wj9/vslsnJUVahtBtQBc9qS+ss3+yWVT0
	 M/BBQuNYOWFM82XTT2KYrirkn2fjkx+O77eYpDpxesO0YhpOEUB9xO/zBpm//7aHjE
	 mA0mWW/DgHLrXvkod6fbATFwNGqwYh/cI31PtdR9Psk6D+VxL8fsCSCJs1pFhu1EyJ
	 UozJveSdpDoBA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6981KwCM2071317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 09:20:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:20:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 8 Oct 2026 09:20:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Bernie Huang <phhuang@realtek.com>, Timlee
	<timlee@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Tristan Madani <tristan@talencesecurity.com>
Subject: RE: [PATCH wireless v2 2/2] wifi: rtw89: fix IE length passed to
 cfg80211_find_ie() in WoW AKM
Thread-Topic: [PATCH wireless v2 2/2] wifi: rtw89: fix IE length passed to
 cfg80211_find_ie() in WoW AKM
Thread-Index: AQHdVnda/YlzD7My9U+OO5gAW1p6T7by0Kmg
Date: Thu, 8 Oct 2026 01:20:57 +0000
Message-ID: <bc87087595994f81a505385c871aab58@realtek.com>
References: <20261007161721.261452-1-tristmd@gmail.com>
 <20261007161721.261452-3-tristmd@gmail.com>
In-Reply-To: <20261007161721.261452-3-tristmd@gmail.com>
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
> __rtw89_wow_parse_akm() computes a pointer to the IE area from an
> association request frame:
>=20
>     ies =3D mgmt->u.assoc_req.variable;
>=20
> but then passes skb->len as the IE data length to cfg80211_find_ie().
> Since skb->len covers the entire frame including the 28-byte management
> header and fixed fields, cfg80211_find_ie() may read past the end of the
> actual IE data.
>=20
> Fix by computing the correct IE data length as skb->len minus the
> header offset, and validating the minimum frame length before parsing.
>=20
> Fixes: 480dd4dddfc5 ("wifi: rtw89: enter power save mode aggressively")

it should be

Fixes: 92790c4e50d2 ("wifi: rtw89: wow: parsing Auth Key Management from as=
sociate request")

> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


