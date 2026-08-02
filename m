Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64427175A66;
	Sun,  2 Aug 2026 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785634100; cv=none; b=Wd/v65upPbStM0r5ZgrqbULFFzRpLrgVA31Oh1YyMY2HZCz+A72mCpzUtD+oo4DmD9F3O9L9o7nimzYylcxuHKBXAkt0UlMjbN8Pv8S2hXri2jIVO9SYyGKU//ZB+Uvgs8u0ZsqU+z6HsulrKq0JEIhwHf9GjUZBbP6FGO1+c9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785634100; c=relaxed/simple;
	bh=Yi+Oej9r/P7K4bv9FV9oR/2NoM/m1xuG+lJvVeUUpo8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=ce+jXzVdh7o5s8XA5b94RYIkylbUj+vbHP0xzrRP9ujZKahzhnjuRgyZFf/UPMq1aFukzM3UGAc+q+WbKsDKenx7ZsGkUpsCpH/ov4wUbRxcwsVV0nKb8z/MCRv9r6O4pQ8Nbjw6clkB7pwI1Wqr5cXc2lNWNorXSxB9prWhRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BEQeg2gO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BEQeg2gO"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6721SDlwC3071857, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785634093; bh=UF9nXiNm5CIOQPIgSeTG8Q2938fIs4gTdxleTHAdwOY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=BEQeg2gOhfATmKVMqPKAFeeKFDyZgMXyRyZhSIsodN29jjlv8RFiRQW16cnbfxrgj
	 Xqkb/1X+Wh3r2fTPWOGZCXdv8HYYHOj4V7iB5p4DPgZhe9FSBYApkrB3RrJGj4buD9
	 EfxJLqAGpXRdP8uJMXzAfVFI1G7yDd6tZV9Gsl4Hj1MMQQB2/XyYL8CVFgNF/qOiPu
	 JRvljbrSVOfJjYxiNNsM2TIT6trsRPiNfl5+PkKN7+qV49FTCP1RrAldTSMGOeIvhi
	 ggyxMah0EzQdjPh5K8THVUeaUCqMqhaOjBpX8MDPbQHGEPU4B5kzRFsehEGJYsM9bA
	 ePbDP8dqLLcsA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6721SDlwC3071857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Aug 2026 09:28:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 2 Aug 2026 09:28:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 2 Aug 2026 09:28:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 2 Aug 2026 09:28:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <yhchen312@gmail.com>, <pkshih@realtek.com>
CC: <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuhang.chen <yhchen312@gmail.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot
In-Reply-To: <20260729014142.2746777-1-yhchen312@gmail.com>
References: <142c91dfc7334136a5dabc4f91504ec6@realtek.com> <20260729014142.2746777-1-yhchen312@gmail.com>
Message-ID: <2f9366ea-d5c1-48fe-9bb7-ad7ea5520c37@RTKEXHMBS06.realtek.com.tw>
Date: Sun, 2 Aug 2026 09:28:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

yhchen312@gmail.com wrote:

> From: "Yuhang.chen" <yhchen312@gmail.com>
> 
> Since the hardware rfkill polling was introduced, arm64 platforms can
> panic with an asynchronous SError during warm reboot:
> 
>   SError Interrupt on CPU8, code 0x00000000be000011 -- SError
>   Workqueue: events_power_efficient rfkill_poll [rfkill]
>     rtw89_pci_ops_read8+0x94/0x160 [rtw89_pci]
>     rtw89_core_rfkill_poll+0x50/0x1e0 [rtw89_core]
>     rtw89_ops_rfkill_poll+0x40/0x68 [rtw89_core]
>     ieee80211_rfkill_poll+0x3c/0x70 [mac80211]
>     cfg80211_rfkill_poll+0x40/0x2a0 [cfg80211]
>     rfkill_poll+0x30/0x88 [rfkill]
>   Kernel panic - not syncing: Asynchronous SError Interrupt
> 
> On the reboot path the kernel only runs device_shutdown(), which calls
> each driver's .shutdown callback; .remove is not invoked.  The rtw89 PCI
> driver had no .shutdown callback, so nothing stopped the rfkill polling
> work while the platform was tearing the PCIe link down.  Once the link
> is gone, the next MMIO read from the poll handler targets a
> non-responding device and is reported as a fatal asynchronous SError on
> arm64.
> 
> Add rtw89_pci_shutdown(), wired to all rtw89 PCI device drivers, which
> sets a new RTW89_FLAG_SHUTDOWN flag (mirroring the USB
> RTW89_FLAG_UNPLUGGED pattern).  When the flag is set,
> rtw89_ops_rfkill_poll() returns early, so no MMIO read is issued to the
> chip after shutdown begins and the SError no longer occurs.
> 
> This does not call the full .remove path from .shutdown, to keep the
> shutdown handler minimal and avoid running the non-idempotent teardown
> twice.
> 
> Fixes: 0b38e6277aed ("wifi: rtw89: add support for hardware rfkill")
> Cc: stable@vger.kernel.org
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

667c12782aaf wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot

---
https://github.com/pkshih/rtw.git

