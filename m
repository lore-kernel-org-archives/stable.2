Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683E369D7A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562241; cv=none; b=bTmGKXIPgRzR9Hn60yxLbJy0tfDf8xU8v84YB7x8cgNOl8aauXr0MEyqz34FHoHSygAJZQbFKZV8FQb6A5WBAP9SecWPZA4htxT9rhwsFUr5D4+hGQ/LfSq6rHCW/WwA/kcJbSY0oYe9agG3vmUJekiPzgoJCmU3hMKj2K7Oe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562241; c=relaxed/simple;
	bh=ZCY+IOuiVdsZazfSLPCfkgoRPfouuZCc8XLFx247yvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j70xdL5Jex6vzGVG3R31UYkgbMzDu4sLiV3RG2tzhIrQBxDfmJMAo8H76Wr5YL4I9Zg5ap1IPJXU7jZjFbV0WNMNE/dnTTuAUX1PGF7w4VKbdo4UOP/pDIfz9Dh52P6WguMPMbF8KgoU9pEvGQKaRfHp+S0p+I9zmenQKc7J7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpd6cddL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpd6cddL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5138B1F00893;
	Thu,  4 Jun 2026 08:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562240;
	bh=5yFZW12fo8Pbe/X7ZrhMk+4ym/tFkZqNK27mdB8y8I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fpd6cddLmN6N/U/XHJPkscNI8MoCe2BeiQfXQ2WRffmH3QCq7jMPaK0kdxU4QXiPK
	 2zQqCFZz0ON1ot1yzZRyD8IfKo5XFyWTQEk+OXd3CSzBe0UNvyfZXJgbGgfJeq1tIl
	 FSjfEbQRi7TPBpnfiy92kA8X26sCyqgE/AesfrAVC+DWSC5+/F1RCq86cBRcalx91s
	 xXq43SBwn30RKpPyLvypgZppfw0Smy07BS5jIjhHKZEVP4ysx+UkYwGT3sQMPgui26
	 uOLLt8q96Yk9xSlMTY3k/ZLZ/pxHMQK9ttziCkXXdv+n9pSO18wr1t02nLAByHF1UP
	 gfcLD5esbs0eQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV3Zm-0000000B7Sf-1Jpe;
	Thu, 04 Jun 2026 10:37:18 +0200
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y] USB: serial: cypress_m8: fix memory corruption with small endpoint
Date: Thu,  4 Jun 2026 10:36:36 +0200
Message-ID: <20260604083636.2650249-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060436-outcome-uptight-239a@gregkh>
References: <2026060436-outcome-uptight-239a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e1a9d791fd66ab2431b9e6f6f835823809869047 upstream.

Make sure that the interrupt-out endpoint max packet size is at least
eight bytes to avoid user-controlled slab corruption or NULL-pointer
dereference should a malicious device report a smaller size.

Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
Cc: stable@vger.kernel.org	# 2.6.26
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
[ johan: adjust context for 6.18 ]
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This one should apply to 6.18 and earlier trees that lack kzalloc_obj().

Johan


 drivers/usb/serial/cypress_m8.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index e29569d65991..53f27dee35e6 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -445,6 +445,14 @@ static int cypress_generic_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * The buffer must be large enough for the one or two-byte header (and
+	 * following data), but assume anything smaller than eight bytes is
+	 * broken.
+	 */
+	if (port->interrupt_out_size < 8)
+		return -EINVAL;
+
 	priv = kzalloc(sizeof(struct cypress_private), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.53.0

