Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080214;
	b=SFOv1rRfL2DgTPozxTtKEhX17/OhkfzPr6kD1HJGQWTur/OGKmYX2JfXq5FIf6pMylxK
	 3o/QSrK7u1Ag87rZDBFhDl7DQZ1dZPP03ljTTJ86OZTecSIUB2UeoZyUc4apNANp9B/fN
	 yMh4CRzhN3VTT6PxENINxHBxiPinXF5rt/wSAm0HDv7oODU+DTWMvgdI8V4ST4twCad01
	 xqbpebBDnjf+bb0wXKJzLl9W5djFTdRzvwSYrkOSwLIeBMmmXEX/edfPDVCKb8WrB0IwS
	 2O8GWhi3T8y/dv05XuiPYqQPG0M6hGy+Z++bQXuE+u5xhi4X8pbWtl5bcZ4F4slfUlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080214;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=dH+1qS3r3/qThoPs/bcfpRZ8WDJsMNF5jVHZIGMNezg=;
	b=c3zqUQRpR0fNFEr8UtAd1TPSNqp2dJ6riv2P1n2Uj8+BikKBfi7WGXy9PnOuQMUnPRZw
	 aZBmqmPHY4vB9KDc/YWsKm2sgVTs3O8hNNzxaAbtRaiTOV2GQ8CGcfISauP1kuvA7PfDt
	 cA8chfBdMuwUaNGDsFvaDzMrSo9ttpnRmcUFyqFRNelHh2gN4h2Qe53i522Sq5UT5DFK4
	 +82esOhryj3t9ap+9Lv8poXGIMcw9KqHC0kUS6PmMtROhmhv0YAJHrLWKeE3/aTlSzKLK
	 gZQwcbSWbzROteySkj/cmPAyod0DOXd0vKPwpE9NEEL7dEJDaQIEQoFy5sCaOkCkpmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=VN52ouDJ;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EA606A327;
	Tue, 27 Oct 2026 05:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A9EA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=VN52ouDJ
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69R5nWhqD701598, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793080172; bh=dH+1qS3r3/qThoPs/bcfpRZ8WDJsMNF5jVHZIGMNezg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VN52ouDJwmzTdlQG+++aCY8axAkumQe6RJ9XGHpLcMPAjjDdLbZiYxgtuctwNTLXx
	 TAOO+unwUfOeir/gNyfNih1EwJdaubbdduk5atv1ufvygNAvcthcnKdyS7B+l59Qz5
	 8tNB2ihWBOAUCNkhqbdxxqZ89JF0hrsXm7VQMmlgfDnlWzy0gQ4H6lBTvqygdD9seQ
	 yCgKK9Nnc6QgnZMji7BMZVe8RtmZEALvoGJgO9PlU0jt1omvh/Jd8NIHTj9vafwMjD
	 j1hKjWYcjP393Ji+eXKtpOb8RCAJCIP7/AcLYwJR80GbVy3z0In0W7r+ZWqNHjj+uU
	 tnLZobeY4LRnA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69R5nWhqD701598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Oct 2026 13:49:32 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 13:49:33 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 13:49:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::f36f:a844:4916:93f2%9]) with mapi id
 15.02.2562.049; Tue, 27 Oct 2026 13:49:32 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Linmao Li <lilinmao@kylinos.cn>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: nic_swsd <nic_swsd@realtek.com>, Chih Kai Hsu <hsu.chih.kai@realtek.com>,
	"mail@birger-koblitz.de" <mail@birger-koblitz.de>,
	"zhangxiangqian@kylinos.cn" <zhangxiangqian@kylinos.cn>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v3] r8152: Use BMSR to detect the link state
Thread-Topic: [PATCH net v3] r8152: Use BMSR to detect the link state
Thread-Index: AQHdZOi1SWakue5+fUmL1fScAZd2QbcQ421w
Date: Tue, 27 Oct 2026 05:49:31 +0000
Message-ID: <65b2cd5e124a4fee9eb5b013e4069e44@realtek.com>
References: <20261026012345.1902285-1-lilinmao@kylinos.cn>
In-Reply-To: <20261026012345.1902285-1-lilinmao@kylinos.cn>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Linmao Li <lilinmao@kylinos.cn>
> Sent: Monday, October 26, 2026 9:24 AM
> To: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@kernel.org;
> kuba@kernel.org; pabeni@redhat.com
> Cc: Hayes Wang <hayeswang@realtek.com>; nic_swsd
> <nic_swsd@realtek.com>; Chih Kai Hsu <hsu.chih.kai@realtek.com>;
> mail@birger-koblitz.de; zhangxiangqian@kylinos.cn; linux-usb@vger.kernel.=
org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; stable@vger.kernel.=
org;
> Linmao Li <lilinmao@kylinos.cn>
> Subject: [PATCH net v3] r8152: Use BMSR to detect the link state
>=20
>=20
> External mail : This email originated from outside the organization. Do n=
ot
> reply, click links, or open attachments unless you recognize the sender a=
nd
> know the content is safe.
>=20
>=20
>=20
> r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
> BMSR_LSTATUS can remain latched low after link up. Since
> commit f6f2e946aa4d ("net: mii: Fix the Speed display when the network
> cable is not connected"), the first speed query can then report
> SPEED_UNKNOWN, which applications such as NetworkManager may cache
> until the next carrier change.
>=20
> Use BMSR_LSTATUS in set_carrier() so a latched link down can turn
> carrier off after the link has recovered. If BMSR reports down but
> PLA_PHYSTATUS reports up, reschedule the link work to read the current
> state without waiting for another notification.
>=20
> Tested on an RTL8153B: NetworkManager reported 1000 Mb/s after 3 of 3
> rebinds, instead of an unknown speed.
>=20
> Fixes: f6f2e946aa4d ("net: mii: Fix the Speed display when the network ca=
ble is
> not connected")
> Cc: stable@vger.kernel.org
> Suggested-by: Hayes Wang <hayeswang@realtek.com>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Reviewed-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes

