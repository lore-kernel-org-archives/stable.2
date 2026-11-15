Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736676;
	b=WJRSS9P+mkjkPFN6ftdwcfCIBjeA4vYxUYdrE94IXkkeqQH4gsEK5coW7WNaBwIDygzA
	 4rGoT0yeq0r7e7t+N7KJVZ8SEOV15pcxaPPUHRupo1PAz+Ryo40CVXY26u/p3aBCnXMdi
	 WvyGo6OIpJrCmpocCnLxW3aQdP3U1uofJDHicgRgKHm/u+Y6GkAD0c+5u6m5gxKpcrN5m
	 0Bo/5Nk9KnU3+WCJVFKqEC0eWxq+/pz4NLDjzpzszSV969lMKGXW9KYSCp0B0m+Lwq/yg
	 ze6R7QBbjoENjHtPkh+A2t42F/l3/a4khisThnHisJBpaSxtFNHYr2pZk7JHZdvT3CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=wrEezkh2FqOZ5AVk117fStcd3GyFNgpx6FJHQLyjcEl2buINFJJdFDVa8tE4ELpyjppx
	 5TSHQI0iSO8QpgWsfYogE2IfHsvUMByzRJasJB5zFTVPEoxISq2Wdt8UyTRqYSy73EP08
	 lKpc6lXu3UJjOzIoKS35UlpdL6Ae83qmiufutaHJRUa7Fpd2W9Q09OWaQqcCHtWDdzRJD
	 DyxSyGvpFIgueyioWuUN0y6KvRyLSWP+p4ICgzssr4IPxCnatPA1hEUZFu+eSjqkXynfT
	 IksRH34BcvbM0czduWDxSB8/1Niip1U3LCnHZuSSw12eHpETW7D3eW7cMjMtorsMWVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CVyazAM8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C5606A899;
	Sun, 15 Nov 2026 09:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4C5606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CVyazAM8
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A4097205A0A;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=CVyazAM8Abop6VseKTraDswZIGXjucAG6MzYY0dozdeKgt906sX4NzlgWMyJ5jkjQne7rx
	jxMPDRgPElVrmnevnTl/1EvREAIqvM4Ie4gc2Oxi4Hv/3hy9VRrwBqGxPh0CSuGEfXq4Aq
	c+Lo4epCS21eitAXnPabiLNcBefTHTU0r+zctTzhoEbPvIuG8YG/PRw7O8mJrhSzMJIpqC
	gd7VoA0PStvYUifANhenmx2Fsfn/mi5+djL+kmkwIj1Zjwrs5gHSrhrKYoDiLrXWs+PDA6
	0PtBWTaJVexePIah50MdtchU6R7kSqJVtqwZj71iX6yMdRIHtDUR1Jfzxdq/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=EcsQyuX23YXzvRG0CoprClm2Oy1smAhpve4aoHCLnxtwwnjHl6zX7EJFXIFavjQ0qHgo/y
	2rL/Fh/GWJSUcMEaY41+2efnmfrhR5MOfLKhOLCe6RyKuz1BeEDYHjpHIJFeAXqFET7lMW
	tanif+I//h6iUwTy/5saQHh/2Hno/90oT2QWoO+eFwd2zN6/jSZLmk9mEJuyDzD1W0YQ7K
	SD4pCE7xxbifEZd5LDOa4xcBJiVeLPz+Va+uNorbnZSYNwKwwJvMhwk4au89J8sNjTJOvD
	i44QvOzoG8sd5u/8vytxO3NWmUkvTcsjmBmEzzfU8isZDCDyiF7N26WkIJNDmA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=a0QUsFzyxjfFAvwvz3bV2gwDquHs4wAhGX7xoFu/14b76OCXRpCOIjWN8TCfPcCJRltjOT
	Dav+vJr0hK/cTPRevN32htQWT5ugjWBbVK+g6xmwXGcI/AFhkpFgsOwcyAcl6Hl4EzpyyA
	wSSisDuvvw6gfmwsxIYZRdgho31OhvkyQivDsuwwD3s6miQDirgBHAJVF1Kh1IdOrRrCO7
	eYmqMDNqzUKI1spT4OtLoIcAOcTJmcJmsfaYtqGF1bdXZJNe7Mae6r0AoslCJDa9a3GhBW
	LDJ+IoBkz6apP4bH640xenxamEE1Vywe0V8QSj83RzSrgazXifPGB4XWlaxhmg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWT-1b;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 464025EC255;
	Sun, 15 Nov 2026 09:57:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH net 9/9] can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
Date: Sun, 15 Nov 2026 10:55:00 +0100
Message-ID: <20261115095746.709371-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115095746.709371-1-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver allocates the transmission buffer using kmalloc(), which means
the memory remains uninitialized. Then various headers are filled and, but
only the actual CAN frame data payload (of length cfd->len or cf->len) is
copied into the buffer, leaving the remaining buffer uninitialized.

Fix this information leak, allocate the buffer with kzalloc().

Closes: https://sashiko.dev/#/bug/linux-0a8c0e8a-c623-426a-8db3-f55111f6cd84
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..15f28833f2de 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -861,7 +861,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	if (!urb)
 		goto nomem_urb;
 
-	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
+	hf = kzalloc(dev->hf_size_tx, GFP_ATOMIC);
 	if (!hf)
 		goto nomem_hf;
 
-- 
2.53.0

