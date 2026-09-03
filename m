Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CB50C2BF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466583; cv=none; b=QKQx5gOj095q2EtARSQlGdSsZm4gP8lG2w5kZE1il4BDW6i2pVi8WC0txPwmjLMoX7ZoX3NTxckg86GXhBioltcB4xaLWn0VKR/Ouz1AW9y3nw0MyhgQHTfZZ+qvmZrKWsmBytkCExEc4eE/L1QB2b1a9YTyWxHFLD47wNWYZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466583; c=relaxed/simple;
	bh=OCay8y54i/DeL+BmtuyobvApMswnnqjLbsKh2PebhQ8=;
	h=Content-Type:Subject:Date:Mime-Version:From:Message-Id:To:Cc; b=IYqovqRuLTpWqMyh7T9KwKzDUzXDs72f4rBoCbUADpzUQswBUBokotDYReILcHh7YeIrlgwhDPnRwhZUuzpn3jhZdMVwvdd/7EZUM6zgsOCrM+dIksRvUILbwEGkNphbIL8QPhDmpMaECuBdTGUqBOwlK+WS2KOGNHvzl2wB84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=g9Blo83V; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="g9Blo83V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788466551; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D9TEDMv0CjVfKQlEgF61kSUh682AwltwWfoAN5/kJX0=;
 b=g9Blo83VJYy8VLloUNS5xPCXmdhaUn0YkuIKOIvse773bC5ZbTwBT45mTodgNz+AYOdN/+
 vNol0TEwF+KvwoJqLuJH1CvmmwXesU17uSJbZCC8+HF6VSTrhAyomfkie1SMg8+T9+uvKt
 bACPN8aVtm+f7Pc4KWDUOEYzfE2JNAlHLpPXOwwiJPIxIMNpz3o9xXjvfGaBYNefC55wY1
 C1EDKusalc/1P6FMO/dzkY09eRKa4r3ZfRdF0FueQYds8XridN6+uvaAimheYYBkdXBg76
 MVxiPoON/nZcj6+s+O1H/Mj46jEYvgec6WWffzrbkqYOMs85oJINZGmCCvDlvA==
X-B4-Tracking: v=1; b=H4sIAHHVmWoC/yWMwQrCMBAFf6Xs2YWkoKK/Ih6a5EXXQ1yyaSmU/ rtRjzMws5GhCoyuw0YVi5i8Swd/GCg+p/IAS+pMoxtP7uI8Z0TWpqxqjAWl8TxlTjGefTjCp+C ot1qRZf19b1TQ6P6XNocXYvsead8/URna+34AAAA=
X-Change-Id: 20260901-fec-ptp-pps-event-uaf-dcc71b5e1db0
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.9.107] ([111.42.148.30]) by smtp.feishu.cn with ESMTPS; Fri, 04 Sep 2026 04:15:49 +0800
Subject: [PATCH net 0/2] net: fec: fix PTP clock teardown races on device removal
Date: Fri, 04 Sep 2026 04:15:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260904-fec-ptp-pps-event-uaf-v1-0-9af446be4a11@cherr.cc>
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 7bit
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a99d575+cadeb7+vger.kernel.org+me@cherr.cc>
To: "Wei Fang" <wei.fang@nxp.com>, "Frank Li" <frank.li@nxp.com>, 
	"Shenwei Wang" <shenwei.wang@nxp.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Richard Cochran" <richardcochran@gmail.com>, 
	"Troy Kisky" <troy.kisky@boundarydevices.com>, 
	"Fugang Duan" <fugang.duan@nxp.com>, 
	"Lucas Stach" <l.stach@pengutronix.de>, 
	"Fugang Duan" <B38611@freescale.com>
Cc: <imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>

fec_drv_remove() calls fec_ptp_stop() before the netdev is unregistered
and freed, but PTP teardown leaves dangling references behind.  The PHC
pointer remains set after ptp_clock_unregister(), so an ethtool -T on the
still-registered netdev can pass it to ptp_clock_index() after the clock
structure has been freed.

An in-flight PPS handler can race ptp_clock_unregister().  The devm-managed
handler also remains registered past free_netdev() and can dereference the
freed netdev before device-managed resources are released.

This series closes both holes at their respective introduction points.
Look up the PHC index by the parent device and clear fep->ptp_clock after
unregistering the PHC, then explicitly free the dedicated PPS interrupt
before the PHC and netdev teardown.

Found by source inspection while reviewing PTP teardown paths.  Verified by
compiling the driver with W=1.  No hardware was available to reproduce the
races.

---
Shengzhuo Wei (2):
      net: fec: don't leave a stale PTP clock pointer after unregister
      net: fec: free the PPS interrupt before tearing down the PHC and netdev

 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c |  3 +--
 drivers/net/ethernet/freescale/fec_ptp.c  | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)
---
base-commit: 548e7bcd0c5460ddcbca9600cea603ebeebf4da7
change-id: 20260901-fec-ptp-pps-event-uaf-dcc71b5e1db0

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
