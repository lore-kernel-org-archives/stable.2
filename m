Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675289;
	b=NpaWQOUDKpVzCU31Vj2bSYcc/bHs+2CjGHKTtfT7oc/RxKNfhw07WpW+qtAOdTDGn2D7
	 Rvdw+iX5CjCooTO8Q6FwnDM7qgA1Myj/0WW1gZraHlppvHkvI1hEleIhZ16bJvZpzLTdO
	 9Juygrjfd1t7iadWk/FHVMFMakf3k0yzPaZQvHW7AYtSV8HzTzDGXNRhW5YGLtV2tMPmE
	 jl/jjYSe00hcsct17rPltm1/1c4twEIXipJsEH0dzAr8XQspyfL/fK7kKyqmFiJ+tvhLU
	 MV63rp5JIeyDpCYf+Yz8S3j+6T4vxqyrlwdC5FtASMBm/Gcy9MVtolOtPRG22+l+Ipg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675289;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:Date:MIME-Version:Content-Type;
	bh=ipoTgPd8Fwqg7YNSVq8z0RBRMLPfB3mxi/Vs+YIWPmY=;
	b=zFmUU9Q5bfOavBU1zJSKjzx8kiatDoMGTa8QOgNTkI471fI1DhDoX7jp44WhsC9DFiMP
	 VdEdKD/pTCCQnSiXGkrxuooeheVnENUacZisu8Sx9JuX9uxNQ7JsDvLbZSILRH8oiv0QK
	 xL9sIcFFR8PdxJZoEdVCpsco9qhKZ2z5ECIsAJd2S9Ng99ICBl0DdxfOfGzVlTJ7uj91k
	 8R9Sl5p8ha1oPqvZPr68h1WtSLOdA0V9xfwfzB5pfSrsg8lsuZ1vGA3/s9XSzs/19nxuW
	 YlojUorvsXv9yd7p313tMSxIzfR9M228WK3SiNV7ec+14tcW504wFeO2RiTZCcXlm1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=sqEDJ+4K;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC137606A326;
	Tue,  3 Nov 2026 03:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC137606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=sqEDJ+4K
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A337x3F22691575, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793675279; bh=ipoTgPd8Fwqg7YNSVq8z0RBRMLPfB3mxi/Vs+YIWPmY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=sqEDJ+4KPkO5D5F/XUV/HIdbuL0f6t4No7RHlpHlSLpASHLv8nrxjUVgWqFkXWk00
	 s5nklKbjdJCcQL0Nsqe311GpleTUAi1cj0NzyUrYQoKoT5UeH8xa8xqkX0KsVQKhNJ
	 kZuXuL5UYM/X0XgmJ9xylm8o5NlJmB41ia/2d9feIiZ3wlW229QIXABSKJ8XSYgmo+
	 F8i5nQPiTw5r7erGMFtzHE+7v/4dQ31abPIT1SMFTlP+hRBDMtkzAFK8zogHWDkVeY
	 mV4EO9HvfBRh9J4uLHWGZXJg9wGCm91esKS02qFZvHDNOkTtEGKrCZvaHarnvKAImq
	 DeHHmQJ4M0c9g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A337x3F22691575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:07:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:07:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:07:59 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 11:07:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kim Wooseok <5mghybrid@khu.ac.kr>, <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Kim Wooseok <5mghybrid@khu.ac.kr>
Subject: Re: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer from CPU state
In-Reply-To: <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr>
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr> <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr>
Message-ID: <28afeaf0-6e3f-46b5-83d2-768496e9abac@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 3 Nov 2026 11:07:54 +0800
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

Kim Wooseok <5mghybrid@khu.ac.kr> wrote:

> From: Kim Wooseok <5mghybrid@khu.ac.kr>
> 
> An RTL8192EU failed to reconnect on a Raspberry Pi after an AP power
> cycle. RF_MODE contained a corrupted value, and restoring its initialized
> value restored reception.
> 
> The register access helpers pass usb_buf directly to usb_control_msg(),
> but the buffer is embedded next to usb_buf_mutex. On the affected Pi,
> it shares a cache line with the mutex's waiter state. A contending task
> updates that state while the USB transfer uses the buffer. This violates
> the cache-line isolation required for non-coherent DMA.
> 
> Allocate the buffer once in probe and reuse it, avoiding an allocation
> for every register access. Keep the existing register access helpers and
> mutex protection. Free the buffer on probe failure and after power_off()
> in disconnect, since shutdown still uses the register access helpers.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

f7c98e720cad wifi: rtl8xxxu: isolate the USB register buffer from CPU state

---
https://github.com/pkshih/rtw.git

