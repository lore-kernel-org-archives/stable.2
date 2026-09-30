Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4303BE659
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762796; cv=none; b=msMm/cRD2jc2rvMhtavrvXJtB+SFkDlkjLxvv9GjjQR6kGs0p1svL+03b2+1qhUaL2EafVy8wvfai0FPeP4u2upWnEzzEWmq7T65C9tDEIVNPey86Ra2l7dhbHRvtfq36FxK3UbZIDTboiLsOZpKpu9SsCbqNEW7c+0sKopC9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762796; c=relaxed/simple;
	bh=9nvl85Z6QtFWRFbLYnO5GWIjhJ87TJx9hTTk0Zsecrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o95cHsb987r8ePVT0zntSJ5FjIXKZS86JtrvKVsJmeXt1dPcfzz5T7i7nRasB9d4SI1vCCrrmOmCgz4UjLVgmOJ31I7KaHMKaahdaBP44woV2/wlNv8ArHfNKT1/2wczgZAWZ2vxBcQmVvpLbho/zdtxvSf7ZIv0Jm5tzMgGeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DWcl1WGD; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DWcl1WGD"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9nvl85Z6QtFWRFbLYnO5GWIjhJ87TJx9hTTk0Zsecrs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790762791; v=1; x=1791367591;
 b=DWcl1WGDcji4K1jQaqX73xaR7IjQFmk/0wiKCPA3LTNxt9Ua8OMSkPDIzpEyWpQ4rkUMnC9i
 n7pkj20nHV92vDScYb4c9fVt+crQ75q1DjC+QRkH9kur8ayBn2AtKdbhsfII6ggzVd7D1UQ7NlK
 eb9dJ5p6PVnM/z3svF6mkWY0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d540dcc667c71fe4;
	Wed, 30 Sep 2026 10:06:31 +0000
X-Mizu-Trace-ID: d540dcc667c71fe4
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
Subject: Re: [PATCH v2] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Wed, 30 Sep 2026 10:06:29 +0000
Message-ID: <20260930100629.14270-1-luka.gejak@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930090714.2779699-1-alastair@d-silva.org>
References: <20260930090714.2779699-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alastair,

This breaks the drain loop on the 8051 parts. The early write clears
REG_SDIO_HISR_RX_REQUEST before rtw_sdio_rx_isr() runs, but the 8051 branch
of the loop uses that bit to decide whether another request is pending:

> +	rtw_sdio_disable_interrupt(rtwdev);
> +	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
> [...]
> +	if (hisr & REG_SDIO_HISR_RX_REQUEST)
>  		rtw_sdio_rx_isr(rtwdev);

		if (rtw_chip_wcpu_8051(rtwdev)) {
			hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
		} else {
			hisr = REG_SDIO_HISR_RX_REQUEST;
		}
	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);

In the v1 thread Ping-Ke relayed that the hardware clears the bit once the
RX buffer is empty, and that a software clear means no new interrupt unless
a new packet arrives. So the first re-read after the write returns 0, the
loop stops after one request, and the rest of the FIFO waits for the next
packet.

The 8821CS cannot show this, since 3081 parts never read HISR there.
RTL8723CS, RTL8723DS and the RTL8723BS once its glue lands are the 8051
SDIO parts, so please run the test on one of those, or leave RX_REQUEST out
of the early write and let the hardware drop it.

This also needs a rebase for rtw-next. The 8723BS mask sits between this
block and the old write:

	if (rtw_is_8723bs(rtwdev))
		hisr &= RTW_SDIO_HISR_CLEAR_MASK;

	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);

Moving the write up as posted puts the raw value back, undefined bits
included, which is the resume storm on 8723BS that the mask exists to
avoid.

One smaller thing, the early write also consumes anything already queued
when the handler starts, so what the 64K budget leaves behind waits for the
next packet too, on 3081 as well.

Best regards,
Luka Gejak
