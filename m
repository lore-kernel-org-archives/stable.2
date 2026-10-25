Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957916;
	b=NKDlqOts9FSnDBZSP1mfziq2QucagcA4CoFeCVFGB+TyIFteUFojQj3Nprto6+UJLLGW
	 5eMN6xzYZehojU2KHnqqUNEKhIXpmF3MRSkSWi6TQ2t+5xbhbLplMYLynADCdNiU+Bc77
	 6AVqkN6ANJz3v7Lul5z+vNxhhft1R4Qe6FOO0z0J9SN2WFk3jeJO7rsTCxKItJ2GgA2xZ
	 hCehutg2OAGQ6C1SYxuy4RYmTtdMuLll6dp8Kju1I701ChgPDsEZr8U2NceglIZoZe9I2
	 6lCWOjKWjpRMCCWem6XUiu9aBu+RG8exLHfvV4iCexqWOdEK0VojTqZGCo+sikZFp6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=k+i/n5kE0VNFyHzROi95cXyBD/Ug7QHmQK5qbkHZr6A=;
	b=rt07txR4JS/kvF/nVGpFAI8nUAdbNVULT/H/IKa6AdFGcZXeA7hs69j5mWKNShd6fqK2
	 NUIxz0gqZZPlGzaloh5iD0NgmBrRH34D4nmP2+a2L/FQUldvtxa6P4sXtteWEdiYvtqKU
	 fwTYE9ZTfSP4scdwSjcP7Sm9HltQNIrAvuuQXIbkvrGCnh7ld6aVlgsaDrGDw8SeoMHc9
	 9LVy6U5qF0cXduINbNfTUwNlxfSt6EdA5c726cfiMXApWuDORMzoHuSrN9/RK3eM/YFpE
	 EuVGBvW8/xN8f2eQBwPChA1XaZhnKSLYtF1thAbVdevqt/cEuofZs/sXGmEQEjvHTJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OapCd1xA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D7606A31E;
	Sun, 25 Oct 2026 19:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53D7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OapCd1xA
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C9233200B9E;
	Sun, 25 Oct 2026 20:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k+i/n5kE0VNFyHzROi95cXyBD/Ug7QHmQK5qbkHZr6A=;
	b=OapCd1xA1K/q05VDjplQJ6i2Rwv4Se8jYJYKcNkELFQb9sC4FHPlkfSpJyB1XSzhoe918F
	gkwwDDmXY9oMEjQ0J1YZdSDtJuCEBRP1LN/8n+dqOBfX15ppO6h+Ahv1yeeGKt0OwYFiM9
	946SQfeP4lMg8IdW+fXun5kJ+g+a67R8xQVJkMVgxrHp1Tm/0LFaeBwftf/SwJHT8oCH8d
	ovhriYMAF300A7kAatkTF1S5hJG/OeS3E7Wnya+sjFHySdVszycz5dusOLNzu1IvJG4gAO
	N+W+vJVF57dPC0RSQ3zSELgfC2fuLRhtZxxXbSc1vdhpa+f+LyH0lkKi1QAecQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792957912; a=rsa-sha256;
	cv=none;
	b=HwQ85aW+a9FCeGkK+KHjuplDOslEMAyg2F0igVIj7aSQm+PcPdhK8otfPDtCxbeF+VoiNj
	mc/EkLoqoOylkdUPDVAsS1DUC+abWNm1almxGyfGqESpIccCSTPRsfGUR8ztm8wCIT4pLX
	0d1IHZb+zks2NqYEJ96M7hBB2LnARaGK10dWlzqYqSL3Nb+IyY3xzMTerU7SsJZUcM3rrn
	mXeYyOJN/guecT+i+xDZnxJcuLyjFllnJpBDQBvyf13IZq4fJPruUJGCUErrdozrASjlkI
	oAkXKCCerE9apJx/q34/Er51rwbq5ziUZ91LsXHIq8RMCES18AmNhEzVgOxU6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k+i/n5kE0VNFyHzROi95cXyBD/Ug7QHmQK5qbkHZr6A=;
	b=gPjZT7/SkCUKgBZk4+yr8aWzlEddVx9bOa1pov259vmH5ujm0t4QA1aBMrHIi20NEiozzS
	PfWtzmORJ5NNfeGkp8VLaHk8V6uUVMyry1E7O2R9XzyxUucOU2D3VIbEjoFbhz4KwQMWOB
	3kDGV95ozFR+9GkOIN+Q9SrXpdC+5z52FwMxo5LZ92Zw1hEP8dEBByZ/wn6Wx+qLd+gN+J
	H0r5D+manIRvz6niKtScKl/mHJkLB9pgNtE7yOagw/v9dTS99ZpUVA5kCFpZYpkOgkU77R
	va0GW3DMjH0EHdVRjEP5mUX6IQPOgbCXGvW49o6FR1Wc+glVGyZjUqqmN/UaIg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL4G0-001AwN-2L;
	Sun, 25 Oct 2026 20:51:52 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6F6065D41F3;
	Sun, 25 Oct 2026 19:51:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/4] gs_usb: fixes
Date: Sun, 25 Oct 2026 20:51:40 +0100
Message-Id: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw6CMBBFf4V0bbW0PAwr/8MQQ+kAY0LBTiEYw
 r9bYO3yZu65Z1ZG4BCIFdHKHMxIONgQ5CVidVfZFjiakJkUMouFTHlLr4k0b3AB4jIVjbrflYp
 FzgIyOjgOgXiWZ6ZJv6H2+8be6JD84L6Hb4733p/pOeaCN3kCWpvEVCp7jGDbybvB4nI1wMrtF
 Dj4TOFtf1qZrgh4PfQ9+iKy4LmFxd/6Cm0gth9t6JTj8AAAAA==
X-Change-ID: 20261025-gs_usb-fixes-250f38833107
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=TTLjyYepNudqi5WyFrM+foP9J2BkeGn/6lO8B58AEhI=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6F3tx6iRZph3Ws/r+/ekOajZ6IiLuW8Lxf3EET0vv1
 kk1z0xcOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjARHT5Ghn/PNxx+8Ov+aw7+
 zdqtJbLX5kg+3mF5YPO6D3FH91Wd3FbFyLDoRu3nM8f3ZHDsD1/6VvnC+QVHTUKPqcldT3psXn3
 7VxMrAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Hello,

this series contains fixes for issues found by sashiko.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- patch #2: add missing cleanup if register_candev() fails (pointed out by sashiko)
- patch #3: do not increase rx_errors during OOM (pointed out by sashiko)
- Link to v1: https://patch.msgid.link/20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de

---
Marc Kleine-Budde (4):
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish

 drivers/net/can/usb/gs_usb.c | 74 ++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 23 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

