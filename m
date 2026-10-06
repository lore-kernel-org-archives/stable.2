Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3DA54706D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245345; cv=none; b=obiTfDaOSRPStePlcYbzTeAkFgwhfX0vpxaH+0EA5cBB1I54Nf/u82u32OwK1PuvNhXW1cdUvVOZUZWvSU3HqMciKhWka/3iBYokDXM4cY7OLacOMnx3W+esGLPqifCSiIt7cRc+qTbmnHiewuqWIRBKhu1ABkG6qC/ayMl17hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245345; c=relaxed/simple;
	bh=HTEzC+xItDKfHTvj36ZKVCP+nKWEgL75n7V4em4XT0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RabWL6XkaHBD9xKC/0XZFg+X4jT+I/ptOorhnJl3QLqnU6fvweXOA8SNTvW/Y592avDDiLVu7uQqrSYYOtMwni8WxKO1V4IBpJwmj+7c2uxijJnmWunWS5SFE+hiEb+sO9wA/PZTEwPWHhb4/40RtRoslLvyyHSZTsrHYRwvvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctv7Zqw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctv7Zqw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5601F000FF;
	Tue,  6 Oct 2026 00:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245343;
	bh=PIQkp80iFt2iK/fBk10OIHZnMcOpabgulS/T3Sza77U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ctv7Zqw8rfycJ1k9MgCOGtMA5tBsKhZZBw0isFa42GlJ/4pXsHCFAwaEPcbeXwltp
	 SSncwtYGT/tdsQffnXxjStvaOhRcoTq0PzzblbHKvPc6Vftorza+mDxLJIfkNq6HQv
	 yzwvBlwGHcT0Ibci/oVALOydEDikgYQvmVoozkTZwdXQpqCrjYfcAuBZDwsG8+/pB5
	 Ibw8jQ7jDfQqw2yyVhdinM6fLt9++sFuwNbkmkv4kMTQBiXpv5WWCZZmeVx5No7cxY
	 bAzUbQ3xZWyNO0+rJ4f+Vrnh0Dlom4TCRdH6at9vCE7eRJw3pK1n+a6+9rlS72nXTn
	 btzL2pahqOFYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] serial: abort TIOCMIWAIT on hangup
Date: Mon,  5 Oct 2026 20:08:59 -0400
Message-ID: <20261006000850.3530203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100556-jimmy-pending-cc18@gregkh>
References: <2026100556-jimmy-pending-cc18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit eb35b73e133686e5b999eb7130c4e3d22fe03089 ]

Add the missing hangup check to the TIOCMIWAIT wait loop to avoid going
back to sleep (indefinitely) after being woken on hangup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org
Cc: stable@kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260910130816.642699-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261005214655.3401887-1-sashal@kernel.org>

 drivers/tty/serial/serial_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2bbccc376dc73..be0b01d7f427a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1251,6 +1251,11 @@ static int uart_wait_modem_status(struct tty_struct *tty, struct uart_state *sta
 			break;
 		}
 
+		if (tty_io_error(tty)) {
+			ret = -EIO;
+			break;
+		}
+
 		schedule();
 
 		/* see if a signal did it */
-- 
2.53.0

