Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFA37F75E;
	Tue, 22 Sep 2026 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042598; cv=none; b=sHKrM0RqBldpIq8tpXzMcrNiD1PcByuNDgJ9cYGk6GoWHNW2chqDz782EvXJXc160drLsfiWyzv07FuDApkWzoOFAQ+jUHE1GCfPRmDXuJKGieR6s/M2w9lGMpIAegPXv5qpmMkO6oOVqIRDMjPtK3hBGoLM6H/snfORK6fOpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042598; c=relaxed/simple;
	bh=6sKStPWdjMYC/nDnoTIJleWkVfL7gmdSQTTlR9jcODc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDTwY/j34345S5bsqXMpbpuZEyESDi9Py7Q9bpcCRvnenkq56SNeQEcS9y3KCLbqFxyb5KOtLCkusAnzRt/+QDsYGVrNNUjblKf7omomG8xm4fQg3CpbnTQLGm+w5U9JNy0PIPOTVbizD/QfGV1Mw3gMfCb3SSaywDHdg+D2+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uEJjfeoc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uEJjfeoc"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68M23BCZ03156700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790042591; bh=FjHE1dL1c7lSBCVZyKu5tXWihe2/df9LwgwDtAvZtKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uEJjfeocZcybzv4ywbaZoZV6NsUUHxg3aWjspa4xmUMRB4zHcjQHakxXxMMj2VOZi
	 0/xQgvdL1mkq8LM+Kk00giUEpJisg6AMa0SYDfrJv77pF0qnqiu/8GXWRljdRVOcji
	 9oFIv8WmYmcoWybOgXeOMLpfTCirpX8tY2sU04uRYNfOFphxNEU6SUwWMN/ep4Xvum
	 qlxnzpQ9j9GmRhXGmwzC2hLNQiGm2Ivey+gby7gEEKDSKcv2R6taBMvSPRgDEGUh3r
	 aZYFNgKfZwU2q7fl3Hh5Kp2Mr8e3F2uysrCi/76dZfly49LADXIFPPVnEpWAALHZ97
	 5ffPngq9LxkpA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68M23BCZ03156700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Sep 2026 10:03:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 10:03:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 22 Sep 2026 10:03:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>, Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: extend the TX report timeout to
 RTL8822BU
Thread-Topic: [PATCH rtw-next] wifi: rtw88: extend the TX report timeout to
 RTL8822BU
Thread-Index: AQHdSenJcyZ0zJutbUi+wqdx39QBULbZ2AMg
Date: Tue, 22 Sep 2026 02:03:11 +0000
Message-ID: <4c000f11b23c4920b052e8513ad28345@realtek.com>
References: <20260921165343.8131-1-pepe.schlehofer@gmail.com>
In-Reply-To: <20260921165343.8131-1-pepe.schlehofer@gmail.com>
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

Josef Schlehofer <pepe.schlehofer@gmail.com> wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wirele=
ss/realtek/rtw88/tx.c
> index 4e110a457..55d7923e1 100644
> --- a/drivers/net/wireless/realtek/rtw88/tx.c
> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
> @@ -208,7 +208,8 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, st=
ruct sk_buff *skb, u8 sn)
>         __skb_queue_tail(&tx_report->queue, skb);
>         spin_unlock_irqrestore(&tx_report->q_lock, flags);
>=20
> -       if ((rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8723D &&
> +       if (((rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8723D ||
> +             rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8822B) &&
>              rtwdev->hci.type =3D=3D RTW_HCI_TYPE_USB) ||

Hi Bitterblue,

It seems like more and more USB chips need this, let's enlarge timeout time
for all USB devices. Do you have any concern? Need your input.

>             rtw_is_8723bs(rtwdev))

Also, considering SDIO chips, should we keep original timeout for PCI only?

>                 timeout =3D msecs_to_jiffies(2500);
>=20
> base-commit: 73e3b1c94c7d5b4a113e7cbb42665dc2fe3b9d78
> --
> 2.54.0 (Apple Git-157)

