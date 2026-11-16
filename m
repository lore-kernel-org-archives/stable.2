Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.236.53.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796298;
	b=emyDmZd/JeKTNiK3EBZloZp2vunQN3ncYak8+cm57pm49YlLZwFx77WiTVSsoNQ5akud
	 e433JDeF+nomkgOa4MvCatVGVDKZMb9S5I5VAUTCP700q0c0/s6X55uHDmBZwnVMLnO+X
	 c4X+QonN7yoaJgXtkQirY7zGtRCqc7DKyoiYBr9J6NRJe7+LG5o2EsPWRkCMTRnblJKKu
	 ReL2MCwlAwOvi9zX/ACqU+SaI0hEgGQN6cAdXiyAh7ypy2i0jqdaeY8esIbGdNblis0/z
	 wF/RZpMVP+4aqKGQgsXrpCsHTRlXMhbP2WCkNll/DLlOGcOuSUHcY/d8JYLarVNpEKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796298;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=hfqntSgZEOiSlMbDpZIWb1KiGQmsm3Ec+5CbGoJgk7E=;
	b=e5ES9sNNbDZY2387ICOcgtV/JB8sManWop/ef31Z4EqO7GEZv16E8JbgD2l1Sf8jcUi/
	 v837i3qAa5teC/326boCpgaxPku622rQCQiHKQmOQlVR1OIagjA2GzzsOrdoc8m6oWknx
	 743XexJXD3mZMIsB18S3/PISuChflNhhxmcO3sznLk65YFlZVAO9X1kbNxm/K/csUrmbE
	 xk0CFhe5d2ERH/wepbN/9WyQfsFL+M+n1j+gjnenx8dlgdfJ/huUM/DggysGRXO378wqz
	 SzrlRsHuv6dCjqnGUsqzmlpLKZgY/sGJyzIFo55WVOWVbdonYps4vEEcGoe0Ldl2owQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=WxeZfkmZ;
	arc=none smtp.remote-ip=160.236.53.13
Received: from mail-m1602365313.xmail.ntesmail.com (mail-m1602365313.xmail.ntesmail.com [160.236.53.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3C606A31C;
	Mon, 16 Nov 2026 02:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64B3C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=WxeZfkmZ
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54c419283;
	Mon, 16 Nov 2026 10:31:24 +0800 (GMT+08:00)
Message-ID: <eb51e0bf-148a-4d8b-8110-b65094fa1b43@rock-chips.com>
Date: Mon, 16 Nov 2026 10:31:23 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lucas Tanure <tanure@linux.com>,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, stable@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2] phy: rockchip: naneng-combphy: fix RK3588 SATA
 pipe_con1 register offset
To: ricardo@pardini.net, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>
References: <20261115-rk3588-combphy-sata2-6g-v2-1-778e0e8011fe@pardini.net>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261115-rk3588-combphy-sata2-6g-v2-1-778e0e8011fe@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e231e94703a4kunm17ffdc46316b32
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0lOVk5NT0keGBlITkhPTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WxeZfkmZ5HroSFzNuKJdwY9gasYUv4nbix2/cXrP2RmCjDFaiag8JqeXgy6Lw32LPAlnUK/JDwgljR25116G2CTQRGcyB6duFeqPbq36WeCpMq1ZX0VQ3do+LrDW58KNesZ5AexQivXnWkr6tRuGJz1XIZfXwn2I6BRkg81Bipg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=hfqntSgZEOiSlMbDpZIWb1KiGQmsm3Ec+5CbGoJgk7E=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/15 星期日 23:48, Ricardo Pardini via B4 Relay 写道:
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> 
> On RK3588, the sata2 PHY speed is selected by sata2_phy_spdmode in
> PHP_GRF_PHP_CON1[1:0] (offset 0x0004), with sata2_phy_rx_err in bit 2.
> rk3588_combphy_grfcfgs has pipe_con1_for_sata at offset 0x0000 though,
> so the value 0x2 (6.0 Gb/s, rx_err cleared) ends up in PHP_GRF_PHP_CON0
> and CON1 is never written.
> 
> This leaves sata2 at its 1.5 Gb/s reset value, so the link only trains
> at 1.5 Gb/s, even with a 6 Gb/s capable disk and no SControl speed
> limit. sata0 and sata1 are not affected: their speed fields are in
> PHP_GRF_PHP_CON0 and are set by pipe_con0_for_sata.
> 
> The misplaced write also lands in PHP_GRF_PHP_CON0[2:0], which are the
> PCIe link reset grant bits, and turns on the one for pcie3x2 whenever a
> combphy is put in SATA mode. No effect from that is known, but this
> stops it too.
> 
> The register layout is described in the RK3588 TRM V1.0 Part1, section
> 6.17 "PHP_GRF Register Description".
> 
> Tested with an mSATA SSD on sata2 (combphy2_psu). Before:
> 
>    ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>    Timing O_DIRECT disk reads: 374 MB in 3.01 seconds = 124.45 MB/sec
> 
> After:
> 
>    ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>    Timing O_DIRECT disk reads: 1266 MB in 3.00 seconds = 421.78 MB/sec
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
