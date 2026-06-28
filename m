Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAE26B742
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664267; cv=none; b=X927ya9ni6Eu0yVGXkrwykURhVUvRvhi/kOMqEzD7JRIjoUcqFdhvS2XInLWxjRBKuwWeBqyFylPTEtY97YQ3JT7JqAYpxUr17sxBz4j0v7SdoRFuiSIBA19wt088xUEHo2YgAo/vJwpWr/pZEW9BX3ug7NMnHo23jouqwfDzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664267; c=relaxed/simple;
	bh=pwNe+XoOzjXv09t/4Ep12hexyuF5uQcuJZEVEzLOuZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4AIKXtcm+xBshlEu6krvKm7e0FwFrZ3R92/9htVLutgXI0Erm/Jyfa+QX2sY4DAhAqGaAL37TalloSueQWwmoOUgE9QjYGtGg1yb4wF/dphrxRRU5meTNMlFMWc/PCXqM1ARUrlC0LhrDma6wkPUp7rN40WsOxi5fxqYdMjW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMXpZFuk; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMXpZFuk"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6626b5ace23so1810509d50.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664263; x=1783269063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuM5aqUk7y4LethrziGqS6AGoxMIRZ2CRfrmTBywl70=;
        b=AMXpZFukW3S6ATZL5HzARMJJ/inn9nft3qulpQMuQ/RshuaA8HY0m3iRbreQGiIs63
         /AXMO+tIrCREAgsFwKUP1lfW0BruEH2WaenUvyQxgWz7XPyPTNh/oxS/VC3okksQ6lfR
         rNADs1GZzDmOWLAjS+I58goIf2QC8DOKhg6gzVautn7vCYpMEK5R7oMkKWzEumK2csiM
         kq6rlrYUFrlFoHuEjxupVA3TEZ26jjqpOFvV3SB1MgCa42VNLqQjQzBjpkJ86LXdmM0L
         8eKsKItniDwwImgx4JhNt3vbdcIc/4x+gLybwMMwxuEFRTU1f1a65SlrXIQl/QXoGvNt
         Mqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664263; x=1783269063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuM5aqUk7y4LethrziGqS6AGoxMIRZ2CRfrmTBywl70=;
        b=sMU76VzkOT5EXdzzkSkHGS61pVOcU805BCyVuKDiy3W9CtEWp/wKBtC8igfY0a56xd
         WFqqSx7lkXUK7Yme3HCxfBiuq7n/mAtbJlHVCGZVp8jyvGcWzhA4q4+aGhEpnhJXDaky
         Jk6I4BaW79Mf/qRj9XdaJqOM2nyVdxmoCo4kPbGONXJFAfBWzAf5BlJwZ/SFGz/BF+k3
         5Hc2iLJ7/uvtOg8c1f/wvjvPPBqDvh2RmHcq+tm0LuWlTlTkqXfiJz2qjIE/Kai8VCGx
         1qiN4RbrD7KCFJMTG5B/Jaqa8IdK774AQNJ23YlEJE5pwpnQN3ZRq5N5ZbL1lnFLWfP9
         YQ5g==
X-Forwarded-Encrypted: i=1; AHgh+RqSYROcVC/yRIpPDSMbrvlElzvrzQRIPES7EcEis+zQvB+QhqL9LHkcygRPOEbwkqiBQlz1Ha8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UC5TGtrBMMiUI+6eEKWA5opDsS445MSlerxESLMiWTGppWlN
	k3tNBU8jpsc068po8RJtrg0BIUQP/nQ4eRTxCJiaaN8RC7pt8w+qs35C
X-Gm-Gg: AfdE7cnZ9SkJ3OMIY1Xr7w1huN7+C1DYr6cfG6qoVTM6fv6bbMVlrCWm8O3/7a8igpK
	Lnqo6yHNB6UOI2iiA57bGI9iTy5t14VUOD8Uh+FtwawMCNTui1cAnJUzcXyBo53Mx2/7RNkYz2K
	BFclI26RNHZzdgqZI5qDgMOHNcycqpHAgUv6lY0v0P18D5/NyJdURdYMf/z6rtvMgV2X6tmUccJ
	BSqmeLtx3S0au7tsCLAf/tNdNuC6psz7vZmQ/jXsi6oJHpgHuaNtMp7jtQYhgP/li5hQEJqdKPw
	jZhOvV3nKYOTA/L0gj+2Q0eNReJwvCbeNywDYo58HlLQflFH4Oawl70iNQr+wC8v5RuvUE3G7Cx
	f8VP9yHgOpGeXQnnHJ92RdTBmtcsoSN4WZh1D0uu4AAWZdsEciA3hzPfmpTm01FXZtH8KPNezzv
	Gz2BoRQOpDksw07cpJqtAyTcJUwWHM+zZUGUm7
X-Received: by 2002:a05:690e:128b:b0:664:c444:39b1 with SMTP id 956f58d0204a3-664c4443d37mr3345018d50.39.1782664263434;
        Sun, 28 Jun 2026 09:31:03 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-664cbe0a2basm1164814d50.7.2026.06.28.09.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:31:03 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: mcp2200: reject short read-all responses
Date: Sun, 28 Jun 2026 18:30:35 +0200
Message-ID: <20260628163035.12212-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp2200_raw_event() casts every READ_ALL response to the full 16-byte
response structure and reads fields through byte 10 without checking the
received report size. A malformed USB device can therefore trigger
out-of-bounds reads from the input buffer.

Complete the pending command with -EMSGSIZE when the response is short.

Fixes: 740329d7120f ("HID: mcp2200: added driver for GPIOs of MCP2200")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-mcp2200.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
index dafdd5b4a079..d49f3aa44448 100644
--- a/drivers/hid/hid-mcp2200.c
+++ b/drivers/hid/hid-mcp2200.c
@@ -302,6 +302,10 @@ static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report *report,
 	switch (data[0]) {
 	case READ_ALL:
 		all_resp = (struct mcp_read_all_resp *) data;
+		if (size < sizeof(*all_resp)) {
+			mcp->status = -EMSGSIZE;
+			break;
+		}
 		mcp->status = 0;
 		mcp->gpio_inval = all_resp->io_port_val_bmap;
 		mcp->baud_h = all_resp->baud_h;
-- 
2.54.0

