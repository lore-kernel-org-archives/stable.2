Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417840;
	b=zagQ2UJ9U54kSj6KAut+pvRxEGXdps5ucmydLpFrrHZwQnu4pJIYorzGEqG3Swgb/gDK
	 yMuqBfBAoE0nc870gvl99Hq1APdtgy8Bg6pDl49lNgO/zFd9KDOk/J0azxZO9cSL9yUvl
	 r39+qAqwtcbYABdkKKpvKVsfv0oJItgkYJqgxZiODFImwDy+ahi8+zFDTFvDxi3ZObAVB
	 lW2b6gLMY+LCNlREjzs58u+mvoul1aNwcZTJVJGUvt4oOo+NiYXjJKqDvbd3aj6pMgnqx
	 pG7kyvew9Z48M2sVnGm7x/0DLnPdSpIIayBaOLziObORU4BQS+g/dkoWoio1uWONsKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417840;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	b=vOAtmQ+rdgjJ33tRt/amZrtrEaGGCg+a3ZLHpiMCsLZcPRb1l14jBVkjjDpjYgjnmZOE
	 fKUfC5svEmvAK9SIJiAlUnQ3mH+2mxb3AHWhlOBK6UiprzQU0H+7X4Fk8OZCYEky2MXq5
	 wJoxqCwXjaXUXZ20lqeaho1eRHu/9I0DAgple6oedTsaQqz9HvqVbHtTcTzr4LP218u+L
	 /xr2a4NobY1AISoC02BwaqnntFp010UmnZp2gCq4E33sSQ6iKshVu4sIIGF3C5oR9psV8
	 UDt1bGb3+KAuqEFYdwgLJnQrz8gznuOo7XHISX9eGE5ouhbF9fV7dfpfQft/CSkJnEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USbhCSdq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2A606A89D;
	Wed, 11 Nov 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USbhCSdq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794417840;
	b=wawummk5zf1zOr7V4/Nf6mPl7a5QgEMtCXt/bVig5hEMh603ixTvoHBfWZk3s/cHl8Qf
	 1YAOtbSXZaOVeOBBN9cmWQ/zwP7glq6096zqfocdAwag/PUDruiW0X8NW+nUWm7TQjwg3
	 Ohm9Yt5q/4RFJ2GsXCXPHFbRXgNU4+L8+JvnmheKtA95Fu3DW6byVt/UHdQLxIQO9JaQp
	 QA1swZjOxZsjtbMwwL5UW0r/vNOhWM6gkVeq8HuPgdGtv8X21yvZtqb4KRxsT9/OFdNB/
	 YMmNR+iBWnuo4WsJitEfvQgpUJmnMxEdldBpAT3lejJwDBWSjXPPPxpq/wplF7QcwnQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794417840;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	b=cW7Dv0HUR147/rEJUt376JiJVehvvzZzdVlGfskdehIyzWS9e0zInlmL4YfjViiquMlb
	 C3M2yvUmZ83a/OIvzDKEk8+RJmyXvnxa1Wkse/exNx1NdDyqCSuPptnncJ8xvJ7dYkOiD
	 6J39g2IRz4rL0JRJrU5cIrV8kp/9BhsHuEWJgkWCXzQYvL7fLcJCNiKww4ZbFIZfr8Ioa
	 2WHkGlfTeJPhFyZkLGNZcPUuxwD2UkgD3qIrcFH16B8prEgPNYH4pZ0bayhMiPL9cPWaZ
	 ALkKAb1RTDkJVw8WSVuatAupRswQLzJusrAl7lXn3y4Dw7ZlMj1KAhLyOUMDLIWAjcg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9B5181F00A06;
	Wed, 11 Nov 2026 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417840;
	bh=FQRPAOczeChNohAnaECEMnatXU5EQobFRvNRBtV70cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=USbhCSdqhue2ub7hBt+q5xeZUEQWXyG+LWPQ+jyU1nW0jc/LdaO957hNc3pj1JEhe
	 NrXXTJd3kc3bZAnaUGGZ7Jy4W7PoQdpBT84+9pJOXySQ+b76DycXW7qbABhJRWQZbQ
	 r/10bbEGiodWttbnAzS4JDsy0FOGFh28+Jqi/AaBDmuLFTr7nTBP1GjhRXV+dXgJqF
	 e2IjGURvHHJxhW7nzNow/SwV7vYhD/r8g5ISu2L8z3d7MT1p5cepTS+Ulfzf1Jxsc4
	 xPlRYyXuw1ofbiCIOom4wSLJoG2qHRYfXgnIkbPA0P4ZKcLHQ6nCyUqVmamUuOCXkU
	 vFGSdBHaUophw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2643849055;
	Wed, 11 Nov 2026 17:23:59 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:23:59 +0000
Subject: [PATCH v2 2/2] can: kvaser_usb: reject devices reporting zero max
 outstanding tx
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
Message-Id: <20261111-kvaser-usb-validate-v2-2-193dc10ca19b@gmail.com>
References: <20261111-kvaser-usb-validate-v2-0-193dc10ca19b@gmail.com>
In-Reply-To: <20261111-kvaser-usb-validate-v2-0-193dc10ca19b@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794417838; l=1920;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=CWXGNrvsTmGzERh91MhkIoNvIPE1iZLcRy1k5EnUGBw=;
 b=vNchyjTBxRedrlTdKJ6+cU4oyOinGs+bICZ4Dj/cr5o1SicqzOQ5RNWhk/MrIOzNlJMffsBPb
 pAQists5UFkAnpLhpAFmyC50h0rgx410feYgy03MlyL5MZHUzHpyyio
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

The number of tx contexts is taken from the max_outstanding_tx field of
the software info reply sent by the device.  The leaf driver uses the
value as is and the hydra driver only limits it to
KVASER_USB_MAX_TX_URBS, so a device can report zero.

dev->max_tx_urbs is then used as a divisor when a tx acknowledge is
received:

  kvaser_usb_leaf_tx_acknowledge()
	context = &priv->tx_contexts[tid % dev->max_tx_urbs];

  kvaser_usb_hydra_tx_acknowledge()
	context = &priv->tx_contexts[transid % dev->max_tx_urbs];

With max_tx_urbs == 0 a tx acknowledge sent by the device while the
interface is up is a division by zero in the URB completion handler on
architectures that trap on it.  On architectures that do not
trap, the index is not reduced at all and tx_contexts[], which was
allocated with zero elements, is accessed out of bounds.

A device that cannot accept any outstanding tx frame is not usable, so
fail the probe when it reports zero.

Found by LLM-assisted source review.

Fixes: 082d70b6142f ("can: kvaser_usb: Comply with firmware max tx URBs value")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d0a2a2a33c1c..a915e529290b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -977,6 +977,12 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 		goto free_devlink;
 	}
 
+	if (!dev->max_tx_urbs) {
+		dev_err(&intf->dev, "Invalid max outstanding tx (0)\n");
+		err = -ENODEV;
+		goto free_devlink;
+	}
+
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
 		if (err) {

-- 
2.43.0


