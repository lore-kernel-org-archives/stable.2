Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3122157B;
	Wed,  7 Oct 2026 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791340313; cv=none; b=uF1nQUwqoTxo/t8e2DEitgnX9HKshsbmcGuBWynGrlSTbmEPXHiL95DK2IXW/9c+xe8xQVL55ngAt/9x10Vxgo4UtBuAG3cmUU783wUB7/C9RM4HV8G8iWBvQPXg9BpJAw56kqMG4a8ThM12DlOaY2Ohkj0wNzAs7ZrUGx/6gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791340313; c=relaxed/simple;
	bh=RWCrne7Kk1ulz7DBV5OOYrWoI2P0LZHXia1smq1H+H0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HSCofA7Np0YbvamAjyx2jVpThv/tWaEf9eTw/CvCQqvG4ED/HO3GCvRGpArDq00VqclEJWLPNoHU8QFEtC+X4+vlKvBf53teWTNC6VH4KPyOcNUpejAuXVYjXsXn6PBqkqLPXLrmtdZ9hOJGLB5bwqvjnHVLlj3kSPU8qBjWYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rKnoYzGi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rKnoYzGi"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6972Vd5H23465184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791340299; bh=U8IpDLuXGHqIJEqKxAV6k/3Dtp16wkOUMCLPBb2C/f8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rKnoYzGiaF+7yvXLv6Bv5GTNXM2auTSBUEZMTM/CuIIMSq//HrEc0gnx1f9y2+YHe
	 Klf+o1lPQpzV08vzFaV642EHgFsd/CCc55acLeIkKCVYGV9Dx/VWScGQ3Du5xx2MSa
	 ZHMDLmPJkBxanucthhCHWISq6r9GTf5TBOSmGhqrQ11LIFfMZ2bgFUJ7eeys9E0Hah
	 RmBE7CowhJNzsLkaOf2lYstObJYFjNtsvicQELeLBjeyHmWPsPgeoMUllLS1TpwL5z
	 A3E+ZAIxu52RLtrlfiY3MuGuOxRBXCvSo7cdCf114bFkDwwucSi/akTJ2HHAAjDgm4
	 lCqkx3QFqmFYQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6972Vd5H23465184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Oct 2026 10:31:39 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 10:31:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 10:31:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Wed, 7 Oct 2026 10:31:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, Nick Morrow <morrownr@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw89: usb: shorten the RX aggregation
 hold on RTL8922AU
Thread-Topic: [PATCH rtw-next] wifi: rtw89: usb: shorten the RX aggregation
 hold on RTL8922AU
Thread-Index: AQHdVcXLhUR7pyplckCU03EB/o2Zj7bxVR7Q
Date: Wed, 7 Oct 2026 02:31:24 +0000
Message-ID: <ab97da288acb477e91484f1461632b26@realtek.com>
References: <20261006190618.258037-1-lucid_duck@justthetip.ca>
In-Reply-To: <20261006190618.258037-1-lucid_duck@justthetip.ca>
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

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:
> The RTL8922AU holds received frames for up to a millisecond before
> handing them to the host, a value carried over from the RTL8852CU.
> That adds up to a millisecond of round trip, and under load at 160 MHz
> the access point drops to lower rates and download suffers.
>=20
> Shorten the hold on this chip. Upload is unchanged, and so is download
> on a USB 2 port, where the bus is the limit.=20

Can I know the number of USB 2 port? Just curious, not blocking item.

> The cost is some extra CPU at the same load.

I think the major reason people want RX aggregation is that a chip is
operating on a low-end CPU.=20

>=20
> RTL8922AU on USB 3 at 160 MHz, power save off for the round trip:
>=20
>                          x86, 6 GHz    x86, 5 GHz    Pi 5, 6 GHz
>                         before after  before after  before after
>   TCP down, 1 flow        613  1002     579   948     586   999  Mbps
>   TCP down, 8 flows       656  1187     629  1080     605  1108  Mbps
>   round trip             2.33  1.29    2.25  1.18    1.44  0.88  ms
>   busiest core, UDP 200M  8.4  12.8     8.3  12.9     2.3   2.8  %
>=20
> Fixes: 32cee8a9bb66 ("wifi: rtw89: usb: Enable RX aggregation for RTL8922=
AU")
> Reported-by: Nick Morrow <morrownr@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> Ping-Ke, Bitterblue pointed me to you, since the 32 came from Realtek.
> Realtek's 8852CU driver uses it as the default and also has a
> small-packet mode that sets the hold to 1, the value this patch uses.
> If the longer default is there for a reason these tests would miss,
> please let me know, thank you.

I can't find small-packet mode you mentioned, please share a link.=20

As I know the reason of longer default can benefit low-end CPU.=20
By the way, the TX aggregation is pending, because our experiments
show no gain after the patch, so I don't send the patch. That means
current platform is much better than what years ago.

Ping-Ke

