Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791287;
	b=UysvrZaeYHWMXH5gISxAtBAdtSbvfY09Lw1E/S6H6tmNBShtD6+oomTCIB9YQUS2XRRj
	 SHfuJE8T6UGFtnW8p+LiXlp/3SaOg5/eUDVGbSp77MfIihRPLJfBPXylphdaQnDU/821r
	 4GU/B2465Tq4MCUohbNlI40PUdkTEWVYqjE7x/FfaDTC6rYBk7IrV+vOtAUEy2GIdkPE3
	 lS5tS5H9zolsJjWOI49RX5aV+GdzZX4Kg+8GbrSHM6Hx/GBy+ktXp0jVx89VvCx/MX1c5
	 D9We/L0cI20cN765NHqzhXcCVHWy5Z0f0dpmc9ydeiRQfMpo7SvwGfi+3wU5dqRUHag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791287;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=mj1EQmViELyAD5iYnBsJNfh49SKOx/sjji9QC17NZv0=;
	b=jJtx3tCp76fX4iV9pJCDLPJXbe5+xfVYdEn97Rwk3KsGxxmpdZ6jRijcvxqeEq9ztSxN
	 fvgtf5Yw64r7//KSmv1F9kdpclo5HVzta+UVAxeWKe0pSky99tXGRoLjjv6/OCsfUjTiv
	 M/oNJHOg6isb/KNN0uLlMM4K/lR+NIAGyGzIfuVbX/WfrAHBA5u8s4lxyOLvXrniNYvWD
	 POdbINP/BkisFS6QM8goIcfi8TY8ukZ3/pJMVtwbDsyFjc64HcQYcdkd2OgO7+I5CvWEw
	 BfBeFwmrHKJUFrM1QTcV8fxu0Au9EMFg0jFqz5vtenU0TF5qGAtEVWvtgPtC7C6CfIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=ENx9zle8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="GJW/ZBpb";
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219D606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9219D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=ENx9zle8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GJW/ZBpb
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC5667A0510
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:54:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Nov 2026 09:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1795791284; x=1795877684; bh=mj
	1EQmViELyAD5iYnBsJNfh49SKOx/sjji9QC17NZv0=; b=ENx9zle8aIXxyTbnnH
	YdGKpIEqdDZlEnJM0rvL+e3iWc8trT1Vxyp1MiQEWxGBd3QOvBYcZVJQ0HN94RoL
	lN+wHCKGFDolH6neSAnVCaxJk6xJRuvyY0sqUwR9RHRpDSV+/LMsApK1E3SFgEgA
	EoZUtTDt7Wgs+5O8cQGpvpzI2mhqQqQ8gkwKrvo7gMqNExHR9p4/6B9y2iNVKDXs
	xtk2+BcOI/ymJ24VGLAWY9UNvQAV76ruObWH3baV/XSR9j7ZHFMSqcSp1MCpsijo
	J4b8DnaIB4bYOj3Dl0c9/Obb4fS4/x3MCyI2yvFqi1E/xObxJsFsYAOePQZNcySE
	bviw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795791284; x=1795877684; bh=mj1EQmViELyAD5iYnBsJNfh49SKO
	x/sjji9QC17NZv0=; b=GJW/ZBpbTWdtBRg0gR/f5628xHP4uGBeV5353eIW95A0
	tNRCmWhsvUEdwh/T01WhriZez6rvVhX/ERN6xzUEEO+G0iWg3662Amasv6u1OR0e
	3Xx8LAubp4tVLMsbbgu1m+ESABSlOy+2asqU2DRIJyMF51LxYqN0QUITHnJpU1n6
	J6M/rGKSZ57mKLKU/Uq6Rxf8aiczy4ofGpRbpBMQxQilIrLM1U1q4wzy5w0O3ydo
	owAHrwgt1ibTV0EPgT238soAN95GjenZtRgBQuUF0QBaL3PdWBdvEY22yLBf0CHV
	M3DfESjw0SlkfQyDs4oMuHeePNIZodAcroBJgVvOlg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795791284; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:yL3HlpTXV8nnhOoHo/Oqm93KPrX+AnjrkUqlmEuPalJS3lo
	rJV8+Z7/wCsb9RbHA/f9l/qgB5yXfw7sOr9DM1uVa0UMSeac2kl48eWRWLj+BWc2
	4oP0m3hWj5XRJbYoTpOQ3dBkS6iHIB+HpWq1H9czraeVZgIlXtVdGi8LdK7EQW6w
	/JXV5zWjubaGjlMHwCAM7NT5bSu0t7MWejdzQ2cFHCKQJ4vlvFlhh3ZMOby2CqvG
	9PYBxMdMWb8apzWjWB5s/6vIELdZwc7GqElfwdHa4Wpfu3RK4F96M8Z7kTwXzfIw
	G1+YOpPfjD/T2fr30wX0Z61dbR2fcQr1BVU85Lg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:8/SsVL/DbJjvbplJoqW6Xt8IUURkG66Bhy2G2i1BTak=:FaWlkVcfhTtU9BJPT1LZeQ12lOoelPb3QEQBGCTaiRI=;
X-ME-Sender: <xms:tJkJa6vxcCjManfiy8BtKgicYOHpTJWzMudlsdPYb4rv53gSSVkTHQ>
    <xme:tJkJa1f_3J3H3tvu6_5ybFa4n3NUabLArF_NCUI1Gl32XDDXDGkM-nPqdu27-2Lo7
    nXvjHaUEQd84RozpxPt-G_fZIPnAwgonq04dMf6tjkw_FSyu768BeA>
X-ME-Received: <xmr:tJkJawlLdS5P3naLJKVGonWZkJpFxiOtt54wQIg2W9lhM1FUP9IPEX8QJHVj4qTWoO3Pd2hgEQI4t9q536BieOFbnPOpi6x6MrBLyA>
X-ME-Proxy-Cause: dmFkZTF0QC8QVKNfBuLTGkJVP2tTAySO26mjZ4x4FEVqaPN8CHJa7609vVOeYkLNPBMoGl
    mzB+HulYp5iepZqn++bL0MYQtsnph6YPi4avuVfPo/2ZNhOomHdcQj3O2VNJRPDYvEvdCk
    dH8nRSIWH3UhPg+STllE7j6tzpPeUdEfIO0vCu4oYCCS+cq7lFAPCs7Msd8PnmhR6imDrj
    odeABito1K9Iua0dgo+Gp0NLoRbsYpd35fe2PaCLWHPIYRQLXwOQCrxNLkWrXJYL3wsN6Q
    iEhOCD6GFQkKb0x8Dga3iSjRYhFluDpFCaNeteCVp2M6KTiYCzKRrrA62hDMvXVnR7FFOa
    /OnHygwTDDSwjaBhLj18p/reuTlP4bbyj+grNqQ5UjmAE0TGLCHoSFYkF9KKJp91oqxBts
    6a0sceJ2SisRw0VrI6pojCapz/cp/AuLHqcRUERJaCPD+tg3O/ZCPqk9KbuyOGJr26Zn+n
    e3iq4mBCnwYzDIXm/DY9jef+TmeuYmtgGhAgGOiAiiYC/rpljt6KzI3RS+odO4dl3QbQ/7
    eDvs1+fZSliwLAVFeonl95VthlnXwiYFPseuREACPt27pA3WkVqZXaa4JRjXmESQ00dsot
    q6K031n25Gh74euhkA7A4B2scIM0VsToylV53ox8nengpDz2CzFAJoY+/Ieg
X-ME-Proxy: <xmx:tJkJa4AZGebXA7x5-4N1xVerB-8NSmbSj3IVX4Y3if9KCi8MFfLZ8g>
    <xmx:tJkJa6OdE5FkhwyjzT8brDYhfkNA4q9ho8xrKb-XDfJ7pqwkapOMEg>
    <xmx:tJkJa3MWt3OqRfgtTUq41_28FTERey-wVKsH8-eaWV0F8lYm6jklCQ>
    <xmx:tJkJa6kkciZQazEzUBZAQ2oBuKy26083X-8HCTf3XaUiyzJsfydORA>
    <xmx:tJkJa7rPrN6jzU1XbqCqBmm6d7NQgutfgzmj_X_xhrSGhvv8AsIeJwmR>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 09:54:43 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 0/3] net: atlantic: AQC113: Fix regression on Apple
 silicon systems
Date: Fri, 27 Nov 2026 15:54:38 +0100
Message-Id: <20261127-net-atlantic-aq113-apple-l2-filter-slots-v3-0-b5efbc124dcc@jannau.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/53NsQ6CMBCA4VdpbuZMrxUsTL6HcahwaE1TsK1EQ
 3h3I4tx1PUf/m+GxNFxgkbMEHlyyQ0BGqELAe3FhjOj66ARoKSqSKoKA2e02duQXYv2RqTRjqN
 n9Ap75zNHTH7ICSu9VSWVbanJQCFgjNy7x0odjoWAi0t5iM9Vnuhd/0AmQondTnFdn6q6NHp/t
 SHY+yZwhrcyqc+ZpPnhrFCiPNXGdFJTuzNf52VZXjIYDlY7AQAA
X-Change-ID: 20261026-net-atlantic-aq113-apple-l2-filter-slots-6342515c5318
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=FaWlkVcfhTtU9BJPT1LZeQ12lOoelPb3QEQBGCTaiRI=;
 b=kA0DAAoWoRs8240vZWYByyZiAGsJmbGhVnSNE2sGrFRxJXWDr+bU1uv7do3F+wGxKO1EDg0q3
 Yh1BAAWCgAdFiEEYivpiACrfCFcfeBWoRs8240vZWYFAmsJmbEACgkQoRs8240vZWbo3QEAnEdD
 FBWgcUJM6p1Qcrwu4CA+X+4N9VwyFj3zYJU5ZvwA/ix22XnOnoMquKCLsxyTD8PMe+MYX/dr5DP
 0SlMk7f8C
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Hej,

commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
slot, MAC address") broke data transmission on Apple silicon systems
with integrated AQC113. The commit uses the queried filter caps from the
firmware which may result in using L2 filter slots starting from
`l2_filters_base_index`.
hw_atl_b0_hw_packet_filter_set() is not aware of this change and enables
/disables L2 filter slots starting from index 0. When the firmware
reported `l2_filters_base_index` is high enough (9 on Apple systems) it
will likely disable the L2 filter for the NIC's own MAC address
resulting in a complete loss of data transmission.
Another issue is that the number of available L2 filter slots might
smaller than AQ_HW_MULTICAST_ADDRESS_MAX (32). This is the case on Apple
systems with `l2_filter_count` == 29. To avoid -EBADRQC when L2 filters
run out query the number of filter slots from the hardware.

The fixes in this series restores Ethernet data transmission on an Apple
M1 Max Mac Studio and supersedes my previous "fix" in [1].

Link: https://lore.kernel.org/r/20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1@jannau.net [1]

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v3:
- fix off-by-one error in hw_atl2_hw_packet_filter_set()
- ensure hw_atl2_hw_packet_filter_set programs only valid L2 filter slots
- validate firmware provided l2_filter_count
- swap order of changes to avoid introducing temporary issues with the
  main fix
- rename added hw ops function and switched return value to unsigned int
- fix typos and rewrite commit messages
- Link to v2: https://lore.kernel.org/r/20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-0-0b988d031c78@jannau.net

Changes in v2:
- Leave atl_b0 as is and copy hw_atl_b0_hw_packet_filter_set to hw_atl2
  to adapt it
- Enable L2 filters for multicast addresses correctly
- Query the number of available L2 filter slots from HW to avoid
  -EBADRQC if it exceeds `l2_filter_count - 1` and use promiscuous mode
  instead in aq_nic_set_multicast_list()
- Link to v1: https://lore.kernel.org/r/20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583@jannau.net

---
Janne Grunau (3):
      net: atlantic: AQC113: Ensure L2 filter count is valid
      net: atlantic: AQC113: Limit multicast filters to available slots
      net: atlantic: AQC113: Fix hw_atl2_hw_packet_filter_set for L2 filter base index > 0

 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |  2 +
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |  9 ++--
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c  |  7 ++++
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  | 11 ++++-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h  |  3 --
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   | 48 +++++++++++++++++++++-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c   |  2 +
 7 files changed, 72 insertions(+), 10 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261026-net-atlantic-aq113-apple-l2-filter-slots-6342515c5318

Best regards,
-- 
Janne Grunau <j@jannau.net>

