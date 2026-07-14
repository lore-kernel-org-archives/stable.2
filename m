Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE94D90CC
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047597; cv=none; b=uaVtzlsuJZl8BX7n4SRPPcq4wU/c8iGg0HUA8kTXQXC/0aQKEDvffQ5JLMQ99p7z4VWs5itarHNyc2NP90QksMr9HogdKbnoDM/Z8ZAGVhetdQlwhyy4rz3jpEfl8O0ztV17BzrSVVx4KNGYZrLGsSe2lCNE0PtWRanePw/GTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047597; c=relaxed/simple;
	bh=Frw282+aHQ3ZxDrx8czE2RBlkQDSjmruTH68jMfrBuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jrs4g+Q4Z7xaTDzpGusnaAJsl0zFqw9APAjTj7EJzcW9noZoU3Qy7pmNgIa6y1HeU3Rvnw2r2m12Gotqt9p+zFqXQ5kvMb5thw3LiG99cbHZrGF5yG1XZ4cBE/tHgPHd6XqvP57fy/QdEGySdq6hFxKqG0Cv8dFp75yKHXqtJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=gZJjtv9+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="gZJjtv9+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b779003fso19556935e9.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784047594; x=1784652394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPpnQyB5O61CilIt8FpW4+VW+Z5EVEM70y97AViA5k0=;
        b=gZJjtv9+zCN/TMoODAONigwPSGtmTgORTQPIlXR4OH3i1L/obinSsCdEsi1PveoLJ/
         xEUAsTMCOarpKmmIBpdGaj7YErRkE73YilWbQP1q0dp3UQPfsKaqVxDTe/LOT8cEw1P3
         Vr+AeBM1qsl9EiruBIdMyBnN/OoGVzAP3bHWMor5ymJQTjTy2kkZAGVANp/6OtdA3pua
         On6iXBXPYu++903kHSBEvOIxbrGUPguwZxzgOosdJkRFdhi4cTa2JattnPE/WE+47FJ1
         7TYfVlGFdI4cHUzazAH5R4PipMB7eFZXOCIJSz5GfpUS4YkH2U078HoeMsO4sXRzzzD+
         Co6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047594; x=1784652394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPpnQyB5O61CilIt8FpW4+VW+Z5EVEM70y97AViA5k0=;
        b=IKC1hxOKPXs1kBXrRAh3dLNTSZL6vFZPlwgPlYFhFwio/iFXXcmVW9jpBQvA8/e1Aq
         YCIOsxgsNyDGgZfHwNvyOapD+uSccmLqtrA4oKP31Yr2Ft2KjtNhT0qYNyrLASrdq4kJ
         wbZ4NHsXIqViJp7GT9y4SjFRKxsFgFxPY/zRs6E6F1hviClCcOzLlnoJF42eVTYO74Ky
         TEsh3IvZCEp9yr+BcPFgbxzjqDVZKNgaYPlgEt+27I25q3qb+OZndpgm9mGOxjpzjOYY
         +lGebH/ZaoxFUvkozF94y+3G3YAbMPm97cWDDrVJO8L+GHq2RZaWIPGGL9aWsEMRPGyC
         B1/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqoGZjc5Ey0PpttTz7R7/BBwtPKegu4oXz2WNYaCgs7WlDDRskEfcpttB3RtgjeHv6okA6iIRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Mg8KtQNJFZLxJNiMTExraJjO0LIUFEPt/O123eZm3b7lBO57
	rUeynVWtOz+8RjL9ZEB9TUkp83jiekB87He4r6qcCpF0Q5ALnYGhFiqS0v4KqojsShMt
X-Gm-Gg: AfdE7ckXiTCt6GTIzn8n200UKTnjaDaoeoO7PIlBMXSNsR3H2jrUURUJeU4r0DY/qHN
	CbiHuxV1S1+PolY6m+JQ+9LrT7ak0SbmjcFOrCPBLjjabkeBbVuG0oOIRZuHhbxT7Zl1FHXvMCB
	zlanvM0F7gYkuBeoP8DMJPN4FvuBBSpesl83ZgzJPYVt4WJ3wSSTqRnA2LCNiHV1oLHtyUKF0Rk
	RAlohes8xh5BUBUNh34ukP/pXgHGbFL5mrAR6fC2SCcCHPaxKJcs59NuoWjCvSHRjt4jolZOHBS
	xshprNkHfnsXSEBff3UTwWzWS+8xd+yGvDdWPAKSQRKgG5N9glkedo+f+NB27VJ2ptvUHZBOard
	GDEWoDm5WSzA2Cdh0zOJ6ODpV1PjzNy9OIzcT7ny3KBJGYmN0bQLFwhSnWZaJ3JO/b3TxQz+bWo
	xvUFG9rSnTHwC9SZEhI0t6rF0YXQHcUCjJ8E1Q0Oo7VcbH9S5IBKmxhzx0dMJu7J4jlTzF56L5/
	sP1q8As6qzTvYEy+Oi+yggYePQW+B/nNKs=
X-Received: by 2002:a05:600c:34d6:b0:492:58d6:2565 with SMTP id 5b1f17b1804b1-495389c5f8cmr36811105e9.25.1784047593529;
        Tue, 14 Jul 2026 09:46:33 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953b8d0f9dsm1989895e9.0.2026.07.14.09.46.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 09:46:33 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: vadim.fedorenko@linux.dev,
	horms@kernel.org,
	david.laight.linux@gmail.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] nfc: llcp: reject PDUs shorter than the LLCP header
Date: Tue, 14 Jul 2026 18:46:31 +0200
Message-ID: <20260714164631.75068-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every LLCP PDU begins with a two-byte header (DSAP/SSAP + PTYPE), but the
receive path never checked that a frame is at least LLCP_HEADER_SIZE bytes
before parsing it.

nfc_llcp_rx_skb() reads the header via nfc_llcp_ptype()/nfc_llcp_dsap()/
nfc_llcp_ssap(), which dereference pdu->data[0] and pdu->data[1], and a
CONNECT or CC PDU then computes

	tlv_array_len = skb->len - LLCP_HEADER_SIZE;

as a size_t and hands it to the TLV walk. When the frame is shorter than
the header the subtraction wraps to a huge value and the walk runs far
past the buffer, an out-of-bounds read.

A nearby NFC device can reach this without authentication; LLCP link
activation happens automatically after NFC-DEP.

Guard the common receive choke point __nfc_llcp_recv(), shared by both the
target (nfc_llcp_data_received()) and initiator (nfc_llcp_recv()) paths, so
a short skb is dropped before the rx_work worker parses it. Use
pskb_may_pull() rather than a skb->len test so the two header bytes are
guaranteed to sit in the skb linear area even for a non-linear skb,
matching how the sibling NCI and HCI receive paths validate their headers.

Reproduced with a KFENCE out-of-bounds read via /dev/virtual_nci on
linux-next.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3: use pskb_may_pull() so the guard also covers non-linear skbs and
    guarantees the header bytes are in the linear area (David Laight).
v2: move the guard into __nfc_llcp_recv() so both the target and
    initiator receive paths are covered by a single check.

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..e3b2627cb089 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1565,6 +1565,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
 
 static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
+	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	local->rx_pending = skb;
 	timer_delete(&local->link_timer);
 	schedule_work(&local->rx_work);
-- 
2.43.0
