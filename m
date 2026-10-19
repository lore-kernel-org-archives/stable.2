Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533993C1D70;
	Mon, 19 Oct 2026 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392290; cv=none; b=DXqFDaVjPYoOl74S2/YLV+uqS2N8NSs5vXYZZtOubHoQueHFtooNsWOBr0kGwnt2w/uM++bgHsmW+cvJRrhnt48KjY6BL23VdBhg1NcxEIdSKUpbuYF8LGzrovba5zOE33hSRxzj6yVKLs7IRPq2pCyzL7Dgx7oYplbtLIFJLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392290; c=relaxed/simple;
	bh=brmz6Ugg4+Wssx/Cd5pn3XoUG5aERwRrLt35+dX+2+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tbqm78YT3eizOimRPI2huRzidWkctUzBLON/CU/9LxLtcClMfTt2ROxarMU5aXCTJo+eSle0KLsPCE962qT6DX1plmCS8nJE+LhVObakeau8P/pbyFQjwnNWG87n5SRSQLO2uh/N3/yVUHYfuYcFU1V3kpx8XxWhiyWiFbVmy0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=njh60DzA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="njh60DzA"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69J6iVrC51650305, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792392271; bh=q6toGPiAhl8lDOX+lhOHl14TFZGbmZsm49q0x+8+nLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=njh60DzAekDUzBK+GACdM51ajV+ugDA+4nyS0AYILHp2PnqW8LpA2u4amEDLWOqvr
	 +mo2ODTs1e1HF1RU8b04UtI+hkYEh98cVj6IbdJwNUmNZr3tjMYV97GOHfqL/0eN1A
	 hg1uXNeoJ69HQ9OSKWOrDKTr0WqT+AyfJeYrPr/Y27/WcQSwA3Eza49vqNp/Y3Ug4W
	 eW+XVl1ir4g5Ptu3/qSnF/HfM5wA05QT+49IYqkUJ/Mcl/sfOvEoWFdkqP8iqYYAin
	 hjeI26tfghl++xxE8uqnyV6yh3pPvVQjr5agZHH9EIq7TeqmvZJouiWcRel/M6oQSX
	 xD5ARN+VliSCA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69J6iVrC51650305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Oct 2026 14:44:31 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:44:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:44:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 19 Oct 2026 14:44:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Bin Yu <byu@xidian.edu.cn>, Cheng Wen
	<wencheng@xidian.edu.cn>
Subject: RE: [PATCH v2] wifi: rtw88: usb: drop RX frames received before the
 device is started
Thread-Topic: [PATCH v2] wifi: rtw88: usb: drop RX frames received before the
 device is started
Thread-Index: AQHdX5TFSpeU6nUm5Ei39SmkeDvplrcEa1HQ
Date: Mon, 19 Oct 2026 06:44:31 +0000
Message-ID: <128f18dd67cf4848bb22209f290e33c8@realtek.com>
References: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
 <20261019064000.5167-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261019064000.5167-1-25031212351@stu.xidian.edu.cn>
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

YuanZhe Liu <25031212351@stu.xidian.edu.cn> wrote:
> rtw_usb_probe() submits the bulk-in RX URBs at the end of probe, right
> after rtw_register_hw(). A device can already have data queued on that
> endpoint, so rtw_usb_read_port_complete() runs and queues the frame on
> rtwusb->rx_queue before any interface has been brought up. Submitting
> the URBs late does not close that window: the frame can arrive as soon
> as they are submitted, which is still before the device is started.
>=20
> rtw_usb_rx_handler() hands every non-C2H frame to mac80211 without
> checking whether the device is running, so ieee80211_rx_irqsafe() runs
> while local->started is still false. mac80211 treats that as a driver
> bug and warns in ieee80211_rx_list():
>=20
>   WARNING: net/mac80211/rx.c:5601 at ieee80211_rx_list
>    Call Trace:
>     <IRQ>
>     ieee80211_rx_napi
>     ieee80211_rx
>     ieee80211_handle_queued_frames
>     <TASK>
>     rtw_usb_rx_resubmit
>     rtw_usb_setup_rx
>     rtw_usb_probe
>=20
> The frame is dropped by mac80211 anyway, and because the URB is
> resubmitted from its completion handler, every further frame repeats the
> warning, which floods the log until an interface is actually started.
>=20
> rtw_ops_tx() already drops frames outside of start/stop by checking
> RTW_FLAG_RUNNING, which mirrors local->started: it is set at the end of
> rtw_core_start() and cleared at the beginning of rtw_core_stop(). Use
> the same check in the RX path and free the frame while the device is not
> running. This also covers the opposite ordering, where a frame that is
> still queued in rtwusb->rx_queue is handed over after the device has
> been stopped again.
>=20
> C2H packets are left untouched: they go to the firmware event queue
> handled by rtw_fw_c2h_cmd_rx_irqsafe() and are never passed to mac80211.
>=20
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



