Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3250412280;
	Mon, 27 Jul 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158364; cv=none; b=brjW1vcv8b/MntBI2Eq88UNusPHogWU/lVy81bnGJQG+jhM3Ksjwrb9wBOSSeTHUX8RUCowjUAEznoPfyHJ8TEJrCZvqwCDNDr43fGbdrhX7y4raL/5qz2Zjk8kyW3l9OXXrKrpMxL9P6jSP3viy1Nfi7Q259IN9lY/yt96ChmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158364; c=relaxed/simple;
	bh=a/IWBX5/KSTomr9EEUQNAH8GIN43cL9GoYjV+aAE3XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw7cJptZqcATrTiIsKjiNguL6bkEGCj9DEQjM9dgc3XU9xHy4ImOnJkGXZH0GVXyvYxkqRJpLW5iEBCNG7ZZ8qvXkCnB4ebqDxGuhsUSOIyT6jbmObLKqSxdPvIAep3tCxD1l75mfs7BNSKGJBPbhxw+QxJfdmaPQC5o2zH6ykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=NkucxRId; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=NkucxRId; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="NkucxRId";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="NkucxRId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158354; bh=a/IWBX5/KSTomr9EEUQNAH8GIN43cL9GoYjV+aAE3XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkucxRIdZAHCFVmoqL+u6ip0xymEwbNB7FwGY7o/TTJ1tIibJ4iTOZsO5bKWZP1ci
	 vABD67mDew+gPfxQ42nZ9bziWWTlwRj63ngxYW7roVpnt2fYKmzPr/e9CjchnEOcRv
	 Or4cRLnpMzNU/zbBazDiohM+k6eBXbVvxVdtvV37cf0Of23LuLBOgGllsENG4hkHVZ
	 jva0xwfYgM9nGvgFmYyh5yKpNn6BN3zBzADOpSCgYpHJxX0fiZkFvmY0ywaBTvWz5w
	 fBgPqDHuPy5b5uIC5NI4ubQWLf78U7Ih4redAAfOkOumoSY01rPj/PMaf3oI4+1M4C
	 4QQV5yWnLnkOg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id D11004253C; Mon, 27 Jul 2026 14:19:14 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158354; bh=a/IWBX5/KSTomr9EEUQNAH8GIN43cL9GoYjV+aAE3XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkucxRIdZAHCFVmoqL+u6ip0xymEwbNB7FwGY7o/TTJ1tIibJ4iTOZsO5bKWZP1ci
	 vABD67mDew+gPfxQ42nZ9bziWWTlwRj63ngxYW7roVpnt2fYKmzPr/e9CjchnEOcRv
	 Or4cRLnpMzNU/zbBazDiohM+k6eBXbVvxVdtvV37cf0Of23LuLBOgGllsENG4hkHVZ
	 jva0xwfYgM9nGvgFmYyh5yKpNn6BN3zBzADOpSCgYpHJxX0fiZkFvmY0ywaBTvWz5w
	 fBgPqDHuPy5b5uIC5NI4ubQWLf78U7Ih4redAAfOkOumoSY01rPj/PMaf3oI4+1M4C
	 4QQV5yWnLnkOg==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 3319C4017A;
	Mon, 27 Jul 2026 14:19:14 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/15] media: redrat3: Error path leaves device in transmitting state
Date: Mon, 27 Jul 2026 14:18:48 +0100
Message-ID: <d22b8dac679cc4b4713dd03875576d71305e3912.1785158244.git.sean@mess.org>
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

If the allocation fails, transmitting is left as true and the transmitter
cannot be used any more.

Fixes: fac59136bc22 ("[media] RedRat3: Return directly after a failed kcalloc() in redrat3_transmit_ir()")"
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 994d4864520c..bc75f68ca535 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -781,9 +781,6 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 	if (count > RR3_MAX_SIG_SIZE - RR3_TX_TRAILER_LEN)
 		return -EINVAL;
 
-	/* rr3 will disable rc detector on transmit */
-	rr3->transmitting = true;
-
 	sample_lens = kzalloc_objs(*sample_lens, RR3_DRIVER_MAXLENS);
 	if (!sample_lens)
 		return -ENOMEM;
@@ -794,6 +791,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 		goto out;
 	}
 
+	/* rr3 will disable rc detector on transmit */
+	rr3->transmitting = true;
+
 	for (i = 0; i < count; i++) {
 		cur_sample_len = redrat3_us_to_len(txbuf[i]);
 		if (cur_sample_len > 0xffff) {
-- 
2.55.0

