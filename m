Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738619;
	b=yt7Flmn1/XZch3tEpTBsZZqzo1+tVGT7PdHj/g50pv+3Byz9vlDmYevkjGMVNp+QnbzO
	 Wz3YhNi6cQJRDADn6Aud05Nz2cb1M66itjVDTJ8m90TTAa+vn4mqaxmBkhKwyps9AkvLn
	 qscewj/4GMoAhGjZi8OBlGNVQh1Rsmarh71AYJNqpg4EYzJFAr7QMYMIzFPp2eZPlGH8S
	 5XW9iw2vZqEE+eadokMkvuwDQrOKaimsSkq3bIAAV7O4cJtM46y2gCsnmXUQUULsfO2K1
	 TnwDfmqG/X6zm5a883YvG9l/qV68YGuSklL0+xZR10JZx8P4z37fUwLKnE8F5p0y61A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZGWbMqtxzyzutGZIAT+lDAmzMT4Jq1S3yMZtZEBClnw=;
	b=YHaJDeoia7+WEKvVYVvPwJ9zrhoVqfR2y1wDvsCxD3IEtSkHpWl8Au8/fkusSVIxmj7B
	 Y9FBN8X8IOjruYkxWxS7fgThHuKCi3cXvdHc7bMGjZHIl/qGCk61npOZkGYS9W/fyTQrv
	 eX17P+a9/TR0m4hXfxfn3gMGOdkvJ7X6/QugGChlrCdeSyay5v5OHGMiwHrP1B5vvteQL
	 irt/Mx5bX88sTYZtRigO4b4NQ/cGmR48UB9ZlL0vF33Z6CUs1OR+tBpKLQth1qmWzov+0
	 HrUcYW7YpprEx2iWFD/brUu8P34TcbXfXqxeprTLAR+mmfhVgByjo0EbT/oT6D0fgbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Rtb3qiV+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA8606D80B;
	Tue,  3 Nov 2026 20:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBA8606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Rtb3qiV+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C20AB20177D;
	Tue, 03 Nov 2026 21:43:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGWbMqtxzyzutGZIAT+lDAmzMT4Jq1S3yMZtZEBClnw=;
	b=Rtb3qiV+s1FjvOwcBeqznPYBIwvnHlsMQPPyJtjv37LKoM3Grdq/gCDnU8vF8usvJYkjRq
	ANlYBDOdas3yj0JSJblp2VbH7ZiqkWYU+aQlFA+/Ot4B/TsBD1zz5hPkiftb/+Lg5eYlA8
	N378JwpJru1geBqqIZufBvnJ4u9zII/bOyu9X2AvWfq3R6vh5E7nxGvho85uy6GMvnQY7P
	uEBUgQBkXGq2/Oov6NILH6rKre/auBIo5MlJL9IHcbHzTaAxelZ87MUwfvcZ4eCTYpJgTZ
	LEBA5Rfazm8ErzR9R7BHa4php37Y8qwKmW/d8X8oco2K+eVDKFQtaROuifrSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGWbMqtxzyzutGZIAT+lDAmzMT4Jq1S3yMZtZEBClnw=;
	b=FIcrWzK1gKH539oC3GC7MUwjNB03NquIlrzZ+3Ch9DJbs+hcjDJsF5x9jYyaF7Gb7nX9uC
	3Uh+ffJ0FvKPEEjdH8QMOXqsG5bv1eCpFRj+oBL4+1/2Wkc2mTsd2rjUIpeJENYUpfjf54
	pix++f3qalKxfLlFzCLGAWQ4b36RA1FxOoygnE5q8+lu6t2T+XPLdetgtK7Jtx7SFCrKoj
	pJxyQLD5OOrnshNEX6fek4/5/DP0WVgwQIKU9Of/yEhuqaCSFwzgxep8h5GYPLxxzq0tm4
	V76aTs9ekDEZNgJnkKDjCtxu6WZxKdzdR/aq9uHmnWmGLyPN6RP83rTz5QuSJw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738607; a=rsa-sha256;
	cv=none;
	b=Tc1R50XvRiN0INBOe07E7Pv6J/cPVdlBs09fboGuIhfAqKE6drzjI+CstK4FT8nI+2s3wd
	Ojv6/Z+sXUXn3kYFzyg/Xr6aNzs86u7t9l1c6lHJeSjXR8AxjhLgh407VzpBRLJbjeJjQd
	qHs1X/PXAoJTmTcMa+YZSlD/wo0GeqOjdIi53O09saItEajgYekoULOpb3nJtI/l6zJeTu
	yS43tyc32HmzWmYo5Z0bbVmdU+OV5z3A5tLa5s1W9gwwNNHBhymwQ2yAZJndi5FNvmar2g
	1u91smctYmq6yWm2eGgRqpZvgUR2YXSNuiP84eOHoaYmfAKE9f38NVPlKx4r/A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLr-002V97-13;
	Tue, 03 Nov 2026 21:43:27 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1A72E5DDEDE;
	Tue, 03 Nov 2026 20:43:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Liu Changjie <liucj1228@outlook.com>,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 15/15] can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records
Date: Tue,  3 Nov 2026 21:30:36 +0100
Message-ID: <20261103204305.3211144-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Liu Changjie <liucj1228@outlook.com>

A PCAN-USB FD v2 running firmware 3.2.0 sends a 16-byte status record
followed by a four-byte zero-size end marker.

Since commit 93fcab2c6968 ("can: peak_usb: validate uCAN receive record
lengths") these transfers cause repeated receive-buffer dumps while the
interface is up.

This has been observed on Linux 7.2.11-arch1-1 with matching kernel
headers:
- Classic CAN, 500 kbit/s: 25 decoder errors in 5 s before the fix; none in
  15 s after.
- CAN FD, 500 kbit/s nominal and 2 Mbit/s data: 26 decoder errors in 5 s
  before the fix; none in 60 s after.
- Three additional down/up cycles: no decoder errors.

pcan_usb_fd_decode_buf() requires a complete 12-byte struct pucan_msg
before checking the size field, so it rejects the end marker with -EBADMSG.

Check that the size field is present before testing for an end marker.
Require the full header for nonzero-size records and keep the remaining
record and payload length checks.

This patch was created with LLM assistance.

Fixes: 93fcab2c6968 ("can: peak_usb: validate uCAN receive record lengths")
Signed-off-by: Liu Changjie <liucj1228@outlook.com>
Reviewed-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Link: https://patch.msgid.link/CH5PR19MB997156AB3BE253C3BE445223B0AC992@CH5PR19MB997156.namprd19.prod.outlook.com
Cc: stable@vger.kernel.org
[mkl: copy additional info to commit message]
[mkl: convert Assisted-by: tag to prose]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Built and tested the original and patched peak_usb modules on Arch
Linux 7.2.11-arch1-1 with matching kernel headers.

  - Classic CAN, 500 kbit/s: 25 decoder errors in 5 s before the fix;
    none in 15 s after.
  - CAN FD, 500 kbit/s nominal and 2 Mbit/s data: 26 decoder errors
    in 5 s before the fix; none in 60 s after.
  - Three additional down/up cycles: no decoder errors.

USB captures during the patched tests contained 406 packets with
short end markers. Neither receive-buffer dump recurred.

The CAN bus was disconnected; external TX/RX was not tested.
One startup "can_change_state: oops, state did not change" message and
an RX dropped count reaching 2 were observed during the patched tests.
Their causes remain undetermined.
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 0d46f4ce5dca..39f0740421c3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -755,7 +755,7 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		u16 rx_msg_type, rx_msg_size;
 		size_t rx_msg_min_size;
 
-		if (msg_end - msg_ptr < sizeof(*rx_msg)) {
+		if (msg_end - msg_ptr < sizeof(rx_msg->size)) {
 			err = -EBADMSG;
 			break;
 		}
@@ -766,6 +766,11 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 			break;
 		}
 
+		if (msg_end - msg_ptr < sizeof(*rx_msg)) {
+			err = -EBADMSG;
+			break;
+		}
+
 		rx_msg_size = le16_to_cpu(rx_msg->size);
 		rx_msg_type = le16_to_cpu(rx_msg->type);
 
-- 
2.53.0

