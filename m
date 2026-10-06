Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8042EEE8C;
	Tue,  6 Oct 2026 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791250598; cv=none; b=brco56MTiwKC8BCcQKSBNF2YDueqniFN9UtkvDgu7RfeinRUy3Ap8d25Jjesxpl5KdAFD+sM+FwKJ3xAN9haQz/9TciPOOKFQN1qClIwgC2msK7ts2ekUDnSyaubn1NUVgb63S1FZW1vlwwR6rWpNY8xvBN5Wt+XQTkt61C8kPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791250598; c=relaxed/simple;
	bh=gcLDcH4/MIbqcmfU/3c31uHe25FV2F15BkrWXnBbryg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFqvUyYQyFMManLU0WQNiOUo6sIa1l/u6/bBZ1N4bxXHIqwlaqfPAo6rWy8bMrUiVmW0drkgftHHLfbtbgsNBU02RbZOIFWkYbrDQtQYbM/42Opm5mCZW8Hx1axRY5XeKorex7b2uMert3dZwhSlQEj9+eAeEo9i1D5EtbE/tgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Yq6WFAgC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Yq6WFAgC"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6961a71i92447263, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791250568; bh=gcLDcH4/MIbqcmfU/3c31uHe25FV2F15BkrWXnBbryg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Yq6WFAgCxlHSKuaydVAvzdRj6kUVACzt/1qZSz23Th2Zs0jJ6LO005qaVPuO3QpUo
	 g/2W9cs22E4DNBnhqkDvty6Nnz5WFUJzJktlP6HRcQSHo6vSrUib5O8zIL5t/sYZoE
	 I6y4Nr4nFOl/Ffv/QJAoMHbjXJqC+1sJVpEA/yCt37MqMecLXlcgK3f0BTHFxABVve
	 hoJwLZEN6XUu19cMXIfbCZ7E7H6KHRq1677BnGRPVAoqx4/ipyaLAwZ2ckb2Z2X1gS
	 LsF5PB1EURk9a/OAwPL9TdPwQcbbbEr8pjtEY73GDaF7CqdJyShuUV4Wr4p3Qd1CI7
	 GVdWfsqWCUkdQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6961a71i92447263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 09:36:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 09:35:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 6 Oct 2026 09:35:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Luka Gejak <luka.gejak@linux.dev>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 1/4] wifi: rtw88: sdio: Handle allocation and
 read errors in rtw_sdio_rxfifo_recv
Thread-Topic: [PATCH rtw-next v4 1/4] wifi: rtw88: sdio: Handle allocation and
 read errors in rtw_sdio_rxfifo_recv
Thread-Index: AQHdVKZ9K8OfDB3J0Ei9WOsZyeMBM7bvvInA
Date: Tue, 6 Oct 2026 01:35:53 +0000
Message-ID: <e376378c5c534ba995b6890f5bd3abfb@realtek.com>
References: <20261005084849.3109337-1-alastair@d-silva.org>
 <20261005084849.3109337-2-alastair@d-silva.org>
In-Reply-To: <20261005084849.3109337-2-alastair@d-silva.org>
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

Alastair D'Silva <alastair@d-silva.org> wrote:
> When dev_alloc_skb() or rtw_sdio_read_port() fails, rtw_sdio_rxfifo_recv(=
)
> returns without reading data. Because it returned void, the caller still
> counted rx_len against the loop budget while leaving data stranded in the
> FIFO.
>=20
> Return an error code from rtw_sdio_rxfifo_recv() on failure and break out
> of the receive loop in the caller immediately.
>=20
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

