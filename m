Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C140D583;
	Mon, 29 Jun 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737139; cv=none; b=RYIINvujoDLapewSlJMXpXMzuhP9KOFjyFQJw3aYcD42hOevK77CTDPCq2vDMbCWdGNRzQR/sLPekcK9AHwgJBJu1zptBCcMWzMZtHYyibKteiNOfcMUKnFrGgd6nsGOcKptH/795B/kHojYTOpW8FwRMauIpNOGmnqg0tSry+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737139; c=relaxed/simple;
	bh=JqnUCp9NHegTKtifIRvOmaNsg7jrJXmvZNcvYEDtA7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKHY/zgU+8Wr8hsUC96zFaduhYugwehSQr/dqJ9SoEdLXHlmhOe/N8YoVjEfb7xiOeu0ZATTGcIVGTkVKrlk3pAIdn31T80LUo6jDslRQSjMalKtFzSuxxCNchcXyz2YiGDioOAPy3lFuPVon/RUiN+UGLZ7OfV9BVfBLYhdO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH+tvkoq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH+tvkoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DA11F000E9;
	Mon, 29 Jun 2026 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782737138;
	bh=ZXaaX3OylUoeKnjHd0RcDoqhdodV7vKZgIr4/0fW9Kw=;
	h=From:To:Cc:Subject:Date;
	b=XH+tvkoqXRZspX9JR9awHGs9a6A4qAXcKrxVEjJROb+2usi/vVIp3hp5nqrOd/j2g
	 syf92922kF7/eJX2HYmnQAq6upohawzsDmzPKEHRF9fzt7eq719OSxd38mVcy+JRko
	 NaAB99s4j+2L9ozDbtdI6hhjV0xDk7LPpQsVvABzv9bnBgJ4di0FcCl7wCdJrQJTb9
	 kDqkjzWqJP/dgIZeVjHc6kQ1OtPs7dCQ8HZm6P7zK3sDvkR4+02C/gKAar7nSzBrME
	 QbpiB2qU8JDAGprRb7og+xl+DrSt0CWatRRTF9AQimhLBIvu2w+U3PvEcoh35Bhk5W
	 312yscqztGICg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1weBMl-00000000Pbc-2G7D;
	Mon, 29 Jun 2026 14:45:35 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: keyspan_pda: fix information leak
Date: Mon, 29 Jun 2026 14:45:26 +0200
Message-ID: <20260629124526.98415-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write() callback is supposed to return the number of characters
accepted or a negative errno. Since the addition of write fifo support
the keyspan_pda implementation will however return the number characters
submitted to the device if the write urb is not already in use. If this
number is larger than the number of characters passed to write(), the
line discipline continues writing data from beyond the tty write buffer.

Fix the information leak by making sure that keyspan_pda_write_start()
returns zero on success as intended.

Fixes: 034e38e8f687 ("USB: serial: keyspan_pda: add write-fifo support")
Cc: stable@vger.kernel.org	# 5.11
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 3b99f9676c35..f05bcce60600 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -516,7 +516,7 @@ static int keyspan_pda_write_start(struct usb_serial_port *port)
 	if (count == room)
 		schedule_work(&priv->unthrottle_work);
 
-	return count;
+	return 0;
 }
 
 static void keyspan_pda_write_bulk_callback(struct urb *urb)
-- 
2.53.0

