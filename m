Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4BC3AB260;
	Wed, 29 Jul 2026 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307979; cv=none; b=Xs9Aii2D/c3134yXKnOT9k5wnEzsO3WipOkBcVd5TcgUjNHIUXk+kQkYbf7pkarDWIP8EtzmJWa/Hl25V12qkjJSy/r5xhGwV6j8hznD67qTppJU/QVa43A7POeTQtjJwYM4dZ09SP9W0GWNwscjY2nCpLdvJAI0CKu8cPa9DP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307979; c=relaxed/simple;
	bh=x7RZQvvPvxXbMfuXWGrKVps+LeWW4nbQZ2SLee/v/eE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdrUdbsA1fIdvpFyVyYh/mMtQvmfQn6D35cjLtu4fbeAzqO/xRiBDaPtiiBNdk0EhZMioWCTaV1trWyKXjmZ5KjH62EGe3KiIJXvcpJ3IMlppki2WUQH/pGiYZB4ke4Y0WN6He3UXqPut9EgYurpnNcFZJUAVB9CQ7as1GN6SoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vcN10VWz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vcN10VWz"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66T6qpdZ7254779, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785307971; bh=WHRWHJD3QHcEEMI+e56YiNfInwYHe63bnjzMDvKJAg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vcN10VWzo4j5oBnmRtzLZGpZZVUi8a7bDrJpac6AmpWBsoPhqIAjOqTQpDIO5xvFb
	 2G56FDIQQTnOBQsmJ8PELdxEB86ujkdsePRDFXvwKfY/vZ8WaiPlPwYR3FileewLWs
	 sSWq8q4SXJe+6FIXvRo1uftn24b60wV1NUOntx7lalLgMjdytQZJQSCHJbjscQCOY6
	 ojkjSjSrm2n0TNfUhZQE13THzV2x4tB+AEUcjXJTREJO/2guinA86Guoyylf+Cht3W
	 q+JIcIXY9rUUX6WWXYCtqWU1Dc4pcMq2nvgOicvYQCxHvjjafCpzt9WaI+QwdmFrEB
	 0w/sVsWAYGGxw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66T6qpdZ7254779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jul 2026 14:52:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Jul 2026 14:52:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 29 Jul 2026 14:52:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "yhchen312@gmail.com" <yhchen312@gmail.com>
CC: Damon Chen <damon.chen@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: pci: add .shutdown callback to stop
 rfkill polling on reboot
Thread-Topic: [PATCH v2] wifi: rtw89: pci: add .shutdown callback to stop
 rfkill polling on reboot
Thread-Index: AQHdHvt1Pu/352P+/U6+Mc52K++5r7aED6Yw
Date: Wed, 29 Jul 2026 06:52:51 +0000
Message-ID: <1c11e1e5c94b4a80835df4c5bafb55ea@realtek.com>
References: <142c91dfc7334136a5dabc4f91504ec6@realtek.com>
 <20260729014142.2746777-1-yhchen312@gmail.com>
In-Reply-To: <20260729014142.2746777-1-yhchen312@gmail.com>
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

yhchen312@gmail.com <yhchen312@gmail.com> wrote:
> From: "Yuhang.chen" <yhchen312@gmail.com>
>=20
> Since the hardware rfkill polling was introduced, arm64 platforms can
> panic with an asynchronous SError during warm reboot:
>=20
>   SError Interrupt on CPU8, code 0x00000000be000011 -- SError
>   Workqueue: events_power_efficient rfkill_poll [rfkill]
>     rtw89_pci_ops_read8+0x94/0x160 [rtw89_pci]
>     rtw89_core_rfkill_poll+0x50/0x1e0 [rtw89_core]
>     rtw89_ops_rfkill_poll+0x40/0x68 [rtw89_core]
>     ieee80211_rfkill_poll+0x3c/0x70 [mac80211]
>     cfg80211_rfkill_poll+0x40/0x2a0 [cfg80211]
>     rfkill_poll+0x30/0x88 [rfkill]
>   Kernel panic - not syncing: Asynchronous SError Interrupt
>=20
> On the reboot path the kernel only runs device_shutdown(), which calls
> each driver's .shutdown callback; .remove is not invoked.  The rtw89 PCI
> driver had no .shutdown callback, so nothing stopped the rfkill polling
> work while the platform was tearing the PCIe link down.  Once the link
> is gone, the next MMIO read from the poll handler targets a
> non-responding device and is reported as a fatal asynchronous SError on
> arm64.
>=20
> Add rtw89_pci_shutdown(), wired to all rtw89 PCI device drivers, which
> sets a new RTW89_FLAG_SHUTDOWN flag (mirroring the USB
> RTW89_FLAG_UNPLUGGED pattern).  When the flag is set,
> rtw89_ops_rfkill_poll() returns early, so no MMIO read is issued to the
> chip after shutdown begins and the SError no longer occurs.
>=20
> This does not call the full .remove path from .shutdown, to keep the
> shutdown handler minimal and avoid running the non-idempotent teardown
> twice.
>=20
> Fixes: 0b38e6277aed ("wifi: rtw89: add support for hardware rfkill")
> Cc: stable@vger.kernel.org
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yuhang.chen <yhchen312@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


