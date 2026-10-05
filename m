Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C009460;
	Mon,  5 Oct 2026 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178268; cv=none; b=pK5MoBmyg5z8dICjYC2alFZhAAhKy4SsT0Q2ZaBr826EgfSrgHH5+FyrM/Cxr6+kgqkPjzUCM+cI9FryCtJgOXlT5Z7y1BeX8rAr3Kuzt5NtXGoPliue9Lr+N3wkSqget1myvR1NFGu2MxQOoCmilNhrNGSHLNOWNTOnDcDJP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178268; c=relaxed/simple;
	bh=ZB4D+4teW5DXUeFs9cCbrVbL/WvsoSbXiBRjVLIMe/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tX35b8ePQBVZflyfPK3w5vOumol6vYnDY60iMxTns3srqZbUD+lW/I8PESPkcri51WlmDkvZYDyfLgp2JVP2Fncpq0oiKhL9Q33fRgzU1xAsG3kWakyvemt8nSGwP/PMo+iQqt070ReSc5+1PkBs04LeGqIU2CT+QcwhJl2caNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AmTzkeGK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AmTzkeGK"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6955Ufr261690584, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791178241; bh=ZB4D+4teW5DXUeFs9cCbrVbL/WvsoSbXiBRjVLIMe/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AmTzkeGKKp0fsaIJTSKZL1KXJBQQrQQRMOTH9pbQGx7Tpmk0OgyrbjXGhXRirh1px
	 SOeoCycuJ1lncQCvt+PwTx9CKpCF4Z6BGF9hogfiPpIr4qscTCeYlHpYWvFiKF5nHt
	 oaamP3UF2sl0D/Vxyz56awrUTz7BU/gn41zIjDISeyEEBmCGGQcZZia12ndSFs4bqW
	 +jDShjoixlRSnYgrVhKpia1iAD81xuqwT0VAsa6NVW0np+JBcwB43L/ILy1QiWx544
	 DOrF7Uh9wezdcGEm52D6JrevmgLWeGKaqBDbHVsOID+T1v0uXvw63kC267jUQEshO2
	 xud03HVEmwwhg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6955Ufr261690584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Oct 2026 13:30:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 13:30:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 13:30:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 5 Oct 2026 13:30:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>, Alastair D'Silva
	<alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	<ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	<kvalo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Topic: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Index: AQHdUThjHehNiw0xlkuYT1bxT/PheLbuUbcg//+M34CAAJPnEA==
Date: Mon, 5 Oct 2026 05:30:40 +0000
Message-ID: <c852aa23403e4ec7ad80a17a6dc18d0e@realtek.com>
References: <20261001000303.3505264-1-alastair@d-silva.org>
 <20261001000303.3505264-2-alastair@d-silva.org>
 <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
 <6ef33599cc268fa12e4663461248f1700969df34@linux.dev>
In-Reply-To: <6ef33599cc268fa12e4663461248f1700969df34@linux.dev>
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

THVrYSBHZWphayA8bHVrYS5nZWpha0BsaW51eC5kZXY+IHdyb3RlOg0KPiBJIHRoaW5rIHlvdSBt
aXNzZWQgbXkgcmV2aWV3IGF0IFsxXS4NCj4gDQo+IFsxXTpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNjEwMDEwNjAyMTMuMjQ3NTktMS1sdWthLmdlamFrQGxpbnV4LmRldi8NCg0KSSBm
ZWVsIGxpa2UgdGhhdCBtaWdodCBiZSBleGlzdGluZyBpc3N1ZT8gSWYgc28sIHVzZSBvdGhlciBw
YXRjaGVzIHRvIGZpeA0KdGhlbS4gDQoNCg0K
