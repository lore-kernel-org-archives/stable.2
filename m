Received: from mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B13D3CE6
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394571; cv=none; b=AKz+tl3gXfstU+mJlh1sbMJjOBKGG3hVsrS9EbTLJ2NTDe7krx48cBEEwijv9wx+h4zV/HcaI/CmMbKuJ0qoGmnpkFtj9k5u9EhQBWp2bEpBoY+GEsXwsvn5caJTFNzVq0kitRU8HeknRfcW5GZu1ysI1lnnIiG7MMtLoF3lQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394571; c=relaxed/simple;
	bh=tIcB/mfw1V4/KEV3mq2Mt8WWKPnOPSq+oy94YAQGtdk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=KoxKNGebztKbVxa8u+xlkAXAsDeRmR3Rg1B8J65K7FNJygfuCz/lAquPb01UKawxUtVnysnr+ZedOKKJrI23fnQIFCMN2CzBqnTLI2y8yW9qKNlsssEMWVAgtggLJKbZ9vVWW76qJk+S2H6FNCSxAicLqfsRKeP3+hOvINE65eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X03FReZ0; arc=none smtp.client-ip=91.218.175.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X03FReZ0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tIcB/mfw1V4/KEV3mq2Mt8WWKPnOPSq+oy94YAQGtdk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792394566; v=1; x=1792999366;
 b=X03FReZ0qVgKhX1IRehv3r7RkEEstcOE+PUy4E7s1FwIfcgWoB7qAJdYZ7ydEuwXjfq6n6c+
 JjDo3gZjJGX+AsZYYPpaphPX1D9LF16twjiEVpJGnpHSnl6AwLT5eXPpryXxw0Nik7lx4uo8g42
 QaHQATOe5n4reXss1XVFNYM0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 046eedbd3f6afff5;
	Mon, 19 Oct 2026 07:22:46 +0000
X-Mizu-Trace-ID: 046eedbd3f6afff5
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 07:22:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <a3877fa66c76303da8240f65caca292579a006f3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] wifi: rtw88: usb: drop RX frames received before the
 device is started
To: "YuanZhe Liu" <25031212351@stu.xidian.edu.cn>, "Ping-Ke Shih"
 <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Sascha Hauer" <s.hauer@pengutronix.de>, "Bin Yu"
 <byu@xidian.edu.cn>, "Cheng Wen" <wencheng@xidian.edu.cn>
In-Reply-To: <20261019064000.5167-1-25031212351@stu.xidian.edu.cn>
References: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
 <20261019064000.5167-1-25031212351@stu.xidian.edu.cn>

October 19, 2026 at 8:40 AM, "YuanZhe Liu" <25031212351@stu.xidian.edu.cn=
> wrote:


>=20
>=20rtw_usb_probe() submits the bulk-in RX URBs at the end of probe, righ=
t
> after rtw_register_hw(). A device can already have data queued on that
> endpoint, so rtw_usb_read_port_complete() runs and queues the frame on
> rtwusb->rx_queue before any interface has been brought up. Submitting
> the URBs late does not close that window: the frame can arrive as soon
> as they are submitted, which is still before the device is started.
>=20
>=20rtw_usb_rx_handler() hands every non-C2H frame to mac80211 without
> checking whether the device is running, so ieee80211_rx_irqsafe() runs
> while local->started is still false. mac80211 treats that as a driver
> bug and warns in ieee80211_rx_list():
>=20
>=20 WARNING: net/mac80211/rx.c:5601 at ieee80211_rx_list
>  Call Trace:
>  <IRQ>
>  ieee80211_rx_napi
>  ieee80211_rx
>  ieee80211_handle_queued_frames
>  <TASK>
>  rtw_usb_rx_resubmit
>  rtw_usb_setup_rx
>  rtw_usb_probe
>=20
>=20The frame is dropped by mac80211 anyway, and because the URB is
> resubmitted from its completion handler, every further frame repeats th=
e
> warning, which floods the log until an interface is actually started.
>=20
>=20rtw_ops_tx() already drops frames outside of start/stop by checking
> RTW_FLAG_RUNNING, which mirrors local->started: it is set at the end of
> rtw_core_start() and cleared at the beginning of rtw_core_stop(). Use
> the same check in the RX path and free the frame while the device is no=
t
> running. This also covers the opposite ordering, where a frame that is
> still queued in rtwusb->rx_queue is handed over after the device has
> been stopped again.
>=20
>=20C2H packets are left untouched: they go to the firmware event queue
> handled by rtw_fw_c2h_cmd_rx_irqsafe() and are never passed to mac80211=
.
>=20
>=20Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---

You forgot to carry my Reviewed-by tag so here is it again so it gets
picked up.

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Best regards,
Luka Gejak
