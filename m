Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4737F8CC;
	Mon,  5 Oct 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189818; cv=none; b=PJbveaSKRQ9kZk537GmnqHnIjPK4k4uCp0EvNrxL9btOd2X2iMfBbigFo2zDbwKrgTqhqGFY8O9arNVibNyOZ/c7Xz6gMfrsWjZzbso1D33CNkYl51wRlV/O04ZtXHpXruH8mVUKT7B/8PS83fUF9fxDHe4FZyhC+BTsvuauhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189818; c=relaxed/simple;
	bh=G8WqB9t8K5Th+TAvmPbu5vgC3SraoHElAQgw5f5snIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p/jG8h4Q+KCt50dnxr5qfreHfh0pElu6JP+rKxmSSRqBcr8N9Q/alcVtcWGnUZqCRn+2iNvgmJRsJ3QaQcgxWk9NBC0H4dXzMhtq0RCROzsDxmVOs8h5XlLVNiIQBxGwyybf+24Ojp+9THxqDj6+7AGCOYdU/0GcGN88Kna4Bf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gFwOqr4O; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gFwOqr4O"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6958hB3v91783009, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791189791; bh=G8WqB9t8K5Th+TAvmPbu5vgC3SraoHElAQgw5f5snIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gFwOqr4OZUO+MyoSumVtgVC+S5c1sapFhvNwXcrMcHFaOufpBVO9Q0aKYGICzqO7B
	 4t9CYpsf9iUDVU9OakU5Dbd5mkzYM/eE03zkxM5d7G2DOnQyaH5wZlOQUy7EGCSEHE
	 GcqAIlltfSjcmm+M126qYcfjoxVlFMeVf0u/O/abA3dUC87AhczqCtFrkXz5tQ/1GN
	 nagmsQ3VODJTJeAscsizrDcfNmWYykq2eoGtLPNs8X74oyqe5riZwkuRKW1JzSwS/H
	 QmkFtBGX7R8znDuD34Mxmd3mYbxhcR4+QHo4bCwPez9Ls3eNQpXlugWqb/ICIaWwTD
	 muaOtC09WK0og==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6958hB3v91783009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Oct 2026 16:43:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 16:43:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 5 Oct 2026 16:43:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	<ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	<kvalo@kernel.org>, Luka Gejak <luka.gejak@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Topic: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Index: AQHdUThjHehNiw0xlkuYT1bxT/PheLbuUbcg///Kj4CAAIw/0A==
Date: Mon, 5 Oct 2026 08:43:11 +0000
Message-ID: <098718c80d3f4ae1b8a781d47b8dbb0e@realtek.com>
References: <20261001000303.3505264-1-alastair@d-silva.org>
	 <20261001000303.3505264-2-alastair@d-silva.org>
	 <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
 <50d48391aef50cbc4c7f9292f7467b8be17b4ec1.camel@d-silva.org>
In-Reply-To: <50d48391aef50cbc4c7f9292f7467b8be17b4ec1.camel@d-silva.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

QWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+IHdyb3RlOg0KPiBCb3RoIGNv
bW1pdHMgbGFuZGVkIGluIHY2LjQtcmMxLCBzbyB0aGUgc3RhYmxlIHRyZWUgdGFyZ2V0aW5nIHJl
bWFpbnMgaWRlbnRpY2FsLiBQbGVhc2UgbGV0IHVzIGtub3cNCj4geW91ciBwcmVmZXJlbmNlLg0K
DQpPa2F5LiBLZWVwIHRoZSBGaXhlcyB0YWcuIA0KDQoNCg==
