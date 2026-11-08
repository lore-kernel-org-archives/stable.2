Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794109972;
	b=AWJXj4anc9jJeLL8z5SS1im8aGM9smZzkjMwi7HGdHERhxJTANRf7zeosWoTI//CmfwE
	 EA6jLIlaO9PHSk6jiLljvIoBDVhW2fTrqtOseqyvMsTda5j6yAktEcrcI0WTp5xzYajTD
	 pcc/5PIg7T7GliAMA9auj/0zfaomxnHJtJmVU0H7oM2d3CPKRcpSGuca2GKrLbgu/ul2s
	 JWu04Z+08GGBwA2dVdB6Rbms/T78i4AK4LK99oREdZf3zyHFVgQ6fUaA2virG/qh4xBjF
	 JuzedoPKHQY3CHTTYh/778Ik7Wc/f1BMKrOpv8R+ag4e2ZTmGr+pZLbdwMqefrkgrTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794109972;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=6+MQ2e+CW/XIn/LSBP48znWXilXVA2UuYaRCTuVEdqs=;
	b=iOsec+b6Cy/HiUSD8rx+9g7ZtYXouWIGV9bnZXmdWBLfnHRMY4zuYf/bcDuU3P5n8BZv
	 eUWr9zK38/nESuzhLMbvZxfG50GXRX5qB+8wgTDJGY/4HPg9zYTaJy2HkbEFOXzAXSx6s
	 HMrWrVHHQ+UNUpmFk+HXvxLnL2y2X0cTtF9oSlIAH/5IFRAATRbhnOZUxqZxMt8i7K8vc
	 Khup7IkfHPyp/y5gDaet4F6LCsgb2c9arCCrdYApVcGh1YNZBF5ZPD/1xH0jKEyTAbM3c
	 v9iargQ1ww8PldM+fsk/VEsICELgd2z85X4EUxpXLOfytLE+uZAnY5csqRt1gpcNwEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=DMxJnKKW;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3D0606A31A;
	Sun,  8 Nov 2026 03:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B3D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=DMxJnKKW
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A83qLaL53122185, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794109941; bh=6+MQ2e+CW/XIn/LSBP48znWXilXVA2UuYaRCTuVEdqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DMxJnKKWdu4sWt+tkvAmgf0xEh7640rTademYxhlqtkZcFVyzOkJjHN2pEICdoemP
	 DyhPZafZrSwnktxiKogyxpywwXcjBMsqL98c6f7g9eUwmuu+mdwrf5iAaLBNk/82cx
	 XWkKJ7ulNtWSeJvoKoMPt8ncRNE5IkF7SpauHZDWVvogmsxrsaKhHZihaOJQcMnKk8
	 IGdBXPM4/Fyd4ayVHzvyjv6ZHI5voEOoAQPUwcmPz5SnIJkb+HeR3tDXuhF1AbfWCZ
	 kjCL1zeeXTm24USqgTDIoEqnwd9J8nU3vzN0ZyNP9blH03Jw6JbnSnmyZ8Rk4Jqf1s
	 XHSjTcqP15QTQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A83qLaL53122185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 8 Nov 2026 11:52:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 11:52:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Sun, 8 Nov 2026 11:52:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhao Li <enderaoelyther@gmail.com>
CC: Luka Gejak <luka.gejak@linux.dev>, neo_jou <neo_jou@realtek.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>, "Hans Ulli
 Kroll" <linux@ulli-kroll.de>, Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: usb: stop RX work before unregistering
 hardware
Thread-Topic: [PATCH v2] wifi: rtw88: usb: stop RX work before unregistering
 hardware
Thread-Index: AQHdagcM28orajH85Uivj75AIag6crcjlLvA
Date: Sun, 8 Nov 2026 03:52:22 +0000
Message-ID: <b78488d51cbf4fe7923ea64b2e6f56f7@realtek.com>
References: <20261101134314.39340-2-enderaoelyther@gmail.com>
In-Reply-To: <20261101134314.39340-2-enderaoelyther@gmail.com>
Accept-Language: en-US, zh-TW
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

Zhao Li <enderaoelyther@gmail.com> wrote:
> Disconnecting an rtw88 USB device while RX traffic is active can leave
> the RX worker running after mac80211 hardware is unregistered. A firmware
> event can then queue C2H work onto a destroyed workqueue.
>=20
> rtw_usb_disconnect() kills the RX URBs but does not cancel rx_work,
> which their completions may already have queued. rxwq is destroyed only
> after rtw_unregister_hw().
>=20
> Cancel rx_work synchronously after killing the RX URBs. Only a
> successful RX completion queues rx_work, and no RX URB can be
> resubmitted at this point: rtw88 does not set soft_unbind, so the USB
> core disables the endpoints before it calls rtw_usb_disconnect().
>=20
> LLM assistance was used to find the bug and review.
>=20
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



