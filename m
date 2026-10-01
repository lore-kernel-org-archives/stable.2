Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB64570D6
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790834565; cv=none; b=K8rUfwuiwu0A+BWr3g5v+nY2B7LNusH9WSD3jAY8ec3OgqOWDjPyiKU+u1XesfTFz5c29ws40PK6JUhThMloEICbUPTz/HNi7ej94wnWGFW4p34ZfWWPqyu0bJGHKW/ByWXmvVXChaQS5Y84T1LKQUucWCJ7CL5vDTaWh/U3rO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790834565; c=relaxed/simple;
	bh=ONHwvlafLxqOwWtTKBLJQM46MsZG63waYc7Ovsluscs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2GepJCDp/6RYndDOHpnu6UwhCC8gCbYYUdz55ZXL6UFPGA4Qq+bxjheyHvI6ve7DqpZFF7Bru71r3M2u/6cNF4YC3fo+SWBsK2J2mwtFFAzpUaH3VdrXd0LRCHLFVAv8oZb2uZP6vMwD3mQIKw2Q3kWuIM3XXg9jbCIpPkX9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahrIkfdT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahrIkfdT"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ONHwvlafLxqOwWtTKBLJQM46MsZG63waYc7Ovsluscs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790834556; v=1; x=1791439356;
 b=ahrIkfdTqyLz3d21ADnyivDKDAM1fD5EcQvOYnZ2BOHIVAkbAdkrwZuUJkHv39wgQ29cusJ+
 nmyEM4BQmXzYVteogEGAyfgdFBE5dIH1IWS4BAfliNNSXO3H40vXU5VIbYqmgMNQHHLkj2FzUNt
 h9xycMfDrayyzuyNzUeviDpI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dfba6b55da3cb7ed;
	Thu, 01 Oct 2026 06:02:36 +0000
X-Mizu-Trace-ID: dfba6b55da3cb7ed
X-Migadu-Flow: FLOW_OUT
From: Luka Gejak <luka.gejak@linux.dev>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Thu,  1 Oct 2026 06:02:12 +0000
Message-ID: <20261001060213.24759-1-luka.gejak@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001000303.3505264-2-alastair@d-silva.org>
References: <20261001000303.3505264-2-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alastair,

The split looks good to me.

One issue with acknowledging the request up front:

> +	rtw_sdio_disable_interrupt(rtwdev);
> +	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);

When dev_alloc_skb() fails, rtw_sdio_rxfifo_recv() returns without
reading the port:

	skb = dev_alloc_skb(bufsz);
	if (!skb)
	  return;

but the loop counts the bytes anyway:

		rtw_sdio_rxfifo_recv(rtwdev, rx_len);

		total_rx_bytes += rx_len;

so a few failed reads burn the 64K budget and the loop exits with the
FIFO still full. The request is already cleared by then, and only a new
packet sets it again, which may never come if the FIFO is full and the
sender is paused. 8051 does not have this problem because it leaves the
bit to hardware. Can rtw_sdio_rxfifo_recv() report the failure, so the
loop can stop and retry instead? The read error just below the allocation
leaves the FIFO in the same state.

Same function, the enable at the end:

> +	/* Unmasking HIMR re-asserts the IRQ line if new packets arrived */
> +	rtw_sdio_enable_interrupt(rtwdev);

It also runs when the device has been stopped. ksdioirqd can still run a
handler that was signalled before rtw_sdio_stop() released the host, and
stop only writes HIMR as zero:

	static void rtw_sdio_stop(struct rtw_dev *rtwdev)
	{
		rtw_sdio_disable_interrupt(rtwdev);
	}

rtwsdio->irq_mask still has RX_REQUEST and CPWM1, so this puts the mask
back and arms the stopped device again. PCI clears rtwpci->running in its
stop path and only re-enables while it is still set:

	if (rtwpci->running)
		rtw_pci_enable_interrupt(rtwdev, rtwpci, rx);

Can you add something like that here?

Best regards,
Luka Gejak
