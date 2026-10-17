Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30947F3C1
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230450; cv=none; b=uJTmsUj6Ev7HuPvbmexv7FGQ/f37Nicwj/tdBPdVPR1WcLxTV8VksmTd2Rk9EqgJjXTO3zsr9rh04WPfLIzzBcyNnu4hNDH7ScbFAzWq2ZHfrjgPG4tW1Y3IoFj6dPryaWSMJs4MFoVse1aD+hnJlktW7ZKYn+QRwunXDuO8keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230450; c=relaxed/simple;
	bh=qX7rmF6h1+DZNL++qx2GfJQv14aUtMydKWiaDVtlerY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mGMm2ssw9xuJ2KxUl/zytkoRIWnA73jRKCKKNMkm7DYBHZZaTQiVkHziFPofeM8Gm8/Hwl1doJsEUk9mx4zJ9VR9dc9FSEu9CBjK4cBNYWfcG9HzFYYbDmZIdIFs0VXzbE8BehpgQTA36RRA39qYi9v8Zkr5EMWZTquUspolHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c66ldpvY; arc=none smtp.client-ip=91.218.175.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c66ldpvY"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qX7rmF6h1+DZNL++qx2GfJQv14aUtMydKWiaDVtlerY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792230445; v=1; x=1792835245;
 b=c66ldpvYnT+E89ydv5wTqv+bBiJe0/ngQyRw+5vC0dFyYjXI0ajiZn5kbLGaVzkYpLBoTX0f
 kGzISi8wxfCQnRBNlGsWseuGnMI+Ty/P7oPJ8CcUFWKT33eZpdHAArMJ40eoHY6BhvFKW/1POvs
 EaNupO8RjjGma0GqBt78eEd4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a42a045764720f77;
	Sat, 17 Oct 2026 09:47:25 +0000
X-Mizu-Trace-ID: a42a045764720f77
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 11:47:24 +0200
Message-Id: <DM70O3RX648Y.JHOHHH89JM3F@linux.dev>
To: "YuanZhe Liu" <25031212351@stu.xidian.edu.cn>, "Ping-Ke Shih"
 <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Bin Yu"
 <byu@xidian.edu.cn>, "Cheng Wen" <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] wifi: rtw88: usb: drop RX frames received before the
 device is started
From: "Luka Gejak" <luka.gejak@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>

On Fri Oct 16, 2026 at 6:19 PM CEST, YuanZhe Liu wrote:
> rtw_usb_probe() submits the bulk-in RX URBs at the end of probe, right
> after rtw_register_hw(). A device can already have data queued on that
> endpoint, so rtw_usb_read_port_complete() runs and queues the frame on
> rtwusb->rx_queue before any interface has been brought up. Submitting
> the URBs late does not close that window: the frame can arrive as soon
> as they are submitted, which is still before the device is started.
>
> rtw_usb_rx_handler() hands every non-C2H frame to mac80211 without
> checking whether the device is running, so ieee80211_rx_irqsafe() runs
> while local->started is still false. mac80211 treats that as a driver
> bug and warns in ieee80211_rx_list():
>
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
>
> The frame is dropped by mac80211 anyway, and because the URB is
> resubmitted from its completion handler, every further frame repeats the
> warning, which floods the log until an interface is actually started.
>
> rtw_ops_tx() already drops frames outside of start/stop by checking
> RTW_FLAG_RUNNING, which mirrors local->started: it is set at the end of
> rtw_core_start() and cleared at the beginning of rtw_core_stop(). Use
> the same check in the RX path and free the frame while the device is not
> running. This also covers the opposite ordering, where a frame that is
> still queued in rtwusb->rx_queue is handed over after the device has
> been stopped again.
>
> C2H packets are left untouched: they go to the firmware event queue
> handled by rtw_fw_c2h_cmd_rx_irqsafe() and are never passed to mac80211.
>
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---

Looks good to me.

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Best regards,
Luka Gejak
