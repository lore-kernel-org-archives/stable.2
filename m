Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C817BED0;
	Thu,  8 Oct 2026 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437633; cv=none; b=YU8MDJi3LSMbMoH5rJjqQPR9sx0yDCkPA588dskd43iBoxLh//++lY0UWw2Fpk5y7sRfclmBOF+6MLUqO+32DjmxN9EWcAQEZBlkqBvDwJTfC61ao8Cckij+E7gr/fLRx7DGi7kIOQo97KhbxjLgF9R1J4hc2iyvdYRIH1h2uNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437633; c=relaxed/simple;
	bh=o8O3dki1havIlVNVt9DzgHw+2hdVAp3OiR9gHxT2NUs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Vu0A6HWdno685lNmwvxQtt32gLGy42OAKI35LxRe4t8UM6mN75zgMT+OlCUidw5oQkZeIC9u5tvbKi+qZjbVwpmW8Cy7FkWhHrvqaAM58ZDgB1WIYstYDZ30wS744kI/O4mq5RIlYTPjYLUqf3FlSzwQnnHA8T1TSXpU3q9+pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WuXPjYDX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WuXPjYDX"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6985XfzrE224642, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791437621; bh=Tcy3hlPXtmRVvYPhWKliUGPh74tuQMfQRKmFJmI+rK4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=WuXPjYDX5NrI3dkhp160MqcmFjRCbWdAT0SDQaJQzAfHWgJSDQrl4xOw0NLgscqE9
	 X3dvDm3pGnaYYxitaSU1/Kzs1ucjkpkIDM+rY1CmcrEfjalnc9/oms9ZHIfEjT1CIs
	 UDxdg3Kwu/j9PmBUyiSAUNIAV89Dj5LJvS6CVIpX/Nlsoe0HfIrFBEAORAHdrWZ/D+
	 zwFdP1PmDRGMi9oV3JGKzJHha4CNtHGrWaLYa6tlGUnAhUg1RQSAr5aYv8LtwH+zzL
	 0BgHUv3NBVJ+y9g6P3biFO2azCqhPUWQswDpC1CeUPLUrOV8XrnmSd2PJmcxV24C+P
	 XyfaUVuXsm16A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6985XfzrE224642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 13:33:41 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 13:33:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 13:33:40 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 13:33:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, Ping-Ke Shih
	<pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, Bitterblue Smith
	<rtl8821cerfe2@gmail.com>, Nick Morrow <morrownr@gmail.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next v2] wifi: rtw89: usb: shorten the RX aggregation hold on RTL8922AU over USB 3
In-Reply-To: <20261007210958.56528-1-lucid_duck@justthetip.ca>
References: <20261007210958.56528-1-lucid_duck@justthetip.ca>
Message-ID: <ac793abc-e9e3-4d03-adfa-e5964cc8785d@RTKEXHMBS05.realtek.com.tw>
Date: Thu, 8 Oct 2026 13:33:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:

> The RTL8922AU holds received frames for up to a millisecond before
> handing them to the host, a value carried over from the RTL8852CU.
> On USB 3 that adds up to a millisecond of round trip, and under load
> at 160 MHz the access point drops to lower rates and download suffers.
> 
> Shorten the hold on USB 3 only. On USB 2 the bus is the limit, and a
> slow host needs the long hold to keep up.
> 
> RTL8922AU on USB 3 at 160 MHz, power save off for the round trip:
> 
>                          x86, 6 GHz    x86, 5 GHz    Pi 5, 6 GHz
>                         before after  before after  before after
>   TCP down, 1 flow        613  1002     579   948     587  1010  Mbps
>   TCP down, 8 flows       656  1187     629  1080     605  1122  Mbps
>   round trip             2.33  1.29    2.25  1.18    1.42  0.84  ms
>   busiest core, UDP 200M  8.4  12.8     8.3  12.9     2.1   3.3  %
> 
> RTL8922AU on USB 2, Raspberry Pi 1 B+ at 5 GHz, 80 MHz:
> 
>                         long hold  short hold
>   TCP up, 1 flow            102.3        87.7  Mbps
>   CPU, UDP 20M               50.5        77.4  %
>   loss, UDP 50M               3.8        85.7  %
> 
> Fixes: 32cee8a9bb66 ("wifi: rtw89: usb: Enable RX aggregation for RTL8922AU")
> Reported-by: Nick Morrow <morrownr@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

83de3a16c7b3 wifi: rtw89: usb: shorten the RX aggregation hold on RTL8922AU over USB 3

---
https://github.com/pkshih/rtw.git

