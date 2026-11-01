Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566026;
	b=AhaIXT6CrMOaeTRVj+ocBDpXnsx8fWkuj/33fiyL3NtqgqDXY+5Hp+4Blm2ga32GEZND
	 p4Q1VzS25gAHz1YY+0YbHQrDD0GnvN2quWTH1/8nyV4+6GYKknDy6iEVicAlPFjh9aAaz
	 l2uy3oh/hfc9yrso60efQ/hzG4y0GHx4uM9KZ2iHuIvOTrDWzeKi40wFpcXWlMZSRKv0f
	 R6HEZsQGFFMRCK5evlJCtd1A5Cw2XKsr8dTuRYmCcwhyZnMXodZhe6j6Id43xOk2bpVaP
	 jpdATC3XMG/AoZxiEKmhoqO398I0hTsPMnUJw0t7nItwuD9MH6C16RwjdF3vLLvLXQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yMQqpQDiKs7uaSI9ZXZcOp+ka5/Pebym49yFSbFp92E=;
	b=H5MCKSFNrW6I/xzGxGiLKsJSBp+EG7c3NyBHt0P25jWhJcs7FZD3q9KtZQtKLAmqFoXm
	 RvT80ecsGx+wGkItKjKeW+qJ/+uZyi4huprgGpGcyHDHaqH17ViHXVeEpiKbiD+qO9rI7
	 TIfiIDDl3hu3dEgMr4tdA9IDnXZXCZLGniZBunu2koQtbayYf5ndNgkOWr3f5lFcP0k1j
	 kZLjLEJTF9IryKnzXb1BWuqbVmY6/28jIEwIQAliiXctQLz+TfEpSns3Gi9nKGfKklmHW
	 y7n8tYbpHbPTcbUqh6SMiRxpfFT04vtQ/NW/gX94916iuY8HefWsynbWHs3ge1EdYsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyn0UUmd;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C6606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyn0UUmd
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso19714165e9.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793566024; x=1794170824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yMQqpQDiKs7uaSI9ZXZcOp+ka5/Pebym49yFSbFp92E=;
        b=uyn0UUmd5DmTqweYOWwmfRBB0vRnW70olD9vJcqDzlnJTA249rwTfz/QFwR2LfGn7i
         bGOcm598ZA2CGvFEN9blfPNhyPxFjJUkeZ+VfJoMYN5Bzs+Mj9LXkNTl8UxO1IXJM7li
         +1Ar7bsHi1sEbuEwSsSxOQbppKDH9+sijB0qrvJqyv+tpLX3w32b+skck3/SfimPT0y7
         EsaGNeyvhvRbzp87efA4rn9AgJHAdmuuj/p892FBOxJI4vYna94GFVFkefkYhzKM8Co+
         vypw+RAOmaF8sBMi9cyLbPCd3NwJ3Yhp/H+pL0WPuyDRB7tJxlETRRzo60kQygt0UgNM
         0oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793566024; x=1794170824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yMQqpQDiKs7uaSI9ZXZcOp+ka5/Pebym49yFSbFp92E=;
        b=hzQbL0T/7W5ysyv2nAyk8DUCY/8/3vFEZ8aaBX/PH02L7dAYQoLNSRejRqlwag/F7O
         7B5jb+c3F4D7hk6pVrQ1XCp/+8QdB9uS1tHO/RBw8wTglLNigxvcnAWh65VeMSll7u2h
         fsoCAMUa2Z30208Q5n9iOsqbVEDqajteq7flvz6t58x1il+4DJCK1gbThvEhB0N/cHnS
         NEPZjTLOQTAMdTCQyzk92WnLN6KUtD2rsk7Zj9vC1vY06lnsjgXidOr+vxNF922bZfcC
         NFvlL0hyduRuxDPfoz0B1Sr6XgHE8wDCixESpinH/p/uTNgjWnqy9mhuQYdEaZ9kDjgq
         y1vA==
X-Forwarded-Encrypted: i=1; AKwUvBzqNm52UEenyUmZFy8hhcmSahL5DRwTkY1uto39fWLjidf2Q1/G5jW0jwiUCVJaf+25RC3fUGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJI5Ug1pZ4DUsPG7IkYF4S1QZ1UjELXSYaihkgiHzaovWJhdyS8
	2JtDPEj6AjR3YqrmD37wx1Uc93D38oumYkkMm2JC6/f6cPM9XKXtQR4=
X-Gm-Gg: AYBFou1n2c89SVeyQp86Pub/zjedfk+nTxCebsE+Y4tRK5UpmQJuyOrl39/cuoyomm7
	Lr3+d/dUPGVRHKp3esMjCiCsqPuUD02/OLGo6Q+ZI4k5u0rhEqNL2xMpGhYL8lmt8NoB69+dVdn
	fWCtoU8JbUzFIsqrB6g+xMSUUKqI2Rfq1sArC5M0Smd/JT7m4PwN2u6ZLIwXAiBl5B82pFP8pni
	yf8MDXVutx+gtL1z3hzN5laUE/ZtRI41RGivI8ml1Zn07nRK/O1+v9qjl1KriHKy9IQuIc6Gs+/
	U4dqX6wcSfaQFEOQOVBTA79QQteTlD6l5FWEfTyIs7Dqs1PLmfUrWPthckXGkvkUZ9d9Q18cmGf
	W5emUZ/Va3flV5lblEv4esbx1jIL5s8UvnVZe9pg4hetQK7SGdMoXcfNQP3+GcdZhecmB53y4O7
	aY0Rtti/taGZ/zTZmLmrj8iWKPLXgGszLTYESUHtyJG61i8zacqROROzFlGR8JWeNJhziT1ZnFA
	Fk+wURt1BlNu/YoL5roO3F+8/wpfpY/1t+1blKXfIhR1Bx81F3YUpW20xrJRC1LC3PuF6nM/8Sz
	Tdt6Esv0UIkbjVcQqMrA197jK8UGsd51
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr195820425e9.32.1793566024206;
        Sun, 01 Nov 2026 12:47:04 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm205314035e9.0.2026.11.01.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:47:02 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] Bluetooth: hci_bcm4377: validate completion ring entry data length
Date: Sun,  1 Nov 2026 20:47:01 +0000
Message-ID: <20261101204701.2851941-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

The data_len field is read from a firmware-supplied completion ring
entry and passed to bcm4377_handle_event() as the payload length for
memcpy into a newly allocated skb. When the PAYLOAD_MAPPED flag is
not set, the payload comes from inline ring memory of payload_size
bytes, but data_len is not checked against this limit.

Add a bounds check for data_len before processing the entry.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/hci_bcm4377.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 66d49b4715440a..5d6bda4a04114f 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377_data *bcm4377,
 	msg_id = le16_to_cpu(entry->msg_id);
 	transfer_ring = le16_to_cpu(entry->ring_id);
 
+	if (data_len > ring->payload_size) {
+		dev_warn(&bcm4377->pdev->dev,
+			 "completion event data len %zu exceeds payload size %u for ring %d\n",
+			 data_len, ring->payload_size, ring->ring_id);
+		return;
+	}
+
 	if ((ring->transfer_rings & BIT(transfer_ring)) == 0) {
 		dev_warn(
 			&bcm4377->pdev->dev,
-- 
2.47.3

