Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35D40F74E;
	Mon, 27 Jul 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158363; cv=none; b=MCiOiMWoVfukFA8Lia6yK7+Wu9BB9ZwINMrqnRNxLfI9aTkqvyy9hfVcT5TFVsNaujYFxrlbQ/ot2BAsJAboepAltg5lPX4hCunIGbLoQzMHaHjRu1ZrCtJfX6n6l2UFnnB2l7Gm+huCuVYZD4ypG2ig4OqNKDyBjbpIqvzBeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158363; c=relaxed/simple;
	bh=Vqnoc/HG6KBIH/2BotzWGk/HYm00jme5eSftcFPtvgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfCbjaEuiWRbPjuOyOnH84NYPwb1W9ky1EHcPAq4hwdZ6iBGpwb3Ihh2fta/cWclU5vkUw7PtuaIGmyY3w3hv7+R6EOHzQZBOAnNp1k0IHfaUJw6aZ2miW2fp+35bDGQcaU/jkzTGJtCjg98hGjuZWzfhR/jx1IsMKr2lBLiJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rc0d0ICu; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rc0d0ICu; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rc0d0ICu";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rc0d0ICu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158353; bh=Vqnoc/HG6KBIH/2BotzWGk/HYm00jme5eSftcFPtvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rc0d0ICuHD6O0RHWxDcVns/tNRqiWKuYA/MiroEwz4Z5FbET1tzoPpXRsF9yhkN1p
	 D9kRQdj21+cjS3jvONDSq0PqDyS1l6JV6Zalc9I34I3MF8gvl+j+7pPlac0Z5xJ48t
	 5t2iti9oSz2LP7Hie9p26MYHSnAJRBipNp2PmAMuusiYhzuWz+yTR2AswpLaAllgbF
	 eYuTgGawAV0IXjc8YSoaJY+FuH/ss/v7xjsFFgVUzz1WgHuYtMQq5HlQ9RBjtSsGBp
	 2Q0sbyVkGtKj7i1pJqzaXTj78WmouFHtvRGTubIfo4bb4DVQSc55G+Df2PZP9MCQd+
	 PR+uudzDY5FiQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id CC11642536; Mon, 27 Jul 2026 14:19:13 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158353; bh=Vqnoc/HG6KBIH/2BotzWGk/HYm00jme5eSftcFPtvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rc0d0ICuHD6O0RHWxDcVns/tNRqiWKuYA/MiroEwz4Z5FbET1tzoPpXRsF9yhkN1p
	 D9kRQdj21+cjS3jvONDSq0PqDyS1l6JV6Zalc9I34I3MF8gvl+j+7pPlac0Z5xJ48t
	 5t2iti9oSz2LP7Hie9p26MYHSnAJRBipNp2PmAMuusiYhzuWz+yTR2AswpLaAllgbF
	 eYuTgGawAV0IXjc8YSoaJY+FuH/ss/v7xjsFFgVUzz1WgHuYtMQq5HlQ9RBjtSsGBp
	 2Q0sbyVkGtKj7i1pJqzaXTj78WmouFHtvRGTubIfo4bb4DVQSc55G+Df2PZP9MCQd+
	 PR+uudzDY5FiQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 1ACF64252E;
	Mon, 27 Jul 2026 14:19:13 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jarod Wilson <jarod@redhat.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/15] media: redrat3: Ensure we don't read beyond the end of the packet
Date: Mon, 27 Jul 2026 14:18:46 +0100
Message-ID: <013ba80c2327344bb2b2e1010e2db20eddb8e5c7.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length and offset is provided by the usb device, so it should be
validated.

Fixes: 2154be651b90 ("[media] redrat3: new rc-core IR transceiver device driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 2b639fe59923..f86efcb74e6e 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -358,8 +358,24 @@ static void redrat3_process_ir_data(struct redrat3_dev *rr3)
 
 	/* process each rr3 encoded byte into an int */
 	sig_size = be16_to_cpu(rr3->irdata.sig_size);
+
+	/*
+	 * Note we are not checking if we are reading beyond the end of the
+	 * packet which was sent, and reading stale data. If the device
+	 * sends a packet which is short then we get garbage IR, but no
+	 * out of bounds read.
+	 */
+	if (sig_size > RR3_MAX_SIG_SIZE) {
+		dev_err(dev, "length %u is incorrect\n", sig_size);
+		return;
+	}
+
 	for (i = 0; i < sig_size; i++) {
 		offset = rr3->irdata.sigdata[i];
+		if (offset >= RR3_DRIVER_MAXLENS) {
+			dev_err(dev, "offset %u is incorrect\n", offset);
+			return;
+		}
 		val = get_unaligned_be16(&rr3->irdata.lens[offset]);
 
 		/* we should always get pulse/space/pulse/space samples */
-- 
2.55.0

