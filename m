Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A41F63D9;
	Tue,  6 Oct 2026 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791252374; cv=none; b=GCxpMK7XkvHXkj5hoRNMzVZ9GIgyYIRnBFld8Z7FtF6vXy6KGp9ZpvcuTFH7Tx0E2pqsJTd17ESznTOsdM/azb2URfeXLxAHGHf2llNi98KRXMBV2z9SSQ2ZGnLMa9bUSFUkxWzNqdq3Jgu0LUe5PIo6v4Z+NC+06cRSdo0B4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791252374; c=relaxed/simple;
	bh=+VNC3tGI5gjA1gVGpucnQBUir6Ag+84zGG5Pvhilf3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFoN1lv+iK8QwViE6NO5PHS7RV9xSDVTyGETRgMS6mTZmyQ0EYwRz8zTlcTbRJYL4qSNz8HJt4ftiU7sfHY7xfaIyyyQywHNHZt7JDA2s4xCqOJx6HFo+MDsnIE7Y4i7wC4uwbzDu4ZZSnjPU0ViWlLhAIje5wBE4sjD9iFjPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KZbVYZbO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KZbVYZbO"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69625lM022461081, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791252347; bh=zrARIFLPTpKyiMUrsr4CRAeQgwU57lbyuLUZr8wFi1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KZbVYZbOaQ2JSCzSnBBgKhuRpJIwdzrODpyqpJaIfSsHWe4VDFlNLPN1VqLPl10wf
	 ml/sSaMnSkh1ddD5RUDzCv1u3jh921pM9qcIYUbZBrU6lA4lTh24pOcY9v8vHZtuEu
	 D/V7YbpwttK4/cehEvXmMRxE3ngKMD5ii08fcufuuSIHykbsZAfM75fr8IxDook5KE
	 vqvLxclbX1Ya1nsnb6qLDL/YCrvluf4W1CouS/teErMckT4NVn6qRefkk8P6ZBFLBT
	 FByVX9YV8fpRoIS2Kcgxkc+H7I3h8C+E3b01bgkGO5rlYeZ06W/OXbqhkvanBvBEex
	 4Z9rkUsWR1tJA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69625lM022461081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 10:05:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:05:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:05:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 6 Oct 2026 10:05:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Luka Gejak <luka.gejak@linux.dev>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 3/4] wifi: rtw88: sdio: Fix unhandled RX
 request interrupt storm
Thread-Topic: [PATCH rtw-next v4 3/4] wifi: rtw88: sdio: Fix unhandled RX
 request interrupt storm
Thread-Index: AQHdVKaFGpmA7OCHDkKW5a8Cyqr61bbvxOWw
Date: Tue, 6 Oct 2026 02:05:47 +0000
Message-ID: <0b69a0e2d5b246f4a576640c07b8172b@realtek.com>
References: <20261005084849.3109337-1-alastair@d-silva.org>
 <20261005084849.3109337-4-alastair@d-silva.org>
In-Reply-To: <20261005084849.3109337-4-alastair@d-silva.org>
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
> +static void rtw_sdio_handle_interrupt_3081(struct rtw_dev *rtwdev, u32 h=
isr)
> +{
> +       struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> +
> +       rtw_sdio_disable_interrupt(rtwdev);
> +       rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
> +
> +       if (hisr & REG_SDIO_HISR_TXERR)
> +               rtw_sdio_tx_err_isr(rtwdev);
> +       if (hisr & REG_SDIO_HISR_RX_REQUEST)
> +               rtw_sdio_rx_isr(rtwdev);
> +
> +       /* Unmasking HIMR re-asserts the IRQ line if new packets arrived =
*/
> +       if (rtwsdio->running)

I think here needs a lock

> +               rtw_sdio_enable_interrupt(rtwdev);
> +}
> +

