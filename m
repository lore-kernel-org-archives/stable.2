Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D52E8B98
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783753988; cv=none; b=VMCWceVEnQaGH3nfOE1tpMcnxmnJIBAXgCkZCc6foRpdVs5ArW3FtblJ1irTvSOxOuAKDKVpYsLNKjpfnqyBjm2/sBSVm9/jTAi3c4Pz2J3l7dF9Lg5kcrqj/R7yMSpacpykOYnlPNeuTneqpXMgTTk3FQN6D6eGgkUaXWYSxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783753988; c=relaxed/simple;
	bh=tteEXFBN4+2wOzmiU/i/Ti+DuESNyUk6Z2sZdVGq9Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+WSMgFwxVJzuGX/ZrH5yyP4cqXkfEIX43tHwwVS8AboyfXBsjUPg0sUskK9DRUQcJ3MR/aIdZs0iFxHYWPW2TvW4iE2fo6oS4q1fxuuo7Lnn8rUkrK0k0nqRsyeEqa0ciKshOE38ziXfWQJdUDlB58HtfB3uNk/VzcgB43lxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=TXgXK4St; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="TXgXK4St"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so6154665e9.3
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783753985; x=1784358785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQOzeXV8phwSUt0xHK7ZAorIIAoHjVqQrsau28MhLzE=;
        b=TXgXK4StoK/5ZxxboEGyrVKWH8OZoZ32y9ZnT+G8Ga+dQGcEI6OHqCK1sn3ZC4c0f/
         GRsS24NcO+qG3vNu0D0X2UxqCpKddKiMMy5UJ6M/nW6RIHs7CvA+X6qI4gQQF5tnuUfi
         PSkuYUA1S7TnNbO7S/21ydAWi1rBnBNPLoj+jUg2wBkCLz5ryIEuG75JNNLHd62VRtVL
         FqpViNbc/O37ZUD6zyCMFLykqDAqeVyKXKJjSxSAU3YzSZiqNhdXt21Ar1SmL8g/FXVV
         x/NCDvj0IozNX7d8hpkMkseZC4mQJuQ620pIP6u0mzWcfBlo84pSEby3/LdWVtlP6mZu
         Gwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783753985; x=1784358785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQOzeXV8phwSUt0xHK7ZAorIIAoHjVqQrsau28MhLzE=;
        b=leq/Au1Q+jX4j0y/Vf6WR3KpM6Pkfg9C08pNnXyAA0X0unargvnkjSyIcW0q2NT/UF
         f/ZVH5spz8pm04lb9XAtOovi59pejnkw27k1Hun4OeWDILlJBcOXJQq1ePOZ/T83fCo9
         LU7ctHcfixZFsc8zrH2N962wfpJBFJK94TbGrneHwxKJ4bojop4mIUBhXyJrWNfpUF4n
         OT1WufZpQPNMUJziqkiEj4EkUaMmhsJDYObLqMB2fXjb1pwnihSaq0z+Ib/VKqjX4poZ
         MVRDoxctmps2WfSL7SHyo2C8VVx5pgimiPOrVtBXKqrFo00NLX93rdEYMCExvWINhjoY
         KXRA==
X-Forwarded-Encrypted: i=1; AHgh+RobajvETsjdaQLXYfpGeiUvz91yPnnPiey85To5irbm05jSQXJll82h4lD/y0LG0ZsmxYZ29YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwBQSNxxltA6min/gBp5xT0e4gl+3kR9QHnBD3axKh0J0/bEF
	rPLSLPXindo/x/v+DdhaYu8Evsq/On5l0wy8eY9jg4V23ZhB0F+TbRy14gG6//daEM1r
X-Gm-Gg: AfdE7cmfJ/9a/x5e4d9sdzfQLooC6TzYGg+j238P2lFevVKcElE1FFS4njoJrPyDVam
	F472xItbbRkUwa7TQ+xpx82GI2Bia2X/v7XFvkTMfBoIqN1g5S6gWOOIA1s/LZWt47JC6nV3+5F
	vHwmwVmI+aedTmm9LgEqH8xJFxGNePaUEqaNFaamK6P89/uvMhraJmOf36w7lusv6LwXGtmUX9K
	+2/NVIBhjjnr97U/v0TH19imTwib2c7jRyyF7B4+LaxMvYd0NX42+Z/1eLOF0h1C+vXcb90hSaY
	nzyVFeu2u7avLSieOstpfXHF27/IGHoE5rCI066n8j9HN3zPBQe7rvjw5vgyuGXWe8p1TfNAaaB
	wA+OhBN2+tH/pCbJo/vv7tAtnXFpWsKZk1oYkmLMMGnfljl+W3dXtf/NkTL7QTZKBXA966ciI1+
	jptINAEDMqInSWRSOSvDszxcG9PKB3sDsa+hw4KHvTPWYPWv2mYpHT2Ml0mB7pgawmiPoE8gLUG
	wWIXuWeoy62vagmNrX3fhBOnqKH9y27JPk=
X-Received: by 2002:a05:600c:4f8a:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-493f87e9bd4mr15077835e9.9.1783753985154;
        Sat, 11 Jul 2026 00:13:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm87910115e9.2.2026.07.11.00.13.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:13:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: st21nfca: validate ATR_REQ length against the received frame
Date: Sat, 11 Jul 2026 09:13:01 +0200
Message-ID: <20260711071301.58071-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

st21nfca_tm_recv_atr_req() checks that the received ATR_REQ frame is at
least ST21NFCA_ATR_REQ_MIN_SIZE and that the self-declared atr_req->length
is at least sizeof(struct st21nfca_atr_req), but never checks that
atr_req->length does not exceed the actual received length (skb->len).

st21nfca_tm_send_atr_res() then trusts the declared length:

	gb_len = atr_req->length - sizeof(struct st21nfca_atr_req);
	...
	memcpy(atr_res->gbi, atr_req->gbi, gb_len);

so an RF peer that sends a short frame but sets atr_req->length larger
than the frame makes gb_len exceed the general bytes actually present,
and the memcpy reads out of bounds past the received skb. Those bytes are
placed in the ATR_RES and sent back to the peer (kernel-memory disclosure
to a proximity attacker); a larger declared length is an out-of-bounds
read (DoS).

Reject frames whose declared length exceeds the received length. The
adjacent nfc_tm_activated() path in the same function already derives its
general-bytes length from skb->len rather than the declared field.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: 1892bf844ea0 ("NFC: st21nfca: Adding P2P support to st21nfca in Initiator & Target mode")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/st21nfca/dep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index 3425b68f0ddc..a5fab4fd5129 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -205,6 +205,9 @@ static int st21nfca_tm_recv_atr_req(struct nfc_hci_dev *hdev,
 	if (atr_req->length < sizeof(struct st21nfca_atr_req))
 		return -EPROTO;
 
+	if (atr_req->length > skb->len)
+		return -EPROTO;
+
 	r = st21nfca_tm_send_atr_res(hdev, atr_req);
 	if (r)
 		return r;
-- 
2.43.0

