Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F8306768;
	Thu,  8 Oct 2026 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422895; cv=none; b=G7vTwUjB0MvUkk0nq4NmVbg/BA66Xq+c5QYBe1yHaM+dSMJpe8eLKDuH+WatEEV0mq9Y69rpCI1QWxyw/96+l3g2WMwg8slm8g/GjIQy+uUfAS1YVPRxBIvXhNTvQuIMJQ1L16tzKlNjcXLuUKCrxntqRWgUjd1A5V07Qf84t4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422895; c=relaxed/simple;
	bh=0i/Q45BAHtk1SGbstgQ+fgF4wcI9oEQolU0fiiWOnsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tcfaq/BVDKE1Y0q08S8N1shzh+pcfh78cplI/nx3IYyPbc2REMpYTUHkaaZfoQhElUb791WZPnTPpBBEztjWI8W7FSzfFvaDcljhbX4g2T+m1mS8EIOYasGdoNxnV+EtjRvQsMnWLiWy0h16dpKRV+XQUkcz6nCB1iklCE6myZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=L+pRrpfa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="L+pRrpfa"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6981S1jvC074716, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791422882; bh=zNWW0rZpoxZbcO0wO4Y0b53dr78WRP0MWi7x7lKBpFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=L+pRrpfaD8gLsieA4Z8uuTb2nc5C09BQ7dJRIJHsha0VE9lN8BtJi9iPMK9IZKF+q
	 CMf+l3uRTGWOq0N9gfVlTbP5nQ58t6FMlb3HRuIFEALXh39uoH1Ot3USeDNt5oVimk
	 phs6Gc9yNG8agdm/kQ1iVLTKTrb8UtCOJo23SrbN+9rSxSbJR9YVjDFY3f5MZ52e9X
	 NgVGQccrIpk16tKZRsv0TDTAMMFgC0opNIDpmgHvY2j1GQ+NuiHU29G+AChB/jRkiw
	 CgzDPgS52ZZL5bacZyYkMfRXEGbfPv3kJsOkiTdoJFtYRW0ISwtUl8pfT2eRgemgVW
	 nziFDFUBJnNeA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6981S1jvC074716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 09:28:02 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:28:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:28:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 8 Oct 2026 09:28:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, Nick Morrow <morrownr@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2] wifi: rtw89: usb: shorten the RX aggregation
 hold on RTL8922AU over USB 3
Thread-Topic: [PATCH rtw-next v2] wifi: rtw89: usb: shorten the RX aggregation
 hold on RTL8922AU over USB 3
Thread-Index: AQHdVqA7ValSLRsbmUeDytxruIYp87by2c7w
Date: Thu, 8 Oct 2026 01:28:01 +0000
Message-ID: <365ec643cfba4fa697bb4558a235d078@realtek.com>
References: <20261007210958.56528-1-lucid_duck@justthetip.ca>
In-Reply-To: <20261007210958.56528-1-lucid_duck@justthetip.ca>
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
> On USB 3 that adds up to a millisecond of round trip, and under load
> at 160 MHz the access point drops to lower rates and download suffers.
>=20
> Shorten the hold on USB 3 only. On USB 2 the bus is the limit, and a
> slow host needs the long hold to keep up.
>=20
> RTL8922AU on USB 3 at 160 MHz, power save off for the round trip:
>=20
>                          x86, 6 GHz    x86, 5 GHz    Pi 5, 6 GHz
>                         before after  before after  before after
>   TCP down, 1 flow        613  1002     579   948     587  1010  Mbps
>   TCP down, 8 flows       656  1187     629  1080     605  1122  Mbps
>   round trip             2.33  1.29    2.25  1.18    1.42  0.84  ms
>   busiest core, UDP 200M  8.4  12.8     8.3  12.9     2.1   3.3  %
>=20
> RTL8922AU on USB 2, Raspberry Pi 1 B+ at 5 GHz, 80 MHz:
>=20
>                         long hold  short hold
>   TCP up, 1 flow            102.3        87.7  Mbps
>   CPU, UDP 20M               50.5        77.4  %
>   loss, UDP 50M               3.8        85.7  %
>=20
> Fixes: 32cee8a9bb66 ("wifi: rtw89: usb: Enable RX aggregation for RTL8922=
AU")
> Reported-by: Nick Morrow <morrownr@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

>=20
> Small-packet mode is at the link below. It sets both the hold and the
> size to 1, and nothing in that driver selects it.
>=20
> https://github.com/morrownr/rtl8852cu-20251113/blob/fcb70aac55585a8e63c72=
da4e6d24c39d7494307/phl/h
> al_g6/hal_rx.c#L805-L808

Thanks for the info. I quickly check the internal commit log that people wa=
nt
dynamically select the modes depends on RX conditions. I think the actually
selection might be only existing in special branches.=20

Let's take this patch in advance. If you or other people can fine tune=20
the threshold by certain conditions dynamically, we can apply the patch
in the future.

Ping-Ke

