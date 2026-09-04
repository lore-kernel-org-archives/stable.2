Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C72EA75E;
	Fri,  4 Sep 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527288; cv=none; b=s2pjaULIneWtutoFZH+uALEb7yv3PMftO7fXoon6KUFxi4IYGmL4vWpfzvHidTOxN0ZbdyeJOnicanVh/7NN4tHFHm2GxjEkT5BVw7I6r6vCEcAbfcuvJtK8zw405AnE4mOZF0syqEsOtqlz3TmtCMCFm7P7XYT5hrqpUYXpaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527288; c=relaxed/simple;
	bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f30tNCwEAhQRBoL0FsvSYGqxetN61FeVfts0kCIBJS64WuwwNByep0CKFDoUiCK96Z/A6fw0jp/K9FE66ZObdI4V5t4SKGnSj0Izdy298PlCgVGKVaTDjbe8qknfyxEkINEOslkhTpF8XAdKokteWabXEDIMAzpCf3R1qQiuVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=iFMb4Atm; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=eCRMP3Ra; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="iFMb4Atm";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="eCRMP3Ra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527279; bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFMb4AtmjWiODvScJVTvLAbIfKyJxLcEWCxcyWD7DuAuSZw/ES1S1LnVbciByd9ZZ
	 bB4T26vRy6uQ1DshWGHbyDdCjmefBMzfTwviUuoAQyytQMo2r/bUtLzG5TC2OypC3X
	 CGyiRPgqiR0Mf2LCodSiFXGE0VMsMGukD9P3zAm3SImDtEdBLjC5F1e2VxtyBDzwY0
	 NpJ6mhn051sWM/JzLEzQYyI/1pMIJUrQW7NVgbNmP6nu1b7JGlMI39J7oz5Ycag9Uw
	 FmGNLo5duvFrtTCa44dCe6cEPyyJTOAx+XLY8+JquoFNQee13r/euq8RsW19TI62Wd
	 BWcurDeXaq14Q==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 2576441445; Fri, 04 Sep 2026 14:07:59 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527277; bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCRMP3Ram+7e9ISNDbGfiDvsGMGbQHvo4fM8b4hHSCGj2A2ptK4x/kw1KZE+mFV6R
	 dyO3PxOgbPbzuv8irBC/jIApbMaasc3g7Y/W9OwyvgEzhCenSFxSAtmn9uaxSdSFwr
	 E20dAfEDXUY0RG6ykNFsR0lVZODTs6alteeyeQ39kk3RYl+ruRgev8I4N/MC/puhhz
	 bDmrCdAjiedwbIjEqbVV81E9WR2whyNlZYd++oP6lWxC8VRD5uWqpyROMYhHDWTStk
	 6vXcugD1lbpYg/c6behrtV9+/jQwIBXrCJhgB5HzmL5Ffl0PjUV4VNBGqJ+PeKOK9E
	 i8dT0FZiyzbdg==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 1CD1341445;
	Fri, 04 Sep 2026 14:07:57 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/17] media: rc: Ensure that rc_unregister_device() does not free input device
Date: Fri,  4 Sep 2026 14:07:30 +0100
Message-ID: <e2362642b58c459d1eb6d343fcb5d1f93e348adc.1788526920.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788526920.git.sean@mess.org>
References: <cover.1788526920.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During or after rc_unregister_device(), IR may still be reported which
results in a input event being reported. This could result in a null
pointer deref in rc_keydown() or a use-after-free of the input device if
the pointer was read before it is set to NULL.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 1f99540456f1..88d8f7d4aab3 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1753,7 +1753,7 @@ void rc_free_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
-	input_free_device(dev->input_dev);
+	input_put_device(dev->input_dev);
 
 	put_device(&dev->dev);
 
@@ -1865,6 +1865,8 @@ static int rc_setup_rx_device(struct rc_dev *dev)
 	if (rc)
 		return rc;
 
+	input_get_device(dev->input_dev);
+
 	/*
 	 * Default delay of 250ms is too short for some protocols, especially
 	 * since the timeout is currently set to 250ms. Increase it to 500ms,
@@ -1891,10 +1893,8 @@ static void rc_free_rx_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
-	if (dev->input_dev) {
+	if (dev->input_dev)
 		input_unregister_device(dev->input_dev);
-		dev->input_dev = NULL;
-	}
 
 	ir_free_table(&dev->rc_map);
 }
-- 
2.55.0

