Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592151;
	b=qc94Vn6h8hSHQH2Iidw42COlrn1j6z48yL2KITOG9r9tKput9+Ny7xaQjltLpkXFQfKQ
	 1Y1RwzdUVCh8xrqHp8QyqOPVCFtP6noT4OOc98OL0qEJ5y3K9qk/4dkC7+PlY3vcj8ESP
	 +FShLKmNv4q3gj/7B8xdAotHfgCgYGr30pJYpqcDbkh28j8SmKbwH4O05vaJKalp97kPS
	 +tDqmzjQPNDeLft/H0KzfQfaora10iacPTZEribjv0gykGfcBXTGwBwr+z8luVWZ+szwx
	 U+9ldK8RorKN9K1IMIcxcSbuDDvfExBvMEHIMy97e9+WgVs91rMgSpeNrm2XZQ3fdMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592151;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=STn/reUeroT2S0kL1cRx0++G+TaGCLq/vnG6pBGhH6s=;
	b=4s7Q6OPcMtKau1EaWvR4xFHF5sYw+B15/CZzrgfa3B2CbupFczQTMSWbrYCz9OJ73g9k
	 dR9ac/3Ir3ajrFldjhkib65MCoQB389K93FvnHHmkdNsPoJo8Chf94Yf8FNSm3mS8r/WB
	 NKeCFM54keIHNU/4AeWEDtQr6Q3MuWPsdLLY1w4aTKMw2ycQvGq/2lYAkryq0435LdXCT
	 /1auDpOz17OY/v7iyrWA3sSoi4m5diCoq+mohfvEVVdZDVk3B03MEQ0gmTC4FA03McCFR
	 bDX3BIQhxQz4WCvrutlJrwulhVHk4kcDPBWLHkQgS7qZKsxvtQieB/iqWAZblHwNrkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DewKlNqx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A4606A31D;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DewKlNqx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C81F000C8;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592150;
	bh=STn/reUeroT2S0kL1cRx0++G+TaGCLq/vnG6pBGhH6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DewKlNqxekCOT0m2HJE8/ttdyUguk3gxIx1t3SWw/jQEJelgZP3zsU9ojt9Sbe44K
	 KotH3Ad1EItUt277uh0BbtxtGHQ2IJYDKJVG2DtMhqYwdDx9WK0mV29wL7dr0Gbqsk
	 yLbqQ4bKh4K0rH4Jvq6Tw2EFxgf5BxnuftWkSeIlrCDsd4s62ri0O9TGJV7vAEgTGe
	 CKUQ0R9Hjtd+EypaaIr7HLszH8Xk9DOAhKG+DSkCFsCXjm4ZhimIJFxORWn//qeyDT
	 NFmO1EJts8bBTqhtbYiClHEFYcpPw+t+c1RHWi8k/D8C25qHuFHqKtHw64OHlGIgKY
	 yet+oNBGblgPw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xJX6Z-00000009kqD-2Nes;
	Wed, 21 Oct 2026 16:15:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/11] USB: serial: io_edgeport: fix potential close() use-after-free
Date: Wed, 21 Oct 2026 16:11:46 +0200
Message-ID: <20261021141154.2324793-4-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021141154.2324793-1-johan@kernel.org>
References: <20261021141154.2324793-1-johan@kernel.org>
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

Add the missing locking when updating the port status during close() to
prevent a racing interrupt completion handler from trying to submit more
data for the port while its write URB and FIFO are being deallocated.

This issue was flagged by Sashiko when reviewing a related fix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260714101316.823942-1-shpark061104%40gmail.com?part=1
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 0cc4f41299e0..a2410c063ffe 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1089,7 +1089,9 @@ static void edge_close(struct usb_serial_port *port)
 
 	/* port->close = true; */
 	edge_port->closePending = false;
+	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->open = false;
+	spin_unlock_irq(&edge_port->ep_lock);
 	edge_port->openPending = false;
 
 	usb_kill_urb(edge_port->write_urb);
-- 
2.55.0

