Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6ED33938F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835092; cv=none; b=dztGzlkTwHx0NbRbAkH89Z74E9BTYYMaK8Yb6xLP+TO3vPa4RQmghG8ANhVcblQx8CeNHC/v+5bhsrH5yUZM9osNkGz9U4n0lxnl0zpw/b6EMLzIYmhkkoXtVCUE10tXQJDHfMVQATf6UuwJP0Xl0pLVlBG7TrIjhtb4QjzstxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835092; c=relaxed/simple;
	bh=rfJMxKZZRzj4HZMtbUgPCYMFf6bfVaKIMTAZk4aVrjA=;
	h=Message-Id:To:Cc:Subject:Date:Content-Type:From:Mime-Version; b=lLpeY5SUgoFO5bqkdWVs82pc8RTor9pLVX5XkHN58BKTJ5a1n+btkZpWeOhs0CYgSiBjTVltB4VpJSuZI5b/4tI3WTrCdUyvgktmB+PML2vq81s6zdivKjVte/w/LPFccZ1T2Prbc3TiRZ1tGYmIQHGOBu2Af1tJx68HqOVF5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=cOL+YMup; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="cOL+YMup"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788835083; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kSI7yGDTAXS2LsAwqINs1fL1cOHm9czyVm2WQa6R7SU=;
 b=cOL+YMupfdxf8xPOZFa9bPKU87Lg3ltSnXVWV3Hh1kmomiwx5MtpV1/MahZm43Ncn9ft/z
 yXcqGNxntS8j1Es5e9OdJBNZ6uh8NF3C8Y/DR2Aukz2MkUUqb8/oQ9E6T4o0TuzmyTz9CZ
 1ZtEc9BwpmSd+6NRP+xVSW0f0Mb0RVQ4KKLqAV1Arm1EjLXI2j5GMWxAzMLgyQyuxwJk1J
 TJ0CZdJjKz3PLUBeuIpavNls7y54oauG0RW258cC4S2CFIAetl2pXfdKPD416VKcIE57C2
 WKD2tsdpvLLXSP3HYuEe5i2IupqP+adtYUQvt6C90inWt10Cb6l/5D4gP080Ig==
Message-Id: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Transfer-Encoding: 7bit
X-Change-Id: 20260901-fec-ptp-pps-event-uaf-dcc71b5e1db0
X-Lms-Return-Path: <lba+26a9f7509+c8d703+vger.kernel.org+me@cherr.cc>
To: "Wei Fang" <wei.fang@nxp.com>, "Frank Li" <frank.li@nxp.com>, 
	"Shenwei Wang" <shenwei.wang@nxp.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Richard Cochran" <richardcochran@gmail.com>, 
	"Troy Kisky" <troy.kisky@boundarydevices.com>, 
	"Fugang Duan" <fugang.duan@nxp.com>, 
	"Lucas Stach" <l.stach@pengutronix.de>
Cc: "Simon Horman" <horms@kernel.org>, "Phuc" <phucduc.bui@gmail.com>, 
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH net v2 0/2] net: fec: fix PTP clock teardown races on device removal
Date: Tue, 08 Sep 2026 10:37:56 +0800
X-B4-Tracking: v=1; b=H4sIAAR1n2oC/3WNwQ6CMBBEf4Xs2TUtqRg8+R+EQ7tspR5K05ZGQ /h3Ab16fJOZeQskjo4T3KoFIheX3OQ3qE8V0Kj9g9ENG0Mt6ka0QqJlwpADhpCQC/uMs7Y4EF2 lubAcjIBtGyJb9zp+O/Ccof+GaTZPprw/7rXRpTzF92Ev8ij/ROqPqEgU2GqrVGNYaSnvNHKMZ yLo13X9AKAq6HDQAAAA
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.16.0
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.9.107] ([111.42.148.30]) by smtp.feishu.cn with ESMTPS; Tue, 08 Sep 2026 10:38:00 +0800

This series fixes two FEC teardown races: ethtool can access a freed
PTP clock, and the PPS interrupt can outlive the PHC and netdev.

I have kept the main Ethernet IRQ issue discussed with Phuc [1] out of
this revision. His PTP initialization error-propagation changes are
also separate; if they land first, the new probe failure path will
need PPS IRQ cleanup too.

Full x86_64 kernel and module builds passed with W=1, FEC=m and PTP
enabled and disabled. The bugs were found by code inspection; no
hardware testing was done.

[1] https://lore.kernel.org/r/CAABR9nHLcR103aADF1WMSEkw-_BjWB9vyWXENJCYfjX5Wz1nkw@mail.gmail.com/

---
Link to v1: https://lore.kernel.org/netdev/20260904-fec-ptp-pps-event-uaf-v1-0-9af446be4a11@cherr.cc

Changes in v2:
- Drop the ptp_clock_index_by_dev() lookup and unregister the netdev
  before fec_ptp_stop() instead, as suggested by Wei Fang, so the
  netdev callbacks are drained before the PHC teardown.
- Use -1 as the "no PPS interrupt" sentinel so a valid IRQ 0 is neither
  skipped on release nor freed when the request never happened.

---
Shengzhuo Wei (2):
      net: fec: stop the PTP clock after the netdev is unregistered
      net: fec: free the PPS interrupt before tearing down the PHC and netdev

 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c |  2 +-
 drivers/net/ethernet/freescale/fec_ptp.c  | 12 +++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 548e7bcd0c5460ddcbca9600cea603ebeebf4da7
change-id: 20260901-fec-ptp-pps-event-uaf-dcc71b5e1db0

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
