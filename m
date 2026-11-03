Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676676;
	b=y8dyBrY6zzxLlRWR5CTwQsQT8FrcJsOyRE5T2/k5BdfK0Hz4nrnQTnzx4nQk8hn3XFg8
	 d15tcPa56W8hBxCylk1ICvnDgYgycbjoN0EX8Dh/AMFI3O140LWVYZpyClYHQVp4OINn9
	 JRkx3kOcS8okGdUTgoes3fACzoWRQ4MNjYVLviOqlHJ1FTbRvRDxbijJsfSS7MF3QSwvH
	 z0DjUoelEr+is471FU0mb9ecnlRHKEF+aOpCJqsTkxWzpzfiq7Px0q5/naeokF6xa1Y9g
	 YWiphSoPcERsyGRcGgsAOA5vwfYCxFNdmO6BO3sbg44vyTQhjObWBAZREk/tCjOsr0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676676;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	bh=AMOS0B/JAnxwot5406OJH4FzxWsoAX0mWtHn/kmohNA=;
	b=kGx0s4hnPI2EsHf02xyadMtpf8fyH0VA2WsfZzZP7Od5aOz19bX4vPqU/cmusqXZqm6c
	 R9MYlQuPVbhLGWBsRYOO7AwaOKWziXEl3x0iHnOG21bfj/QqAyribIMWF9H7XDzez4JjS
	 y5OO4b7V7MZ4IAEd0dFsyfqcV0mw/ZiLPseTQi5GhIiawPc8uQnK6DnWSbBOWfBND7iEZ
	 g0fEiQBW1sXnsB1Jl/QcNvTMywHAlqOb91qiKRKTcUo3J3HIF8jKGWe2lvptslTELxeGU
	 p869QpmB6V00NtFYCxo3gKrYrm7mbyaLpWqK4KkEW6ujesgGvtlc12glMKcfarf58GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b="DN/5d44T";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA7606A32D;
	Tue,  3 Nov 2026 03:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EA7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=DN/5d44T
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A33UumzE2700913, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793676656; bh=AMOS0B/JAnxwot5406OJH4FzxWsoAX0mWtHn/kmohNA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=DN/5d44THYWN3WqXzEXhXzj/APwbrzJ0Ry/eAMn2oNsCa5eRkEBab23RMMy5NZm1e
	 myIKnjgzYFpA1dCt0ypuvyZHOBz4MC+Yh2vspQYSjCjq3kHR6eToJ5iNwODKx0KsxL
	 T+eEFuIoxUfPdOVreoEqCEpaCg0FO/FGoeQdXgTfV4VWoljSdzeoTR1Y7k1KZBjyn6
	 LPNhl3YCk/NHN1sXKkddyXEVs5vtugcmf7J0KJFzjJePjVt5WxUWOVgzEe+DT6p4xD
	 919rtK/v5O0X3fRK2yPlNO0OUdZZbGHD+Cn38g4b+1vbBDY2xWRZH5FJ/GDGlgekgA
	 rwrdkp7Mte65w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A33UumzE2700913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:30:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 11:30:56 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 11:30:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>, Ping-Ke Shih
	<pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Bin Yu
	<byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] wifi: rtw88: usb: drop RX frames received before the device is started
In-Reply-To: <20261019064000.5167-1-25031212351@stu.xidian.edu.cn>
References: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn> <20261019064000.5167-1-25031212351@stu.xidian.edu.cn>
Message-ID: <a52d266e-8060-4b10-8b3c-80cbc29259ec@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 3 Nov 2026 11:30:56 +0800
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

YuanZhe Liu <25031212351@stu.xidian.edu.cn> wrote:

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
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

72fa55807619 wifi: rtw88: usb: drop RX frames received before the device is started

---
https://github.com/pkshih/rtw.git

