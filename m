Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E443BDA1;
	Tue, 29 Sep 2026 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716053; cv=pass; b=rsqtfqjIEqkS9GAqrn2QDg14yTnfxnf5SwRtPQat+r5qINgDp1o1g19gUp7OckQc90r7SFSrpIzHA8hZI3jzyCOPtPkSPcJ7u0b8jwQ5R/5tgTzdcc59aq/It5o2JXNDgQR/cO78Ojd0cmBe9tNvlFHCqgnuIRai9eKa5eoKaYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716053; c=relaxed/simple;
	bh=nv62Kjvjw2Se9Y1SZMQ/l/ptXvFA+AlrtiuFWTfdGlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI9A65ua1Dg05Tm5rUXBma1NHzAIUHw0NSmsFTyWeF0ZvkzSsTfFdPVWG1Clvq6FfjWoffq35TbXx52i/SSf+GWwKJNnQBAdxih5y2i5Vi6VCFNOSEHGc+o8QdVM+L1K2rZkTD1FNBCqTUAdzidoJlghNkrMUt+c70HHuXlIBHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=al21Nl5z; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="al21Nl5z"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 342B1201F2F;
	Tue, 29 Sep 2026 23:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfLX0FVn5KXNuLwBvoZh4vQ7hK3XXJBqTaCubH8TshI=;
	b=al21Nl5zdk2XDHFhB3+mvTAhXTwg6oMZSpdQCB5Jsfqux2i7ZjWHfvhKOm5h4Oaf//P247
	VhyosXLykFUifD1CLtLROsM270bN28WJHJzF0CO1rwi6F179Qn6uDdZ++3XlSo2CjY2f5m
	NQLpPI/Unk07tjnbCEvlioLqXuVLz6bZWNKFNmT8bCqA1SQarRO+NbB8oCmP2fwfOUXqs1
	YwwljbZJCCaToIYVr/nr1qsyIRump3pK7K0tf1egOb2O+9/DKfQ26rt69u/GxdLp0q5IUS
	GBwsQWw88dUIBtq3jXqs8oIQBC4Z53kneluhlCu4YCAq3jublAzq3F88nG+iCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfLX0FVn5KXNuLwBvoZh4vQ7hK3XXJBqTaCubH8TshI=;
	b=Sefnj6akv6yPqDEUGAhA3fgs5QgRhYWyom95LZFqjSZGkXYYaPb6Xc+IBfxrCT7+awzP3e
	wu+3irG7aLjIWE1q2vWzkc7YmpZVy8JRvaOblj+vdgzeQZjfegqO05En/e26v9H/3SUJsD
	XY/dqaafPsPbrhORX9ifv7ZmZgJ1Pu9H/p4IHxZ/1J7S6awcPouN0WndIw/RuP53BdaLSF
	rrQuULl9JgJ70AM0j7cPoTsf+LaQgJlMNmkoPuPIU1XVla7zpkyVHxK2EgU0r22jVj/e2J
	lZ5e/Lb0uiws9dHFE+5O+MxV7SdhGe4Dz1zMKh72hwFunp3YCEkqjHlmIrpxlA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716024; a=rsa-sha256;
	cv=none;
	b=Qko7nqjs+gqEHGsgv5j/ZyCH7LmAHqcx2oVeDfOm3ZY7w66g5/F42f/0wn/V4naNfXp5EK
	vvmSRsEbw/ee5xbtSmT760/uTtSqy3gCcD8LuMJLi9WKBTjzfbfa8Y7eBQDYMwWKUrwf+q
	p+uKxwQBzD97CvT0vH26A2yRZBfuBxF8Vfk+R3VYqwf8NV4A6pZSPTnn2Si8fTW+UnmEeV
	SUXKnmNfNoVcl2eo3AO8cNODl4tsWSfsNSlyqHa5QyBjWCYqtMASQ+7tC7GT1LVvCjgzzA
	dWffD04lwdMPQsUanzLO0dBPWMN4makhB878b0LLPeCbmRHvynEZgbG32G6OyA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2W-003S47-0A;
	Tue, 29 Sep 2026 23:07:04 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B6DB25B4CDE;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20G=C3=BCnther?= <stefangun@pm.me>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 14/16] can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters
Date: Tue, 29 Sep 2026 22:44:04 +0200
Message-ID: <20260929210700.1183036-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Günther <stefangun@pm.me>

When the device reports error counters, the driver incorrectly uses an
assignment (=) instead of a bitwise OR (|=) for CAN_ERR_CNT. This wipes
out the CAN_ERR_FLAG and CAN_ERR_CRTL flags, causing the error frame to
be sent to userspace as a regular CAN frame with ID 0x200.

Fix this by using a bitwise OR to preserve the flags.

Signed-off-by: Stefan Günther <stefangun@pm.me>
Link: https://patch.msgid.link/20260915134551.54038-1-stefangun@pm.me
Cc: stable@vger.kernel.org
Fixes: 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify availability of error counter")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..785224e00c4e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,7 +526,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			/* Supply TX/RX error counters in case of
 			 * controller error.
 			 */
-			cf->can_id = CAN_ERR_CNT;
+			cf->can_id |= CAN_ERR_CNT;
 			cf->data[6] = mc->pdev->bec.txerr;
 			cf->data[7] = mc->pdev->bec.rxerr;
 		}
-- 
2.53.0

