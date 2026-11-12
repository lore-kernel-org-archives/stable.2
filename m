Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453493;
	b=ZgqBcEnBU0Ep3B7xOg2JoHhXJIFGubGQ/kzVLeg/fzrChw534ZoApp6fQ/Qif/ofa43M
	 DyfEUtVN4D5MoH/1O+rYyKO5Pg13mlsRdO6e/BrMFjRLRQyRcgwb7Doysc3RUUNfjO+wA
	 rgARpt9yU1I+m4dX7nhQkk+fo/cQUj8JVW/nUOyjIzk+yi/mqrs/yxOxC+EQ+R3of2nvY
	 fkYxSh0+cvj5m7MiNwbx25an3q3VdMFGwovvuGuj2r4cbi9lujMI4qOndaKEVx2cnpdVc
	 P364MYOBuENKzieEqWptY837gPE4dNfOMjfDnTvAcHK5nEJFxk2hdNjjtmLMonMyaKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453493;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:Date:MIME-Version:Content-Type;
	bh=lbIs4tprYVpNM+bPoaJ4jGZRUpTsv4P/N73o1CTqSLg=;
	b=wp8FuUKCy2F+b2cgYN/3xtfhIJU2rSPRi30V4Rx/BixgiRXWhpb9UNeE2EIfBeVUwVDo
	 BsQDSn714jxI1AXFYydeubzgBo616M/KwKSuS86VLspLnZe0CxuZNzMb75U2LY9I9r54d
	 wkQWXWbnG97c9k3EQGswVJtmxJPjcpZHsVWTvA7EszEoVhkXq2ZY0jNlwBhbeFU8GSC/f
	 k5EgTuKtHseqBpS+GrJh80Kc9XawuGTxJklLeq7EJ7uSqptKsR7RVmMqD4/H16nMSNlb9
	 Vk8ZUe8ElQkJSQJioyMNfKZ1tnwgdb6tZIS0CpOFsihX9kqch6WkUuLZ+fNA4YFz66w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b="DKyk/Hjz";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C8606A31C;
	Thu, 12 Nov 2026 03:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9C8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=DKyk/Hjz
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AC3HYAV03373523, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794453454; bh=lbIs4tprYVpNM+bPoaJ4jGZRUpTsv4P/N73o1CTqSLg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=DKyk/HjzL1Uh12CMRgXu4gIeGk6UTrTX7RnYTM7Wz1YKcjARb929Dc8J/wxqvecfQ
	 TMr9m4xA+bA7UjcrG91Ieg19dW1GT6mmCkMrAHOqGth/2gvCLugIdID0/KIRprekj4
	 8nygY8kuZJr1dxnSzXaNJwj8lPQshp7ogK4/hFar/Xqokr/m8ZoamYDB732S/Zj+kP
	 pgyVVo/ieIlLa/p/jhdADEgfAySS5Upnet7UZuQzqgDmdI3b88tlAxHgRyJ5bmkzpS
	 jS0e4awNktTotpIOMop1j6l9P8r4Sq+iRrm0OHroZBzbnGpeVLy9GqoUBxyLr/SjMf
	 5JKXSWsOVMZ2A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AC3HYAV03373523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Nov 2026 11:17:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 11:17:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 11:17:33 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 12 Nov 2026 11:17:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhao Li <enderaoelyther@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: Luka Gejak <luka.gejak@linux.dev>, neo_jou <neo_jou@realtek.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>, "Hans Ulli
 Kroll" <linux@ulli-kroll.de>, Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw88: usb: stop RX work before unregistering hardware
In-Reply-To: <20261101134314.39340-2-enderaoelyther@gmail.com>
References: <20261101134314.39340-2-enderaoelyther@gmail.com>
Message-ID: <92d3d8d3-656e-4669-8782-f64bd2ecc1ed@RTKEXHMBS05.realtek.com.tw>
Date: Thu, 12 Nov 2026 11:17:33 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Zhao Li <enderaoelyther@gmail.com> wrote:

> Disconnecting an rtw88 USB device while RX traffic is active can leave
> the RX worker running after mac80211 hardware is unregistered. A firmware
> event can then queue C2H work onto a destroyed workqueue.
> 
> rtw_usb_disconnect() kills the RX URBs but does not cancel rx_work,
> which their completions may already have queued. rxwq is destroyed only
> after rtw_unregister_hw().
> 
> Cancel rx_work synchronously after killing the RX URBs. Only a
> successful RX completion queues rx_work, and no RX URB can be
> resubmitted at this point: rtw88 does not set soft_unbind, so the USB
> core disables the endpoints before it calls rtw_usb_disconnect().
> 
> LLM assistance was used to find the bug and review.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

85ef46b9f514 wifi: rtw88: usb: stop RX work before unregistering hardware

---
https://github.com/pkshih/rtw.git

